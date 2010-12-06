class HomeController < ApplicationController
  def wall
  end

  def info
    @info = YAML.load_file("#{RAILS_ROOT}/config/info.yml")
    @files = AppFile.all
  end

  def info_save
    File.open("#{RAILS_ROOT}/config/info.yml", 'w') do |file|
      YAML::dump(params[:info], file)
    end
    redirect_to :back
  end

  def jobs
    @jobs = Job.all
  end

  def admin

    @info = YAML.load_file("#{RAILS_ROOT}/config/info.yml")
    @files = AppFile.all
  end

  def file_save
    respond_to do |format|
      format.js do
        responds_to_parent do
          render :update do |page|
            file = AppFile.new(params[:file])
            if file.save
              page.insert_html :bottom, 'list_files', :partial => "files.html", :locals => { :file => file }
            else
              page.alert("File is to large")
            end
          end
        end
      end
    end
  end

  def file_remove
    render :update do |page|
      file = AppFile.find(params[:id])
      if file.destroy
        page.replace 'file_'+file.id.to_s, ''
      else
        page.alert("File is to large")
      end
    end
  end

  def file_send
    file = AppFile.find(params[:id])
    send_data(file.image_data,:type => file.content_type, :filename => file.filename)
  end

end
