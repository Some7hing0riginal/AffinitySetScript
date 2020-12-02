# AffinitySetScript
This Powershell script automatically identifies processes with a particular name and sets them to a specified affinity of your choosing

```
 1 (CPU 1)
 2 (CPU 2)
 4 (CPU 3)
 8 (CPU 4)
 16 (CPU 5)
 32 (CPU 6)
 64 (CPU 7)
 128 (CPU 8)
```

Example:

Affinity = 4 will use CPU 3 only

Affinity = 4 + 8 = 12 will use CPU 3 and CPU 4

The following will limit all current notepad processes running to run on CPU 3 and 4 

```
powershell -file AffinitySetScript.ps1 -processName notepad -affinity 12
```
Add debugMode to pause script upon completion:
```
powershell -file AffinitySetScript.ps1 -processName notepad -affinity 12 -debugMode 1
```

Use the set_affinity_to_1_audiodg.bat file sets the affinity of audiodg.exe to 1. This fixes some audio issues you might be having from a recent Windows Update.
Just double click the file to run or run from the command prompt. Ensure both set_affinity_to_1_audiodg.bat and AffinitySetScript.ps1 are in the same directory.
```
cd "<directory of both files>"
set_affinity_to_1_audiodg.bat
```
If you'd like to pause the script upon completion:
```
set_affinity_to_1_audiodg.bat -debugMode 1
```

Follow these instructions to run the .bat file automatically upon login:
https://www.windowscentral.com/how-create-automated-task-using-task-scheduler-windows-10
