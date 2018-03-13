class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "https://80887eaf7a0b474e9fa06d513302b5b6.vfs.cloud9.us-east-2.amazonaws.com/auth"
      req.params['code'] = params[:code]
    end
   
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
  
  private 
  def logged_in?
    !!session[:token]
  end
end