import Chart as C exposing (..)
import Graphics.Element exposing (show)
import Json.Encode exposing (..)

options2 = { bezierCurve = False , barShowStroke = True }

data2 : C.DataType2
data2 = [ {
          value = 300
        , color = "#F7464A"
        , highlight = "#FF5A5E"
        , label = "Red"
        },
          {
            value = 50
          , color = "#46BFBD"
          , highlight = "#5AD3D1"
          , label = "Green"
          },
          {
            value = 150
          , color = "#6BFBD0"
          , highlight = "#AD3D10"
          , label = "hgoe"
          },
          {
            value = 35
          , color = "#BFBD00"
          , highlight = "#D3D100"
          , label = "fuga"
          }
        ]

data3 : C.DataType1
data3 = {
      labels = ["January","February","March","April","May","June","July"],
      datasets = [
       {
         fillColor = "rgba(220,220,220,0.5)",
         strokeColor = "rgba(220,220,220,0.8)",
         highlightFill = "rgba(220,220,220,0.75)",
         highlightStroke = "rgba(220,220,220,1)",
         data = [30, 34, 67, 12, 96, 75, 39],
         mLabel = Nothing
       },
       {
         fillColor = "rgba(151,187,205,0.5)",
         strokeColor = "rgba(151,187,205,0.8)",
         highlightFill = "rgba(151,187,205,0.75)",
         highlightStroke = "rgba(151,187,205,1)",
         data = [20, 4, 87, 32, 46, 55, 38],
         mLabel = Just "xlabel"
       },
       {
         fillColor = "rgba(251,87,205,0.5)",
         strokeColor = "rgba(251,87,205,0.8)",
         highlightFill = "rgba(251,87,205,0.75)",
         highlightStroke = "rgba(251,87,205,1)",
         data = [42, 84, 7, 73, 26, 5, 8],
         mLabel = Just "xlabel"
       }
      ]
    }

main =
    let
--        d = C.polarArea (C.chart "canvas") data2 options2
       d = C.line (C.chart "canvas") options2 data3
    in show <| "hoge"
