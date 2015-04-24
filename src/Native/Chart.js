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

    function addDataType1(chart, data, label)
    {
        chart.addData(JSON.parse(data), label);
        return chart;
    }

    function addDataType2(chart, data, index)
    {
        chart.addData(data, index);
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
        update : update,
        addDataType1 : F3(addDataType1),
        addDataType2 : F3(addDataType2),
    };

};
