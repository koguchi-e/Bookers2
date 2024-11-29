class BooksController < ApplicationController
  before_action :authenticate_user!

  # 新規作成
  def new
    @book = Book.new
    @new_book = Book.new  # 新規作成フォーム用のBookインスタンス
  end

  # データの保存
  def create
    @book = current_user.books.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @new_book = Book.new  # フォーム再表示のために新規のBookインスタンスを作成
      @books = Book.page(params[:page])  # ページネーションを使用して@booksを設定
      render :index
    end
  end

  # 一覧画面表示
  def index
    @books = Book.page(params[:page])  # ページネーションを使用
    @new_book = Book.new  # 新規作成フォーム用のBookインスタンス
  end

  def show
    @book = Book.find(params[:id])  # idで本の情報を取得
    @new_book = Book.new  # 新規作成フォーム用のBookインスタンス
  end

  # 本の編集・更新
  def edit
    puts params[:id]  # params[:id] を確認
    @book = Book.find(params[:id])  # 本を取得
    if @book.user != current_user  # ユーザーが一致するかチェック
      redirect_to books_path, alert: 'You are not authorized to edit this book.'
    end
  end

  def update
    @book = Book.find(params[:id])  # 編集対象の本を取得
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # 本の削除
  def destroy
    @book = Book.find(params[:id])  # 削除対象の本を取得
    
    # 投稿した本人でない場合は削除を許可しない
    unless @book.user == current_user
      redirect_to books_path, alert: 'You are not authorized to delete this book.'
      return  # ユーザーが権限がない場合は、ここで終了
    end

    # ユーザーが許可された場合のみ削除を実行
    @book.destroy
    redirect_to books_path, notice: 'Book was successfully deleted.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
