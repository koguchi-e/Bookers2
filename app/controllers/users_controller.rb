class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update], except: [:new, :create]
  before_action :is_matching_login_user, only: [:edit, :update]

  # ユーザー一覧
  def index
    @users = User.all # すべてのユーザーを取得
    @new_book = Book.new  # 新規作成フォーム用のBookインスタンス
  end
  
  # ユーザー詳細
  def show
    @user = User.find(params[:id])  # ユーザー情報を取得
    @new_book = Book.new  # 新規作成フォーム用のBookインスタンス
    @books = @user.books.page(params[:page])  # ユーザーに関連する本の情報をページネーションで取得
  end

  # ユーザー編集ページ
  def edit
    @user = User.find(params[:id])
  end

  # ユーザー更新
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  # ユーザーのパラメータを許可
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  # ログインユーザーと一致しているか確認
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
