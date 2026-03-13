unmanaged implementation in class /exedminb/cl_i_nfemonitorlogh unique;
strict ( 2 ); auxiliary class /exedminb/cl_nfe_inb_processor;

define behavior for /EXEDMINB/I_NFEMONITORLOGH alias _NFeMonitorH
lock master authorization master ( instance, global )
{
  field ( readonly ) ChaveNFe, Atividade, AtividadeDescricao, BusinessPlaceName, CompanyCodeName, DataEmissao, Delivery, Destinatario, DANFE,
  Emitente, Empresa, Fatura, EntradaMercadoria, LocalDeNegocio, NomeDestinatario, NomeEmitente, NumeroNFe, ProcessoSAP, Serie, Status, StatusCriticality,
  StatusNFe, StatusNFeDescricao, ValorFrete, ValorOutrasDesp, ValorSeguro, ValorTotalICMS, ValorTotalICMSST, ValorTotalIPI, ValorTotalNFe, moeda;

  update;

  action etapa_700;
  action etapa_800;

  side effects
  {
    entity _Delivery affects entity _Historico;
    action etapa_700 affects entity _Historico;
    action etapa_800 affects entity _Historico;
  }

  association _Item;
  association _Delivery;
  association _Historico;
  association _Files;
}

define behavior for /EXEDMINB/I_NFEMONITORLOGI alias _NFeMonitorI
lock dependent by _Header
authorization dependent by _Header
{
  create ( authorization : global );
  update;
  internal delete;
  field ( readonly )
  ChaveNFe, ItemNFe, ItemIdDiv, Plant, Material, DescricaoMaterial, NCM, UnidadeMedidaXML, Pedido, ItemPedido, PedidoItem,
  CFOP, ValorUnitario, UnidadeMedida, ValorICMS, AliquotaICMS, AliquotaIPI, ValorIPI, DescricaoMaterialFornecedor;


  side effects
  {
    field Pedido affects field ItemPedido;
  }

  association _Header;
}

define behavior for /EXEDMINB/I_NFEMINBDELIVERY alias _NFeMonitorDelivery
lock dependent by _Header
authorization dependent by _Header
{

  update;
  field ( readonly )
  ChaveNFe, Delivery, DeliveryDocumentItem, DeliveryDocumentItemText, DataRemessa, Material, Plant,
  DeliveryQuantityUnit, OriginalDeliveryQuantity, PurchaseOrder, PurchaseOrderItem;

  association _Header;

}