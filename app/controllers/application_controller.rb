class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  def render_404
    head :not_found
  end

  def render_resource(resource)
    if resource.valid?
      render json: {resource: resource}, status: :ok
    else
      render json: {errors: resource.errors}, status: :unprocessable_entity
    end
  end
end
