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

//     function chart(id)
//     {
//         var e = document.getElementById(id).getContext("2d");
//         return new Chart(e);
//     }

    function attachOn(id)
    {
        var f = function(e, callback) {
            return callback(Task.succeed( new Chart(e.getContext("2d"))) );
        };

        return Task.asyncFunction(function(callback){
            var e = document.getElementById(id)
            if (e) {
                f(e, callback);
            } else {
                var mo = new MutationObserver(function(ev){
                    var e = document.getElementById(id)
                    if (e) {
                        f(e, callback);
                    }
                });
                mo.observe(document.body, {childList: true, subtree: true});
            }
        });
    }

    function line(chart, data, options)
    {
        return Task.asyncFunction(function(callback){
            return callback(Task.succeed( chart.Line(JSON.parse(data), options)) );
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

    function pie(chart, data, options)
    {
        return Task.asyncFunction(function(callback){
            return callback(Task.succeed( chart.Pie(JSON.parse(data), options)) );
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

    return localRuntime.Native.Chart.values = {
        attachOn : attachOn,
        line : F3(line),
        bar : F3(bar),
        radar : F3(radar),
        polarArea : F3(polarArea),
        pie : F3(pie),
        doughnut : F3(doughnut),
    };
};
