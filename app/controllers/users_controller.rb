class UsersController < ApplicationController
  before_action :find_user, only: [:show, :update]
  attr_reader :user

  def index
    render json: {resources: User.all}
  end

  def show
    render json: {resource: user}
  end

  def create
    render_resource User.create create_params
  end

  def update
    user.update(nickname: params[:nickname])
    render_resource user
  end


  def find_user
    @user = User.find params[:id]
  end

  def destroy
    User.destroy params[:id]
    head 200
  end

  def create_params
    params.permit(:username, :password, :password_confirmation)
  end

end
