# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def get_image(candidate_profile_id = nil)
    image = ActiveSupport::JSON.decode(@access_token.post('/API/user_info', "candidate_profile_id=#{candidate_profile_id}").body)["photo"] unless candidate_profile_id.blank?
    return image
  end
end
