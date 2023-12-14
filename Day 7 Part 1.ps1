$puzzle = Get-Content "C:\Users\eChog\OneDrive\Documents\AoC2023\day7.txt"

$hash = @{}
$cardRanks = @{}

function Get-CardValue {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Card
    )
    
    switch ($Card) {
        'A' { 14 }
        'K' { 13 }
        'Q' { 12 }
        'J' { 11 }
        'T' { 10 }
        '9' { 9 }
        '8' { 8 }
        '7' { 7 }
        '6' { 6 }
        '5' { 5 }
        '4' { 4 }
        '3' { 3 }
        '2' { 2 }
    }

}

foreach ($line in $puzzle) {
    $cards,$rank = $line -split ' '
    $hash += @{$cards = $rank}
}

$collection = foreach ($set in $hash.GetEnumerator()) {
    $tempHash = @{}
    $set.Key -split '' | ? { $_ -ne ''} | % { $tempHash["$_"] += 1}
    $handType = ($tempHash.GetEnumerator() | Sort-Object Value -Descending | select Value).Value -join ''
    $first = Get-CardValue -Card ($set.Key[0])
    $second = Get-CardValue -Card ($set.Key[1])
    $third = Get-CardValue -Card ($set.Key[2])
    $fourth = Get-CardValue -Card ($set.Key[3])
    $fifth = Get-CardValue -Card ($set.Key[4])

    switch ($handType) {
        11111   { $h = 1 }
        2111    { $h = 2 }
        221     { $h = 3 }
        311     { $h = 4 }
        32      { $h = 5 }
        41      { $h = 6 }
        5       { $h = 7 }
    }

    [PSCustomObject]@{
        Cards   = $set.Key
        Bid     = $set.Value
        Hand    = $h
        First   = $first
        Second  = $second
        Third   = $third
        Fourth  = $fourth
        Fifth   = $fifth
    }
}

$finalResult = $collection | Sort-Object Hand, First, Second, Third, Fourth, Fifth

$rank = 1
$total = 0
foreach ($setup in $finalResult) {
    $total += ([int]$setup.Bid * [int]$rank)
    $rank += 1
}
