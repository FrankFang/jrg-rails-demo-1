class UsersController < ApplicationController

  def index
    render json: {resources: User.all}
  end

  def show
    user = User.find params[:id]
    render json: {resource: user}
  end

  def create
    user = User.create get_params
    if user.valid?
      head 200
    else
      render json: {errors: user.errors}, status: 400
    end
  end

  def update
    user = User.find params[:id]
    if user.update(nickname: params[:nickname])
      render json: {resource: user}
    else
      render json: {errors: user.errors}
    end
  end

  def destroy
    User.destroy params[:id]
    head 200
  end

  def get_params
    params.permit(:username, :password, :password_confirmation)
  end

end
