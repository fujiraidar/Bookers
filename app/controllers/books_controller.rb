class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]


  def new
  end

  def index
  	@book  = Book.new
  	@books = Book.all
  	@user = User.find_by(id: params[:id])
  	@user_profile = current_user
  end

  def show
  	@book_go = Book.find(params[:id])
  	@book = Book.new
  	@user = @book_go.user
  	@user_profile = @book_go.user
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
  	flash[:notice] = "You have creatad book successfully."
  	redirect_to book_path(@book.id)
    else
  	@books = Book.all
  	@user = User.find_by(id: params[:id])
  	@user_profile = User.find(current_user.id)
    render action: :index
    end
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  	flash[:notice] = "successfully."
  	redirect_to book_path(@book.id)
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
  	params.require(:book).permit(:title, :body, :user_id)
  end

  def current_user?(user)
    user == current_user
  end

  def correct_user
  	@book = Book.find(params[:id])
    @user = @book.user
    redirect_to books_path unless current_user?(@user)
  end
end






