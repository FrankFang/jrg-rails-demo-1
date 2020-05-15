class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  def render_404
    head 404
  end

  def render_resource(resource)
    if resource.valid?
      render json: {resource: resource}, status: 200
    else
      render json: {errors: resource.errors}, status: 400
    end
  end
end
