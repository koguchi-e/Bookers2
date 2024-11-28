class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_if_logged_in, only: [:new, :create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # サインアウト後のリダイレクト先を設定
  def after_sign_out_path_for(resource_or_scope)
    root_path 
  end

  # ログイン後ユーザーのダッシュボードなどにリダイレクト
  def after_sign_in_path_for(resource)
    user_path(current_user)  
  end

  # ログインしている場合にサインアップページにアクセスできないようにリダイレクトする
  def redirect_if_logged_in
    if user_signed_in? && controller_name == 'registrations' && ['new', 'create'].include?(action_name)
      redirect_to user_path(current_user)  # ユーザーのページにリダイレクト
    end
  end
end
