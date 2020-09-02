class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_params

  # protect_from_forgery with: :exception

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def search_params
    if params[:q].present?
      @search = Item.ransack(params[:q])
      @search_result = @search.result
      @search_word = @search.name_cont
      @search_result_cnt = @search.result.count
    else
      params[:q] = { sorts: 'id desc' }
      @search = Item.ransack()
      @search_result = Item.all
    end
  end

  def redirect_if_direct_access
    redirect_to root_path and return unless request.referrer
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
