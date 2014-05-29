module ApplicationHelper
	def flash_class(flash_key)
    	return 'alert-warning' if flash_key == 'alert'
    	return 'alert-error' if flash_key == 'error'
  	end
end
