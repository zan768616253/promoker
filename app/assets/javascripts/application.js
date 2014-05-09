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
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bxslider
//= require social-share-button
//= require faye
//= require jquery.imgareaselect
//= require_tree .

$(function(){

    $('#register-link').click(function(e){
    	e.preventDefault()
    	e.stopPropagation()
        $('#login').hide()
        $('#register').fadeIn()
    })
    $('#login-link').click(function(e){
    	e.preventDefault()
    	e.stopPropagation()
        $('#register').hide()
        $('#login').fadeIn()
    })

    $('#post-link').click(function(e){
    	e.preventDefault()
    	e.stopPropagation()
    	$('#post-modal .modal-title').text('发布项目')
        $('#ticket-wrapper').hide()
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
    
})