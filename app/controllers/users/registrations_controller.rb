class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end

end
