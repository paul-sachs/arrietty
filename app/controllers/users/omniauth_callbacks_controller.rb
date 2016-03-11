class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth = request.env["omniauth.auth"]
    provider = auth["provider"]
    uid = auth["uid"]

    @user = User.where(uid: uid, provider: provider).first_or_initialize
  end

  def twitter_submit
    provider = params[:user][:provider]
    uid = params[:user][:uid]

    @user = User.where(uid: uid, provider: provider).first_or_initialize
    @user.password = SecureRandom.uuid

    if @user.update(user_params)
      sign_in_and_redirect @user
    else
      render :twitter
    end
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
