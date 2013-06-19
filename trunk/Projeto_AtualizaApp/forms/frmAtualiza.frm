VERSION 5.00
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "MSINET.OCX"
Begin VB.Form frmAtualiza 
   Caption         =   "Atualiza GeoSan"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton ObtemVersao 
      Caption         =   "Vers�o"
      Height          =   735
      Left            =   2520
      TabIndex        =   2
      Top             =   2040
      Width           =   1815
   End
   Begin VB.CommandButton FazDownload 
      Caption         =   "Download"
      Height          =   615
      Left            =   360
      TabIndex        =   0
      Top             =   1920
      Width           =   1695
   End
   Begin InetCtlsObjects.Inet Inet1 
      Left            =   4080
      Top             =   240
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
   Begin VB.Label lblStatus 
      Caption         =   "Label1"
      Height          =   375
      Left            =   360
      TabIndex        =   1
      Top             =   480
      Width           =   1935
   End
End
Attribute VB_Name = "frmAtualiza"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Refer�ncias adicionadas:
'Microsoft Scripting Runtime - srcrun.dll - para saber a vers�o de uma aplica��o
'Microsoft CDO for Windows 2000 Library - cdosys.dll
'Componentes adicionados:
'Microsoft Internet Transfer Control 6.0 - msinet.ocx - para fazer download de arquivos
'
' Arquivo GeoSan.ini
'[ATUALIZACAO]                  - informa��es para o GeoSan atualizar-se automaticamente
'WEB = NAO                      - indica que vai buscar as atualiza��es em um diret�rio local
'DIRETORIO=\download\GeoSan     - nome do sub-diret�rio onde ir� buscar as atualiza��es, se for web a barra e normal ficando: /download/GeoSan
'URL=c:\tempFtp                 - nome do diret�rio (caso esteja loca a atualiza��o) ou endere�o web, p. ex.: http://www.nexusbr.com
'proxyPorta = NULO              - n�mero da porta em que ser� buscada a atualiza��o. Para buscar no site da NEXUS � porta 80
'proxy = NULO                   - endere�o do proxy da interno da empresa
'DIRETORIOLOCAL=c:\tempApp      - nome do diret�rio completo para onde ser�o baixadas as atualiza��es
'USUARIO=nexus                  - nome do usu�rio para logar no proxy interno da empresa
'SENHA=senha                    - senha para logar no proxy interno da empresa
'
Dim b() As Byte

Public ErroUsuario As New CPrintErro            'Para gerenciar os erros que por ventura ocorram
Public conf As New CArquivoIni                  'Para ler e escrever as configura��es de trabalho do arquivo GEOSAN.INI
Dim versao As CGetVersion                               'gest�o das vers�es de software que dever�o ser atualizadas



Private Sub Command1_Click()
End
End Sub

Private Sub FazDownload_Click()
    Dim carrega As CDownload                                'para fazer o download de novas atualiza��es
    Dim retorno As Boolean
    
    Dim numeroVersao As String
    Dim numeroAtualizacoes  As Integer                      'n�mero total de atualiza��es a serem realizadas
    Dim i As Integer
    Dim nomeArquivo As String                               'nome do arquivo a ser atualizado
    Dim diretorio As String                                 'nome do drive e diret�rio onde o arquivo ser� atualizado (salvo)
    Dim versaoNova As String                                'numero da vers�o nova a ser atualizada
    
    'faz as configura��es iniciais
    Set carrega = New CDownload
    
    Set conf = New CArquivoIni                              'leitura e escrita no arquivo GeoSan.ini
    numeroVersao = versao.ObtemVersao("D:\Desenv\GEOSAN_VB6_B\trunk\Projeto_AtualizaApp\GeoSanIni.exe")
    conf.dirGeoSanIni = "D:\Desenv\GEOSAN_VB6_B\trunk\Controles"
    carrega.atualizacaoWeb = conf.ReadINI("ATUALIZACAO", "WEB")                 'se a atualiza��o ser� realizada pela web ou n�o
    carrega.diretorioServidor = conf.ReadINI("ATUALIZACAO", "DIRETORIO")        '\download\GeoSan
    carrega.portaWww = conf.ReadINI("ATUALIZACAO", "PORTAWWW")                  'porta do servidor na web em que est�o os arquivos
    carrega.url = conf.ReadINI("ATUALIZACAO", "URL")                            'c:\tempFtp ou http://www.nexusbr.com
    carrega.proxyPorta = conf.ReadINI("ATUALIZACAO", "PROXYPORTA")
    carrega.proxy = conf.ReadINI("ATUALIZACAO", "PROXY")
    carrega.diretorioLocal = conf.ReadINI("ATUALIZACAO", "DIRETORIOLOCAL")      'c:\tempApp
    
    Me.Show
    Screen.MousePointer = vbHourglass
    lblStatus.Caption = "Realizando download de atualiza��es ..."
    
    retorno = carrega.DownloadArquivo("Updates.txt")        'obtem a lista de atualiza��es dispon�veis
    lblStatus.Caption = "Download completo!"
    numeroAtualizacoes = versao.VerificaAtualizacoes("c:\tempApp\Updates.txt")
    For i = 0 To numeroAtualizacoes - 1                     'enquanto existirem atualiza��es para se fazer download
        versao.SplitAtualizacoes i, nomeArquivo, diretorio, versaoNova
        retorno = carrega.DownloadArquivo(nomeArquivo)      'faz o download para o diret�rio local, da atualiza��o
        If versao.ExisteArquivo("c:\arquivos de programas\GeoSan\" & nomeArquivo) Then
            MsgBox versao.ObtemVersaoArquivo("c:\arquivos de programas\GeoSan\" & nomeArquivo)
        End If
        
    Next
    
    
    Screen.MousePointer = vbDefault
End Sub

Private Sub Form_Load()
    Set versao = New CGetVersion
    
    
'    End
    
'    Dim MyVer As String
'    MyVer = App.Major & "." & App.Minor & "." & App.Revision
'    Open "c:\tempFtp\Version.Ver" For Output As #1
'    Write #1, MyVer
'    Close #1
'    MsgBox "vers�o 1.1.0"
'    Me.Show
'    Screen.MousePointer = vbHourglass
'    lblStatus.Caption = "Realizando download de atualiza��es ..."
'    retorno = carrega.DownloadArquivo("Updates.txt")
'    lblStatus.Caption = "Download completo!"
'    Screen.MousePointer = vbDefault
'    Command1.Visible = True
End Sub

Private Sub ObtemVersao_Click()
    Dim retorno As Boolean
    
    retorno = versao.ExisteArquivo("D:\Desenv\GEOSAN_VB6_B\trunk\Projeto_AtualizaApp\GeoSanIni.exe")
    If retorno = True Then
        MsgBox versao.ObtemVersaoArquivo("D:\Desenv\GEOSAN_VB6_B\trunk\Projeto_AtualizaApp\GeoSanIni.exe")
    End If
End Sub
