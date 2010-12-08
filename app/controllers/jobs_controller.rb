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

end
