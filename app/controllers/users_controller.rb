class UsersController < ApplicationController
  # ユーザー一覧
  def index
    @users = User.all # すべてのユーザーを取得
  end
  
  # ユーザー詳細
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
  end
end
