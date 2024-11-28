class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_logged_in, only: [:create]

  # GET /users/sign_up
  def new
    @user = User.new
    super  # 通常のサインアップ処理
  end

  private

  def redirect_if_logged_in
    # サインインしていない場合のみサインアップページを表示
    if user_signed_in?
      redirect_to user_path(current_user) # ログインしていればトップページにリダイレクト
    end
  end
end
