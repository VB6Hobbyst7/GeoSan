/****** Script for SelectTopNRows command from SSMS  ******/
SELECT OBJECT_ID_
		,WATERCOMPONENTSDATA.ID_TYPE as a
		,WaterComponentsTypes.Description_
		,WaterComponentsTypes.Specification_
		,WATERCOMPONENTSDATA.ID_SUBTYPE
		,WaterComponentsSubTypes.WaterComponentsSubTypes
		,WaterComponentsSubTypes.Description_
		,WaterComponentsSubTypes.Selection_
		,watercomponentsdata.VALUE_
		,case when WaterComponentsSubTypes.Selection_ = 1 and watercomponentsdata.VALUE_ = 2 then 'Closed' 
		      when WaterComponentsSubTypes.Selection_ = 1 and watercomponentsdata.VALUE_ = 1 then 'Open' 
		      else 'sem influência' end as situreg
		
		
		
	FROM WATERCOMPONENTSDATA
	left join WaterComponentsTypes on WATERCOMPONENTSDATA.ID_TYPE = WaterComponentsTypes.id_Type
	left join WaterComponentsSubTypes on WATERCOMPONENTSDATA.ID_SUBTYPE = WaterComponentsSubTypes.WaterComponentsSubTypes and WATERCOMPONENTSDATA.ID_TYPE = WaterComponentsSubTypes.id_type
	
XXXXXXXXXXXXXXXXXXXXXXX
	
Retorna todos os nós, precisa terminar de validar o select case. Retorna um pouco mais de registros se a base não estiver validada	
	
select * 
,case when watercomponentsdata.id_subtype = 1 and watercomponentsdata.id_type = 27 and watercomponentsdata.value_ = 1 then 'Aberto' 
		      when watercomponentsdata.id_subtype = 2 and watercomponentsdata.id_type = 27 and watercomponentsdata.value_ = 1 then 'Fechado' 
		      when watercomponentsdata.id_subtype = 0 and watercomponentsdata.id_type = 27 and watercomponentsdata.value_ = 1 then 'Desconhecido'
		      else 'Sem influência' end as situreg


from watercomponents
     left join watercomponentsTypes on watercomponentstypes.id_type = watercomponents.id_type
     left join watercomponentsdata on watercomponentsdata.object_id_ = watercomponents.object_id_
	 
	 order by watercomponentsdata.id_type, watercomponentsdata.id_subtype
	 
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx

Esta querie está sendo utilizada para obter todas as componentes, mas falta a parte do id_subtype que indica se
a válvula está aberta ou fechada, ou mesmo se existe o número associado a mesma

select 	watercomponents.object_id_
	,watercomponents.id_type
	,watercomponents.state
	,watercomponents.location
	,watercomponents.groundheight
	,watercomponents.notes
	,watercomponents.demand
	,watercomponents.dateinstallation
	,watercomponents.component_id
	,watercomponentsTypes.description_
	,watercomponentsTypes.specification_
	,watercomponentsdata.Id_subtype
	,watercomponentsdata.Value_
from watercomponents
     left join watercomponentsTypes on watercomponentstypes.id_type = watercomponents.id_type
     left join watercomponentsdata on watercomponentsdata.object_id_ = watercomponents.object_id_
order by watercomponents.id_type