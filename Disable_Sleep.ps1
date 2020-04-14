New-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\7516b95f-f776-4464-8c53-06167f40cc99\8EC4B3A5-6868-48c2-BE75-4F3044BE88A7 -Name "Attributes" -Value 2 -PropertyType DWORD -Force | Out-Null
New-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 -Name "Attributes" -Value 2 -PropertyType DWORD -Force | Out-Null

& "powercfg" /change monitor-timeout-ac 0
& "powercfg" /change monitor-timeout-dc 0
& "powercfg" /change disk-timeout-ac 0
& "powercfg" /change disk-timeout-dc 0
& "powercfg" /change standby-timeout-ac 0
& "powercfg" /change standby-timeout-dc 0
& "powercfg" /change hibernate-timeout-ac 0
& "powercfg" /change hibernate-timeout-dc 0
& "powercfg" /setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 238c9fa8-0aad-41ed-83f4-97be242c8f20 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 0
& "powercfg" /setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 7516b95f-f776-4464-8c53-06167f40cc99 8ec4b3a5-6868-48c2-be75-4f3044be88a7 0
& "powercfg" /setdcvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 7516b95f-f776-4464-8c53-06167f40cc99 8ec4b3a5-6868-48c2-be75-4f3044be88a7 0
& "powercfg" /setdcvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 238c9fa8-0aad-41ed-83f4-97be242c8f20 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 0
