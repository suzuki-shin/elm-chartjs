import Chart as C exposing (..)
import Graphics.Element exposing (show)
import Json.Encode exposing (..)
import Signal exposing ((<~), sampleOn, constant, map)
import Mouse
import Keyboard
import List as L exposing (sum)
import Task exposing (Task, andThen)
import Html as H exposing (..)
import Html.Attributes as Attr exposing (..)
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

c1 : Task String C.Chart
c1 = C.line "lineChart2" {bezierCurve = False} data1

c2 : Task String C.Chart
c2 = C.bar "barChart" {} data1

c3 : Task String C.Chart
c3 = C.radar "radarChart" {} data1


main = H.div [] [
          H.canvas [Attr.id "lineChart2", Attr.style [("width", "600px"),("height", "450px")]] []
       ]

port updateC1 : Signal (Task String ())
port updateC1 = (\x -> c1 `andThen` (\c -> C.updateLine c (0, 2) (x + 5))) <~ sampleOn Mouse.isDown Mouse.x

port updateC2 : Signal (Task String ())
port updateC2 = (\x -> c2 `andThen` (\c -> C.updateBar c (0, 2) x)) <~ sampleOn Mouse.isDown Mouse.x

-- port updateC3 : Task String C.Chart
-- port updateC3 = c3
port updateC3 : Signal (Task String ())
port updateC3 = (\x -> c3 `andThen` (\c -> C.updateRadar c (0, 2) x)) <~ sampleOn Mouse.isDown Mouse.x


-- port addDataToLine : Signal (Task String ())
-- port addDataToLine = (\v -> c2 `andThen` (\c -> C.addDataType1 c [v, v + 100, 2 * v] "XXX")) <~ Keyboard.presses
