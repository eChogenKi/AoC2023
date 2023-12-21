$puzzle = Get-Content "C:\Users\daniel.chaildin\Documents\WindowsPowerShell\AoC2023\Day3.txt"

$regex = '[^\w\s\.]'
$total = @()
foreach ($line in $puzzle) {
    $p = 0
    $CLN = $puzzle.IndexOf($line)
    
    $linearray = $line.ToCharArray()
    $lineCount = 0..($linearray.count - 1)

    foreach ($p in $lineCount) {
        if ($posArray -contains $p) {
            Continue
            } else {
            $posArray = @($p)
            
            if ($line[$p] -like '[0-9]') {
                if ($line[$p+1] -like '[0-9]') {
                    $posArray += ($p + 1)
                    if ($line[$p+2] -like '[0-9]') {
                        $posArray += ($p + 2)
                        $searchArray = @( ($p-1),$p,($p +1),($p+2),($p+3) )
                        if ($CLN -ne 0) {
                            $rowUp = $puzzle[$CLN - 1][$searchArray]
                        } else {
                            $rowUp = $null
                        }
                        if ($CLN -ne ($puzzle.Count - 1)) {
                            $rowDown = $puzzle[$CLN + 1][$searchArray]
                        } else {
                            $rowDown = $null
                        }
                        if ($p -eq 0) {
                            $left = $null
                        } else {
                            $left = $linearray[$p - 1]
                        }
                        if ($p -eq ($lineCount[-1])) {
                            $right = $null
                        } else {
                            $right = $linearray[$p + 3]
                        }
                        $searchRow = (([string]$rowUp + $rowDown + $left + $right) -join '') -replace ' ',''
                    } else {
                        # 2 digit number
                        $searchArray = @( ($p-1),$p,($p +1),($p+2) )
                        if ($CLN -ne 0) {
                            $rowUp = $puzzle[$CLN - 1][$searchArray]
                        } else {
                            $rowUp = $null
                        }
                        if ($CLN -ne ($puzzle.Count - 1)) {
                            $rowDown = $puzzle[$CLN + 1][$searchArray]
                        } else {
                            $rowDown = $null
                        }
                        if ($p -eq 0) {
                            $left = $null
                        } else {
                            $left = $linearray[$p - 1]
                        }
                        if ($p -eq ($lineCount[-1])) {
                            $right = $null
                        } else {
                            $right = $linearray[$p + 2]
                        }
                        $searchRow = (([string]$rowUp + $rowDown + $left + $right) -join '') -replace ' ',''
                    }
                } else {
                    # 1 digit number
                    $searchArray = @( ($p-1),$p,($p +1) )
                    if ($CLN -ne 0) {
                        $rowUp = $puzzle[$CLN - 1][$searchArray]
                    } else {
                        $rowUp = $null
                    }
                    if ($CLN -ne ($puzzle.Count - 1)) {
                        $rowDown = $puzzle[$CLN + 1][$searchArray]
                    } else {
                        $rowDown = $null
                    }
                    if ($p -eq 0) {
                        $left = $null
                    } else {
                        $left = $linearray[$p - 1]
                    }
                    if ($p -eq ($lineCount[-1])) {
                        $right = $null
                    } else {
                        $right = $linearray[$p + 1]
                    }
                    $searchRow = (([string]$rowUp + $rowDown + $left + $right) -join '') -replace ' ',''
            }

            if ($searchRow -match $regex) {
                $total += [int]($linearray[$posArray] -join '')
            }
            $p += 1
            
        }

        
        }
    }
    ($total | Measure-Object -Sum).Sum
}