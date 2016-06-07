strComputer = "."
strNameSpace = "root\cimv2"
strClass = "Win32_Process"

Set objClass = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _ 
    strComputer & "\" & strNameSpace & ":" & strClass)

WScript.Echo strClass & " Class Methods"
WScript.Echo "---------------------------"

For Each objClassMethod in objClass.Methods_
    WScript.Echo objClassMethod.Name
Next
 
WScript.Echo
WScript.Echo strClass & " Working processes"
WScript.Echo "---------------------------"

Set objClass = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _ 
    strComputer & "\" & strNameSpace)
    
Set objServices = objClass.ExecQuery ("Select * from Win32_Process")

For Each objClassName in objServices
    WScript.Echo "Process name -> " & objClassName.Name & _
	" Priority -> " & objClassName.Properties_("Priority") & _
	" Thread Count -> " & objClassName.Properties_("ThreadCount")
Next


Set objServices = objClass.ExecQuery ("Select * from Win32_Process Where Name='notepad.exe'")

For Each objClassMethod in objServices
	objClassMethod.Terminate()
Next

