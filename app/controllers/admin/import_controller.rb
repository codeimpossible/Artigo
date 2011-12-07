class Admin::ImportController < Admin::BaseController
  def new
  end
  
  def create
    upload = params[:export_file]
    content = upload.is_a?(StringIO) ? upload.read : File.read(upload.local_path)
    
    importer_type = params[:import_type].parameterize.underscore.to_sym
    post_type     = params[:post_type].parameterize.underscore.to_sym
    date_type     = params[:post_date].parameterize.underscore.to_sym

    importer      = BlogPostImporter.create importer_type

    @result       = importer.import content, post_type, date_type
        
    flash[:notice] = @result
    
    redirect_to admin_path
  end
end