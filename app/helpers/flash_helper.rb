module FlashHelper
  def flash_message(message, klass)
    content_tag :div, message.html_safe, class: "flash #{klass}", role: 'alert'
  end
end
