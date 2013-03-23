class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource
    resource.approved=true
    resource.role="viewer"
    if resource.save
      redirect_to root_path
    else
      clean_up_passwords(resource)
      redirect_to new_user_session_path, :user => "user creation error"
    end
  end
end
