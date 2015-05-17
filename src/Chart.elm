module Chart (
               line
             , bar
             , radar
             , polarArea
             , pie
             , doughnut
             , updateLine
             , updateBar
             , updateRadar
             , updatePie
             , updateDoughnut
             , updatePolarArea
             , addDataType1
             , addDataType2
             , Chart
             , DataType1
             , DatasetType1
             , DataType2
             ) where

{-| This module is bindings for Chart.js

# Draw Chart
@docs line, bar, radar, polarArea, pie, doughnut

# Types of Chart Data
@docs DataType1, DataType2

-}

import Native.Chart exposing (..)
import Json.Encode exposing (..)
import List as L exposing (..)
import Signal exposing ((<~))
import Task exposing (Task)
import Debug

type ChartType = Line | Bar | Radar | PolarArea | Pie | Doughnut
type Chart = Chart

{-| Draw line chart.

    line (attachOn "chart1") { barShowStroke = True } data
-}
line : String -> a -> DataType1 -> Task String Chart
line id opts data = Native.Chart.line id (encodeDataType1 data) opts

{-| Draw bar chart.

    bar (attachOn "chart1") { barShowStroke = True } data
-}
bar : String -> a -> DataType1 -> Task String Chart
bar id opts data = Native.Chart.bar id (encodeDataType1 data) opts

{-| Draw radar chart.

    radar (attachOn "chart1") { pointDot = False, angleLineWidth = 1 } data
-}
radar : String -> a -> DataType1 -> Task String Chart
radar id opts data = Native.Chart.radar id (encodeDataType1 data) opts

{-| Draw polarArea chart.

    polarArea (attachOn "chart1") { scaleShowLine = True }data
-}
polarArea : String -> a -> DataType2 -> Task String Chart
polarArea id opts data = Native.Chart.polarArea id (encodeDataType2 data) opts

{-| Draw pie chart.

    pie (attachOn "chart1") {} data
-}
pie : String -> a -> DataType2 -> Task String Chart
pie id opts data = Native.Chart.pie id (encodeDataType2 data) opts

{-| Draw doughnut chart.

    doughnut (attachOn "chart1") {} data
-}
doughnut : String -> a -> DataType2 -> Chart
doughnut id opts data = Native.Chart.doughnut id (encodeDataType2 data) opts

{-| Re-render Chart.

    update chart
-}
updateLine : Chart -> (Int, Int) -> Int -> Task String ()
updateLine chart (datasetsIdx, pointsIdx) value = Native.Chart.updatePoint chart datasetsIdx pointsIdx value

updateRadar : Chart -> (Int, Int) -> Int -> Task String ()
updateRadar = updateLine

updateBar : Chart -> (Int, Int) -> Int -> Task String ()
updateBar chart (datasetsIdx, barsIdx) value = Native.Chart.updateBar chart datasetsIdx barsIdx value

updatePie : Chart -> Int -> Int -> Task String ()
updatePie chart segmentsIdx value = Native.Chart.updateSegment chart segmentsIdx value

updateDoughnut : Chart -> Int -> Int -> Task String ()
updateDoughnut = updatePie

updatePolarArea : Chart -> Int -> Int -> Task String ()
updatePolarArea = updatePie

{-| Add data to Chart that type is Line, Bar and Radar.

    addDataType1 (line (attachOn "chart")) [10, 20] "newLabel"
-}
addDataType1 : Chart -> List Int -> String -> Task String ()
addDataType1 chart data label = Native.Chart.addData chart (encode 0 (list (L.map int data))) label

{-| Add data to Chart that type is Polararea, Pie and Doughnut.

    addDataType2 (polarArea (attachOn "chart")) {value = 50, color = "#46BFBD", highlight = "#5AD3D1", label = "Green"}, Nothing
-}
addDataType2 : DatasetType2 -> Maybe Int -> Chart -> Chart
addDataType2 data mIdx chart = case mIdx of
    Just index -> Native.Chart.addData chart (encode 0 (encodeDatasetType2 data)) index
    Nothing -> Native.Chart.addData chart (encode 0 (encodeDatasetType2 data))

encodeDataType1 : DataType1 -> String
encodeDataType1 { labels, datasets }
    = let encodeLabels : List String -> Value
          encodeLabels = list << L.map string

          encodeDatasetType1 : DatasetType1 -> Value
          encodeDatasetType1 { fillColor, strokeColor, highlightFill, highlightStroke, data, mLabel }
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

      in encode 0 <| object [
         ("labels", encodeLabels labels)
       , ("datasets", list <| L.map encodeDatasetType1 datasets)
      ]

encodeDataType2 : DataType2 -> String
encodeDataType2 = encode 0 << list << L.map encodeDatasetType2

encodeDatasetType2 : DatasetType2 -> Value
encodeDatasetType2 { value, color, highlight, label }
    = object [
        ("value", int value)
      , ("color", string color)
      , ("highlight", string highlight)
      , ("label", string label)
      ]

{-| Data type for line chart, bar chart and radar chart

    -- example
    data : DataType1
    data = {
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
       }
      ]
    }
-}
type alias DataType1 = {
      labels : List String
    , datasets : List DatasetType1
    }

type alias DatasetType1 = {
      fillColor : String
    , strokeColor : String
    , highlightFill : String
    , highlightStroke : String
    , data : List Int
    , mLabel : Maybe String
    }

{-| Data type for polarArea chart, pie chart and doughnut chart

    -- example
    data : DataType2
    data = [
      {
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
      }
    ]
-}
type alias DataType2 = List DatasetType2

type alias DatasetType2 = {
      value : Int
    , color : String
    , highlight : String
    , label : String
    }
