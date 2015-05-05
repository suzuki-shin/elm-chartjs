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

    function line(id, data, options)
    {
        var f = function(e, data, options, callback) {
            return callback(Task.succeed( new Chart(e.getContext("2d")).Line(JSON.parse(data), options)) );
        };

        return Task.asyncFunction(function(callback){
            var e = document.getElementById(id)
            if (e) {
                f(e, data, options, callback);
            } else {
                var mo = new MutationObserver(function(ev){
                    var e = document.getElementById(id)
                    if (e) {
                        f(e, data, options, callback);
                    }
                });
                mo.observe(document.body, {childList: true, subtree: true});
            }
        });
    }

    function bar(id, data, options)
    {
        var f = function(e, data, options, callback) {
            return callback(Task.succeed( new Chart(e.getContext("2d")).Bar(JSON.parse(data), options)) );
        };

        return Task.asyncFunction(function(callback){
            var e = document.getElementById(id)
            if (e) {
                f(e, data, options, callback);
            } else {
                var mo = new MutationObserver(function(ev){
                    var e = document.getElementById(id)
                    if (e) {
                        f(e, data, options, callback);
                    }
                });
                mo.observe(document.body, {childList: true, subtree: true});
            }
        });
    }

    function radar(id, data, options)
    {
        var f = function(e, data, options, callback) {
            return callback(Task.succeed( new Chart(e.getContext("2d")).Radar(JSON.parse(data), options)) );
        };

        return Task.asyncFunction(function(callback){
            var e = document.getElementById(id)
            if (e) {
                f(e, data, options, callback);
            } else {
                var mo = new MutationObserver(function(ev){
                    var e = document.getElementById(id)
                    if (e) {
                        f(e, data, options, callback);
                    }
                });
                mo.observe(document.body, {childList: true, subtree: true});
            }
        });
    }

    function polarArea(id, data, options)
    {
        var f = function(e, data, options, callback) {
            return callback(Task.succeed( new Chart(e.getContext("2d")).PolarArea(JSON.parse(data), options)) );
        };

        return Task.asyncFunction(function(callback){
            var e = document.getElementById(id)
            if (e) {
                f(e, data, options, callback);
            } else {
                var mo = new MutationObserver(function(ev){
                    var e = document.getElementById(id)
                    if (e) {
                        f(e, data, options, callback);
                    }
                });
                mo.observe(document.body, {childList: true, subtree: true});
            }
        });
    }

    function pie(id, data, options)
    {
        var f = function(e, data, options, callback) {
            return callback(Task.succeed( new Chart(e.getContext("2d")).Pie(JSON.parse(data), options)) );
        };

        return Task.asyncFunction(function(callback){
            var e = document.getElementById(id)
            if (e) {
                f(e, data, options, callback);
            } else {
                var mo = new MutationObserver(function(ev){
                    var e = document.getElementById(id)
                    if (e) {
                        f(e, data, options, callback);
                    }
                });
                mo.observe(document.body, {childList: true, subtree: true});
            }
        });
    }

    function doughnut(id, data, options)
    {
        var f = function(e, data, options, callback) {
            return callback(Task.succeed( new Chart(e.getContext("2d")).Doughnut(JSON.parse(data), options)) );
        };

        return Task.asyncFunction(function(callback){
            var e = document.getElementById(id)
            if (e) {
                f(e, data, options, callback);
            } else {
                var mo = new MutationObserver(function(ev){
                    var e = document.getElementById(id)
                    if (e) {
                        f(e, data, options, callback);
                    }
                });
                mo.observe(document.body, {childList: true, subtree: true});
            }
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
        addData : F3(addData),
    };
};
