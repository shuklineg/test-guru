module UsersHelper
  def mail_to_user(user)
    mail_to(user.nickname || user.email, user.email)
  end
end
