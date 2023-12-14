$puzzle = Get-Content "C:\Users\eChog\OneDrive\Documents\AoC2023\day8.txt"
$endofpuzzle = $puzzle.Count - 1

$directions = ($puzzle -split "`n")[0]
$aPuzzle = $puzzle[2..$endofpuzzle]
$runs = 0
$dirLength = $directions.Length
$dirCount = 0
$container = "AAA"
$num = $aPuzzle.IndexOf(($aPuzzle | ? { $_ -like "AAA*" }))
while ($container -ne "ZZZ") {
    if ($dirCount -eq $dirLength) {
        $dirCount = 0
    }
    $dir = $directions[$dirCount]

    switch ($dir) {
        "L" { $container = ((((($aPuzzle[$num] -split '=') -replace ' ','')[1])[1..7] -join '') -split ',')[0] }
        "R" { $container = ((((($aPuzzle[$num] -split '=') -replace ' ','')[1])[1..7] -join '') -split ',')[1] }
    }
    $searchString = $container + "*"
    $num = $aPuzzle.IndexOf(($aPuzzle | ? { $_ -like $searchString }))
    $runs += 1
    $dirCount += 1
    $container
}