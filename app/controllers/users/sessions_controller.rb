class Users::SessionsController < Devise::SessionsController
  # このフィルターをスキップ
  skip_before_action :require_no_authentication, only: [:new, :create]

  def after_sign_in_path_for(resource)
    user_path(resource)  # ユーザーのページにリダイレクト
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path  # トップページにリダイレクト
  end

  def destroy
    sign_out current_user  # 明示的に current_user を渡さなくても動作します
    flash[:notice] = "Signed out successfully."
    redirect_to root_path
  end
end
