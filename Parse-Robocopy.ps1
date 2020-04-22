
$path=$args[0] #path is the first arguement given

if($args[0] -eq $NULL){
        $path = Read-Host "Enter log path" #if arg isn't given just get it anyway
        $ParsedOutput = Select-String 'ERROR \d' -Path $path #scan log file for problems using super simple regex
}else{
    $ParsedOutput = Select-String 'ERROR \d' -Path $path #scan log file for problems using super simple regex
}
if($ParsedOutput.Length -eq 0){
    Write-Host "No errors found!" #let's us know if there's no problems
}else{

    Write-Host "Errors are found, writing to a file`n" #let us know there's problems
    $outputpath = Read-Host "Enter desired parsed output location" #save it to a file
    $ParsedOutput | out-file $outputpath #output to that location
}