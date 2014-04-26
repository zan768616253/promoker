window.Movies =
  search : (elem) ->
    $(elem).siblings().removeClass('active')
    $(elem).addClass('active')
    name = $(elem).text()
