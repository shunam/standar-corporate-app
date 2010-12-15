class WallsController < ApplicationController
  def index
    prepare_token
  end

  def post_message
    prepare_token
    response = @access_token.post('/API/wall_message_from_app', "user_id=#{session[:fellownation_user_id]}&app_key=#{FKEY}&message=#{params[:message]}")
    result = ActiveSupport::JSON.decode(response.body)["results"]
    image = ActiveSupport::JSON.decode(@access_token.post('/API/user_info', "token=#{session["token_#{session[:fellownation_user_id]}"]}").body)["photo"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.insert_html :top, :message_list, :partial => "message_list", :locals => { :message => params[:message], :image => image }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

end
