Elm.Native.Chart = {};
Elm.Native.Chart.make = function(localRuntime) {
    localRuntime.Native = localRuntime.Native || {};
    localRuntime.Native.Chart = localRuntime.Native.Chart || {};
    if (localRuntime.Native.Chart.values)
    {
        return localRuntime.Native.Chart.values;
    }

    var Result = Elm.Result.make(localRuntime);
    var NS     = Elm.Native.Signal.make(localRuntime);

    function chart(id)
    {
        var e = document.getElementById(id)
        var ctx = e.getContext("2d");
        return new Chart(ctx);
    }

    function line(id, data, options)
    {
        return NS.constant(chart(id).Line(JSON.parse(data), options));
    }

    function bar(id, data, options)
    {
        return NS.constant(chart(id).Bar(JSON.parse(data), options));
    }

    function radar(id, data, options)
    {
        return NS.constant(chart(id).Radar(JSON.parse(data), options));
    }

    function polarArea(id, data, options)
    {
        return NS.constant(chart(id).PolarArea(JSON.parse(data), options));
    }

    function pie(id, data, options)
    {
        return NS.constant(chart(id).Pie(JSON.parse(data), options));
    }

    function doughnut(id, data, options)
    {
        return NS.constant(chart(id).Doughnut(JSON.parse(data), options));
    }

    function update(data, chart)
    {
console.log(chart);
        chart.data = data;
        chart.update();
        return NS.constant(chart);
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
        update : F2(update),
        addData : F3(addData),
    };

};
