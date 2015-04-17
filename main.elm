import Chart
import Text (plainText)
import Debug

chrt = Chart.chart("canvas")

main =
    let a = Debug.log "chart" chrt
        b = Chart.bar chrt []
    in plainText <| "hoge"