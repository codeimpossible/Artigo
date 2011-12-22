class Admin::MediaController < Admin::BaseController
  before_filter :ensure_todays_media_folder, :only => :create

  def index
    
  end

  def new
  end

  def create
    upload = params[:media]

    name = format_title params[:title] 

    server_path = server_media_path upload.original_filename, name

    write_file server_path, File.read(upload.local_path)

    params[:path] = server_path

    respond_to do |format|
      media = Media.new params
      if media.save
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
    File.new(file_path, 'w') unless File.exist? file_path
    File.open( file_path, 'w' ) do |file|
      file.write( contents )
    end
  end

  def ensure_todays_media_folder
    now = Time.now

    dir = File.dirname(todays_folder)

    FileUtils.mkdir_p( todays_folder ) unless Dir.exist? todays_folder
  end

  def todays_folder
    now = Time.now.strftime('%Y/%m')
    "#{Rails.root}/public/media/#{now}"
  end

  def server_media_path(file, name)
    ext = File.extname(file)[1..-1]

    "#{todays_folder}/#{name}.#{ext}"
  end
end
