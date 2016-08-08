$(document).ready(function(){
	$('#hosts_engagement_main_id').change(function(){
		window.location.href = '/engagements/'+$(this).attr('data-eng-id')+'/hosts/'+$(this).val()
	});

	$('.engagement_os').on('change', function(){
		if($(this).text() == "Linux"){
			$('.os_image').html('<i class="fa fa-linux"></i>');
		}
		else if($(this).text() == "Windows"){
			$('.os_image').html('<i class="fa fa-windows"></i>');
		}
		else{
			$('.os_image').html('<i class="fa fa-apple"></i>');
		}
	});

	//Host Info Datatable start
	var mnEditing = null;
	var moTable = $('#servicesTabView').dataTable({
		"columnDefs": [{
			"targets": 6,
			"orderable": false
		}],
		responsive: true
	});
	var engId = $(moTable).attr('data-eng-id');
	var hostId = $(moTable).attr('data-host-id');
	var host = $(moTable).attr('data-host');

	$('#servicesTabView').on('click', '.save-service-link', function(e){
		e.preventDefault();

		var jqInputs = $('input', mnEditing);
		var jqSelect = $('select#exploit_status_select').find(':selected');

		$.ajax({
			method: "POST",
			url: "/engagements/"+engId+"/hosts/"+hostId+"/host_services",
			data: { service_port: jqInputs[0].value, service_protocol: jqInputs[1].value, service_status: jqSelect.val(), service_name: jqInputs[2].value, service_banner: jqInputs[3].value }
		}).done(function( data ) {
			saveMainRow( moTable, mnEditing, data["id"], hostId, engId, data["ip"] );
			$("#servicesTabView tbody tr").each(function(index){
				//Adding pRelative class to td
				if(!$(this).children("td:nth-last-child(1)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(1)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(2)").children("span").hasClass("pRelative")){
					$(this).children("td:nth-last-child(2)").children("span").addClass("pointer pRelative stat");
				}
				if(!$(this).children("td:nth-last-child(3)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(3)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(4)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(4)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(5)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(5)").addClass("pRelative");
				}
			})
		}).fail(function( data ) {
			alert( eval(data.responseText).join(', ') );
		});
		
		// Show the new link
		$('#new-service-link').removeClass('disabled');
	});

	// New row
	$('#new-service-link').click( function (e) {
		e.preventDefault();

		var aiNew = moTable.fnAddData( [ '', '', '', '', '', '',
		'[Edit]()', '[Delete]()' ] );
		var mnRow = moTable.fnGetNodes( aiNew[0] );
		editMainRow( moTable, mnRow, host );
		mnEditing = mnRow;
				
		// Hide the new link
		$('#new-service-link').addClass('disabled');
	});

	// Cancel create row
	$('#servicesTabView').on('click', 'a.cancel-main-link', function (e) {
		e.preventDefault();

		var mnRow = $(this).parents('tr')[0];
		moTable.fnDeleteRow( mnRow );
				
		// Show the new link
		$('#new-service-link').removeClass('disabled');
	});

	// Delete row
	$('#servicesTabView').on('click', 'a.delete-service-link', function (e) {
		e.preventDefault();

		var mnRow = $(this).parents('tr')[0];
		var mainId = $(this).attr("data-obj-id")
		$.ajax({
			url: '/engagements/'+engId+'/hosts/'+hostId+'/host_services/'+mainId,
			type: 'DELETE',
			success: function(){
				moTable.fnDeleteRow( mnRow );
			}
		})
	});

	// Save row
	function saveMainRow ( moTable, mnRow, mainId, hostId, engId, ip ){
		var jqInputs = $('input', mnRow);
		var jqSelect = $('select#service_status_select').find(':selected');
		moTable.fnUpdate( ip, mnRow, 0, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_info_'+mainId+'_service_port" class="best_in_place" data-bip-value="'+jqInputs[0].value+'" data-bip-url="/engagements/'+engId+'/hosts/'+hostId+'/host_services/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+jqInputs[0].value+'" data-bip-object="host_info" data-bip-attribute="service_port" data-bip-type="input">'+jqInputs[0].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', mnRow, 1, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_info_'+mainId+'_service_port" class="best_in_place" data-bip-value="'+jqInputs[1].value+'" data-bip-url="/engagements/'+engId+'/hosts/'+hostId+'/host_services/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+jqInputs[1].value+'" data-bip-object="host_info" data-bip-attribute="service_port" data-bip-type="input">'+jqInputs[1].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', mnRow, 2, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_info_'+mainId+'_service_port" class="best_in_place" data-bip-value="'+$(jqSelect).val()+'" data-bip-url="/engagements/'+engId+'/hosts/'+hostId+'/host_services/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+$(jqSelect).val()+'" data-bip-object="host_info" data-bip-collection="[[&quot;open&quot;,&quot;Open&quot;],[&quot;closed&quot;,&quot;Closed&quot;]]" data-bip-attribute="service_status" data-bip-type="select">'+$(jqSelect).text()+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', mnRow, 3, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_info_'+mainId+'_service_port" class="best_in_place" data-bip-value="'+jqInputs[2].value+'" data-bip-url="/engagements/'+engId+'/hosts/'+hostId+'/host_services/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+jqInputs[2].value+'" data-bip-object="host_info" data-bip-attribute="service_port" data-bip-type="input">'+jqInputs[2].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', mnRow, 4, false );
		moTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_info_'+mainId+'_service_port" class="best_in_place" data-bip-value="'+jqInputs[3].value+'" data-bip-url="/engagements/'+engId+'/hosts/'+hostId+'/host_services/'+mainId+'" data-bip-skip-blur="false" data-bip-original-content="'+jqInputs[3].value+'" data-bip-object="host_info" data-bip-attribute="service_port" data-bip-type="input">'+jqInputs[3].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', mnRow, 5, false );
		moTable.fnUpdate( '<a href="" class="delete-service-link" data-obj-id='+mainId+' method="delete" >Delete</a>', mnRow, 6, false );
		moTable.fnDraw();
	}

	// Edit row
	function editMainRow ( moTable, mnRow, host ){
		var aData = moTable.fnGetData(mnRow);
		var jqTds = $('>td', mnRow);
		jqTds[0].innerHTML = host;
		jqTds[1].innerHTML = '<input type="text" value="'+aData[1]+'">';
		jqTds[2].innerHTML = '<input type="text" value="'+aData[2]+'">';
		jqTds[3].innerHTML = '<select id="service_status_select"><option value="open">Open</option><option value="closed">Closed</option></select>';
		jqTds[4].innerHTML = '<input type="text" value="'+aData[4]+'">';
		jqTds[5].innerHTML = '<input type="text" value="'+aData[5]+'">';
		jqTds[6].innerHTML = '<a href="#" class="save-service-link">Save</a> <a href="#" class="cancel-main-link">Cancel</a>';
			
		mnEditing = mnRow;
	}
	//Host Info Datatable end

	//Vulns Datatable start
	var vnEditing = null;
	var voTable = $('#vulnsTabView').dataTable({
		"columnDefs": [{
			"targets": 7,
			"orderable": false
		}],
		"aaSorting": [],
		responsive: true
	});
	var engMainId = $(voTable).attr('data-eng-main-id');

	$("#vulnsTabView").on('click', '.save-vuln-link', function(e){
		e.preventDefault();

		var vjqInputs = $('input', vnEditing);
		var vjqSelect = $('select#vulns_status_select').find(':selected');
		var accessLevelSelect = $('select#vulns_access_level_select').find(':selected');
		var vjqTextareas = $('textarea', vnEditing);

		$.ajax({
			method: 'POST',
			url: '/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_vulns',
			data: {port: vjqInputs[0].value, severity: vjqInputs[1].value, cve: vjqInputs[2].value, cwe: vjqInputs[3].value, level_of_access: accessLevelSelect.val(), synopsis: vjqTextareas[0].value }
		}).done(function(data){
			saveVulnRow(voTable, vnEditing, data["id"], engId);
			$("#vulnsTabView tbody tr").each(function(index){
				//Adding pRelative class to td
				if(!$(this).children("td:nth-last-child(2)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(2)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(5)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(5)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(6)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(6)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(9)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(9)").addClass("pRelative");
				}
			})
		}).fail(function(data){
			alert( eval(data.responseText).join(', ') );
		});

		// Show the new link
		$('#new-vuln-link').removeClass('disabled');
	});

	// New row
	$('#new-vuln-link').click( function (e) {
		e.preventDefault();

		var aiNew = voTable.fnAddData( [ '', '', '', '', '', '', '', '',
		'[Edit]()', '[Delete]()' ] );
		var vnRow = voTable.fnGetNodes( aiNew[0] );
		editVulnRow( voTable, vnRow);
		vnEditing = vnRow;
				
		// Hide the new link
		$('#new-vuln-link').addClass('disabled');
	});

	// Cancel create row
	$('#vulnsTabView').on('click', 'a.cancel-vuln-link', function (e) {
		e.preventDefault();

		var vnRow = $(this).parents('tr')[0];
		voTable.fnDeleteRow( vnRow );
				
		// Show the new link
		$('#new-vuln-link').removeClass('disabled');
	});

	// Delete row
	$('#vulnsTabView').on('click', 'a.delete-vuln-link', function (e) {
		e.preventDefault();

		var vnRow = $(this).parents('tr')[0];
		var hostVulnId = $(this).attr("data-obj-id")
		$.ajax({
			url: '/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_vulns/'+hostVulnId,
			type: 'DELETE',
			success: function(){
				voTable.fnDeleteRow( vnRow );
			}
		})
	});

	// Save row
	function saveVulnRow ( voTable, vnEditing, vulnId, engId ){
		var vjqInputs = $('input', vnEditing);
		var vjqSelect = $('select#vulns_status_select').find(':selected');
		var accessLevelSelect = $('select#vulns_access_level_select').find(':selected');
		var vjqTextareas = $('textarea', vnEditing);

		voTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_vuln_'+vulnId+'_port" class="best_in_place" data-bip-value="'+vjqInputs[0].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_vulns/'+vulnId+'" data-bip-skip-blur="false" data-bip-original-content="'+vjqInputs[0].value+'" data-bip-object="host_vuln" data-bip-attribute="port" data-bip-type="input">'+vjqInputs[0].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', vnEditing, 0, false );
		voTable.fnUpdate( vjqInputs[1].value, vnEditing, 1, false );
		voTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_vuln_'+vulnId+'_vuln_name" class="best_in_place" data-bip-value="'+vjqInputs[2].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_vulns/'+vulnId+'" data-bip-skip-blur="false" data-bip-original-content="'+vjqInputs[2].value+'" data-bip-object="host_vuln" data-bip-attribute="vuln_name" data-bip-type="input">'+vjqInputs[2].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', vnEditing, 2, false)
		voTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_vuln_'+vulnId+'_aasm_state" class="best_in_place" data-bip-value="'+$(vjqSelect).val()+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_vulns/'+vulnId+'" data-bip-skip-blur="false" data-bip-original-content="'+$(vjqSelect).val()+'" data-bip-object="host_vuln" data-bip-collection="[[&quot;not_verified&quot;,&quot;Not Verified&quot;],[&quot;vulnerable&quot;,&quot;Vulnerable&quot;],[&quot;false_positive&quot;,&quot;False Positive&quot;]]" data-bip-attribute="_aasm_state" data-bip-type="select">'+$(vjqSelect).text()+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', vnEditing, 3, false );
		voTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_vuln_'+vulnId+'_synopsis" class="best_in_place" data-bip-value="'+vjqTextareas[0].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_vulns'+vulnId+'" data-bip-skip-blur="false" data-bip-original-content="'+vjqTextareas[0].value+'" data-bip-object="host_vuln" data-bip-attribute="syonpsis" data-bip-type="textarea">'+vjqTextareas[0].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', vnEditing, 4, false );
		voTable.fnUpdate( '<a href="/cves/'+vjqInputs[3].value+'" target="_blank">'+vjqInputs[3].value+'</a>', vnEditing, 5, false );
		voTable.fnUpdate( vjqInputs[4].value, vnEditing, 6, false );
		voTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_vuln_'+vulnId+'_level_of_access" class="best_in_place" data-bip-value="'+$(accessLevelSelect).val()+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_vulns/'+vulnId+'" data-bip-skip-blur="false" data-bip-original-content="'+$(accessLevelSelect).val()+'" data-bip-object="host_vuln" data-bip-collection="[[&quot;user&quot;,&quot;User&quot;],[&quot;system&quot;,&quot;System&quot;],[&quot;admin&quot;,&quot;Admin&quot;],[&quot;domain&quot;,&quot;Domain&quot;],[&quot;root&quot;,&quot;Root&quot;]]" data-bip-attribute="level_of_access" data-bip-type="select">'+$(accessLevelSelect).text()+'</span></span><i class="glyphicon glyphicon-pencil editIcon"></i>', vnEditing, 7, false);
		voTable.fnUpdate( '<a href="" class="delete-vuln-link" data-obj-id='+vulnId+' method="delete" >Delete</a>', vnEditing, 8, false );
		voTable.fnDraw();
	}

	// Edit row
	function editVulnRow ( voTable, vnRow ){
		var aData = voTable.fnGetData(vnRow);
		var jqTds = $('>td', vnRow);
		jqTds[0].innerHTML = '<input type="text" value="'+aData[0]+'">';
		jqTds[1].innerHTML = '<input type="text" value="'+aData[1]+'">';
		jqTds[2].innerHTML = '<input type="text" value="'+aData[2]+'">';
		jqTds[3].innerHTML = '<select id="vulns_status_select"><option value="not_verified">Not Verified</option><option value="vulnerable">Vulnerable</option><option value="false_positive">False Positive</option></select>';
		jqTds[4].innerHTML = '<textarea value="'+aData[4]+'"></textarea>';
		jqTds[5].innerHTML = '<input type="text" value="'+aData[5]+'">';
		jqTds[6].innerHTML = '<input type="text" value="'+aData[6]+'">';
		jqTds[7].innerHTML = '<select id="vulns_access_level_select"><option value="user">User</option><option value="system">System</option><option value="admin">Admin</option><option value="domain">Domain</option><option value="root">Root</option></select>'
		jqTds[8].innerHTML = '<a href="#" class="save-vuln-link">Save</a> <a href="javascript:void(0);" class="cancel-vuln-link">Cancel</a>';
		
		vnEditing = vnRow;
	}
	//Vulns Datatable end

	//Creds Datatable start
	var cnEditing = null;
	var coTable = $('#credsTabview').dataTable({
		"columnDefs": [{
			"targets": 4,
			"orderable": false
		}],
		responsive: true
	});

	$("#credsTabview").on('click', '.save-cred-link', function(e){
		e.preventDefault();

		var cjqInputs = $('input', cnEditing);
		var cjqTextareas = $('textarea', cnEditing);

		$.ajax({
			method: 'POST',
			url: '/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_creds',
			data: {ip: cjqInputs[0].value, pwdump: cjqTextareas[0].value, password: cjqInputs[1].value, description: cjqTextareas[1].value}
		}).done(function(data){
			saveCredRow(coTable, cnEditing, data["id"], engId);
			$("#credsTabview tbody tr").each(function(index){
				//Adding pRelative class to td
				if(!$(this).children("td:nth-last-child(2)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(2)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(3)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(3)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(4)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(4)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(5)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(5)").addClass("pRelative");
				}
			})
		}).fail(function(data){
			alert( eval(data.responseText).join(', ') );
		});

		// Show the new link
		$('#new-host-cred-link').removeClass('disabled');
	});

	// New row
	$('#new-host-cred-link').click( function (e) {
		e.preventDefault();

		var aiNew = coTable.fnAddData( [ '', '', '', '',
		'[Edit]()', '[Delete]()' ] );
		var cnRow = coTable.fnGetNodes( aiNew[0] );
		editCredRow( coTable, cnRow);
		cnEditing = cnRow;
				
		// Hide the new link
		$('#new-host-cred-link').addClass('disabled');
	});

	// Cancel create row
	$('#credsTabview').on('click', 'a.cancel-cred-link', function (e) {
		e.preventDefault();

		var cnRow = $(this).parents('tr')[0];
		coTable.fnDeleteRow( cnRow );
				
		// Show the new link
		$('#new-host-cred-link').removeClass('disabled');
	});

	// Delete row
	$('#credsTabview').on('click', 'a.delete-cred-link', function (e) {
		e.preventDefault();

		var cnRow = $(this).parents('tr')[0];
		var hostCredId = $(this).attr("data-obj-id")
		$.ajax({
			url: '/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_creds/'+hostCredId,
			type: 'DELETE',
			success: function(){
				coTable.fnDeleteRow( cnRow );
			}
		})
	});

	// Save row
	function saveCredRow ( coTable, cnEditing, credId, engId ){
		var cjqInputs = $('input', cnEditing);
		var cjqTextareas = $('textarea', cnEditing);
		coTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_vuln_'+credId+'_ip" class="best_in_place" data-bip-value="'+cjqInputs[0].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_creds/'+credId+'" data-bip-skip-blur="false" data-bip-original-content="'+cjqInputs[0].value+'" data-bip-object="host_cred" data-bip-attribute="cred" data-bip-type="input">'+cjqInputs[0].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cnEditing, 0, false );
		coTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_vuln_'+credId+'_pwdump" class="best_in_place" data-bip-value="'+cjqTextareas[0].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_creds/'+credId+'" data-bip-skip-blur="false" data-bip-original-content="'+cjqTextareas[0].value+'" data-bip-object="host_cred" data-bip-attribute="cred" data-bip-type="textarea">'+cjqTextareas[0].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cnEditing, 1, false );
		coTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_vuln_'+credId+'_password" class="best_in_place" data-bip-value="'+cjqInputs[1].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_creds/'+credId+'" data-bip-skip-blur="false" data-bip-original-content="'+cjqInputs[1].value+'" data-bip-object="host_cred" data-bip-attribute="cred" data-bip-type="input">'+cjqInputs[1].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cnEditing, 2, false );
		coTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_host_vuln_'+credId+'_description" class="best_in_place" data-bip-value="'+cjqTextareas[1].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/host_creds/'+credId+'" data-bip-skip-blur="false" data-bip-original-content="'+cjqTextareas[1].value+'" data-bip-object="host_cred" data-bip-attribute="cred" data-bip-type="textarea">'+cjqTextareas[1].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cnEditing, 3, false );
		coTable.fnUpdate( '<a href="javascript:void(0);" class="delete-cred-link" data-obj-id='+credId+' method="delete" >Delete</a>', cnEditing, 4, false );
		coTable.fnDraw();
	}

	// Edit row
	function editCredRow ( coTable, cnRow ){
		var aData = coTable.fnGetData(cnRow);
		var jqTds = $('>td', cnRow);
		jqTds[0].innerHTML = '<input type="text" value="'+aData[0]+'">';
		jqTds[1].innerHTML = '<textarea value="'+aData[1]+'"></textarea>';
		jqTds[2].innerHTML = '<input type="text" value="'+aData[2]+'">';
		jqTds[3].innerHTML = '<textarea value="'+aData[3]+'"></textarea>';
		jqTds[4].innerHTML = '<a href="javascript:void(0);" class="save-cred-link">Save</a> <a href="javascript:void(0);" class="cancel-cred-link">Cancel</a>';
		
		cnEditing = cnRow;
	}
	//Creds Datatable end

	//Custom Findings Datatable start
	var cfnEditing = null;
	var cfoTable = $('#customFindingsTabview').dataTable({
		"columnDefs": [{
			"targets": 6,
			"orderable": false
		}],
		responsive: true
	});
	$('#customFindingsTabview').on('click', '.save-custom-finding-link', function(e){
		e.preventDefault();

		var cfInputs = $('input', cfnEditing);
		var cfTextareas = $('textarea', cfnEditing);
		var cfSeveritySelect = $('select#custom_finding_severity_select').find(':selected');
		var cfAccesslevelSelect = $('select#custom_finding_access_select').find(':selected');

		$.ajax({
			method: 'POST',
			url: '/engagements/'+engId+'/engagement_mains/'+engMainId+'/custom_findings',
			data: {host: cfInputs[0].value, port: cfInputs[1].value, service: cfInputs[2].value, severity: cfSeveritySelect.val(), desc: cfTextareas[0].value, level_of_access: cfAccesslevelSelect.val()}
		}).done(function(data){
			saveCustomFindingRow(cfoTable, cfnEditing, data["id"], engId);
			$("#customFindingsTabview tbody tr").each(function(index){
				//Adding pRelative class to td
				if(!$(this).children("td:nth-last-child(2)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(2)").addClass("pRelative");
				}
				if(!$(this).children("td:nth-last-child(3)").hasClass("pRelative")){
					$(this).children("td:nth-last-child(3)").addClass("pRelative");
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
			})
		}).fail(function(data){
			alert( eval(data.responseText).join(', ') );
		});

		// Show the new link
		$('#new-custom-finding-link').removeClass('disabled');
	});

	// New row
	$('#new-custom-finding-link').click( function (e) {
		e.preventDefault();

		var aiNew = cfoTable.fnAddData( [ '', '', '', '', '', '',
		'[Edit]()', '[Delete]()' ] );
		var cfnRow = cfoTable.fnGetNodes( aiNew[0] );
		editCustomFindingRow( cfoTable, cfnRow);
		cfnEditing = cfnRow;
				
		// Hide the new link
		$('#new-custom-finding-link').addClass('disabled');
	});

	// Cancel create row
	$('#customFindingsTabview').on('click', 'a.cancel-custom-finding-link', function (e) {
		e.preventDefault();

		var cfnRow = $(this).parents('tr')[0];
		cfoTable.fnDeleteRow( cfnRow );
				
		// Show the new link
		$('#new-custom-finding-link').removeClass('disabled');
	});

	// Delete row
	$('#customFindingsTabview').on('click', 'a.delete-custom-finding-link', function (e) {
		e.preventDefault();

		var cfnRow = $(this).parents('tr')[0];
		var CustomFindingId = $(this).attr("data-obj-id")
		$.ajax({
			url: '/engagements/'+engId+'/engagement_mains/'+engMainId+'/custom_findings/'+CustomFindingId,
			type: 'DELETE',
			success: function(){
				cfoTable.fnDeleteRow( cfnRow );
			}
		})
	});

	// Save row
	function saveCustomFindingRow ( cfoTable, cfnEditing, customFindingId, engId ){
		var cfInputs = $('input', cfnEditing);
		var cfTextareas = $('textarea', cfnEditing);
		var cfSeveritySelect = $('select#custom_finding_severity_select').find(':selected');
		var cfAccesslevelSelect = $('select#custom_finding_access_select').find(':selected');
		cfoTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_custom_finding_'+customFindingId+'_host" class="best_in_place" data-bip-value="'+cfInputs[0].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/custom_findings/'+customFindingId+'" data-bip-skip-blur="false" data-bip-original-content="'+cfInputs[0].value+'" data-bip-object="custom_finding" data-bip-attribute="custom_finding" data-bip-type="input">'+cfInputs[0].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cfnEditing, 0, false );
		cfoTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_custom_finding_'+customFindingId+'_port" class="best_in_place" data-bip-value="'+cfInputs[1].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/custom_findings/'+customFindingId+'" data-bip-skip-blur="false" data-bip-original-content="'+cfInputs[1].value+'" data-bip-object="custom_finding" data-bip-attribute="custom_finding" data-bip-type="input">'+cfInputs[1].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cfnEditing, 1, false );
		cfoTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_custom_finding_'+customFindingId+'_service" class="best_in_place" data-bip-value="'+cfInputs[2].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/custom_findings/'+customFindingId+'" data-bip-skip-blur="false" data-bip-original-content="'+cfInputs[2].value+'" data-bip-object="custom_finding" data-bip-attribute="custom_finding" data-bip-type="input">'+cfInputs[2].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cfnEditing, 2, false );
		cfoTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_custom_finding_'+customFindingId+'_severity" class="best_in_place" data-bip-value="'+$(cfSeveritySelect).val()+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/custom_findings/'+customFindingId+'" data-bip-skip-blur="false" data-bip-original-content="'+$(cfSeveritySelect).val()+'" data-bip-object="custom_finding" data-bip-collection="[[&quot;0&quot;,&quot;Info&quot;],[&quot;1&quot;,&quot;Low&quot;],[&quot;2&quot;,&quot;Medium&quot;],[&quot;3&quot;,&quot;High&quot;],[&quot;4&quot;,&quot;Critical&quot;]]" data-bip-attribute="severity" data-bip-type="select">'+$(cfSeveritySelect).text()+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cfnEditing, 3, false)
		cfoTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_custom_finding_'+customFindingId+'_desc" class="best_in_place" data-bip-value="'+cfTextareas[0].value+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/custom_findings/'+customFindingId+'" data-bip-skip-blur="false" data-bip-original-content="'+cfTextareas[0].value+'" data-bip-object="custom_finding" data-bip-attribute="custom_finding" data-bip-type="textarea">'+cfTextareas[0].value+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cfnEditing, 4, false );
		cfoTable.fnUpdate( '<span class="pointer eHover"><span id="best_in_place_custom_finding_'+customFindingId+'_level_of_access" class="best_in_place" data-bip-value="'+$(cfAccesslevelSelect).val()+'" data-bip-url="/engagements/'+engId+'/engagement_mains/'+engMainId+'/custom_findings/'+customFindingId+'" data-bip-skip-blur="false" data-bip-original-content="'+$(cfAccesslevelSelect).val()+'" data-bip-object="custom_finding" data-bip-collection="[[&quot;user&quot;,&quot;User&quot;],[&quot;system&quot;,&quot;System&quot;],[&quot;admin&quot;,&quot;Admin&quot;],[&quot;domain&quot;,&quot;Domain&quot;],[&quot;root&quot;,&quot;Root&quot;]]" data-bip-attribute="level_of_access" data-bip-type="select">'+$(cfAccesslevelSelect).text()+'</span></span><i class="glyphicon glyphicon-pencil editIcon hide"></i>', cfnEditing, 5, false)
		cfoTable.fnUpdate( '<a href="javascript:void(0);" class="delete-cred-link" data-obj-id='+customFindingId+' method="delete" >Delete</a>', cnEditing, 6, false );
		cfoTable.fnDraw();
	}

	// Edit row
	function editCustomFindingRow ( cfoTable, cfnRow ){
		var aData = cfoTable.fnGetData(cfnRow);
		var jqTds = $('>td', cfnRow);
		jqTds[0].innerHTML = '<input type="text" value="'+aData[0]+'">';
		jqTds[1].innerHTML = '<input type="text" value="'+aData[1]+'">';
		jqTds[2].innerHTML = '<input type="text" value="'+aData[2]+'">';
		jqTds[3].innerHTML = '<select id="custom_finding_severity_select"><option value="0">Info</option><option value="1">Low</option><option value="2">Medium</option><option value="3">High</option><option value="4">Critical</option></select>';
		jqTds[4].innerHTML = '<textarea value="'+aData[3]+'"></textarea>';
		jqTds[5].innerHTML = '<select id="custom_finding_access_select"><option value="user">User</option><option value="system">System</option><option value="admin">Admin</option><option value="domain">Domain</option><option value="root">Root</option></select>'
		jqTds[6].innerHTML = '<a href="javascript:void(0);" class="save-custom-finding-link">Save</a> <a href="javascript:void(0);" class="cancel-custom-finding-link">Cancel</a>';
		
		cfnEditing = cfnRow;
	}
	//Custom Findings Datatable end

	$(".engagement_os").bind("ajax-success", function(){
		if($(this).text() == "Linux"){
			$(".os_image").children("i").removeClass();
			$(".os_image").children("i").addClass("fa fa-linux");
		}
		else if($(this).text() == "Windows"){
			$(".os_image").children("i").removeClass();
			$(".os_image").children("i").addClass("fa fa-windows");	
		}
		else if($(this).text() == "Mac"){
			$(".os_image").children("i").removeClass();
			$(".os_image").children("i").addClass("fa fa-apple");
		}
	})
})
