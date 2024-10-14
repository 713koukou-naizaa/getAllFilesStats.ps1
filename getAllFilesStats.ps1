


$statsFile='C:\\Users\\Enzo\\Desktop\\downloads-folder-files-stats.txt'
$filesPathsArray = Get-ChildItem 'C:\\Users\\Enzo\\Downloads' | Select-Object -ExpandProperty FullName
$counter=1

foreach ($file in $filesPathsArray)
{
    $file=$file.replace('\', '\\')
    wmic datafile where "Name='$file'" list /format:list | Out-File $statsFile -Append
    Write-Output "--------------------------" | Out-File $statsFile -Append
    Write-Output "[$counter] Saved $file"
    $counter++
}

$content = [System.IO.File]::ReadAllText($statsFile)
$content = $content.Trim()
[System.IO.File]::WriteAllText($statsFile, $content)

$counter--
Write-Output "Total number of files saved: $counter"

(Get-Content $statsFile) | Where-Object {$_.trim() -ne "" } | Set-Content $statsFile

