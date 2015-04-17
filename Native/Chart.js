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

    function bar(chart, data)
    {
        chart.Bar(JSON.parse(data), { responsive : true });

        return chart;
    }

    return localRuntime.Native.Chart.values = {
        chart : chart,
        bar : F2(bar)
    };

};
