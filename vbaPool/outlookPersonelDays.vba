Private Sub Application_Startup()
On Error Resume Next

    Dim MyDate, MyDay, MyMonth
    Dim InputData
    MyDate = Date
    MyDay = Day(MyDate)
    MyMonth = Month(MyDate)
    MyDate1 = (MyDay & "." & MyMonth)
    
    Open "D:\Personel\PersonelOzelGunleri.csv" For Input As #1
    Do While Not EOF(1)
        Line Input #1, InputData
    
    virgul = InStrRev(InputData, ";", -1)
    MidDogAy = Mid(InputData, virgul + 1)
    TrimDogAy = Trim(MidDogAy)
    DogAy = Val(TrimDogAy)
    
    InputData = Mid(InputData, 1, virgul - 1)
    virgul = InStrRev(InputData, ";", -1)
    MidDogGun = Mid(InputData, virgul + 1)
    TrimDogGun = Trim(MidDogGun)
    DogGun = Val(TrimDogGun)
    DogTar = DogGun & "." & DogAy
    
    If MyDate1 = DogTar Then
    
        InputData = Mid(InputData, 1, virgul - 1)
        virgul = InStrRev(InputData, ";", -1)
        MidDurum = Mid(InputData, virgul + 1)
        TrimDurum = Trim(MidDurum)
        
        If TrimDurum = "e" Then
            mesMesajBox = " Evlilik Yýldönümü..."
            mesSubject = "Evlilik Yýl Dönümünüzü Kutlarým..."
            mesBody = "<HTML><H4>Bir Ömür Boyu Mutluluklar...</H4><BODY>DA<br></BODY></HTML>"
            Else
            mesMesajBox = " Doðum Günü..."
            mesSubject = "Doðum Gününüzü Kutlarým..."
            mesBody = "<HTML><H4>Nice YILLARA...</H4><BODY>DA<br></BODY></HTML>"
        End If
        
        InputData = Mid(InputData, 1, virgul - 1)
        virgul = InStrRev(InputData, ";", -1)
        MidMail = Mid(InputData, virgul + 1)
        TrimMail = Trim(MidMail)
        
        InputData = Mid(InputData, 1, virgul - 1)
        virgul = InStrRev(InputData, ";", -1)
        MidAdSad = Mid(InputData, virgul + 1)
        TrimAdSad = Trim(MidAdSad)
        
        InputData = Mid(InputData, 1, virgul - 1)
        virgul = InStrRev(InputData, ";", -1)
        MidSnfRut = Mid(InputData, virgul + 1)
        TrimSnfRut = Trim(MidSnfRut)
    
    MailCevap = MsgBox((MyDate1 & " / " & TrimSnfRut & TrimAdSad & mesMesajBox), vbOKCancel, "Mail Gönder!!!")
    If MailCevap = 1 Then
        Set MyItem = Outlook.CreateItem(olMailItem)
        MyItem.To = TrimMail
        MyItem.Subject = mesSubject & "(" & TrimAdSad & " - " & MyDate1 & ")"
        MyItem.HTMLBody = mesBody
        MyItem.Send
    End If
    End If
    Loop
    Close #1
End Sub