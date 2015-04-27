import Chart as C exposing (..)
import Graphics.Element exposing (show)
import Json.Encode exposing (..)
import Signal exposing ((<~), sampleOn)
import Mouse
import Html as H exposing (..)
import Html.Attributes as Attr exposing (..)
import Task exposing (Task, andThen)
import Debug

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

main =
    let
        a = "a"
--         c2 = C.bar (C.attachOn "barChart") {} data1 |> addDataType1 [100, 39] "Aug"
--         c4 = C.radar (C.attachOn "radarChart") {} data1
--         c3 = C.polarArea (C.attachOn "polarAreaChart") {} data2 |> addDataType2 datasetType2a (Just 2)
--         c5 = C.pie (C.attachOn "pieChart") {} data2 |> addDataType2 datasetType2a Nothing |> addDataType2 datasetType2b Nothing
--         c6 = C.doughnut (C.attachOn "doughnutChart") {} data2
    in H.canvas [Attr.id "line2", Attr.style [("width", "600"),("height", "450")]] []
--     in (\x -> C.line (C.attachOn "lineChart") { bezierCurve = True } (data1y x) |> update |> \_ -> show x) <~ sampleOn Mouse.isDown Mouse.x

t1 : Int -> Task error C.Chart
t1 y = C.lineOn "line2" {bezierCurve = False} (data1y (Debug.log "y" y))
-- t1 y = C.lineOn "line2" {bezierCurve = False} (data1y (Debug.log "y" y)) `andThen` C.update2

st1 : Signal (Task error C.Chart)
st1 = t1 <~ sampleOn Mouse.clicks Mouse.y

port drawLine2_ : Signal (Task error C.Chart)
port drawLine2_ = st1

port hoho : Signal (Task error C.Chart)
port hoho = st1
