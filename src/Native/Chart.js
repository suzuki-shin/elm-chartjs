Elm.Native.Chart = {};
Elm.Native.Chart.make = function(localRuntime) {
    localRuntime.Native = localRuntime.Native || {};
    localRuntime.Native.Chart = localRuntime.Native.Chart || {};
    if (localRuntime.Native.Chart.values)
    {
        return localRuntime.Native.Chart.values;
    }

    var Result = Elm.Result.make(localRuntime);

    var chartOf = {};

    function chart(id)
    {
        var e = document.getElementById(id).getContext("2d");
        return new Chart(e);
    }


    function line2(id, options, data)
    {
        var e = document.getElementById(id).getContext("2d");
        var dataJson = JSON.parse(data);
        if (! chartOf[id]) {
            var c = new Chart(e);
            var chart = c.Line(dataJson, options);
            chartOf[id] = chart;
            return chart;
        }

        var len1 = dataJson['datasets'].length;
        for (var i = 0; i < len1; i++) {
            var len2 = dataJson['datasets'][i].data.length;
            for (var j = 0; j < len2; j++) {
                chartOf[id].datasets[i].points[j].value = dataJson['datasets'][i].data[j];
            }
        }

        chartOf[id].update();

        return chartOf[id];
    }

    function draw(chart, options, data)
    {
        switch (chart.__chartType) {
        case 'line': return chart.Line(JSON.parse(data), options);
        default: console.log('draw default');
        }
    }

    function line(chart, data, options)
    {
console.log('function line');
console.log('chart');
console.log(chart);
console.log('data');
console.log(data);

        if (! chart.__data) {
            var c = chart.Line(JSON.parse(data), options);

 console.log('c');
 console.log(c);

            return c;
        }

        if (chart.__data['datasets'] === data['datasets']) {
            return chart;
        }

        chart.__data = JSON.parse(data);

console.log('chart 2');
console.log(chart);

        chart.datasets = data['datasets'];
        chart.update();

        return chart;

//         return chart.Line(JSON.parse(data), options);
    }

    function bar(chart, data, options)
    {
        return chart.Bar(JSON.parse(data), options);
    }

    function radar(chart, data, options)
    {
        return chart.Radar(JSON.parse(data), options);
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

    function update(chart, datasetsIdx, pointsIdx, value)
    {

console.log('update');
console.log(chart);
console.log(datasetsIdx);
console.log(pointsIdx);
console.log(value);

        chart.datasets[datasetsIdx].points[pointsIdx].value = value;
        chart.update();
    }

    function addData(chart, data, label)
    {
        chart.addData(JSON.parse(data), label);
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
        update : F4(update),
        addData : F3(addData),
        line2 : F3(line2),
    };

};
