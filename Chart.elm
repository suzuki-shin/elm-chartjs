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


{-| Represents the days of the week.
-}
-- type Day = Mon | Tue | Wed | Thu | Fri | Sat | Sun


{-| Represents the month of the year.
-}
-- type Month
--     = Jan | Feb | Mar | Apr
--     | May | Jun | Jul | Aug
--     | Sep | Oct | Nov | Dec


chart : String -> Chart
chart = Native.Chart.chart

bar : Chart -> List a -> Chart
bar = Native.Chart.bar

{-| Attempt to read a Chart from a string.
-}
-- fromString : String -> Result String Chart
-- fromString =
--   Native.Chart.read


{-| Convert a Chart into a time since midnight (UTC) of 1 January 1990 (i.e.
[UNIX time](http://en.wikipedia.org/wiki/Unix_time)). Given the Chart 23 June
1990 at 11:45AM this returns the corresponding time.
-}
-- toTime : Chart -> Time
-- toTime =
--   Native.Chart.toTime


{-| Take a UNIX time and convert it to a `Chart`.
-}
-- fromTime : Time -> Chart
-- fromTime =
--   Native.Chart.fromTime
