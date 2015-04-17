module Chart ( chart, bar ) where

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

bar : Chart -> String -> String -> Chart
bar = Native.Chart.bar
