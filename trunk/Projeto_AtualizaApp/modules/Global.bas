Attribute VB_Name = "Global"
'Refer�ncias adicionadas:
'Microsoft Scripting Runtime - srcrun.dll - para saber a vers�o de uma aplica��o e copiar arquivos
'Microsoft CDO for Windows 2000 Library - cdosys.dll
'Componentes adicionados (controles):
'Microsoft Internet Transfer Control 6.0 - msinet.ocx - para fazer download de arquivos
'Microsoft Windows Comom Controls 6.0 (SP6) - mscomctl.ocx
'Microsoft Winsock Control 6.0 - mswsock.dll
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

'Defini��o de vari�veis globais
'
'
'
Public b() As Byte

Public ErroUsuario As New CPrintErro            'Para gerenciar os erros que por ventura ocorram
Public conf As New CArquivoIni                  'Para ler e escrever as configura��es de trabalho do arquivo GEOSAN.INI
Public versao As CGetVersion                    'gest�o das vers�es de software que dever�o ser atualizadas
Public mensagem As String                       'mensagem do que est� realizando para o usu�rio
Public Email As New CEmail                      'Classe respons�vel pelo envio de emails

Public Sub Main()
    MsgBox "test"
End Sub
