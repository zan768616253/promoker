window.Messages =
	mark_all_as_read : (elem, e) ->
		e.preventDefault()
		e.stopPropagation()
		$.ajax
			url: "/messages/mark"
			type: "POST"
		$('tr.message').removeClass('unread')
		$('#user_messages_count').text('')
