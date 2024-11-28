class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_logged_in, only: [:new, :create]

  # GET /users/sign_up
  def new
    @user = User.new
    super  # 通常のサインアップ処理
  end

  private

  def redirect_if_logged_in
    redirect_to user_path(current_user) if user_signed_in?
  end
end
