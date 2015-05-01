import Chart as C exposing (..)
import Graphics.Element exposing (show)
import Json.Encode exposing (..)
import Signal exposing ((<~), (~), sampleOn)
import Mouse
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

data1' : C.DataType1
data1' = {
      labels = ["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY"],
      datasets = [
       {
         fillColor = "rgba(120,220,220,0.5)",
         strokeColor = "rgba(120,220,220,0.8)",
         highlightFill = "rgba(120,220,220,0.75)",
         highlightStroke = "rgba(120,220,220,1)",
         data = [15, 34, 34, 12, 96, 75, 39],
         mLabel = Nothing
       },
       {
         fillColor = "rgba(51,187,205,0.5)",
         strokeColor = "rgba(51,187,205,0.8)",
         highlightFill = "rgba(51,187,205,0.75)",
         highlightStroke = "rgba(51,187,205,1)",
         data = [20, 4, 87, 32, 23, 28, 19],
         mLabel = Just "xlabel"
       },
       {
         fillColor = "rgba(51,87,205,0.5)",
         strokeColor = "rgba(51,87,205,0.8)",
         highlightFill = "rgba(51,87,205,0.75)",
         highlightStroke = "rgba(51,87,205,1)",
         data = [42, 184, 7, 173, 26, 15, 8],
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

data1y : Int -> DataType1
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

main = (\_ -> c2 <~ sc2)
--      |> (\_ -> c3 <~ C.polarArea "polarAreaChart" {} data2)
--      |> (\_ -> c5 <~ (C.pie "pieChart" {} data2))
     |> (\_ -> show "hoge")

-- dataSig : Signal DataType1
-- dataSig = (\x -> data1y (Debug.log "x" x)) <~ Mouse.x

-- hoge : Signal (Signal C.Chart)
-- hoge = C.update <~ dataSig ~ sc2

sc2 : Signal C.Chart
sc2 = C.bar "barChart" {} (Debug.log "data1" data1)
c2 : C.Chart -> Signal C.Chart
c2 c = addDataType1 [76, 100, 39] "Aug" (Debug.log "c" c) -- ここに入らない。C.barのNS.constantがいかんのかなあ
-- c4 : Signal C.Chart
-- c4 = C.radar "radarChart" {} data1
c3: C.Chart -> Signal C.Chart
c3 = (addDataType2 datasetType2a (Just 2))
c5 : C.Chart -> Signal C.Chart
c5 = (addDataType2 datasetType2b Nothing)
-- c6 : Signal C.Chart
-- c6 = C.doughnut "doughnutChart" {} data2

-- main = C.line "lineChart" {} data1'
--      |> C.update data1
--      |> \_ -> show "hoge"
