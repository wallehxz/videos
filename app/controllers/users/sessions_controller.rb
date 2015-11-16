class Users::SessionsController < Devise::SessionsController
  layout 'just_front_sign'

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    if params[:back_url].present?
      redirect_to params[:back_url]
    else
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

end
