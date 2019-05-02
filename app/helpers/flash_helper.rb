module FlashHelper
  def flash_message(message, klass)
    content_tag :p, message, class: "flash #{klass}"
  end
end
