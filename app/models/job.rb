class Job < ActiveRecord::Base
  validates_presence_of :date, :job_title, :location, :body
end
