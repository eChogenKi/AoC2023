$puzzle = Get-Content "C:\Users\eChog\OneDrive\Documents\AoC2023\day9.txt"
$total = 0
foreach ($line in $puzzle) {
    $row = $line -split ' '
    $array = @()
    $lastPos = @()
    while ($array[-1] -notlike "0") {
        $contain = for ($i = 0; $i -lt ($row.Count - 1); $i++) {
            ([int]$row[$i] - [int]$row[$i + 1]) * (-1)
        }
        $lastPos += @($row[-1])
        $array += $contain
        $row = $contain
    }
    $answer = 0
    $n = -1
    for ($i = 0; $i -lt $lastPos.Count; $i++) {
        [int]$answer = [int]$lastPos[$n] + $answer
        $n -= 1
    }
    $total += $answer
}
