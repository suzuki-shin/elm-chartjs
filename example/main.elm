import Chart as C exposing (..)
import Graphics.Element exposing (show, flow, down)
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

main = H.div [] [
          H.canvas [Attr.id "lineChart", Attr.style [("width", "600px"),("height", "450px")]] []
        , H.canvas [Attr.id "barChart", Attr.style [("width", "600px"),("height", "450px")]] []
        , H.canvas [Attr.id "radarChart", Attr.style [("width", "600px"),("height", "450px")]] []
        , H.canvas [Attr.id "polarAreaChart", Attr.style [("width", "600px"),("height", "450px")]] []
        , H.canvas [Attr.id "pieChart", Attr.style [("width", "600px"),("height", "450px")]] []
        , H.canvas [Attr.id "doughnutChart", Attr.style [("width", "600px"),("height", "450px")]] []
       ]
--     in (\x -> C.line (C.attachOn "lineChart") { bezierCurve = True } (data1y x) |> update |> \_ -> show x) <~ sampleOn Mouse.isDown Mouse.x

t1 : Int -> Task error C.Chart
t1 y = C.bar "barChart" {bezierCurve = False} (data1y (Debug.log "y" y))

st1 : Signal (Task error C.Chart)
st1 = t1 <~ sampleOn Mouse.clicks Mouse.y

port drawLine : Signal (Task error C.Chart)
port drawLine = t1 <~ sampleOn Mouse.clicks Mouse.y

port drawChart2 : Task error C.Chart
port drawChart2 = C.attachOn "lineChart" `andThen` (C.line {} data1)

port drawChart2x : Signal (Task error C.Chart)
port drawChart2x = (\x -> C.attachOn "lineChart" `andThen` (C.line {} (data1y x))) <~ sampleOn Mouse.clicks Mouse.x

chartP : Int -> Task error C.Chart
chartP v = C.attachOn "pieChart" `andThen` (C.pie {} (hoge data2 v))

port drawChart3 : Signal (Task error C.Chart)
port drawChart3 = chartP <~ sampleOn Mouse.clicks Mouse.x
-- port drawChart3 = (\v -> C.attachOn "pieChart" `andThen` (C.pie {} (hoge data2 v))) <~ sampleOn Mouse.clicks Mouse.x

-- port add3 : Signal (Task error C.Chart)

hoge : C.DataType2 -> Int -> C.DataType2
hoge d v = {
            value = v
          , color = "#FBD000"
          , highlight = "#3D1000"
          , label = "xkjkfuga"
          } :: d