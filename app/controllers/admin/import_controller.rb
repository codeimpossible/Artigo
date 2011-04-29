require 'rexml/document'

class Admin::ImportController < ApplicationController
  before_filter :login_required
  
  def index
  end
  
  def import
    upload = params[:export_file]
    content = upload.is_a?(StringIO) ? upload.read : File.read(upload.local_path)
    
    if params[:import_type] == "wp"
      @result = wp_import content, params[:post_type].downcase, params[:post_date].downcase
    end
    
    flash[:notice] = @result
    
    redirect_to :action => "index"
  end
  
  
  private 
  def wp_import(content, pub_draft, date_type)
    doc = REXML::Document.new(content)
    added = 0
    ignored = 0
    # loop through each post
    s = Time.now
    doc.elements.each('//item') do |ele|
      if ele.get_text("wp:post_type") == "post" # we only do posts
        draft = ele.get_text("wp:status") == "draft"
        
        should_save = (pub_draft == "all") || (pub_draft == "published" and !draft) || (pub_draft == "draft" and draft)
        
        if should_save
          make_post ele, date_type == "original"
          added += 1
        else
          ignored += 1
        end
      end
    end
    time = Time.now - s
    @result = "#{added} posts were added to your blog, #{ignored} posts were skipped. It took #{time} seconds."
  end
  
  def make_post(ele, use_original_date)
    @original_date = Date.parse(ele.get_text("wp:post_date").to_s)
    
    post = Post.new :title => ele.get_text("title").to_s, 
                    :summary => ele.get_text("excerpt:encoded").to_s,
                    :body => ele.get_text("content:encoded").to_s
                    
    post.created_at = @original_date if use_original_date
    
    post.save
  end
end
