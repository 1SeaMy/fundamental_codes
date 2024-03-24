Private Sub CommandButton1_Click()
    Dim wsh As Object
    Set wsh = VBA.CreateObject("WScript.Shell")
    Dim waitOnReturn As Boolean: waitOnReturn = True
    Dim windowStyle As Integer: windowStyle = 1
    
    wsh.Run "compmgmt.msc", windowStyle, waitOnReturn
    Exit Sub

End Sub
