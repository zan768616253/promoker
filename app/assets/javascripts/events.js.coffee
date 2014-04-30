window.Events =
	like : (elem, e) ->
    e.preventDefault()
    e.stopPropagation()
    $elem = $(elem)
    likes_count = parseInt($elem.data("count"))
    if $elem.data("state") != "liked"
      $.ajax
        url : "/events/" + $elem.data("id") + "/like"
        type : "POST"
      likes_count += 1
      $elem.data("count", likes_count)
      $elem.data("state", "liked")
      $(".event-likes b").text("#{likes_count}")
      $elem.toggleClass("liked")
    else
      $.ajax
        url : "/events/" + $elem.data("id") + "/unlike"
        type : "POST"
      likes_count -= 1
      $elem.data("count", likes_count)
      $elem.data("state", "")
      $(".event-likes b").text("#{likes_count}")
      $elem.toggleClass("liked")

    init : ->
