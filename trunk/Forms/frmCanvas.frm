VERSION 5.00
Object = "{18576B0E-A129-4A50-9930-59E18A6FE5E1}#1.0#0"; "TeComCanvas.dll"
Object = "{87AC6DA5-272D-40EB-B60A-F83246B1B8D7}#1.0#0"; "TECOMD~1.DLL"
Object = "{9AB389E7-EAED-4DBF-941D-EB86ED1F9A76}#1.0#0"; "TeComConnection.dll"
Object = "{EE78E37B-39BE-42FA-80B7-E525529739F7}#1.0#0"; "TeComViewDatabase.dll"
Begin VB.Form frmCanvas 
   Caption         =   "Mapa"
   ClientHeight    =   5955
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7680
   Icon            =   "frmCanvas.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   5955
   ScaleWidth      =   7680
   WindowState     =   2  'Maximized
   Begin TECOMCANVASLibCtl.TeCanvas TCanvas 
      Height          =   2415
      Left            =   3360
      OleObjectBlob   =   "frmCanvas.frx":08CA
      TabIndex        =   8
      Top             =   600
      Width           =   2895
   End
   Begin VB.Timer Timer1 
      Left            =   6615
      Top             =   5400
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H80000009&
      Caption         =   "Ajustar Escala"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Visible         =   0   'False
      Width           =   1695
      Begin VB.CommandButton cmdConfEscala 
         Caption         =   "OK"
         Height          =   255
         Left            =   1200
         TabIndex        =   2
         Top             =   240
         Width           =   375
      End
      Begin VB.TextBox txtEscala 
         Height          =   285
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame fraRedes 
      BackColor       =   &H80000009&
      Caption         =   "Tamanho das Redes"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   120
      TabIndex        =   3
      Top             =   780
      Visible         =   0   'False
      Width           =   2175
      Begin VB.TextBox txtRede2 
         Height          =   285
         Left            =   120
         TabIndex        =   5
         Top             =   960
         Width           =   1935
      End
      Begin VB.TextBox txtRede1 
         Height          =   285
         Left            =   120
         TabIndex        =   4
         Top             =   480
         Width           =   1935
      End
      Begin VB.Label Label2 
         BackColor       =   &H80000009&
         Caption         =   "Segunda"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   760
         Width           =   1935
      End
      Begin VB.Label Label1 
         BackColor       =   &H80000009&
         Caption         =   "Primeira"
         Height          =   255
         Left            =   150
         TabIndex        =   6
         Top             =   270
         Width           =   1935
      End
   End
   Begin VB.Timer TimerSetWorld 
      Interval        =   100
      Left            =   6180
      Top             =   5220
   End
   Begin TeComConnectionLibCtl.TeAcXConnection TeAcXConnection1 
      Left            =   6360
      OleObjectBlob   =   "frmCanvas.frx":08FE
      Top             =   3360
   End
   Begin TECOMDATABASELibCtl.TeDatabase TeDatabaseRamais 
      Left            =   720
      OleObjectBlob   =   "frmCanvas.frx":0922
      Top             =   5400
   End
   Begin TECOMDATABASELibCtl.TeDatabase TeDatabase3 
      Left            =   720
      OleObjectBlob   =   "frmCanvas.frx":0946
      Top             =   4680
   End
   Begin TECOMDATABASELibCtl.TeDatabase TeDatabase2 
      Left            =   480
      OleObjectBlob   =   "frmCanvas.frx":096A
      Top             =   3720
   End
   Begin TECOMDATABASELibCtl.TeDatabase TeDatabase1 
      Left            =   480
      OleObjectBlob   =   "frmCanvas.frx":098E
      Top             =   2640
   End
   Begin TeComViewDatabaseLibCtl.TeViewDatabase TeViewDatabase2 
      Left            =   4200
      OleObjectBlob   =   "frmCanvas.frx":09B2
      Top             =   4560
   End
   Begin TeComViewDatabaseLibCtl.TeViewDatabase TeViewDatabase1 
      Left            =   4080
      OleObjectBlob   =   "frmCanvas.frx":09D6
      Top             =   3600
   End
End
Attribute VB_Name = "frmCanvas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim geo As Variant
Dim tipoDeConexao As String

Dim nStr As String
Public Position_X As Double, Position_Y As Double
Private mUserName As String, ViewName As String
Private xmin, ymin, xmax, ymax, LastEvent As TypeGeometryEvent
Dim Tc As New clsTerraConfig, Tr As New clsTerraLib, LastDocument As String, tempo As Date
Dim CLIQUE_RAMAL As Integer
Dim intQtdLinhasNaCoordenada As Integer
Dim postg As Integer
Dim postg2 As Integer
Dim postg3 As Integer
Dim postg4 As Integer
Dim postg5 As Integer
Dim xOld As Double
Dim yOld As Double
Dim a As String
Dim b As String
Dim c As String
Dim d As String
Dim e As String
Dim f As String
Dim g As String
Dim h As String
Dim i As String
Dim layeratual As String
Dim selec As Long
Dim mPROVEDOR As String
Dim mSERVIDOR As String
Dim mPORTA As String
Dim mBANCO As String
Dim mUSUARIO As String
Dim senha2 As String
Dim decriptada As String
Dim user As String
Dim con As New ADODB.connection
Dim strConn As String
Dim count2 As Integer
 Dim conexao As New ADODB.connection

 


Public Static Function TipoConexao() As String

tipoDeConexao = typeconnection
TipoConexao = tipoDeConexao

End Function



Public Static Function POST() As Integer


POST = postg

End Function

Public Static Function POST2(po3 As Integer) As Integer


postg = po3

End Function

Public Static Function POSTA() As Integer


POSTA = postg2

End Function

Public Static Function POST2A(po2 As Integer) As Integer


postg2 = po2

End Function




Public Static Function POSTB() As Integer


POSTB = postg3

End Function

Public Static Function POST2B(po3 As Integer) As Integer


postg3 = po3

End Function


Public Static Function POSTC() As Integer


POSTC = postg4

End Function

Public Static Function POST2C(po4 As Integer) As Integer


postg4 = po4

End Function


Public Static Function POSTD() As Integer


POSTD = postg5

End Function

Public Static Function POST2D(po5 As Integer) As Integer


postg5 = po5

End Function




Public Static Function Senha() As String

Senha = nStr

End Function





Public Function init(Conn As ADODB.connection, username As String) As Boolean
On Error GoTo Trata_Erro

Dim rs As ADODB.Recordset

1
2 Dim linha As Integer

tipoDeConexao = typeconnection


If typeconnection <> postgreSQL Then

3 TeViewDatabase1.username = username

4 TeViewDatabase1.Provider = typeconnection

5 TeViewDatabase1.connection = Conn
       'LoadThemes
'user = username
'con = Conn
6 TeDatabase1.username = username
7 TeDatabase1.Provider = typeconnection
8 TeDatabase1.connection = Conn

9  TeDatabase2.Provider = typeconnection
10 TeDatabase2.connection = Conn

11 TeDatabase3.Provider = typeconnection

12 TeDatabase3.connection = Conn

13 TeDatabaseRamais.Provider = typeconnection
14 TeDatabaseRamais.connection = Conn

     
17 TCanvas.Provider = typeconnection '
      
19 TCanvas.user = username

20 TCanvas.connection = Conn ' SE DER ERRO AQUI, VERIFICAR A VERS�O DA TECOM INSTALADA NA M�QUINA

  ' ViewName = TeViewDatabase1.getActiveView

21        If Tc.GetWorldByUser(username, xmin, ymin, xmax, ymax, typeconnection) Then
22            TCanvas.setProjection "WATERLINES"
23            TCanvas.setWorld CDbl(xmin), CDbl(ymin), CDbl(xmax), CDbl(ymax)
24        End If
        
        '***************************************************
        'incluido em 16/01/2009 - Jonathas
        'Recurso Tecom 3.2 - Configura��o do tamanho do ponto do acordo com o zoom
        
25
If ReadINI("MAPA", "FIXAR_ICONE", App.path & "\CONTROLES\GEOSAN.INI") = "SIM" Then
    TCanvas.fixedPoint = True

Else
   TCanvas.fixedPoint = False

End If



        '***************************************************
   
   
   'DEIXA COMO CURRENT LAYER O RAMAIS AGUA CASO SEJA USU�RIO VISUALIZADOR
   Set rs = New ADODB.Recordset
   rs.Open "SELECT USRLOG, USRFUN FROM SYSTEMUSERS WHERE USRLOG = '" & strUser & "' ORDER BY USRLOG", Conn, adOpenDynamic, adLockOptimistic
   If rs.EOF = False Then
      If rs!UsrFun = 4 Then 'VISUALIZADOR
        MsgBox "Layer corrente: RAMAIS_AGUA", vbInformation, ""
        TCanvas.setCurrentLayer "RAMAIS_AGUA"
         
      End If
   End If
   rs.Close
   
   
26 Me.Show
        
27 TCanvas.plotView



28 TCanvas.snapOn = 1
        
29 mUserName = username
    'Para saber quantos canvas est�o abertos...
30    If FrmMain.Tag = "" Then
31        FrmMain.Tag = 0
32    Else
33        FrmMain.Tag = Int(FrmMain.Tag) + 1
34    End If



   
   
   
   Else
   

Dim mPROVEDOR As String
Dim mSERVIDOR As String
Dim mPORTA As String
Dim mBANCO As String
Dim mUSUARIO As String
Dim Senha As String
Dim decriptada As String
                         

mSERVIDOR = ReadINI("CONEXAO", "SERVIDOR", App.path & "\CONTROLES\GEOSAN.ini")
mPORTA = ReadINI("CONEXAO", "PORTA", App.path & "\CONTROLES\GEOSAN.ini")
mBANCO = ReadINI("CONEXAO", "BANCO", App.path & "\CONTROLES\GEOSAN.ini")
mUSUARIO = ReadINI("CONEXAO", "USUARIO", App.path & "\CONTROLES\GEOSAN.ini")
Senha = ReadINI("CONEXAO", "SENHA", App.path & "\CONTROLES\GEOSAN.ini")
nStr = FunDecripta(Senha)
decriptada = nStr
 Call WriteINI("CONEXAO", "USER", username, App.path & "\CONTROLES\GEOSAN.INI")
 TeAcXConnection1.Open mUSUARIO, decriptada, mBANCO, mSERVIDOR, mPORTA


 
 TeViewDatabase1.username = username
 TeViewDatabase1.Provider = typeconnection
 TeViewDatabase1.connection = TeAcXConnection1.objectConnection_

 
' TeViewDatabase1.addView ("TESTE2000")
 
 'TeViewDatabase1.addTheme("WATERLINES", "TESTE2000", "WATERLINES") = True



 TeDatabase1.username = username
 TeDatabase1.Provider = typeconnection
 TeDatabase1.connection = TeAcXConnection1.objectConnection_

 TeDatabase2.Provider = typeconnection
 TeDatabase2.connection = TeAcXConnection1.objectConnection_

 TeDatabase3.Provider = typeconnection

 TeDatabase3.connection = TeAcXConnection1.objectConnection_

 TeDatabaseRamais.Provider = typeconnection
 TeDatabaseRamais.connection = TeAcXConnection1.objectConnection_



    
    TCanvas.Provider = typeconnection 'Provider 4 = PostgreSQL
    TCanvas.user = username
    TCanvas.connection = TeAcXConnection1.objectConnection_ '� nessa parte que � setada a conex�o com
                                                          'a TeComConnection. Isso � v�lido para
                                                          'todas as outras TeComs. Por�m, quando for
                                                          'realizar as querys de atributos, as mesmas
                                                          'devem ser feitas pela conex�o ado do vb.
                                                          'Se quiser trabalhar com transa��o, deve-se
                                                          'abrir a transa��o da conex�o ado e da
                                                          'TeComConnection. Ex:
                                                          'conexao.BeginTrans
                                                          'TeConnection.beginTransaction
                                                          'O mesmo vale para o Commit e para o
                                                          'Rollback.

    
     
     
     
     
  'TCanvas.saveOnMemory
'TCanvas.SaveInDatabase
     
     



       If Tc.GetWorldByUser(username, xmin, ymin, xmax, ymax, typeconnection) Then
           TCanvas.setProjection "WATERLINES"
           TCanvas.setWorld CDbl(xmin), CDbl(ymin), CDbl(xmax), CDbl(ymax)
       End If
        
        '***************************************************
        'incluido em 16/01/2009 - Jonathas
        'Recurso Tecom 3.2 - Configura��o do tamanho do ponto do acordo com o zoom
        

If ReadINI("MAPA", "FIXAR_ICONE", App.path & "\CONTROLES\GEOSAN.INI") = "SIM" Then
    TCanvas.fixedPoint = True

Else
   TCanvas.fixedPoint = False

End If

 



        '***************************************************
   
   
   'DEIXA COMO CURRENT LAYER O RAMAIS AGUA CASO SEJA USU�RIO VISUALIZADOR
   Set rs = New ADODB.Recordset
  
   
   Dim stringconexao As String

    Dim a As String
    Dim b As String
    Dim c As String
     Dim d As String
     Dim e As String
    a = "USRLOG"
      b = "USRFUN"
       c = "SYSTEMUSERS"
      

   stringconexao = "Select " + """" + a + """" + "," + """" + b + """" + " from " + """" + c + """" + " where " + """" + a + """" + "=" + "'" & strUser & "' ORDER BY " + """" + a + """" + ""
  

   
  ' rs.Open stringconexao, Conn, adOpenDynamic, adLockReadOnly
    rs.Open stringconexao, Conn, adOpenDynamic, adLockOptimistic
   
   
   If rs.EOF = False Then
      If rs!UsrFun = 4 Then 'VISUALIZADOR
        MsgBox "Layer corrente: RAMAIS_AGUA", vbInformation, ""
        TCanvas.setCurrentLayer "RAMAIS_AGUA"
         
      End If
   End If
   rs.Close
   
   
 Me.Show
        
TCanvas.plotView



 TCanvas.snapOn = 1
        
mUserName = username
    'Para saber quantos canvas est�o abertos...
   If FrmMain.Tag = "" Then
        FrmMain.Tag = 0
   Else
      FrmMain.Tag = Int(FrmMain.Tag) + 1
   End If


 
   
   
   
   
   End If
   
Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
      Resume Next
   Else
      
      
      PrintErro CStr(Me.Name), "Public Function Init", CStr(Err.Number), CStr(Err.Description), True, Erl
      End
      
   End If

End Function

'Sub CorrigeBug()
'On Error GoTo Trata_Erro
'   Dim rs As New ADODB.Recordset, a As Integer, x As Double, y As Double
'   TeDatabase2.setCurrentLayer "watercomponents"
'   With TeDatabase1
'      .setCurrentLayer "WATERLINES"
'      rs.Open "SELECT object_id_,initialcomponent,finalcomponent, lower_x,lower_y from waterlines inner join lines38 on object_id=object_id_ where initialcomponent= 0 or finalcomponent =0", Conn, adOpenKeyset, adLockOptimistic
'      While Not rs.EOF
'         For a = 0 To 1
'            .getPointOfLine 0, rs("object_id_").value, a, x, y
'            If TeDatabase2.locateGeometryXY(x, y, tpPOINTS) = 1 Then
'               If a = 0 Then
'                  rs("initialcomponent").value = TeDatabase2.objectIds(0)
'               Else
'                  rs("finalcomponent").value = TeDatabase2.objectIds(0)
'               End If
'            Else
'                TCanvas.setCurrentLayer "WATERLINES"
'                TCanvas.setWorld x - 500, y - 500, x + 500, y + 500
'                'TCanvas.Object = rs("object_id_").value
'                'TCanvas.SELECT
'
'                TCanvas.setDetachedLineStyle 3, 1, RGB(255, 255, 0), True
'                TCanvas.addDetachedIds tpLINES, , rs("object_id_").value
'                TCanvas.plotView
'
'                MsgBox "O trecho:" & rs("object_id_").value & " que est� marcado apresenta inconscist�ncia nos 'N�S' que o sistema n�o pode corrigir autom�ticamente, remova e desenhe novamente.", vbExclamation
'                Exit Sub
'            End If
'         Next
'         rs.Update
'         rs.MoveNext
'      Wend
'      rs.Close
'   End With
'   Set rs = Nothing
'   Set Tr.cgeo.tdb = TeDatabase1
'   Set Tr.cgeo.tdbcon = TeDatabase2
'   Tr.cgeo.AddAtributesLinesOut "WATERLINES"
'Trata_Erro:
'    If Err.Number = 0 Or Err.Number = 20 Then
'       Resume Next
'    Else
'       Open App.path & "\Controles\GeoSanLog.txt" For Append As #1
'       Print #1, Now & " " & strUser & " " & Versao_Geo & " - frmCanvas - Sub CorrigeBug - " & " - " & Err.Number & " - " & Err.Description
'       Close #1
'       MsgBox "Um posss�vel erro foi identificado:" & Chr(13) & Chr(13) & Err.Description & Chr(13) & Chr(13) & "Foi gerado na pasta do aplicativo o arquivo GeoSanLog.txt com informa��es desta ocorr�ncia.", vbInformation
'    End If
'End Sub


Private Sub cmdConfEscala_Click()
On Error GoTo Trata_Erro
    If Trim(txtEscala.Text) <> "" And IsNumeric(txtEscala.Text) Then
        TCanvas.setScale Int(txtEscala.Text)
    Else
        MsgBox "Digite um valor num�rico para a escala.", vbInformation, "Aten��o!"
        txtEscala.SetFocus
    End If
Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
   Else
    
      PrintErro CStr(Me.Name), "cmdConfEscala_Click()", CStr(Err.Number), CStr(Err.Description), True
      
   End If
End Sub

Private Sub Form_Activate()
   'TeViewDatabase1.setActiveView
   'TCanvas.v ViewName
   'TeViewDatabase1.connection = Conn

   LoadThemes
   
   LoadToolsBar
   TCanvas_onEndSELECT
End Sub

Private Sub LoadToolsBar()
   Dim a As Integer
   For a = 1 To FrmMain.tbToolBar.Buttons.count
      If FrmMain.tbToolBar.Buttons.Item(a).Style = tbrCheck Then FrmMain.tbToolBar.Buttons(a).value = tbrUnpressed
   Next
   Select Case Tr.TerraEvent
      Case tg_SelectObject
      
         FrmMain.tbToolBar.Buttons("kselection").value = tbrPressed
      Case tg_ZoomArea
         FrmMain.tbToolBar.Buttons("kzoomarea").value = tbrPressed
      Case tg_Pan
         FrmMain.tbToolBar.Buttons("kpan").value = tbrPressed
      Case tg_DrawNetWorkline
         FrmMain.tbToolBar.Buttons("kdrawnetworkline").value = tbrPressed
      Case tg_DrawNetWorkNode
         FrmMain.tbToolBar.Buttons("kinsertnetworknode").value = tbrPressed
      Case tg_MoveNetWorkNode
         FrmMain.tbToolBar.Buttons("kmovenetworknode").value = tbrPressed
   End Select
End Sub




Private Sub Form_KeyPress(KeyAscii As Integer)
   With FrmMain
      Select Case KeyAscii
         Case vbKeyDelete
            .tbToolBar_ButtonClick .tbToolBar.Buttons("kdelete")
         Case 19 'vbKeyControl + vbKeyS
            .tbToolBar_ButtonClick .tbToolBar.Buttons("ksave")
         Case 27 'ESC
            TCanvas.Cancel
            frmNetWorkLegth.txtLength.Text = 0
      End Select
      
      
      
   End With

End Sub

Private Sub Form_Resize()
On Error GoTo Trata_Erro

   If Me.Width > 200 And Me.Height > 200 Then
      TCanvas.Move 100, 100, Me.Width - 200, Me.Height - 200
      TCanvas.plotView
   End If

Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else

   PrintErro CStr(Me.Name), "Private Sub Form_Resize", CStr(Err.Number), CStr(Err.Description), True

End If

End Sub


Private Sub Form_Unload(Cancel As Integer)

On Error GoTo Trata_Erro
   
  FrmMain.Manager1.GridVisibled False
   Tc.SetWorldByUser strUser, CDbl(xmin), CDbl(ymin), CDbl(xmax), CDbl(ymax)
   
  Set Tc = Nothing
   
  On Error Resume Next
   
  ' Set FrmMain.ViewManager1.tcs = Null
 '  Set FrmMain.ViewManager1.tvm = Null
 ' Set FrmMain.ViewManager1.tvw = Null
   
   
   FrmMain.ViewManager1.resetView
'FrmMain.ViewManager1.start

   Unload frmNetWorkLegth
   
   'para saber quantos canvas est�o abertos...
   FrmMain.Tag = Int(FrmMain.Tag) - 1


Trata_Erro:
    
    If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
    Else
       
       PrintErro CStr(Me.Name), "Private Sub Form_Unload", CStr(Err.Number), CStr(Err.Description), True
       
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
On Error GoTo Trata_Erro
   
   TCanvas.zoomArea
   TCanvas.drawpo

Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
   Else
    
      PrintErro CStr(Me.Name), "Private Sub Toolbar1_ButtonClick", CStr(Err.Number), CStr(Err.Description), True
    
   End If
End Sub


'Apartir de hoje comentando o codigo
Public Sub Tb_SELECT(ByVal Button As String)
On Error GoTo Trata_Erro 'trata erros

    Dim a As Integer, object_ids As String ' declara��o das vari�veis a  do tipo integer e object_ids do tipo string
    Dim retval As String ' declara��o da vari�vel retval do tipo string

    LastEvent = Tr.TerraEvent 'LastEvent recebe o conte�do de Tr.TerraEvent
   
   TCanvas.ToolTipText = "" 'em branco
   
    With TCanvas ' Com o TCanvas
      
      Select Case Button    'selecione um case
         
         Case "kselection"
            
            TCanvas.Normal ' TCanvas da area normal desmarca item 1, item2, item3, item4 e 128
            TCanvas.Select
            Tr.TerraEvent = tg_SelectObject
            .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128

         Case "kplotview" ' plota a vista desmarca item 1, item2, item3, item4 e 128
            
            TCanvas.plotView
            .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128
         
         Case "krecompose" 'recomp�e a vista desmarca item 1, item2, item3, item4 e 128
            
            TCanvas.recompose
            .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128

         Case "kzoomarea" ' zoom da area desmarca item 1, item2, item3, item4 e 128
            
            TCanvas.zoomArea
            Tr.TerraEvent = tg_ZoomArea
            .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128

         Case "kpan" ' recorta plotview desmarcaitem 1, item2, item3, item4 e 128
            
            TCanvas.pan
            Tr.TerraEvent = tg_Pan

         Case "kundoview" 'retorna a visualiza��o anterior desmarca item 1, item2, item3, item4 e 128
            
            TCanvas.undoView
            .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128

         Case "kredoview"  'desfaz a �ltima visualiza��o desmarca item 1, item2, item3, item4 e 128
            
            TCanvas.redoView
            .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128

         Case "KFindCoordenadas" 'final das coordenadas desmarca item 1, item2, item3, item4 e 128
            
            .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128
            'Declara��o das vari�veis x,y
            Dim x As Double, y As Double

            x = InputBox("Informe a Coordena X ") ' entrada da coordenada x
            y = InputBox("Informe a Coordena Y ") ' entrada da coordenada y
            If x <> 0 And y <> 0 Then ' se x e y for diferente de zero
                TCanvas.setWorld x - 50, y - 50, x + 50, y + 50 '  'configura as coordenadas mundo a serem utilizadas para desenho

                TCanvas.plotView ' plota o layer
            End If ' final do if
         
         Case "KEncontraConsumidor" ' localizar consumidores
            
           
            
            TCanvas.setCurrentLayer "RAMAIS_AGUA" ''configura o plano "RAMAIS_AGUA" como corrente

            frmEncontraConsumidor.Show 1 ' encontra consumidor e adiciona
         
         Case "KEncontraTexto" ' case encontra texto e adiciona

            frmEncontraTexto.Show 1

         Case "kzoomin" ' zoom menos -

            TCanvas.zoomIn dblFatorZoomMenos

         Case "kzoomout" ' zoom mais +


           TCanvas.zoomOut dblFatorZoomMais


         Case Else
            If TCanvas.getCurrentLayer <> "" Then 'configura o plano corrente e se for diferente da falta de sele��o
               TeDatabase1.setCurrentLayer TCanvas.getCurrentLayer 'aciona atabela para modificar o plano e configura um plano corrente
               Set Tr.tcs = TCanvas ' seta e TCanvas passa ser valor para a vari�vel Tr.tcs
               Set Tr.tdb = TeDatabase1 'seta e TeDatabase1 passa ser valor para a vari�vel Tr.tdb
               Set Tr.tdbcon = TeDatabase2 'seta e TeDatabase2 passa ser valor para a vari�vel Tr.tdbcon
               Set Tr.tdbconref = TeDatabase3 'seta e TeDatabase3 passa ser valor para a vari�vel Tr.tdbconref
               Set Tr.CtrlMgr = FrmMain.Manager1 'CtrlMgr recebe o form.Manager1
                      'TCanvas.getRepresentationTheme(
               Select Case Button ' selecione uma das op��es
                  
                  Case "kCalcularArea"
                  
                     TCanvas.calculateArea
                     TCanvas.ToolTipText = "" ' se for igual em branco
                     
               
                  Case "kdrawnetworkline" 'desenhar rede de agua

                     TCanvas.clearSelectItens 0 'desmarca se h� item selecionado

'                     Tr.TerraEvent = tg_DrawNetWorkline

                     If Tr.DrawNetWorkLine = True Then
                        frmNetWorkLegth.init TCanvas, FrmMain
                        FrmMain.ViewManager1.LoadImageSnap Tr.cgeo.GetReferenceLayer(.getCurrentLayer), mOnSnapLock
                        FrmMain.TabStrip1.Tabs(2).Selected = True
                     Else

                        FrmMain.tbToolBar.Buttons("kdrawnetworkline").value = tbrUnpressed

                        .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128
                        Exit Sub
                     End If

                  Case "kmovenetworknode" 'mover n� da rede
                        Tr.MoveNetWorkNode

                  Case "kinsertnetworknode"
'                        fraRedes.Visible = T rue
                        Tr.DrawNetWorkNode

                  Case "kdrawtext"
                        'A implantar

                  Case "kinsertdoc" ' este
                     Tr.DrawPoint: Tr.TerraEvent = tg_DrawGeometrys

                  Case "kdrawramal"
                        If ConnSec.State = 1 Then
                            TCanvas.clearSelectItens 0 'desmarca se h� item selecionado
                            Tr.DrawRamal: Tr.TerraEvent = tg_DrawRamal
                        Else
                            MsgBox "A conex�o com o banco de dados comercial n�o foi configurada para realizar esta opera��o.", vbInformation, "Conex�o Comercial"
                        End If

                  Case "kdelete"

                     Tr.Delete

                  Case "ksearchinnetwork" ''obtem a quantidade de poligonos selecionados em mem�ria
                     If .getSelectCount(lines) = 1 Then

                        Dim Trecho As String
                        Trecho = TCanvas.getSelectObjectId(0, lines) 'CAPTURA O TRECHO SELECIONADO
                        TCanvas.Normal                               'LIMPA A SELE��O DE QUALQUER OBJETO NO MAPA
                        TCanvas.Select

                        object_ids = FrmProcess.FindValvulas(Trecho, TCanvas)   'Tr.CGeo.SELECTRede TCanvas.getSELECTObjectId(0, lines)

                        If object_ids <> "" Then

                           frmConsumidoresDesabastecidos.init object_ids
                        End If
                     Else
                        MsgBox "Selecione 1 trecho de rede de agua para esta fun��o.", vbInformation, ""
                     End If

                  Case "kdeclivity"
                     If .getSelectCount(lines) = 1 Then
                        Set Tr.cgeo.tcs = TCanvas
                        Tr.cgeo.GetDeclivity .getCurrentLayer, Tr.cgeo.GetReferenceLayer(.getCurrentLayer), .getSelectObjectId(0, lines)
                     End If

                  Case "ksearchattribute"
                     Tr.SearchGeomtryForAttribute

                  Case "ksave"


                     Tr.SaveInDatabase

                     If FrmMain.tbToolBar.Buttons("kdrawnetworkline").value = tbrUnpressed Then
                         With TCanvas
                            .Normal
                            .Select: Tr.TerraEvent = tg_SelectObject
                            .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128
                         End With
                     End If
                   TCanvas.plotView
                     LoadToolsBar

                  Case "kdrawintersection"
                     Tr.DrawInterSection

                  Case "kdrawline"

                  Case "kdrawpoint"

                  Case "kdrawtext"

                  Case "mnuPoligono"
                     'TCanvas.Select True

                     Tr.TerraEvent = 0
                     TCanvas.Normal
                     TCanvas.drawPolygon


               End Select
            Else
               MsgBox "Nenhum plano est� ativo", vbExclamation
            End If
      End Select
      
      'comprimento da linha
      If Tr.TerraEvent = tg_DrawNetWorkline Then
         frmNetWorkLegth.init TCanvas, FrmMain
         Dim Lh As Double
         TCanvas.getLengthOfLastSegmentOfLine Lh
         frmNetWorkLegth.txtLength.Text = Lh
      Else
         Unload frmNetWorkLegth
      End If
      TCanvas_onEndPlotView
      LoadToolsBar
      
      
   End With
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
    ElseIf Err.Number = 13 Then
       Exit Sub
    Else

       PrintErro CStr(Me.Name), "Public Sub Tb_SELECT", CStr(Err.Number), CStr(Err.Description), True

    End If
End Sub


Private Sub TCanvas_onArea(ByVal value As Double)

   FrmMain.sbStatusBar.Panels(1).Text = "�rea do pol�gono: " & Format(value, "0.00") & " m�"
   TCanvas.ToolTipText = "�rea: " & Format(value, "0.00") & " m�"

End Sub

'Public Function CarregaPoligonoVirtual(redeIn As Boolean, redeCross As Boolean, ramalIn As Boolean, ramalCross As Boolean) As Boolean
'
'   Dim i As Long
'
'   'GRAVA EM ARQUIVO TXT O NOME DO USUARIO QUE FEZ O POLIGONO PARA QUE A EXPORTA��O EPANET SAIBA QUAL USU�RIO QUE CRIOU
'    Open "C:\ARQUIVOS DE PROGRAMAS\GEOSAN\Controles\UserLog.txt" For Output As #3
'    Print #3, strUser
'    Close #3
'
'   With TeDatabase1
'      '.UserName = UserName
'      .Provider = typeconnection
'      .Connection = Conn
'      .setCurrentLayer "WATERLINES"
'   End With
'
'
'   If redeIn = True Then
'      'CARREGA NA VARIAVEL TOTAL A QUANTIDADE DE LINHAS QUE EST�O CONTIDADAS NO POL�GONO
'      lngTotalRedesDentro = TeDatabase1.Within(geo, tpPOLYGONS, tpLINES)
'
'      If lngTotalRedesDentro > 0 Then
'
'         ReDim Preserve ArrRedesDentro(lngTotalRedesDentro) 'REDIMENSIONA O ARRAY
'
'         FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalRedesDentro
'
'         For i = 0 To lngTotalRedesDentro - 1
'            DoEvents
'            ArrRedesDentro(i) = TeDatabase1.objectIds(i)
'            FrmMain.ProgressBar1.value = i + 1
'         Next
'
'      End If
'
'   End If
'
'   If redeCross = True Then
'      'CARREGA NA VARIAVEL TOTAL A QUANTIDADE DE LINHAS QUE EST�O NA DIVISA DO POL�GONO
'      lngTotalRedesDivisa = TeDatabase1.Crosses(geo, tpPOLYGONS, tpLINES)
'
'      If lngTotalRedesDivisa > 0 Then
'
'         FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalRedesDentro
'
'         For i = 0 To lngTotalRedesDivisa - 1
'            DoEvents
'            Conn.execute ("INSERT INTO POLIGONO_SELECAO (OBJECT_ID_,USUARIO,TIPO) VALUES ( '" & TeDatabase1.objectIds(i) & "','" & strUser & "',1)")
'            FrmMain.ProgressBar1.value = i + 1
'         Next
'
'      End If
'
'   End If
'
'
'   ' ************************** CARREGANDO RAMAIS
'
'   'LIMPA A TABELA POLIGONO_SELECAO ELIMINANDO A SELECAO ANTERIOR DO USU�RIO
'    Conn.execute ("DELETE FROM POLIGONO_SELECAO WHERE USUARIO = '" & strUser & "' AND TIPO = 1")
'
'   TeDatabase1.setCurrentLayer "RAMAIS_AGUA"
'   If ramalIn = True Then
'
'      lngTotalRamaisDentro = TeDatabase1.Within(geo, tpPOLYGONS, tpLINES)
'
'      If lngTotalRamaisDentro > 0 Then
'         FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalRamaisDentro
'
'         For i = 0 To lngTotalRamaisDentro - 1
'            DoEvents
'            Conn.execute ("INSERT INTO POLIGONO_SELECAO (OBJECT_ID_,USUARIO,TIPO) VALUES ( '" & TeDatabase1.objectIds(i) & "','" & strUser & "',2)")
'            FrmMain.ProgressBar1.value = i + 1
'         Next
'      End If
'
'   End If
'
'   If ramalCross = True Then
'
'      lngTotalRamaisDivisa = TeDatabase1.Crosses(geo, tpPOLYGONS, tpLINES)
'
'      If lngTotalRamaisDivisa > 0 Then
'         FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalRamaisDentro
'
'         For i = 0 To lngTotalRamaisDivisa - 1
'            DoEvents
'            Conn.execute ("INSERT INTO POLIGONO_SELECAO (OBJECT_ID_,USUARIO,TIPO) VALUES ( '" & TeDatabase1.objectIds(i) & "','" & strUser & "',2)")
'            FrmMain.ProgressBar1.value = i + 1
'         Next
'      End If
'
'   End If
'
'End Function

Private Sub TCanvas_onDblClick(ByVal Button As Long, ByVal x As Double, ByVal y As Double)
On Error GoTo Trata_Erro

'A FUN��O DUPLO CLIQUE � UTILIZADA PARA FECHAR UM POL�GONO QUE EST� SENDO DESENHADO E
'APOS ISSO, INSERIR OS OBJECT_ID_ DAS LINHAS QUE EST�O DENTRO OU NA BORDA DO POL�GONO E O NOME DO
'USU�RIO QUE FEZ A SELE��O EM UMA TABELA CHAMADA POLIGONO_SELEAO

   Me.MousePointer = vbHourglass

   Dim i As Long
   
   geo = TCanvas.Geometry
   blnPoligonoVirtual = True
   
   TeDatabase1.setCurrentLayer "WATERLINES"
   'CARREGA NA VARIAVEL TOTAL A QUANTIDADE DE LINHAS QUE EST�O CONTIDADAS NO POL�GONO
   lngTotalRedesDentro = TeDatabase1.Within(geo, tpPOLYGONS, tpLINES)
   If lngTotalRedesDentro > 0 Then
      ReDim ArrRedesDentro(lngTotalRedesDentro - 1) 'REDIMENSIONA O ARRAY
      FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalRedesDentro
      For i = 0 To lngTotalRedesDentro - 1
         DoEvents
         ArrRedesDentro(i) = TeDatabase1.objectIds(i)
         FrmMain.ProgressBar1.value = i + 1
      Next
   Else
      lngTotalRedesDentro = 0
   End If
    
   lngTotalRedesDivisa = TeDatabase1.Crosses(geo, tpPOLYGONS, tpLINES)
   If lngTotalRedesDivisa > 0 Then
      ReDim ArrRedesDivisa(lngTotalRedesDivisa - 1) 'REDIMENSIONA O ARRAY
      FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalRedesDivisa
      For i = 0 To lngTotalRedesDivisa - 1
         DoEvents
         ArrRedesDivisa(i) = TeDatabase1.objectIds(i)
         FrmMain.ProgressBar1.value = i + 1
      Next
   Else
      lngTotalRedesDivisa = 0
   End If
       
' ###########################################################################################

   TeDatabase1.setCurrentLayer "WATERCOMPONENTS"
   'CARREGA NA VARIAVEL TOTAL A QUANTIDADE DE LINHAS QUE EST�O CONTIDADAS NO POL�GONO
   lngTotalPontosDentro = TeDatabase1.Within(geo, tpPOLYGONS, tpPOINTS)
   If lngTotalPontosDentro > 0 Then
      ReDim ArrPontosDentro(lngTotalPontosDentro - 1) 'REDIMENSIONA O ARRAY
      FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalPontosDentro
      For i = 0 To lngTotalPontosDentro - 1
         DoEvents
         ArrPontosDentro(i) = TeDatabase1.objectIds(i)
         FrmMain.ProgressBar1.value = i + 1
      Next
   Else
      lngTotalPontosDentro = 0
   End If
    
   lngTotalPontosDivisa = TeDatabase1.Crosses(geo, tpPOLYGONS, tpPOINTS)
   If lngTotalPontosDivisa > 0 Then
      ReDim ArrPontosDivisa(lngTotalPontosDivisa - 1) 'REDIMENSIONA O ARRAY
      FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalPontosDivisa
      For i = 0 To lngTotalPontosDivisa - 1
         DoEvents
         ArrPontosDivisa(i) = TeDatabase1.objectIds(i)
         FrmMain.ProgressBar1.value = i + 1
      Next
   Else
      lngTotalPontosDivisa = 0
   End If
       
       
' ###########################################################################################
   
   TeDatabase1.setCurrentLayer "RAMAIS_AGUA"
   lngTotalRamaisDentro = TeDatabase1.Within(geo, tpPOLYGONS, tpLINES)
   If lngTotalRamaisDentro > 0 Then
      ReDim ArrRamaisDentro(lngTotalRamaisDentro - 1) 'REDIMENSIONA O ARRAY
      FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalRamaisDentro
      For i = 0 To lngTotalRamaisDentro - 1
         DoEvents
         ArrRamaisDentro(i) = TeDatabase1.objectIds(i)
         FrmMain.ProgressBar1.value = i + 1
      Next
   Else
      lngTotalRamaisDentro = 0
   End If

    
   lngTotalRamaisDivisa = TeDatabase1.Crosses(geo, tpPOLYGONS, tpLINES)
   If lngTotalRamaisDivisa > 0 Then
      ReDim ArrRamaisDivisa(lngTotalRamaisDivisa - 1) 'REDIMENSIONA O ARRAY
      FrmMain.ProgressBar1.Visible = True: FrmMain.ProgressBar1.value = 1: FrmMain.ProgressBar1.Max = lngTotalRamaisDivisa
      For i = 0 To lngTotalRamaisDivisa - 1
         DoEvents
         ArrRamaisDivisa(i) = TeDatabase1.objectIds(i)
         FrmMain.ProgressBar1.value = i + 1
      Next
   Else
      lngTotalRamaisDivisa = 0
   End If
      
   FrmMain.ProgressBar1.Visible = False
   Me.MousePointer = vbDefault
   
   If lngTotalRedesDentro > 0 Or lngTotalRedesDivisa > 0 Or lngTotalRamaisDentro > 0 Or lngTotalRamaisDivisa > 0 Or lngTotalPontosDentro > 0 Or lngTotalPontosDivisa > 0 Then
       
       frmAtualizarSetores.Show 1
       
   End If
   
   TCanvas.Normal
    
Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Or Err.Number = 13 Then
      Resume Next
   Else
      PrintErro CStr(Me.Name), "Private Sub TCanvas_onEndPlotView", CStr(Err.Number), CStr(Err.Description), True
   End If
End Sub



'Private Sub TCanvas_onBeginPlotView()
'   MsgBox "Inicio: " & tempo & "Fim: " & Time
'End Sub

'############################################################################
'Autor: Luis CLaudio
'Data: 31/08/06
'Especifica��o:
'Este Evento ocorre quando � selecionado um ou mais objetos no canvas
'A rotina dentro do evento  carrega as propridades
'na componente manage1(Gerenciador de Propridades) do Form Principal
'Obs: Havendo apenas um objeto selecionado � disparado .LoadDefaultProperties
'     Havendo mais de um objeto selecionado � disparado .LoadComunsObjects
'##########################################################################

Private Sub TCanvas_onEndPlotView()
On Error GoTo Trata_Erro
   Dim MyScale As Double
   MyScale = TCanvas.getScale
   
   TCanvas.getWorld xmin, ymin, xmax, ymax

   
   ViewName = TeViewDatabase1.getActiveView





'End If
   'CARREGA AS VARI�VEIS GLOBAIS PARA O M�DULO DE IMPRESS�O
   CanvasXmin_ = xmin
   CanvasYmin_ = ymin
   CanvasXmax_ = xmax
   CanvasYmax_ = ymax
   strViewAtiva_ = ViewName
   
   FrmMain.txtEscala.Text = "1 / " & Round(MyScale, 0)
   
   If TCanvas.getCurrentLayer <> "" Then
        strLayerAtivo = TCanvas.getCurrentLayer
   Else
        strLayerAtivo = ""
   End If
   
   TCanvas.ToolTipText = ""
   
   ' p/ corrigir o DrawNetWorkLine - Luis
   If Tr.TerraEvent = 1 Then 'tg_DrawNetWorkline
      With TCanvas
         MyScale = .getScale
         Select Case MyScale
            Case Is < 10
               .tolerance = 0.001
            Case Is < 100
               .tolerance = 0.01
            Case Is < 500
               .tolerance = 0.1
            Case Is < 1000
               .tolerance = 0.5
            Case Is >= 1000
               .tolerance = 1
         End Select
      End With
   Else
      TCanvas.tolerance = 1
   End If
Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
   Else
    
      PrintErro CStr(Me.Name), "Private Sub TCanvas_onEndPlotView", CStr(Err.Number), CStr(Err.Description), True
    
   End If
End Sub

Private Sub TCanvas_onEndSELECT()
On Error GoTo Trata_Erro

   Dim strDistrito As String
   Dim IdDistrito As Integer

   Dim i As Integer, j As Integer, VarObj As String, frm As New FrmAssociation
   With FrmMain.Manager1
      If TCanvas.getSelectCount(2) Or TCanvas.getSelectCount(4) Or TCanvas.getSelectCount(1) Then
         .GridEnabled True: .GridVisibled True
         Select Case Tr.cgeo.GetLayerTypeReference(TCanvas.getCurrentLayer)
            
            Case LayerTypeRefence.Trecho_Rede_Agua, LayerTypeRefence.Trecho_Rede_Drenagem, LayerTypeRefence.Trecho_Rede_esgoto, _
               LayerTypeRefence.Componente_Rede_Agua, LayerTypeRefence.Componente_Rede_Drenagem, LayerTypeRefence.Componente_Rede_Esgoto
               'Verifica a sele��o apenas das geometrias 2(linhas) e 4(Pontos)
               For j = 2 To 4 Step 2
                  
                  Dim x As String
                  x = TCanvas.getSelectObjectId(0, 2) ' LINHAS
                  
                  If TCanvas.getSelectCount(j) = 1 Then
                     .LoadDefaultProperties TCanvas.getSelectObjectId(0, j), TCanvas.getCurrentLayer, False
                  
                  ElseIf TCanvas.getSelectCount(j) > 1 Then
                     For i = 0 To TCanvas.getSelectCount(j) - 1
                        With TCanvas
                           VarObj = IIf(i, VarObj & "," & .getSelectObjectId(i, j), .getSelectObjectId(i, j))
                        End With
                     Next
                      'Carrega Prorpiedades Properties Manager
                     .LoadComunsObjects VarObj, TCanvas.getCurrentLayer, FrmMain.mnuMultProperteis.Checked
                  End If
                  
                  FrmMain.TabStrip1.Tabs(2).Selected = True
                  Tr.TerraEvent = tg_SelectObject 'Define o evento de selecao para a classe
               
               Next
            
            Case LayerTypeRefence.DOCUMENTOS
               If TCanvas.getSelectCount(points) = 1 Then
                  If LastDocument <> TCanvas.getSelectObjectId(0, points) Then
                     LastDocument = TCanvas.getSelectObjectId(0, points)
                     frm.init TCanvas.getSelectObjectId(0, points), TCanvas, TeDatabase1
                  Else
                    LastDocument = ""
                  End If
               End If
            
            Case LayerTypeRefence.OUTROS
               If TCanvas.getSelectCount(1) = 1 Then
                  .LoadDefaultProperties TCanvas.getSelectObjectId(0, 1), TCanvas.getCurrentLayer, False
               ElseIf TCanvas.getSelectCount(2) = 1 Then
                  .LoadDefaultProperties TCanvas.getSelectObjectId(0, 2), TCanvas.getCurrentLayer, False
               ElseIf TCanvas.getSelectCount(4) = 1 Then
                  .LoadDefaultProperties TCanvas.getSelectObjectId(0, 4), TCanvas.getCurrentLayer, False
               ElseIf TCanvas.getSelectCount(128) = 1 Then
                  .LoadDefaultProperties TCanvas.getSelectObjectId(0, 128), TCanvas.getCurrentLayer, False
               End If
               FrmMain.TabStrip1.Tabs(2).Selected = True
            
            
            Case LayerTypeRefence.Poligonos
               

              ' idPoligonSel = TCanvas.getSelectObjectId(0, 1)
                 idPoligonSel = TCanvas.getSelectGeoId(0, 1)
               strLayerAtivo = TCanvas.getCurrentLayer
               
               
            Case LayerTypeRefence.RAMAIS_AGUA, LayerTypeRefence.RAMAIS_ESGOTO
               Set Tr.tcs = TCanvas
               Set Tr.tdbconref = TeDatabase2
               Tr.tdbconref.setCurrentLayer Tr.cgeo.GetLayerOperation(TCanvas.getCurrentLayer, 2)
               

               If TCanvas.getSelectCount(lines) Then
                  Tr.OnRamal Position_X, Position_Y, TCanvas.getSelectObjectId(0, lines)
               ElseIf TCanvas.getSelectCount(points) Then
                  Tr.OnRamal Position_X, Position_Y, TCanvas.getSelectObjectId(0, points)
               End If
               
               
               Tr.TerraEvent = tg_SelectObject
         End Select
      Else
         .GridEnabled False: .GridVisibled False: FrmMain.TabStrip1.Tabs(1).Selected = True
      End If
   End With
   FrmMain.SizeControls
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
    Else
       
       PrintErro CStr(Me.Name), "Private Sub TCanvas_onEndSELECT", CStr(Err.Number), CStr(Err.Description), True
       
    End If
End Sub

Private Sub TCanvas_onIntersectionPoint(ByVal x As Double, ByVal y As Double)
On Error GoTo Trata_Erro
   TeDatabase1.moveNetWorkNodeTo "watercomponents", "WATERLINES", "", , x, y
Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
   Else
    
      PrintErro CStr(Me.Name), "Private Sub TCanvas_onIntersectionPoint", CStr(Err.Number), CStr(Err.Description), True
      
   End If
End Sub

Private Sub TCanvas_onKeyPress(ByVal key As Long)
On Error GoTo Trata_Erro
   Dim retval As String
   
   'Evento de captura de tecla utilizada
   'A tecla PageUp faz a fun��o de ZOOM OUT(afastamento)
   'A tecla PageDown faz a fun��o de ZOOM IN(aproxima��o)
   
   '� utilizado um arquivo externo (geosan.ini) para armazenar o fator de zoom que ser� aplicado quando a fun��o for chamada
   
   'Vari�veis carregadas no evento MouseMove Position_X e Position_Y possuem coordenadas do mouse
   
   '� feita centraliza��o do mapa no local do ponteiro do mouse antes do zoom
'
'   TCanvas.setWorld Position_X - 50, Position_Y - 50, Position_X - 50, Position_Y - 50
'   TCanvas.plotView
'
'         Dim Scala As Double
'
'         Scala = TCanvas.getScale
         
         
   Select Case key
      Case 27 'ESC
         
         TCanvas.ToolTipText = ""
         
         TCanvas.Normal
         TCanvas.Select
         Tr.TerraEvent = tg_SelectObject
         TCanvas.clearSelectItens 0
         
         TCanvas.clearEditItens 0 '.clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128
         
         LoadToolsBar
      
      Case 33 ' PageUp
         
         TCanvas.zoomIn dblFatorZoomMenos
         'TCanvas.zoomIn = Replace(ReadINI("MAPA", "ZOOM_MAIS", App.path & "\CONTROLES\GEOSAN.ini"), ",", ".")
      
      Case 34 'PageDown
        
         TCanvas.zoomOut dblFatorZoomMais
         'TCanvas.zoomOut = Replace(ReadINI("MAPA", "ZOOM_MENOS", App.path & "\CONTROLES\GEOSAN.ini"), ",", ".")
      
      Case 46 'DEL
         Tr.Delete
      Case 87
         TCanvas.verticalPan 50
      Case 90
         TCanvas.verticalPan -50
      Case 65
         TCanvas.horizontalPan -50
      Case 83
         TCanvas.horizontalPan 50
   End Select
    

Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
    Else
       
       PrintErro CStr(Me.Name), "Private Sub TCanvas_onKeyPress", CStr(Err.Number), CStr(Err.Description), True
      
    End If
End Sub

Private Sub TCanvas_onKeyUp(ByVal key As Long, ByVal Shift As Long, ByVal ctrl As Long)
On Error GoTo Trata_Erro


If key = 13 Then 'ENTER
    FrmMain.ActiveForm.Tb_SELECT "ksave"
End If


Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
   Else
    
      PrintErro CStr(Me.Name), "Private Sub TCanvas_onKeyUP", CStr(Err.Number), CStr(Err.Description), True
       
   End If

End Sub



Private Sub TCanvas_onLine(ByVal distance As Double)
On Error GoTo Trata_Erro
   If Tr.TerraEvent = tg_DrawRamal Then 'SE ESTA DESENHANDO RAMAL
      Tr.OnRamal Position_X, Position_Y, ""
   End If
   
  
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
    Else
       
       PrintErro CStr(Me.Name), "Private Sub TCanvas_onLine", CStr(Err.Number), CStr(Err.Description), True
       
    End If
End Sub

'Procedimento que carrega no trevview do main os temas do tcanvas corrente
Private Function LoadThemes() 'ViewName As String)
''On Error GoTo Trata_Erro


   If Not TCanvas Is Nothing Then
      Screen.MousePointer = vbHourglass
      DoEvents
    
      
      If ViewName <> "" Then
      
'TeViewDatabase1.connection = Conn

         TeViewDatabase1.setActiveView ViewName
      Else
         ViewName = TeViewDatabase1.getActiveView
       
      End If

      With FrmMain.ViewManager1
         Set .tcs = TCanvas
       
          
         Set .tvw = TeViewDatabase1
      
         
         Set .mConn = Conn
          

         .Provider = typeconnection
         FrmMain.txtEscala.Text = "1 / " & Round(TCanvas.getScale, 0)
         .start
         Select Case Tr.TerraEvent
            Case tg_DrawNetWorkline
               .LoadImageSnap Tr.cgeo.GetReferenceLayer(TCanvas.getCurrentLayer), mOnSnapLock
         End Select
         .LoadImageSnap TCanvas.getCurrentLayer, mOnSet
      End With
     
      Me.Caption = "Vista: " & TeViewDatabase1.getActiveView
     
         
 
      Screen.MousePointer = vbNormal
      If Tr.TerraEvent = tg_DrawNetWorkline Then
         frmNetWorkLegth.init TCanvas, FrmMain
         Dim Lh As Double
         TCanvas.getLengthOfLastSegmentOfLine Lh
         frmNetWorkLegth.txtLength.Text = Lh
      Else
         Unload frmNetWorkLegth
      End If
   End If
Trata_Erro:

  '  If Err.Number = 0 Or Err.Number = 20 Then
    '   Resume Next
    'Else
       
    '  PrintErro CStr(Me.Name), "Private Function LoadThemes", CStr(Err.Number), CStr(Err.Description), True
       
  ' End If
End Function

Private Sub TCanvas_onMouseDown(ByVal Button As Long, ByVal x As Double, ByVal y As Double)

On Error GoTo Trata_Erro
    
            
   X1 = 0 'passa as coordenadas para calculo e exibi��o
   Y1 = 0
    
    If Button = 1 And FrmMain.tbToolBar.Buttons("kdrawnetworkline").value = tbrPressed Then
        Select Case LastEvent
            Case tg_DrawNetWorkline
                Tr.DrawNetWorkLine True
            Case tg_MoveNetWorkNode
                Tr.MoveNetWorkNode True
        End Select
    ElseIf Button = 0 Then
        If Tr.TerraEvent = tg_DrawNetWorkNode Then

            Tr.SaveInDatabase: FrmMain.Manager1.GridEnabled True
            With TCanvas
                .Normal
                .Select: Tr.TerraEvent = tg_SelectObject
                .clearEditItens 1: .clearEditItens 2: .clearEditItens 4: .clearEditItens 128
            End With
            LoadToolsBar
        
        ElseIf Tr.TerraEvent = tg_DrawRamal Then
        
       If UCase(TCanvas.getCurrentLayer) = "RAMAIS_AGUA" Or UCase(TCanvas.getCurrentLayer) = "RAMAIS_ESGOTO" Then
           
        
        
        
            'ESTA DESENHANDO RAMAL, CAPTURA O PRIMEIRO CLIQUE DO MOUSE E TESTA SE ESTE CLIQUE
            'FOI FEITO SOBRE UMA REDE
            
            If CLIQUE_RAMAL = 0 Then
               
               'VERIFICA SE O LAYER CORRENTE � O DE RAMAIS DE AGUA OU ESGOTO
               'SE FOR O DE AGUA, SETA O CURRENT LAYER DO TEDATABASE PARA RAMAIS_AGUA
               'SE FOR O DE ESGOTO, SETA O CURRENT LAYER DO TEDATABASE PARA RAMAIS_ESGOTO
               If UCase(TCanvas.getCurrentLayer) = "RAMAIS_AGUA" Then
                  TeDatabaseRamais.setCurrentLayer "WATERLINES"
               Else
                  TeDatabaseRamais.setCurrentLayer "SEWERLINES"
               End If
               
               
            
               
               
               
               
               'VERIFICA SE O USU�RIO CLICOU SOBRE UMA REDE DE AGUA OU ESGOTO
               intQtdLinhasNaCoordenada = TeDatabaseRamais.locateGeometry(x, y, tpLINES, 1)
               
                '  intQtdLinhasNaCoordenada = TeDatabaseRamais.locateGeometryXY(x, y, tpLINES)
                  
     
               'CASO N�O, EXIBE MENSAGEM E REINICIA O PROCESSO
               If intQtdLinhasNaCoordenada = 0 Then
                  
                  MsgBox "Inicie o desenho do ramal partindo do trecho de rede.", vbInformation, ""
                  TCanvas.Normal
                  TCanvas.Select
                  CLIQUE_RAMAL = 0
                  TCanvas.clearSelectItens 0 'desmarca se h� item selecionado
                  Tr.DrawRamal 'reinicia o processo de cadastramento de ramal
                  Tr.TerraEvent = tg_DrawRamal
                
               'CASO H� MAIS DE UMA REDE SOB O CLIQUE, EXIBE MENSAGEM E REINICIA O PROCESSO
               ElseIf intQtdLinhasNaCoordenada > 1 Then
                  
                  MsgBox "Foi identificado mais de um trecho de rede no local selecionado." & Chr(13) & Chr(13) & "tente novamente.", vbInformation, ""
                  TCanvas.Normal
                  TCanvas.Select
                  CLIQUE_RAMAL = 0
                  TCanvas.clearSelectItens 0 'desmarca se h� item selecionado
                  Tr.DrawRamal 'reinicia o processo de cadastramento de ramal
                  Tr.TerraEvent = tg_DrawRamal
               
               'CASO SIM, CAPTURA O OBJECT_ID_ DA REDE QUE FOI SELECIONADA E PASSA
               'PARA A VARI�VEL QUE VAI SALVAR O RAMAL
               Else
                  
                  ramal_Object_id_trecho = TeDatabaseRamais.objectIds(0)
                  'TCanvas.ToolTipText = "Rede: " & ramal_Object_id_trecho
                  'GUARDA A INFORMA��O DE QUE O PRIMEIRO CLIQUE JA FOI DADO PARA DESENHAR O RAMAL
                  CLIQUE_RAMAL = 1
               End If
            
            Else
                CLIQUE_RAMAL = 0
                
            End If
        
        ElseIf Tr.TerraEvent = tg_DrawNetWorkline Or Tr.TerraEvent = tg_MoveNetWorkNode Then
            
            FrmMain.Manager1.GridEnabled True
            
            X1 = x 'passa as coordenadas para calculo e exibi��o
            Y1 = y
            
        Else
            FrmMain.Manager1.GridEnabled False
            
        End If
        End If
    End If
Trata_Erro:
    
    
    If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
    ElseIf Err.Number = -2147467259 Then
       
       PrintErro CStr(Me.Name), "Private Sub TCanvas_onMouseDown", CStr(Err.Number), CStr(Err.Description), True
       End
    Else
       PrintErro CStr(Me.Name), "Private Sub TCanvas_onMouseDown", CStr(Err.Number), CStr(Err.Description), True
    End If
End Sub

Private Sub TCanvas_onMouseMove(ByVal x As Double, ByVal y As Double, ByVal lat As String, ByVal lon As String)
On Error GoTo Trata_Erro

Dim TBP As String
Dim TBA As String
Dim pesquisar As Boolean
Dim dist As Integer
Dim COMP As Double


   pesquisar = False
   If (xOld - x) > 3 Or (x - xOld) > 3 Then
      xOld = x
      pesquisar = True
      'TCanvas.ToolTipText = ""
   ElseIf (yOld - y) > 3 Or (y - yOld) > 3 Then
      yOld = y
      pesquisar = True
      'TCanvas.ToolTipText = ""
   End If

   If pesquisar = True Then
      'PEGAR O NOME DA TABELA NO GEOSAN.INI
      
      If UCase(TCanvas.getCurrentLayer) = UCase("RAMAIS_AGUA") Or _
         UCase(TCanvas.getCurrentLayer) = UCase("RAMAIS_ESGOTO") Then
         
         If ReadINI("RAMAISFILTROLOTES", "ATIVADO", App.path & "\CONTROLES\GEOSAN.INI") = "SIM" Then
            
            TBP = ReadINI("RAMAISFILTROLOTES", "TABELA_PLANO", App.path & "\CONTROLES\GEOSAN.INI")
            TBA = ReadINI("RAMAISFILTROLOTES", "TABELA_ATRIB", App.path & "\CONTROLES\GEOSAN.INI")
            
            
            Call Pesquisa_Dados_Lote(x, y, lat, lon, TBA, TBP)
   
         End If
   
      End If
   End If
   
   FrmMain.sbStatusBar.Panels(4).Text = "x: " & Round(x, 2) & " - y:" & Round(y, 2)
   
   If X1 <> 0 Then ' SE A VARIAVEL DE PRIMEIRO CLICK ESTIVER ZERADA...
      COMP = Sqr((Abs(x - X1) ^ 2) + (Abs(y - Y1) ^ 2))
      FrmMain.sbStatusBar.Panels(1).Text = "Comprimento da rede: " & Format(COMP, "0.00") & " m"
      'TCanvas.ToolTipText = Format(COMP, "0.00") & " m"
   'Else
      'FrmMain.sbStatusBar.Panels(1).Text = ""
   End If
   
   
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
    ElseIf Err.Number = 11 Then
       Exit Sub
    Else
       MsgBox Err.Number
       PrintErro CStr(Me.Name), "Private Sub TCanvas_onMouseMove", CStr(Err.Number), CStr(Err.Description), True
       
    End If
End Sub

Sub Pesquisa_Dados_Lote(ByVal x As Double, ByVal y As Double, ByVal lat As String, ByVal lon As String, ByVal TBAtributo As String, ByVal TBPlano As String)

On Error GoTo Trata_Erro
      Dim rs As ADODB.Recordset
      Dim Obj As String, str As String, Mystep As String

      

      'PEGAR O NOME DA TABELA NO GEOSAN.INI
      'saber a tabela de geometrias
      
      



      
   If typeconnection <> 4 Then
      
      
      
      TeDatabase1.connection = Conn
      Else
   TeDatabase2.Provider = typeconnection


      TeDatabase1.connection = TeAcXConnection1.objectConnection_

      End If
      '
      'tabela = "LOTES_PREF"
      If TBPlano <> "" And TBAtributo <> "" Then
      
         TeDatabase1.setCurrentLayer CStr(TBPlano)
         
         If TeDatabase1.locateGeometryXY(x, y, tpPOLYGONS) = 1 Then
            
            'LOCALIZADA 1 GEOMETRIA DE POLIGONO DE LOTE
            'LOCALIZAR NA TABELA DE ATRIBUTO QUAL IPTU DO LOTE
            
            idAutoLote = TeDatabase1.objectIds(0)
            Dim ba As String
            Dim be As String
            Dim bi As String
             Dim h As String
            ba = "CADASTRO"
            be = TBAtributo
            h = "be"
            bi = "LOTE_ID"
            
            If frmCanvas.TipoConexao <> 4 Then
            
            str = "SELECT CADASTRO AS " + """" + "IPTU" + """" + " FROM " & TBAtributo & " WHERE LOTE_ID = '" & idAutoLote & "'"
            Else
            str = "SELECT " + """" + ba + """" + " AS " + """" + "IPTU" + """" + " FROM " + """" + TBAtributo + """" + " WHERE " + """" + bi + """" + " = '" & idAutoLote & "'"
            End If
            
            Set rs = New ADODB.Recordset
           ' rs.Open str, Conn, adOpenForwardOnly, adLockReadOnly
           rs.Open str, Conn, adOpenDynamic, adLockOptimistic
            If rs.EOF = False Then

                TCanvas.ToolTipText = "IPTU: " & rs!IPTU

            End If
            rs.Close

         Else
         
            TCanvas.ToolTipText = ""
         
         End If
    
End If
      Position_X = x
      Position_Y = y
      'FrmMain.sbStatusBar.Panels(4).Text = "x: " & Round(x, 2) & " - y:" & Round(y, 2)
      Set rs = Nothing
Exit Sub

Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
      Resume Next
   Else
    
      PrintErro CStr(Me.Name), "Sub Pesqisa_Dados_Lotes", CStr(Err.Number), CStr(Err.Description), True
      
   End If
End Sub

'Private Sub txtEdit_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'    If Button = 2 Then 'Bot�o direito foi pressionado
'    End If
'End Sub

Private Sub TCanvas_onMouseUp(ByVal Button As Long, ByVal x As Double, ByVal y As Double)
On Error GoTo Trata_Erro
   If Button = 0 Then 'BOT�O ESQUERDO DO MOUSE
      'PopupMenu
   ElseIf Button = 1 Then
      Dim Lh As Double
      TCanvas.getLengthOfLastSegmentOfLine Lh
      frmNetWorkLegth.txtLength.Text = Lh
   End If
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
    Else
       
       PrintErro CStr(Me.Name), "Private Sub TCanvas_onMouseUp", CStr(Err.Number), CStr(Err.Description), True
    
    End If
End Sub

Private Sub TCanvas_onPoint(ByVal x As Double, ByVal y As Double)
On Error GoTo Trata_Erro
   Select Case Tr.TerraEvent
      Case tg_DrawNetWorkNode
         Tr.SaveInDatabase
'      Case tg_DrawPoint
'         Tr.OnPoint x, y
      Case tg_DrawGeometrys
         Tr.OnPoint x, y
      Case tg_DrawRamal
         Tr.OnRamal x, y, True
   End Select
Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
   Else
      PrintErro CStr(Me.Name), "Private Sub TCanvas_onPoint", CStr(Err.Number), CStr(Err.Description), True
      
   End If

End Sub

'###########################################################################
'ROTINA QUE SALVA OS DADOS VERTORIAIS DAS REDES
'LINE_ID = NOVA LINHA
'NODE_ID1 = NOVO N� OU N� EXISTENTE
'NODE_ID2 = NOVO N�
'###########################################################################

'AP�S O SAVEINDATABASE O TECANVAS RETORNA, ATRAV�S DO M�TODO OnSaveNetworkLine
'OS C�DIGOS GEOM_ID DOS PONTOS CRIADOS E O CODIGO LINE_ID DA LINHA CRIADA.
'SENDO NOVOS OU N�O, OS C�DIGOS DE PONTOS S�O RETORNADOS
'SE RETORNADO 0(ZERO) PARA ALGUM PONTO, SIGNIFICA QUE A REDE EST� SENDO MOVIDA
'NESTE CASO ENT�O DEVE SER EXCLUIDO E REFEITO O TEXTO DAS LINHAS QUE EST�O SENDO MOVIDAS



Private Sub TCanvas_onSaveNetWorkLine(ByVal LINE_ID As Long, ByVal Node_id1 As Long, ByVal Node_id2 As Long)
On Error GoTo Trata_Erro

Dim TbGeometriaLinhas As String
Dim TbGeometriaPontos As String

Dim CompCalc As Long
Dim CompCalc2 As Long
Dim CompCalc3 As Double

Dim LayerName As String
Dim RefLayer As String



a = "LENGTHCALCULATED"
b = "USUARIO_LOG"
c = "INSCRICAO_LOTE"
d = "DATA_LOG"
e = "OBJECT_ID_"
f = Replace(Round(CompCalc3, 2), ",", ".")
g = Format(Now, "DD/MM/YY HH:MM")
h = RefLayer
X1 = 0 ' ZERA A COORDENADA DE PRIMEIRO CLIQUE USADA PARA CALCULO DA DIST�NCIA

LayerName = TCanvas.getCurrentLayer
RefLayer = TCanvas.GetReferenceLayer

If Node_id1 = 0 Or Node_id2 = 0 Then 'ESTA MOVENDO A REDE

   'CALCULAR O NOVO COMPRIMENTO DA LINHA E ATUALIZAR NA BASE
   TeDatabase1.setCurrentLayer RefLayer
   
   'OBTEM NA VARI�VEL CompCalc O COMPRIMENTO DA LINHA
   TeDatabase1.getLengthOfLine LINE_ID, CStr(LINE_ID), CompCalc3
    If frmCanvas.TipoConexao <> 4 Then
   'ATUALIZAR O COMPRIMENTO DA REDE, USU�RIO E DATA DE ATUALIZA��O
   Conn.execute ("UPDATE " & RefLayer & " SET LENGTHCALCULATED = " & Replace(Round(CompCalc3, 2), ",", ".") & ", USUARIO_LOG = '" & strUser & "', DATA_LOG = '" & Format(Now, "DD/MM/YY HH:MM") & "' WHERE OBJECT_ID_ = '" & LINE_ID & "'")
  Else
  'MsgBox "UPDATE  " + """" + h + """" + "SET " + """" + a + """" + " =  '" & Replace(Round(CompCalc3, 2), ",", ".") & "', " + """" + b + """" + " = '" & strUser & "', " + """" + d + """" + "= '" & Format(Now, "DD/MM/YY HH:MM") & "' WHERE " + """" + e + """" + " = '" & LINE_ID & "'"
   'UPDATE "DRAINLINES" SET "LENGTHCALCULATED" = CAST(regexp_replace ('34', '3', '1') As Integer), "USUARIO_LOG" = 'Administrador', "DATA_LOG" = 'Format(Now, "DD/MM/YY HH:MM")' WHERE "OBJECT_ID_" = '5'
   Conn.execute ("UPDATE  " + """" + RefLayer + """" + "SET " + """" + a + """" + " =  '" & Replace(Round(CompCalc3), ",", ".") & "', " + """" + b + """" + " = '" & strUser & "', " + """" + d + """" + "= '" & Format(Now, "DD/MM/YY HH:MM") & "' WHERE " + """" + e + """" + " = '" & LINE_ID & "'")
   
   End If
   'CHAMA O M�TODO DE EXCLUIR E CRIAR TEXTOS DENTRO DO M�TODO Tr.CreatNetWorkAttribute
   Tr.CreatNetWorkAttribute LINE_ID, Node_id1, Node_id2, True
   
   FrmMain.sbStatusBar.Panels(1).Text = "Rede " & LINE_ID & " movida com sucesso."

Else  'EST� DESENHANDO A REDE
   
   Dim JaExisteRede As Boolean
   JaExisteRede = False
   
   TbGeometriaLinhas = LCase(TeDatabase1.getRepresentationTableName(TCanvas.getCurrentLayer, tpLINES))
   TbGeometriaPontos = LCase(TeDatabase1.getRepresentationTableName(TCanvas.GetReferenceLayer, tpPOINTS))
   
   'VERIFICA SE N�O JA EXISTE UMA REDE COM ESTES MESMOS N�S INICIAIS E FINAIS
   Dim rs As ADODB.Recordset
   Set rs = New ADODB.Recordset 'alterado em 20/10/2010
   Dim dt As String
   Dim dm As String
   Dim dg As String
   Dim dv As String
   dv = "OBJECT_ID_"
   dt = "INITIALCOMPONENT"
   dm = "FINALCOMPONENT"
   dg = "d"
   
   If frmCanvas.TipoConexao <> 4 Then

  
   rs.Open ("SELECT OBJECT_ID_ FROM " & LayerName & " WHERE INITIALCOMPONENT = '" & Node_id1 & "' AND FINALCOMPONENT = '" & Node_id2 & "'"), Conn, adOpenForwardOnly, adLockReadOnly
   Else
  rs.Open ("SELECT " + """" + dv + """" + " FROM " + """" + LayerName + """" + " WHERE " + """" + dt + """" + " = '" & Node_id1 & "' AND " + """" + dm + """" + " = '" & Node_id2 & "'"), Conn, adOpenDynamic, adLockOptimistic
  End If
  
   If rs.EOF = False Then
      JaExisteRede = True

      
 Else
  
  
  
      Set rs = New ADODB.Recordset
If frmCanvas.TipoConexao <> 4 Then

      rs.Open ("SELECT OBJECT_ID_ FROM " & LayerName & " WHERE FINALCOMPONENT = '" & Node_id1 & "' AND INITIALCOMPONENT = '" & Node_id2 & "'"), Conn, adOpenForwardOnly, adLockReadOnly
      Else
      rs.Open ("SELECT " + """" + dv + """" + " FROM " + """" + LayerName + """" + " WHERE " + """" + dm + """" + " = '" & Node_id1 & "' AND " + """" + dt + """" + " = '" & Node_id2 & "'"), Conn, adOpenDynamic, adLockOptimistic
      End If
      If rs.EOF = False Then
         JaExisteRede = True
      End If
   End If
   rs.Close
   

    
  

   
   If JaExisteRede = True Then
       MsgBox "J� existe uma rede desenhada entre estas 2 pe�as.", vbExclamation, ""
       
       'DELETA GEOMETRIA DE LINHA QUE FOI CRIADA
       If frmCanvas.TipoConexao <> 4 Then
       Conn.execute ("DELETE FROM " & TbGeometriaLinhas & " WHERE GEOM_ID = " & LINE_ID)
       Else
       Dim ga As String
       ga = "geom_id"
        Conn.execute ("DELETE FROM " + """" + TbGeometriaLinhas + """" + " WHERE " + """" + ga + """" + " = '" & LINE_ID & "'")
       End If
       
   
       FrmMain.sbStatusBar.Panels(1).Text = "Rede " & LINE_ID & " n�o criada."
       
       'SAI DO EVENTO
       Exit Sub
   End If
a = "tbgeometrialinhas"
b = "object_id"
c = "geom_id"


  
   'ATUALIZA OS OBJECTS_ID COM O MESMO C�DIGO DO AUTO NUMERADOR
   
    If frmCanvas.TipoConexao <> 4 Then
         
   Conn.execute ("UPDATE " & TbGeometriaLinhas & " SET OBJECT_ID = GEOM_ID WHERE GEOM_ID = " & LINE_ID)
   Conn.execute ("UPDATE " & TbGeometriaPontos & " SET OBJECT_ID = GEOM_ID WHERE GEOM_ID = " & Node_id1)
   Conn.execute ("UPDATE " & TbGeometriaPontos & " SET OBJECT_ID = GEOM_ID WHERE GEOM_ID = " & Node_id2)
     Else
     
     Conn.execute ("UPDATE " + """" & TbGeometriaLinhas & """" + " SET " + """" + "object_id" + """" + " = " + """" + "geom_id" + """" + " WHERE " + """" + "geom_id" + """" + " =  '" & LINE_ID & "'")
     Conn.execute ("UPDATE " + """" & TbGeometriaPontos & """" + " SET " + """" + "object_id" + """" + " = " + """" + "geom_id" + """" + " WHERE " + """" + "geom_id" + """" + " =  '" & Node_id1 & "'")
     Conn.execute ("UPDATE " + """" & TbGeometriaPontos & """" + " SET " + """" + "object_id" + """" + " = " + """" + "geom_id" + """" + " WHERE " + """" + "geom_id" + """" + " =  '" & Node_id2 & "'")
   
     End If
     

   Tr.CreatNetWorkAttribute LINE_ID, Node_id1, Node_id2, False
   
   FrmMain.sbStatusBar.Panels(1).Text = "Rede " & LINE_ID & " salva com sucesso."


     End If
    
    
    
    
Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
   Else
    
      PrintErro CStr(Me.Name), "Private Sub TCanvas_onSaveNetWorkLine", CStr(Err.Number), CStr(Err.Description), True
    
   End If
End Sub

Private Sub TCanvas_onSaveNetWorkNode(ByVal node_id As Long, ByVal line1_id As Long, ByVal line2_id As Long)
On Error GoTo Trata_Erro

a = "TBGEOMETRIALINHAS"
b = "object_id"
c = "geom_id"
d = "TBGEOMETRIAPONTOS"



   'AO INSERIR OU MOVER UM N� DE REDE EM UMA REDE JA EXISTENTE, ENTRA NESTE M�TODO
   'O NODE_ID � O C�DIGO DO NOVO N�, LINE1_ID � A LINHA JA EXISTENTE E
   'A LINE2_ID � A GEOMETRIA SALVA PELO TE_CANVAS PARA A NOVA LINHA
   'CASO SEJA RETORNADO 0(ZERO) PARA ALGUMA DAS LINHAS SIGNIFICA QUE O N� DE REDE FOI MOVIDO
   
TCanvas.ToolTipText = ""
X1 = 0 ' ZERA A COORDENADA DE PRIMEIRO CLIQUE USADA PARA CALCULO DA DIST�NCIA

If line1_id = 0 Or line2_id = 0 Then 'O N� DE REDE FOI MOVIDO E DEVER� SOFRER ALTERA��ES SOMENTE SE FOR PE�A DE ESGOTO

   Tr.CreatNetWorkNode node_id, line1_id, line2_id, True


Else

     Dim TbGeometriaPontos As String
     Dim TbGeometriaLinhas As String
     
   'ATUALIZA O OBJECT_ID DA LINHA RECEM CRIADA NA TABELA LINES
   
   
    If frmCanvas.TipoConexao <> 4 Then
   TbGeometriaLinhas = LCase(TeDatabase1.getRepresentationTableName(TCanvas.getCurrentLayer, tpLINES))
   
      Conn.execute ("UPDATE " & TbGeometriaLinhas & " SET OBJECT_ID = GEOM_ID WHERE GEOM_ID = " & line2_id)
   
     
   
   'ATUALIZA O OBJECT_ID DA POINTS COM O MESMO C�DIGO DO AUTO NUMERADOR DO TeCanvas
   TbGeometriaPontos = LCase(TeDatabase1.getRepresentationTableName(TCanvas.GetReferenceLayer, tpPOINTS))
   Conn.execute ("UPDATE " & TbGeometriaPontos & " SET OBJECT_ID = GEOM_ID WHERE GEOM_ID = " & node_id)
  Else
    TbGeometriaLinhas = LCase(TeDatabase1.getRepresentationTableName(TCanvas.getCurrentLayer, tpLINES))
   
   
Conn.execute ("UPDATE " + """" + TbGeometriaLinhas + """" + " SET " + """" + b + """" + " = " + """" + c + """" + " WHERE " + """" + c + """" + " = '" & line2_id & " '")
     
   
   'ATUALIZA O OBJECT_ID DA POINTS COM O MESMO C�DIGO DO AUTO NUMERADOR DO TeCanvas
   TbGeometriaPontos = LCase(TeDatabase1.getRepresentationTableName(TCanvas.GetReferenceLayer, tpPOINTS))
   Conn.execute ("UPDATE " + """" + TbGeometriaPontos + """" + " SET " + """" + b + """" + " = " + """" + c + """" + " WHERE " + """" + c + """" + " = '" & node_id & " '")
   End If
   
   Tr.CreatNetWorkNode node_id, line1_id, line2_id, False
   
   FrmMain.sbStatusBar.Panels(1).Text = "Componente " & node_id & " criado com sucesso."
   
End If
   
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
    Else
       
       PrintErro CStr(Me.Name), "Private Sub TCanvas_onSaveNetWorkLine", CStr(Err.Number), CStr(Err.Description), True
       
    End If
End Sub

Private Sub TCanvas_onSnap(ByVal distance1 As Double, ByVal distance2 As Double)
On Error GoTo Trata_Erro
    
    If FrmMain.tbToolBar.Buttons("kinsertnetworknode").value = tbrPressed Then
        Dim xmin As Double, xmax As Double, ymin As Double, ymax As Double
        Call TeDatabase1.getGeometryBox(0, TCanvas.getSelectObjectId(0, 2), tpLINES, xmin, ymin, xmax, ymax)
        If (Position_X >= xmin And Position_X <= xmax) And (Position_Y >= ymin And Position_Y <= ymax) Then
            txtRede1.Text = distance1
            txtRede2.Text = distance2
        End If
    End If
   
Trata_Erro:
   If Err.Number = 0 Or Err.Number = 20 Then
       Resume Next
   Else
      
      PrintErro CStr(Me.Name), "Private Sub TCanvas_onSnap", CStr(Err.Number), CStr(Err.Description), True
   End If
End Sub




Private Sub TimerSetWorld_Timer()
On Error GoTo Trata_Erro
   'timer para inicializar o m�todo SetWorld do TeCanvas
   
   If xWorld > 0 And yWorld > 0 Then
      
      TCanvas.setWorld xWorld - 100, yWorld - 100, xWorld + 100, yWorld + 100
      
      If blnLocalizandoConsumidor = True Then
         blnLocalizandoConsumidor = False
         TCanvas.setScale 80
      End If

      xWorld = 0
      TCanvas.plotView

   End If
   
   If canvasScale > 0 Then
      TCanvas.setScale canvasScale
      canvasScale = 0
   End If
   

   
   'TimerSetWorld.Enabled = False
Trata_Erro:

End Sub

Public Function FunDecripta(ByVal strDecripta As String) As String


    Dim IntTam As Integer
    Dim i As Integer
    Dim letra As String
    IntTam = Len(strDecripta)
    nStr = ""

    'desconsidera os os numeros de HH-MM-SS
    strDecripta = mid(strDecripta, 6, 5) & mid(strDecripta, 16, 5) & mid(strDecripta, 26, 5) & _
                  mid(strDecripta, 36, 5) & mid(strDecripta, 46, 5) & mid(strDecripta, 56, 200)

    i = 1
    Do While Not i = IntTam - 29
        letra = mid(strDecripta, i, 5)
        Select Case letra
        Case "14334"
            nStr = nStr & "a"
        Case "14212"
            nStr = nStr & "A"
        Case "24334"
            nStr = nStr & "�"
        Case "24134"
            nStr = nStr & "�"
        Case "24234"
            nStr = nStr & "�"
        Case "24314"
            nStr = nStr & "�"
        Case "24324"
            nStr = nStr & "b"
        Case "14223"
            nStr = nStr & "B"
        Case "11211"
            nStr = nStr & "�"
        Case "11311"
            nStr = nStr & "�"
        Case "13334"
            nStr = nStr & "c"
        Case "14324"
            nStr = nStr & "C"
        Case "24344"
            nStr = nStr & "d"
        Case "14444"
            nStr = nStr & "D"
        Case "12314"
            nStr = nStr & "e"
        Case "21111"
            nStr = nStr & "E"
        Case "24321"
            nStr = nStr & "�"
        Case "32314"
            nStr = nStr & "�"
        Case "31314"
            nStr = nStr & "f"
        Case "21311"
            nStr = nStr & "F"
        Case "32134"
            nStr = nStr & "g"
        Case "21341"
            nStr = nStr & "G"
        Case "31324"
            nStr = nStr & "h"
        Case "22111"
            nStr = nStr & "H"
        Case "32124"
            nStr = nStr & "i"
        Case "21112"
            nStr = nStr & "I"
        Case "31334"
            nStr = nStr & "�"
        Case "32333"
            nStr = nStr & "�"
        Case "11314"
            nStr = nStr & "j"
        Case "23122"
            nStr = nStr & "J"
        Case "33134"
            nStr = nStr & "k"
        Case "23411"
            nStr = nStr & "K"
        Case "33314"
            nStr = nStr & "l"
       Case "32222"
            nStr = nStr & "L"
        Case "43423"
            nStr = nStr & "m"
        Case "32111"
            nStr = nStr & "M"
        Case "42423"
            nStr = nStr & "n"
        Case "33221"
            nStr = nStr & "N"
        Case "43234"
            nStr = nStr & "o"
        Case "33233"
            nStr = nStr & "O"
        Case "42444"
            nStr = nStr & "�"
        Case "43223"
            nStr = nStr & "�"
        Case "42433"
            nStr = nStr & "�"
        Case "43231"
            nStr = nStr & "�"
        Case "22223"
            nStr = nStr & "p"
        Case "33444"
            nStr = nStr & "P"
        Case "43233"
            nStr = nStr & "q"
        Case "34442"
            nStr = nStr & "Q"
        Case "43421"
            nStr = nStr & "r"
        Case "34332"
            nStr = nStr & "R"
        Case "13443"
            nStr = nStr & "s"
        Case "34222"
            nStr = nStr & "S"
        Case "44444"
            nStr = nStr & "t"
        Case "34112"
            nStr = nStr & "T"
        Case "13444"
            nStr = nStr & "u"
        Case "41311"
            nStr = nStr & "U"
        Case "11111"
            nStr = nStr & "�"
        Case "13243"
            nStr = nStr & "�"
        Case "11115"
            nStr = nStr & "�"
        Case "13241"
           nStr = nStr & "v"
        Case "41222"
            nStr = nStr & "V"
        Case "12443"
            nStr = nStr & "x"
        Case "41133"
            nStr = nStr & "X"
        Case "13244"
            nStr = nStr & "y"
        Case "42231"
            nStr = nStr & "Y"
        Case "13441"
            nStr = nStr & "w"
        Case "42222"
            nStr = nStr & "W"
        Case "11313"
            nStr = nStr & "z"
        Case "42213"
            nStr = nStr & "Z"
        Case "11312"
            nStr = nStr & "@"
        Case "11114"
            nStr = nStr & "%"
        Case "12341"
            nStr = nStr & "&"
        Case "13343"
            nStr = nStr & "*"
        Case "12342"
            nStr = nStr & "("
        Case "13344"
            nStr = nStr & ")"
        Case "12333"
            nStr = nStr & "$"
        Case "23334"
            nStr = nStr & "!"
        Case "13331"
            nStr = nStr & "#"
        Case "21242"
            nStr = nStr & "?"
        Case "22313"
            nStr = nStr & "1"
        Case "23424"
            nStr = nStr & "2"
        Case "24131"
            nStr = nStr & "3"
        Case "41414"
            nStr = nStr & "4"
        Case "22314"
           nStr = nStr & "5"
        Case "23423"
            nStr = nStr & "6"
        Case "44134"
            nStr = nStr & "7"
        Case "21241"
            nStr = nStr & "8"
       Case "22312"
           nStr = nStr & "9"
       Case "23231"
            nStr = nStr & "0"
        Case "34123"
            nStr = nStr & " "
        Case "14121"
            nStr = nStr & "_"
        Case "14144"
            nStr = nStr & "/"
        Case "12131"
            nStr = nStr & "\"
        Case "12124"
            nStr = nStr & "-"
        Case "21421"
            nStr = nStr & ";"
        Case "21321"
            nStr = nStr & ":"
        Case "14431"
            nStr = nStr & ","
        Case "13421"
            nStr = nStr & "."
        Case "11213"
            nStr = nStr & "+"
        Case "11212"
            nStr = nStr & "="

        Case Else
            MsgBox "C�digo de criptografia inv�lido!"
            'mStrDeCriptografa = ""
            Exit Function
        End Select
        i = i + 5
    Loop
  FunDecripta = nStr
    'mStrDeCriptografa = nStr

Exit Function
End Function



