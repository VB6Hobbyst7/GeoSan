VERSION 5.00
Object = "{87AC6DA5-272D-40EB-B60A-F83246B1B8D7}#1.0#0"; "TeComDatabase.dll"
Object = "{2CCABA93-B681-4E7F-8047-BD4D623301BA}#1.0#0"; "TeComImport.dll"
Object = "{C51C74EC-6107-4A01-8400-40B53BB20D42}#1.0#0"; "TeComExport.dll"
Object = "{9AB389E7-EAED-4DBF-941D-EB86ED1F9A76}#1.0#0"; "TeComConnection.dll"
Object = "{EE78E37B-39BE-42FA-80B7-E525529739F7}#1.0#0"; "TeComViewDatabase.dll"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{D21E4F0D-5F4A-4897-9502-979E04C5FAF5}#1.1#0"; "NxViewManager2.ocx"
Object = "{1A397116-3057-40EE-9ECA-6FA4CC1E5FC3}#1.0#0"; "NexusPM4.ocx"
Begin VB.MDIForm FrmMain 
   BackColor       =   &H8000000C&
   Caption         =   "NEXUS - GeoSan"
   ClientHeight    =   9210
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   12720
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "FrmMain"
   StartUpPosition =   3  'Windows Default
   Tag             =   "0"
   WindowState     =   2  'Maximized
   Begin MSComDlg.CommonDialog Cdl 
      Left            =   4305
      Top             =   2430
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.PictureBox pctSfondo 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   8160
      Left            =   8775
      ScaleHeight     =   8160
      ScaleWidth      =   3945
      TabIndex        =   1
      Top             =   630
      Width           =   3945
      Begin NxViewManager.ViewManager ViewManager1 
         Height          =   1335
         Left            =   480
         TabIndex        =   11
         Top             =   3720
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   2355
      End
      Begin TECOMIMPORTLibCtl.TeImport TeImport1 
         Left            =   720
         OleObjectBlob   =   "frmMain.frx":08CA
         Top             =   5640
      End
      Begin MSComDlg.CommonDialog cmmSalvaImg 
         Left            =   1590
         Top             =   7605
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin PManager4.Manager Manager1 
         Height          =   615
         Left            =   495
         TabIndex        =   9
         Top             =   1725
         Width           =   885
         _ExtentX        =   1561
         _ExtentY        =   1085
      End
      Begin VB.CommandButton cmdClose 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3660
         Picture         =   "frmMain.frx":08EE
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   0
         Width           =   285
      End
      Begin VB.PictureBox picSplitter 
         BackColor       =   &H00808080&
         BorderStyle     =   0  'None
         FillColor       =   &H00808080&
         Height          =   7200
         Left            =   2250
         ScaleHeight     =   3135.189
         ScaleMode       =   0  'User
         ScaleWidth      =   780
         TabIndex        =   2
         Top             =   -90
         Visible         =   0   'False
         Width           =   72
      End
      Begin VB.Frame FrameEscala 
         Height          =   615
         Left            =   240
         TabIndex        =   4
         Top             =   240
         Width           =   3675
         Begin VB.TextBox txtEscala 
            Height          =   285
            Left            =   1890
            TabIndex        =   5
            Top             =   210
            Width           =   1635
         End
         Begin VB.Label Label1 
            Caption         =   "Escala de Visualiza��o:"
            Height          =   195
            Left            =   90
            TabIndex        =   6
            Top             =   240
            Width           =   1755
         End
      End
      Begin MSComctlLib.TabStrip TabStrip1 
         Height          =   315
         Left            =   240
         TabIndex        =   3
         Top             =   960
         Width           =   4095
         _ExtentX        =   7223
         _ExtentY        =   556
         MultiRow        =   -1  'True
         MultiSelect     =   -1  'True
         _Version        =   393216
         BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
            NumTabs         =   2
            BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
               Caption         =   "Temas"
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
               Caption         =   "Propriedades"
               ImageVarType    =   2
            EndProperty
         EndProperty
      End
      Begin TECOMDATABASELibCtl.TeDatabase TeDatabase1 
         Left            =   2880
         OleObjectBlob   =   "frmMain.frx":0C60
         Top             =   3720
      End
      Begin TeComConnectionLibCtl.TeAcXConnection TeAcXConnection1 
         Left            =   2400
         OleObjectBlob   =   "frmMain.frx":0C84
         Top             =   1680
      End
      Begin TeComViewDatabaseLibCtl.TeViewDatabase TeViewDatabase1 
         Left            =   3120
         OleObjectBlob   =   "frmMain.frx":0CA8
         Top             =   4920
      End
      Begin VB.Image imgSplitter 
         Height          =   7380
         Left            =   0
         MousePointer    =   9  'Size W E
         Top             =   0
         Width           =   150
      End
   End
   Begin MSComctlLib.StatusBar sbStatusBar 
      Align           =   2  'Align Bottom
      Height          =   420
      Left            =   0
      TabIndex        =   0
      Top             =   8790
      Width           =   12720
      _ExtentX        =   22437
      _ExtentY        =   741
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   8819
            MinWidth        =   8819
            Text            =   "Status"
            TextSave        =   "Status"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            AutoSize        =   2
            TextSave        =   "01/05/2013"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            AutoSize        =   2
            TextSave        =   "16:36"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   2
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbToolBar 
      Align           =   1  'Align Top
      Height          =   630
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   12720
      _ExtentX        =   22437
      _ExtentY        =   1111
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      ImageList       =   "ImageList3"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   38
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "knew"
            Object.ToolTipText     =   "Novo"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ksave"
            Object.ToolTipText     =   "Salvar"
            ImageIndex      =   19
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kselection"
            Object.ToolTipText     =   "Selecionar"
            ImageIndex      =   25
            Style           =   1
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kplotview"
            Object.ToolTipText     =   "Atualizar"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "krecompose"
            Object.ToolTipText     =   "Recompor"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "mnuPoligono"
            Object.ToolTipText     =   "Poligono de Sele��o"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "KFindCoordenadas"
            Object.ToolTipText     =   "Localizar Coordenada"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "KEncontraTexto"
            Object.ToolTipText     =   "Encontrar Textos"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "KEncontraConsumidor"
            Object.ToolTipText     =   "Encontrar Consumidores"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kzoomarea"
            Object.ToolTipText     =   "Zoom �rea"
            ImageIndex      =   24
            Style           =   1
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kpan"
            Object.ToolTipText     =   "Mover Visualiza��o"
            ImageIndex      =   15
            Style           =   1
         EndProperty
         BeginProperty Button16 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kundoview"
            Object.ToolTipText     =   "Voltar Visualiza��o"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button17 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kredoview"
            Object.ToolTipText     =   "Avan�ar Visualiza��o"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button18 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button19 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kzoomin"
            Object.ToolTipText     =   "Menos Zoom"
            ImageIndex      =   23
         EndProperty
         BeginProperty Button20 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kzoomout"
            Object.ToolTipText     =   "Mais Zoom"
            ImageIndex      =   22
         EndProperty
         BeginProperty Button21 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button22 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kdrawnetworkline"
            Object.ToolTipText     =   "Desenhar Rede"
            ImageIndex      =   12
            Style           =   1
         EndProperty
         BeginProperty Button23 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kmovenetworknode"
            Object.ToolTipText     =   "Mover Componente com Rede"
            ImageIndex      =   18
            Style           =   1
         EndProperty
         BeginProperty Button24 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kinsertnetworknode"
            Object.ToolTipText     =   "Desenhar Componente na Rede"
            ImageIndex      =   17
            Style           =   1
         EndProperty
         BeginProperty Button25 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button26 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "kdrawtext"
            Object.ToolTipText     =   "Desenhar Texto - Amarra��o"
            Style           =   1
         EndProperty
         BeginProperty Button27 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "kdrawline"
            Object.ToolTipText     =   "Desenhar Linha - Amarra��o"
         EndProperty
         BeginProperty Button28 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "kdrawpoint"
            Object.ToolTipText     =   "Desenhar Ponto - Amarra��o"
         EndProperty
         BeginProperty Button29 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button30 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button31 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kinsertdoc"
            Object.ToolTipText     =   "Inserir Documento(s)"
            ImageIndex      =   9
            Style           =   1
         EndProperty
         BeginProperty Button32 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kdrawramal"
            Object.ToolTipText     =   "Inserir Ramal"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button33 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "kdelete"
            Object.ToolTipText     =   "Excluir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button34 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ksearchinnetwork"
            Object.ToolTipText     =   "Encontrar v�lvulas a partir da rede selecionada"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button35 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "ksearchattribute"
            Object.ToolTipText     =   "Pesquisa Geral"
         EndProperty
         BeginProperty Button36 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button37 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "kdrawintersection"
         EndProperty
         BeginProperty Button38 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "kConsumoLote"
            Object.ToolTipText     =   "Apresenta Consumo"
         EndProperty
      EndProperty
      Begin TECOMEXPORTLibCtl.TeExport TeExport2 
         Left            =   4320
         OleObjectBlob   =   "frmMain.frx":0CCC
         Top             =   840
      End
      Begin MSComctlLib.ProgressBar ProgressBar1 
         Height          =   285
         Left            =   9120
         TabIndex        =   10
         Top             =   60
         Visible         =   0   'False
         Width           =   1890
         _ExtentX        =   3334
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   1
         Min             =   1e-4
         Scrolling       =   1
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4830
      Top             =   2370
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   31
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":0CF0
            Key             =   "new_window"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":1042
            Key             =   "zoom_area"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":1394
            Key             =   "zoom_in"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":16E6
            Key             =   "zoon_out"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":1A38
            Key             =   "undo_view"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":1D8A
            Key             =   "redo_view"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":20DC
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":262E
            Key             =   "delete"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":2980
            Key             =   "save"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":2CD2
            Key             =   "fit"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":3024
            Key             =   "insertramal"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":3376
            Key             =   "foto"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":36C8
            Key             =   "fonte"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":3A1A
            Key             =   "fiti"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":3D6C
            Key             =   "sair"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":40BE
            Key             =   "seta"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":4410
            Key             =   "world"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":4762
            Key             =   "find_user"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":4AB4
            Key             =   "insert_point"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":4E06
            Key             =   "attach"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":5158
            Key             =   "draw_network"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":54AA
            Key             =   "find_valvula"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":57FC
            Key             =   "declivity"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":5B4E
            Key             =   "reflesh"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":5EA0
            Key             =   "move_point"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":61F2
            Key             =   "pan"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":6544
            Key             =   "registro"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":6896
            Key             =   "point"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":6BE8
            Key             =   "point2"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":6FB3
            Key             =   "line"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":7305
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   5400
      Top             =   2370
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   32
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":7757
            Key             =   "new_window"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":7AA9
            Key             =   "zoom_area"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":7DFB
            Key             =   "zoom_in"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":814D
            Key             =   "zoon_out"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":849F
            Key             =   "undo_view"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":87F1
            Key             =   "redo_view"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":8B43
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":9095
            Key             =   "delete"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":93E7
            Key             =   "save"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":9739
            Key             =   "fit"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":9A8B
            Key             =   "insertramal"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":9DDD
            Key             =   "foto"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":A12F
            Key             =   "fonte"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":A481
            Key             =   "fiti"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":A7D3
            Key             =   "sair"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":AB25
            Key             =   "seta"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":AE77
            Key             =   "world"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":B1C9
            Key             =   "find_user"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":B51B
            Key             =   "insert_point"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":B86D
            Key             =   "attach"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":BBBF
            Key             =   "draw_network"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":BF11
            Key             =   "find_valvula"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":C263
            Key             =   "declivity"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":C5B5
            Key             =   "reflesh"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":C907
            Key             =   "move_point"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":CC59
            Key             =   "pan"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":CFAB
            Key             =   "registro"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":D2FD
            Key             =   "point"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":D64F
            Key             =   "point2"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":DA1A
            Key             =   "line"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":DD6C
            Key             =   ""
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":E1BE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList3 
      Left            =   4320
      Top             =   3960
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   25
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":E7E8
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":EC4B
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":1379D
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":167EF
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":19841
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":1C893
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":1F8E5
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":21767
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":21B85
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":2DBD7
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":39C29
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":45C7B
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":51CCD
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":5DD1F
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":69D71
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":6A9C3
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":76A15
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":82A67
            Key             =   ""
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":8EAB9
            Key             =   ""
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":9AB0B
            Key             =   ""
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":A6B5D
            Key             =   ""
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":A9BAF
            Key             =   ""
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":A9FF3
            Key             =   ""
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":AA427
            Key             =   ""
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":AA860
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu Mnu_Arquive 
      Caption         =   "&Arquivo"
      Begin VB.Menu mnuExport 
         Caption         =   "Exportar"
         Begin VB.Menu mnuImagem 
            Caption         =   "�rea Visualizada para Imagem"
         End
         Begin VB.Menu mnuExportLocalNos 
            Caption         =   "Localiza��o de N�s com Cota"
         End
         Begin VB.Menu mnuExpAutoCad 
            Caption         =   "DXF"
         End
         Begin VB.Menu mnuExpCon 
            Caption         =   "Localiza��o de Consumidores e Consumo"
         End
         Begin VB.Menu OdImport 
            Caption         =   "Novo DXF com OdImport"
            Visible         =   0   'False
         End
      End
      Begin VB.Menu mnusep01001 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuImport 
         Caption         =   "Importar"
         Begin VB.Menu mnuImportSIG 
            Caption         =   "SIG"
         End
         Begin VB.Menu mnuImportDXF 
            Caption         =   "DXF"
         End
         Begin VB.Menu mnuImpCotas 
            Caption         =   "Cotas"
         End
      End
      Begin VB.Menu mnusep011101 
         Caption         =   "-"
      End
      Begin VB.Menu mnuUpdate_Demand 
         Caption         =   "Atualizar Consumos e Distribuir Demandas"
      End
      Begin VB.Menu mnuExporta_GeoSan 
         Caption         =   "Exporta GeoSan"
      End
      Begin VB.Menu mnuAutoLogin 
         Caption         =   "Logar Automaticamente"
      End
      Begin VB.Menu mnuChangePassword 
         Caption         =   "Alterar Senha"
      End
      Begin VB.Menu mnuFileClose 
         Caption         =   "Fechar"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileBar0 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileProperties 
         Caption         =   "Propriedades"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileBar2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFileExit 
         Caption         =   "Sair"
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "&Editar"
      Begin VB.Menu mnuSelect 
         Caption         =   "Selecionar"
      End
      Begin VB.Menu mnu_Reflesh 
         Caption         =   "Atualizar"
      End
      Begin VB.Menu mnuRecompose 
         Caption         =   "Recompor"
      End
      Begin VB.Menu mnuFileBar71 
         Caption         =   "-"
      End
      Begin VB.Menu mnuZoom 
         Caption         =   "Zoom �rea"
         Shortcut        =   ^Z
      End
      Begin VB.Menu mnuMove 
         Caption         =   "Mover Visualiza��o"
      End
      Begin VB.Menu mnuUndoView 
         Caption         =   "Voltar Visualiza��o"
      End
      Begin VB.Menu mnuRedoView 
         Caption         =   "Avan�ar Visualiza��o"
      End
      Begin VB.Menu mnuFileBar72 
         Caption         =   "-"
      End
      Begin VB.Menu mnuMinusZoom 
         Caption         =   "Menos Zoom"
      End
      Begin VB.Menu mnuMoreZoom 
         Caption         =   "Mais Zoom"
      End
      Begin VB.Menu mnuFileBar73 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuDeleteInc 
         Caption         =   "Excluir Pontos Inconcistentes"
         Visible         =   0   'False
      End
   End
   Begin VB.Menu mnuMapa 
      Caption         =   "&Mapa"
      Begin VB.Menu mnuDrawLineWater 
         Caption         =   "Desenhar Rede �gua"
         Shortcut        =   ^L
      End
      Begin VB.Menu mnuMovePointWithLines 
         Caption         =   "Mover Componente c/ Rede"
      End
      Begin VB.Menu mnuDrawPointInLineWater 
         Caption         =   "Desenhar Componente na Rede"
         Shortcut        =   ^R
      End
      Begin VB.Menu mnuEditBar30 
         Caption         =   "-"
      End
      Begin VB.Menu mnuInsertDocs 
         Caption         =   "Inserir Documentos"
         Shortcut        =   ^D
      End
      Begin VB.Menu mnuEditBar80 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDrawRamal 
         Caption         =   "Desenhar Ramal"
      End
      Begin VB.Menu mnusep1234 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDeleteLineWater 
         Caption         =   "Excluir"
         Shortcut        =   ^X
      End
      Begin VB.Menu mnusep9999 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCalcArea 
         Caption         =   "Calcular �rea (m�)"
      End
      Begin VB.Menu mnuCalibrarZoom 
         Caption         =   "Calibrar Zoom"
      End
      Begin VB.Menu mnuDesenhaPoligono 
         Caption         =   "Desenhar Poligono"
      End
      Begin VB.Menu mnuCarregaPoligono 
         Caption         =   "Carregar Pol�gono"
      End
      Begin VB.Menu mnuDefEscala 
         Caption         =   "Definir Escala"
      End
      Begin VB.Menu mnuFixaIcone 
         Caption         =   "Fixar �cone"
      End
      Begin VB.Menu mnusep0001 
         Caption         =   "-"
      End
      Begin VB.Menu mnu_Find_Object 
         Caption         =   "Encontrar Objeto"
      End
      Begin VB.Menu mnuEncontraTexto 
         Caption         =   "Encontrar Textos"
      End
      Begin VB.Menu mnuEncontraCoordenada 
         Caption         =   "Localizar Coordenadas"
      End
      Begin VB.Menu mnuLocConsumidores 
         Caption         =   "Localizar Consumidores"
      End
      Begin VB.Menu mnusep10000 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSalvaImgMapa 
         Caption         =   "Salvar Imagem"
         Begin VB.Menu mnuBitmap 
            Caption         =   "BMP"
         End
         Begin VB.Menu mnuGIF 
            Caption         =   "GIF"
         End
         Begin VB.Menu mnuJPG 
            Caption         =   "JPG"
         End
         Begin VB.Menu mnuPNG 
            Caption         =   "PNG"
         End
         Begin VB.Menu mnuTIF 
            Caption         =   "TIF"
         End
      End
   End
   Begin VB.Menu mnuCadastros 
      Caption         =   "&Cadastros"
      Begin VB.Menu mnuTypes 
         Caption         =   "Tipos"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuSuppliers 
         Caption         =   "Fornecedores"
      End
      Begin VB.Menu mnuManufacters 
         Caption         =   "Fabricantes"
      End
   End
   Begin VB.Menu mnuRel 
      Caption         =   "Relat�rios"
      Begin VB.Menu MnuRelWl 
         Caption         =   "Rede de �gua"
      End
      Begin VB.Menu MnuRelSl 
         Caption         =   "Rede de Esgoto"
      End
      Begin VB.Menu mnuRelRegistros 
         Caption         =   "V�lvulas"
      End
      Begin VB.Menu mnuRelComponentesAgua 
         Caption         =   "Componentes de �gua"
      End
      Begin VB.Menu mnuRelComponentesEsgoto 
         Caption         =   "Componentes de Esgoto"
      End
   End
   Begin VB.Menu mnuAdmin 
      Caption         =   "Administrar"
      Begin VB.Menu mnuRemoverPlano 
         Caption         =   "Remover Plano"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuUsers 
         Caption         =   "Usu�rios"
      End
      Begin VB.Menu mnuSep113 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSelectDatabase 
         Caption         =   "Banco de Dados"
      End
      Begin VB.Menu s999999 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnudiagRede 
         Caption         =   "Diagn�stico de rede"
         Visible         =   0   'False
      End
      Begin VB.Menu mnusep 
         Caption         =   "-"
      End
      Begin VB.Menu mnuProdutividade 
         Caption         =   "Indicador de Produtividade"
         Begin VB.Menu mnuRedesAgua 
            Caption         =   "Redes de �gua"
         End
         Begin VB.Menu mnuRamaisAgua 
            Caption         =   "Liga��es de �gua"
         End
         Begin VB.Menu mnusep1 
            Caption         =   "-"
         End
         Begin VB.Menu mnuRedesEsgoto 
            Caption         =   "Redes de Esgoto"
         End
      End
   End
   Begin VB.Menu mnuView 
      Caption         =   "&Janela"
      Begin VB.Menu mnuViewStatusBar 
         Caption         =   "Barra de Status"
         Checked         =   -1  'True
         Shortcut        =   ^B
      End
      Begin VB.Menu mnuViewToolbar 
         Caption         =   "Barra de Ferramentas"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuLayers 
         Caption         =   "Layers e Propriedades"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuSep016 
         Caption         =   "-"
      End
      Begin VB.Menu mnuMultProperteis 
         Caption         =   "Propriedades Multiplas"
      End
      Begin VB.Menu mnuLoadAttributeByReference 
         Caption         =   "Carregar Attributos por Refer�ncia"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnusep100 
         Caption         =   "-"
      End
      Begin VB.Menu mnuWindowCascade 
         Caption         =   "Cascata"
      End
      Begin VB.Menu mnuWindowTileHorizontal 
         Caption         =   "Alinhamento Horizontal"
      End
      Begin VB.Menu mnuWindowTileVertical 
         Caption         =   "Alinhamento Vertical"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Ajuda"
      Begin VB.Menu mnuHelpContents 
         Caption         =   "Conte�do"
         Shortcut        =   ^H
         Visible         =   0   'False
      End
      Begin VB.Menu mnuHelpBar0 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuHelpAbout 
         Caption         =   "Sobre"
         Shortcut        =   {F1}
      End
   End
End
Attribute VB_Name = "FrmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private TCanvas As frmCanvas
Const sglSplitLimit = 0

Private mbMoving        As Boolean
Private mstrprevfunc    As String
Private msngStartX      As Single
Dim conee As TeAcXConnection
Dim Abertura As Integer
Dim teac As TeAcXConnection
Dim a1 As TeImport
Dim a2 As TeDatabase



Private Sub cmdClose_Click()

   pctSfondo.Visible = False: mnuLayers.Checked = False
   
End Sub




Private Sub imgSplitter_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    msngStartX = X
    
    With imgSplitter
        picSplitter.Move .Left, .Top, .Width \ 2, .Height - 20
    End With
    
    picSplitter.Visible = True
    picSplitter.Height = pctSfondo.Height
    mbMoving = True
    
End Sub

Private Sub imgSplitter_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

    Dim sglPos As Single
    
    If mbMoving Then
        sglPos = X + imgSplitter.Left
        If sglPos < sglSplitLimit Then
        
            picSplitter.Left = sglSplitLimit
        ElseIf sglPos > Me.Width - sglSplitLimit Then
            picSplitter.Left = Me.Width - sglSplitLimit
        Else
            picSplitter.Left = sglPos
        End If
    End If
    
End Sub

Private Sub imgSplitter_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

    pctSfondo.Width = pctSfondo.Width + msngStartX - X
    pctSfondo.Refresh
    picSplitter.Visible = False
    mbMoving = False
    MDIForm_Resize
    TabStrip1.Refresh
    
End Sub



Private Sub MDIForm_Activate()

   'MDIForm_Resize
   
End Sub

Private Sub MDIForm_Load()

   '''LoozeXP1.InitSubClassing
   Manager1.InitConn Conn, CInt(typeconnection)
   Manager1.GridVisibled False
   
End Sub

Private Sub mnu_Find_Object_Click()
On Error GoTo Trata_Erro
   
   
   
   Dim Object_id_ As String, xmin As Double, ymin As Double, xmax As Double, ymax As Double
   
   Object_id_ = ""
   
   Object_id_ = InputBox("Informe o identificador do objeto", "Encontrar Objeto")
   
   If Trim(Object_id_) <> "" Then
      
      With ActiveForm.TCanvas
         .Normal
         If .addSelectObjectIds(Object_id_) = 1 Then
            .getSelectBox xmin, ymin, xmax, ymax
            .setWorld xmin - 1000, ymin - 1000, xmax + 1000, ymax + 1000
            .Select
            .setScale 1000
         Else
            MsgBox "N�o foi encontrado a geometria referente ao atributo selecionado", vbExclamation
         End If
      End With
      
   End If
   
Trata_Erro:

If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
ElseIf Err.Number = 91 Then
    MsgBox "N�o h� mapa ativo.", vbInformation, "Geosan"
Else
   
   PrintErro CStr(Me.Name), "Private Sub mnu_Find_Object_Click", CStr(Err.Number), CStr(Err.Description), True
   
End If
   
End Sub


Private Sub mnuAutoLogin_Click()
   
   Close #1
   Open App.path & "\controles\AutoLogin.txt" For Output As #1
   Print #1, strUser
   Close #1
   MsgBox "Definido login autom�tico para " & strUser, vbInformation, ""
   
End Sub



Private Sub mnuCalcArea_Click()
   
   ActiveForm.TCanvas.ToolTipText = ""
   
   ActiveForm.TCanvas.calculateArea
   
   
   
End Sub

Private Sub mnuCalibrarZoom_Click()
   Dim calibrazoom As New frmCalibrarZoom
   calibrazoom.Show 1
End Sub



Private Sub mnuEncontraCoordenada_Click()
On Error GoTo Trata_Erro
    Dim X As Double, Y As Double
   
    X = InputBox("Informe a Coordena X ")
    Y = InputBox("Informe a Coordena Y ")
    
    If X <> 0 And Y <> 0 Then
        ActiveForm.TCanvas.setWorld X - 50, Y - 50, X + 50, Y + 50
        ActiveForm.TCanvas.plotView
    End If

Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next

ElseIf Err.Number = 91 Or Err.Number = 13 Then
    'MsgBox "N�o h� mapa ativo.", vbInformation, "Geosan"
    Exit Sub
Else
   
   PrintErro CStr(Me.Name), "Public Function EncontraCoord()", CStr(Err.Number), CStr(Err.Description), True
   

End If

End Sub


Private Sub mnu_PatternCurves_Click()

   Dim frm As New frmEPANavegator
   
   frm.init
   Set frm = Nothing
   
End Sub

Private Sub mnu_Reflesh_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kplotview")
   
End Sub

Private Sub mnuExpCon_Click()
Dim CAMINHO, SQL As String
 Dim rs As New ADODB.Recordset
  Dim rs2 As New ADODB.Recordset
    Dim rs3 As New ADODB.Recordset
CAMINHO = App.path & "\EXPCONSUMO.txt"
Dim TB_GEOMETRIA As String
    Dim mPROVEDOR As String
Dim mSERVIDOR As String
Dim mPORTA As String
Dim mBANCO As String
Dim mUSUARIO As String
Dim Senha As String
Dim decriptada As String
Dim conexao As New ADODB.connection
Dim strConn As String
Dim nStr As String
Dim count2 As Integer

If frmCanvas.TipoConexao = 4 Then
If count2 <> 10 Then

mSERVIDOR = ReadINI("CONEXAO", "SERVIDOR", App.path & "\CONTROLES\GEOSAN.ini")
mPORTA = ReadINI("CONEXAO", "PORTA", App.path & "\CONTROLES\GEOSAN.ini")
mBANCO = ReadINI("CONEXAO", "BANCO", App.path & "\CONTROLES\GEOSAN.ini")
mUSUARIO = ReadINI("CONEXAO", "USUARIO", App.path & "\CONTROLES\GEOSAN.ini")
Senha = ReadINI("CONEXAO", "SENHA", App.path & "\CONTROLES\GEOSAN.ini")
nStr = frmCanvas.FunDecripta(Senha)
decriptada = frmCanvas.Senha
strConn = "DRIVER={PostgreSQL Unicode}; DATABASE=" + mBANCO + "; SERVER=" + mSERVIDOR + "; PORT=" + mPORTA + "; UID=" + mUSUARIO + "; PWD=" + nStr + "; ByteaAsLongVarBinary=1;"

conexao.Open strConn
count2 = 10
    
End If
End If




If frmCanvas.TipoConexao <> 4 Then
SQL = "SELECT * FROM NXGS_V_LIG_COMERCIAL_CONSUMO N INNER JOIN RAMAIS_AGUA_LIGACAO R on R.NRO_LIGACAO=N.NRO_LIGACAO inner join NXGS_V_LIG_COMERCIAL F on  R.NRO_LIGACAO = F.NRO_LIGACAO ORDER BY R.NRO_LIGACAO ASC"
 rs.Open SQL, Conn, adOpenDynamic, adLockReadOnly
  

Else

SQL = "SELECT * FROM " + """" + "NXGS_V_LIG_COMERCIAL_CONSUMO" + """" + " N INNER JOIN " + """" + "RAMAIS_AGUA_LIGACAO" + """" + " R on CAST(R." + """" + "NRO_LIGACAO" + """" + " AS INTEGER)=N." + """" + "NRO_LIGACAO" + """" + "inner join " + """" + "NXGS_V_LIG_COMERCIAL" + """" + "F ON R." + """" + "NRO_LIGACAO" + """" + "=F." + """" + "NRO_LIGACAO" + """" + " ORDER BY R." + """" + "NRO_LIGACAO" + """" + " ASC"
 rs.Open SQL, conexao, adOpenDynamic, adLockReadOnly

End If

If frmCanvas.TipoConexao <> 4 Then
 rs3.Open "SELECT * FROM lines1 T INNER JOIN RAMAIS_AGUA R ON R.OBJECT_ID_TRECHO = T.OBJECT_ID ORDER BY R.OBJECT_ID_TRECHO ASC", Conn, adOpenDynamic, adLockReadOnly
  

  

Else

rs3.Open "SELECT * FROM " + """" + "lines1" + """" + " T INNER JOIN " + """" + "RAMAIS_AGUA" + """" + " R ON R." + """" + "OBJECT_ID_TRECHO" + """" + " = T." + """" + "object_id" + """" + " ORDER BY R." + """" + "OBJECT_ID_TRECHO" + """" + " ASC", conexao, adOpenDynamic, adLockReadOnly

End If


'MsgBox "ARQUIVO DEBUG SALVO"
' WritePrivateProfileString "A", "A", SQL, App.path & "\DEBUG.INI"


  'sql = "SELECT * FROM NXGS_V_LIG_COMERCIAL_CONSUMO N UNION RAMAIS_AGUA INNER JOIN RAMAIS_AGUA_LIGACAO R on R.NRO_LIGACAO=N.NRO_LIGACAO UNION SELECT * FROM " & TB_GEOMETRIA & " P JOIN WATERLINES W ON P.OBJECT_ID = W.OBJECT_ID_"
 


If frmCanvas.TipoConexao <> 4 Then

Open CAMINHO For Output As #1
      Print #1, "CONSUMIDOR;NRO_LIGACAO;CONSUMO;LOWER_X;UPPER_X;LOWER_Y;UPPER_Y;MES,ANO"
      Do While Not rs.EOF = True
         Print #1, rs!CONSUMIDOR & ";"; rs!NRO_LIGACAO & ";" & rs!consumo_medido & ";" & rs3!lower_x & ";" & rs3!upper_x & ";" & rs3!lower_y & ";" & rs3!upper_y & ";" & rs!Mes & ";" & rs!ANO
         rs.MoveNext
      Loop
   Close #1
   rs.Close
   
   'MousePointer = vbDefault
   Else
   
   
Open CAMINHO For Output As #1
      Print #1, "CONSUMIDOR;NRO_LIGACAO;CONSUMO;COORDENADAS ESPACIAIS;MES,ANO"
      Do While Not rs.EOF = True
         Print #1, rs!CONSUMIDOR & ";"; rs!NRO_LIGACAO & ";" & rs!consumo_medido & ";" & rs3!spatial_data & ";" & rs!Mes & ";" & rs!ANO
         rs.MoveNext
      Loop
   Close #1
   rs.Close
   
   
   
   End If
   
   
   
   MsgBox "Arquivo exportado em " & CAMINHO & ".", vbInformation, "Exporta��o Conclu�da!"




End Sub

Private Sub mnuExportLocalNos_Click()
On Error GoTo Trata_Erro

   Dim CAMINHO As String
   Dim rs As New ADODB.Recordset
   Dim TB_GEOMETRIA As String
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
a = "geom_table"
b = "te_representation"
c = "geom_type"
d = "layer_id"
e = "te_layer"
f = "name"
g = "WATERCOMPONENTS"

   
   If frmCanvas.TipoConexao <> 4 Then
   
   'retornar a tabela de geometria de pontos
   rs.Open "SELECT GEOM_TABLE FROM TE_REPRESENTATION WHERE GEOM_TYPE = 4 AND LAYER_ID IN (SELECT LAYER_ID FROM TE_LAYER WHERE NAME = 'WATERCOMPONENTS')", Conn, adOpenDynamic, adLockReadOnly
   If rs.EOF = False Then
      TB_GEOMETRIA = rs!GEOM_TABLE
   Else
      MsgBox "N�o foi encontrada a tabela de Geometrias.", vbInformation, ""
      Exit Sub
   End If
   Else
   'SELECT "geom_table" FROM "te_representation" WHERE "geom_type" = '4' AND "layer_id" IN (SELECT "layer_id" FROM "te_layer" WHERE "name" = 'WATERCOMPONENTS')
   rs.Open "SELECT " + """" + a + """" + " FROM " + """" + b + """" + " WHERE " + """" + c + """" + " = '4' AND " + """" + d + """" + " IN (SELECT " + """" + d + """" + " FROM " + """" + e + """" + " WHERE " + """" + f + """" + " = 'WATERCOMPONENTS')", Conn, adOpenDynamic, adLockOptimistic
   If rs.EOF = False Then
      TB_GEOMETRIA = rs!GEOM_TABLE
   Else
      MsgBox "N�o foi encontrada a tabela de Geometrias.", vbInformation, ""
      Exit Sub
      End If
   End If
   
   
   rs.Close
   
    If frmCanvas.TipoConexao = 1 Then
   'SELECIONA DO BANCO DE DADOS O C�DIGO DO N�, COORDENADAS E COTA ATUAL
   
   
 
   
   rs.Open "SELECT W.GROUNDHEIGHT AS " + """" + "COTA" + """" + ", LEN(P.OBJECT_ID) AS " + """" + "TAM" + """" + ", P.OBJECT_ID ,P.X,P.Y FROM " & TB_GEOMETRIA & " P JOIN WATERCOMPONENTS W ON P.OBJECT_ID = W.OBJECT_ID_ ORDER BY TAM, OBJECT_ID"
   
   ElseIf frmCanvas.TipoConexao = 2 Then
   
    rs.Open "SELECT W.GROUNDHEIGHT AS " + """" + "COTA" + """" + ", P.OBJECT_ID AS " + """" + "TAM" + """" + ", P.OBJECT_ID ,P.X,P.Y FROM " & TB_GEOMETRIA & " P JOIN WATERCOMPONENTS W ON P.OBJECT_ID = W.OBJECT_ID_ ORDER BY TAM, OBJECT_ID"
   
   
   
   Else
   a = "INITIALGROUNDHEIGHT"
b = "object_id"
c = "x"
d = "y"
e = "WATERCOMPONENTS"
f = LCase(TB_GEOMETRIA)
g = "OBJECT_ID_"



    rs.Open "SELECT " + """" + e + """" + "." + """" + a + """" + " AS " + """" + "COTA" + """" + ", " + """" + f + """" + "." + """" + b + """" + " AS " + """" + "TAM" + """" + ", " + """" + f + """" + "." + """" + b + """" + " ," + """" + f + """" + "." + """" + c + """" + ", " + """" + f + """" + "." + """" + d + """" + " FROM  " + """" + f + """" + " JOIN " + """" + e + """" + "ON" + """" + f + """" + "." + """" + b + """" + " = " + """" + e + """" + "." + """" + g + """" + " ORDER BY " + """" + "TAM" + """" + ", " + """" + b + """" + "", Conn, adOpenDynamic, adLockOptimistic
   End If
   
   
   MousePointer = vbHourglass
   
   CAMINHO = App.path & "\LOCALIZA��O_NOS_REDE_AGUA.txt"
  
   Open CAMINHO For Output As #1
      Print #1, "IDENTIFICADOR;COORD_X;COORD_Y;COTA"
      Do While Not rs.EOF = True
         Print #1, rs!object_id & ";" & rs!X & ";" & rs!Y & ";" & rs!cota
         rs.MoveNext
      Loop
   Close #1
   rs.Close
   
   MousePointer = vbDefault
   
   MsgBox "Arquivo exportado em " & CAMINHO & ".", vbInformation, "Exporta��o Conclu�da!"
   
Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else
   MousePointer = vbDefault
   
   PrintErro CStr(Me.Name), "Private Sub mnuExportLocalNos_Click()", CStr(Err.Number), CStr(Err.Description), True
   
   
End If
   
End Sub

Private Sub mnuBitmap_Click()
   SalvaImagem "BMP"
End Sub

Private Sub mnuLocConsumidores_Click()
   frmEncontraConsumidor.Show 1
End Sub

Private Sub mnuPNG_Click()
   SalvaImagem "PNG"
End Sub

Private Sub mnuGIF_Click()
   SalvaImagem "GIF"
End Sub

Private Sub mnuJPG_Click()
   SalvaImagem "JPG"
End Sub



Private Sub mnuTIF_Click()
   SalvaImagem "TIF"
End Sub

Private Function SalvaImagem(tipo As String)
On Error GoTo saida





If FrmMain.Tag = "0" Then
   
   MsgBox "� necess�rio um mapa para realizar esta fun��o.", vbInformation, ""
   GoTo saida
End If

Dim TP As ImageType
Dim strCaminho As String
   
   'TP = "a"
   
   'PREPARA O FILTRO DO COMPONENTE DE LOCALIZA��O DE ARQUIVOS
   If tipo = "BMP" Then
      Me.cmmSalvaImg.Filter = ".BMP|*.BMP"
      TP = 1 '= BMP
   ElseIf tipo = "GIF" Then
      Me.cmmSalvaImg.Filter = ".GIF|*.GIF"
      TP = 2 '= GIF
   ElseIf tipo = "JPG" Then
      Me.cmmSalvaImg.Filter = ".JPG|*.JPG"
      TP = 3 '= JPG
   ElseIf tipo = "PNG" Then
      Me.cmmSalvaImg.Filter = ".PNG|*.PNG"
      TP = 4 '= PNG
   ElseIf tipo = "TIF" Then
      Me.cmmSalvaImg.Filter = ".TIF|*.TIF"
      TP = 5 '= TIF
   End If
   
   'ABRE O CPMPONENTE DE LOCALIZA��O DE ARQUIVOS
   Me.cmmSalvaImg.ShowOpen
   
   strCaminho = Me.cmmSalvaImg.filename
         
   'SE N�O FOI DEFINIDO UM CAMINHO, SAI DA FUN��O
   If Trim(strCaminho) = "" Then
      GoTo saida
   End If
   
   'SALVA O ARQUIVO DE ACORDO COM O TIPO ESCOLHIDO
   'If tipo = "JPG" Then
      If TCanvas.TCanvas.saveImageToFile(strCaminho, TP) Then
         MsgBox "Imagem salva com sucesso!"

      Else
         MsgBox "Falha ao salvar imagem!"
      End If
   
saida:
   If Err.Number = 0 Or Err.Number = 20 Then
      Resume Next
   Else
      
      PrintErro CStr(Me.Name), "Private Function SalvaImagem(tipo As String)", CStr(Err.Number), CStr(Err.Description), True
      Err.Clear

   End If
End Function

Private Sub mnuFixaIcone_Click()
On Error GoTo Trata_Erro

    With ActiveForm.TCanvas
        
        If .fixedPoint = False Then
            .fixedPoint = True
            
            mnuFixaIcone.Checked = True
            
            Call WriteINI("MAPA", "FIXAR_ICONE", "SIM", App.path & "\CONTROLES\GEOSAN.INI")
            
        Else
            .fixedPoint = False
            mnuFixaIcone.Checked = False
            
            Call WriteINI("MAPA", "FIXAR_ICONE", "NAO", App.path & "\CONTROLES\GEOSAN.INI")
            
        End If
        .plotView
        
    End With
Trata_Erro:

End Sub


Private Sub mnuDefEscala_Click()
On Error GoTo Trata_Erro

   Dim Scala As String
   
   Scala = InputBox("Informe o valor: ", "Defini��o de Escala")
   
   If IsNumeric(Scala) Then
      canvasScale = CDbl(Scala)
   Else
      MsgBox "Valor inv�lido.", vbInformation, ""
   End If


Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else
   MsgBox Err.Number & " - " & Err.Description
End If

End Sub


Private Sub mnuCalcularRede_Click()

   Dim MyComponents As String
   
   With ActiveForm.TCanvas
      If .getCurrentLayer = "WATERLINES" Then
         If .getSelectCount(2) > 0 Then
            If obtemRede(ActiveForm.TCanvas) = True Then
               openForm
            End If
         Else
            MsgBox "Selecione a rede a ser calculada", vbExclamation
         End If
      Else
         .setCurrentLayer "WATERLINES"
         MsgBox "Somente � possivel calcular a rede selecionando os tubos", vbExclamation
      End If
   End With

End Sub

Private Sub mnuChangePassword_Click()

    
    frmTrocaSenha.txtUsuario.Text = strUser
    frmTrocaSenha.txtUsuario.Locked = True
    frmTrocaSenha.Show 1

'   Set Sec = CreateObject("NSecurity.AppMode")
'   If Sec.OpenUserChangePwd(Conn, Usuario.UsrId) Then
'      MsgBox "Senha alterada com sucesso", vbInformation
'   End If
'   Set Sec = Nothing
'
End Sub

Private Sub mnuDeleteInc_Click()

   ActiveForm.CorrigeBug
   
End Sub

Private Sub mnuDeleteLineWater_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kdelete")
   
End Sub

Private Sub mnuDrawLineWater_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kdrawnetworkline")
   
End Sub

Private Sub mnuDrawPointInLineWater_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kinsertnetworknode")
   
End Sub

Private Sub mnuDrawRamal_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kdrawramal")
   
End Sub

Private Sub mnuEncontraTexto_Click()
    'frmCanvas.TimerSetWorld.Enabled = True
    frmEncontraTexto.Show 1
    
End Sub

Private Sub mnuExpAutoCad_Click()

    Dim frm As New FrmExport
   
    'Se nao houver canvas aberto n�o � possivel exportar nada...
    If FrmMain.Tag > 0 Then
        frm.init Conn, ActiveForm.TCanvas, Me
    Else
        MsgBox "N�o � poss�vel exportar quando n�o existe uma �rea de trabalho do mapa.", vbInformation, "Aten��o!"
    End If
   
    'Set frm = Nothing
   
End Sub

Private Sub mnuExpCRD_Click()
On Error GoTo mnuExpCRD_Click_err

   Shell App.path & "\Ferramentas\Exporte EPANet.exe", vbNormalFocus
   Exit Sub


mnuExpCRD_Click_err:
   MsgBox "Programa Exporte EPANet.exe n�o encontrado", vbExclamation, ""
   'Resume
End Sub

Private Sub mnuFileExit_Click()

   End
   Close
   
End Sub



Private Sub mnuGroups_Click()

   Set Sec = CreateObject("NSecurity.AppMode")
   Sec.OpenGroups Conn
   Set Sec = Nothing
   
End Sub

Private Sub mnuHelpAbout_Click()

   frmAbout.Show
   
End Sub

Private Sub mnuImagem_Click()

    'Se nao houver canvas aberto n�o � possivel exportar nada...
    If FrmMain.Tag > 0 Then
        With CDL
           .filename = ""
           .Filter = "Bitmap (*.bmp)|*.bmp | GIF (*.gif) | *.gif | JPG (*.jpg) | *.jpg | PNG (*.png) | *.png | TIF (*.tif) | *.tif"
           .ShowOpen
           If .filename <> "" Then
              ActiveForm.TCanvas.saveImageToFile CDL.filename, .FilterIndex - 1
           End If
        End With
    Else
        MsgBox "N�o � poss�vel exportar quando n�o existe uma �rea de trabalho do mapa.", vbInformation, "Aten��o!"
    End If
   
End Sub

Private Sub mnuImpCotas_Click()
   frmImportarCotas.Show 1
End Sub

Public Function Conecta()

Dim mPROVEDOR As String
Dim mSERVIDOR As String
Dim mPORTA As String
Dim mBANCO As String
Dim mUSUARIO As String
Dim Senha As String
Dim decriptada As String
If frmCanvas.TipoConexao <> 4 Then

   
   
   TeImport1.Provider = typeconnection
   TeImport1.connection = Conn
   
   TeDatabase1.Provider = typeconnection
   TeDatabase1.connection = Conn

Else




'Set teac = TeAcXConnection1
If frmCanvas.POSTB <> 10 Then
mSERVIDOR = ReadINI("CONEXAO", "SERVIDOR", App.path & "\CONTROLES\GEOSAN.ini")
mPORTA = ReadINI("CONEXAO", "PORTA", App.path & "\CONTROLES\GEOSAN.ini")
mBANCO = ReadINI("CONEXAO", "BANCO", App.path & "\CONTROLES\GEOSAN.ini")
mUSUARIO = ReadINI("CONEXAO", "USUARIO", App.path & "\CONTROLES\GEOSAN.ini")
Senha = ReadINI("CONEXAO", "SENHA", App.path & "\CONTROLES\GEOSAN.ini")
frmCanvas.FunDecripta (Senha)
decriptada = frmCanvas.Senha

'If TeAcXConnection1.Open = False Then

 TeAcXConnection1.Open mUSUARIO, decriptada, mBANCO, mSERVIDOR, mPORTA
 ' End If

 
 TeImport1.Provider = typeconnection
   TeImport1.connection = TeAcXConnection1.objectConnection_
   
   TeDatabase1.Provider = typeconnection
   TeDatabase1.connection = TeAcXConnection1.objectConnection_
  frmCanvas.POST2B (10)
'   Else
   
  '' a1.Provider = typeconnection
  ' a1.connection = teac.objectConnection_
   
  ' a2.Provider = typeconnection
  ' a2.connection = teac.objectConnection_
   End If
End If

End Function

Private Sub mnuImportDXF_Click()
   

  ' Set a1 = TeImport1
 ' Set a2 = TeDatabase1
   
Dim frm As New frmImportDxf

Conecta

   
        frm.init Conn, TeImport1, TeDatabase1
   Set frm = Nothing
   'changeSelIntersectionPoint
End Sub

Private Sub mnuImportSIG_Click()
   
   Dim frm As New frmImportFile
   
   'Dim a1 As TeImport
  ' Dim a2 As TeDatabase
  ' Set a1 = TeImport1
 ' Set a2 = TeDatabase1
   

   
Conecta
   

      frm.init Conn, TeImport1, TeDatabase1
   Set frm = Nothing
   
End Sub

Private Sub mnuInsertDocs_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kinsertdoc")
   
End Sub

Private Sub mnuInsertLabel_Click()

   FrmCreatTextForLayer.init
   
End Sub

Private Sub mnuLayers_Click()
   
   Dim rs As ADODB.Recordset
Dim a, b, c As String
   Set rs = New ADODB.Recordset
a = "USRLOG"
b = "USRFUN"
c = "SYSTEMUSERS"



   If frmCanvas.TipoConexao <> 4 Then
   rs.Open "SELECT USRLOG, USRFUN FROM SYSTEMUSERS WHERE USRLOG = '" & strUser & "' ORDER BY USRLOG", Conn, adOpenDynamic, adLockReadOnly
   Else
   rs.Open "SELECT " + """" + a + """" + "," + """" + b + """" + " FROM " + """" + c + """" + " WHERE " + """" + a + """" + " = '" & strUser & "' ORDER BY " + """" + a + """" + "", Conn, adOpenDynamic, adLockOptimistic
   End If
   If rs.EOF = False Then
      If rs!UsrFun = 4 Then  'VISUALIZADOR
         
         frmLoginTema.Show 1
                  
         'pctSfondo.Visible = True
      Else
      
         pctSfondo.Visible = Not mnuLayers.Checked
         mnuLayers.Checked = Not mnuLayers.Checked
      
      End If
   End If
   rs.Close
   

   
End Sub

Private Sub mnuLoadAttributeByReference_Click()

   mnuLoadAttributeByReference.Checked = Not mnuLoadAttributeByReference.Checked
   
End Sub

Private Sub mnuManufacters_Click()

   FrmManufactures.Show
   
End Sub

Private Sub mnuMinusZoom_Click()
 
   tbToolBar_ButtonClick tbToolBar.Buttons("kzoomin")
   
End Sub

Private Sub mnuMoreZoom_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kzoomout")
   
End Sub

Private Sub mnuMove_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kpan")
   
End Sub

Private Sub mnuMovePointWithLines_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kmovenetworknode")
   
End Sub

Private Sub mnuMultProperteis_Click()

   mnuMultProperteis.Checked = Not mnuMultProperteis.Checked
   
End Sub




Private Sub mnuRecompose_Click()
   tbToolBar_ButtonClick tbToolBar.Buttons("krecompose")
End Sub

Private Sub mnuRamaisAgua_Click()
    frmIndicProdutRamaisAgua.Show 1
End Sub

Private Sub mnuRedesAgua_Click()
    
    frmIndicProdutRedesDeAgua.TipoRede = "AGUA"
    frmIndicProdutRedesDeAgua.Show 1
    
    
End Sub

Private Sub mnuRedesEsgoto_Click()
    
    frmIndicProdutRedesDeAgua.TipoRede = "ESGOTO"
    frmIndicProdutRedesDeAgua.Show 1
    
End Sub

Private Sub mnuRedoView_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kredoview")
   
End Sub

Private Sub mnuRelComponentesAgua_Click()

   GeraRelatorioHtm ComponentsRede, "watercomponents"
   
End Sub

Private Sub mnuRelComponentesEsgoto_Click()

   GeraRelatorioHtm ComponentsRede, "sewercomponents"
   
End Sub

Private Sub mnuRelComponentsWaterFilter_Click()

   GeraRelatorioHtm ComponentsRede, "watercomponents", True
   
End Sub

Private Sub mnuRelRegistros_Click()

   GeraRelatorioHtm RegistrosEstadoEstado, ""
   
End Sub

Private Sub MnuRelSl_Click()

   OpenReport "sewer"
   
End Sub

Private Sub MnuRelWl_Click()

   OpenReport "water"
   
End Sub

Private Sub mnuRemoverPlano_Click()

   FrmRemoverPlano.Show vbModal
   
End Sub

Private Sub mnuSELECT_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kselection")
   
End Sub

Private Sub mnuSELECTDatabase_Click()

On Error GoTo Trata_Erro

    'FrmConnection.Show (1)

   Dim cn As ADODB.connection, nC As Object
   
   Set nC = CreateObject("NexusConnection.App")
   If nC.appNewRegistry(App.EXEName, cn) Then
      Conn.Close
      'Set Conn = cn
      'Shell App.path & "\" & App.EXEName & ".exe"
      MsgBox "Banco de dados redirecionado com sucesso." & Chr(13) & Chr(13) & "Reinicie o sistema para ativar.", vbInformation
      'Set cn = Nothing
      End
   End If
   
Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else

   PrintErro CStr(Me.Name), "Private Sub mnuSELECTDatabase_Click()", CStr(Err.Number), CStr(Err.Description), True
   

End If

End Sub

Private Sub mnuSuppliers_Click()

   FrmSuppliers.Show
   
End Sub



Private Sub mnuTypes_Click()

   FrmSelectTypes.init
   
End Sub

Private Sub mnuUndoView_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kundoview")
   
End Sub
'Exporta as redes do GeoSan
'
'
Private Sub mnuExporta_GeoSan_Click()
    Dim exp As New GeosanExport
    Dim retorno As Boolean
    Dim conexao As New ADODB.connection
    
    Screen.MousePointer = vbHourglass
    
    'exporta consumidores
    exp.InsereTabAtributoConsumidores
    exp.CriaTabelaConsumidores
    exp.InsereConsumidores
    exp.AtivaExportacaoConsumidores
    conexao.Open Conn
    TeExport2.Provider = 1
    TeExport2.connection = conexao
    retorno = TeExport2.exportSHP("d:\gsConsumidores.shp", "RAMAIS_AGUA", "GS_CONSUMIDORES")
    Screen.MousePointer = vbNormal
    If retorno Then
        MsgBox "Exporta��o shape de ramais realizada com sucesso"
    Else
        MsgBox "Falha na exporta��o"
    End If
    conexao.Close
    
    'exporta ramais
    exp.InsereTabAtributoRamais
    exp.CriaTabelaRamais
    exp.InsereRamais
    exp.AtivaExportacaoRamais
    conexao.Open Conn
    TeExport2.Provider = 1
    TeExport2.connection = conexao
    retorno = TeExport2.exportSHP("d:\gsRamais.shp", "RAMAIS_AGUA", "GS_RAMAIS")
    Screen.MousePointer = vbNormal
    If retorno Then
        MsgBox "Exporta��o shape de ramais realizada com sucesso"
    Else
        MsgBox "Falha na exporta��o"
    End If
    conexao.Close
    
    
    'prepara tabelas e atributos para exportar as redes
    exp.InsereTabAtributoRedes
    exp.CriaTabelaRedes
    exp.InsereRedes
      
    'exp.ExportaRedesAguaShp
    'exporta para o formato shape
    conexao.Open Conn
    TeExport2.Provider = 1
    TeExport2.connection = conexao
    retorno = TeExport2.exportSHP("d:\gsRedes.shp", "WATERLINES", "GS_REDES")
    Screen.MousePointer = vbNormal
    If retorno Then
        MsgBox "Exporta��o shape de redes realizada com sucesso"
    Else
        MsgBox "Falha na exporta��o"
    End If
    conexao.Close
    
    'prepara tabelas e atributos para exportar os n�s
    exp.InsereTabAtributoNos
    exp.CriaTabelaNos
    exp.InsereNos
    
    conexao.Open Conn
    TeExport2.Provider = 1
    TeExport2.connection = conexao
    'exporta para o formato shape os n�s
    'conexao.Open Conn
    'TeExport2.Provider = 1
    'TeExport2.connection = conexao
    exp.AtivaExportacaoNos
    retorno = TeExport2.exportSHP("d:\gsNos.shp", "WATERCOMPONENTS", "GS_NOS")
    exp.DesativaExportacaoNos
    Screen.MousePointer = vbNormal
    If retorno Then
        MsgBox "Exporta��o dos n�srealizada com sucesso"
    Else
        MsgBox "Falha na exporta��o"
    End If
    conexao.Close
End Sub

Private Sub mnuUpdate_Demand_Click()

Dim cgeo As New clsGeoReference

'If frmCanvas.TipoConexao = 1 Then

   
   frmAtualizacaoConsumo.Show 1

'Else
'
'   cgeo.Update_Demand_Node
'
'End If


'UPDATE RAMAIS_AGUA_LIGACAO SET CONSUMO_LPS = NXGS.CONSUMO_MEDIDO FROM RAMAIS_AGUA_LIGACAO AS RAL INNER JOIN NXGS_V_LIG_COMERCIAL_CONSUMO AS NXGS ON RAL.NRO_LIGACAO = NXGS.NRO_LIGACAO

'Se ao inv�s do consumo medido for utilizado o consumo faturado, o comando �:

'UPDATE RAMAIS_AGUA_LIGACAO SET CONSUMO_LPS = NXGS.CONSUMO_FATURADO FROM RAMAIS_AGUA_LIGACAO AS RAL INNER JOIN NXGS_V_LIG_COMERCIAL_CONSUMO AS NXGS ON RAL.NRO_LIGACAO = NXGS.NRO_LIGACAO


Set cgeo = Nothing

End Sub

Private Sub mnuUsers_Click()

'   Set Sec = CreateObject("NSecurity.AppMode")
'   Sec.OpenUsers Conn
'   Set Sec = Nothing
   
   frmUserControle.Show 1
   'FrmUser.Show 1
   
End Sub

Private Sub mnuViewStatusBar_Click()

   sbStatusBar.Visible = Not mnuViewStatusBar.Checked
   mnuViewStatusBar.Checked = Not mnuViewStatusBar.Checked
   
End Sub

Private Sub mnuViewToolbar_Click()

   tbToolBar.Visible = Not mnuViewToolbar.Checked
   mnuViewToolbar.Checked = Not mnuViewToolbar.Checked
   
End Sub

Private Sub mnuWindowCascade_Click()

   Me.Arrange vbCascade
   
End Sub

Private Sub mnuWindowTileHorizontal_Click()

   Me.Arrange vbTileHorizontal
   
End Sub

Private Sub mnuWindowTileVertical_Click()

   Me.Arrange vbTileVertical
   
End Sub

Private Sub mnuZoom_Click()

   tbToolBar_ButtonClick tbToolBar.Buttons("kzoomarea")
   
End Sub

Private Sub OdImport_Click()
   
   Form1.Show 1
   
End Sub

Private Sub pctSfondo_Resize()

   SizeControls
   
End Sub

Private Sub MDIForm_Resize()

   SizeControls
   
End Sub


Public Sub SizeControls()
On Error GoTo Trata_Erro
   
   With TabStrip1
      .Height = IIf(pctSfondo.Height < .Top, 100, pctSfondo.Height - .Top)
      .Width = IIf(pctSfondo.Width < .Left, 100, pctSfondo.Width - .Left)
   End With
   With Manager1
      .Width = IIf(pctSfondo.Width < .Left, 10, pctSfondo.Width - (.Left + 100))
      .Height = IIf(pctSfondo.Height < .Top, 10, pctSfondo.Height - (.Top + 100))
      .Resize pctSfondo.Width - 400, pctSfondo.Height - 1400
      .Top = 1340
      .Left = 300
   End With
   With ViewManager1
      .Width = IIf(pctSfondo.Width < .Left, 10, pctSfondo.Width - (.Left + 100))
      .Height = IIf(pctSfondo.Height < .Top, 10, pctSfondo.Height - (.Top + 100))
      .Top = 1350
      .Left = 300
   End With
   picSplitter.Height = pctSfondo.Height
   imgSplitter.Height = pctSfondo.Height
   
   cmdClose.Left = pctSfondo.Width - 300
   cmdClose.Top = pctSfondo.Top - 350
   FrameEscala.Width = pctSfondo.Width - 300
   txtEscala.Width = pctSfondo.Width - 2350

Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    ElseIf Err.Number = 380 Then
         Exit Sub
    Else
    
      PrintErro CStr(Me.Name), "Public Sub SizeControls()", CStr(Err.Number), CStr(Err.Description), True
      
      
    End If

End Sub

Private Sub MDIForm_Unload(Cancel As Integer)

On Error GoTo Trata_Erro
    
    
   If FrmMain.ViewManager1.mConn.State = 1 Then
      FrmMain.ViewManager1.mConn.Close
   End If
    
    If Conn.State = 1 Then
      Conn.Close
    End If
    

    Set Conn = Nothing
    'LoozeXP1.EndWinXPCSubClassing
    End
   
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
    
         'PrintErro CStr(Me.Name), "Private Sub MDIForm_Unload", CStr(Err.Number), CStr(Err.Description), True
         
    
    End If

End Sub
' Op��o do menu de �cones que abre uma janela de desenho de mapa.
' Entra nesta rotina quando o usu�rio seleciona a �cone de que deseja uma nova janela de desenho
'
'
'
Private Sub mnuOpen_Click()
    Set TCanvas = New frmCanvas
    TCanvas.init Conn, usuario.UseName
End Sub

Private Sub TabStrip1_Click()

   If TabStrip1.SelectedItem.index = 2 Then
      Manager1.Visible = True
      'Tv.Visible = False
      ViewManager1.Visible = False
   Else
      Manager1.Visible = False
      'Tv.Visible = True
      ViewManager1.Visible = True
   End If
   
End Sub
' Monitoramento dos eventos da barra de �cones. Evento de clique na barra de ferramentas
' Fica aguardando o usu�rio selecionar uma das �cones na barra de menu de �cones
' Caso a janela de desenho (canvas) n�o estiver aberto, n�o faz nada ainda
' Caso esteja aberta a sele��o da �cone
' Caso selecione que � para abrir uma nova janela de desenho (canvas), abre a mesma
'
' Button - bot�o que foi selecionado pelo usu�rio
'
Public Sub tbToolBar_ButtonClick(ByVal Button As MSComctlLib.Button)
'If blnMonitorar = True Then
    On Error GoTo Trata_Erro
    Select Case Button.key
        Case "knew", ""
           mnuOpen_Click
        Case Else
           If Not ActiveForm Is Nothing Then
              If ActiveForm.Name = "frmCanvas" Then         'se o canvas de mapas est� na tela
                  ActiveForm.Tb_SELECT Button.key           'indica a ativa��o do bot�o que foi selecionado
              End If
           End If
    End Select
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    ElseIf Err.Number = 91 Then
        Err.Clear
        Exit Sub
    Else
        PrintErro CStr(Me.Name), "N�o est� encontrando o bot�o a ser selecionado em Public Sub tbToolBar_ButtonClick()", CStr(Err.Number), CStr(Err.Description), True
    End If
End Sub


Private Sub TePrinter_Click()

   'frmPrint As New frm1TePrinter

   frmTePrinter.Show 1
   

End Sub

Private Sub txtEscala_KeyPress(KeyAscii As Integer)

'AO RECEBER UM COMANDO ENTER, � FOR�ADO UM LOST_FOCUS

If KeyAscii = 13 Then
   
   txtEscala_LostFocus
   
End If

End Sub

Private Sub txtEscala_LostFocus()

   If IsNumeric(Me.txtEscala.Text) = True Then
 
      canvasScale = CDbl(Me.txtEscala.Text)
   
   End If
   
End Sub


Private Sub ViewManager1_onReset(ViewName As String)
On Error GoTo Trata_Erro

   Dim a As Integer, LayerNameStr As String
   
   For a = 1 To tbToolBar.Buttons.count
      If tbToolBar.Buttons.Item(a).Style = tbrCheck Then
         tbToolBar.Buttons(a).value = tbrUnpressed
      End If
   Next
   
   
   strLayerAtivo = TCanvas.TCanvas.getCurrentLayer
   
   With Me.ActiveForm.TCanvas
      For a = 0 To .getLayersToSnapCount() - 1
         If .getLayerToSnap(a, LayerNameStr) = 1 Then
            .removeLayerToSnap LayerNameStr
         End If
      Next
   End With
   
   tbToolBar.Buttons("kselection").value = tbrPressed
   
   Me.ActiveForm.Caption = "Vista: " & ViewName
   sbStatusBar.Panels(1).Text = "Modo de sele��o: Selecione um objeto do plano referente ao tema ativo"

Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
        
        PrintErro CStr(Me.Name), "Private Sub ViewManager1_onReset", CStr(Err.Number), CStr(Err.Description), True
        
        
    End If
End Sub

Private Sub mnuCarregaPoligono_Click()


On Error GoTo Trata_Erro

   Dim rs As ADODB.Recordset
   Dim strsql As String
   
   blnPoligonoVirtual = False
   Dim a, b, c, d, e, f As String
   Set rs = New ADODB.Recordset
a = "layer_id"
b = "geom_table"
c = "te_representation"
d = "geom_type"
e = "te_layer"
f = "name"




     If frmCanvas.TipoConexao <> 4 Then
   strsql = "SELECT TL.LAYER_ID,TL.NAME,TR.GEOM_TABLE FROM TE_LAYER TL INNER JOIN TE_REPRESENTATION TR ON TL.LAYER_ID = TR.LAYER_ID WHERE TR.GEOM_TYPE = 1 AND TL.NAME = '" & strLayerAtivo & "'"
   Else
   strsql = "SELECT " + """" + e + """" + "." + """" + a + """" + "," + """" + e + """" + "." + """" + f + """" + "," + """" + c + """" + "." + """" + b + """" + " FROM " + """" + e + """" + " INNER JOIN " + """" + c + """" + " ON " + """" + e + """" + "." + """" + a + """" + " = " + """" + c + """" + "." + """" + a + """" + " WHERE " + """" + c + """" + "." + """" + d + """" + " = '1' AND " + """" + e + """" + "." + """" + f + """" + "= '" & strLayerAtivo & "'"
   End If
   
   
   
'MsgBox "ARQUIVO DEBUG SALVO"
 'WritePrivateProfileString "A", "A", strsql, App.path & "\DEBUG.INI"
 
   rs.Open strsql, Conn, adOpenDynamic, adLockOptimistic
   
   If rs.EOF = False Then
   
a = "object_id"
b = LCase(rs!GEOM_TABLE)



      If frmCanvas.TipoConexao <> 4 Then
      strsql = "SELECT COUNT(OBJECT_ID) AS " + """" + "QTD" + """" + " FROM " & rs!GEOM_TABLE
      Else
      strsql = "SELECT COUNT(" + """" + a + """" + ") AS " + """" + "QTD" + """" + " FROM " + """" + b + """" + ""
      End If
      rs.Close
      rs.Open strsql, Conn, adOpenDynamic, adLockOptimistic
      If rs!qtd = 0 Then
         MsgBox "O plano ativo n�o possui pol�gonos.", vbInformation, ""
         rs.Close
         Exit Sub
      End If
      rs.Close
      Me.MousePointer = vbHourglass
      frmAtualizarSetores.Show 1
      Me.MousePointer = vbDefault
   
   Else
      MsgBox "O plano ativo n�o possui pol�gonos.", vbInformation, ""
      rs.Close
   End If
   
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
         
         PrintErro CStr(Me.Name), "mnuCarregaPoligono_Click()", CStr(Err.Number), CStr(Err.Description), True
         
        
    End If

End Sub


Private Sub mnuDesenhaPoligono_Click()




 If ActiveForm.Name = "frmCanvas" Then
                  ActiveForm.Tb_SELECT "mnuPoligono"
                  
                  
              End If



End Sub








