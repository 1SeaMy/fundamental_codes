Private Sub CommandButton1_Click()
' Dökümanda yazdýrma alanýndaki kýsýmlarý masa üstüne aktif sayfa ismi ile pdf kaydeder
On Error Resume Next
ActiveSheet.ExportAsFixedFormat Type:=xlTypePDF, Filename:= _
"C:\Users\Deniz\Desktop\" & ActiveSheet.Name

End Sub
