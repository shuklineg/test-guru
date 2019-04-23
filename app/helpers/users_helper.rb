module UsersHelper
  def mail_to_user(user)
    return 'Unknown' unless user

    mail_to(user.nickname || user.email, user.email)
  end
end
