   method eliminar_item.
     if it_keys is initial.
       "Raise Error
       exit.
     endif.

     read entities of /exedminb/i_nfemonitorh
       in local mode
       entity _nfemonitori
       all fields
       with value #( ( %tky = it_keys[ 1 ]-%tky ) )
       result data(lt_nfe_item_data).

     if lt_nfe_item_data is initial.
       "Raise Error
       exit.
     endif.

     data(ls_nfe_item_data) = lt_nfe_item_data[ 1 ].

     read entities of /exedminb/i_nfemonitorh
       in local mode
       entity _nfemonitori
       all fields
       with value #( ( ChaveNFe = ls_nfe_item_data-ChaveNFe
                       ItemNFe = ls_nfe_item_data-ItemNFe ) )
       result data(lt_nfe_all_itens).

     "Se n encontrou, ou tem apenas 1, tem algo errado com a chave
     if lines( lt_nfe_all_itens ) between 0 and 1.
       "Raise Error
       exit.

       "Se possui 2 linhas, exclui as  duas para na busca pegar a original da NFe
     elseif lines( lt_nfe_all_itens ) eq 2.
       modify entity in local mode /exedminb/i_nfemonitori
         delete from corresponding #( lt_nfe_all_itens ).

       "Se possuir mais de 2, exclui a selecionada e redistribui a qtd para o primeiro item
     else.
       modify entity in local mode /exedminb/i_nfemonitori
         delete from value #( ( corresponding #( ls_nfe_item_data ) ) ).

       "Se excluiu a primeira linha, ditribui na segunda
       if line_exists( lt_nfe_all_itens[ ItemIdDiv = cond #( when ls_nfe_item_data-ItemIdDiv = 10 then 20 else 10 ) ] ).
         data(ls_item_div_to_chg) = lt_nfe_all_itens[ ItemIdDiv = cond #( when ls_nfe_item_data-ItemIdDiv = 10 then 20 else 10 ) ].
       else.
         "Raise Error
         exit.
       endif.

       modify entity in local mode /exedminb/i_nfemonitori
         update from value #( (  ChaveNFe = ls_item_div_to_chg-ChaveNFe
                                  ItemNFe = ls_item_div_to_chg-ItemNFe
                                ItemIdDiv = ls_item_div_to_chg-ItemIdDiv
                               Quantidade = ls_item_div_to_chg-Quantidade + ls_nfe_item_data-Quantidade
                                Valoricms = ls_item_div_to_chg-Valoricms + ls_nfe_item_data-Valoricms
                                     Lote = ls_item_div_to_chg-Lote
                                 %control = value #( Quantidade = if_abap_behv=>mk-on
                                                     Lote = if_abap_behv=>mk-on
                                                     Valoricms = if_abap_behv=>mk-on ) ) ).

     endif.

   endmethod.