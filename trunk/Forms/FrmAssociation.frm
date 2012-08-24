VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form FrmAssociation 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "  Associa��o de Documentos"
   ClientHeight    =   3930
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   4965
   Icon            =   "FrmAssociation.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3930
   ScaleWidth      =   4965
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin MSComDlg.CommonDialog Dialog 
      Left            =   4080
      Top             =   3240
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Frame Frame2 
      Height          =   585
      Left            =   30
      TabIndex        =   1
      Top             =   0
      Width           =   4755
      Begin VB.CommandButton cmdAbrirDoc 
         Height          =   360
         Left            =   660
         Picture         =   "FrmAssociation.frx":030A
         Style           =   1  'Graphical
         TabIndex        =   4
         ToolTipText     =   "Abrir Documento"
         Top             =   150
         Width           =   435
      End
      Begin VB.CommandButton cmdInserirDoc 
         Height          =   360
         Left            =   180
         Picture         =   "FrmAssociation.frx":064C
         Style           =   1  'Graphical
         TabIndex        =   3
         ToolTipText     =   "Inserir Documento"
         Top             =   120
         Width           =   435
      End
      Begin VB.CommandButton cmdRemoverDoc 
         Height          =   360
         Left            =   1170
         Picture         =   "FrmAssociation.frx":0EAE
         Style           =   1  'Graphical
         TabIndex        =   2
         ToolTipText     =   "Remover Documento"
         Top             =   150
         Width           =   435
      End
   End
   Begin VB.Frame fraSelecoes 
      Caption         =   "Documentos Associados"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3045
      Left            =   30
      TabIndex        =   0
      Top             =   630
      Width           =   4755
      Begin MSComctlLib.ListView LvAssociations 
         Height          =   2745
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   4545
         _ExtentX        =   8017
         _ExtentY        =   4842
         View            =   3
         LabelWrap       =   -1  'True
         HideSelection   =   0   'False
         HideColumnHeaders=   -1  'True
         FullRowSelect   =   -1  'True
         GridLines       =   -1  'True
         HotTracking     =   -1  'True
         HoverSelection  =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         NumItems        =   3
         BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            Key             =   "Diret�rio"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   1
            Key             =   "Documento"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   2
            Key             =   "Exten��o"
            Object.Width           =   2540
         EndProperty
      End
   End
   Begin MSComctlLib.ListView ListView1 
      Height          =   2145
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   4545
      _ExtentX        =   8017
      _ExtentY        =   3784
      View            =   3
      LabelWrap       =   -1  'True
      HideSelection   =   0   'False
      HideColumnHeaders=   -1  'True
      FullRowSelect   =   -1  'True
      GridLines       =   -1  'True
      HotTracking     =   -1  'True
      HoverSelection  =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   3
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Key             =   "Diret�rio"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Key             =   "Documento"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   2
         Key             =   "Exten��o"
         Object.Width           =   2540
      EndProperty
   End
End
Attribute VB_Name = "FrmAssociation"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Private object_id As String, Lv As ListItem
Private rs As ADODB.Recordset
Private tcs As TeCanvas, tdb As TeDatabase, x As Double, y As Double
Const SW_SHOW As Long = 5
Dim er As String



Public Function init(ObjectID_ As String, mtcs As TeCanvas, mtdb As TeDatabase, Optional mx As Double, Optional my As Double) As Boolean
On Error GoTo Trata_Erro
   Set tcs = mtcs
   Set tdb = mtdb
   x = mx
   y = my
   LvAssociations.ListItems.Clear
   'LvAssociations.ColumnHeaders(1).Width = 2100
   'LvAssociations.ColumnHeaders(2).Width = LvAssociations.Width - 2600
   'LvAssociations.ColumnHeaders(3).Width = LvAssociations.Width - 3550
  
   object_id = ObjectID_
   Dim af As String
   Dim ag As String
   Dim ah As String
   Dim ai As String
   Dim aj As String
   af = "PATH_"
   ag = "FILE_"
   ah = "EXTENSION_"
   ai = "X_FILES"
   aj = "OBJECT_ID_"
   
   If frmCanvas.TipoConexao <> 4 Then
   
   Set rs = Conn.execute("SELECT path_, file_, extension_ from X_Files where object_id_ = '" & object_id & "' ")
   
      While Not rs.EOF
         Set Lv = LvAssociations.ListItems.Add(, , rs.Fields("path_").value)
             Lv.SubItems(1) = rs.Fields("file_").value
             Lv.SubItems(2) = rs.Fields("extension_").value
         rs.MoveNext
      Wend
   rs.Close
   Set rs = Nothing
   
   Else
    Dim awe As String
     
Set rs = Conn.execute("SELECT " + """" + af + """" + ", " + """" + ag + """" + ", " + """" + ah + """" + " from " + """" + ai + """" + " where " + """" + aj + """" + " = '" & object_id & "' ")
     
 'WritePrivateProfileString "A", "A", "SELECT " + """" + af + """" + ", " + """" + ag + """" + ", " + """" + ah + """" + " from " + """" + ai + """" + " where " + """" + aj + """" + " = '" & object_id & "' ", App.path & "\DEBUG.INI"
     LvAssociations.ListItems.Clear
     
     
     While Not rs.EOF
       er = Replace(rs.Fields("path_").value, "9qwert2", "\")
         Set Lv = LvAssociations.ListItems.Add(, , er)
             Lv.SubItems(1) = rs.Fields("file_").value
             Lv.SubItems(2) = rs.Fields("extension_").value
         rs.MoveNext
      Wend
   rs.Close
   Set rs = Nothing
   
   
   End If
   
  
    
   Me.Show vbModal
   
Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else
   
   PrintErro CStr(Me.Name), "Public Function Init", CStr(Err.Number), CStr(Err.Description), True
   
End If

End Function

Private Sub cmdAbrirDoc_Click()
On Error GoTo Trata_Erro
   Dim Cont As Integer
   

   
   
   With LvAssociations
      If .ListItems.count > 0 Then
         If .SelectedItem.Selected = True Then
            For Cont = 1 To .ListItems.count
               If .ListItems.Item(Cont).Selected = True Then
                  Dim i&
                  i& = ShellExecute(0, "open", IIf(Right(.ListItems(Cont).Text, 1) = "\", .ListItems(Cont).Text, .ListItems(Cont).Text & "\") & .ListItems(Cont).SubItems(1) & .ListItems(Cont).SubItems(2), "", "", SW_SHOW)
                  Exit Sub
               End If
            Next
         Else
            MsgBox "Selecione um documento para excluir", vbExclamation, "GeoSan"
         End If
      Else
         MsgBox "N�o foi selecionado nenhum arquivo", vbExclamation, "GeoSan"
      End If
   End With
   
   
   
 
   
   
   

Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else
   
   PrintErro CStr(Me.Name), "Private Sub cmdAbrirDoc", CStr(Err.Number), CStr(Err.Description), True
   
End If


End Sub



Private Sub cmdSalvarPonto_Click()
On Error GoTo Trata_Erro
   Dim Cont As Integer, geom_id As Long, cgeo As New clsGeoReference
   
Dim stringconexao As String

Dim a As String
Dim b As String
Dim c As String
Dim d As String
Dim e As String
Dim f As String
Dim g As String
Dim h As String
Dim i As String
Dim j As String
Dim k As String
Dim l As String
Dim m As String
If frmCanvas.TipoConexao <> 4 Then
     

   If LvAssociations.ListItems.count > 0 Then
      tcs.object_id = object_id
      tcs.saveOnMemory
      
      'Conn.BeginTrans
      If object_id = "" Then
         tcs.SaveInDatabase
         'tcs.getSELECTBox x, y, x, y
      '   geom_id = tcs.getSelectGeometry(0, 4)
    
      
        
         Set rs = Conn.execute("SELECT max(geom_id) from points" & cgeo.GetLayerID(tcs.getCurrentLayer))
         Conn.execute "update points" & cgeo.GetLayerID(tcs.getCurrentLayer) & " set object_id = geom_id where geom_id =" & rs(0).value
         object_id = rs(0).value
         rs.Close
         Set rs = Nothing
         tcs.plotView
         'tdb.updateObjectIdInt geom_id, CStr(geom_id), 4
         
      Else


     
         Set rs = Conn.execute("delete from X_Files where object_id_ = '" & object_id & "' ")
         End If
      
      'salva atributos
    
      For Cont = 1 To LvAssociations.ListItems.count
     
   
         Set rs = Conn.execute("insert into X_Files (object_id_, path_, file_, extension_) values ('" & object_id & "', '" & LvAssociations.ListItems(Cont).Text & "', '" & LvAssociations.ListItems(Cont).SubItems(1) & "', '" & LvAssociations.ListItems(Cont).SubItems(2) & "') ")
      Next
      'Conn.CommitTrans
      
      'MsgBox "Associa��o conclu�da com sucesso", vbExclamation, "GeoSan"
      LvAssociations.ListItems.Clear
      Me.Hide
   Else
      MsgBox "Insira um documento para associar ao ponto", vbExclamation, "GeoSan"
   End If
   Set cgeo = Nothing
   
   
   
    
     Else
     
a = "points"
b = "geom_id"
c = cgeo.GetLayerID(tcs.getCurrentLayer)
d = "object_id"
l = "points"
f = l + c
g = "X_FILES"
h = "PATH_"
i = "FILE_"
j = "EXTENSION_"
k = "OBJECT_ID_"
m = l + f
    If LvAssociations.ListItems.count > 0 Then
      tcs.object_id = object_id
      tcs.saveOnMemory
      
      'Conn.BeginTrans
      If object_id = "" Then
         tcs.SaveInDatabase
         'tcs.getSELECTBox x, y, x, y
        ' geom_id = tcs.getSelectGeometry(0, 4)
        
         Set rs = Conn.execute("SELECT max(" + """" + b + """" + ") from " + """" + f + """" + "")
      'MsgBox "update " + """" + f + """" + " set " + """" + d + """" + " ='" & geom_id & "'  where " + """" + b + """" + " =   '" & rs(0).value & "'"
      
     
      
      
      
         Conn.execute "update " + """" + f + """" + " set " + """" + d + """" + " =" + """" + "geom_id" + """" + "  where " + """" + b + """" + " =   '" & rs(0).value & "'"
         
         
         object_id = rs(0).value
         rs.Close
         Set rs = Nothing
         tcs.plotView
         'tdb.updateObjectIdInt geom_id, CStr(geom_id), 4
         
      Else
      
         Set rs = Conn.execute("delete from " + """" + g + """" + " where " + """" + k + """" + " = '" & object_id & "' ")
      End If
     ' MsgBox "insert into " + """" + g + """" + "(" + """" + k + """" + "," + """" + h + """" + "," + """" + i + """" + "," + """" + j + """" + ") values ('" & object_id & "', '" & LvAssociations.ListItems(Cont).Text & "', '" & LvAssociations.ListItems(Cont).SubItems(1) & "', '" & LvAssociations.ListItems(Cont).SubItems(2) & "') "
      ' Dim a1, a2, a3, a4 As String
     ' a1 = object_id
     ' a2 = LvAssociations.ListItems(1).Text
    '  a3 = LvAssociations.ListItems(1).SubItems(1)
    '  a4 = LvAssociations.ListItems(1).SubItems(2)
     ' a1 = Replace(a1, "", "'")
      'salva atributos
      For Cont = 1 To LvAssociations.ListItems.count
        er = Replace(LvAssociations.ListItems(Cont).Text, "\", "9qwert2")
      
         Set rs = Conn.execute("insert into " + """" + g + """" + "(" + """" + k + """" + "," + """" + h + """" + "," + """" + i + """" + "," + """" + j + """" + ") values ('" & object_id & "', '" & er & "', '" & LvAssociations.ListItems(Cont).SubItems(1) & "', '" & LvAssociations.ListItems(Cont).SubItems(2) & "') ")
      Next
      'Conn.CommitTrans
      
      'MsgBox "Associa��o conclu�da com sucesso", vbExclamation, "GeoSan"
      LvAssociations.ListItems.Clear
      Me.Hide
   Else
      MsgBox "Insira um documento para associar ao ponto", vbExclamation, "GeoSan"
   End If
   Set cgeo = Nothing

  
   End If
   

Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else
   
   PrintErro CStr(Me.Name), "Private Sub cmdSalvarPonto", CStr(Err.Number), CStr(Err.Description), True

End If
   
End Sub
'inserir documento na lista
Private Sub cmdInserirDoc_Click()
On Error GoTo Trata_Erro
  Dim Cont As Integer, geom_id As Long, cgeo As New clsGeoReference
   
Dim stringconexao As String

   Dim fso As New Scripting.FileSystemObject
   Dim ts As Scripting.TextStream
   Dim conteudoArquivo As String, path As String, file As String, extension As String
    path = ""
    file = ""
    extension = ""
    
    Dialog.Filter = "BBA Files (*.*)|*.*"
    Dialog.Filter = "Arquivo all (*.*)|*.*|"
    Dialog.DialogTitle = "Open File"

    Dialog.Flags = _
    cdlOFNFileMustExist + _
    cdlOFNHideReadOnly + _
    cdlOFNLongNames + _
    cdlOFNExplorer
    Dialog.ShowOpen
 
 
 
 
 

 
       ' If frmCanvas.TipoConexao <> 4 Then
        
        
          If Dialog.FileName <> "" Then
        'guarda caminho diret�rio
        'path = fso.GetParentFolderName(Dialog.fileName)
        path = Left(Dialog.FileName, InStrRev(Dialog.FileName, "\") - 1)
        'guarda nome do arquivo
        'file = fso.GetBaseName(Dialog.fileName)
        file = mid(Dialog.FileName, InStrRev(Dialog.FileName, "\") + 1, InStrRev(Dialog.FileName, ".") - (InStrRev(Dialog.FileName, "\") + 1))
        'guarda extens�o do arquivo
        'extension = "." & fso.GetExtensionName(Dialog.fileName)
        extension = Right(Dialog.FileName, Len(Dialog.FileName) - (InStrRev(Dialog.FileName, ".") - 1))
        Set Lv = LvAssociations.ListItems.Add(, , path)
            Lv.SubItems(1) = file
            Lv.SubItems(2) = extension
            'Lv.Tag = LvAssociations.ListItems.count
    Else
        path = ""
        file = ""
        extension = ""
        'FrmCanvas.NewAssociationPoint = False
    End If
    '
      '  Else
        
       '    If Dialog.FileName <> "" Then
        'guarda caminho diret�rio
        'path = fso.GetParentFolderName(Dialog.fileName)
     '   path = Left(Dialog.FileName, InStrRev(Dialog.FileName, "\") - 1)
        'guarda nome do arquivo
        'file = fso.GetBaseName(Dialog.fileName)
       ' file = mid(Dialog.FileName, InStrRev(Dialog.FileName, "\") + 1, InStrRev(Dialog.FileName, ".") - (InStrRev(Dialog.FileName, "\") + 1))
        'guarda extens�o do arquivo
        'extension = "." & fso.GetExtensionName(Dialog.fileName)
      '  extension = Right(Dialog.FileName, Len(Dialog.FileName) - (InStrRev(Dialog.FileName, ".") - 1))
        '  er = Replace(path, "\", "9qwert2")
      '  Set Lv = LvAssociations.ListItems.Add(, , er)
           
           ' Lv.SubItems(1) = file
          '  Lv.SubItems(2) = extension
            'Lv.Tag = LvAssociations.ListItems.count
   ' Else
     '   path = ""
     '   file = ""
    '    extension = ""
        'FrmCanvas.NewAssociationPoint = False
        
        
    '    End If
        
 '  End If
 
 
 If frmCanvas.TipoConexao <> 4 Then
     
  Conn.execute ("DELETE  from X_Files where object_id_ = '" & object_id & "' ")
   
   Else
    Conn.execute ("DELETE  from " + """" + "X_FILES" + """" + " where " + """" + "OBJECT_ID_" + """" + " = '" & object_id & "' ")
   
   End If
   
 
 Salva
 
 
Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else
   
   PrintErro CStr(Me.Name), "Private Sub cmdInserirDoc_Click", CStr(Err.Number), CStr(Err.Description), True
   
End If

End Sub
Public Function Salva()
 Dim Cont As Integer, geom_id As Long, cgeo As New clsGeoReference
 
Dim a As String
Dim b As String
Dim c As String
Dim d As String
Dim e As String
Dim f As String
Dim g As String
Dim h As String
Dim i As String
Dim j As String
Dim k As String
Dim l As String
Dim m As String
If frmCanvas.TipoConexao <> 4 Then
     

   If LvAssociations.ListItems.count > 0 Then
      tcs.object_id = object_id
      tcs.saveOnMemory
      
      'Conn.BeginTrans
      If object_id = "" Then
         tcs.SaveInDatabase
         'tcs.getSELECTBox x, y, x, y
      '   geom_id = tcs.getSelectGeometry(0, 4)
        
         Set rs = Conn.execute("SELECT max(geom_id) from points" & cgeo.GetLayerID(tcs.getCurrentLayer))
         Conn.execute "update points" & cgeo.GetLayerID(tcs.getCurrentLayer) & " set object_id = geom_id where geom_id =" & rs(0).value
         object_id = rs(0).value
         rs.Close
         Set rs = Nothing
         tcs.plotView
         'tdb.updateObjectIdInt geom_id, CStr(geom_id), 4
         
    
         End If
      
      'salva atributos
    
      For Cont = 1 To LvAssociations.ListItems.count
     
   
         Set rs = Conn.execute("insert into X_Files (object_id_, path_, file_, extension_) values ('" & Val(object_id) & "', '" & LvAssociations.ListItems(Cont).Text & "', '" & LvAssociations.ListItems(Cont).SubItems(1) & "', '" & LvAssociations.ListItems(Cont).SubItems(2) & "') ")
      Next
      'Conn.CommitTrans
      
      'MsgBox "Associa��o conclu�da com sucesso", vbExclamation, "GeoSan"
     ' LvAssociations.ListItems.Clear
    '  Me.Hide
  
   End If
   Set cgeo = Nothing
   
   
   
    
     Else
     
a = "points"
b = "geom_id"
c = cgeo.GetLayerID(tcs.getCurrentLayer)
d = "object_id"
l = "points"
f = l + c
g = "X_FILES"
h = "PATH_"
i = "FILE_"
j = "EXTENSION_"
k = "OBJECT_ID_"
m = l + f
    If LvAssociations.ListItems.count > 0 Then
      tcs.object_id = object_id
      tcs.saveOnMemory
      
      'Conn.BeginTrans
      If object_id = "" Then
         tcs.SaveInDatabase
         'tcs.getSELECTBox x, y, x, y
        ' geom_id = tcs.getSelectGeometry(0, 4)
        
         Set rs = Conn.execute("SELECT max(" + """" + b + """" + ") from " + """" + f + """" + "")
      'MsgBox "update " + """" + f + """" + " set " + """" + d + """" + " ='" & geom_id & "'  where " + """" + b + """" + " =   '" & rs(0).value & "'"
      
     
      
      
      
         Conn.execute "update " + """" + f + """" + " set " + """" + d + """" + " =" + """" + "geom_id" + """" + "  where " + """" + b + """" + " =   '" & rs(0).value & "'"
         
         
         object_id = rs(0).value
         rs.Close
         Set rs = Nothing
         tcs.plotView
         'tdb.updateObjectIdInt geom_id, CStr(geom_id), 4
         
     
      End If
     ' MsgBox "insert into " + """" + g + """" + "(" + """" + k + """" + "," + """" + h + """" + "," + """" + i + """" + "," + """" + j + """" + ") values ('" & object_id & "', '" & LvAssociations.ListItems(Cont).Text & "', '" & LvAssociations.ListItems(Cont).SubItems(1) & "', '" & LvAssociations.ListItems(Cont).SubItems(2) & "') "
      ' Dim a1, a2, a3, a4 As String
     ' a1 = object_id
     ' a2 = LvAssociations.ListItems(1).Text
    '  a3 = LvAssociations.ListItems(1).SubItems(1)
    '  a4 = LvAssociations.ListItems(1).SubItems(2)
     ' a1 = Replace(a1, "", "'")
      'salva atributos
      For Cont = 1 To LvAssociations.ListItems.count
        er = Replace(LvAssociations.ListItems(Cont).Text, "\", "9qwert2")
      
         Set rs = Conn.execute("insert into " + """" + g + """" + "(" + """" + k + """" + "," + """" + h + """" + "," + """" + i + """" + "," + """" + j + """" + ") values ('" & object_id & "', '" & er & "', '" & LvAssociations.ListItems(Cont).SubItems(1) & "', '" & LvAssociations.ListItems(Cont).SubItems(2) & "') ")
      Next
      'Conn.CommitTrans
      
      'MsgBox "Associa��o conclu�da com sucesso", vbExclamation, "GeoSan"
   '   LvAssociations.ListItems.Clear
     ' Me.Hide
  
   End If
   Set cgeo = Nothing

  
   End If
 
   
   
 



End Function
















'remover documento da lista
Private Sub cmdRemoverDoc_Click()
On Error GoTo Trata_Erro
   Dim Cont As Integer
   
   
   
   
   
         If frmCanvas.TipoConexao <> 4 Then
     
  Conn.execute ("DELETE  from X_Files where object_id_ = '" & object_id & "' ")
   
   Else
    Conn.execute ("DELETE  from " + """" + "X_FILES" + """" + " where " + """" + "OBJECT_ID_" + """" + " = '" & object_id & "' ")
   
   End If
   

   
   'verifica se existe documento para excluir
   If LvAssociations.ListItems.count > 0 Then
      'verifica se algum documento est� selecionado
      If LvAssociations.SelectedItem.Selected = True Then
         For Cont = 1 To LvAssociations.ListItems.count
            If LvAssociations.ListItems.Item(Cont).Selected = True Then
               LvAssociations.ListItems.Remove (Cont)
                Salva
               Exit Sub
            End If
         Next
      Else
         MsgBox "Selecione um documento para excluir", vbExclamation, "GeoSan"
      End If
   Else
      MsgBox "Este ponto n�o possui documento(s) para exclus�o", vbExclamation, "GeoSan"
   End If

     
   
   
Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else
   
   PrintErro CStr(Me.Name), "Private Sub cmdRemoverDoc_Click", CStr(Err.Number), CStr(Err.Description), True
   
End If

End Sub

Private Sub Command1_Click()
cmdSalvarPonto_Click
End Sub

Private Sub Form_Load()
   'LoozeXP1.InitSubClassing
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Error GoTo Trata_Erro

   
   'LoozeXP1.EndWinXPCSubClassing

Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else
   MsgBox Err.Description & " - " & Err.Number
End If

End Sub


