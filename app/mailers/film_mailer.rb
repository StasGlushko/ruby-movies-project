class FilmMailer < ApplicationMailer
  def import_complete
    @user = params[:user]
    @film = params[:film]
    @subject = 'Import complete.'

    mail to: @user.email, subject: @subject
  end
end
