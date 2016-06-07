param([string]$Path = "", [string]$NewPath = ".\new.bmp")

if ($Path.Length -lt 0)
{
    echo "Please provide file name in proper format .bmp with 24-color bitmap"
    end
}

function GetArrayFromPicture ($path)
{
    $picture = Get-Content $Path -ReadCount 0 -Encoding Ascii 
    $pictureCharArray = $picture.ToCharArray()
    return $pictureCharArray
}

function ClearBitsFromArray ($offset, $array)
{
    for($r=$offset; $r -lt $array.Length; $r += 3)
    {
        $array[$r] = 0
    }
    return $array
}

function GetPixelOffsetFromHeader ($array)
{
    $offset = 0
    for($i=10; $i -lt 14; $i++)
    {
        $offset += [System.Convert]::ToInt32($array[$i])*[Math]::Pow(2,$i - 10)
    }
    return $offset
}

function SaveNewPictureFromArray ($path, $array)
{
    $newpicture = -join $array
    Set-Content $path -Value $newpicture -Encoding Ascii
}

$pictureCharArray = GetArrayFromPicture $Path

$offset = GetPixelOffsetFromHeader $pictureCharArray

Write-Host
Write-Host ([System.String]::Format("Colors of picture begin from offset {0:X}", [System.Convert]::ToInt32($offset)))

$decision = Read-Host ("Please choose color which should be deleted (red, green, blue) :")

if ($decision -contains "blue")
{
    $pictureCharArray = ClearBitsFromArray $offset $pictureCharArray
}
if ($decision -contains "green")
{
    $offset += 1
    $pictureCharArray = ClearBitsFromArray $offset $pictureCharArray
}
if ($decision -contains "red")
{
    $offset += 2
    $pictureCharArray = ClearBitsFromArray $offset $pictureCharArray
}

SaveNewPictureFromArray $NewPath $pictureCharArray