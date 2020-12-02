cd /d %~dp0
powershell -executionpolicy bypass -file AffinitySetScript.ps1 -processName audiodg -affinity 1 %*
