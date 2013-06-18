VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CGetVersion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Para obter a vers�o de um arquivo .exe
Private linha() As String
Public Function ObtemVersao(dirNomeArquivo As String) As String
    Dim fso As FileSystemObject
    
    Set fso = New FileSystemObject
    ObtemVersao = fso.GetFileVersion(dirNomeArquivo)
End Function
' L� o arquivo com todas as atualiza��es dispon�veis
' O formato do arquivo �:
'
' nome do arquivo a atualizar;diretorio local;vers�o
'
' VerificaAtualizacoes - n�mero de atualiza��es a serem realizadas (n�mero de linhas lidas)
' dirNomeArquivo - diret�rio completo e nome do arquivo que ser� lido
'
' vbCr is the carriage return (return to line beginning),
' vbLf is the line feed (go to next line)
' vbCrLf is the carriage return / line feed (similar to pressing Enter)
Public Function VerificaAtualizacoes(dirNomeArquivo As String) As Integer
    On Error GoTo Trata_Erro:
    Dim contador As Integer
    Dim arquivoLido As String
    Dim linhaLida As String

    Open dirNomeArquivo For Input As #1
    Input #1, arquivoLido
    Close #1
    linha() = Split(arquivoLido, vbLf)
    VerificaAtualizacoes = UBound(linha()) + 1
    Exit Function
    
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
        ErroUsuario.Registra "CGetVersion", "VerificaAtualizacoes", CStr(Err.Number), CStr(Err.Description), True, glo.enviaEmails
        DownloadArquivo = False
    End If
End Function
' Dada uma linha lida no arquivo remoto de atualiza��es a serem realizada, faz um parse para ver o que tem que realizar no computador local para uma determinada atualiza��o
' Segue o formato:
'
' nome do arquivo a atualizar;diretorio local;vers�o
'
' atualizacao - string contendo todos os par�metros separados por ;
' nomeArquivo - nome do arquivo a ser atualizado
' diretorio - localiza��o do mesmo no computador cliente
' versao - n�mero da nova vers�o para comparar com a existente e ver se necessita atualizar
'
Public Sub SplitAtualizacoes(numeroLinha As Integer, ByRef nomeArquivo As String, ByRef diretorio As String, ByRef versao As String)
    On Error GoTo Trata_Erro:
    Dim splitAtualizacao() As String
    
    splitAtualizacao = Split(linha(numeroLinha), ";")
    nomeArquivo = splitAtualizacao(0)
    diretorio = splitAtualizacao(1)
    versao = splitAtualizacao(2)
    Exit Sub
    
Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
        ErroUsuario.Registra "CGetVersion", "SplitAtualizacoes", CStr(Err.Number), CStr(Err.Description), True, glo.enviaEmails
        DownloadArquivo = False
    End If
End Sub