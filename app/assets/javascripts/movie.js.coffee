window.Movies =
	like : (elem) ->
    $elem = $(elem)
    likes_count = parseInt($elem.data("count"))
    if $elem.data("state") != "liked"
      $.ajax
        url : "/movies/" + $elem.data("id") + "/like"
        type : "POST"
      likes_count += 1
      $elem.data("count", likes_count)
      $elem.data("state", "liked")
      $("span", elem).text("#{likes_count}")
      $elem.toggleClass("liked")
    else
      $.ajax
        url : "/movies/" + $elem.data("id") + "/unlike"
        type : "POST"
      likes_count -= 1
      $elem.data("count", likes_count)
      $elem.data("state", "")
      $("span", elem).text("#{likes_count}")
      $elem.toggleClass("liked")

    init : ->
