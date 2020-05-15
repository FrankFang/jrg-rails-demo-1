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
    user.update update_params
    render_resource user
  end

  private

  def find_user
    @user = User.find params[:id]
  end

  def destroy
    User.destroy params[:id]
    head :ok
  end

  def create_params
    params.permit(:username, :password, :password_confirmation)
  end

  def update_params
    params.permit :nickname
  end

end
