FUNCTION ZAS_008_FM_MLZMEINFO.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_MATNR) TYPE  MATNR OPTIONAL
*"  CHANGING
*"     VALUE(CS_MLZMEINFO) TYPE  ZAS_GIT_009_S_MLZMEINFO OPTIONAL
*"     VALUE(CT_MLZMEINFO) TYPE  ZAS_GIT_009_TT_MLZMEINFO2 OPTIONAL
*"     VALUE(CS_MLZMEINFORTRN) TYPE  ZAS_GIT_009_SS_MLZMEINFO3
*"         OPTIONAL
*"--------------------------------------------------------------------

  SELECT SINGLE mara~matnr,
                makt~maktx,
                mara~mtart,
                mara~meins
    FROM mara
    INNER JOIN makt ON makt~matnr EQ mara~matnr
    WHERE mara~matnr EQ @iv_matnr
    INTO @CS_MLZMEINFO.

  SELECT mard~werks,
         mard~lgort,
         mard~labst
    FROM mard
    WHERE mard~matnr EQ @iv_matnr
    INTO TABLE @CT_MLZMEINFO.

  IF sy-subrc IS NOT INITIAL.
    CS_MLZMEINFOrtrn = VALUE #( resultcode = '1'
                                resultdesc = 'Malzeme Numarasına Ait Bulunamıyor. '
                                resulttype = 'Error' ).
  ELSE.
    CS_MLZMEINFOrtrn = VALUE #( resultcode = '0'
                                resultdesc = 'İşlem Başarılı '
                                resulttype = 'Success' ).
  ENDIF.


ENDFUNCTION.
