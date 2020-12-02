# AffinitySetScript
This Powershell script automatically identifies processes with a particular name and sets them to a specified affinity of your choosing


# 1 (CPU 1) 
# 2 (CPU 2) 
# 4 (CPU 3) 
# 8 (CPU 4) 
# 16 (CPU 5) 
# 32 (CPU 6) 
# 64 (CPU 7) 
# 128 (CPU 8)

Example:

Affinity = 4 will use CPU 3 only
Affinity = 4 + 8 = 12 will use CPU 3 and CPU 4
The following will limit all current notepad processes running to run on CPU 3 and 4 
powershell -file set_affinity.ps1 -processName notepad -affinity 12
