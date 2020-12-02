# elevate privileges if we are not running as Administrator, so we can set affinity of Windows owned processes
# source: http://superuser.com/questions/108207/how-to-run-a-powershell-script-as-administrator

param(
    [switch]$Elevated,
    [Parameter(Mandatory=$true)][string]$processName,
    [Parameter(Mandatory=$true)][int]$affinity,
    [int]$debugMode=0
)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

#pass whatever leftover args
$stringArgs = [string]$args
Write-Host "Arguments ${stringArgs}"

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        'tried to elevate to full privileges, did not work, aborting'
    } else {
        'running my self again with full privileges'
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-executionpolicy bypass -noprofile -file "{0}" -elevated {1} {2} {3} {4}' -f ($myinvocation.MyCommand.Definition), $processName, $affinity, $debugMode, $stringArgs)
    }
    exit
}
'running with full privileges'
#$debugMode = 1

# set affinity of all processes to CPU 3 and CPU 4
# it prints processes that it was unable to set affinity of    
# source: https://digitaljive.wordpress.com/2011/11/18/set-processor-affinity-with-powershell/

# 1 (CPU 1) 
# 2 (CPU 2) 
# 4 (CPU 3) 
# 8 (CPU 4) 
# 16 (CPU 5) 
# 32 (CPU 6) 
# 64 (CPU 7) 
# 128 (CPU 8)

#$affinity = 4 + 8
'setting all processes of ' + $processName + ' to affinity: '+$affinity

$allProcesses = Get-Process $processName 
foreach ($process in $allProcesses) { 
    try {
        $originalAffinity = $process.ProcessorAffinity
        Write-Host "Original affinity ${originalAffinity}"
        $process.ProcessorAffinity = $affinity
        $newAffinity = $process.ProcessorAffinity
        Write-Host "New affinity ${newAffinity}"

    }
    catch {
        'processes unable to set affinity of: '
        $process
    }
}

if ($debugMode) {
    Write-Host -NoNewLine 'Press any key to continue...';
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}

# Help from https://stackoverflow.com/a/35183987
