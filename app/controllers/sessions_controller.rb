class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  def create
    
    # response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
    #   req.body = {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_SECRET"],code: params["code"], Accept: 'application/json'}

    #   binding.pry
    # end
    response = Faraday.post("https://github.com/login/oauth/access_token"), {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_SECRET"],code: params["code"], 'Accept': 'application/json'}
    
    binding.pry
    access_hash = JSON.parse(response.body)
    # binding.pry
    session[:token] = access_hash["access_token"]
    
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    
    # resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    #   req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
    #   req.params['client_secret'] = ENV['GITHUB_SECRET']
    #   req.params['grant_type'] = 'authorization_code'
      
    #   req.params['redirect_uri'] = "https://80887eaf7a0b474e9fa06d513302b5b6.vfs.cloud9.us-east-2.amazonaws.com/auth"
    #   req.params['code'] = params[:code]
    # end
   
  
    redirect_to root_path
  end
  
  private 
  def logged_in?
    !!session[:token]
  end
end