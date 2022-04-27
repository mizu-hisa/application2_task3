class UsersController < ApplicationController

  def show
    @user=User.find(params[:id])
    @books = @user.books
    @user_info=User.new
    @book_new=Book.new
  end

  def index
    @book=Book.new
    @users=User.all
    @user=current_user
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
       flash[:notice]= "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def edit
    @user=User.find(params[:id])
    @current_user=current_user
  end



  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  before_action :correct_user, only: [:edit, :update]

  def correct_user
    @user=User.find(params[:id])
    # @current_user=current_user
    redirect_to user_path(current_user) unless @user == current_user
  end

end
