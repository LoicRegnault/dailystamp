class UsersController < ApplicationController
  before_filter :login_required, :only => [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.save do |result|
      if result
        flash[:notice] = I18n.t 'user.controller.signing'
        redirect_to root_url
      else
        render :action => 'new'
      end
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.attributes = params[:user]
    @user.guest = false
    @user.save do |result|
      if result
        flash[:notice] = I18n.t 'user.controller.update'
        redirect_to root_url
      else
        render :action => 'edit'
      end
    end
  end
end
