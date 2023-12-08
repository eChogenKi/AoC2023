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

### Part 2 ###

function Get-JokerCardValue {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Card
    )
    
    switch ($Card) {
        'A' { 14 }
        'K' { 13 }
        'Q' { 12 }
        'J' { 1 }
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

function Get-HighestCard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [array]$GroupCheck
    )

    if ($GroupCheck -contains 'A') {
        return "A"
        Break
    }
    if ($GroupCheck -contains 'K') {
        return "K"
        Break
    }
    if ($GroupCheck -contains 'Q') {
        return "Q"
        Break
    }
    if ($GroupCheck -contains 'T') {
        return "T"
        Break
    }
    if ($GroupCheck -contains 9) {
        return 9
        Break
    }
    if ($GroupCheck -contains 8) {
        return 8
        Break
    }
    if ($GroupCheck -contains 7) {
        return 7
        Break
    }
    if ($GroupCheck -contains 6) {
        return 6
        Break
    }
    if ($GroupCheck -contains 5) {
        return 5
        Break
    }
    if ($GroupCheck -contains 4) {
        return 4
        Break
    }
    if ($GroupCheck -contains 3) {
        return 3
        Break
    }
    if ($GroupCheck -contains 2) {
        return 2
        Break
    }

}

$collection = foreach ($set in $hash.GetEnumerator()) {
    $tempHash = @{}
    $cardMakeup = $set.Key -split '' | ? { $_ -ne ''}
    if ($set.Key -like "*J*") {
        $cardMakeup | ? { $_ -ne "J" } | % { $tempHash["$_"] += 1}
        $tempHash = $tempHash.GetEnumerator() | Sort-Object Value -Descending
        try {
            $most = ((($tempHash.Keys) -split '') | ? { $_ -notlike '' })[0]
        } catch {
            $most = ((($tempHash.Key) -split '') | ? { $_ -notlike '' })
        }
        if ($most.Count -gt 1) {
            $most = Get-HighestCard -GroupCheck $most
        }
        $cardMakeup = $cardMakeup -replace "J",$most
                
    }
    $tempHash = @{}
    $cardMakeup -split '' | ? { $_ -ne ''} | % { $tempHash["$_"] += 1}
    
    [string]$handType = ($tempHash.GetEnumerator() | Sort-Object Value -Descending | select Value).Value -join ''
    $first = Get-JokerCardValue -Card ($set.Key[0])
    $second = Get-JokerCardValue -Card ($set.Key[1])
    $third = Get-JokerCardValue -Card ($set.Key[2])
    $fourth = Get-JokerCardValue -Card ($set.Key[3])
    $fifth = Get-JokerCardValue -Card ($set.Key[4])

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
        Makeup  = $cardMakeup
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