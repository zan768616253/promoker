class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters
	protected
	def configure_permitted_parameters
		binding.pry
		devise_parameter_sanitizer.for(:sign_up).push(:nickname)
	end
end