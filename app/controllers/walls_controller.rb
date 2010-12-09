class WallsController < ApplicationController
  def index
    if params[:token].blank?
      consumer=OAuth::Consumer.new FKEY, FSECRET, {:site=>"http://localhost:3000"}
      request_token = consumer.get_request_token
      session[:request_token] = request_token.token
      session[:request_token_secret] = request_token.secret
      redirect_to request_token.authorize_url
    end
  end

end
