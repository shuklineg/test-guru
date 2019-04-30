module FlashHelper
  def flash_alert(message)
    flash_message(message, 'flash alert')
  end

  def flash_notice(message)
    flash_message(message, 'flash info')
  end

  def flash_message(message, klass)
    content_tag :p, message, class: klass
  end
end
