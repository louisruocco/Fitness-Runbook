function Randomise-Exercise {
    param (
        [array]$exercises
    )

    return $exercises | Sort-Object {Get-Random}
}

$arms = Get-Content ".\files\arms.txt"
$back = Get-Content ".\files\back.txt"
$legs = Get-Content ".\files\legs.txt"
$abs = Get-Content ".\files\abs.txt"

$backExercises = Randomise-Exercise -exercises $back
$armExercises = Randomise-Exercise -exercises $arms
$legkExercises = Randomise-Exercise -exercises $legs
$abExercises = Randomise-Exercise -exercises $abs

$backExercises[0..1]
## Send Email