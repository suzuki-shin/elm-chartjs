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
        return new Chart(e);
    }

    function line(chart, data, options)
    {
        chart.Line(JSON.parse(data), options);
        return chart;
    }

    function bar(chart, data, options)
    {
        chart.Bar(JSON.parse(data), options);
        return chart;
    }

    function radar(chart, data, options)
    {
        chart.Radar(JSON.parse(data), options);
        return chart;
    }

    function polarArea(chart, data, options)
    {
        chart.PolarArea(JSON.parse(data), options);
        return chart;
    }

    function pie(chart, data, options)
    {
        chart.Pie(JSON.parse(data), options);
        return chart;
    }

    function doughnut(chart, data, options)
    {
        chart.Doughnut(JSON.parse(data), options);
        return chart;
    }

    return localRuntime.Native.Chart.values = {
        chart : chart,
        line : F3(line),
        bar : F3(bar),
        radar : F3(radar),
        polarArea : F3(polarArea),
        pie : F3(pie),
        doughnut : F3(doughnut),
    };

};
