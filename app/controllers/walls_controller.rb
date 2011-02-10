class WallsController < ApplicationController

  def index
    response = request_webservius('/API/wall_messages_for_app', {:app_key => FKEY })
    result = ActiveSupport::JSON.decode(response.body)["results"]
    @wall_messages = result unless result == 'no result'
  end

  def show_more
    response = request_webservius('/API/wall_messages_for_app', {:app_key => FKEY, :page => params[:page] })
    result = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess
        unless result == 'no result'
          result.each do |wm|
            page.insert_html :bottom, :message_list, :partial => "message_list", :locals => { :message => wm }
          end
          
          if result.size == 10
            page.replace_html :show_more, :partial => "show_more", :locals => {:index => params[:page].next}
          else
            page.replace :show_more, ""
          end
        else
          page.replace :show_more, ""
        end
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def post_message    
    response = request_webservius('/API/wall_message_from_app', {:user_id => session[:fellownation_user_id], :app_key => FKEY, :message => params[:message] }, :post)
    result = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|      
      if Net::HTTPSuccess && result != "failed"
        page.insert_html :top, :message_list, :partial => "message_list", :locals => { :message => result }
        page << "jQuery('#message_text_area').val('')"
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def like_message
    response = request_webservius('/API/like_message_from_app', {:message_id => params[:message_id], :user_id => session[:fellownation_user_id]}, :post)
    result = ActiveSupport::JSON.decode(response.body)["results"]
    response = request_webservius('/API/list_like_messages', {:message_id => params[:message_id] })
    likes = ActiveSupport::JSON.decode(response.body)["results"]
    
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.replace_html "like_#{params[:message_id]}", :partial => "link_like_unlike", :locals => { :message_id => params[:message_id], :is_like => true }
        page.replace_html "list_like_#{params[:message_id]}", :partial => "list_like", :locals => { :likes => likes }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def unlike_message
    response = request_webservius('/API/unlike_message_from_app', {:message_id => params[:message_id], :user_id => session[:fellownation_user_id]}, :post)
    result = ActiveSupport::JSON.decode(response.body)["results"]
    response = request_webservius('/API/list_like_messages', {:message_id => params[:message_id] })
    likes = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.replace_html "like_#{params[:message_id]}", :partial => "link_like_unlike", :locals => { :message_id => params[:message_id], :is_like => false }
        page.replace_html "list_like_#{params[:message_id]}", :partial => "list_like", :locals => { :likes => likes }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def favorite_message
    response = request_webservius('/API/favorite_message_from_app', {:message_id => params[:message_id], :user_id => session[:fellownation_user_id]}, :post)
    result = ActiveSupport::JSON.decode(response.body)["results"]
    response = request_webservius('/API/list_favorite_messages', {:message_id => params[:message_id]})
    favorites = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.replace_html "favorite_#{params[:message_id]}", :partial => "link_favorite_unfavorite", :locals => { :message_id => params[:message_id], :is_favorite => true }
        page.replace_html "list_favorite_#{params[:message_id]}", :partial => "list_favorite", :locals => { :favorites => favorites }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def unfavorite_message
    response = request_webservius('/API/unfavorite_message_from_app', {:message_id => params[:message_id], :user_id => session[:fellownation_user_id]}, :post)
    result = ActiveSupport::JSON.decode(response.body)["results"]
    response = request_webservius('/API/list_favorite_messages', {:message_id => params[:message_id]})
    favorites = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.replace_html "favorite_#{params[:message_id]}", :partial => "link_favorite_unfavorite", :locals => { :message_id => params[:message_id], :is_favorite => false }
        page.replace_html "list_favorite_#{params[:message_id]}", :partial => "list_favorite", :locals => { :favorites => favorites }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def comment_message
    render :update do |page|
      unless params[:comment].blank?
        response = request_webservius('/API/comment_message_from_app', {:message_id => params[:message_id], :user_id => session[:fellownation_user_id], :comment => params[:comment]}, :post)
        result = ActiveSupport::JSON.decode(response.body)["results"]
        response = request_webservius('/API/show_all_comments', {:message_id => params[:message_id] })
        comments = ActiveSupport::JSON.decode(response.body)["results"]

        if Net::HTTPSuccess && result == "success"
          page.insert_html :top, "comment_list_#{params[:message_id].to_s}", :partial => "comment_list", :locals => { :comments => [comments.last] }
          page << '$("text_field_comment_'+params[:message_id].to_s+'").value = ""'
        else
          page.alert "Could you try it later ? Something went wrong."
        end
      else
        page.alert "Comment can't be empty !"
      end
    end
  end

  def show_all_comments
    response = request_webservius('/API/show_all_comments', {:message_id => params[:message_id] })
    comments = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess
        page.replace_html "comment_list_#{params[:message_id].to_s}", :partial => "comment_list", :locals => { :comments => comments }
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def delete_message
    response = request_webservius('/API/delete_message', {:message_id => params[:message_id] }, :post)
    result = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.replace "message_list_#{params[:message_id].to_s}", ""
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

  def delete_comment
    response = request_webservius('/API/delete_comment', {:comment_id => params[:comment_id] }, :post)
    result = ActiveSupport::JSON.decode(response.body)["results"]
    render :update do |page|
      if Net::HTTPSuccess && result == "success"
        page.replace "comment_#{params[:comment_id].to_s}", ""
      else
        page.alert "Could you try it later ? Something went wrong."
      end
    end
  end

end
