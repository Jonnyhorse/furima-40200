class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'yamazaki' && password == '0614'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nick_name, :last_name_chinese_character, :first_name_chinese_character, :last_name_katakana, :first_name_katakana,
                                             :date_of_birth])
  end
end
