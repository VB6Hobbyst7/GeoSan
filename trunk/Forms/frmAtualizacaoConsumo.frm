VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmAtualizacaoConsumo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Atualiza��es de Consumo"
   ClientHeight    =   3540
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7200
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3540
   ScaleWidth      =   7200
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.ProgressBar ProgressBar1 
      Height          =   495
      Left            =   360
      TabIndex        =   7
      Top             =   2880
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   873
      _Version        =   393216
      Appearance      =   1
   End
   Begin VB.OptionButton optAtualizaConsumo 
      Caption         =   "Atualizar com o Consumo M�dio das Liga��es Cadastradas"
      Height          =   255
      Left            =   195
      TabIndex        =   6
      Top             =   375
      Value           =   -1  'True
      Width           =   5985
   End
   Begin VB.OptionButton optDistDem 
      Caption         =   "Distribuir Demandas"
      Height          =   255
      Left            =   195
      TabIndex        =   4
      Top             =   840
      Width           =   1800
   End
   Begin VB.OptionButton optImpMedAtuConsDistDem 
      Caption         =   "Importar Medias de Consumo"
      Enabled         =   0   'False
      Height          =   255
      Left            =   195
      TabIndex        =   3
      Top             =   1290
      Width           =   2430
   End
   Begin VB.Frame Frame1 
      Caption         =   "Caminho de Arquivo com M�dias de Consumo"
      Enabled         =   0   'False
      Height          =   990
      Left            =   180
      TabIndex        =   1
      Top             =   1785
      Width           =   6810
      Begin VB.TextBox Text1 
         Height          =   315
         Left            =   240
         TabIndex        =   2
         Top             =   420
         Width           =   6360
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Iniciar"
      Height          =   390
      Left            =   5850
      TabIndex        =   0
      Top             =   2910
      Width           =   1140
   End
   Begin VB.Label Label1 
      Height          =   285
      Left            =   240
      TabIndex        =   5
      Top             =   2970
      Width           =   1350
   End
End
Attribute VB_Name = "frmAtualizacaoConsumo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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




Private Sub Command1_Click()
'On Error GoTo Trata_Erro

   ' if we want to update medium consum in each consumer
   If Me.optAtualizaConsumo.value = True Then
      If AtualizaConsumo = True Then
         MsgBox "Consumo de liga��es atualizados com sucesso!", vbInformation, ""
      Else
         MsgBox "Falha na atualiza��o de consumo.", vbInformation, ""
      End If
      Exit Sub
   End If

   ' if we want to distribute consume demands
   If Me.optDistDem.value = True Then
      
      If DISTRIBUI_DEMANDAS = True Then
         MsgBox "Atualiza��o de demanda conclu�da com sucesso!", vbInformation, "Conclu�do"
      End If
      'If DISTRIBUI_DEMANDAS = False Then
       '  MsgBox "Atualiza��o de demanda conclu�da com sucesso!", vbInformation, "Conclu�do"
     ' End If
   
   End If
   
   
   If Me.optImpMedAtuConsDistDem = True Then
      If Me.Text1.Text <> "" Then
         
         Screen.MousePointer = vbHourglass
         importa_media
         Me.Command1.Enabled = False
      Else
         MsgBox "Caminho de arquivo inv�lido!", vbExclamation, ""
         Exit Sub
      End If
   End If
   
   Command1.Enabled = True
   
'Trata_Erro:
'If Err.Number = 0 Or Err.Number = 20 Then
  ' Resume Next
'Else
 '  MsgBox Err.Number & " - " & Err.Description
   'Resume
'End If

   
End Sub

Private Function AtualizaConsumo() As Boolean
On Error GoTo Trata_Erro
   'ATUALIZA O CONSUMO DAS LIGACOES DE UM RAMAL PUXANDO O VALOR EXISTENTE EM NXGS_V_LIG_COM_CONSUMO_MEDIO
   
   Screen.MousePointer = vbHourglass
   
   ' if the database is SqlServer
   If frmCanvas.TipoConexao = 1 Then
   
        'ORIGINAL DA VERS�O 5.7.6
        'Conn.execute ("UPDATE RAMAIS_AGUA_LIGACAO SET CONSUMO_LPS = (NXGS.CONSUMO_MEDIO * 0.00038580246) FROM RAMAIS_AGUA_LIGACAO RAL INNER JOIN NXGS_V_LIG_COM_CONSUMO_MEDIO NXGS ON RAL.NRO_LIGACAO = NXGS.NRO_LIGACAO")
        'Conn.execute ("UPDATE RAMAIS_AGUA_LIGACAO SET CONSUMO_LPS = (SELECT NXGS.CONSUMO_MEDIO * 0.00038580246 FROM RAMAIS_AGUA_LIGACAO RAL INNER JOIN NXGS_V_LIG_COMERCIAL_CONSUMO NXGS ON RAL.NRO_LIGACAO = NXGS.NRO_LIGACAO)")
        'Conn.execute ("UPDATE RAMAIS_AGUA_LIGACAO SET CONSUMO_LPS = (SELECT NXGS.CONSUMO_MEDIO * 0.00038580246 FROM NXGS_V_LIG_COM_CONSUMO_MEDIO NXGS WHERE RAMAIS_AGUA_LIGACAO.NRO_LIGACAO = NXGS.NRO_LIGACAO)")
         
        'querie does not update consumo_medio - is wrong
        'Conn.execute ("UPDATE RAMAIS_AGUA_LIGACAO SET CONSUMO_LPS = (NXGS.CONSUMO_MEDIDO * 0.00038580246) FROM RAMAIS_AGUA_LIGACAO RAL INNER JOIN NXGS_V_LIG_COMERCIAL_CONSUMO NXGS ON RAL.NRO_LIGACAO = NXGS.NRO_LIGACAO")
         
         'updated with consumo_medio in 2012-08-21
         Conn.execute ("UPDATE RAMAIS_AGUA_LIGACAO SET CONSUMO_LPS = (NXGS.CONSUMO_MEDIO * 0.00038580246) FROM RAMAIS_AGUA_LIGACAO RAL INNER JOIN NXGS_V_LIG_COM_CONSUMO_MEDIO NXGS ON RAL.NRO_LIGACAO = NXGS.NRO_LIGACAO")
   
   ' if the database is oracle
   ElseIf frmCanvas.TipoConexao = 2 Then
  
        Conn.execute ("UPDATE RAMAIS_AGUA_LIGACAO SET CONSUMO_LPS = (SELECT NXGS.CONSUMO_MEDIO * 0.00038580246 FROM NXGS_V_LIG_COM_CONSUMO_MEDIO NXGS WHERE RAMAIS_AGUA_LIGACAO.NRO_LIGACAO = NXGS.NRO_LIGACAO)")
   
   ' if the database is postgres
   ElseIf frmCanvas.TipoConexao = 4 Then
        a = "RAMAIS_AGUA_LIGACAO"
        b = "CONSUMO_LPS"
        c = "CONSUMO_MEDIDO"
        d = "NXGS_V_LIG_COMERCIAL_CONSUMO"
        e = "NRO_LIGACAO"
        Dim conexao As String

        'UPDATE "RAMAIS_AGUA_LIGACAO" SET "CONSUMO_LPS" = (rc."CONSUMO_MEDIDO" *
        ''0.00038580246') FROM "RAMAIS_AGUA_LIGACAO" ra INNER JOIN"NXGS_V_LIG_COMERCIAL_CONSUMO" rc ON ra."NRO_LIGACAO" = rc."NRO_LIGACAO"
        
        'MsgBox "UPDATE " + """" + "RAMAIS_AGUA_LIGACAO" + """" + " SET " + """" + "CONSUMO_LPS" + """" + " = (N." + """" + "CONSUMO_MEDIDO" + """" + " * 0.00038580246) FROM " + """" + "RAMAIS_AGUA_LIGACAO" + """" + "  as R INNER JOIN " + """" + "NXGS_V_LIG_COMERCIAL_CONSUMO" + """" + " N  ON R." + """" + "NRO_LIGACAO" + """" + " = N." + """" + "NRO_LIGACAO" + """" + ""
        
        'MsgBox "ARQUIVO DEBUG SALVO"
        'WritePrivateProfileString "A", "A", "UPDATE " + """" + "RAMAIS_AGUA_LIGACAO" + """" + " SET " + """" + "CONSUMO_LPS" + """" + " = (N." + """" + "CONSUMO_MEDIDO" + """" + " * 0.00038580246) FROM " + """" + "RAMAIS_AGUA_LIGACAO" + """" + "  as R INNER JOIN " + """" + "NXGS_V_LIG_COMERCIAL_CONSUMO" + """" + " N  ON R." + """" + "NRO_LIGACAO" + """" + " = N." + """" + "NRO_LIGACAO" + """" + "", App.path & "\DEBUG.INI"
                                                                                                                                                                                                                                                                                                                 ' "CAST(" + """" + d4 + """" + "." + """" + e4 + """" + " AS INTEGER)"
        'Please verify this querie, is problably is wrong because it updates de consumo_medido instead of consumo_medio - 2012-08-21
        Conn.execute ("UPDATE " + """" + "RAMAIS_AGUA_LIGACAO" + """" + " SET " + """" + "CONSUMO_LPS" + """" + " = (N." + """" + "CONSUMO_MEDIDO" + """" + " * 0.00038580246) FROM " + """" + "RAMAIS_AGUA_LIGACAO" + """" + "  as R INNER JOIN " + """" + "NXGS_V_LIG_COMERCIAL_CONSUMO" + """" + " N  ON CAST(R" + "." + """" + "NRO_LIGACAO" + """" + "AS INTEGER) = CAST(N." + """" + "NRO_LIGACAO" + """" + "AS INTEGER)" + "")
      
        'Conn.execute ("UPDATE " + """" + a + """" + " SET " + """" + b + """" + " = (" + """" + d + """" + "." + """" + c + """" + " * '0.00038580246') FROM " + """" + a + """" + " INNER JOIN( " + """" + d + """" + " ON " + """" + a + """" + "." + """" + e + """" + " = " + """" + d + """" + "." + """" + e + """" + ")'")
        'Conn.execute (conexao)
   End If
   Screen.MousePointer = vbDefault
      
   AtualizaConsumo = True

Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
Else
   Screen.MousePointer = vbDefault
   MsgBox Err.Number & " - " & Err.Description
   AtualizaConsumo = False

   'Resume
End If

End Function

Private Function DISTRIBUI_DEMANDAS() As Boolean
'On Error GoTo Trata_Erro

    Dim rsCon As New ADODB.Recordset
    Dim rsWATER As New ADODB.Recordset
    Dim redeOld As String, Inicial As String, Final As String
    Dim soma_consumo As Double, metade As Double
    Dim strsql As String
    Dim strMetade As String, strConsumo As String
    Dim rsWTC As New ADODB.Recordset
    
    Dim TEMPOINI As Date, TEMPOFIM As Date
    Dim contador As Long
    
    Me.Command1.Enabled = False
    Screen.MousePointer = vbHourglass
      
    TEMPOINI = Now
    
    b = "WATERCOMPONENTS"
    c = "DEMAND"
    
    ' if it is not Postgres
    If frmCanvas.TipoConexao <> 4 Then
        Conn.execute ("UPDATE WATERCOMPONENTS SET DEMAND = 0")
    Else
        Conn.execute ("UPDATE " + """" + b + """" + " SET " + """" + c + """" + " = '0'")
    End If
   
    Dim ma As String
    Dim mb As String
    Dim mc As String
    Dim md As String
    Dim mf As String
    Dim mg As String
    Dim mh As String
    Dim mi As String
    Dim mj As String

    ' open connection to distribute demands
    ' if it is not Postgres
    If frmCanvas.TipoConexao <> 4 Then
        strsql = "SELECT SUM(RAL.CONSUMO_LPS)/2 AS " + """" + "MEDIA_TRECHO" + """" + ",RA.OBJECT_ID_TRECHO,WTR.INITIALCOMPONENT,WTR.FINALCOMPONENT "
        strsql = strsql & "FROM RAMAIS_AGUA_LIGACAO RAL "
        strsql = strsql & "INNER JOIN RAMAIS_AGUA RA ON RAL.OBJECT_ID_ = RA.OBJECT_ID_ INNER JOIN WATERLINES WTR ON WTR.OBJECT_ID_ = RA.OBJECT_ID_TRECHO "
        strsql = strsql & "Where RAL.CONSUMO_LPS > 0 "
        strsql = strsql & "GROUP BY RA.OBJECT_ID_TRECHO,WTR.INITIALCOMPONENT,WTR.FINALCOMPONENT "
        strsql = strsql & "ORDER BY RA.OBJECT_ID_TRECHO,WTR.INITIALCOMPONENT "
    ' if it is Postgres
    Else
        ma = "RAMAIS_AGUA_LIGACAO"
        mb = "CONSUMO_LPS"
        mc = "OBJECT_ID_"
        md = "WATERLINES"
        mf = "INITIALCOMPONENT"
        mg = "FINALCOMPONENT"
        mh = "RAMAIS_AGUA"
        mi = "OBJECT_ID_TRECHO"
        mj = "RAMAIS_AGUA_LIGACAO"
        strsql = "SELECT SUM(" + """" + ma + """" + "." + """" + mb + """" + ")/'2' AS " + """" + "MEDIA_TRECHO" + """" + "," + """" + mh + """" + "." + """" + mi + """" + "," + """" + md + """" + "." + """" + mf + """" + "," + """" + md + """" + "." + """" + mg + """" + " "
        strsql = strsql & "FROM " + """" + ma + """" + ""
        strsql = strsql & "INNER JOIN " + """" + mh + """" + " ON " + """" + ma + """" + "." + """" + mc + """" + " = " + """" + mh + """" + "." + """" + mc + """" + " INNER JOIN " + """" + md + """" + "  ON " + """" + md + """" + "." + """" + mc + """" + " = " + """" + mh + """" + "." + """" + mi + """" + " "
        strsql = strsql & "Where " + """" + ma + """" + "." + """" + mb + """" + " > '0' "
        strsql = strsql & "GROUP BY " + """" + mh + """" + "." + """" + mi + """" + "," + """" + md + """" + "." + """" + mf + """" + "," + """" + md + """" + "." + """" + mg + """" + " "
        strsql = strsql & "ORDER BY " + """" + mh + """" + "." + """" + mi + """" + "," + """" + md + """" + "." + """" + mf + """" + " "
   End If
   
   Set rsCon = New ADODB.Recordset
   rsCon.Open strsql, Conn, adOpenDynamic, adLockReadOnly
   Set rsCon = New ADODB.Recordset
   rsCon.Open strsql, Conn, adOpenDynamic, adLockReadOnly
  
   Do While Not rsCon.EOF = True
      contador = contador + 1
      rsCon.MoveNext
   Loop
   
   rsCon.Close
   Set rsCon = Nothing
   
   Me.ProgressBar1.Max = contador + 1
   Me.ProgressBar1.value = 1
   Me.ProgressBar1.Visible = True
   
   Set rsCon = New ADODB.Recordset
   rsCon.Open strsql, Conn, adOpenDynamic, adLockReadOnly
   
   'MEDIA_TRECHO,OBJECT_ID_TRECHO,INITIALCOMPONENT,FINALCOMPONENT
   If rsCon.EOF = False Then
      Do While Not rsCon.EOF = True
        'DoEvents
        
        'strMetade = (rsCon!MEDIA_TRECHO)
        strMetade = Replace(rsCon!MEDIA_TRECHO, ",", ".")
        
        STRINICIAL = rsCon!INITIALCOMPONENT
        STRFINAL = rsCon!FinalComponent
        
        a = "WATERCOMPONENTS"
        b = "DEMAND"
        c = "INSCRICAO_LOTE"
        d = "OBJECT_ID_"
        e = strMetade
        'f = "e'"
        
        If frmCanvas.TipoConexao <> 4 Then
            'comando que joga para os 2 n�s ponta o consumo da rede
            On Error Resume Next
            Conn.execute ("UPDATE WATERCOMPONENTS SET DEMAND = DEMAND + " & strMetade & " WHERE OBJECT_ID_ IN ('" & STRINICIAL & "','" & STRFINAL & "')")
        Else
            On Error Resume Next
            Conn.execute ("UPDATE " + """" + a + """" + " SET " + """" + b + """" + " = '" & strMetade & "' WHERE " + """" + d + """" + " IN ('" & STRINICIAL & "','" & STRFINAL & "')")
        End If
        
        rsCon.MoveNext
        Me.ProgressBar1.value = Me.ProgressBar1.value + 1
        Loop
    End If
   
    rsCon.Close
    Set rsCon = Nothing
    
    Screen.MousePointer = vbNormal
    Me.ProgressBar1.Visible = False
    
    DISTRIBUI_DEMANDAS = True
   
    'Trata_Erro:
    'If Err.Number = 0 Or Err.Number = 20 Then
    '  Resume Next
    'Else
    '   DISTRIBUI_DEMANDAS = False
    '   MsgBox Err.Number & " - " & Err.Description
      'Resume
    'End If

End Function

Private Function importa_media()

On Error GoTo Trata_Erro

Dim linha As String
Dim Vetor As Variant
Dim i As Integer
Dim SQL As String
Dim rs As New ADODB.Recordset
Dim Cont As Long

   'anoM�s;imov_ID;cons_medio
   a = "NXGS_V_LIG_COM_CONSUMO_MEDIO"


     If frmCanvas.TipoConexao <> 4 Then
   Conn.execute ("DELETE FROM NXGS_V_LIG_COM_CONSUMO_MEDIO")
   Else
      Conn.execute ("DELETE FROM " + a + "")
   End If
   
   'Conn.execute ("DROP TABLE CONSUMO")
   
a = "CONSUMO"
b = "MESANO"
c = "IMOVEL"
d = "CONSUMO"

     If frmCanvas.TipoConexao <> 4 Then
   Conn.execute ("CREATE TABLE CONSUMO (MESANO [char] (12),IMOVEL [char](12), CONSUMO [FLOAT])")
   Else
      Conn.execute ("CREATE TABLE " + """" + a + """" + " (" + """" + b + """" + " character varying(50) ," + """" + c + """" + " character varying(50) ," + """" + d + """" + " float)")
   End If
   Cont = 0
   Open Me.Text1.Text For Input As #3
   Do While Not EOF(3)
      Input #3, linha
      Cont = Cont + 1
   Loop
   Close #3
   
   ProgressBar1.value = 1
   ProgressBar1.Max = Cont + 10
   ProgressBar1.Visible = True
   
   Open Me.Text1.Text For Input As #3

   Do While Not EOF(3)
      DoEvents
      
      Input #3, linha
      Vetor = Split(linha, ";")
      
      a = "CONSUMO"
      b = "MESANO"
      c = "IMOVEL"
      d = "CONSUMO"
      e = "HIDROMETRADO"
      f = "ECONOMIAS"
      g = "CONSUMO_LPS"
      h = "TB_LIGACOES"
      i = "HIDROMETRADO"
      j = "ECONOMIAS"
      k = "CONSUMO_LPS"
      l = "IMOVEL"


     If frmCanvas.TipoConexao <> 4 Then
         
      Conn.execute ("INSERT INTO CONSUMO (MESANO,IMOVEL,CONSUMO) VALUES ('" & Vetor(0) & "','" & Vetor(1) & "','" & Vetor(2) & "')")
     Else
     
       Conn.execute ("INSERT INTO " + """" + a + """" + " (" + """" + b + """" + "," + """" + c + """" + "," + """" + d + """" + ") VALUES ('" & Vetor(0) & "','" & Vetor(1) & "','" & Vetor(2) & "')")
     End If
      
                        
      ProgressBar1.value = ProgressBar1.value + 1
      
      
   Loop
   Close #3
   
   Dim ID_IMOVEL As String
   Dim Media As String
   
      a = "CONSUMO"
      b = "IMOVEL"

      
   
   If frmCanvas.TipoConexao <> 4 Then
   SQL = "SELECT CONSUMO.IMOVEL, SUM(CONSUMO.CONSUMO)/COUNT(CONSUMO.CONSUMO) AS " + """" + "MEDIA_CONS" + """" + " FROM CONSUMO AS " + """" + "CONSUMO" + """" + " GROUP BY CONSUMO.IMOVEL"
   Else
   SQL = "SELECT " + """" + a + """" + "." + """" + b + """" + "," + """" + " SUM(" + """" + a + """" + "." + """" + a + """" + ")/COUNT(" + """" + a + """" + "." + """" + a + """" + ") AS " + """" + "MEDIA_CONS" + """" + " FROM " + """" + a + """" + " AS " + """" + "CONSUMO" + """" + " GROUP BY " + """" + a + """" + "." + """" + b + """" + ""
   End If
   
   
   Set rs = Conn.execute(SQL)
   
   Cont = 0
   If rs.EOF = False Then
      Do While Not rs.EOF
         Cont = Cont + 1
         rs.MoveNext
      Loop
      Me.ProgressBar1.Max = Cont + 10
      Me.ProgressBar1.value = 1
      Set rs = Conn.execute(SQL)
      Do While Not rs.EOF
         DoEvents
         Media = Trim(rs!MEDIA_CONS)
         Media = Replace(Media, ",", ".")
         
         ID_IMOVEL = Trim(rs!IMOVEL)
         
         
      a = "NXGS_V_LIG_COM_CONSUMO_MEDIO"
      b = "NRO_LIGACAO"
      c = "CONSUMO_MEDIO"
      

     If frmCanvas.TipoConexao <> 4 Then
         
      Conn.execute ("INSERT INTO NXGS_V_LIG_COM_CONSUMO_MEDIO (NRO_LIGACAO,CONSUMO_MEDIO) VALUES ('" & ID_IMOVEL & "'," & Media & ")")
     
     Else
     
       Conn.execute ("INSERT INTO " + """" + a + """" + " (" + """" + b + """" + "," + """" + c + """" + ") VALUES ('" & ID_IMOVEL & "'," & Media & ")")
     End If
         
         Me.ProgressBar1.value = Me.ProgressBar1.value + 1
         
         rs.MoveNext
      
      Loop
   End If
   
   Me.ProgressBar1.Visible = False

Trata_Erro:
If Err.Number = 0 Or Err.Number = 20 Then
   Resume Next
ElseIf Err.Number = "-2147217900" Or Err.Number = "-2147217913" Then
   Resume Next
Else
   MsgBox Err.Number & " - " & Err.Description
   Resume Next
End If

End Function

Private Sub optAtualizaConsumo_Click()
   Frame1.Enabled = False
End Sub

Private Sub optDistDem_Click()
   Frame1.Enabled = False
End Sub


Private Sub optImpMedAtuConsDistDem_Click()
   Frame1.Enabled = True
End Sub




    '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   '
   'O PROCEDIMENTO DE TRANSFERIR A DEMANDA DO N� PARA O N� VIZINHO CASO ESTE SEJA V�LVULA,BOMBA OU RESERVAT�RIO
   'QUE EST� ABAIXO FOI COMENTADO AP�S VERIFICAR COM PINHEIRO QUE ESTE PROCEDIMENTO N�O SEJA NECESS�RIO


''
''   'SELECIONA-SE TODOS OS N�S QUE S�O DO TIPO VALVULA OU BOMBA OU RESERVATORIO QUE A DEMANDA SEJA MAIOR QUE ZERO
''   strSQL = "SELECT OBJECT_ID_,DEMAND FROM WATERCOMPONENTS WHERE ID_TYPE IN ( SELECT ID_TYPE FROM WATERCOMPONENTSTYPES WHERE DESCRIPTION_ IN ('VRP','BOMBA','REGISTRO')) AND DEMAND > 0 ORDER BY ID_TYPE"
''   Set rsWTC = Conn.execute(strSQL)
''
''   'RETORNA: | OBJECT_ID_ | DEMAND
''
''   If rsWTC.EOF = False Then
''      Do While Not rsWTC.EOF = True
''         Set rsWATER = Conn.execute("SELECT INITIALCOMPONENT, FINALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT = " & rsWTC!Object_id_)
''         If rsWATER.EOF = False Then ' PELO N� INICIAL, ACHEI O N� FINAL... QUE RECEBE A DEMANDA
''
''            Final = rsWATER!FINALCOMPONENT
''            strConsumo = Replace(rsWTC!DEMAND, ",", ".")
''            strSQL = "UPDATE WATERCOMPONENTS SET DEMAND = DEMAND + " & strConsumo & " WHERE OBJECT_ID_ = '" & Final & "'"
''
''         Else
''            Set rsWATER = Conn.execute("SELECT INITIALCOMPONENT, FINALCOMPONENT FROM WATERLINES WHERE FINALCOMPONENT = " & rsWTC!Object_id_)
''            If rsWATER.EOF = False Then ' PELO N� FINAL, ACHEI O N� INICIAL... QUE RECEBE A DEMANDA
''
''               Inicial = rsWATER!INITIALCOMPONENT
''               strConsumo = Replace(rsWTC!DEMAND, ",", ".")
''               strSQL = "UPDATE WATERCOMPONENTS SET DEMAND = DEMAND + " & strConsumo & " WHERE OBJECT_ID_ = '" & Inicial & "'"
''            Else
''               MsgBox ""
''            End If
''
''         End If
''
''         Conn.execute (strSQL) 'EXECUTA O COMANDO DO UPDATE ACIMA
''
''         strSQL = "UPDATE WATERCOMPONENTS SET DEMAND = 0 WHERE OBJECT_ID_ = '" & rsWTC!Object_id_ & "'"
''         Conn.execute (strSQL) 'ZERA O VALOR DE DEMANDA DA VALVULA, BOMBA OU RESERVATORIO QUE ESTAVA EM AN�LISE
''
''         rsWTC.MoveNext
''      Loop
''   End If
''
''
''   'PODE OCORRER DE UM N� DO TIPO V�LVULA OU BOMBA OU RESERVATORIO TER SIDO ATUALIZADO COM O VALOR DE SEU VIZINHO ..
''
''   'INICIA-SE UM NOVO PROCESSO, ESPEC�FICO NOS COMPONENTES DO TIPO V�LVULA OU BOMBA OU RESERVATORIO
''   'VERIFICANDO SE AINDA H� V�LVULA OU BOMBA OU RESERVATORIO COM VALORES MAIORES QUE ZERO NA DEMANDA
''   strSQL = "SELECT OBJECT_ID_,DEMAND FROM WATERCOMPONENTS WHERE ID_TYPE IN ( SELECT ID_TYPE FROM WATERCOMPONENTSTYPES WHERE DESCRIPTION_ IN ('VRP','BOMBA','REGISTRO')) AND DEMAND > 0 ORDER BY ID_TYPE"
''   Set rsWTC = Conn.execute(strSQL)
''
''   'RETORNA: | OBJECT_ID_ | DEMAND
''
''   If rsWTC.EOF = False Then
''      Do While Not rsWTC.EOF = True
''         'SELECT INITIALCOMPONENT, FINALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT = 302
''         strSQL = "SELECT INITIALCOMPONENT, FINALCOMPONENT FROM WATERLINES WHERE INITIALCOMPONENT = " & rsWTC!Object_id_
''         Set rsCon = Conn.execute(strSQL)
''         If rsCon.EOF = False Then
''            Do While Not rsCon.EOF = True
''               '--PELO COMPONENTE 302 ACHEI O 298
''               '--PESQUISA SE ELE � UM COMPONENTE V�LIDO PARA RECEBER A DEMANDA, OU SEJA DIFERENTE DE 'VRP','BOMBA','REGISTRO'
''               strSQL = "SELECT * FROM WATERCOMPONENTS WHERE OBJECT_ID_ = " & rsCon!FINALCOMPONENT & " AND ID_TYPE NOT IN ( SELECT ID_TYPE FROM WATERCOMPONENTSTYPES WHERE DESCRIPTION_ IN ('VRP','BOMBA','REGISTRO'))"
''               Set rsCon = Conn.execute(strSQL)
''               '--CASO O SELECT ACIMA RETORNE VALORES, O COMPONENTE 298 RECEBE A DEMANDA DO COMPONENTE 302, SE N�O PESQUISA DE NOVO USANDO O 302 COMO FINALCOMPONENT
''               If rsCon.EOF = False Then
''
''                  strConsumo = Replace(rsWTC!DEMAND, ",", ".")
''                  strSQL = "UPDATE WATERCOMPONENTS SET DEMAND = DEMAND + " & strConsumo & " WHERE OBJECT_ID_ = '" & rsCon!Object_id_ & "'"
''                  Conn.execute (strSQL) 'EXECUTA O COMANDO DO UPDATE ACIMA
''
''                  strSQL = "UPDATE WATERCOMPONENTS SET DEMAND = 0 WHERE OBJECT_ID_ = '" & rsWTC!Object_id_ & "'"
''                  Conn.execute (strSQL) 'ZERA O VALOR DE DEMANDA DA VALVULA, BOMBA OU RESERVATORIO QUE ESTAVA EM AN�LISE
''                  Exit Do
''
''               End If
''               If rsCon.EOF = False Then
''                  rsCon.MoveNext
''               Else
''                  'NENHUM VIZINHO DO PONTO � V�LIDO
''               End If
''            Loop
''         Else
''            'PROCURA POR INICIALCOMPONENT
''            'SELECT INITIALCOMPONENT, FINALCOMPONENT FROM WATERLINES WHERE FINALCOMPONENT = 302
''            strSQL = "SELECT INITIALCOMPONENT, FINALCOMPONENT FROM WATERLINES WHERE FINALCOMPONENT = " & rsWTC!Object_id_
''            Set rsCon = Conn.execute(strSQL)
''            If rsCon.EOF = False Then
''               Do While Not rsCon.EOF = True
''                  '--PESQUISA SE ELE � UM COMPONENTE V�LIDO PARA RECEBER A DEMANDA, OU SEJA DIFERENTE DE 'VRP','BOMBA','REGISTRO'
''                  strSQL = "SELECT * FROM WATERCOMPONENTS WHERE OBJECT_ID_ = " & rsCon!INITIALCOMPONENT & " AND ID_TYPE NOT IN ( SELECT ID_TYPE FROM WATERCOMPONENTSTYPES WHERE DESCRIPTION_ IN ('VRP','BOMBA','REGISTRO'))"
''                  Set rsCon = Conn.execute(strSQL)
''                  '--CASO O SELECT ACIMA RETORNE VALORES, O COMPONENTE 298 RECEBE A DEMANDA DO COMPONENTE 302, SE N�O PESQUISA DE NOVO USANDO O 302 COMO INITIALCOMPONENT
''                  If rsCon.EOF = False Then
''
''                     strConsumo = Replace(rsWTC!DEMAND, ",", ".")
''                     strSQL = "UPDATE WATERCOMPONENTS SET DEMAND = DEMAND + " & strConsumo & " WHERE OBJECT_ID_ = '" & rsCon!Object_id_ & "'"
''                     Conn.execute (strSQL) 'EXECUTA O COMANDO DO UPDATE ACIMA
''
''                     strSQL = "UPDATE WATERCOMPONENTS SET DEMAND = 0 WHERE OBJECT_ID_ = '" & rsWTC!Object_id_ & "'"
''                     Conn.execute (strSQL) 'ZERA O VALOR DE DEMANDA DA VALVULA, BOMBA OU RESERVATORIO QUE ESTAVA EM AN�LISE
''                     Exit Do
''
''                  End If
''                  If rsCon.EOF = False Then
''                     rsCon.MoveNext
''                  Else
''                     'NENHUM VIZINHO DO PONTO � V�LIDO
''                  End If
''               Loop
''            End If
''         End If
''
''         rsWTC.MoveNext
''
''      Loop
''
''   End If
''
''   'AO FIM DESSE PROCESSO, SE AINDA EXISTEM COMPONENTES DO TIPO V�LVULA OU BOMBA OU RESERVATORIO COM VALOR DE DEMANDA
''   'ISSO QUER DIZER QUE PROV�VELMENTE H� UM ERRO NO CADASTRO DOS COMPONENTES
''
''   strSQL = "SELECT OBJECT_ID_,DEMAND FROM WATERCOMPONENTS WHERE ID_TYPE IN ( SELECT ID_TYPE FROM WATERCOMPONENTSTYPES WHERE DESCRIPTION_ IN ('VRP','BOMBA','REGISTRO')) AND DEMAND > 0 ORDER BY ID_TYPE"
''   Set rsWTC = Conn.execute(strSQL)
''
''   'RETORNA: | OBJECT_ID_ | DEMAND
''
''   If rsWTC.EOF = False Then
''      Do While Not rsWTC.EOF = True
''         MsgBox "VERIFICAR O COMPONENTE: " & rsWTC!Object_id_
''         rsWTC.MoveNext
''      Loop
''   Else
''      MsgBox "Demandas de consumo atualizadas com sucesso!", vbExclamation, ""
''   End If

   'MsgBox "Demandas de consumo atualizadas com sucesso!", vbExclamation, ""


