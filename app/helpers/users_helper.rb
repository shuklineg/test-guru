module UsersHelper
  def mail_to_user(user)
    return t('user.null') unless user

    mail_to(user.email, user.fullname.blank? ? user.email : user.fullname)
  end
end
