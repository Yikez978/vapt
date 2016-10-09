// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
	//Datatable and manual entry for mai tab start
	var mnEditing = null;
	var engId = $('#mainTabViewEngagement').attr('data-eng-id')

	// var moTable = $('#mainTabView').dataTable({
	// 	"columnDefs": [{
	// 		"targets": 7,
	// 		"orderable": false
	// 	}],
	// 	responsive: true
	// });


	$('#mainTabView').on('click', '.save-main-link', function(e){
		e.preventDefault();
		var jqInputs = $('input', mnEditing);
		var jqSelect = $('select#exploit_status_select').find(':selected');
		var usrId = $(moTable).attr('data-usr-id');
		$.ajax({
			method: "POST",
			url: "/engagements/"+engId+"/engagement_mains",
			data: { host: jqInputs[0].value, ports: jqInputs[1].value, services: jqInputs[2].value, vulns: jqInputs[3].value, host_name: jqInputs[4].value, os: jqInputs[5].value, username: usrId, exploit_status: jqSelect.val() }
		}).done(function( data ) {
			saveMainRow( moTable, mnEditing, data["id"], usrId, engId );
			$("#mainTabView tbody tr").each(function(index){
				//Adding pRelative class to td
				if(!$(this).children("td:nth-last-child(2)").children("span").hasClass("pRelative")){
					$(this).children("td:nth-last-child(2)").children("span").addClass("pointer pRelative stat");
				}
				if(!$(this).children("td:nth-last-child(4)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(4)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(5)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(5)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(6)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(6)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(7)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(7)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(8)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(8)").addClass("pRelative");
				}
				
				//Adding badges to span
				if($(this).children("td:nth-last-child(2)").text() == "Not Exploited" && $(this).children("td:last-child").children("a").attr("data-obj-id") == data["id"]){
					$(this).children("td:nth-last-child(2)").children("span").children("span").addClass("label label-danger");
				}
				else if($(this).children("td:nth-last-child(2)").text() == "Working" && $(this).children("td:last-child").children("a").attr("data-obj-id") == data["id"]){
					$(this).children("td:nth-last-child(2)").children("span").children("span").addClass("label label-warning");
				}
				else if($(this).children("td:nth-last-child(2)").text() == "Exploited" && $(this).children("td:last-child").children("a").attr("data-obj-id") == data["id"]){
					$(this).children("td:nth-last-child(2)").children("span").children("span").addClass("label label-success");
				}
			})
		}).fail(function( data ) {
			alert( eval(data.responseText).join(', ') );
		});
		
		// Show the new link
		$('#new-main-link').removeClass('disabled');
	});

	// Edit row
	function editMainRow ( moTable, mnRow ){
		var aData = moTable.fnGetData(mnRow);
		var jqTds = $('>td', mnRow);
		jqTds[0].innerHTML = '<input type="text" value="'+aData[0]+'">';
		jqTds[1].innerHTML = '<input type="text" value="'+aData[1]+'">';
		jqTds[2].innerHTML = '<input type="text" value="'+aData[2]+'">';
		jqTds[3].innerHTML = '<input type="text" value="'+aData[3]+'">';
		jqTds[4].innerHTML = '<input type="text" value="'+aData[4]+'">';
		jqTds[5].innerHTML = '<input type="text" value="'+aData[5]+'">';
		jqTds[7].innerHTML = '<select id="exploit_status_select"><option value="not_exploited">Not Exploited</option><option value="exploited">Exploited</option><option value="working">Working</option></select>'
		jqTds[8].innerHTML = '<a href="#" class="save-main-link">Save</a> <a href="#" class="cancel-main-link">Cancel</a>';
			
		mnEditing = mnRow;
	}

	// Save row
	function saveMainRow ( moTable, mnRow, mainId, usrId, engId ){
		var jqInputs = $('input', mnRow);
		var jqSelect = $('select#exploit_status_select').find(':selected');
		moTable.fnUpdate( '<a href="/engagements/'+engId+'/hosts/'+mainId+'">'+jqInputs[0].value+'</a>', mnRow, 0, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_engagement_main_'+mainId+'_ports" class="best_in_place" data-bip-value="'+jqInputs[1].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+jqInputs[1].value+'" data-bip-object="engagement_main" data-bip-attribute="ports" data-bip-type="input">'+jqInputs[1].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', mnRow, 1, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_engagement_main_'+mainId+'_services" class="best_in_place" data-bip-value="'+jqInputs[2].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+jqInputs[2].value+'" data-bip-object="engagement_main" data-bip-attribute="services" data-bip-type="input">'+jqInputs[2].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', mnRow, 2, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_engagement_main_'+mainId+'_vulns" class="best_in_place" data-bip-value="'+jqInputs[3].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+jqInputs[3].value+'" data-bip-object="engagement_main" data-bip-attribute="vulns" data-bip-type="input">'+jqInputs[3].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', mnRow, 3, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_engagement_main_'+mainId+'_host_name" class="best_in_place" data-bip-value="'+jqInputs[4].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+jqInputs[4].value+'" data-bip-object="engagement_main" data-bip-attribute="host_name" data-bip-type="input">'+jqInputs[4].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', mnRow, 4, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_engagement_main_'+mainId+'_os" class="best_in_place" data-bip-value="'+jqInputs[5].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+jqInputs[5].value+'" data-bip-object="engagement_main" data-bip-attribute="os" data-bip-type="input">'+jqInputs[5].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', mnRow, 5, false );
		moTable.fnUpdate( usrId, mnRow, 6, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_engagement_main_'+mainId+'_exploit_status" class="best_in_place" data-bip-value="'+$(jqSelect).val()+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+$(jqSelect).val()+'" data-bip-object="engagement_main" data-bip-collection="[[&quot;not_exploited&quot;,&quot;Not Exploited&quot;],[&quot;exploited&quot;,&quot;Exploited&quot;],[&quot;working&quot;,&quot;Working&quot;]]" data-bip-attribute="exploit_status" data-bip-type="select">'+$(jqSelect).text()+'</span></span>', mnRow, 7, false );
		moTable.fnUpdate( '<a href="" class="delete-main-link" data-obj-id='+mainId+' method="delete" >Delete</a>', mnRow, 8, false );
		moTable.fnDraw();
	}

	// New row
	$('#new-main-link').click( function (e) {
		e.preventDefault();

		var aiNew = moTable.fnAddData( [ '', '', '', '', '', '', '', '', '',
		'[Edit]()', '[Delete]()' ] );
		var mnRow = moTable.fnGetNodes( aiNew[0] );
		editMainRow( moTable, mnRow );
		mnEditing = mnRow;
				
		// Hide the new link
		$('#new-main-link').addClass('disabled');
	});

	// Delete row
	$('#mainTabView').on('click', 'a.delete-main-link', function (e) {
		e.preventDefault();

		var mnRow = $(this).parents('tr')[0];
		var mainId = $(this).attr("data-obj-id");
		$.ajax({
			url: '/engagements/'+engId+'/engagement_mains/'+mainId,
			type: 'DELETE',
			success: function(){
				moTable.fnDeleteRow( mnRow );
			}
		})
	});

	// Cancel create row
	$('#mainTabView').on('click', 'a.cancel-main-link', function (e) {
		e.preventDefault();

		var mnRow = $(this).parents('tr')[0];
		moTable.fnDeleteRow( mnRow );
				
		// Show the new link
		$('#new-main-link').removeClass('disabled');
	});

	$(".best_in_place").best_in_place();
	//Datatable and manual entry for main tab end

	//Datatable and manual entry for cred tab start
	var oTable = $('#credsTabView').dataTable({
		"columnDefs": [{
			"targets": 4,
			"orderable": false
		}],
		responsive: true
	});
	var nEditing = null;
	var engId = $(oTable).attr('data-eng-id');
		
	$('#credsTabView').on('click', '.save-cred-link', function (e) {
		e.preventDefault();
		var jqInputs = $('input', nEditing);
		
		$.ajax({
			method: "POST",
			url: "/engagements/"+engId+"/engagement_creds",
			data: { ip: jqInputs[0].value, pwdump: jqInputs[1].value, password: jqInputs[2].value, description: jqInputs[3].value }
		}).done(function( data ) {
			saveRow( oTable, nEditing, data["id"] );
		}).fail(function( data ) {
			alert( eval(data.responseText).join(', ') );
		});
		
		// Show the new link
		$('#new-cred-link').removeClass('disabled');
	});

	// Edit row
	function editRow ( oTable, nRow ){
		var aData = oTable.fnGetData(nRow);
		var jqTds = $('>td', nRow);
		jqTds[0].innerHTML = '<input type="text" value="'+aData[0]+'">';
		jqTds[1].innerHTML = '<input type="text" value="'+aData[1]+'">';
		jqTds[2].innerHTML = '<input type="text" value="'+aData[2]+'">';
		jqTds[3].innerHTML = '<input type="text" value="'+aData[3]+'">';
		jqTds[4].innerHTML = '<a href="#" class="save-cred-link">Save</a> <a href="#" class="cancel-cred-link">Cancel</a>';
			
		nEditing = nRow;
	}
	
	// Save row
	function saveRow ( oTable, nRow, credId ){
		var jqInputs = $('input', nRow);
		oTable.fnUpdate( jqInputs[0].value, nRow, 0, false );
		oTable.fnUpdate( jqInputs[1].value, nRow, 1, false );
		oTable.fnUpdate( jqInputs[2].value, nRow, 2, false );
		oTable.fnUpdate( jqInputs[3].value, nRow, 3, false );
		oTable.fnUpdate( '<a href="" class="delete-cred-link" data-obj-id='+credId+' method="delete" >Delete</a>', nRow, 4, false );
		oTable.fnDraw();
	}
	
	// New row
	$('#new-cred-link').click( function (e) {
		e.preventDefault();

		var aiNew = oTable.fnAddData( [ '', '', '', '',
		'[Edit]()', '[Delete]()' ] );
		var nRow = oTable.fnGetNodes( aiNew[0] );
		editRow( oTable, nRow );
		nEditing = nRow;
				
		// Hide the new link
		$('#new-cred-link').addClass('disabled');
	} );
	
	// Delete row
	$('#credsTabView').on('click', 'a.delete-cred-link', function (e) {
		e.preventDefault();

		var nRow = $(this).parents('tr')[0];
		var credId = $(this).attr("data-obj-id")
		$.ajax({
			url: '/engagements/'+engId+'/engagement_creds/'+credId,
			type: 'DELETE',
			success: function(){
				oTable.fnDeleteRow( nRow );
			}
		})
	} );
		
	// Cancel create row
	$('#credsTabView').on('click', 'a.cancel-cred-link', function (e) {
		e.preventDefault();

		var nRow = $(this).parents('tr')[0];
		oTable.fnDeleteRow( nRow );
				
		// Show the new link
		$('#new-cred-link').removeClass('disabled');
	} );
	//Datatable and manual entry for cred tab end

	//Datatable for nmap start
	$('#nmapDataTable').dataTable({
		responsive: true
	});
	//Datatable for nmap start

	// $('td.pRelative').on('mouseover', '.eHover', function(){
	// 	$(this).siblings('i.editIcon').removeClass('hide');
	// })
	// $('.eHover').mouseleave(function(){
	// 	$(this).siblings('i.editIcon').addClass('hide');
	// })
	$('.eHover').click(function(){
		// $(this).siblings('i.editIcon').addClass('hide');
		$(this).children("span").removeClass("label");
		if($(this).children('span').hasClass('label-danger')){
			$(this).children("span").removeClass("label-danger");
		}
		else if($(this).children('span').hasClass('label-warning')){
			$(this).children("span").removeClass("label-warning");
		}
		else if($(this).children('span').hasClass('label-success')){
			$(this).children("span").removeClass("label-success");
		}
	});

	//Datatable for nessus start
	$("#nessusDataTable").dataTable({
		responsive: true
	});
	//Datatable for nessus end
	
	//Tab to accordion start
	$('.vTabs').tabCollapse({
		tabsClass: 'hidden-xs',
		accordionClass: 'visible-xs'
	});
	//Tab to accordion end

	//Datatable for metasploit hosts start
	$("#metasploit_host_table").dataTable({
		responsive: true
	});
	//Datatable for metasploit hosts end

	//Datatable for metasploit service start
	$("#metasploit_service_table").dataTable({
		responsive: true
	});
	//Datatable for metasploit service end

	//Datatable for metasploit vulns start
	$("#metasploit_vulns_table").dataTable({
		responsive: true
	});
	//Datatable for metasploit vulns end

	$(".exploit_status").bind("ajax:success", function(){
		var element = $(this);
		setTimeout(function(){
			console.log($(element).text());
			if($(element).text() == "Not Exploited"){
				$(element).removeClass();
				$(element).addClass("best_in_place eFontSize exploit_status label label-danger");
			}
			else if($(element).text() == "Exploited"){
				$(element).removeClass();
				$(element).addClass("best_in_place eFontSize exploit_status label label-success");
			}
			else if($(element).text() == "Working"){
				$(element).removeClass();
				$(element).addClass("best_in_place eFontSize exploit_status label label-warning");
			}
		},400)
	});
});
