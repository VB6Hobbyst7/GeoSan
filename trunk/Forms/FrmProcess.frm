VERSION 5.00
Begin VB.Form FrmProcess 
   ClientHeight    =   975
   ClientLeft      =   60
   ClientTop       =   60
   ClientWidth     =   5040
   ControlBox      =   0   'False
   Icon            =   "FrmProcess.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   975
   ScaleWidth      =   5040
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancelar"
      Height          =   345
      Left            =   4110
      TabIndex        =   3
      Top             =   540
      Width           =   885
   End
   Begin VB.TextBox txtRecord 
      Height          =   345
      Left            =   1920
      TabIndex        =   1
      Top             =   540
      Width           =   1185
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      BackColor       =   &H00004000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000005&
      Height          =   435
      Left            =   0
      TabIndex        =   0
      Text            =   "Processando..."
      Top             =   0
      Width           =   5055
   End
   Begin VB.Label Label1 
      Caption         =   "Linhas Processadas:"
      Height          =   285
      Left            =   90
      TabIndex        =   2
      Top             =   570
      Width           =   1485
   End
End
Attribute VB_Name = "FrmProcess"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Objectid As String
Private cgeo As New clsGeoReference

Private Sub cmdCancel_Click()
   If MsgBox("Deseja para a execu��o do processo", 36) = vbYes Then
      stopProcess = True
   End If
End Sub
'Fun��o destinada a localizar todos os trechos de rede que est�o conectados at� que seja encontrato um registro.
'Um registro � onde posso abrir e fechar, uma v�lvula n�o tenho a possibilidade de abrir e fechar. Na verdade ele vai procurar registros e n�o v�lvulas
'
'Object_id_ - do trecho que foi selecionado
'tcs - canvas
'
Public Function FindValvulas(Object_id_ As String, tcs As TeCanvas) As String
   'LoozeXP1.InitSubClassing
   txtRecord = 0
   Objectid = Object_id_                                    'rede de agua selecionada
   Me.Show
   Set cgeo.tcs = tcs
   tcs.setDetachedLineStyle 3, 1, RGB(255, 255, 0), True    'm�todo para indicar o estilo de visual de plotagem para as pr�ximas linhas que ser�o destacadas. Somente ser�o aplicadas a este estilo as pr�ximos linhas adicionadas � lista de destacadas. Vai destacar em amarelo.
   tcs.addDetachedIds tpLINES, , Object_id_                 'm�todo para destacar as geometrias que possuem a identifica��o especificada.
   cgeo.object_ids = "'" & Objectid & "'"                   'obtem os object_id_s
   cgeo.SELECTRede Objectid
   FindValvulas = cgeo.object_ids
   tcs.plotView
   Unload Me
   'LoozeXP1.EndWinXPCSubClassing
End Function

Private Sub Form_KeyPress(KeyAscii As Integer)
   cmdCancel_Click
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set cgeo = Nothing
End Sub

