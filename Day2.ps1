$puzzle = Get-Content "C:\Users\eChog\Documents\AoC2023\day2.txt"

$redTotal = 12
$greenTotal = 13
$blueTotal = 14
$total = 0
$p2Total = 0
foreach ($line in $puzzle) {
    $gameNumber = (($line -split " ",3)[1]) -replace ":",''
    $hash = @{}
    $n = 1
    $line = ($line -split ': ',2)[1]
    $sets = $line -split '; '
    foreach ($set in $sets) {
        $set = $set -split ', '
        foreach ($sub in $set) {
            $num,$col = $sub -split ' '
            $hash["$col"+"$n"] += [int]$num
        }
        $n += 1
    }

    $redCheck = ($hash.GetEnumerator() | ? { $_.Key -like "red*"}).Value | % { $_ -le $redTotal} | ? { $_ -eq $false }
    $greenCheck = ($hash.GetEnumerator() | ? { $_.Key -like "green*"}).Value | % { $_ -le $greenTotal} | ? { $_ -eq $false }
    $blueCheck = ($hash.GetEnumerator() | ? { $_.Key -like "blue*"}).Value | % { $_ -le $blueTotal} | ? { $_ -eq $false }

    if (($redCheck.Count -gt 0) -or ($greenCheck.Count -gt 0) -or ($blueCheck.Count -gt 0)) {
        
    } else {
        $total += $gameNumber
    }

    # Part 2
    $redLowest = ($hash.GetEnumerator() | ? { $_.Key -like "red*"}).Value | Sort-Object -Descending | select -First 1
    $greenLowest = ($hash.GetEnumerator() | ? { $_.Key -like "green*"}).Value | Sort-Object -Descending | select -First 1
    $blueLowest = ($hash.GetEnumerator() | ? { $_.Key -like "blue*"}).Value | Sort-Object -Descending | select -First 1

    $p2Total += ($redLowest * $greenLowest * $blueLowest)
}