class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @users = User.all
    @book = Book.new
    @books = @user.books
    
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
    redirect_to user_path(current_user.id)
    end
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end