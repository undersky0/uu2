class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :authenticate_user
  # before_filter :authenticate_user!
    include ApplicationHelper
helper_method :recipients

   def recipients
    curr_u = current_user
    User.all.reject { |u| u.id == curr_u.id }.compact
  end
  

def set_flash_message(key, kind, options = {})
    message = find_message(kind, options)
    flash[key] = message if message.present?
  end

  def find_message(kind, options = {})
    I18n.t("#{controller_name}.#{kind}", options)
  end
end