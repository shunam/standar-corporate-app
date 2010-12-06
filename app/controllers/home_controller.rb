class HomeController < ApplicationController
  def wall
  end

  def info
    @info = YAML.load_file("#{RAILS_ROOT}/config/info.yml")
    @files = AppFile.all
  end

  def jobs
  end

  def admin
    #    File.open("#{RAILS_ROOT}/lib/tasks/questions/questions.yml", 'w') do |file|
    #      questions = Question.find(:all, :order => 'order_position')
    #      # pass the file handle as the second parameter to dump
    #      YAML::dump(questions, file)
    #    end

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
