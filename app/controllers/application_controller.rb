class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  before_filter :set_current_user
  
  protected
  
  def set_current_user
    Authorization.current_user = current_user
  end
   
  def render_404(error)
    puts "Error: #{error}"
    respond_to do |format|
      format.html { render :template => "site/welcome" }
    end
  end
    
end
