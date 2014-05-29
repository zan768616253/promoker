$ ->
	$("a.fancybox").fancybox
		type: 'ajax'
	$('.bx-slider').bxSlider
		minSlides: 1,
		maxSlides: 6,
		# slideWidth: 170,
		# slideMargin: 10,
		pager: false,
		# auto: true,
		moveSlides: 1

	$('.poster img').contenthover
		effect: "slide"
		slide_speed: 300
		overlay_background: "#000"
		overlay_opacity: 0.8

	$('.project-thumbnail img').contenthover
		overlay_background: "#000"
		overlay_opacity: 0.8

	$('.back-to-top').click ()->
		$('html, body').animate({ scrollTop: 0 }, 'slow');


