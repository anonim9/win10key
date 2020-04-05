Set WshShell = CreateObject("WScript.Shell")
regKey = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\"
DigitalProductId = WshShell.RegRead(regKey & "DigitalProductId")
Win10ProductName = "Версия Windows 10: " & WshShell.RegRead(regKey & "ProductName") & vbNewLine
Win10ProductID = "ID продукта: " & WshShell.RegRead(regKey & "ProductID") & vbNewLine
Win10ProductKey = ConvertToKey(DigitalProductId)
ProductKeyLabel ="Ключ Windows 10: " & Win10ProductKey
Win10ProductID = Win10ProductName & Win10ProductID & ProductKeyLabel
MsgBox(Win10ProductID)
Function ConvertToKey(regKey)
Const KeyOffset = 52
isWin10 = (regKey(66) \ 6) And 1
regKey(66) = (regKey(66) And &HF7) Or ((isWin10 And 2) * 4)
j = 24
Chars = "BCDFGHJKMPQRTVWXY2346789"
Do
Cur = 0
y = 14
Do
Cur = Cur * 256
Cur = regKey(y + KeyOffset) + Cur
regKey(y + KeyOffset) = (Cur \ 24)
Cur = Cur Mod 24
y = y -1
Loop While y >= 0
j = j -1
winKeyOutput = Mid(Chars, Cur + 1, 1) & winKeyOutput
Last = Cur
Loop While j >= 0
If (isWin10 = 1) Then
keypart1 = Mid(winKeyOutput, 2, Last)
insert = "N"
winKeyOutput = Replace(winKeyOutput, keypart1, keypart1 & insert, 2, 1, 0)
If Last = 0 Then winKeyOutput = insert & winKeyOutput
End If
a = Mid(winKeyOutput, 1, 5)
b = Mid(winKeyOutput, 6, 5)
c = Mid(winKeyOutput, 11, 5)
d = Mid(winKeyOutput, 16, 5)
e = Mid(winKeyOutput, 21, 5)
ConvertToKey = a & "-" & b & "-" & c & "-" & d & "-" & e
End Function
