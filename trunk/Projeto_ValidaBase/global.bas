Attribute VB_Name = "Module1"
'
'Modulo - string que cont�m em arquivo VB o erro ocorreu
'EVENTO - string que cont�m em que rotina o erro ocorreu
'ErrDescr - string com a descri��o do erro ocorrido
'ExibeMensagem - se � para exibir ou n�o uma mensagem para o usu�rio
'linha - n�mero da linha em que o erro ocorreu
'
Public Function PrintErro(ByVal Modulo As String, ByVal EVENTO As String, ByVal ErrNum As String, ByVal ErrDescr As String, ByVal ExibeMensagem As Boolean, Optional ByVal linha As Integer = 0)
      Close #1 'FECHA O ARQUIVO DE LOG
      Open App.Path & "\Controles\ValidaBaseLog.txt" For Append As #1
      Print #1, "DATA"; Tab(16); Now
      Print #1, "USU�RIO"; Tab(16); strUser
      Print #1, "VERS�O"; Tab(16); Versao_Geo
      Print #1, "M�DULO"; Tab(16); Modulo
      Print #1, "EVENTO"; Tab(16); EVENTO
      Print #1, "LINHA"; Tab(16); CStr(linha)
      Print #1, "MOTIVO"; Tab(16); ErrNum
      Print #1, "DESCRI��O"; Tab(16); ErrDescr
      Print #1, ""
      Print #1, "-----------------------------------------------------------------------------------------------------"
      Print #1, ""
      Close #1 'FECHA O ARQUIVO
      'SE O PAR�METRO ExibeMensagem = True , EXIBE MENSAGEM PARA O USU�RIO
      If ExibeMensagem = True Then
         MsgBox "A opera��o n�o pode ser completada, consulte o arquivo " & App.Path & "\Controles\ValidaBaseLog.txt" & " para maiores detalhes.", vbInformation
      End If
End Function
