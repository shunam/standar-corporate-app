class WallsController < ApplicationController
  def index
    prepare_token
    response = @access_token.post('/API/wall_messages_for_app', "app_key=#{FKEY}")
    result = ActiveSupport::JSON.decode(response.body)["results"]
    @wall_messages = result unless result == 'no result'
    
  end

  def post_message
    prepare_token
    response = @access_token.post('/API/wall_message_from_app', "user_id=#{session[:fellownation_user_id]}&app_key=#{FKEY}&message=#{params[:message]}")
    result = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.insert_html :top, :message_list, :partial => "message_list", :locals => { :message => params[:message], :user_id => session[:fellownation_user_id] }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

end
