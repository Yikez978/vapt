var vapt = angular.module('vapt', []);

vapt.value('CONFIG', {
	'METALMAN_SENDER_TYPE' : "VAPT",
	'METALMAN_USER_NAME' : "VAPT"
});

vapt.controller('OcbCtrl', function ($scope, $compile, $http) {
	$scope.messages_header = '';
	// $scope.master = {};
	$scope.engagement_id = 0;
	tmp_ocb_count = 0;
	
	$scope.addNewOcbBtnClick = function(engagement_id){
		$scope.engagement_id = engagement_id;
		tmp_ocb_count = tmp_ocb_count + 1;
		
		$scope.messages_header = 'Adding new OCB detail..'
		console.log("appending new ocb form block.")
		var remove_btn = '<span class="pLeft10 glyphicon glyphicon-minus-sign" aria-hidden="true" ng-click="removeOcbBtnClick($event)"></span>'
		var html = '<form novalidate>\
		<div class="row ocb-form-block">\
			<div class="col-md-3"></div>\
			<div class="col-md-4 col-xs-4"><input ng-model="ocb_'+tmp_ocb_count+'.number" type="text" name="ocb[number]" id="ocb_number" placeholder="OCB Number"></div>\
			<div class="col-md-3 col-xs-5"><input type="text" ng-model="ocb_'+tmp_ocb_count+'.start_date" data-date-format="yyyy-mm-dd" data-provide="datepicker" id="datepicker_ocb_start_date" name="start date"></div>\
			<div class="col-md-2 col-xs-3"><input type="submit" name="commit" value="save" ng-click="saveOcbDetail($event, ocb_'+tmp_ocb_count+', '+$scope.engagement_id+', null)">'+remove_btn+'</div>\
		</div>\
		</form>';
			
		var temp_html = $compile(html)($scope);
		
	    $('.ocb-form-blocks').append(temp_html);
	};
	
	$scope.removeOcbBtnClick = function($event){
		$event.target.parentElement.parentElement.remove();
	};
	
	$scope.saveOcbDetail = function($event, ocb, engagement_id, ocb_id){
		$scope.messages_header = 'Saving OCB detail..';
		if (ocb == undefined) {
			$scope.messages_header = 'OCB Number & Start Date can\'t be blank.'
		} else if (!ocb.number && (ocb_id == null)) {
		    $scope.messages_header = 'OCB Number can\'t be blank.'
		} else if (!ocb.start_date) {
		    $scope.messages_header = 'OCB Start Date can\'t be blank.'
		} else {
			$http({
				method: 'POST',
				url: (ocb_id ? '/engagements/'+engagement_id+'/ocbs?id='+ocb_id : '/engagements/'+engagement_id+'/ocbs'),
				data: ocb
			}).then(function successCallback(response) {
				// After data saved
				$($event.target.parentElement.parentElement).children('div').eq(1).html('<span>'+response.data.number+'</span>');
				$($event.target).next().remove();
				
				console.log(response);
				$scope.messages_header = 'Saved OCB detail.'
			}, function errorCallback(response) {
				console.log(response);
				$scope.messages_header = 'Failed to save OCB detail.'
			});	
		}
		
	};
});
