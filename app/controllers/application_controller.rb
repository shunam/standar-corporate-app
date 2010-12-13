# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :get_authentication, :except => [:access_token]
  layout 'home'

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def access_token
    consumer = OAuth::Consumer.new FKEY, FSECRET, {:site=> SITE }

    request_token = OAuth::RequestToken.new(
      consumer,
      session[:request_token],
      session[:request_token_secret]
    )
    session[:request_token] = session[:request_token_secret] = nil

    access_token = request_token.get_access_token(
      :oauth_verifier => params[:oauth_verifier]
    )

    Token.create( :token => access_token.token, :secret => access_token.secret)
    session[:token] = access_token.token
    session[:id] = ActiveSupport::JSON.decode(access_token.post('/API/user_info', "token=#{session[:token]}").body)["id"]

    redirect_to root_path
  end
  
  private

  def prepare_token
    consumer = OAuth::Consumer.new FKEY, FSECRET, {:site=> SITE}
    token = Token.find_by_token(session[:token])
    @access_token = OAuth::AccessToken.new( consumer, token.token, token.secret)
  end

  def get_authentication
    session[:creator_id] = params[:creator_id] if session[:creator_id].blank?
    if params[:token].blank? && session[:token].blank?
      consumer = OAuth::Consumer.new FKEY, FSECRET, {:site=> SITE}
      request_token = consumer.get_request_token
      session[:request_token] = request_token.token
      session[:request_token_secret] = request_token.secret
      redirect_to request_token.authorize_url
    elsif session[:token].blank?
      session[:token] = params[:token]
    end
  end
end
