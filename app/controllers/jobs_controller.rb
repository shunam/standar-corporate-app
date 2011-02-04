class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def create
    render :update do |page|
      job = Job.new(params[:job])
      if job.save
        page.insert_html :top, 'job_list', :partial => "job_list.html", :locals => { :job => job }
      end
    end
  end

  def destroy
    render :update do |page|
      job = Job.find(params[:id])
      if job.destroy
        page.replace 'job_' + job.id.to_s, ""
      end
    end
  end

  def apply
    prepare_token
    job_title = Job.find(params[:id]).job_title
    response = request_webservius('/API/apply_job', {:user_id => session[:fellownation_user_id], :app_key => FKEY, :job_title => job_title })
    result = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.alert "PM sent !"
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

end
