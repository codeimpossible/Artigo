require File.expand_path('../blog_post_importer', __FILE__)

require 'rexml/document'

BlogPostImporter :wordpress do 
  def import(content, import_types = :all, date_type = :original)
    doc = REXML::Document.new(content)
    added = 0
    ignored = 0
    # loop through each post
    s = Time.now
    doc.elements.each('//item') do |ele|
      if ele.get_text("wp:post_type") == "post" || ele.get_text("wp:post_type") == "draft" # we only do posts
        draft = ele.get_text("wp:status") == "draft"
        
        should_save = (import_types == :all) || (import_types == :published && !draft) || (import_types == :draft && draft)

        if should_save
          make_post ele, date_type == :original
          added += 1
        else
          ignored += 1
        end
      end
    end
    bench = Time.now - s
    "#{added} posts were added to your blog, #{ignored} posts were skipped. It took #{bench} seconds."
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