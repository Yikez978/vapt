$(document).ready(function(){
	$('#hosts_host_scan_id').change(function(){
		window.location.href = '/engagements/'+$(this).attr('data-eng-id')+'/host_scan_details/'+$(this).val()
	});
})