Private Sub BuyukHarf()
    Dim c As Range
    For Each c In ActiveSheet.UsedRange
        If Not IsEmpty(c.Value) And VarType(c.Value) = vbString Then
            c.Value = UCase(c.Value)
        End If
    Next c
         
End Sub
' ----------------------------------------------------------------------
Private Sub CommandButton1_Click()
Sub TumHarfleriBuyukYap()
    Dim ws As Worksheet
    Dim cell As Range
    Dim rng As Range

    Application.ScreenUpdating = False

    For Each ws In ThisWorkbook.Worksheets
        On Error Resume Next
        Set rng = ws.UsedRange.SpecialCells(xlCellTypeConstants, xlTextValues)
        On Error GoTo 0

        If Not rng Is Nothing Then
            For Each cell In rng
                If VarType(cell.Value) = vbString Then
                    cell.Value = UCase(cell.Value)
                End If
            Next cell
        End If
        Set rng = Nothing
    Next ws

    Application.ScreenUpdating = True
    MsgBox "Tüm hücrelerdeki metinler büyük harfe dönüştürüldü.", vbInformation
End Sub
' ----------------------------------------------------------------------
Sub EnterKarakterleriniBosluklaDegistir()
    Dim ws As Worksheet
    Dim cell As Range
    Dim rng As Range

    Application.ScreenUpdating = False

    For Each ws In ThisWorkbook.Worksheets
        On Error Resume Next
        Set rng = ws.UsedRange.SpecialCells(xlCellTypeConstants, xlTextValues)
        On Error GoTo 0

        If Not rng Is Nothing Then
            For Each cell In rng
                If VarType(cell.Value) = vbString Then
                    cell.Value = Replace(cell.Value, vbLf, " ")
                    cell.Value = Replace(cell.Value, vbCr, " ")
                End If
            Next cell
        End If
        Set rng = Nothing
    Next ws

    Application.ScreenUpdating = True
    MsgBox "Tüm Enter karakterleri boşlukla değiştirildi.", vbInformation
End Sub
' ----------------------------------------------------------------------

Private Sub Trimle()
    Dim c As Range
    For Each c In ActiveSheet.UsedRange
        If Not IsEmpty(c.Value) Then
            c.Value = Trim(c.Value)
        End If
    Next c
         
End Sub
' ----------------------------------------------------------------------
Private Sub tekBosluk()
    Cells.Replace What:="     ", Replacement:=" ", LookAt:=xlPart, SearchOrder _
        :=xlByRows, MatchCase:=False, SearchFormat:=False, ReplaceFormat:=False
    Cells.Replace What:="    ", Replacement:=" ", LookAt:=xlPart, SearchOrder _
        :=xlByRows, MatchCase:=False, SearchFormat:=False, ReplaceFormat:=False
    Cells.Replace What:="   ", Replacement:=" ", LookAt:=xlPart, SearchOrder _
        :=xlByRows, MatchCase:=False, SearchFormat:=False, ReplaceFormat:=False
    Cells.Replace What:="  ", Replacement:=" ", LookAt:=xlPart, SearchOrder _
        :=xlByRows, MatchCase:=False, SearchFormat:=False, ReplaceFormat:=False
         
End Sub
' ----------------------------------------------------------------------
Private Sub Trim_le()
    Dim ws As Worksheet
    Dim sonuc As String
    Dim sonSatir As Integer
    Dim satir As Integer
    
    Set ws = ActiveSheet
    sonSatir = ws.Cells(ws.Rows.Count, 2).End(xlUp).Row
    
    For satir = 2 To sonSatir
        sonuc = Trim(ws.Cells(satir, 2).Value)
        ws.Cells(satir, 2).Value = sonuc
    Next satir

End Sub
' ----------------------------------------------------------------------
Function RemoveCombiningCharacters(text As String) As String
    Dim i As Integer
    Dim ch As String
    Dim result As String

    For i = 1 To Len(text)
        ch = Mid(text, i, 1)
        ' Combining dot above (U+0307) gibi bazı görünmez karakterleri atla
        If AscW(ch) <> 775 Then
            result = result & ch
        End If
    Next i

    RemoveCombiningCharacters = result

End Function
' ----------------------------------------------------------------------
Function TurkceToIngilizce(text As String) As String
    text = RemoveCombiningCharacters(text)

    Dim i As Integer
    Dim ch As String
    Dim result As String

    For i = 1 To Len(text)
        ch = Mid(text, i, 1)
        Select Case ch
            Case "Ç": result = result & "C"
            Case "ç": result = result & "c"
            Case "Ş": result = result & "S"
            Case "ş": result = result & "s"
            Case "Ğ": result = result & "G"
            Case "ğ": result = result & "g"
            Case "Ü": result = result & "U"
            Case "ü": result = result & "u"
            Case "Ö": result = result & "O"
            Case "ö": result = result & "o"
            Case "İ": result = result & "I"
            Case "i": result = result & "i"
            Case "I": result = result & "I"
            Case "ı": result = result & "i"
            Case Else: result = result & ch
        End Select
    Next i

    TurkceToIngilizce = result
End Function

Sub TurkceKarakterleriDonustur()
    Dim c As Range
    
    For Each c In ActiveSheet.UsedRange
        If Not IsEmpty(c.Value) Then
            c.Value = TurkceToIngilizce(CStr(c.Value))
        End If
    Next c
End Sub

' ----------------------------------------------------------------------
Sub BuyukTurkceKarakterleriDonustur_Dizisiz()
    Dim ws As Worksheet
    Dim cell As Range
    Dim rng As Range
    Dim metin As String

    Application.ScreenUpdating = False

    For Each ws In ThisWorkbook.Worksheets
        On Error Resume Next
        Set rng = ws.UsedRange.SpecialCells(xlCellTypeConstants, xlTextValues)
        On Error GoTo 0

        If Not rng Is Nothing Then
            For Each cell In rng
                If VarType(cell.Value) = vbString Then
                    metin = cell.Value
                    metin = Replace(metin, "İ", "I")
                    metin = Replace(metin, "Ü", "U")
                    metin = Replace(metin, "Ğ", "G")
                    metin = Replace(metin, "Ş", "S")
                    metin = Replace(metin, "Ö", "O")
                    metin = Replace(metin, "Ç", "C")
                    cell.Value = metin
                End If
            Next cell
        End If
        Set rng = Nothing
    Next ws

    Application.ScreenUpdating = True
    MsgBox "Büyük Türkçe karakterler başarıyla dönüştürüldü.", vbInformation
End Sub
' ----------------------------------------------------------------------
Private Sub CommandButton1_Click()

' pdfKaydet Makro
' Dökümanda yazdırma alanındaki kısımları masa üstüne aktif sayfa ismi ile pdf kaydeder
On Error Resume Next
ActiveSheet.ExportAsFixedFormat Type:=xlTypePDF, Filename:= _
"C:\Users\Deniz\Desktop\" & ActiveSheet.Name

End Sub
' ----------------------------------------------------------------------
Sub KısaltmaOtomatik()
    Dim ws As Worksheet
    Dim kelimeler() As String
    Dim i As Integer
    Dim sonuc As String
    Dim metin As String
    Dim sonSatir As Integer
    Dim satir As Integer
    
    Set ws = ActiveSheet
    sonSatir = ws.Cells(ws.Rows.Count, 2).End(xlUp).Row
    
    For satir = 2 To sonSatir
        sonuc = ""
        metin = ws.Cells(satir, 2).Value
        kelimeler = Split(metin, " ")
' okul adını boşluklarla ayırdık ve ilk harfleri alıyoruz
        For i = LBound(kelimeler) To UBound(kelimeler)
            sonuc = sonuc & Left(kelimeler(i), 1)
        Next i
' satir, 4 = il kodu
        ws.Cells(satir, 5).Value = ws.Cells(satir, 4).Value & " - " & sonuc
    Next satir
End Sub
