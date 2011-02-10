# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include FellownationApi
  before_filter :set_session
  layout 'home'


  def set_session    
    if !params[:fellownation_user_id].blank? && params[:fellownation] != session[:fellownation_user_id]
      session[:fellownation_user_id] = params[:fellownation_user_id]
      response = request_webservius('/API/check_admin', {:user_id => params[:fellownation_user_id], :key => FKEY })
      session[:is_admin] = ActiveSupport::JSON.decode(response.body)["results"]["is_admin"]
    end
  end

  private

#  before_filter :get_authentication, :except => [:access_token]
#
#  # Scrub sensitive parameters from your log
#  # filter_parameter_logging :password
#
#  def access_token
#    consumer = OAuth::Consumer.new FKEY, FSECRET, {:site=> SITE }
#
#    request_token = OAuth::RequestToken.new(
#      consumer,
#      session[:request_token],
#      session[:request_token_secret]
#    )
#    session[:request_token] = session[:request_token_secret] = nil
#
#    access_token = request_token.get_access_token(
#      :oauth_verifier => params[:oauth_verifier]
#    )
#
#    Token.create( :token => access_token.token, :secret => access_token.secret)
#    session["token_#{session[:fellownation_user_id]}"] = access_token.token
#
#    redirect_to root_path
#  end
#
#  private
#
#  def prepare_token
#      consumer = OAuth::Consumer.new FKEY, FSECRET, {:site=> SITE}
#      if session["token_#{session[:fellownation_user_id]}"] == FKEY
#        @access_token = OAuth::AccessToken.new( consumer, FKEY, FSECRET)
#      else
#        token = Token.find_by_token(session["token_#{session[:fellownation_user_id]}"])
#        @access_token = OAuth::AccessToken.new( consumer, token.token, token.secret)
#      end
#  end
#
#  def get_authentication
#    session[:fellownation_user_id] = params[:fellownation_user_id] unless params[:fellownation_user_id].blank?
#    if !params[:token].blank?
#      session["token_#{session[:fellownation_user_id]}"] = params[:token]
#    elsif session["token_#{session[:fellownation_user_id]}"].blank?
#      consumer = OAuth::Consumer.new FKEY, FSECRET, {:site=> SITE}
#      request_token = consumer.get_request_token
#      session[:request_token] = request_token.token
#      session[:request_token_secret] = request_token.secret
#      redirect_to request_token.authorize_url
#    end
#  end
end
