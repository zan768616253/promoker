window.App =
	fixUrlDash : (url) ->
    	url.replace(/\/\//g,"/").replace(/:\//,"://")
	initNotificationSubscribe : () ->
	    return if not CURRENT_USER_ACCESS_TOKEN?
	    faye = new Faye.Client(FAYE_SERVER_URL)
	    message_subscription = faye.subscribe "/messages_count/#{CURRENT_USER_ACCESS_TOKEN}",(json) ->
	      span = $("span#user_messages_count")
	      new_title = $(document).attr("title").replace(/\(\d+\) /,'')
	      if json.count > 0
	        span.addClass("badge-error")
	        new_title = "(#{json.count}) #{new_title}"
	        url = App.fixUrlDash("#{ROOT_URL}#{json.content_path}")
	        console.log url
	        $.notifier.notify(json.avatar,json.title,json.content,url)
	      else
	        span.removeClass("badge-error")
	      span.text(json.count)
	      $(document).attr("title", new_title)
	    true