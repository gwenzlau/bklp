class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    '?welcome=true'
   # after_sign_in_path_for(resource)
  end
end