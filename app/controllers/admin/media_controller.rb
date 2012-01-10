class Admin::MediaController < Admin::BaseController
  before_filter :ensure_todays_media_folder, :only => :create
  protect_from_forgery :except => :create

  @output_folder_prefix = "#{Rails.root}/public"

  def index
    @media = Media.find(:all)

    respond_to do |format|
      format.html { render "index" }
      format.json { render :json => @media }
    end
  end

  def new
  end

  def library_embedded
    render "admin/media/embedded/library", :layout => false
  end

  def create
    upload = params[:file]

    name = format_title params[:name]

    @output_file = server_media_path upload.original_filename, name

    write_file @output_file, upload.read

    params[:path] = "http://#{request.host_with_port}#{@output_file}"
    params[:title] = name

    respond_to do |format|
      @media = Media.new params
      if @media.save
        format.html { redirect_to :action => "index" }
      else
        flash[:error] = "Media could not be added!"
        format.html { render "new" }
      end
    end
  end

  protected
  def format_title(title)
    title.gsub(/&.{1,4};/i,'-').gsub(/[^a-z0-9]+/i, '-') if title
  end

  def write_file(file_path, contents)
    File.open( "#{@output_folder_prefix}#{file_path}", 'wb+' ) do |file|
      file << contents
    end
  end

  def ensure_todays_media_folder
    now = Time.now

    folder = "#{@output_folder_prefix}#{todays_folder}"

    dir = File.dirname(todays_folder)

    FileUtils.mkdir_p( todays_folder ) unless Dir.exist? todays_folder
  end

  def todays_folder
    now = Time.now.strftime('%Y/%m')
    if( defined? MEDIA_FOLDER )
      "/#{MEDIA_FOLDER}/#{now}"
    else
      "/media/#{now}"
    end
  end

  def server_media_path(file, name)
    ext = File.extname(file)[1..-1]

    "#{todays_folder}/#{name}.#{ext}"
  end
end
