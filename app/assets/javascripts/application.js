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
//= require jquery.turbolinks
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/extras/dataTables.responsive
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require jquery-ui
//= require bootstrap
//= require cocoon
//= require bootstrap-datepicker
//= require bootstrap-switch
//= require moment
//= require bootstrap-datetimepicker
//= require c3
//= require d3
//= require angular
//= require autocomplete-rails
//= require ckeditor/init
//= require shCore
//= require syntaxhighlighter	
//= require jquery.tokeninput
//= require best_in_place
//= require best_in_place.jquery-ui
//= require Chart.min
//= require bootstrap-tabcollapse
//= require_tree .
	
var mouseover = false;

$(document).ready(function() {
	// $('#vTabs').tabCollapse({
	// 	tabsClass: 'hidden-xs',
	// 	accordionClass: 'visible-xs'
	// });
	//Join Engagements
	$('.accept_engagement').click(function(){
		var element = $(this)
		$.ajax({
			url: '/engagement_statuses/accept',
			type: 'POST',
			data: 'engagement_id='+$(this).attr('eng-id'),
			success: function(){
				$(element).parent('td').parent('tr').remove();
			}
		})
	})

	//Remove Notes
	$('.remove_note').click(function(){
		var element = $(this)
		$.ajax({
			url: '/notes/'+$(this).attr('note_id'),
			type: 'DELETE',
			data: 'engagement_id='+$(this).attr('eng_id'),
			success: function(){
				$(element).parent('li').remove();
			}
		})
	})

	$(".ajaxLoader").hide();
	$("#cve_db").dataTable({
		responsive: true
	});
	$("#cwe_db").dataTable({
		responsive: true
	});


	//New Engagement Datepicker
	var nowTemp = new Date();
	var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

	var checkin = $('#datepicker_start_date').datepicker({
		beforeShowDay: function(date) {
			return date.valueOf() < now.valueOf() ? 'disabled' : '';
		}
	}).on('changeDate', function(ev) {
		if (ev.date.valueOf() > checkout.viewDate.valueOf()){
			var newDate = new Date(ev.date)
			newDate.setDate(newDate.getDate() + 1);
			checkout.setDate(newDate);		
		}
		else {
			checkout.setDate(checkout.getDate());
		}
	    
		checkin.hide();
		$('#datepicker_end_date')[0].focus();
	}).data('datepicker');

	var checkout = $('#datepicker_end_date').datepicker({
		beforeShowDay: function(date) {
			return date.valueOf() <= checkin.viewDate.valueOf() ? 'disabled' : '';
		}
	}).on('changeDate', function(ev) {
		checkout.hide();
	}).data('datepicker');

	$("#pageLoading").hide();
  	$("#backdropPageLoading").hide();

	if( $("div.alert") ) {

		$("div.alert")
			.mouseover(function() {
				mouseover = true;
			})
			.mouseout(function() {
				mouseover = false;
			});
	}
	
	setTimeout(checkAlert, 2000);
});

function checkAlert() {
	if ( mouseover == false ) {
		$().alert('close');
		$("div.alert").fadeTo(500, 0).slideUp(500, function(){
			$("div.alert").remove();
		});
	}
	
	if( $("div.alert") ) {
		setTimeout(checkAlert, 2000);
	}
}

$(window).bind('beforeunload', function() { 
  $("#backdropPageLoading").show();
  $("#pageLoading").show();
});
$(window).bind('load', function() { 
  $("#pageLoading").hide();
  $("#backdropPageLoading").hide();
});