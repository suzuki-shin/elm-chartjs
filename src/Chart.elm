module Chart ( chart, line, bar, radar, polarArea, pie, doughnut, LineChartData ) where

import Native.Chart
import Json.Encode (..)
import List as L
import List ((::))
import Debug

type Chart = Chart

chart : String -> Chart
chart = Native.Chart.chart

line : Chart -> LineChartData -> String -> Chart
line chart data options = Native.Chart.line chart (encodeLineChartData data) options

bar : Chart -> LineChartData -> String -> Chart
bar chart data options = Native.Chart.bar chart (encodeLineChartData data) options

radar : Chart -> LineChartData -> String -> Chart
radar chart data options = Native.Chart.radar chart (encodeLineChartData data) options

polarArea : Chart -> String -> String -> Chart
polarArea = Native.Chart.polarArea

pie : Chart -> String -> String -> Chart
pie = Native.Chart.pie

doughnut : Chart -> String -> String -> Chart
doughnut = Native.Chart.doughnut


encodeLabels : List String -> Value
encodeLabels = list << L.map string

encodeLineChartData : LineChartData -> String
encodeLineChartData { labels, datasets }
    = encode 0 <| object [
         ("labels", encodeLabels labels)
       , ("datasets", list <| L.map encodeLineChartDataset datasets)
      ]

encodeLineChartDataset : LineChartDataset -> Value
encodeLineChartDataset { fillColor, strokeColor, highlightFill, highlightStroke, data, mLabel }
    = let ds : List (String, Value)
          ds = [
            ("fillColor", string fillColor)
          , ("strokeColor", string strokeColor)
          , ("highlightFill", string highlightFill)
          , ("highlightStroke", string highlightStroke)
          , ("data", list <| L.map int data)
          ]
      in case mLabel of
           Just label -> object <| ("label", string label) :: ds
           Nothing -> object ds

type alias LineChartData = {
      labels : List String
    , datasets : List LineChartDataset
    }

type alias LineChartDataset = {
      fillColor : String
    , strokeColor : String
    , highlightFill : String
    , highlightStroke : String
    , data : List Int
    , mLabel : Maybe String
    }