VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CGeoDatabase"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public geoDatabase As New TeDatabase           'aqui ele deixa como heran�a todos os m�todos do TeDatabase, quando o usu�rio instanciar um novo objeto do tipo CGeoDatabase
' Fun��o para ativar a conex�o com o banco de dados utilizando a biblioteca TeDatabase
'
' retorna se a conex�o realizou ou n�o
' conex�o - string de conex�o com o banco de dados geogr�fico
' provedor - 0 - Access, 1 - SQLServer, 2 - Oracle, 3 - Firebird, 4 - Postgres (isto vem do VB6 em object browser)
' usu�rio - nome do usu�rio Terralib que se conecta ao banco geogr�fico
'
Public Function configura(conexao As ADODB.connection, provedor As cAppType, usuario As String) As Boolean
    On Error GoTo Trata_Erro:
    
    If typeconnection <> postgreSQL Then
        'se n�o for Postgresss
        geoDatabase.username = usuario
        geoDatabase.Provider = provedor
        geoDatabase.connection = conexao
    Else
        'implementar
    End If

Trata_Erro:
    If Err.Number = 0 Or Err.Number = 20 Then
        Resume Next
    Else
        Erro.Registra "CGeoDatabase", "Falhou ao conectar com o banco de dados", CStr(Err.Number), CStr(Err.Description), True, Erl
        End
    End If
End Function