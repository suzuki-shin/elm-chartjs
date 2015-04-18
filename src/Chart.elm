module Chart ( chart, line, bar, radar, polarArea, pie, doughnut ) where

{-| Library for working with Charts. Email the mailing list if you encounter
issues with internationalization or locale formatting.

# Conversions
@docs fromString, toTime, fromTime

# Extractions
@docs year, month, Month, day, dayOfWeek, Day, hour, minute, second, millisecond

-}

import Native.Chart
type Chart = Chart

chart : String -> Chart
chart = Native.Chart.chart

line : Chart -> String -> String -> Chart
line = Native.Chart.line

bar : Chart -> String -> String -> Chart
bar = Native.Chart.bar

radar : Chart -> String -> String -> Chart
radar = Native.Chart.radar

polarArea : Chart -> String -> String -> Chart
polarArea = Native.Chart.polarArea

pie : Chart -> String -> String -> Chart
pie = Native.Chart.pie

doughnut : Chart -> String -> String -> Chart
doughnut = Native.Chart.doughnut