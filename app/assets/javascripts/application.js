// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$( document ).ready(function() {
var loc = 'http://localhost:3000/v1/';
	$('#signup button').click(function() {
	   $.ajax({
	      url: loc+'signup.json',
	      data: {
	         'user[name]': $('#signup input[name="name"]').val(),
	         'user[email]': $('#signup input[name="email"]').val(),
	         'user[password]': $('#signup input[name="password"]').val(),
	         'user[confirm_password]': $('#signup input[name="confirm_password"]').val()
	      },
	      error: function(jqXHR, status, error) {
	         $('#error').html('<p>'+status+'</p>'+'<p>'+error+'</p>');
	         console.log(status + '; ' + error);
	      },
	      dataType: 'json',
	      success: function(data) {
	      	$('#response').html('');
	      	content = '';
	      	$.each(data, function(i,dat){
            content += '<p><b>' + i + ':<b>' + dat + '</p>';
          });
	        $(content).appendTo("#response");
	        console.log(data);
	      },
	      type: 'POST'
	   });
	});

});