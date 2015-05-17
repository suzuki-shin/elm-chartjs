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

    function draw(chartType, id, data, options)
    {
        var f = function(chartType, id, e, data, options, chartOf, callback) {
            var chart = new Chart(e.getContext("2d"));
            switch (chartType) {
            case 'line':      chartOf[id] = chart.Line(JSON.parse(data), options); break;
            case 'bar':       chartOf[id] = chart.Bar(JSON.parse(data), options); break;
            case 'radar':     chartOf[id] = chart.Radar(JSON.parse(data), options); break;
            case 'polarArea': chartOf[id] = chart.PolarArea(JSON.parse(data), options); break;
            case 'pie':       chartOf[id] = chart.Pie(JSON.parse(data), options); break;
            case 'doughnut':  chartOf[id] = chart.Doughnut(JSON.parse(data), options); break;
            };
            return callback( Task.succeed(chartOf[id] ) );
        };

        return Task.asyncFunction(function(callback){
            if (chartOf[id]) return callback( Task.succeed(chartOf[id] ) );

            var e = document.getElementById(id)
            if (e) return f(chartType, id, e, data, options, chartOf, callback);

            var mo = new MutationObserver(function(ev){
                var e = document.getElementById(id)
                if (e) {
                    this.disconnect();
                    return f(chartType, id, e, data, options, chartOf, callback);
                }
            });
            mo.observe(document.body, {childList: true, subtree: true});
        });
    }

    function line(id, data, options)
    {
        return draw('line', id, data, options);
    }

    function bar(id, data, options)
    {
        return draw('bar', id, data, options);
    }

    function radar(id, data, options)
    {
        return draw('radar', id, data, options);
    }

    function polarArea(id, data, options)
    {
        return draw('polarArea', id, data, options);
    }

    function pie(id, data, options)
    {
        return draw('pie', id, data, options);
    }

    function doughnut(id, data, options)
    {
        return draw('doughnut', id, data, options);
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
        return Task.asyncFunction(function(callback){
            if (! data) return callback(Task.succeed(Utils.Tuple0));

            chart.addData(JSON.parse(data), label);

            return callback(Task.succeed(Utils.Tuple0));
        });
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
