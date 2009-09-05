class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:index, :show, :edit, :update]
  
  filter_access_to :all
  filter_access_to [:index, :show], :require => :read
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end
  
  def index
    @users = User.all
  end

  def edit
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end
  
  def update
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
    
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      if @user == @current_user
        redirect_to account_url
      else
        redirect_to user_url(@user)
      end
    else
      render :action => :edit
    end
  end
end
