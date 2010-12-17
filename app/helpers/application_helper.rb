# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def get_image(params = {})
    if !params["candidate_profile_id"].blank?
      image = ActiveSupport::JSON.decode(@access_token.post('/API/user_info', "candidate_profile_id=#{params["candidate_profile_id"]}").body)["photo"]
    elsif !params["user_id"].blank?
      image = ActiveSupport::JSON.decode(@access_token.post('/API/user_info', "user_id=#{params["user_id"]}").body)["photo"]
    end
    return image
  end
end
