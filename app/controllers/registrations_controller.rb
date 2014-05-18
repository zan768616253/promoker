class RegistrationsController < Devise::RegistrationsController
	before_filter :generate_captcha_key, :only => [:new]
end