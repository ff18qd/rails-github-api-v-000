class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      # make sure to pass in the scope parameter (`repo` scope should be appropriate for what we want to do) in step of the auth process!
      # https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/#web-application-flow
      client_id = ENV['GITHUB_CLIENT_ID']
      scopestring = 'repo'
      redirect_uri = CGI.escape("https://80887eaf7a0b474e9fa06d513302b5b6.vfs.cloud9.us-east-2.amazonaws.com/auth")
      github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=#{scopestring}&redirect_uri=#{redirect_uri}"
      redirect_to github_url unless logged_in?
      # redirect_to root_path 
    end

    def logged_in?
    end
end
