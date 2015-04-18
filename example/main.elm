import Chart
import Text (plainText)
import Json.Encode (..)
import Debug

chrt = Chart.chart("canvas")

data = encode 0 <| object [
      ("labels", list [(string "January"),(string "February"),(string "March"),(string "April"),(string "May"),(string "June"),(string "July")]),
      ("datasets", list [ object [
         ("fillColor", string "rgba(220,220,220,0.5)"),
         ("strokeColor", string "rgba(220,220,220,0.8)"),
         ("highlightFill", string "rgba(220,220,220,0.75)"),
         ("highlightStroke", string "rgba(220,220,220,1)"),
         ("data", list [int 30, int 34, int  67, int 12, int 96, int 75, int 39])
       ],
       object [
         ("fillColor", string "rgba(151,187,205,0.5)"),
         ("strokeColor", string "rgba(151,187,205,0.8)"),
         ("highlightFill", string "rgba(151,187,205,0.75)"),
         ("highlightStroke", string "rgba(151,187,205,1)"),
         ("data", list [int 20, int 4, int 87,int 32, int 46, int 55,int 38])
       ]]
      )
    ]

options = encode 0 <| object [
             ("bezierCurve", bool False)
           , ("barShowStroke", bool False)
          ]
-- data = {
--       labels = ["January","February","March","April","May","June","July"],
--       datasets = [
--        {
--          fillColor = "rgba(220,220,220,0.5)",
--          strokeColor = "rgba(220,220,220,0.8)",
--          highlightFill = "rgba(220,220,220,0.75)",
--          highlightStroke = "rgba(220,220,220,1)",
--          data = [30, 34, 67, 12, 96, 75, 39]
--        },
--        {
--          fillColor = "rgba(151,187,205,0.5)",
--          strokeColor = "rgba(151,187,205,0.8)",
--          highlightFill = "rgba(151,187,205,0.75)",
--          highlightStroke = "rgba(151,187,205,1)",
--          data = [20, 4, 87, 32, 46, 55, 38]
--        }
--       ]
--     }

main =
    let b = Debug.log "data" data
        c = Chart.radar chrt b options
--         c = Chart.bar chrt b options
    in plainText <| "hoge"