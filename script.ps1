function Generate-Workout {
    param (
        [array]$routine, 
        [string]$bodyPart
    )

    $exercises = foreach($item in $routine){
        "<li>$item</li>"
    }

    return $exercises | Sort-Object {Get-Random}
}

$arms = Get-Content ".\files\arms.txt"
$back = Get-Content ".\files\back.txt"
$legs = Get-Content ".\files\legs.txt"
$abs = Get-Content ".\files\abs.txt"
$chest = Get-Content ".\files\chest.txt"
$date = Get-Date -Format "dd-MM-yyyy"

$backWorkout = Generate-Workout -routine $back
$armWorkout = Generate-Workout -routine $arms
$legWorkout = Generate-Workout -routine $legs
$abWorkout = Generate-Workout -routine $abs
$chestWorkout = Generate-Workout -routine $chest

$backPayload = $backWorkout[0..1]
$armPayload = $armWorkout[0..1]
$legPayload = $legWorkout[0..1]
$abPayload = $abWorkout[0..1]
$chestPayload = $chestWorkout[0..1]


#Send Email
$username = <redacted>
$password = <redacted> | ConvertTo-SecureString -AsPlainText -Force

$body = @"
    <h1>Gym Routine | $date</h1>
    <h2>Legs</h2>
    <ul>
        $legPayload
    </ul>
    <h2>Chest</h2>
    <ul>
        $chestPayload
    </ul>
    <h2>Back</h2>
    <ul>
        $backPayload
    </ul>
    <h2>Arms</h2>
    <ul>
        $armPayload
    </ul>
    <h2>Abs</h2>
    <ul>
        $abPayload
    </ul>

"@
$email = @{
    from = $username
    to = $username
    subject = "Gym Routine | $date"
    smtpserver = "smtp.gmail.com"
    body = $body
    port = 587
    credential = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $password
    usessl = $true
    verbose = $true
}

Send-MailMessage @email -BodyAsHtml