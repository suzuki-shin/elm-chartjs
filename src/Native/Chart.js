Elm.Native.Chart = {};
Elm.Native.Chart.make = function(localRuntime) {
    localRuntime.Native = localRuntime.Native || {};
    localRuntime.Native.Chart = localRuntime.Native.Chart || {};
    if (localRuntime.Native.Chart.values)
    {
        return localRuntime.Native.Chart.values;
    }

    var Task = Elm.Native.Task.make(localRuntime);
    var Result = Elm.Result.make(localRuntime);
    var Utils = Elm.Native.Utils.make(localRuntime);

    var chartOf = {};

    function chart(id)
    {
        var e = document.getElementById(id).getContext("2d");
        return new Chart(e);
    }

    function line(id, data, options)
    {
        return Task.asyncFunction(function(callback){

            var f = function(id, e) {
                var chart = new Chart(e.getContext("2d"));
                chartOf[id] = chart.Line(JSON.parse(data), options);
                return callback( Task.succeed(chartOf[id] ) );
            };

            if (chartOf[id]) return callback( Task.succeed(chartOf[id] ) );

            var e = document.getElementById(id)
            if (e) return f(id, e);

            var mo = new MutationObserver(function(ev){
                var e = document.getElementById(id)
                if (e) return f(id, e);
            });
            mo.observe(document.body, {childList: true, subtree: true});

        });
    }

    function bar(id, data, options)
    {
        return Task.asyncFunction(function(callback){
            if (! chartOf[id]) chartOf[id] = chart(id).Bar(JSON.parse(data), options);
            return callback( Task.succeed(chartOf[id] ) );
        });
    }

    function radar(id, data, options)
    {
        return Task.asyncFunction(function(callback){
            if (! chartOf[id]) chartOf[id] = chart(id).Radar(JSON.parse(data), options);
            return callback( Task.succeed(chartOf[id] ) );
        });
    }

    function polarArea(chart, data, options)
    {
        return chart.PolarArea(JSON.parse(data), options);
    }

    function pie(chart, data, options)
    {
        return chart.Pie(JSON.parse(data), options);
    }

    function doughnut(chart, data, options)
    {
        return chart.Doughnut(JSON.parse(data), options);
    }

    function updatePoint(chart, datasetsIdx, pointsIdx, value)
    {
        return Task.asyncFunction(function(callback){
            if (! value) return callback(Task.succeed(Utils.Tuple0));

            chart.datasets[datasetsIdx].points[pointsIdx].value = value;
            chart.update();

            return callback(Task.succeed(Utils.Tuple0));
        });
    }

    function updateBar(chart, datasetsIdx, barsIdx, value)
    {
        return Task.asyncFunction(function(callback){
            if (! value) return callback(Task.succeed(Utils.Tuple0));

            chart.datasets[datasetsIdx].bars[barsIdx].value = value;
            chart.update();

            return callback(Task.succeed(Utils.Tuple0));
        });
    }

    function updateSegment(chart, segmentsIdx, value)
    {
        return Task.asyncFunction(function(callback){
            if (! value) return callback(Task.succeed(Utils.Tuple0));

            chart.segments[segmentsIdx].value = value;
            chart.update();

            return callback(Task.succeed(Utils.Tuple0));
        });
    }

    function addData(chart, data, label)
    {
        chart.addData(JSON.parse(data), label);
        return chart;
    }

    return localRuntime.Native.Chart.values = {
        line : F3(line),
        bar : F3(bar),
        radar : F3(radar),
        polarArea : F3(polarArea),
        pie : F3(pie),
        doughnut : F3(doughnut),
        updatePoint : F4(updatePoint),
        updateBar : F4(updateBar),
        updateSegment : F3(updateSegment),
        addData : F3(addData),
    };

};
