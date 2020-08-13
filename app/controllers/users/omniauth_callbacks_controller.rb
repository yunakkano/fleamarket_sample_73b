# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :minimum_pass_len, only: [:facebook, :google_oauth2]

  def facebook
    authorization
  end

  def google_oauth2
    authorization
  end

  def failure
    redirect_to new_user_registration_path
  end

  private
  def authorization
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @profile = Profile.new
    if @user.persisted? #ユーザー情報が登録済みなので、新規登録ではなくログイン処理を行う
      sign_in_and_redirect @user, event: :authentication
    else #ユーザー情報が未登録なので、新規登録画面へ遷移する
      render template: 'devise/registrations/new'
    end
  end

  def minimum_pass_len
    @minimum_password_length = User.password_length.min
  end

end
