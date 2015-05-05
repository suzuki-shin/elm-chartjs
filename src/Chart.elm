module Chart (
               line
             , bar
             , radar
             , polarArea
             , pie
             , doughnut
             , addDataType1
             , addDataType2
             , Chart
             , DataType1
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
import Task exposing (Task)

type Chart = Chart

{-| Draw line chart and return Task.

    lineOn "chart1" { barShowStroke = True } data
-}
line : String -> a -> DataType1 -> Task error Chart
line id opts data = Native.Chart.line id (encodeDataType1 data) opts

{-| Draw bar chart.

    bar (attachOn "chart1") { barShowStroke = True } data
-}
bar : String -> a -> DataType1 -> Task error Chart
bar id opts data = Native.Chart.bar id (encodeDataType1 data) opts

{-| Draw radar chart.

    radar (attachOn "chart1") { pointDot = False, angleLineWidth = 1 } data
-}
radar : String -> a -> DataType1 -> Task error Chart
radar id opts data = Native.Chart.radar id (encodeDataType1 data) opts

{-| Draw polarArea chart.

    polarArea (attachOn "chart1") { scaleShowLine = True }data
-}
polarArea : String -> a -> DataType2 -> Task error Chart
polarArea id opts data = Native.Chart.polarArea id (encodeDataType2 data) opts

{-| Draw pie chart.

    pie (attachOn "chart1") {} data
-}
pie : String -> a -> DataType2 -> Task error Chart
pie id opts data = Native.Chart.pie id (encodeDataType2 data) opts

{-| Draw doughnut chart.

    doughnut (attachOn "chart1") {} data
-}
doughnut : String -> a -> DataType2 -> Task error Chart
doughnut id opts data = Native.Chart.doughnut id (encodeDataType2 data) opts

{-| Add data to Chart that type is Line, Bar and Radar.

    addDataType1 (line (attachOn "chart")) [10, 20] "newLabel"
-}
addDataType1 : List Int -> String -> Chart -> Chart
addDataType1 data label chart = Native.Chart.addData chart (encode 0 (list (L.map int data))) label

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

          encodeDataTypeset1 : DataTypeset1 -> Value
          encodeDataTypeset1 { fillColor, strokeColor, highlightFill, highlightStroke, data, mLabel }
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
       , ("datasets", list <| L.map encodeDataTypeset1 datasets)
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
    , datasets : List DataTypeset1
    }

type alias DataTypeset1 = {
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
