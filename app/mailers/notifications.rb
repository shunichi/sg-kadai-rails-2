class Notifications < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.comment_mail.subject
  #
  def comment_mail(comment)
    @comment = comment

    mail to: 'sike.tm@gmail.com',
     subject: '新しいコメントが投稿されました'
  end
end
