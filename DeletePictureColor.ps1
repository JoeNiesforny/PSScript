param([string]$Path = "", [string]$NewPath = ".\new.bmp")

if ($Path.Length -lt 0)
{
    echo "Please provide file name in proper format .bmp with 24-color bitmap"
    end
}

$picture = Get-Content $Path -ReadCount 0 -Encoding Ascii 
$pictureCharArray = $picture.ToCharArray()

$offset = 0
for($i=10; $i -lt 14; $i++)
{
$offset += [System.Convert]::ToInt32($pictureCharArray[$i])*[Math]::Pow(2,$i - 10)
}

Write-Host
Write-Host ([System.String]::Format("Colors of picture begin from offset {0:X}", [System.Convert]::ToInt32($offset)))

$decision = Read-Host ("Please choose color which should be deleted (red, green, blue) :")

if ($decision -contains "blue")
{
    for($r=$offset; $r -lt $pictureCharArray.Length; $r += 3)
    {
        $pictureCharArray[$r] = 0
    }
}
if ($decision -contains "green")
{
    for($i=($offset+1); $i -lt $pictureCharArray.Length; $i += 3)
    {
        $pictureCharArray[$i] = 0
    }
}
if ($decision -contains "red")
{
    for($i=($offset+2); $i -lt $pictureCharArray.Length; $i += 3)
    {
        $pictureCharArray[$i] = 0
    }
}

$newpicture = -join $pictureCharArray
$newPicturePath = $NewPath
Set-Content $newPicturePath -Value $newpicture -Encoding Ascii
