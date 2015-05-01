module Chart ( line
             , bar
             , radar
             , polarArea
             , pie
             , doughnut
             , update
             , addDataType1
             , addDataType2
             , Chart
             , DataType1
             , DataType2
             , DatasetType1
             , DatasetType2
             ) where

{-| This module is bindings for Chart.js

# Draw Chart
@docs line, bar, radar, polarArea, pie, doughnut

# Types of Chart Data
@docs DataType1, DataType2, DatasetType1, DatasetType2

-}

import Native.Chart exposing (..)
import Json.Encode exposing (..)
import List as L exposing (..)
import Signal exposing ((<~))
import Debug

type Chart = Chart

{-| Draw line chart.

    -- new Chart(document.getElementById("chart1").getContext("2d")).Line(data, { barShowStroke = True });
    line "chart1" { barShowStroke = True } data
-}
line : String -> a -> DataType1 -> Signal Chart
line id opts data = Native.Chart.line id (encodeDataType1 data) opts

{-| Draw bar chart.

    -- new Chart(document.getElementById("chart1").getContext("2d")).Bar(data, { barShowStroke = True });
    bar "chart1" { barShowStroke = True } data
-}
bar : String -> a -> DataType1 -> Signal Chart
bar chart opts data = Native.Chart.bar chart (encodeDataType1 data) opts

{-| Draw radar chart.

    -- new Chart(document.getElementById("chart1").getContext("2d")).Radar(data, { pointDot = False, angleLineWidth = 1 });
    radar "chart1" { pointDot = False, angleLineWidth = 1 } data
-}
radar : String -> a -> DataType1 -> Signal Chart
radar chart opts data = Native.Chart.radar chart (encodeDataType1 data) opts

{-| Draw polarArea chart.

    -- new Chart(document.getElementById("chart1").getContext("2d")).PolarArea(data, { scaleShowLine = True });
    polarArea "chart1" { scaleShowLine = True } data
-}
polarArea : String -> a -> DataType2 -> Signal Chart
polarArea chart opts data = Native.Chart.polarArea chart (encodeDataType2 data) opts

{-| Draw pie chart.

    -- new Chart(document.getElementById("chart1").getContext("2d")).Pie(data, {});
    pie "chart1" {} data
-}
pie : String -> a -> DataType2 -> Signal Chart
pie chart opts data = Native.Chart.pie chart (encodeDataType2 data) opts

{-| Draw doughnut chart.

    -- new Chart(document.getElementById("chart1").getContext("2d")).Doughnut(data, {});
    doughnut "chart1" {} data
-}
doughnut : String -> a -> DataType2 -> Signal Chart
doughnut chart opts data = Native.Chart.doughnut chart (encodeDataType2 data) opts

{-| Re-render Chart.

    data x = {
      labels = ["January","February","March","April","May","June","July"],
      datasets = [
       {
         fillColor = "rgba(220,220,220,0.5)",
         strokeColor = "rgba(220,220,220,0.8)",
         highlightFill = "rgba(220,220,220,0.75)",
         highlightStroke = "rgba(220,220,220,1)",
         data = [30, 75, x],
         mLabel = Nothing
       },
      ]
    }
    (\x -> line "chart" {} (data x) |> update) <~ sampleOn Mouse.isDown Mouse.x
-}
update : a -> Signal Chart -> Signal Chart
update d sc = Native.Chart.update (Debug.log "d" d) <~ sc

{-| Add data to Chart that type is Line, Bar and Radar.

    (addDataType1 [100, 39] "August") <~ bar "chart" {} data
-}
addDataType1 : List Int -> String -> Chart -> Signal Chart
addDataType1 data label chart = Native.Chart.addData chart (encode 0 (list (L.map int data))) label

{-| Add data to Chart that type is Polararea, Pie and Doughnut.

    addDataType2 (polarArea "chart") {value = 50, color = "#46BFBD", highlight = "#5AD3D1", label = "Green"} Nothing
-}
addDataType2 : DatasetType2 -> Maybe Int -> Chart -> Signal Chart
addDataType2 data mIdx chart = case mIdx of
    Just index -> Native.Chart.addData chart (encode 0 (encodeDatasetType2 data)) index
    Nothing -> Native.Chart.addData chart (encode 0 (encodeDatasetType2 data))

{-| This is helper function that encode data for line, bar and radar function.
This function encode DataType1 data to JSON string.
-}
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

{-| This is helper function that encode data for polarArea, pie and doughnut function.
This function encode DataType2 data to JSON string.
-}
encodeDataType2 : DataType2 -> String
encodeDataType2 = encode 0 << list << L.map encodeDatasetType2

{-| This is helper function that encode DatasetType2 data to JSON Value.
-}
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

{-| Data type that "datasets" field of DataType1 data.
-}
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

{-| Data type that "datasets" field of DataType1 data.
-}
type alias DatasetType2 = {
      value : Int
    , color : String
    , highlight : String
    , label : String
    }
