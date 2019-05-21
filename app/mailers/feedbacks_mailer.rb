class FeedbacksMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedbacks_mailer.send_feedback.subject
  #
  def send_feedback(feedback)
    @user = feedback.user
    @message = feedback.message

    mail to: Admin.pluck(:email).join(',')
  end
end
