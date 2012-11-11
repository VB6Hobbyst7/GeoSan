VERSION 5.00
Object = "{9AB389E7-EAED-4DBF-941D-EB86ED1F9A76}#1.0#0"; "TeComConnection.dll"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FrmEPANET 
   BorderStyle     =   1  'Fixed Single
   Caption         =   " Exporta��o EPANET"
   ClientHeight    =   1890
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6450
   ControlBox      =   0   'False
   Icon            =   "FrmEPANET.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1890
   ScaleWidth      =   6450
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Caminho de Exporta��o"
      Height          =   990
      Left            =   120
      TabIndex        =   4
      Top             =   210
      Width           =   6165
      Begin VB.TextBox txtArquivo 
         Height          =   315
         Left            =   150
         TabIndex        =   6
         Top             =   375
         Width           =   5325
      End
      Begin VB.CommandButton cmdPath 
         Caption         =   "..."
         Height          =   330
         Left            =   5550
         TabIndex        =   5
         Top             =   375
         Width           =   435
      End
   End
   Begin VB.TextBox txtTimer 
      Height          =   315
      Left            =   1350
      TabIndex        =   2
      Text            =   "20:00:00"
      Top             =   1335
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   3450
      Top             =   1305
   End
   Begin MSComDlg.CommonDialog cdl 
      Left            =   3420
      Top             =   1260
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cmdConfirmar 
      Caption         =   "Exportar"
      Height          =   375
      Left            =   5190
      TabIndex        =   1
      Top             =   1335
      Width           =   1065
   End
   Begin VB.CommandButton cmdCancelar 
      Caption         =   "Cancelar"
      Height          =   375
      Left            =   4035
      TabIndex        =   0
      Top             =   1335
      Width           =   1065
   End
   Begin MSComctlLib.ProgressBar ProgressBar1 
      Height          =   360
      Left            =   165
      TabIndex        =   7
      Top             =   1335
      Visible         =   0   'False
      Width           =   3075
      _ExtentX        =   5424
      _ExtentY        =   635
      _Version        =   393216
      Appearance      =   1
      Min             =   1e-4
      Scrolling       =   1
   End
   Begin TeComConnectionLibCtl.TeAcXConnection TeAcXConnection1 
      Left            =   4680
      OleObjectBlob   =   "FrmEPANET.frx":1CFA
      Top             =   120
   End
   Begin VB.Label Label4 
      Caption         =   "Hor�rio"
      Height          =   225
      Left            =   645
      TabIndex        =   3
      Top             =   1395
      Visible         =   0   'False
      Width           =   675
   End
End
Attribute VB_Name = "FrmEPANET"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'EpanetExport Vers�o 01.02.25

Option Explicit
Public conn As ADODB.Connection
Public Provider As Integer
Public PLANO As String

Private rsTP As ADODB.Recordset
Private rsST As ADODB.Recordset

Dim i As Integer


Public Sub init()
   
   cmdConfirmar.Default = True
   
   'txtArquivo.Text = App.Path & "\GeoSan_Exp_Epanet_" & Format(Now, "YYYY-MM-DD-HHMMSS") & ".INP"
   txtArquivo.Text = Environ$("USERPROFILE") & "\my documents" & "\GeoSan_Exp_Epanet_" & Format(Now, "YYYY-MM-DD-HHMMSS") & ".INP"
   
   Me.Show

End Sub



Private Sub cmdCancelar_Click()
   
   Cancelar = True
   
   Unload Me
End Sub
'In�cio da fun��o de exporta��o para o EPANET. Ao final dela ser� chamado o ModExport pela rotina ExportaEPANet que gera em mem�ria toda a exporta��o
'para depois gerar em arquivo atrav�s de outra rotina
Private Function INICIAR()
On Error GoTo Trata_Erro

    Dim retval As String
    Dim usuario As String
    Dim arquivoLog As String                        'nome do arquivo de log com todas as opera��es ao exportar para o Epanet
   
    arquivoLog = "\Controles\ExportaEpanet" & DateValue(Now) & "  " & TimeValue(Now) & ".log"    'define o nome completo do arquivo de log do sistema, inclu�ndo a data e hora em que o mesmo ser� gerado pela primeira vez
    arquivoLog = Replace(arquivoLog, "/", "-")                      'troca caractere / especial que n�o � aceito como parte do nome do arquivo
    arquivoLog = Replace(arquivoLog, ":", "-")                      'troca caractere : especial que n�o � aceito como parte do nome do arquivo
    arquivoLog = App.Path & arquivoLog                              'adiciona a localiza��o do caminho onde o aplicativo est� instalado
    Open arquivoLog For Append As #5                                'Inicia o log do sistema, abrindo o arquivo sem apagar o log anterior, mantendo sempre o hist�rico
    Print #5, vbCrLf & "ExportEpanet;*************************************************************************************************"  'Pula uma linha antes de iniciar a escrita
    Print #5, "ExportEpanet;In�cio do processamento da exporta��o para o Epanet: " & DateValue(Now) & " - " & TimeValue(Now)

    
    'Neste arquivo existe gravado o nome do usu�rio ativo, que indica que usu�rio exportou para o Epanet o pol�gono de sele��o
    'Atrav�s dele ser� feita uma pesquisa no banco de dados POLIGONO_SELECAO para ver que redes OBJECT_ID_s ser�o exportados para o EPANET
    'Lembrando que
    '                TIPO = 0 - N�s
    '                TIPO = 1 - Redes
    '                TIPO = 2 - Ramais
    retval = Dir(App.Path & "\Controles\UserLog.txt")
   
    'verifica se o arquivo existe na pasta
    If retval <> "" Then
        'Abre e l� o arquivo para ver que usu�rio ser� consultado no pol�gono selecionado, pois podem existir v�rios usu�rios realizando esta opera��o ao mesmo tempo
        Open App.Path & "\Controles\UserLog.txt" For Input As #3
        Line Input #3, usuario
        Close #3
    Else
        'Avisa e cai fora, pois n�o d� para executar a opera��o
        MsgBox "� necess�rio criar a sele��o por pol�gono.", vbOKOnly + vbInformation, "Mensagem"
        End
    End If
    
    'Liga a ampulheta no ponteiro do mouse
    MousePointer = vbHourglass
    
    'Atualiza todas as rugosidades de todas as tubula��es, conforme o tipo de material. Foi considerada uma tubula��o de 20 anos de idade
    If conn.Provider <> "PostgreSQL.1" Then
        'Caso o banco de dados seja Oracle ou SQLServer
        Print #5, "ExportEpanet;UPDATE WATERLINES SET ROUGHNESS = 0"
        conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 0")
        Print #5, "ExportEpanet;UPDATE WATERLINES SET ROUGHNESS = 111 WHERE MATERIAL = 0"
        conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 111 WHERE MATERIAL = 0")
        Print #5, "ExportEpanet;UPDATE WATERLINES SET ROUGHNESS = 130 WHERE MATERIAL = 1 AND ROUGHNESS = 0"
        conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 130 WHERE MATERIAL = 1 AND ROUGHNESS = 0")
        Print #5, "ExportEpanet;UPDATE WATERLINES SET ROUGHNESS = 120 WHERE MATERIAL = 2 AND ROUGHNESS = 0"
        conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 120 WHERE MATERIAL = 2 AND ROUGHNESS = 0")
        Print #5, "ExportEpanet;UPDATE WATERLINES SET ROUGHNESS = 110 WHERE MATERIAL = 3 AND ROUGHNESS = 0"
        conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 110 WHERE MATERIAL = 3 AND ROUGHNESS = 0")
        Print #5, "ExportEpanet;UPDATE WATERLINES SET ROUGHNESS = 105 WHERE MATERIAL = 4 AND ROUGHNESS = 0"
        conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 105 WHERE MATERIAL = 4 AND ROUGHNESS = 0")
        Print #5, "ExportEpanet;UPDATE WATERLINES SET ROUGHNESS = 90 WHERE MATERIAL = 5 AND ROUGHNESS = 0"
        conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 90 WHERE MATERIAL = 5 AND ROUGHNESS = 0")
        Print #5, "ExportEpanet;UPDATE WATERLINES SET ROUGHNESS = 130 WHERE MATERIAL = 6 AND ROUGHNESS = 0"
        conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 130 WHERE MATERIAL = 6 AND ROUGHNESS = 0")
    Else
        'Caso seja Postgres
        Print #5, "ExportEpanet;UPDATE" + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '0'"""
        conn.Execute ("UPDATE" + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '0'")
        Print #5, "ExportEpanet;UPDATE" + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '111' WHERE " + """" + "MATERIAL" + """" + " = '0'"
        conn.Execute ("UPDATE" + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '111' WHERE " + """" + "MATERIAL" + """" + " = '0'")
        Print #5, "ExportEpanet;UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '130' WHERE " + """" + "MATERIAL" + """" + " = '1' AND " + """" + "ROUGHNESS" + """" + " = '0'"
        conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '130' WHERE " + """" + "MATERIAL" + """" + " = '1' AND " + """" + "ROUGHNESS" + """" + " = '0'")
        Print #5, "ExportEpanet;UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '120' WHERE " + """" + "MATERIAL" + """" + " = '2' AND " + """" + "ROUGHNESS" + """" + " = '0' "
        conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '120' WHERE " + """" + "MATERIAL" + """" + " = '2' AND " + """" + "ROUGHNESS" + """" + " = '0'")
        Print #5, "ExportEpanet;UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '110' WHERE " + """" + "MATERIAL" + """" + " = '3' AND " + """" + "ROUGHNESS" + """" + " = '0'"
        conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '110' WHERE " + """" + "MATERIAL" + """" + " = '3' AND " + """" + "ROUGHNESS" + """" + " = '0'")
        Print #5, "ExportEpanet;UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '105' WHERE " + """" + "MATERIAL" + """" + " = '4' AND " + """" + "ROUGHNESS" + """" + " = '0'"
        conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '105' WHERE " + """" + "MATERIAL" + """" + " = '4' AND " + """" + "ROUGHNESS" + """" + " = '0'")
        Print #5, "ExportEpanet;UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '90' WHERE " + """" + "MATERIAL" + """" + " = '5' AND " + """" + "ROUGHNESS" + """" + " = '0'"
        conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '90' WHERE " + """" + "MATERIAL" + """" + " = '5' AND " + """" + "ROUGHNESS" + """" + " = '0'")
        Print #5, "ExportEpanet;UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '130' WHERE " + """" + "MATERIAL" + """" + " = '6' AND " + """" + "ROUGHNESS" + """" + " = '0'"
        conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '130' WHERE " + """" + "MATERIAL" + """" + " = '6' AND " + """" + "ROUGHNESS" + """" + " = '0'")
    End If
    'Volta o mouse para o normal
    FrmEPANET.MousePointer = vbDefault
    
    Dim Rs As ADODB.Recordset
    Dim str As String
    Dim Tipo As String
    Dim setor As String
    Dim strtot As String        'armazena a querie para obter o n�mero total de segmentos de rede que ser�o exportados para o Epanet
   

    '   For i = 1 To lvTipoRede.ListItems.Count
    '      If lvTipoRede.ListItems.Item(i).Checked Then
    '         If Tipo = "" Then
    '            Tipo = lvTipoRede.ListItems.Item(i).Tag
    '         Else
    '            Tipo = Tipo & "," & lvTipoRede.ListItems.Item(i).Tag
    '         End If
    '      End If
    '   Next
    '
    '   For i = 1 To lvSetor.ListItems.Count
    '      If lvSetor.ListItems.Item(i).Checked Then
    '         If setor = "" Then
    '            setor = lvSetor.ListItems.Item(i).Tag
    '         Else
    '            setor = setor & "," & lvSetor.ListItems.Item(i).Tag
    '         End If
    '      End If
    '   Next
    
    'Zera todos os materiais de tubula��es quando o mesmo n�o estiver cadastrado
    If conn.Provider <> "PostgreSQL.1" Then
        'Se for Oracle ou SQLServer
        Print #5, "ExportEpanet;UPDATE WATERLINES SET MATERIAL = 0 WHERE MATERIAL IS NULL"
        conn.Execute ("UPDATE WATERLINES SET MATERIAL = 0 WHERE MATERIAL IS NULL")
    Else
        'Se for Postgres
        Print #5, "ExportEpanet;UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "MATERIAL" + """" + " = '0' WHERE " + """" + "MATERIAL" + """" + " IS NULL"
        conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "MATERIAL" + """" + " = '0' WHERE " + """" + "MATERIAL" + """" + " IS NULL")
    End If
   
    'WHERE WATERLINES.id_type in(1,3,0,2,12) and WATERLINES.SECTOR IN (21)
    'str = "SELECT * FROM WATERLINES "
       
    '   If Tipo <> "" Or setor <> "" Then
    '      str = str & "WHERE "
    '      If Tipo <> "" Then
    '         str = str & "id_type in(" & Tipo & ") "
    '      End If
    '      If setor <> "" And Tipo <> "" Then
    '         str = str & "and "
    '      End If
    '      If setor <> "" Then
    '         str = str & "SECTOR IN (" & setor & ")"
    '      End If
    '   End If
       'MsgBox str
    
    'Agora temos que descobrir todos os trechos de rede (TIPO=1) que ser�o exportados para o Epanet, do usu�rio ativo
    If Provider = 1 Then
        'Se for SQLServer
        str = "SELECT * FROM WATERLINES INNER JOIN X_MATERIAL ON WATERLINES.MATERIAL = X_MATERIAL.MATERIALID "
        str = str & "WHERE WATERLINES.OBJECT_ID_ IN (SELECT OBJECT_ID_ FROM POLIGONO_SELECAO WHERE USUARIO = '" & usuario & "' AND TIPO = 1)"
    ElseIf Provider = 2 Then
        'Se for Oracle
        str = "SELECT * FROM WATERLINES WATERLINES INNER JOIN X_MATERIAL ON WATERLINES.MATERIAL = X_MATERIAL.MATERIALID "
        str = str & "WHERE EXISTS (SELECT 1 FROM POLIGONO_SELECAO P WHERE WATERLINES.LINE_ID = P.OBJECT_ID_ AND P.USUARIO = '" & usuario & "' AND P.TIPO = 1)"
    End If
    If conn.Provider = "PostgreSQL.1" Then
        'Se for Postgres
        str = "SELECT * FROM " + """" + "WATERLINES" + """" + " INNER JOIN " + """" + "X_MATERIAL" + """" + " ON " + """" + "WATERLINES" + """" + "." + """" + "MATERIAL" + """" + " = " + """" + "X_MATERIAL" + """" + "." + """" + "MATERIALID" + """" + " "
        str = str & "WHERE " + """" + "WATERLINES" + """" + "." + """" + "OBJECT_ID_" + """" + " IN (SELECT " + """" + "OBJECT_ID_" + """" + " FROM " + """" + "POLIGONO_SELECAO" + """" + " WHERE " + """" + "USUARIO" + """" + " = '" & usuario & "' AND " + """" + "TIPO" + """" + " = '1')"
    End If
    
    'Prepara querie para verificar quantos trechos de rede iremos ler
    If conn.Provider <> "PostgreSQL.1" Then
        'Se for Oracle ou SQLServer
        strtot = Replace(str, "SELECT *", "SELECT COUNT(*)")
    Else
        'Se for Postgres
        strtot = Replace(str, "SELECT *", "SELECT COUNT(*)")
    End If
    Set Rs = New ADODB.Recordset
    'Obtem o n�mero total de trechos de rede a serem exportados para o Epanet
    If conn.Provider <> "PostgreSQL.1" Then
        'Se SQLServer ou Oracle
        Rs.Open strtot, conn, adOpenDynamic, adLockReadOnly
    Else
        'Se Postgres
        Rs.Open strtot, conn, adOpenDynamic, adLockOptimistic
    End If
    Me.ProgressBar1.Value = 1
    If Rs(0).Value > 0 Then
        Me.ProgressBar1.Max = Rs(0).Value
    Else
        MsgBox "N�o h� dados selecionados para exportar.", vbInformation, ""
        Exit Function
    End If
    Rs.Close
    Set Rs = Nothing
   
    'Agora que temos trechos a serem exportados, vamos exportar para o Epanet
    Set Rs = New ADODB.Recordset
    Rs.Open str, conn, adOpenDynamic, adLockReadOnly
    If Rs.EOF = False Then
        'Fecha temporariamente a conex�o com o arquivo de log
        Print #5, vbCrLf & "ExportEpanet;Fim do processamento inicial da exporta��o para o Epanet. Inicia A exporta��o."
        Close #5                                           'Fecha o arquivo de log do sistema
        'Chama rotina de exporta��o, passando o cursor com a querie com todos os segmentos de rede a serem exportados
        ExportaEPANet Rs, conn, arquivoLog
    Else
        MsgBox "N�o h� informa��es selecionadas para exportar.", vbInformation, ""
    End If

Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
        Close #2
        Open App.Path & "\LogErroExportEPANET.txt" For Append As #2
        Print #2, Now & "  - Private Sub cmdConfirmar_Click() - Linha: " & intLinhaCod & " - " & Err.Number & " - " & Err.Description
        Close #2
        Print #5, vbCrLf & "ExportEpanet;Fim do processamento da exporta��o para o Epanet: " & DateValue(Now) & " - " & TimeValue(Now)
        Print #5, "ExportEpanet;*************************************************************************************************"
        Close #5                                           'Fecha o arquivo de log do sistema
        MsgBox "Exporta��o para o Epanet conclu�da com n�o conformidades. Verifique o log no arquivo " & arquivoLog
        MsgBox "Um posss�vel erro foi identificado na rotina 'INICIAR()':" & Chr(13) & Chr(13) & Err.Description & Chr(13) & Chr(13) & "Foi gerado na pasta do aplicativo o arquivo LogErroExportEPANET.txt com informa��es desta ocorrencia.", vbInformation
    End If
End Function

Private Sub Timer1_Timer()

'   If txtTimer.Text = "" Then
      
      
      
      MousePointer = vbHourglass
      INICIAR
      
      MousePointer = vbDefault
      
      Timer1.Enabled = False
      End
      
'   Else
'      If IsDate(Me.txtTimer.Text) Then
'
'         If CDate(txtTimer.Text) < Format(Now, "HH:MM:SS") Then
'            INICIAR
'            Timer1.Enabled = False
'         End If
'
'      Else
'         MsgBox "Hor�rio inv�lido"
'         Timer1.Enabled = False
'      End If
'   End If

End Sub




Private Sub cmdConfirmar_Click()
   Timer1.Enabled = True
   Me.ProgressBar1.Visible = True
   Me.cmdConfirmar.Enabled = False
   
End Sub


Private Sub cmdPath_Click()
   cdl.Filter = "Epanet (.inp)|*.INP|Todos tipos (*.*)|*.*|"
   cdl.FileName = txtArquivo.Text
   cdl.InitDir = Environ$("USERPROFILE") & "\my documents"
   cdl.ShowSave
   
   
   txtArquivo.Text = cdl.FileName
End Sub


Private Sub Command1_Click()

If MsgBox("Deseja aplicar f�rmula Material x Rugosidade?", vbYesNo + vbQuestion, "Confirmar A��o") = vbYes Then
   FrmEPANET.MousePointer = vbHourglass
   
   

     If conn.Provider <> "PostgreSQL.1" Then
   conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 0")
   conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 111 WHERE MATERIAL = 0")
   conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 130 WHERE MATERIAL = 1 AND ROUGHNESS = 0")
   conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 120 WHERE MATERIAL = 2 AND ROUGHNESS = 0 ")
   conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 110 WHERE MATERIAL = 3 AND ROUGHNESS = 0")
   conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 105 WHERE MATERIAL = 4 AND ROUGHNESS = 0")
   conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 90 WHERE MATERIAL = 5 AND ROUGHNESS = 0")
   conn.Execute ("UPDATE WATERLINES SET ROUGHNESS = 130 WHERE MATERIAL = 6 AND ROUGHNESS = 0")
   Else
     conn.Execute ("UPDATE" + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '0'")
   conn.Execute ("UPDATE" + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '111' WHERE " + """" + "MATERIAL" + """" + " = '0'")
   conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '130' WHERE " + """" + "MATERIAL" + """" + " = '1' AND " + """" + "ROUGHNESS" + """" + " = '0'")
   conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '120' WHERE " + """" + "MATERIAL" + """" + " = '2' AND " + """" + "ROUGHNESS" + """" + " = '0' ")
   conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '110' WHERE " + """" + "MATERIAL" + """" + " = '3' AND " + """" + "ROUGHNESS" + """" + " = '0'")
   conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '105' WHERE " + """" + "MATERIAL" + """" + " = '4' AND " + """" + "ROUGHNESS" + """" + " = '0'")
   conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '90' WHERE " + """" + "MATERIAL" + """" + " = '5' AND " + """" + "ROUGHNESS" + """" + " = '0'")
   conn.Execute ("UPDATE " + """" + "WATERLINES" + """" + " SET " + """" + "ROUGHNESS" + """" + " = '130' WHERE " + """" + "MATERIAL" + """" + " = '6' AND " + """" + "ROUGHNESS" + """" + " = '0'")
   
   
   End If
   
   
   
   
   
   FrmEPANET.MousePointer = vbDefault
   MsgBox "F�rmula aplicada com sucesso!", vbInformation, ""
End If


End Sub

