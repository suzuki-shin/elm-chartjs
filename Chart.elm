module Chart ( chart, line, bar, radar ) where

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
