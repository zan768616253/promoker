$ ->
	$('#project-save').click () ->
		tags = []
		for elem in $('form.edit-project span.tag.selected')
			tag = $(elem).text().trim()	
			tags.push(tag)
		$('#project_needs').val(tags)
		$('form.edit-project').submit()
	$('#project-publish').click () ->
		tags = []
		for elem in $('form.edit-project span.tag.selected')
			tag = $(elem).text().trim()	
			tags.push(tag)
		$('#project_needs').val(tags)
		$('form.edit-project').submit()
