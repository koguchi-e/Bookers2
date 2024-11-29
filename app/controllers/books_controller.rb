class BooksController < ApplicationController
  before_action :authenticate_user!  

  # 新規作成
  def new
    @book = Book.new
  end

  # データの保存
  def create
    @book = current_user.books.new(book_params)
    @books = Book.all
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  # 一覧画面表示
  def index
    # すべての本のデータを取得
    @books = Book.page(params[:page])
    @book = Book.new
  end

  def show
  end

  def edit
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
