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
$date = Get-Date -Format "dd-MM-yyyy"

$backExercises = Randomise-Exercise -exercises $back
$armExercises = Randomise-Exercise -exercises $arms
$legkExercises = Randomise-Exercise -exercises $legs
$abExercises = Randomise-Exercise -exercises $abs

$backExercises[0..1]
## Send Email
$username = <redacted>
$password = <redacted> | ConvertTo-SecureString -AsPlainText -Force

$body = @"
    <h2>Back</h2>
    <ul>
        <li>$backExercises</li>
    </ul>    
"@
$email = @{
    from = <redacted>
    to = <redacted>
    subject = "Gym Routine | $date"
    smtpserver = "smtp.gmail.com"
    body = $body
    port = 587
    credential = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $password
    usessl = $true
    verbose = $true
}

Send-MailMessage @email -BodyAsHtml