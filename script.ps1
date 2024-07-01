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
$armExercises = Randomise-Exercise -exercises $back
$legkExercises = Randomise-Exercise -exercises $back
$abExercises = Randomise-Exercise -exercises $back

## Send Email