class UsersController < ApplicationController
  before_filter :require_login_unless_no_users

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        auto_login @user
        format.html { redirect_to admin_path, notice: 'Welcome!' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render action: 'new' }
    end
  end

  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_path, notice: 'Settings Saved!' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private

  def require_login_unless_no_users
    require_login unless no_users?
  end
end