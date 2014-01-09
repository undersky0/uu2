module ApplicationHelper
  def title(page_title)
    content_for(:title) {page_title}
  end
    def message_person(mailbox_name, message)
    mailbox_name == 'inbox' ? message.sender : message.recipient_list.join(', ')
  end
  
  def resource_class
  devise_mapping.to
end
end
