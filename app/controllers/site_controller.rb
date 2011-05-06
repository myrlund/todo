class SiteController < ApplicationController
  def welcome
    redirect_to lists_path if user_signed_in?
  end

end
