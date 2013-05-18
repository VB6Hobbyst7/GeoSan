VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CCoordIniRamalDistTrecho"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Fun�~oes para obter as coordenadas do ramal em sua nova posi��o, ap�s movida a rede
'
Private dist As Double                              'dist�ncia do in�cio do ramal antes de mover at� o in�cio do trecho antes de mover
Private coordsR As New CLine2D
Private coordInicialRamal As New CPoint2D           'nova coordenada inicial do ramal
'Retorna coordenadas do primeiro e �ltimo v�rtices da linha
'
Property Get CoordIniFimRamal() As CLine2D
    Set CoordIniFimRamal = coordsR
End Property
'Retorna a nova coordenada inicial do ramal
'
Property Get coordRamal() As CPoint2D
    Set coordRamal = coordInicialRamal
End Property

' Obtem as coordenadas iniciais e finais do ramal ap�s a movimenta��o do trecho de rede
'
' distancia - nova dist�ncia do in�cio do trecho de rede at� o in�cio do ramal na nova posi��o tanto do trecho quanto do ramal
' newObjIdTrecho - do trecho depois que moveu o mesmo
' teDatabaseConn - conex�o com o banco de dados geogr�fico
'
Public Function coordsRamal(Distancia As Double, newObjIdTrecho As String, ByVal teDatabaseConn As TeDatabase)
    Dim linha3 As New CLine2D                       'linha final movida do trecho de rede
    Dim linha4 As New CLine2D                       'linha final do ramal, movido, ligado ao trecho de rede
    Dim coordenadasLinha3 As New CCoordIniFinLinha  'coordenadas ao trecho de rede depois de mover
    Dim coordXYdist As New CCoordXYaDistLinha
    
    'obtem as coordenadas inicial e final do trecho de rede na nova posi��o ao qual foi movido
    coordenadasLinha3.GetStartEndPointsTrecho (newObjIdTrecho)      'calcula as coordenadas inicial e final do novo trecho de rede
    linha3.xi = coordenadasLinha3.linha.xi                          'obtem as coordenadas
    linha3.yi = coordenadasLinha3.linha.yi
    linha3.xf = coordenadasLinha3.linha.xf
    linha3.yf = coordenadasLinha3.linha.yf
    coordXYdist.calculaCoord linha3, Distancia
    coordInicialRamal.X = coordXYdist.X                                      'nova coordenada x inicial do ramal movido
    coordInicialRamal.Y = coordXYdist.Y                                      'nova coordenada y inicial do ramal movido
    coordsR.xf = linha3.xf                                          'coordenada x final do ramal, onde est� o hidr�metro, que n�o foi movido, mesma que a anterior
    coordsR.yf = linha3.yf                                          'coordenada y final do ramal, onde est� o hidr�metro, que n�o foi movido, mesma que a anterior
End Function
