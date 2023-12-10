### Part 2 ###

$puzzle = Get-Content "C:\Users\eChog\OneDrive\Documents\AoC2023\day7.txt"


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

$collection = foreach ($set in $puzzle) {
    $cards,$bid = $set -split ' '
    $tempHash = @{}
    $cardMakeup = $cards -split '' | ? { $_ -ne ''}
    if ($cards -eq "JJJJJ") {
        
    } elseif ($cards -like "*J*") {
        $cardMakeup | ? { $_ -ne "J" } | % { $tempHash["$_"] += 1}
        $tempHash = $tempHash.GetEnumerator() | Sort-Object Value -Descending
        if ($tempHash.GetType().Name -eq "Hashtable") {
            $highestValue = ($tempHash.GetEnumerator() | ? { $_.Value -ge 1 } | Select-Object -First 1).Value
            $most = ($tempHash.GetEnumerator() | ? { $_.Value -eq $highestValue }).Name
            if ($most.Count -gt 1) {
                $most = Get-HighestCard -GroupCheck $most
            }
        } elseif ($tempHash.GetType().Name -eq "DictionaryEntry") {
            $most = $tempHash.Name
        }
        $cardMakeup = $cardMakeup -replace "J",$most
    }     
                
    $tempHash = @{}
    $cardMakeup -split '' | ? { $_ -ne ''} | % { $tempHash["$_"] += 1}
    
    [string]$handType = ($tempHash.GetEnumerator() | Sort-Object Value -Descending | select Value).Value -join ''
    $first = Get-JokerCardValue -Card ($cards[0])
    $second = Get-JokerCardValue -Card ($cards[1])
    $third = Get-JokerCardValue -Card ($cards[2])
    $fourth = Get-JokerCardValue -Card ($cards[3])
    $fifth = Get-JokerCardValue -Card ($cards[4])

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
        Cards   = $cards
        Makeup  = $cardMakeup
        Bid     = $bid
        Hand    = $h
        First   = $first
        Second  = $second
        Third   = $third
        Fourth  = $fourth
        Fifth   = $fifth
    }
}

$finalResult = $collection | Sort-Object Makeup, First, Second, Third, Fourth, Fifth

$rank = 1
$total = 0
foreach ($setup in $finalResult) {
    $total += ([int]$setup.Bid * [int]$rank)
    $rank += 1
}

# Total not right: 251903187
# 2: 250685668
# 3: 251510440
# 4: 251542229 | 5 minutes to test result...............