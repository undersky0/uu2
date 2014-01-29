module ApplicationHelper
  def title(page_title)
    content_for(:title) {page_title}
  end
    def message_person(mailbox_name, message)
    mailbox_name == 'inbox' ? message.sender : message.recipient_list.join(', ')
  end
   def recipients
    curr_u = current_user
    User.all.reject { |u| u.user_id == curr_u.user_id }.compact
  end
  def set_flash_message(key, kind, options = {})
    message = find_message(kind, options)
    flash[key] = message if message.present?
  end

  def find_message(kind, options = {})
    I18n.t("#{controller_name}.#{kind}", options)
  end
  def resource_class
  devise_mapping.to
end

 def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success" # Green
      when :error
        "alert-danger" # Red
      when :alert
        "alert-warning" # Yellow
      when :notice
        "alert-info" # Blue
      else
        flash_type.to_s
    end
  end
end
