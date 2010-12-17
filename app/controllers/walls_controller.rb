class WallsController < ApplicationController
  before_filter :prepare_token

  def index
    response = @access_token.post('/API/wall_messages_for_app', "app_key=#{FKEY}")
    result = ActiveSupport::JSON.decode(response.body)["results"]
    @wall_messages = result unless result == 'no result'
  end

  def post_message
    response = @access_token.post('/API/wall_message_from_app', "user_id=#{session[:fellownation_user_id]}&app_key=#{FKEY}&message=#{params[:message]}")
    result = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.insert_html :top, :message_list, :partial => "message_list", :locals => { :message => result }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def like_message
    response = @access_token.post('/API/like_message_from_app', "message_id=#{params[:message_id]}&user_id=#{session[:fellownation_user_id]}")
    result = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.replace_html "like_#{params[:message_id]}", :partial => "link_like_unlike", :locals => { :message_id => params[:message_id], :is_like => true }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def unlike_message
    response = @access_token.post('/API/unlike_message_from_app', "message_id=#{params[:message_id]}&user_id=#{session[:fellownation_user_id]}")
    result = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.replace_html "like_#{params[:message_id]}", :partial => "link_like_unlike", :locals => { :message_id => params[:message_id], :is_like => false }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def favorite_message

  end

  def unfavorite_message

  end

  def comment_message

  end

end
