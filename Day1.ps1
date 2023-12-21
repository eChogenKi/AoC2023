$puzzle = Get-Content C:\Users\daniel.chaildin\Documents\WindowsPowerShell\AoC2023\Day1.txt

$total = 0
$reg = '[^0-9]'
foreach ($line in $puzzle) {
    $total += ($line -replace $reg)[0,-1] -join ''
}


# Part 2

$words = @{
    one = "o1e"
    two = "t2o"
    three = "t3e"
    four = "f4r"
    five = "f5e"
    six = "s6x"
    seven = "s7n"
    eight = "e8t"
    nine = "n9e"
}
$total = 0
$reg = '[^0-9]'
foreach ($line in $puzzle) {
    foreach ($word in $words.GetEnumerator()) {
        $line = $line -replace $word.Key,$word.Value
    }
    $total += ($line -replace $reg)[0,-1] -join ''
}