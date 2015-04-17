Elm.Native.Chart = {};
Elm.Native.Chart.make = function(localRuntime) {
	localRuntime.Native = localRuntime.Native || {};
	localRuntime.Native.Chart = localRuntime.Native.Chart || {};
	if (localRuntime.Native.Chart.values)
	{
		return localRuntime.Native.Chart.values;
	}

	var Result = Elm.Result.make(localRuntime);

    function chart(id)
    {
        var e = document.getElementById(id).getContext("2d");
        console.log(e);
        return new Chart(e);    // これが読めてないのかな？
//         return new Chart(document.getElementById(id));
    }

    function Bar(chart, data)
    {
        var e = document.getElementById('canvas').getContext("2d");
        var chart = new Chart(e);
        console.log(chart);
        var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
	    var data = {
	        labels : ["January","February","March","April","May","June","July"],
	        datasets : [
	            {
	                fillColor : "rgba(220,220,220,0.5)",
	                strokeColor : "rgba(220,220,220,0.8)",
	                highlightFill: "rgba(220,220,220,0.75)",
	                highlightStroke: "rgba(220,220,220,1)",
	                data : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
	            },
	            {
	                fillColor : "rgba(151,187,205,0.5)",
	                strokeColor : "rgba(151,187,205,0.8)",
	                highlightFill : "rgba(151,187,205,0.75)",
	                highlightStroke : "rgba(151,187,205,1)",
	                data : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
	            }
	        ]

	    };
        chart.Bar(data, { responsive : true });
//         new chart.Bar(data, { responsive : true });

        return chart;
    }

// 	function ChartNow()
// 	{
// 		return new window.Chart;
// 	}

// 	function readChart(str)
// 	{
// 		var Chart = new window.Chart(str);
// 		return isNaN(Chart.getTime())
// 			? Result.Err("unable to parse '" + str + "' as a Chart")
// 			: Result.Ok(Chart);
// 	}

// 	var dayTable = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
// 	var monthTable =
// 		["Jan", "Feb", "Mar", "Apr", "May", "Jun",
// 		 "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];


	return localRuntime.Native.Chart.values = {
//         getContext : getContext,
        chart : chart,
        bar : Bar
// 		read    : readChart,
// 		year    : function(d) { return d.getFullYear(); },
// 		month   : function(d) { return { ctor:monthTable[d.getMonth()] }; },
// 		day     : function(d) { return d.getChart(); },
// 		hour    : function(d) { return d.getHours(); },
// 		minute  : function(d) { return d.getMinutes(); },
// 		second  : function(d) { return d.getSeconds(); },
// 		millisecond: function (d) { return d.getMilliseconds(); },
// 		toTime  : function(d) { return d.getTime(); },
// 		fromTime: function(t) { return new window.Chart(t); },
// 		dayOfWeek : function(d) { return { ctor:dayTable[d.getDay()] }; }
	};

};
