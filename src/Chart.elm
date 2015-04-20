module Chart ( chart, line, bar, radar, polarArea, pie, doughnut, DataType1, DataType2 ) where

import Native.Chart
import Json.Encode (..)
import List as L
import List ((::))
import Debug

type Chart = Chart

chart : String -> Chart
chart = Native.Chart.chart

line : Chart -> DataType1 -> String -> Chart
line c d o = Native.Chart.line c (encodeDataType1 d) o

bar : Chart -> DataType1 -> String -> Chart
bar c d o = Native.Chart.bar c (encodeDataType1 d) o

radar : Chart -> DataType1 -> String -> Chart
radar c d o = Native.Chart.radar c (encodeDataType1 d) o

polarArea : Chart -> DataType2 -> String -> Chart
polarArea c d o = Native.Chart.polarArea c (encodeDataType2 d) o

pie : Chart -> DataType2 -> String -> Chart
pie c d o = Native.Chart.pie c (encodeDataType2 d) o

doughnut : Chart -> DataType2 -> String -> Chart
doughnut c d o = Native.Chart.doughnut c (encodeDataType2 d) o

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


-- data type for line chart, bar chart and radar chart
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

-- data type for polarArea chart, pie chart and doughnut chart
type alias DataType2 = List DatasetType2

type alias DatasetType2 = {
      value : Int
    , color : String
    , highlight : String
    , label : String
    }

encodeDataType2 : DataType2 -> String
encodeDataType2 =
    let encodeDatasetType2 : DatasetType2 -> Value
        encodeDatasetType2 { value, color, highlight, label }
            = object [
                ("value", int value)
              , ("color", string color)
              , ("highlight", string highlight)
              , ("label", string label)
              ]
    in encode 0 << list << L.map encodeDatasetType2

