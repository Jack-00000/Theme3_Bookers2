class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @user = current_user
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    @users = User.all
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.new
    @user = User.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body).merge(user_id:current_user.id)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end

end