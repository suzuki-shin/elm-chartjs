Elm.Native.Chart = {};
Elm.Native.Chart.make = function(localRuntime) {
    localRuntime.Native = localRuntime.Native || {};
    localRuntime.Native.Chart = localRuntime.Native.Chart || {};
    if (localRuntime.Native.Chart.values)
    {
        return localRuntime.Native.Chart.values;
    }

    var Result = Elm.Result.make(localRuntime);
    var Task = Elm.Native.Task.make(localRuntime);

    function chart(id)
    {
        var e = document.getElementById(id).getContext("2d");
        return new Chart(e);
    }

    function lineOn(id, data, options)
    {
        console.log('line2');
        console.log(id);

        return Task.asyncFunction(function(callback){
            var e = document.getElementById(id)
            if (e) {
                var c = new Chart(e.getContext("2d"));
                var lc = c.Line(JSON.parse(data), options);
                callback(Task.succeed(lc));
            } else {

                var mo = new MutationObserver(function(ev){
                    var e = document.getElementById(id)
                    if (e) {
                        var c = new Chart(e.getContext("2d"));
                        var lc = c.Line(JSON.parse(data), options);
                        callback(Task.succeed(lc));
                    }
                });
                mo.observe(document.body, {childList: true, subtree: true});
            }
        });
    }

//     function lineOn(id, data, options)
//     {
//         console.log(id);
//         console.log(data);
//         console.log(options);
//         var mo = new MutationObserver(function(mutation){
//             console.log(mutation);
//             var e = document.getElementById(id);
//             if (e) {
//                 var chartObj = new Chart(e.getContext("2d"));
//                 return chartObj.Line(JSON.parse(data), options);
//             }
//             console.log(e);
//         });
//         mo.observe(document.body, {attributes: true, childList: true});
//     }

    function line(chartObj, data, options)
    {
        return chartObj.Line(JSON.parse(data), options);
    }

    function bar(chartObj, data, options)
    {
        return chartObj.Bar(JSON.parse(data), options);
    }

    function radar(chartObj, data, options)
    {
        return chartObj.Radar(JSON.parse(data), options);
    }

    function polarArea(chartObj, data, options)
    {
        return chartObj.PolarArea(JSON.parse(data), options);
    }

    function pie(chartObj, data, options)
    {
        return chartObj.Pie(JSON.parse(data), options);
    }

    function doughnut(chartObj, data, options)
    {
        return chartObj.Doughnut(JSON.parse(data), options);
    }

    function update(chart)
    {
        chart.update();
        return chart;
    }

    function update2(chart)
    {
        console.log('update2');
        console.log(chart);
        return Task.asyncFunction(function(callback) {
            chart.update();
            return callback(Task.succeed(chart));
        });
    }

    function addData(chart, data, label)
    {
        chart.addData(JSON.parse(data), label);
        return chart;
    }

    return localRuntime.Native.Chart.values = {
        chart : chart,
        line : F3(line),
        lineOn : F3(lineOn),
        bar : F3(bar),
        radar : F3(radar),
        polarArea : F3(polarArea),
        pie : F3(pie),
        doughnut : F3(doughnut),
        update : update,
        update2 : update2,
        addData : F3(addData),
    };
};
