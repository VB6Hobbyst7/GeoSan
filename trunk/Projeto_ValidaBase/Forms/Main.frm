VERSION 5.00
Object = "{87AC6DA5-272D-40EB-B60A-F83246B1B8D7}#1.0#0"; "TeComDatabase.dll"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Begin VB.Form FormuarioPrincipal 
   Caption         =   "Valida Base de Dados GeoSan"
   ClientHeight    =   1770
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5970
   LinkTopic       =   "ValidaBase"
   ScaleHeight     =   1770
   ScaleWidth      =   5970
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   3
      Top             =   1395
      Width           =   5970
      _ExtentX        =   10530
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   3
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   5292
            MinWidth        =   5292
            Text            =   "Verifica��o"
            TextSave        =   "Verifica��o"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Text            =   "N�"
            TextSave        =   "N�"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Text            =   "Trecho Rede"
            TextSave        =   "Trecho Rede"
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton Cancela 
      Caption         =   "Cancelar"
      Height          =   375
      Left            =   1080
      TabIndex        =   1
      Top             =   720
      Width           =   1815
   End
   Begin VB.CommandButton ProcessaBancoDados 
      Caption         =   "Inicia Processamento"
      Height          =   375
      Left            =   3240
      TabIndex        =   0
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label Label1 
      Caption         =   "Realize backup do banco de dados antes de iniciar"
      Height          =   375
      Left            =   1200
      TabIndex        =   2
      Top             =   240
      Width           =   3735
   End
   Begin TECOMDATABASELibCtl.TeDatabase TeDatabase1 
      Left            =   240
      OleObjectBlob   =   "Main.frx":0000
      Top             =   480
   End
End
Attribute VB_Name = "FormuarioPrincipal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Vers�o 01.00.01 VALIDABASE
'Checa a base de dados para verifica��o da integridade da mesma para exporta��o para simula��o hidr�ulica

Option Explicit                         'Impede que uma vari�vel seja utilizada sem que a mesma seja antes criada

Public Conn As New ADODB.Connection     'Define de forma global uma conex�o com o banco de dados

Dim rsBusca As New ADODB.Recordset
Dim rsLayer As New ADODB.Recordset
Dim rsLinha As New ADODB.Recordset
Dim VALID As Boolean
Dim strSql As String
Dim rsFinal2 As New ADODB.Recordset
Dim rsSemPoints As New ADODB.Recordset
Dim rslinha1 As New ADODB.Recordset
Dim rslinha2 As New ADODB.Recordset
Dim strXL1 As String, strXL2 As String, strYL1 As String, strYL2 As String
Private Sub cmdCancelar_Click()
   Unload Me
End Sub
Private Sub ObtemCoordenadasIniciaisEFinaisLinha()

End Sub
Private Sub cmdExit_Click()
    Conn.Close
    Close #1
End Sub
'Ir� verificar se todos os compontentes (n�s) iniciais que est�o definidos na tabela de atributo Waterlines, est�o presentes
'Esta fun��o varre toda tabela Waterlines na coluna de n� inicial e procura se o n� informado existe na tabela Watercomponents
'
' arquivoLog - nome do arquivo em que s�o gerados os logs da valida��o
'
Function ValidaComponentesIniciaisDeWaterlines(arquivoLog As String)
    Dim rsVBL As New ADODB.Recordset
    Dim rsVBP As New ADODB.Recordset
    Dim blnPontoCriado As Boolean           'Indica se a geometria do ponto foi criada ou n�o
    
    Open arquivoLog For Append As #1
    Print #1, vbCrLf & "In�cio;ValidaComponentesIniciaisDeWaterlines"
    Close #1
    'Seleciona todos os object_id_s e componentes iniciais da tabela Waterlines
    Set rsVBL = Conn.Execute("SELECT OBJECT_ID_ AS COD,INITIALCOMPONENT AS INI FROM WATERLINES ORDER BY INITIALCOMPONENT")
    'Se existirem redes de �gua
    If rsVBL.EOF = False Then
        'Seleciona todos os n�meros dos componentes existentes dos n�s
        Set rsVBP = Conn.Execute("SELECT COMPONENT_ID AS COMPONENTE FROM WATERCOMPONENTS ORDER BY COMPONENT_ID")
        'VALIDANDO TODOS OS COMPONENTES INITIAL DA WATERLINES
        'Se existirem n�s de redes
        If rsVBP.EOF = False Then
            'Enquanto existirem n�s e trechos de redes
            Do While Not rsVBP.EOF = True And Not rsVBL.EOF = True
                'Se o n� est� presente na componente inicial do trecho de rede
                If rsVBP!COMPONENTE = rsVBL!ini Then 'validado
                    'Vamos ver o pr�ximo trecho de rede, pois j� foi encontrado o n� para o componente inicial do trecho de rede em Waterlines
                    rsVBL.MoveNext      'Move para o pr�ximo trecho de rede
                    VALID = True        'Informa que foi validado e encontrado o n� inicial para o trecho de rede
                'Caso o n� seja menor que o n� inicial do trecho de rede
                ElseIf rsVBP!COMPONENTE < rsVBL!ini Then
                    'Procura o pr�ximo n�, pois n�o encontrou o n� inicial da tabela Waterlines ainda
                    rsVBP.MoveNext      'Veja qual o pr�ximo n� de Watercomponents
                    VALID = False       'Informa que ainda n�o encontrou o n� inicial de Waterlines em Watercomponents
                Else
                    'O n� � maior do que o componente inicial do trecho de rede, isto quer dizer que ele n�o foi encontrado.
                    Open arquivoLog For Append As #1
                    Print #1, "ValidaComponentesIniciaisDeWaterlines-20;Componente Inicial:"; Tab(21); rsVBL!ini; Tab(31); "da linha"; Tab(40); rsVBL!COD; Tab(50); "N�O ENCONTRADO."
                    Close #1
                    
                    CriaComponenteDefault (rsVBL!ini)
                    If blnPontoCriado = True Then
                        Open arquivoLog For Append As #1
                        Print #1, "ValidaComponentesIniciaisDeWaterlines-21;Componente " & rsVBL!ini & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
                        Close #1
                    Else
                        Open arquivoLog For Append As #1
                        Print #1, "ValidaComponentesIniciaisDeWaterlines-22;Componente " & rsVBL!ini & " N�O PODE SER CRIADO AUTOMATICAMENTE."
                        Close #1
                    End If
                    rsVBL.MoveNext
                End If
                'Verifica se chegarmos ao final da leitura de todos os n�s e n�o exsitem mais n�s para lermos
                If rsVBP.EOF = True Then
                    If VALID = False Then
                        Do While Not rsVBL.EOF = True
                            Print #1, "ValidaComponentesIniciaisDeWaterlines-23;Componente Inicial:"; Tab(21); rsVBL!ini; Tab(31); "da linha"; Tab(40); rsVBL!COD; Tab(50); "n�o encontrado!"
                            blnPontoCriado = CriaComponenteDefault(rsVBL!ini)
                            If blnPontoCriado = True Then
                                Open arquivoLog For Append As #1
                                Print #1, "ValidaComponentesIniciaisDeWaterlines-24;Componente " & rsVBL!ini & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
                                Close #1
                            Else
                                Open arquivoLog For Append As #1
                                Print #1, "ValidaComponentesIniciaisDeWaterlines-25;Componente " & rsVBL!ini & " N�O PODE SER CRIADO AUTOMATICAMENTE."
                                Close #1
                            End If
                            rsVBL.MoveNext
                        Loop
                    End If
                    Exit Do
                End If
           Loop
       End If
   End If
   Open arquivoLog For Append As #1
   Print #1, "Fim;ValidaComponentesIniciaisDeWaterlines"
   Close #1
End Function
'Ir� verificar se todos os compontentes (n�s) finais que est�o definidos na tabela de atributo Waterlines, est�o presentes
'Esta fun��o varre toda tabela Waterlines na coluna de n� final e procura se o n� informado existe na tabela Watercomponents
'
' arquivoLog - nome do arquivo em que s�o gerados os logs da valida��o
'
Function ValidaComponentesFinaisDeWaterlines(arquivoLog As String)
    Dim rsVBL As New ADODB.Recordset
    Dim rsVBP As New ADODB.Recordset
    Dim blnPontoCriado As Boolean           'Indica se a geometria do ponto foi criada ou n�o
    
    Open arquivoLog For Append As #1
    Print #1, vbCrLf & "In�cio;ValidaComponentesFinaisDeWaterlines"
    Close #1
    'Seleciona todos os object_id_s e componentes finais da tabela Waterlines
    Set rsVBL = Conn.Execute("SELECT OBJECT_ID_ AS COD,FINALCOMPONENT AS FIM FROM WATERLINES ORDER BY FINALCOMPONENT")
    'Se existirem redes de �gua
    If rsVBL.EOF = False Then
        Set rsVBP = Conn.Execute("SELECT COMPONENT_ID AS COMPONENTE FROM WATERCOMPONENTS ORDER BY COMPONENT_ID")
        'VALIDANDO TODOS OS COMPONENTES FINAL DA WATERLINES
        'Se existirem n�s de redes
        If rsVBP.EOF = False Then
            'Enquanto existirem n�s e trechos de redes
            Do While Not rsVBP.EOF = True And Not rsVBL.EOF = True
                'Se o n� est� presente na componente final do trecho de rede
                If rsVBP!COMPONENTE = rsVBL!fim Then 'validado
                    'Vamos ver o pr�ximo trecho de rede, pois j� foi encontrado o n� para o componente final do trecho de rede em Waterlines
                    rsVBL.MoveNext      'Move para o pr�ximo trecho de rede
                    VALID = True        'Informa que foi validado e encontrado o n� final para o trecho de rede
                'Caso o n� seja menor que o n� final do trecho de rede
                ElseIf rsVBP!COMPONENTE < rsVBL!fim Then
                    'Procura o pr�ximo n�, pois n�o encontrou o n� final da tabela Waterlines ainda
                    rsVBP.MoveNext      'Veja qual o pr�ximo n� de Watercomponents
                    VALID = False       'Informa que ainda n�o encontrou o n� final de Waterlines em Watercomponents
                Else
                    'O n� � maior do que o componente final do trecho de rede, isto quer dizer que ele n�o foi encontrado.
                    Open arquivoLog For Append As #1
                    Print #1, "ValidaComponentesFinaisDeWaterlines-30;Componente Final:"; Tab(21); rsVBL!fim; Tab(31); "da linha"; Tab(40); rsVBL!COD; Tab(50); "N�O ENCONTRADO."
                    Close #1
                    
                    CriaComponenteDefault (rsVBL!fim)
                    If blnPontoCriado = True Then
                        Open arquivoLog For Append As #1
                        Print #1, "ValidaComponentesFinaisDeWaterlines-31;Componente " & rsVBL!fim & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
                        Close #1
                    Else
                        Open arquivoLog For Append As #1
                        Print #1, "ValidaComponentesFinaisDeWaterlines-32;Componente " & rsVBL!fim & " N�O PODE SER CRIADO AUTOMATICAMENTE."
                        Close #1
                    End If
                    rsVBL.MoveNext
                End If
                If rsVBP.EOF = True Then
                    If VALID = False Then
                        Do While Not rsVBL.EOF = True
                            Open arquivoLog For Append As #1
                            Print #1, "ValidaComponentesFinaisDeWaterlines-33;Componente Final:"; Tab(21); rsVBL!fim; Tab(31); "da linha"; Tab(40); rsVBL!COD; Tab(50); "n�o encontrado!"
                            Close #1
                            
                            CriaComponenteDefault (rsVBL!fim)
                            If blnPontoCriado = True Then
                               Open arquivoLog For Append As #1
                               Print #1, "ValidaComponentesFinaisDeWaterlines-34;Componente " & rsVBL!fim & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
                               Close #1
                            Else
                               Open arquivoLog For Append As #1
                               Print #1, "ValidaComponentesFinaisDeWaterlines-35;Componente " & rsVBL!fim & " N�O PODE SER CRIADO AUTOMATICAMENTE."
                               Close #1
                            End If
                            rsVBL.MoveNext
                        Loop
                    End If
                    'Verifica se chegarmos ao final da leitura de todos os n�s e n�o exsitem mais n�s para lermos
                    Exit Do
                End If
            Loop
        End If
    End If
    Open arquivoLog For Append As #1
    Print #1, "Fim;ValidaComponentesFinaisDeWaterlines"
    Close #1
End Function
'Esta fun��o ir� criar uma nova geometria de n� que n�o existe
'
'ident - n�mero do n� inicial
'
Private Function CriaComponenteDefault(ident As Long) As Boolean
    On Error GoTo Trata_Erro
    Dim rsBusca As New ADODB.Recordset
    Dim rsLayer As New ADODB.Recordset
    Dim strSql As String
    Dim blnPontoCriado As Boolean                               'para indicar se existe uma geometria ou n�o
    
    'Verifica se existe
    strSql = "SELECT LAYER_ID,NAME FROM TE_LAYER WHERE NAME = '" & "WATERCOMPONENTS" & "'"
    Set rsLayer = Conn.Execute(strSql)
    If rsLayer.EOF = False Then
        Set rsBusca = Conn.Execute("SELECT * FROM POINTS" & rsLayer!layer_id & " WHERE OBJECT_ID = '" & ident & "'")
        If rsBusca.EOF = False Then 'A GEOMETRIA DO PONTO EXISTE
            'isto quer dizer que a geometria do ponto procurado existe
            'Verifique agora se o ponto procurado possui atributos em Watercomponents
            Set rsBusca = Conn.Execute("SELECT * FROM WATERCOMPONENTS WHERE OBJECT_ID_ = '" & ident & "'")
            If rsBusca.EOF = True Then
                'N�o existe como o esperado, ent�o tem que inserir os atributos
                Dim strCMD As String
                'strCMD = "SET IDENTITY_INSERT WATERCOMPONENTS ON;"
                strCMD = strCMD & "INSERT INTO WATERCOMPONENTS (COMPONENT_ID,OBJECT_ID_,SECTOR) VALUES (" & ident & "," & ident & ",999);"
                'strCMD = strCMD & "SET IDENTITY_INSERT WATERCOMPONENTS OFF"
                'MsgBox strCMD
                Conn.Execute (strCMD) 'insere o ponto na watercomponents
                Print #1, "Inserido atributo em Watercomponents com object_id_ = " & ident & " e component_id = " & ident
                'indica no flag que existe a geometria do ponto, pois foi verificado anteriormente que ela existia e somente os atributos n�o
                blnPontoCriado = True
            Else ' O PONTO JA FOI CRIADO NO PROCESSO ANTERIOR
                blnPontoCriado = True
            End If
               
        Else 'A GEOMETRIA DO PONTO N�O EXISTE
            'indica no flag que a geometria do ponto n�o existe
            blnPontoCriado = False
        End If
    Else
        '� grave, pois n�o existe a tabela de componentes de rede, deve ser verificado o banco de dados
        MsgBox "N�o encontrada na TE_LAYER referencia para a tabela WATERCOMPONENTS. Verifique a consist�ncia do banco de dados. Acione o suporte da NEXUS."
        End
    End If
    CriaComponenteDefault = blnPontoCriado
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        CriaComponenteDefault = blnPontoCriado
        Resume Next
    Else
        blnPontoCriado = False
        CriaComponenteDefault = blnPontoCriado
        Exit Function
    End If
End Function
'IDENTIFICA QUAL TABELA LINES O LAYER WATERLINES REGISTRA AS LOCALIZA��ES
'Esta fun��o retorna o n�mero do layer em que est�o as geometrias das linhas das redes de �gua. Ela retorna um n�mero
'que ser� utilizado para saber o nome da tabela LINESXX, onde XX � o n�mero em que se encontram as geometrias da
'tabela WATERLINES
'
' ObtemGeomWaterlines - retorna o n�mero da tabela de geometrias de linhas de redes de �gua
'
Private Function ObtemGeomWaterlines() As String
    Dim strSql As String
    Dim rsLayer As New ADODB.Recordset
    strSql = "SELECT LAYER_ID,NAME FROM TE_LAYER WHERE NAME = '" & "WATERLINES" & "'"
    Set rsLayer = Conn.Execute(strSql)
    If rsLayer.EOF = True Then
       MsgBox "N�o localizada a tabela de geometrias 'LINES##' da tabela WATERLINES", vbExclamation, " Contate o suporte pois o banco est� inconsistente."
       Exit Function
    Else
       ObtemGeomWaterlines = rsLayer!layer_id
    End If
End Function
'IDENTIFICA QUAL TABELA POINTS O LAYER WATERCOMPONENTS REGISTRA AS LOCALIZA��ES
'Esta fun��o retorna o n�mero do layer em que est�o as geometrias dos n�s das redes de �gua. Ela retorna um n�mero
'que ser� utilizado para saber o nome da tabela POINTSXX, onde XX � o n�mero em que se encontram as geometrias dos
'pontos da tabela WATERCOMPONENTS
'
' ObtemGeomWatercomponents - retorna o n�mero da tabela de geometrias de pondos (n�s) de redes de �gua
'
Private Function ObtemGeomWatercomponents() As String
    Dim strSql As String
    Dim rsLayer As New ADODB.Recordset
    strSql = "SELECT LAYER_ID,NAME FROM TE_LAYER WHERE NAME = '" & "WATERCOMPONENTS" & "'"
    Set rsLayer = Conn.Execute(strSql)
    If rsLayer.EOF = True Then
        MsgBox "N�o localizada a tabela de geometrias 'Points##' da tabela WATERCOMPONENTS", vbExclamation, " Contate o suporte pois o banco est� inconsistente."
        Exit Function
    Else
        ObtemGeomWatercomponents = rsLayer!layer_id
    End If
End Function
'Esta fun��o apaga todos os atributos de redes de �gua que n�o possuem uma geometria associada aos mesmos, ou seja,
'apaga os atributos (dados alfanum�ricos) soltos no banco, pois sem uma geometria associada, os mesmos n�o podem existir.
'
' ApagaLinhasAtributosSemGeometriasWaterlines - retorna o n�mero de linhas da tabela WATERLINES que foram eliminadas por n�o possuirem geometria de linha de rede associada
' numeroTabela - recebe o n�mero da tabela de geompetrias de linhas (trechos) de redes de �guas
' arquivoLog - nome do arquivo em que s�o gerados os logs da valida��o
'
Private Function ApagaLinhasAtributosSemGeometriasWaterlines(numeroTabela As String, arquivoLog As String) As Integer
    Dim contador As Integer
    Dim strSql As String
    Dim rsLinha As New ADODB.Recordset
    
    contador = 0                        'zera o n�mero de atributos apagados
    'EXCLUI AS LINHAS QUE N�O POSSUEM GEOMETRIA NA TABELA LINES1
    strSql = "SELECT OBJECT_ID_ FROM WATERLINES WHERE OBJECT_ID_ NOT IN (SELECT OBJECT_ID FROM LINES" & numeroTabela & ")"
    Open arquivoLog For Append As #1
    Print #1, vbCrLf & "ApagaLinhasAtributosSemGeometriasWaterlines;" & strSql
    Close #1
    Set rsLinha = Conn.Execute(strSql)
    If rsLinha.EOF = False Then
        Do While Not rsLinha.EOF
            'VERIFICADO QUE QUANDO A LINHA N�O POSSUI GEOMETRIA, ELA N�O APARECE NO MAPA
            'E POR ISSO O USU�RIO N�O PODE MANIPULA-LA
            Open arquivoLog For Append As #1
            Print #1, "ApagaLinhasAtributosSemGeometriasWaterlines;" & "     DELETE FROM WATERLINES WHERE OBJECT_ID_ ='" & rsLinha!Object_id_ & "'"
            Close #1
            Conn.Execute ("DELETE FROM WATERLINES WHERE OBJECT_ID_ ='" & rsLinha!Object_id_ & "'")
            rsLinha.MoveNext
            contador = contador + 1
        Loop
    End If
    Open arquivoLog For Append As #1
    Print #1, "ApagaLinhasAtributosSemGeometriasWaterlines;" & "Fim do SELECT. " & contador & " linhas de atributos em WATERLINES encontradas sem geometrias associadas"
    Close #1
    ApagaLinhasAtributosSemGeometriasWaterlines = contador
End Function
'Esta fun��o apaga todos as geometrias de redes de �gua que n�o possuem um atributo associado aos mesmos, ou seja,
'apaga as geometrias (coordenadas das linhas) soltas no banco, pois sem um atributo associado, as mesmoa n�o podem existir.
'
' ApagaGeometriasSemAtributosWaterlines - retorna o n�mero de linhas (trechos de redes/geometrias) da tabela LINESXX que foram eliminadas por n�o possuirem atributos de rede associada em WATERLINES
' numeroTabela - recebe o n�mero da tabela de geompetrias de linhas (trechos) de redes de �guas
' arquivoLog - nome do arquivo em que s�o gerados os logs da valida��o
'
Private Function ApagaGeometriasSemAtributosWaterlines(numeroTabela As String, arquivoLog As String) As Integer
    'EXCLUI AS GEOMETRIAS DE LINHAS QUE N�O TEM LINHAS NA TABELA WATERLINES
    Dim contador As Integer
    Dim strSql As String
    Dim rsLinha As New ADODB.Recordset
    
    contador = 0                            'zera o n�mero de geometrias apagadas
    strSql = "SELECT OBJECT_ID FROM LINES" & numeroTabela & " WHERE OBJECT_ID NOT IN (SELECT OBJECT_ID_ FROM WATERLINES)"
    Open arquivoLog For Append As #1
    Print #1, vbCrLf & "ApagaLinhasAtributosSemGeometriasWaterlines; " & strSql; ""
    Close #1
    Set rsLinha = Conn.Execute(strSql)
    If rsLinha.EOF = False Then
        Do While Not rsLinha.EOF
            Print #1, "ApagaGeometriasSemAtributosWaterlines;" & "     DELETE FROM LINES1 WHERE OBJECT_ID ='" & rsLinha!object_id & "'"
            Conn.Execute ("DELETE FROM LINES1 WHERE OBJECT_ID ='" & rsLinha!object_id & "'")
            rsLinha.MoveNext
            contador = contador + 1
        Loop
    End If
    Open arquivoLog For Append As #1
    Print #1, "ApagaGeometriasSemAtributosWaterlines;" & "Fim do SELECT. " & contador & " linhas de geometrias de WATERLINES encontradas sem atributos associados"
    Close #1
    ApagaGeometriasSemAtributosWaterlines = contador
End Function
'Obter uma lista de componentes de redes (n�s) que existem na tabela Watercomponents
'que n�o possuem informa��o geogr�fica na tabela PointsXX associada, ou seja, identifica n�s existentes como atributos mas
'sem a presen�a da respectiva geometria
'
'WcSemGeometrias - retorna um Recordset contento os OBJECT_ID_s que n�o possuem as geometrias com as coordenadas dos n�s
'numTabGeomPoints - recebe o n�mero da tabela contento as geometrias dos pontos/n�s das redes
'rsSemPoints - recordSet contendo o resultado da querie na tabela WATERCOMPONENTS com as linhas de atributos sem geometrias
'arquivoLog - nomo do arquivo em que s�o gerados os logs da valida��o
'
Private Function WcSemGeometrias(numTabGeomPoints As String, ByRef rsSemPoints As ADODB.Recordset, arquivoLog As String)
    Dim leGeoSanIni As New ValidaBase.CGeoSanIniFile  'Classe para ler dados de inicializa��o
    Dim TpConexao As String                         'Tipo de conex�o, se SQLServer, Oracle ou Postgres
    Dim strSql As String
    'Dim rsSemPoints As new ADODB.Recordset
    'Informa onde est�o as informa��es sobre a localiza��o, nome e tipo de banco de dados
    leGeoSanIni.arquivo = App.Path & "\Controles\GeoSan.ini"
    TpConexao = leGeoSanIni.TipoBDados
    Select Case TpConexao
        Case "1-SQL Server 2005"
            'gera um Recordset contendo todos os OBJECT_ID_s sem geometrias
            strSql = "SELECT OBJECT_ID_ FROM WATERCOMPONENTS WHERE OBJECT_ID_ NOT IN (SELECT OBJECT_ID FROM POINTS" & numTabGeomPoints & ")"
            Open arquivoLog For Append As #1
            Print #1, vbCrLf & "WcSemGeometrias; " & strSql
            Close #1
            Set rsSemPoints = Conn.Execute(strSql)
            Open arquivoLog For Append As #1
            Print #1, "WcSemGeometrias;Fim do SELECT."
            Close #1
        Case "Oracle"
            'N�o testado com Oracle ainda. Necessita testar novamente
            IMPRIME_COMPONENTE_SEM_GEOMETRIA 'CARREGA UM ARRAY QUE SER� USADO NO LUGAR DO RECORDSET
        Case "Postgres"
        
        Case Else
            MsgBox "Banco de dados incorreto, somente s�o aceitos SQLServer, Oracle e Postgres. Entre em contato com o suporte."
    End Select
End Function
'Esta rotina apaga os pontos (geometrias) dos n�s das redes que n�o possuem atributos associados aos mesmos
'
'Jos� Maria Villac Pinheiro - 11/12/2012
'
'numTabGeomPoints - recebe o n�mero da tabela contento as geometrias dos pontos/n�s das redes
'arquivoLog - nomo do arquivo em que s�o gerados os logs da valida��o
'
Private Function ApagaPointsSemWatercomponents(numTabGeomPoints As String, arquivoLog As String)
    Dim leGeoSanIni As New ValidaBase.CGeoSanIniFile    'Classe para ler dados de inicializa��o
    Dim TpConexao As String                             'Tipo de conex�o, se SQLServer, Oracle ou Postgres
    Dim strSql As String
    Dim rs As New ADODB.Recordset
    
    On Error GoTo Trata_Erro:
    
    StatusBar1.Panels.Item(1).Text = "3-Apaga n�s sem atributos"
    'Informa onde est�o as informa��es sobre a localiza��o, nome e tipo de banco de dados
    leGeoSanIni.arquivo = App.Path & "\Controles\GeoSan.ini"
    TpConexao = leGeoSanIni.TipoBDados
    Select Case TpConexao
        Case "1-SQL Server 2005"
            'gera um Recordset contendo todos os OBJECT_ID_s da tabela de geometrias (POINTS2) que n�o possuem atrubutos em WATERCOMPONENTS
            strSql = "SELECT OBJECT_ID FROM POINTS" & numTabGeomPoints & " WHERE OBJECT_ID NOT IN (SELECT OBJECT_ID_ FROM WATERCOMPONENTS)"
            Open arquivoLog For Append As #1
            Print #1, vbCrLf & "PointsSemWatercomponents; " & strSql
            Close #1
            Set rs = Conn.Execute(strSql)
            Open arquivoLog For Append As #1
            Print #1, "ApagaPointsSemWatercomponents;Fim do SELECT."
            Close #1
        Case "Oracle"
            'N�o testado com Oracle ainda. Necessita testar novamente
            IMPRIME_COMPONENTE_SEM_GEOMETRIA 'CARREGA UM ARRAY QUE SER� USADO NO LUGAR DO RECORDSET
        Case "Postgres"
            'Implementar
        Case Else
            MsgBox "Banco de dados incorreto, somente s�o aceitos SQLServer, Oracle e Postgres. Entre em contato com o suporte."
    End Select
    'para cada object_id da tabela POINTS2 que n�o possui atributo, apaga-o, pois � um ponto no espa�o sem associa��o com nada
    Do While Not rs.EOF
        Dim objID As String
        objID = rs.Fields("OBJECT_ID").Value
        StatusBar1.Panels.Item(2).Text = "ObjID geom: " & objID
        StatusBar1.Panels.Item(3).Text = " "
        strSql = "DELETE FROM Points" & numTabGeomPoints & " WHERE object_id = '" & objID & "'"
        Conn.Execute (strSql)
        Open arquivoLog For Append As #1
        Print #1, "ApagaPointsSemWatercomponents;Apagado o ponto com object_id: " & objID & " da tabela Points" & numTabGeomPoints & " que n�o tinha um atributo associado."
        Close #1
        rs.MoveNext
    Loop
    rs.Close
    Open arquivoLog For Append As #1
    Print #1, "ApagaPointsSemWatercomponents;Fim do processamento."
    Close #1
Trata_Erro:

If Err.Number = 0 Or Err.Number = 20 Then
    Resume Next
Else
   'Resume
   Me.MousePointer = vbDefault
   Open arquivoLog For Append As #1
   Print #1, Now & " - Function ApagaPointsSemWatercomponents - " & Err.Number & " - " & Err.Description
   Close #1
   PrintErro CStr(Me.Name), "Function ApagaPointsSemWatercomponents, tipo de erro: ", CStr(Err.Number), CStr(Err.Description), True
   MsgBox "Um posss�vel erro foi identificado:" & Chr(13) & Chr(13) & Err.Description & Chr(13) & Chr(13) & "Foi gerado na pasta do aplicativo o arquivo: " & App.Path & "\Controles\GeoSanLog.txt" & " com informa��es desta ocorr�ncia.", vbInformation
End If

End Function
'Esta rotina verifica se para cada atributo de n� existe um object_id da geometria deste n�.
'Depois faz o contr�rio, verifica se para cada object_id de uma geometria de n�, existe o respectivo atributo
'
'Jos� Maria Villac Pinheiro - 11/12/2012
'
'numTabGeomPoints - recebe o n�mero da tabela contento as geometrias dos pontos/n�s das redes
'arquivoLog - nomo do arquivo em que s�o gerados os logs da valida��o
'
Private Function VefificaUnicidadeNos(numTabGeomPoints As String, arquivoLog As String)
    Dim leGeoSanIni As New ValidaBase.CGeoSanIniFile    'Classe para ler dados de inicializa��o
    Dim TpConexao As String                             'Tipo de conex�o, se SQLServer, Oracle ou Postgres
    Dim strSql As String
    Dim strSql2 As String
    Dim rs As New ADODB.Recordset
    Dim rs2 As New ADODB.Recordset
    Dim numeroNos As Integer
    Dim objID As String
    
    On Error GoTo Trata_Erro:
    
    'Informa onde est�o as informa��es sobre a localiza��o, nome e tipo de banco de dados
    leGeoSanIni.arquivo = App.Path & "\Controles\GeoSan.ini"
    TpConexao = leGeoSanIni.TipoBDados
    StatusBar1.Panels.Item(1).Text = "2-Verifica��o da unicidade dos n�s"
    Select Case TpConexao
        Case "1-SQL Server 2005"
            'gera um Recordset contendo todos os OBJECT_ID_s da tabela de geometria POINTS2, sem restri��es
            strSql = "SELECT OBJECT_ID FROM POINTS" & numTabGeomPoints
            Open arquivoLog For Append As #1
            Print #1, vbCrLf & "VefificaUnicidadeNos; " & strSql
            Close #1
            Set rs = Conn.Execute(strSql)
            Open arquivoLog For Append As #1
            Print #1, "VefificaUnicidadeNos;Fim do SELECT."
            Close #1
        Case "Oracle"
            'N�o testado com Oracle ainda. Necessita testar novamente
            IMPRIME_COMPONENTE_SEM_GEOMETRIA 'CARREGA UM ARRAY QUE SER� USADO NO LUGAR DO RECORDSET
        Case "Postgres"
        
        Case Else
            MsgBox "VefificaUnicidadeNos;Banco de dados incorreto, somente s�o aceitos SQLServer, Oracle e Postgres. Entre em contato com o suporte."
    End Select
    'para cada geometria (object_id) do ponto
    Do While Not rs.EOF
        objID = rs.Fields("OBJECT_ID").Value
        'procura na tabela de atrubutos WATERCOMPONENTS quantos atributos deste n� est�o l� cadastrados
        strSql2 = "select count(object_id_) from watercomponents where object_id_ = '" & objID & "'"
        Set rs2 = Conn.Execute(strSql2)
        numeroNos = rs2.Fields(0)
        StatusBar1.Panels.Item(2).Text = "ObjID n�: " & objID
        StatusBar1.Panels.Item(3).Text = "Total n�s: " & numeroNos
        If numeroNos = 0 Then
            'indica no arquio de log a n�o conformidade de que os atributos do n� n�o foram encontrados
            Open arquivoLog For Append As #1
            Print #1, "VefificaUnicidadeNos;O n� numero: " & objID & " existe na tabela Points" & numTabGeomPoints & " mas n�o existe na tabela watercomponents."
            Close #1
        ElseIf numeroNos > 1 Then
            'indica no arquivo de log que existe mais de um atributo associado a geometria, deveria existir apenas um
            Open arquivoLog For Append As #1
            Print #1, "VefificaUnicidadeNos;O n� numero: " & objID & " existe na tabela Points" & numTabGeomPoints & " e existe na tabela watercomponents: " & numeroNos & " vezes, deveria existir uma �nica vez."
            Close #1
        Else
            'est� tudo certo, existe um atributo na tabela de atributos que est� associado a geometria e ent�o n�o precisa fazer nada
        End If
        rs.MoveNext                         'vamos a pr�xima geometria de ponto
    Loop
    Open arquivoLog For Append As #1
    Print #1, "VefificaUnicidadeNos;Fim do processamento."
    Close #1
    'Agora verifica ao contr�rio
    'Informa onde est�o as informa��es sobre a localiza��o, nome e tipo de banco de dados
    Select Case TpConexao
        Case "1-SQL Server 2005"
            'gera um Recordset contendo todos os OBJECT_ID_s sem geometrias
            strSql = "SELECT OBJECT_ID_ FROM WATERCOMPONENTS"
            Open arquivoLog For Append As #1
            Print #1, vbCrLf & "VefificaUnicidadeNos; " & strSql
            Close #1
            Set rs = Conn.Execute(strSql)
            Open arquivoLog For Append As #1
            Print #1, "VefificaUnicidadeNos;Fim do SELECT."
            Close #1
        Case "Oracle"
            'N�o testado com Oracle ainda. Necessita testar novamente
            IMPRIME_COMPONENTE_SEM_GEOMETRIA 'CARREGA UM ARRAY QUE SER� USADO NO LUGAR DO RECORDSET
        Case "Postgres"
        
        Case Else
            MsgBox "VefificaUnicidadeNos;Banco de dados incorreto, somente s�o aceitos SQLServer, Oracle e Postgres. Entre em contato com o suporte."
    End Select
    Do While Not rs.EOF
        objID = rs.Fields("OBJECT_ID_").Value
        strSql2 = "select count(object_id) from points" & numTabGeomPoints & " where object_id = '" & objID & "'"
        Set rs2 = Conn.Execute(strSql2)
        numeroNos = rs2.Fields(0)
        StatusBar1.Panels.Item(2).Text = "ObjID n�: " & objID
        StatusBar1.Panels.Item(3).Text = "Total n�s: " & numeroNos
        If numeroNos = 0 Then
            Open arquivoLog For Append As #1
            Print #1, "VefificaUnicidadeNos;O n� numero: " & objID & " existe na tabela WATERCOMPONENTS mas n�o existe na tabela POINTS" & numTabGeomPoints
            Close #1
        ElseIf numeroNos > 1 Then
            Open arquivoLog For Append As #1
            Print #1, "VefificaUnicidadeNos;O n� numero: " & objID & " existe na tabela WATERCOMPONENTS e existe na tabela POINTS" & numTabGeomPoints & ": " & numeroNos & " vezes, deveria existir uma �nica vez."
            Close #1
        Else
        End If
        rs.MoveNext
    Loop
    rs.Close
    rs2.Close
    Open arquivoLog For Append As #1
    Print #1, "VefificaUnicidadeNos;Fim do processamento."
    Close #1

Trata_Erro:

If Err.Number = 0 Or Err.Number = 20 Then
    Resume Next
Else
   'Resume
   Me.MousePointer = vbDefault
   Open arquivoLog For Append As #1
   Print #1, Now & " - Function VefificaUnicidadeNos - " & Err.Number & " - " & Err.Description
   Close #1
   PrintErro CStr(Me.Name), "Function VefificaUnicidadeNos, tipo de erro: ", CStr(Err.Number), CStr(Err.Description), True
   MsgBox "Um posss�vel erro foi identificado:" & Chr(13) & Chr(13) & Err.Description & Chr(13) & Chr(13) & "Foi gerado na pasta do aplicativo o arquivo: " & App.Path & "\Controles\GeoSanLog.txt" & " com informa��es desta ocorr�ncia.", vbInformation
End If
   
End Function
Private Sub ProcuraSeEhNoInicial(id_componente As String, rsNoInicial As ADODB.Recordset)
    'Procura se este n� de Watercomponents � um n� inicial de alguma rede de �gua em Waterlines
    Set rsNoInicial = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,INITIALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT ='" & id_componente & "'")
    If rsNoInicial.EOF = False Then
        'ProcuraSeEhNoInicial = True
    Else
        'ProcuraSeEhNoInicial = False
    End If
End Sub
Private Sub ProcuraSeEhNoFinal(id_componente As String, rsNoInicial As ADODB.Recordset)
    'Procura se este n� de Watercomponents � um n� inicial de alguma rede de �gua em Waterlines
    Set rsNoInicial = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,FINALCOMPONENT FROM WATERLINES WHERE FINALCOMPONENT ='" & id_componente & "'")
    If rsNoInicial.EOF = False Then
        'ProcuraSeEhNoInicial = True
    Else
        'ProcuraSeEhNoInicial = False
    End If
End Sub

'Procura n�s em Watercomponents sem geometrias em PointsXX
Private Function CorrigeGeometriaNosNaoExistentesEmWatercomponents(rsSemPoints As Object) As String
    Dim id_componente As String                                     'object_id da geometria
    Dim rsInitial As New ADODB.Recordset                            'cursor para WATERLINES onde INITIALCOMPONENT � o n� inicial
    Dim rsInitial2 As New ADODB.Recordset                           'demais trechos de rede com o n� inicial, com exce��o do trecho inicial j� visto
    Dim rsFinal As New ADODB.Recordset                              'lista com linhas (trechos de rede) com n�s finais dos trechos de redes de �gua que pertencem a outros trechos de redes
    Dim LINHA1 As String                                            'object_id da linha que � componente inicial
    Dim LINHA2 As String                                            'object_id da linha que � componente final
    Dim XL1 As Double, XL2 As Double, YL1 As Double, YL2 As Double  'X e Y iniciais e finais da linha
    Dim retorno As Integer
    Dim QTDPT As Integer                                            'n�mero de pontos (v�rtices) que comp�em a linha para pegar as coordenadas do ultimo ponto
    Dim CONTALINHAS As Integer                                      'Indica quantos trechos de rede est�o associados a este n� sem geometria
    Dim strCMD As String                                            'comando SQL
    
    'Verifica se o objeto passado � realmente um Recordset
    If Not TypeOf rsSemPoints Is ADODB.Recordset Then
        CorrigeGeometriaNosNaoExistentesEmWatercomponents = "Falha em receber um Recordset v�lido em CorrigeGeometriaNosNaoExistentesEmWatercomponents"
        Exit Function
    End If
    'Enquanto existirem n�s em Watercomponents sem geometrias, varre cada object_id_ de Watercompontes sem geometria
    Do While Not rsSemPoints.EOF = True
        id_componente = rsSemPoints!Object_id_      'obtem o object_id_ que n�o tem geometria associada
        Dim teste As Boolean                        'indica se � n� inicial ou n�o de algum trecho de rede
        'verifica se o n� em quest�o � um n� inicial de algum trecho de redes em WATERLINES
        Call ProcuraSeEhNoInicial(id_componente, rsInitial)
        If Not rsInitial.EOF = True Then
            'chegando a este ponto significa que o componente � inicial de 1 ou mais linhas
            LINHA1 = rsInitial!Object_id_ 'carrega em LINHA1 o id da linha que o componente � inicial
            retorno = TeDatabase1.getPointOfLine(0, LINHA1, 0, XL1, YL1) 'retorna em XL1 e YL1 as coordenadas iniciais da linha
            'Procura se este n� de Watercomponents � um n� final de alguma rede de �gua em Waterlines
            Set rsFinal = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,FINALCOMPONENT FROM WATERLINES WHERE FINALCOMPONENT ='" & id_componente & "'AND OBJECT_ID_ <> '" & LINHA1 & "'")
            If rsFinal.EOF = False Then
                LINHA2 = rsFinal!Object_id_
                'chegando a este ponto significa que o componente � inicial e final de duas OU mais linhas
                'ANALISAR AS 2 LINHAS
                'FAZER A PESQUISA PARA SABER O X,Y DAS LINHAS
                QTDPT = TeDatabase1.getQuantityPointsLine(0, LINHA2) 'retorna n�mero de pontos que comp�em a linha para pegar as coordenadas do ultimo ponto
                If QTDPT >= 2 Then
                    retorno = TeDatabase1.getPointOfLine(0, LINHA2, QTDPT - 1, XL2, YL2) 'retorna em XL2 e YL2 as coordenadas finais da linha
                End If
                If XL1 = XL2 And YL1 = YL2 Then
                   strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                   Conn.Execute (strSql)
                   Print #5, "Componente " & id_componente & " localizado com sucesso!"
                Else
                   'MsgBox "Valor inconsistente para o componente de rede n� " & id_componente & " contido nas linhas " & LINHA1 & " e " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                   Print #5, "Valor inconsistente para o componente de rede n� " & id_componente & " contido nas linhas " & LINHA1 & " e " & LINHA2 & ". N�o foi possivel corrigir automaticamente."
                End If
            Else
                'chegando a este ponto significa que o componente � somente inicial de duas ou mais linhas
                'ANALIZAR A LINHA QUE ELE � INICIAL
                CONTALINHAS = 1
                rsInitial.MoveNext
                Do While Not rsInitial.EOF = True
                    CONTALINHAS = CONTALINHAS + 1
                Loop
                If CONTALINHAS = 1 Then 'O PONTO EST� CONECTADO A SOMENTE 1 LINHA
                    'retorno = TeDatabase1.getPointOfLine(0, rsInitial!Object_id_, 0, XL1, YL1)
                    strXL1 = Replace(XL1, ",", ".") 'converte o valor double do XL1
                    strYL1 = Replace(YL1, ",", ".") 'converte o valor double do YL1
                    strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & strXL1 & "," & strYL1 & ")"
                    Conn.Execute (strSql)
                    Print #5, "Componente " & id_componente & " localizado com sucesso!"
                Else 'O PONTO EST� CONECTADO A MAIS DE 1 LINHA
                    Set rsInitial2 = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,INITIALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT ='" & id_componente & "' AND OBJECT_ID_ <> '" & LINHA1 & "'")
                    If rsInitial2.EOF = False Then
                        LINHA2 = rsInitial2!Object_id_
                        retorno = TeDatabase1.getPointOfLine(0, rsInitial2!Object_id_, 0, XL2, YL2)
                        If XL1 = XL2 And YL1 = YL2 Then
                            strXL1 = Replace(XL1, ",", ".") 'converte o valor double do XL1
                            strYL1 = Replace(YL1, ",", ".") 'converte o valor double do YL1
                            strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                            Conn.Execute (strSql)
                            Print #5, "Componente " & id_componente & " localizado com sucesso!"
                        Else
                            'MsgBox "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                            Print #5, "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & ". N�o foi possivel corrigir automaticamente."
                        End If
                    Else
                        'MsgBox "Valores inconsistentes para a linha " & LINHA1 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                        Print #5, "Valores inconsistentes para a linha " & LINHA1 & ". N�o foi possivel corrigir automaticamente."
                    End If
                End If
            End If
        Else
            'chegando a este ponto significa que o componente n�o � inicial de nenhuma linha
            'verificando se ele � final de alguma linha
            Set rsFinal = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,FINALCOMPONENT FROM WATERLINES WHERE FINALCOMPONENT ='" & id_componente & "'")
            If rsFinal.EOF = False Then
                'chegando a este ponto significa que o componente � somente final de duas ou mais linhas
                LINHA1 = rsFinal!Object_id_
                retorno = TeDatabase1.getPointOfLine(0, LINHA1, 0, XL1, YL1)
                CONTALINHAS = 1
                rsFinal.MoveNext
                Do While Not rsFinal.EOF = True
                   CONTALINHAS = CONTALINHAS + 1
                Loop
                If CONTALINHAS = 1 Then 'O PONTO EST� CONECTADO A SOMENTE 1 LINHA
                    strXL1 = Replace(XL1, ",", ".") 'converte o valor double do XL1
                    strYL1 = Replace(YL1, ",", ".") 'converte o valor double do YL1
                    strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                    Conn.Execute (strSql)
                    Print #5, "Componente " & id_componente & " localizado com sucesso!"
                Else 'O PONTO EST� CONECTADO A MAIS DE 1 LINHA
                    Set rsFinal2 = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,INITIALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT ='" & id_componente & "' AND OBJECT_ID_ <> '" & LINHA1 & "'")
                    If rsFinal2.EOF = False Then
                         LINHA2 = rsFinal2!Object_id_
                         retorno = TeDatabase1.getPointOfLine(0, rsFinal2!Object_id_, 0, XL2, YL2)
                         If XL1 = XL2 And YL1 = YL2 Then
                            strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                            Conn.Execute (strSql)
                            Print #5, "Componente " & id_componente & " localizado com sucesso!"
                         Else
                            'MsgBox "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                            Print #5, "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente."
                         End If
                     Else
                        'MsgBox "Valores inconsistentes para a linha " & LINHA1 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                        Print #5, "Valores inconsistentes para a linha " & LINHA1 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente."
                     End If
                End If
            Else
               'chegando a este ponto significa que o componente n�o � inicial nem final de linhas
               strCMD = "DELETE FROM WATERCOMPONENTS WHERE OBJECT_ID_ ='" & id_componente & "'"
               Conn.Execute (strCMD)
               Print #5, "Componente de rede " & id_componente & " sem conex�es. >> Exclu�do."
            End If
        End If
        rsSemPoints.MoveNext
    Loop
    CorrigeGeometriaNosNaoExistentesEmWatercomponents = "Sucesso"
End Function
' numTabGeomPoints - N�mero da tabela de geometrias (PointsXX) associada a tabela Watercomponents
' esta rotina n�o est� sendo chamada por nenhuma parte do software se vier a ser utilizada � necess�rio configurar o recemento do arquivoLog
Private Function localizaFaltaPointsEmWatercomponents(numTabGeomPoints) As String

    Dim rsSemPoints As New ADODB.Recordset          'Lista de object_id_s que n�o possuem geometrias
    Dim id_componente As Integer                    'Object_id_ de Watercomponents sem geometria em PointsXX
    Dim rsInitial As New ADODB.Recordset            '
    Dim rsFinal As New ADODB.Recordset              '
    Dim LINHA1 As String
    Dim LINHA2 As String
    Dim XL1 As Double, XL2 As Double, YL1 As Double, YL2 As Double
    Dim pontos As String
    Dim arquivoLog As String
    
    arquivoLog = ""                                 '� necess�rio receber este par�metro para passar para a pr�xima fun��o chamada
    
    pontos = numTabGeomPoints
    'Procura n�s em Watercomponents sem geometrias em PointsXX
    Set rsSemPoints = WcSemGeometrias(pontos, rsSemPoints, arquivoLog)
    If rsSemPoints.EOF = False Then
        'Se existem n�s sem geometrias
        Dim teste As String
        teste = CorrigeGeometriaNosNaoExistentesEmWatercomponents(rsSemPoints)
    Else
        'Se n�o existem n�s sem geometrias, ou seja todos os n�s em Watercomponents possuem uma geometria associada
        
    End If
End Function
'Esta rotina est� apenas como refer�ncia para as demais processadas e poder� vir a ser apagada
Private Sub cmdInciar_Click()
    Dim TpConexao As String                                         'Tipo de conex�o, se SQLServer, Oracle ou Postgres
    Dim id_componente As Integer                                    'Object_id_ de Watercomponents sem geometria em PointsXX
    Dim rsInitial As New ADODB.Recordset                            'cursor para WATERLINES onde INITIALCOMPONENT � o n� inicial
    Dim LINHA1 As String                                            'object_id da linha que � componente inicial
    Dim LINHA2 As String                                            'object_id da linha que � componente final
    Dim XL1 As Double, XL2 As Double, YL1 As Double, YL2 As Double  'X e Y iniciais e finais da linha
    Dim retorno As Integer
    Dim rsFinal As New ADODB.Recordset                              'lista com linhas (trechos de rede) com n�s finais dos trechos de redes de �gua que pertencem a outros trechos de redes
    Dim QTDPT As Integer                                            'n�mero de pontos (v�rtices) que comp�em a linha para pegar as coordenadas do ultimo ponto
    Dim CONTALINHAS As Integer                                      'Indica quantos trechos de rede est�o associados a este n� sem geometria
    Dim rsInitial2 As New ADODB.Recordset                           'demais trechos de rede com o n� inicial, com exce��o do trecho inicial j� visto
    Dim strCMD As String                                            'comando SQL
    Dim rsVBL As New ADODB.Recordset
    Dim rsVBP As New ADODB.Recordset
    Dim blnPontoCriado As Boolean                                   'para indicar se existe uma geometria ou n�o
    
On Error GoTo Trata_Erro
   Me.MousePointer = vbHourglass
   
   Open App.Path & "\Controles\ValidaBase2.log" For Append As #5    ' ABRE O ARQUIVO TEXTO PARA LOG
   
'*** FEITO *** IDENTIFICA QUAL TABELA LINES O LAYER WATERLINES REGISTRA AS LOCALIZA��ES
   strSql = "SELECT LAYER_ID,NAME FROM TE_LAYER WHERE NAME = '" & "WATERLINES" & "'"
   Set rsLayer = Conn.Execute(strSql)
   If rsLayer.EOF = True Then
      MsgBox "N�o localizada a tabela de geometrias 'LINES##' da tabela WATERLINES", vbExclamation, ""
      Exit Sub
   Else
   
'*** FEITO *** EXCLUI AS LINHAS QUE N�O POSSUEM GEOMETRIA NA TABELA LINES1
      strSql = "SELECT OBJECT_ID_ FROM WATERLINES WHERE OBJECT_ID_ NOT IN (SELECT OBJECT_ID FROM LINES" & rsLayer!layer_id & ")"
      Set rsLinha = Conn.Execute(strSql)
      If rsLinha.EOF = False Then
         Do While Not rsLinha.EOF
            'VERIFICADO QUE QUANDO A LINHA N�O POSSUI GEOMETRIA, ELA N�O APARECE NO MAPA
            'E POR ISSO O USU�RIO N�O PODE MANIPULA-LA
            'Conn.Execute ("DELETE FROM WATERLINES WHERE OBJECT_ID_ ='" & rsLinha!Object_id_ & "'")
            Print #5, "Linha " & rsLinha!Object_id_ & " SEM GEOMETRIA, EXCLU�DA."
            rsLinha.MoveNext
         Loop
      End If
      
      
'*** FEITO *** EXCLUI AS GEOMETRIAS DE LINHAS QUE N�O TEM LINHAS NA TABELA WATERLINES
      strSql = "SELECT OBJECT_ID FROM LINES" & rsLayer!layer_id & " WHERE OBJECT_ID NOT IN (SELECT OBJECT_ID_ FROM WATERLINES)"
      Set rsLinha = Conn.Execute(strSql)
      If rsLinha.EOF = False Then
         Do While Not rsLinha.EOF
            'Conn.Execute ("DELETE FROM LINES1 WHERE OBJECT_ID ='" & rsLinha!object_id & "'")
            Print #5, "DESENHO DE Linha COD " & rsLinha!object_id & " SEM INFORMA��O DE CADASTRO, EXCLU�DA."
            rsLinha.MoveNext
         Loop
      End If
   
   End If
   
'*** FEITO *** IDENTIFICA QUAL TABELA POINTS O LAYER WATERCOMPONENTS REGISTRA AS LOCALIZA��ES
   strSql = "SELECT LAYER_ID,NAME FROM TE_LAYER WHERE NAME = '" & "WATERCOMPONENTS" & "'"
   Set rsLayer = Conn.Execute(strSql)
   If rsLayer.EOF = True Then
      MsgBox "N�o localizada a tabela de geometrias 'Points##' da tabela WATERCOMPONENTS", vbExclamation, ""
      Exit Sub
   End If
   
     
'*** FEITO *** COM O SELECT ABAIXO OBTEM-SE UMA LISTA DOS COMPONENTES DE REDE QUE EXISTEM NA TABELA WATERCOMPONENTES MAS N�O TEM INFORMA��O GEOGRAFICA
   If TpConexao = 1 Then 'CASO SQL SERVER
      strSql = "SELECT OBJECT_ID_ FROM WATERCOMPONENTS WHERE OBJECT_ID_ NOT IN (SELECT OBJECT_ID FROM POINTS" & rsLayer!layer_id & ")"
      Set rsSemPoints = Conn.Execute(strSql)
   Else 'CASO ORACLE
      IMPRIME_COMPONENTE_SEM_GEOMETRIA 'CARREGA UM ARRAY QUE SER� USADO NO LUGAR DO RECORDSET
   End If
 
      Do While Not rsSemPoints.EOF = True
         id_componente = rsSemPoints!Object_id_
         
         'VERIFICANDO A QUAL LINHA ESTE COMPONENTE � COMPONENTE INICIAL
         Set rsInitial = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,INITIALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT ='" & id_componente & "'")
         
         If rsInitial.EOF = False Then
            'chegando a este ponto significa que o componente � inicial de 1 ou mais linhas
            LINHA1 = rsInitial!Object_id_ 'carrega em LINHA1 o id da linha que o componente � inicial
            
            retorno = TeDatabase1.getPointOfLine(0, LINHA1, 0, XL1, YL1) 'retorna em XL1 e YL1 as coordenadas iniciais da linha

            'VERIFICANDO SE O COMPONENTE � TAMBEM FINAL DE ALGUMA OUTRA LINHA
            Set rsFinal = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,FINALCOMPONENT FROM WATERLINES WHERE FINALCOMPONENT ='" & id_componente & "'AND OBJECT_ID_ <> '" & LINHA1 & "'")
            If rsFinal.EOF = False Then
               LINHA2 = rsFinal!Object_id_
               'chegando a este ponto significa que o componente � inicial e final de duas OU mais linhas
               'ANALISAR AS 2 LINHAS
               
               'FAZER A PESQUISA PARA SABER O X,Y DAS LINHAS
               
               QTDPT = TeDatabase1.getQuantityPointsLine(0, LINHA2) 'retorna n�mero de pontos que comp�em a linhA para pegar as coordenadas do ultimo ponto
               If QTDPT >= 2 Then
                  retorno = TeDatabase1.getPointOfLine(0, LINHA2, QTDPT - 1, XL2, YL2) 'retorna em XL2 e YL2 as coordenadas finais da linha
               End If
              

               If XL1 = XL2 And YL1 = YL2 Then
                  strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                  Conn.Execute (strSql)
                  Print #5, "Componente " & id_componente & " localizado com sucesso!"
                  
               Else
                  'MsgBox "Valor inconsistente para o componente de rede n� " & id_componente & " contido nas linhas " & LINHA1 & " e " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                  Print #5, "Valor inconsistente para o componente de rede n� " & id_componente & " contido nas linhas " & LINHA1 & " e " & LINHA2 & ". N�o foi possivel corrigir automaticamente."
               End If
            
            Else
               'chegando a este ponto significa que o componente � somente inicial de duas ou mais linhas
               'ANALIZAR A LINHA QUE ELE � INICIAL

               CONTALINHAS = 1
               rsInitial.MoveNext
               Do While Not rsInitial.EOF = True
                  CONTALINHAS = CONTALINHAS + 1
               Loop
               If CONTALINHAS = 1 Then 'O PONTO EST� CONECTADO A SOMENTE 1 LINHA
               
                  'retorno = TeDatabase1.getPointOfLine(0, rsInitial!Object_id_, 0, XL1, YL1)
                  
                  strXL1 = Replace(XL1, ",", ".") 'converte o valor double do XL1
                  strYL1 = Replace(YL1, ",", ".") 'converte o valor double do YL1
                  
                  strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & strXL1 & "," & strYL1 & ")"
                  
                  Conn.Execute (strSql)
                  Print #5, "Componente " & id_componente & " localizado com sucesso!"
                  
               
               Else 'O PONTO EST� CONECTADO A MAIS DE 1 LINHA
                  Set rsInitial2 = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,INITIALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT ='" & id_componente & "' AND OBJECT_ID_ <> '" & LINHA1 & "'")
                  If rsInitial2.EOF = False Then
                     LINHA2 = rsInitial2!Object_id_
                     retorno = TeDatabase1.getPointOfLine(0, rsInitial2!Object_id_, 0, XL2, YL2)
                     
                     If XL1 = XL2 And YL1 = YL2 Then
                        strXL1 = Replace(XL1, ",", ".") 'converte o valor double do XL1
                        strYL1 = Replace(YL1, ",", ".") 'converte o valor double do YL1
                        strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                        Conn.Execute (strSql)
                        Print #5, "Componente " & id_componente & " localizado com sucesso!"
                     Else
                        
                        'MsgBox "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                        Print #5, "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & ". N�o foi possivel corrigir automaticamente."
                     End If
                  Else
                  
                     'MsgBox "Valores inconsistentes para a linha " & LINHA1 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                     Print #5, "Valores inconsistentes para a linha " & LINHA1 & ". N�o foi possivel corrigir automaticamente."
                  End If
                  
               End If
               
            End If
            
         Else
            'chegando a este ponto significa que o componente n�o � inicial de nenhuma linha
            'verificando se ele � final de alguma linha
            Set rsFinal = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,FINALCOMPONENT FROM WATERLINES WHERE FINALCOMPONENT ='" & id_componente & "'")
            If rsFinal.EOF = False Then
               'chegando a este ponto significa que o componente � somente final de duas ou mais linhas
            
               LINHA1 = rsFinal!Object_id_
               retorno = TeDatabase1.getPointOfLine(0, LINHA1, 0, XL1, YL1)
            
               CONTALINHAS = 1
               rsFinal.MoveNext
               Do While Not rsFinal.EOF = True
                  CONTALINHAS = CONTALINHAS + 1
               Loop
               If CONTALINHAS = 1 Then 'O PONTO EST� CONECTADO A SOMENTE 1 LINHA
               
                  
                  strXL1 = Replace(XL1, ",", ".") 'converte o valor double do XL1
                  strYL1 = Replace(YL1, ",", ".") 'converte o valor double do YL1
                  strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                  Conn.Execute (strSql)
                  Print #5, "Componente " & id_componente & " localizado com sucesso!"
               
               Else 'O PONTO EST� CONECTADO A MAIS DE 1 LINHA
                  Set rsFinal2 = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,INITIALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT ='" & id_componente & "' AND OBJECT_ID_ <> '" & LINHA1 & "'")
                  If rsFinal2.EOF = False Then
                     
                     LINHA2 = rsFinal2!Object_id_
                     retorno = TeDatabase1.getPointOfLine(0, rsFinal2!Object_id_, 0, XL2, YL2)
                     
                     If XL1 = XL2 And YL1 = YL2 Then
                        strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                        Conn.Execute (strSql)
                        Print #5, "Componente " & id_componente & " localizado com sucesso!"
                     Else
                        
                        'MsgBox "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                        Print #5, "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente."
                     End If
                  Else
                  
                     'MsgBox "Valores inconsistentes para a linha " & LINHA1 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                     Print #5, "Valores inconsistentes para a linha " & LINHA1 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente."
                     
                  End If
                  
               End If
            
            
            Else
               'chegando a este ponto significa que o componente n�o � inicial nem final de linhas
               
               strCMD = "DELETE FROM WATERCOMPONENTS WHERE OBJECT_ID_ ='" & id_componente & "'"
               Conn.Execute (strCMD)
            
               Print #5, "Componente de rede " & id_componente & " sem conex�es. >> Exclu�do."
            
            End If
               
         End If
         rsSemPoints.MoveNext
      Loop
   'End If
   
   Print #5, ""
   Print #5, " * * * * FIM DE VERIFICA��O DE GEOMETRIAS * * * *"
   Print #5, ""
'*** FEITO ***
   Set rsVBL = Conn.Execute("SELECT OBJECT_ID_ AS COD,INITIALCOMPONENT AS INI FROM WATERLINES ORDER BY INITIALCOMPONENT")
   If rsVBL.EOF = False Then
       Set rsVBP = Conn.Execute("SELECT COMPONENT_ID AS COMPONENTE FROM WATERCOMPONENTS ORDER BY COMPONENT_ID")
       'VALIDANDO TODOS OS COMPONENTES INITIAL DA WATERLINES
       If rsVBP.EOF = False Then
           Do While Not rsVBP.EOF = True And Not rsVBL.EOF = True
               If rsVBP!COMPONENTE = rsVBL!ini Then 'validado
                   rsVBL.MoveNext
                   VALID = True
               ElseIf rsVBP!COMPONENTE < rsVBL!ini Then
                   rsVBP.MoveNext
                   VALID = False
               Else
                   Print #5, "Componente Inicial:"; Tab(21); rsVBL!ini; Tab(31); "da linha"; Tab(40); rsVBL!COD; Tab(50); "N�O ENCONTRADO."
                   
                   CriaComponenteDefault (rsVBL!ini)
                   If blnPontoCriado = True Then
                       Print #5, "Componente " & rsVBL!ini & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
                   Else
                       Print #5, "Componente " & rsVBL!ini & " N�O PODE SER CRIADO AUTOMATICAMENTE."
                   End If
                   
                   rsVBL.MoveNext
               End If
               If rsVBP.EOF = True Then
                   If VALID = False Then
                       Do While Not rsVBL.EOF = True
                           Print #5, "Componente Inicial:"; Tab(21); rsVBL!ini; Tab(31); "da linha"; Tab(40); rsVBL!COD; Tab(50); "n�o encontrado!"
                           
                           CriaComponenteDefault (rsVBL!ini)
                           If blnPontoCriado = True Then
                               Print #5, "Componente " & rsVBL!ini & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
                           Else
                               Print #5, "Componente " & rsVBL!ini & " N�O PODE SER CRIADO AUTOMATICAMENTE."
                           End If
                           rsVBL.MoveNext
                       Loop
                   End If
                   Exit Do
               End If
           Loop
       End If
   End If
   Print #5, ""
   Print #5, " * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
   Print #5, ""
'*** FEITO ***
   Set rsVBL = Conn.Execute("SELECT OBJECT_ID_ AS COD,FINALCOMPONENT AS FIM FROM WATERLINES ORDER BY FINALCOMPONENT")
   If rsVBL.EOF = False Then
       Set rsVBP = Conn.Execute("SELECT COMPONENT_ID AS COMPONENTE FROM WATERCOMPONENTS ORDER BY COMPONENT_ID")
       'VALIDANDO TODOS OS COMPONENTES FINAL DA WATERLINES
       If rsVBP.EOF = False Then
           Do While Not rsVBP.EOF = True And Not rsVBL.EOF = True
               If rsVBP!COMPONENTE = rsVBL!fim Then 'validado
                   rsVBL.MoveNext
                   VALID = True
               ElseIf rsVBP!COMPONENTE < rsVBL!fim Then
                   rsVBP.MoveNext
                   VALID = False
               Else
                   Print #5, "Componente Final:"; Tab(21); rsVBL!fim; Tab(31); "da linha"; Tab(40); rsVBL!COD; Tab(50); "N�O ENCONTRADO."
                   
                   CriaComponenteDefault (rsVBL!fim)
                   If blnPontoCriado = True Then
                       Print #5, "Componente " & rsVBL!fim & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
                   Else
                       Print #5, "Componente " & rsVBL!fim & " N�O PODE SER CRIADO AUTOMATICAMENTE."
                   End If
   
                   rsVBL.MoveNext
               End If
               If rsVBP.EOF = True Then
                   If VALID = False Then
                       Do While Not rsVBL.EOF = True
                           Print #5, "Componente Final:"; Tab(21); rsVBL!fim; Tab(31); "da linha"; Tab(40); rsVBL!COD; Tab(50); "n�o encontrado!"
                           
                           CriaComponenteDefault (rsVBL!fim)
                           If blnPontoCriado = True Then
                              Print #5, "Componente " & rsVBL!fim & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
                           Else
                              Print #5, "Componente " & rsVBL!fim & " N�O PODE SER CRIADO AUTOMATICAMENTE."
                           End If
                           
                           rsVBL.MoveNext
                       Loop
                   End If
                   Exit Do
               End If
           Loop
       End If
   End If
   
   Close #5 'FECHA O ARQUIVO TEXTO PARA LOG
   
   rsVBL.Close
   rsVBP.Close
   Me.MousePointer = vbDefault
   MsgBox "foi gerado em xxx um relat�rio contendo o diagn�stico de rede.", vbInformation, ""
   Unload Me
   

Trata_Erro:

If Err.Number = 0 Or Err.Number = 20 Then
    Resume Next
Else
   'Resume
   Me.MousePointer = vbDefault
   Open App.Path & "\Controles\GeoSanLog.txt" For Append As #1
   Print #1, Now & " - frmVerificaConectividade - cmdInciar_Click - " & Err.Number & " - " & Err.Description
   Close #1
   MsgBox "Um posss�vel erro foi identificado:" & Chr(13) & Chr(13) & Err.Description & Chr(13) & Chr(13) & "Foi gerado na pasta do aplicativo o arquivo GeoSanLog.txt com informa��es desta ocorr�ncia.", vbInformation

End If

End Sub
'revisar esta rotina

Private Function IMPRIME_COMPONENTE_SEM_GEOMETRIA()
   
   'FUN��O PARA VERIFICAR SE OS OBJECT_ID NA TABELA POINTS POSSUEM UM OBJECT_ID_ NA WATERCOMPONENTS
   'CRIA UMA LISTA DE ID's DE WATERCOMPONENTS QUE N�O FORAM ENCONTRADOS
   Dim rsWTC As New ADODB.Recordset
   Dim rsPOINT As New ADODB.Recordset
   
   Set rsWTC = Conn.Execute("SELECT OBJECT_ID_ AS ID_COMP, LENGTH(OBJECT_ID_) AS TAM FROM WATERCOMPONENTS ORDER BY TAM, OBJECT_ID_")
   
   'SELECT OBJECT_ID_, LENGTH(OBJECT_ID_) AS TAM from WATERCOMPONENTS ORDER BY TAM, OBJECT_ID_
   
   If rsWTC.EOF = False Then
       Set rsPOINT = Conn.Execute("SELECT OBJECT_ID AS ID_POINT, LENGTH(OBJECT_ID) AS TAM FROM POINTS16 ORDER BY TAM, OBJECT_ID")
       
       Open "c:\teste.txt" For Append As #4
       'COMPARANDO OS ID's
       
       If rsPOINT.EOF = False Then
           Do While Not rsPOINT.EOF = True And Not rsWTC.EOF = True
               If CDbl(rsPOINT!ID_POINT) = CDbl(rsWTC!ID_COMP) Then 'validado
                   rsWTC.MoveNext
                   VALID = True
               ElseIf CDbl(rsPOINT!ID_POINT) < CDbl(rsWTC!ID_COMP) Then
                   rsPOINT.MoveNext
                   VALID = False
               Else
                   Print #4, "Componente Inicial:"; Tab(21); rsWTC!ID_COMP; Tab(30); "N�O ENCONTRADO NA TABELA DE GEOMETRIA."
                   
'                   CriaComponenteDefault (rsWTC!ini)
'                   If blnPontoCriado = True Then
'                       Print #5, "Componente " & rsWTC!ini & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
'                   Else
'                       Print #5, "Componente " & rsWTC!ini & " N�O PODE SER CRIADO AUTOMATICAMENTE."
'                   End If
                   
                   rsWTC.MoveNext
               End If
'               If rsVBP.EOF = True Then
'                   If VALID = False Then
'                       Do While Not rsWTC.EOF = True
'                           Print #5, "Componente Inicial:"; Tab(21); rsWTC!ini; Tab(31); "da linha"; Tab(40); rsWTC!COD; Tab(50); "n�o encontrado!"
'
'                           CriaComponenteDefault (rsWTC!ini)
'                           If blnPontoCriado = True Then
'                               Print #5, "Componente " & rsWTC!ini & " POSSUI GEOMETRIA E FOI CRIADO AUTOMATICAMENTE."
'                           Else
'                               Print #5, "Componente " & rsWTC!ini & " N�O PODE SER CRIADO AUTOMATICAMENTE."
'                           End If
'                           rsWTC.MoveNext
'                       Loop
'                   End If
'                   Exit Do
'               End If
           Loop
       End If
   End If

Close #4

End Function

Private Sub Cancela_Click()
    Unload Me
End Sub
'A partir dos dados de um n�, localiza se existem trechos de rede encostados no mesmo
'
'
'
Private Function ProcuraTrechosEncostadosEmUmNo(no_coord_x As Double, no_coord_y As Double, objId_no As String, arquivoLog As String)

    Dim strSql As String
    Dim leGeoSanIni As New ValidaBase.CGeoSanIniFile    'Classe para ler dados de inicializa��o
    Dim TpConexao As String                             'Tipo de conex�o, se SQLServer, Oracle ou Postgres
    Dim rsLinha As New ADODB.Recordset
    Dim retorno As Integer
    Dim numPontos As Integer
    Dim objIDLinha As String
    Dim Xi As Double
    Dim Xf As Double
    Dim Yi As Double
    Dim Yf As Double                                    'Coordenadas inicial e final da linha
    Dim encontrou As Boolean                            'indica se encontrou ou n�o uma extremidade da linha que coincide com a coordenada do n�
    Dim dbConn As New ADODB.Connection
    Dim tipoErro As String                              'Registra o tipo de erro que pode vir a acontecer
    Dim precisao As Double                              'Indica a precis�o de compara��o entre duas coordenadas
    Dim contadorTrechos As Integer                      'Para mostrar no statusbar o trecho que est� sendo processado
    Dim dif_x As Double                                 'Calcula se os n�s est�o na mesma coordenada para comparar a precis�o
    Dim dif_y As Double                                 'Calcula se os n�s est�o na mesma coordenada para comparar a precis�o
    
    precisao = 0.01
    contadorTrechos = 0
    On Error GoTo Trata_Erro
    leGeoSanIni.arquivo = App.Path & "\Controles\GeoSan.ini"
    TpConexao = leGeoSanIni.TipoBDados
    dbConn.Open leGeoSanIni.StrConexao                              'Abre a conex�o geogr�fica com o banco de dados do GeoSan para utilizar o TeDatabase
    TeDatabase1.Connection = dbConn                                 'Atribui a conex�o para TeDatabase
    TeDatabase1.setCurrentLayer ("waterlines")                      'Indica que o layer ativo � o de redes de �gua, WATERLINES
    
    Select Case TpConexao
        Case "1-SQL Server 2005"
            'gera um Recordset contendo todos os OBJECT_ID_s sem geometrias
            strSql = "SELECT * FROM LINES1"
            strSql = strSql + " where lower_x <= " & no_coord_x + precisao & " and upper_x >= " & no_coord_x - precisao & " and lower_y <= " & no_coord_y + precisao & " and upper_y >= " & no_coord_y - precisao
            strSql = Replace(strSql, ",", ".")
            Set rsLinha = Conn.Execute(strSql)
        Case "Oracle"
            'N�o implementado
        Case "Postgres"
            'N�o implementado
        Case Else
            MsgBox "Banco de dados incorreto, somente s�o aceitos SQLServer, Oracle e Postgres. Entre em contato com o suporte."
    End Select
    
    encontrou = False
    objIDLinha = ""
    Do While Not rsLinha.EOF
        'procura em todas as linhas (redes) se existe um n� com as mesmas coordenadas que uma das extremidades da linha
        contadorTrechos = contadorTrechos + 1
        objIDLinha = rsLinha.Fields("object_id").Value
        retorno = TeDatabase1.getPointOfLine(0, objIDLinha, 0, Xi, Yi) 'retorna em Xi e Yi as coordenadas iniciais da linha
        dif_x = Abs(Xi - no_coord_x)
        dif_y = Abs(Yi - no_coord_y)
        If dif_x < precisao And dif_y < precisao Then
            encontrou = True
            Exit Do
        End If
        numPontos = TeDatabase1.getQuantityPointsLine(0, objIDLinha) 'retorna n�mero de pontos que comp�em a linhA para pegar as coordenadas do ultimo ponto
        If numPontos >= 2 Then
            retorno = TeDatabase1.getPointOfLine(0, objIDLinha, numPontos - 1, Xf, Yf) 'retorna em XL2 e YL2 as coordenadas finais da linha
        End If
        dif_x = Abs(Xf - no_coord_x)
        dif_y = Abs(Yf - no_coord_y)
        If dif_x < precisao And dif_y < precisao Then
            encontrou = True
            Exit Do
        End If
        StatusBar1.Panels.Item(3).Text = "Trecho " & CStr(contadorTrechos)
        rsLinha.MoveNext
    Loop
    If encontrou = False Then
        'o objIDLinha n�o tem rela��o aqui com o objId_no
        Open arquivoLog For Append As #1
        Print #1, vbCrLf & "N�o encontra uma linha encostada no n� de object_id_ = " & objId_no
        Close #1
        'Implementa��o SQLServer para apagar o n� sozinho
            Dim rsNo As New ADODB.Recordset
            strSql = "DELETE FROM Points2 where object_id = " & objId_no
            Set rsNo = Conn.Execute(strSql)
            strSql = "DELETE FROM watercomponents where object_id_ = " & objId_no
            Set rsNo = Conn.Execute(strSql)
            'rsNo.Close
            Open arquivoLog For Append As #1
            Print #1, vbCrLf & "Apagada a geometria e atributo do n� de object_id_ = " & objId_no & " que n�o estava associado a nenhum trecho de rede."
            Close #1
    End If

Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
        Screen.MousePointer = vbDefault
        PrintErro CStr(Me.Name), "ProcessaBancoDados_Click(), tipo de erro: " & tipoErro, CStr(Err.Number), CStr(Err.Description), True
    End If
End Function
' Esta rotina localiza todos os n�s que n�o possuem encostados nos mesmos um trecho de rede
'
' numTabGeomPoints - n�mero da tabela que contem as geometrias de pontos dos n�s (watercomponents)
' arquivoLog - nome do arquivo onde ser�o gerados os logs
'
Private Function ProcuraNosSemTrechosEncostados(numTabGeomPoints As String, arquivoLog As String)

    Dim strSql As String
    Dim leGeoSanIni As New ValidaBase.CGeoSanIniFile    'Classe para ler dados de inicializa��o
    Dim TpConexao As String                             'Tipo de conex�o, se SQLServer, Oracle ou Postgres
    Dim rsNo As New ADODB.Recordset
    Dim coordNo_x As Double                             'Coordenada y do n�
    Dim coordNo_y As Double                             'Coordenada y do n�
    Dim objID As String
    Dim tipoErro As String                                          'Registra o tipo de erro que pode vir a acontecer
    Dim contadorNos As Integer                          'Conta para mostrar o andamento do processamento no statusbar
    
    On Error GoTo Trata_Erro
    
    StatusBar1.Panels.Item(1).Text = "1-Vefifica n�s sem redes"
    contadorNos = 0
    leGeoSanIni.arquivo = App.Path & "\Controles\GeoSan.ini"
    TpConexao = leGeoSanIni.TipoBDados
    StatusBar1.Panels.Item(1).Text = "1-Verifica��o dos n�s"
    Select Case TpConexao
        Case "1-SQL Server 2005"
            'gera um Recordset contendo todos os OBJECT_ID_s sem geometrias
            strSql = "SELECT * FROM POINTS" & numTabGeomPoints
            Set rsNo = Conn.Execute(strSql)
        Case "Oracle"
            'N�o implementado
        Case "Postgres"
            'N�o implementado
        Case Else
            MsgBox "Banco de dados incorreto, somente s�o aceitos SQLServer, Oracle e Postgres. Entre em contato com o suporte."
    End Select
    
    Do While Not rsNo.EOF
        'obtenho os dados do ponto com suas coordenadas
        contadorNos = contadorNos + 1
        StatusBar1.Panels.Item(2).Text = "N� " & CStr(contadorNos)
        objID = rsNo.Fields("OBJECT_ID").Value
        coordNo_x = rsNo.Fields("x").Value
        coordNo_y = rsNo.Fields("y").Value
        Call ProcuraTrechosEncostadosEmUmNo(coordNo_x, coordNo_y, objID, arquivoLog)
        rsNo.MoveNext
    Loop
    
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
        Screen.MousePointer = vbDefault
        PrintErro CStr(Me.Name), "ProcessaBancoDados_Click(), tipo de erro: " & tipoErro, CStr(Err.Number), CStr(Err.Description), True
    End If
End Function
'Esta � a rotina inicial que realiza o processamento do banco de dados do GeoSan quando a n�o conformidades existentes no mesmo
'� dada uma �nfase em informar todas as atividades no arquivo de log do sistema
'
'
'
Private Sub ProcessaBancoDados_Click()
    On Error GoTo Trata_Erro                                        'Desvia para a rotina de tratamento de erro, caso um erro ocorra
    Dim leGeoSanIni As New ValidaBase.CGeoSanIniFile                'Abre a conex�o com o banco de dados
    Dim num_linhas As Integer
    Dim numeroTabelaGeomWl As String
    Dim numeroTabelaGeomWc As String
    Dim rsSemPoints As New ADODB.Recordset
    Dim id_componente As String                                     'object_id da tabela de atributos de pontos que n�o possui geometria associada
    Dim rsFinal As New ADODB.Recordset                              'rsFinal indica os trechos de redes que possuem como n� final o mesmo que de outros trechos, ou seja redes conectadas
                                                                    'lista com linhas (trechos de rede) com n�s finais dos trechos de redes de �gua que pertencem a outros trechos de redes
    Dim rsInitial As New ADODB.Recordset                            'lista com linhas (trechos de redes) com n�s iniciais dos trechos de redes de �gua que pertencem a outros trechos de redes
    Dim LINHA1 As String                                            'object_id da linha que � componente inicial
    Dim LINHA2 As String                                            'object_id da linha que � componente final
    Dim QTDPT As Integer
    Dim retorno As Double
    Dim XL1 As Double, XL2 As Double, YL1 As Double, YL2 As Double  'X e Y iniciais e finais da linha
    Dim dbConn As New ADODB.Connection
    Dim strCMD As String                                            'comando SQL
    Dim arquivoLog As String                                        'nome do arquivo de log com todas as opera��es realizadas no banco de dados
    Dim tipoErro As String                                          'Registra o tipo de erro que pode vir a acontecer
    
    StatusBar1.Panels.Item(1).Text = "In�ciando ..."
    StatusBar1.Panels.Item(2).Text = "  "
    
    tipoErro = "Sem registro erro"                                  'indica que n�o existe um registro de erro
    Screen.MousePointer = vbHourglass                               'coloca o mouse como ampulheta
    leGeoSanIni.arquivo = App.Path & "\Controles\GeoSan.ini"        'Informa onde est�o as informa��es sobre a localiza��o, nome e tipo de banco de dados
    Conn.ConnectionString = leGeoSanIni.StrConexao                  'Inicializa a string de conex�o com o banco de dados
    tipoErro = "Erro de conex�o com base de dados: " & leGeoSanIni.StrConexao & " no arquivo: " & App.Path & "\Controles\GeoSan.ini"  'Registra a conex�o caso o registro de erro ocorra
    Conn.Open                                                       'Abre a conex�o com o banco de dados do GeoSan
    tipoErro = "Sem registro erro"                                  'indica que n�o existe um registro de erro
    arquivoLog = "\Controles\ValidaBase" & DateValue(Now) & "  " & TimeValue(Now) & ".log"    'define o nome completo do arquivo de log do sistema, inclu�ndo a data e hora em que o mesmo ser� gerado pela primeira vez
    arquivoLog = Replace(arquivoLog, "/", "-")                      'troca caractere / especial que n�o � aceito como parte do nome do arquivo
    arquivoLog = Replace(arquivoLog, ":", "-")                      'troca caractere : especial que n�o � aceito como parte do nome do arquivo
    arquivoLog = App.Path & arquivoLog                              'adiciona a localiza��o do caminho onde o aplicativo est� instalado
    Open arquivoLog For Append As #1                                'Inicia o log do sistema, abrindo o arquivo sem apagar o log anterior, mantendo sempre o hist�rico
    Print #1, vbCrLf & "ValidaBase;*************************************************************************************************"  'Pula uma linha antes de iniciar a escrita
    Print #1, "ValidaBase;In�cio do processamento do banco de dados GeoSan: " & DateValue(Now) & " - " & TimeValue(Now)
    Close #1
    numeroTabelaGeomWl = ObtemGeomWaterlines                        'Precisamos saber qual o n�mero da tabela de geometrias que est� relacionada com a tabela de atributos WATERLINES
    num_linhas = ApagaLinhasAtributosSemGeometriasWaterlines(numeroTabelaGeomWl, arquivoLog)    'Varre a tabela de WATERLINES para ver se encontra atributos sem geometrias e se encontrar apaga os atributos
    num_linhas = ApagaGeometriasSemAtributosWaterlines(numeroTabelaGeomWl, arquivoLog)          'Varre a tabela WATERLINES para ver se encontra geometrias sem atributos e se encontrar apaga as geometrias
    numeroTabelaGeomWc = ObtemGeomWatercomponents                   'Obtem o n�mero da tabela POINTS, de geometrias dos n�s das redes
    dbConn.Open leGeoSanIni.StrConexao                              'Abre a conex�o geogr�fica com o banco de dados do GeoSan para utilizar o TeDatabase
    TeDatabase1.Connection = dbConn                                 'Atribui a conex�o para TeDatabase
    TeDatabase1.setCurrentLayer ("waterlines")                      'Indica que o layer ativo � o de redes de �gua, WATERLINES
       
    

    
    'Procura por n�s soltos, que n�o tenham trechos encostados nos mesmos
    Call ProcuraNosSemTrechosEncostados(numeroTabelaGeomWc, arquivoLog)
    
    
    'Verifica se para cada object_id em Points2 existe outro em Watercomponents e vice-versa
    Call VefificaUnicidadeNos(numeroTabelaGeomWc, arquivoLog)
    
    'Apaga todos os pontos dos n�s que n�o possuem atributo associado
    'Ele vai na tabela POINTS2 e verifica se existem geometrias de n�s (pontos) que n�o possuem atributos associados
    'Ele elimina as geometrias que n�o possuem atributos e registra as eliminadas no arquivo de log
    Call ApagaPointsSemWatercomponents(numeroTabelaGeomWc, arquivoLog)
    
    'Identifica se existem N�S existentes como atributos mas sem a presen�a da respectiva geometria
    'Ele vai na tabela WATERCOMPONENTS e verifica se existem atributos de componentes (n�s) que n�o possuem uma geometria associada
    'Em nosso modelo sempre deve existir uma geometria associada a um atributo
    Call WcSemGeometrias(numeroTabelaGeomWc, rsSemPoints, arquivoLog)
    
    'Desta forma, conforme chamada anterior vamos agora investigar os n�s que possuem atributos, mas n�o possuem as respectivas geometrias associadas
    'Enquanto existirem n�s sem geometrias
    'Primeiro verifica se existem atributos de pontos (n�s de redes) sem geometrias, se n�o existir pula esta parte (While), pois est� tudo ok
    Open arquivoLog For Append As #1
    Print #1, vbCrLf & "ProcessaBancoDados_Click;In�cio da investiga��o dos n�s que possuem atributos mas n�o possuem geometrias"
    Close #1
    StatusBar1.Panels.Item(1).Text = "4-N�s com atributos sem geometrias"
    Do While Not rsSemPoints.EOF = True
        id_componente = rsSemPoints!Object_id_                              'obtem o object_id_ que n�o tem geometria associada
        StatusBar1.Panels.Item(2).Text = "N� " & id_componente
        StatusBar1.Panels.Item(3).Text = " "
        Call ProcuraSeEhNoInicial(id_componente, rsInitial)                 'verifica se o n� em quest�o � um n� inicial de algum trecho de redes em WATERLINES
        If rsInitial.EOF = False Then
            'chegando a este ponto significa que o componente � inicial de 1 ou mais linhas (trechos de rede)
            LINHA1 = rsInitial!Object_id_                                   'carrega em LINHA1 o id da linha que o componente � inicial
            retorno = TeDatabase1.getPointOfLine(0, LINHA1, 0, XL1, YL1)    'retorna em XL1 e YL1 as coordenadas iniciais da linha
            'Procura pelos demais trechos de rede com OBJECT_ID do n� inicial com exce��o do trecho j� visto anteriormente
            Set rsFinal = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,FINALCOMPONENT FROM WATERLINES WHERE FINALCOMPONENT ='" & id_componente & "'AND OBJECT_ID_ <> '" & LINHA1 & "'")
            If rsFinal.EOF = False Then
                'chegando a este ponto significa que o componente � final de 1 ou mais linhas (trechos de rede)
                LINHA2 = rsFinal!Object_id_                                 'carrega em LINHA1 o id da linha que o componente � final
                'chegando a este ponto significa que o componente � inicial e final de duas OU mais linhas
                'ANALISAR AS 2 LINHAS
                'FAZER A PESQUISA PARA SABER O X,Y DAS LINHAS
                'caso a linha que est� conectada no ponto final possua mais de dois vertices, vamos obter as coordenadas do �ltimo v�rtice
                QTDPT = TeDatabase1.getQuantityPointsLine(0, LINHA2) 'retorna n�mero de pontos que comp�em a linhA para pegar as coordenadas do ultimo ponto
                If QTDPT >= 2 Then
                  retorno = TeDatabase1.getPointOfLine(0, LINHA2, QTDPT - 1, XL2, YL2) 'retorna em XL2 e YL2 as coordenadas finais da linha
                End If
                If XL1 = XL2 And YL1 = YL2 Then
                    strXL1 = Replace(XL1, ",", ".")     'converte o valor double do XL1
                    strYL1 = Replace(YL1, ",", ".")     'converte o valor double do YL1
                    strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & strXL1 & "," & strYL1 & ")"       'insere esta geometria de ponto que est� faltando
                    Open arquivoLog For Append As #1
                    Print #1, "ProcessaBancoDados_Click-03;" & strSql
                    Close #1
                    Conn.Execute (strSql)
                Else
                    'N�o pode entrar aqui pois achou mais trechos de rede
                    'MsgBox "Valor inconsistente para o componente de rede n� " & id_componente & " contido nas linhas " & LINHA1 & " e " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                    Open arquivoLog For Append As #1
                    Print #1, "ProcessaBancoDados_Click-04;Valor inconsistente para o componente de rede n� " & id_componente & " contido nas linhas " & LINHA1 & " e " & LINHA2 & ". N�o foi possivel corrigir automaticamente."
                    Close #1
               End If
            Else
                'chegando a este ponto significa que o componente � somente inicial de duas ou mais linhas
                'ANALIZAR A LINHA QUE ELE � INICIAL
                Dim CONTALINHAS As Integer              'Indica quantos trechos de rede est�o associados a este n� sem geometria
                
                CONTALINHAS = 1                         'Inicializa o contador para uma linha associada
                rsInitial.MoveNext                      'Vai para a pr�xima linha
                Do While Not rsInitial.EOF = True       'Enquanto existirem linhas com o n� inicial sem atributo de geometria
                    CONTALINHAS = CONTALINHAS + 1       'Incrementa o contador de trechos existentes em que o n� inicial n�o possui atributo de geometria
                    rsInitial.MoveNext
                Loop
                If CONTALINHAS = 1 Then                 'O PONTO EST� CONECTADO A SOMENTE 1 LINHA
                    'Existe somente um trecho de rede (linha) com o n� inicial sem a respectiva geometria associada
                    strXL1 = Replace(XL1, ",", ".")     'converte o valor double do XL1
                    strYL1 = Replace(YL1, ",", ".")     'converte o valor double do YL1
                    'insere esta geometria de ponto que est� faltando
                    strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & strXL1 & "," & strYL1 & ")"
                    Open arquivoLog For Append As #1
                    Print #1, "ProcessaBancoDados_Click-01;" & strSql
                    Close #1
                    Conn.Execute (strSql)
                Else
                    'Existe mais de um trecho de rede (linha) com o n� inicial sem a respectiva geometria associada
                    'Temos que ver se a coordenada inicial desta linha
                    Dim rsInitial2 As New ADODB.Recordset   'demais trechos de rede com o n� inicial, com exce��o do trecho inicial j� visto
                    'Procura pelos demais trechos de rede com OBJECT_ID do n� inicial com exce��o do trecho j� visto anteriormente
                    Set rsInitial2 = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,INITIALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT ='" & id_componente & "' AND OBJECT_ID_ <> '" & LINHA1 & "'")
                    If rsInitial2.EOF = False Then
                        'Caso encontre mais trechos de rede que chegam no n� sem geometria
                        LINHA2 = rsInitial2!Object_id_
                        'Obtem a coordenada inicial do trecho de rede encontrado
                        retorno = TeDatabase1.getPointOfLine(0, rsInitial2!Object_id_, 0, XL2, YL2)
                        
                        'verifica se esta coordenada coincide com a do outro trecho, pois deve ser a mesma, pois s�o os mesmos trechos de rede
                        If XL1 = XL2 And YL1 = YL2 Then
                            strXL1 = Replace(XL1, ",", ".") 'converte o valor double do XL1
                            strYL1 = Replace(YL1, ",", ".") 'converte o valor double do YL1
                            'Insere o n� na tabela de geometrias associada a WATERCOMPONENTS
                            strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & strXL1 & "," & strYL1 & ")"
                            Open arquivoLog For Append As #1
                            Print #1, "ProcessaBancoDados_Click-02;" & strSql
                            Close #1
                            Conn.Execute (strSql)
                        Else
                            'MsgBox "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                            Open arquivoLog For Append As #1
                            Print #1, "ProcessaBancoDados_Click-03;Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & ". N�o foi possivel corrigir automaticamente."
                            Close #1
                        End If
                    Else
                        'N�o pode entrar aqui pois achou mais trechos de rede
                        MsgBox "Valores inconsistentes para a linha " & LINHA1 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                        Open arquivoLog For Append As #1
                        Print #1, "ProcessaBancoDados_Click-04;Valores inconsistentes para o trehco de rede (linha): " & LINHA1 & ". N�o foi possivel corrigir automaticamente."
                        Close #1
                    End If
                End If
            End If
        Else
            'Agora analisamos o n� final
            'chegando a este ponto significa que o componente n�o � inicial de nenhuma linha
            'verificando se ele � final de alguma linha
            'verifica se o n� em quest�o � um n� final de algum trecho de redes em WATERLINES
            Call ProcuraSeEhNoFinal(id_componente, rsFinal)
            If rsFinal.EOF = False Then
                'chegando a este ponto significa que o componente � final de 1 ou mais linhas (trechos de rede)
                LINHA1 = rsFinal!Object_id_                                     'carrega em LINHA1 o id da linha que o componente � inicial
                retorno = TeDatabase1.getPointOfLine(0, LINHA1, 0, XL1, YL1)    'retorna em XL1 e YL1 as coordenadas iniciais da linha
                CONTALINHAS = 1                                                 'Inicializa o contador para uma linha associada
                rsFinal.MoveNext                                                'Vai para a pr�xima linha
                Do While Not rsFinal.EOF = True                                 'Enquanto existirem linhas com o n� final sem atributo de geometria
                    CONTALINHAS = CONTALINHAS + 1                               'Incrementa o contador de trechos existentes em que o n� final n�o possui atributo de geometria
                    rsFinal.MoveNext
                Loop
                If CONTALINHAS = 1 Then                                         'O PONTO EST� CONECTADO A SOMENTE 1 LINHA
                    'Existe somente um trecho de rede (linha) com o n� final sem a respectiva geometria associada
                    strXL1 = Replace(XL1, ",", ".")                             'converte o valor double do XL1
                    strYL1 = Replace(YL1, ",", ".")                             'converte o valor double do YL1
                    'insere esta geometria de ponto que est� faltando
                    strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                    Open arquivoLog For Append As #1
                    Print #1, "ProcessaBancoDados_Click-05;" & strSql
                    Close #1
                    Conn.Execute (strSql)
                    Open arquivoLog For Append As #1
                    Print #1, "ProcessaBancoDados_Click-05;Foi inserida uma geometria na tabela POINTS2 referente a WATERCOMPONENTS com object_id: " & id_componente & ", que estava faltando, com sucesso!"
                    Close #1
                Else 'O PONTO EST� CONECTADO A MAIS DE 1 LINHA
                    'Existe mais de um trecho de rede (linha) com o n� final sem a respectiva geometria associada
                    'Temos que ver se a coordenada final desta linha
                    Set rsFinal2 = Conn.Execute("SELECT LINE_ID,OBJECT_ID_,INITIALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT ='" & id_componente & "' AND OBJECT_ID_ <> '" & LINHA1 & "'")
                    If rsFinal2.EOF = False Then
                        'Caso encontre mais trechos de rede que chegam no n� sem geometria
                        LINHA2 = rsFinal2!Object_id_
                        'Obtem a coordenada inicial do trecho de rede encontrado
                        retorno = TeDatabase1.getPointOfLine(0, rsFinal2!Object_id_, 0, XL2, YL2)
                        'verifica se esta coordenada coincide com a do outro trecho, pois deve ser a mesma, pois s�o os mesmos trechos de rede
                        If XL1 = XL2 And YL1 = YL2 Then
                            'Insere o n� na tabela de geometrias associada a WATERCOMPONENTS
                            strSql = "insert into points2 (object_id,x,y) values ('" & id_componente & "'," & XL1 & "," & YL1 & "')"
                            Open arquivoLog For Append As #1
                            Print #1, "ProcessaBancoDados_Click-06;" & strSql
                            Close #1
                            Conn.Execute (strSql)
                            Open arquivoLog For Append As #1
                            Print #1, "ProcessaBancoDados_Click-06;Foi inserida uma geometria na tabela POINTS2 referente a WATERCOMPONENTS com object_id: " & id_componente & ", que estava faltando, com sucesso!"
                            Close #1
                        Else
                            'MsgBox "Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                            Open arquivoLog For Append As #1
                            Print #1, "ProcessaBancoDados_Click-07;Valores inconsistentes para a linha " & LINHA1 & " e linha " & LINHA2 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente."
                            Close #1
                        End If
                    Else
                        'N�o pode entrar aqui pois achou mais trechos de rede
                        'MsgBox "Valores inconsistentes para a linha " & LINHA1 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente.", vbExclamation, ""
                        Open arquivoLog For Append As #1
                        Print #1, "ProcessaBancoDados_Click-08;Valores inconsistentes para a linha " & LINHA1 & "." & Chr(13) & Chr(13) & "N�o foi possivel corrigir automaticamente."
                        Close #1
                    End If
                End If
            Else
               'chegando a este ponto significa que o componente n�o � inicial nem final de linhas
               strCMD = "DELETE FROM WATERCOMPONENTS WHERE OBJECT_ID_ ='" & id_componente & "'"
               Open arquivoLog For Append As #1
               Print #1, "ProcessaBancoDados_Click-09;" & strSql
               Close #1
               Conn.Execute (strCMD)
            End If
        End If
        rsSemPoints.MoveNext
    Loop
    Open arquivoLog For Append As #1
    Print #1, "ProcessaBancoDados_Click;Fim da investiga��o dos n�s que possuem atributos mas n�o possuem geometrias"
    Close #1
    'Agora vamos verificar quais os n�s que est�o presentes na componente inicial (n� inicial) da tabela Waterlines, mas n�o existe como n� em Watercomponents
    Call ValidaComponentesIniciaisDeWaterlines(arquivoLog)
    
    'Agora vamos verificar quais os n�s que est�o presentes na componente final (n� final) da tabela Waterlines, mas n�o existe como n� em Watercomponents
    Call ValidaComponentesFinaisDeWaterlines(arquivoLog)
    
    rsSemPoints.Close
    dbConn.Close
    Set dbConn = Nothing
    Screen.MousePointer = vbDefault                     'Volta mouse ao normal
    Conn.Close                                          'Fecha a conex�o com o banco de dados
    Open arquivoLog For Append As #1
    Print #1, vbCrLf & "ValidaBase;Fim do processamento do banco de dados GeoSan: " & DateValue(Now) & " - " & TimeValue(Now)
    Print #1, "ValidaBase;*************************************************************************************************"
    Close #1                                           'Fecha o arquivo de log do sistema
    MsgBox "Valida��o conclu�da. Verifique o log no arquivo " & arquivoLog

Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
        Screen.MousePointer = vbDefault
        PrintErro CStr(Me.Name), "ProcessaBancoDados_Click(), tipo de erro: " & tipoErro, CStr(Err.Number), CStr(Err.Description), True
    End If

End Sub
