# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout 'home'

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def access_token
    consumer=OAuth::Consumer.new FKEY, FSECRET, {:site=>"http://localhost:3000"}

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

  end
  
  private

  def get_authentication
    consumer=OAuth::Consumer.new FKEY, FSECRET, {:site=>"http://localhost:3000"}
    request_token = consumer.get_request_token
    redirect_to request_token.authorize_url
  end
end
