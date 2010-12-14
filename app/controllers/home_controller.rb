class HomeController < ApplicationController
  def info
    @info = YAML.load_file("#{RAILS_ROOT}/config/info.yml")
    @files = AppFile.all
  end

  def save_info
    File.open("#{RAILS_ROOT}/config/info.yml", 'w') do |file|
      YAML::dump(params[:info], file)
    end
    redirect_to :back
  end

  def admin
    @info = YAML.load_file("#{RAILS_ROOT}/config/info.yml")
    @files = AppFile.all
    @jobs = Job.all
  end

  def save_file
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

  def remove_file
    render :update do |page|
      file = AppFile.find(params[:id])
      if file.destroy
        page.replace 'file_'+file.id.to_s, ''
      else
        page.alert("File is to large")
      end
    end
  end

  def send_file
    file = AppFile.find(params[:id])
    send_data(file.image_data,:type => file.content_type, :filename => file.filename)
  end

  def post_message
    prepare_token
    response = @access_token.post('/API/wall_message_from_app', "user_id=#{session[:fellownation_user_id]}&app_key=#{FKEY}&message=#{params[:message]}")
    render :update do |page|
      case response
      when Net::HTTPSuccess
        page.alert "PM sent !"
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end
end
