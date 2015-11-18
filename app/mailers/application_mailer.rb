class ApplicationMailer < ActionMailer::Base
  default from: "fxkennyfrc@gmail.com"

  def new_comment

    #New Headers
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    #content
    @user = user
    @post = post
    @comment = comment

    #mail to whom
    mail(to: user.email, subject: "new comment on #{post.title}")
  end
end
