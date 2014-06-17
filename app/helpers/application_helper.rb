module ApplicationHelper
	def flash_class(flash_key)
		return 'alert-info' if flash_key == 'notice'
    	return 'alert-warning' if flash_key == 'alert'
    	return 'alert-danger' if flash_key == 'error'
  	end
end
