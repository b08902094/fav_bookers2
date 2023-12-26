class UsersController < ApplicationController
  def show
    @user =  User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_books =  @books.created_today
    @yesterday_books = @books.created_yesterday
    @this_week_books = @books.created_this_week
    @last_week_books = @books.created_last_week
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
        redirect_to user_path(current_user.id)
    end
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @books = Book.all
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated successfully"
      redirect_to user_path(current_user.id)
    else
      flash.now[:notice] = "error: failed to update"
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
