class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_logged_in, only: [:create]
  before_action :configure_sign_up_params, only: [:create]  # これを追加

  # GET /users/sign_up
  def new
    @user = User.new
    super  # 通常のサインアップ処理
  end

  private

  def configure_sign_up_params
    # :email を追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end

  def redirect_if_logged_in
    # サインインしていない場合のみサインアップページを表示
    if user_signed_in?
      redirect_to user_path(current_user) # ログインしていればトップページにリダイレクト
    end
  end
end
