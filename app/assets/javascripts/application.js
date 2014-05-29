// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require bxslider
//= require social-share-button
//= require faye
//= require jquery.imgareaselect
//= require fancybox
//= require_tree .
//= require turbolinks

$(function() {
    $('#register-modal-link').click(function(e){
        e.preventDefault()
        e.stopPropagation()
        $('#login-modal').modal()
        $('#login-modal #login').hide()
        $('#login-modal #register').fadeIn()
    })
    $('#login-modal-link').click(function(e){
        e.preventDefault()
        e.stopPropagation()
        $('#login-modal').modal()
        $('#login-modal #register').hide()
        $('#login-modal #login').fadeIn()
    })
    $('#register-link').click(function(e){
    	e.preventDefault()
    	e.stopPropagation()
        $('#login-modal #login').hide()
        $('#login-modal #register').fadeIn()
    })
    $('#login-link').click(function(e){
    	e.preventDefault()
    	e.stopPropagation()
        $('#login-modal #register').hide()
        $('#login-modal #login').fadeIn()
    })

    $('#ticket-back').click(function(e){
    	e.preventDefault()
    	e.stopPropagation()
    	$('#post-modal .modal-title').text('发布项目')
        $('#ticket-wrapper').hide()
        $('#post-wrapper').fadeIn()
    })

    $('#project-back').click(function(e){
        e.preventDefault()
        e.stopPropagation()
        $('#post-modal .modal-title').text('发布项目')
        $('#project-wrapper').hide()
        $('#post-wrapper').fadeIn()
    })

    $('#ticket-link').click(function(e){
    	e.preventDefault()
    	e.stopPropagation()
    	$('#post-modal .modal-title').text('一句话项目')
        $('#post-wrapper').hide()
        $('#ticket-wrapper').fadeIn()
    })

    $('#project-link').click(function(e){
        e.preventDefault()
        e.stopPropagation()
        $('#post-modal .modal-title').text('拍摄计划')
        $('#post-wrapper').hide()
        $('#project-wrapper').fadeIn()
    })


    $('span.tag').click(function(){
    	$(this).toggleClass('selected')
    })

    $('#post-modal .submit').click(function(){
    	var tags = []
    	for (var i = 0; i < $('span.tag.selected').length; i++){
    		var tag = $($('span.tag.selected')[i]).text().trim()
    		tags.push(tag)
    	}
    	$('#ticket_needs').val(tags)
    	$('#new_ticket').submit()
    })

    $(window).scroll(function() {
        if ($(this).scrollTop() >= 50) {        // If page is scrolled more than 50px
            $('#return-to-top').fadeIn(200);    // Fade in the arrow
        } else {
            $('#return-to-top').fadeOut(200);   // Else fade out the arrow
        }
    });
    $('#return-to-top').click(function() {      // When arrow is clicked
        $('body,html').animate({
            scrollTop : 0                       // Scroll to top of body
        }, 500);
    });
})