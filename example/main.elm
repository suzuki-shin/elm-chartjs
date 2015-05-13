import Chart as C exposing (..)
import Graphics.Element exposing (show)
import Json.Encode exposing (..)
import Signal exposing ((<~), sampleOn, constant, map)
import Mouse
import Task exposing (Task, andThen)
-- import Debug

data1 : C.DataType1
data1 = {
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

data1y : Int -> C.DataType1
data1y x = {
      labels = ["January","February","March","April","May","June","July"],
      datasets = [
       {
         fillColor = "rgba(220,220,220,0.5)",
         strokeColor = "rgba(220,220,220,0.8)",
         highlightFill = "rgba(220,220,220,0.75)",
         highlightStroke = "rgba(220,220,220,1)",
         data = [30, 34, 67, 12, 96, 75, x],
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

-- data1yMouseX : Signal (List C.DatasetType1)
-- data1yMouseX = datasets1 <~ sampleOn Mouse.clicks Mouse.x

datasetType2a =
    {
      value = 135
    , color = "#FBD000"
    , highlight = "#3D1000"
    , label = "FUGA"
    }

datasetType2b =
    {
      value = 50
    , color = "#BD000F"
    , highlight = "#D1000F"
    , label = "HOGE"
    }


-- updateChart : List C.DatasetType1 -> ()
-- updateChart ds = C.update c1 (Debug.log "updateChart ds" ds)

-- c1 : C.Chart
-- c1 = C.line (C.attachOn "lineChart") {bezierCurve = True} data1

-- c2 : Signal C.Chart
-- c2 = C.line (C.attachOn "lineChart") {bezierCurve = True} <~ data1yMouseX

testX = map show Mouse.x

datasets1 : Int -> (List C.DatasetType1)
datasets1 x = [
       {
         fillColor = "rgba(220,220,220,0.5)",
         strokeColor = "rgba(220,220,220,0.8)",
         highlightFill = "rgba(220,220,220,0.75)",
         highlightStroke = "rgba(220,220,220,1)",
         data = [30, 34, 67, 12, 96, 75, x],
         mLabel = Nothing
       },
       {
         fillColor = "rgba(151,187,205,0.5)",
         strokeColor = "rgba(151,187,205,0.8)",
         highlightFill = "rgba(151,187,205,0.75)",
         highlightStroke = "rgba(151,187,205,1)",
         data = [20, 4, 87, 32, 46, 55, 38],
         mLabel = Just "xlabel"
       }
      ]

-- updateChart : List C.DatasetType1 -> ()
-- updateChart d = C.update c1 (Debug.log "updateChart datasets1 " d)

-- c1 = C.bar (C.attachOn "barChart") {} data1

c2 : Task String C.Chart
c2 = C.line "lineChart" {bezierCurve = False} data1

main = show "ho ho"

updateChart : C.Chart -> Int -> Task String ()
updateChart c n = C.update c (0, 2) n

port updateC2 : Signal (Task String ())
port updateC2 = (\x -> c2 `andThen` (\c -> updateChart c x)) <~ sampleOn Mouse.isDown Mouse.x
