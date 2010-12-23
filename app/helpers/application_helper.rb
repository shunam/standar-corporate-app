# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def get_image(params = {})
    oauth = @access_token.post('/API/user_info', "candidate_profile_id=#{params["candidate_profile_id"]}").body unless params["candidate_profile_id"].blank?
    oauth = @access_token.post('/API/user_info', "user_id=#{params["user_id"]}").body unless params["user_id"].blank?    
    ActiveSupport::JSON.decode(oauth)["results"]["photo"]
  end

  def timeago(time, options = {})
    options[:class] ||= "wallTime"
    options[:style].blank? ? (options[:style] = "color: grey") : (options[:style] = options[:style] + ";color: grey")
    content_tag(:span, time.to_s, options.merge({:title => time.getutc.iso8601, })) if time
  end
end
