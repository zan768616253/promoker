$ ->
	$('#project-save').click () ->
		tags = []
		for elem in $('form.edit-project span.tag.selected')
			tag = $(elem).text().trim()	
			tags.push(tag)
		$('#project_needs').val(tags)
		$('form.edit-project').submit()
	# $('#project-publish').click () ->
	# 	tags = []
	# 	for elem in $('form.edit-project span.tag.selected')
	# 		tag = $(elem).text().trim()	
	# 		tags.push(tag)
	# 	$('#project_needs').val(tags)
	# 	$('form.edit-project').submit()
	# 	window.location.href = "http://" + location.host + '/projects/' + +'/publish'
# $(document).ready(ready)
# $(document).on('page:load', ready)
