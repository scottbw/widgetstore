$(document).ready(function() {	
	
	var usageJSON = null;
	var usersJSON = null;
	var widgetID=$('#widgetID').text().trim();
	
	function plotGraph(m) {

		console.log("plot graph");
		console.log(m);
		console.log(m["points"].length);
		var usageData = [];
		var users = [];

		var min =0;
		var dataMax =0;
		for ( var i = 0; i < m["points"].length; i++) {
			usageData.push([ m["points"][i]["index"], m["points"][i]["count"] ]);
			if (m["points"][i]["count"]>dataMax) dataMax = m["points"][i]["count"];
		}
		dataMax = Math.ceil(dataMax *1.1); //provide 10% space
		
		var options = {
		        xaxis: { mode: "time", tickLength: 5, timeformat: "%y/%m/%d"},
		        selection: { mode: "x" },
		        series : {
					lines : {show : true},
					points : {show : true}
				},
				yaxis : {
					min : 0,
					max : dataMax
				}
		    };
		
		var plot = $.plot($("#placeholder"), [ {
			data: usageData,
			label : "Usage"
		} ], options);
		console.log("what");
	}

	function getData(mode){
		var widgetID=$('#widgetID').text().trim();
		$.ajax({
			type : "GET",
			data : "what="+ mode + "&wid=" + widgetID,
			url : "/wookie/webmenu/ajaxHandlers/getUsageStats.jsp?",
			dataType : 'json',
			beforeSend : function() {
	
			},
			success : function(m) {
				usageJSON = m;
				plotGraph(m);
			},
			error : function(m, n) {
	
			},
			complete : function() {
	
			}
		});
	}
	
	getData("LASTWEEK");
	
	$('#week-link').click(function(){getData("LASTWEEK");});
	$('#month-link').click(function(){getData("LASTMONTH");});
	$('#year-link').click(function(){getData("LASTYEAR");});

});