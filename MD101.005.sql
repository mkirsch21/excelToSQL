------------------------------------------------------------
-- DB_Change_ID:    MD101.005
-- DB_ASSET:        EI
-- DB_RPE_VER:      V3_12_02_02
------------------------------------------------------------
DECLARE @ErrorCount INT;
DECLARE @ShouldApply VARCHAR(5);
DECLARE @ScriptID VARCHAR(30);
DECLARE @NA VARCHAR(16)
DECLARE @RPVer VARCHAR(16);
DECLARE @Asset VARCHAR(30);
SET @NA = 'NA'

SET @ScriptID = 'MD101.005';
SET @Asset = 'EI';
SET @RPVer = 'V3_12_02_02';

EXEC Usp_geterrorcount @ScriptID, @ErrorCount OUTPUT

IF (@ErrorCount = 0)
BEGIN
  EXEC usp_ShouldApplyScript @ScriptID, @ShouldApply OUTPUT
  IF (@ShouldApply='TRUE')
    BEGIN TRY
      BEGIN

------------------------------------------------------------
-- This is where your script goes

IF EXISTS(SELECT 1 FROM dbo.r_account_type WHERE code = 'CORP')UPDATE dbo.r_account_type SET desc_short = 'CORPORATE INCOME TAX', desc_long = 'CORPORATE INCOME TAX', global_address_flag = 1, view_image_enable_flag = 0, collection_threshold_amount = '15.0000', sequence_pos = 2, active_flag = 1, updated_dttm = GETDATE(), updated_by = 0, core = 2, requires_juris_loc_flag = 0, is_external = 1, addr_change_service_req_flag = NULL, pft_juris_loc_rollup = 0, requires_bond_flag = 0, external_offset_flag = 1, internal_offset_flag = 1, requires_county_flag = 1, refund_fraud_flag = 0, refund_fraud_threshold_amt = '0.0000'WHERE code = 'CORP'

IF EXISTS(SELECT 1 FROM dbo.r_account_type WHERE code = 'IIT')UPDATE dbo.r_account_type SET desc_short = 'INDIV INCOME TAX', desc_long = 'INDIVIDUAL INCOME TAX', global_address_flag = 1, view_image_enable_flag = 0, collection_threshold_amount = '15.0000', sequence_pos = 7, active_flag = 1, updated_dttm = GETDATE(), updated_by = 0, core = 2, requires_juris_loc_flag = 0, is_external = 1, addr_change_service_req_flag = NULL, pft_juris_loc_rollup = 0, requires_bond_flag = 0, external_offset_flag = 1, internal_offset_flag = 1, requires_county_flag = 1, refund_fraud_flag = 1, refund_fraud_threshold_amt = '100.0000'WHERE code = 'IIT'

IF EXISTS(SELECT 1 FROM dbo.r_account_type WHERE code = 'ALC')UPDATE dbo.r_account_type SET desc_short = 'ALCOHOL BEVERAGE TAX', desc_long = 'ALCOHOL BEVERAGE TAX', global_address_flag = 1, view_image_enable_flag = 0, collection_threshold_amount = '15.0000', sequence_pos = 15, active_flag = 1, updated_dttm = GETDATE(), updated_by = 0, core = 9, requires_juris_loc_flag = 0, is_external = 1, addr_change_service_req_flag = NULL, pft_juris_loc_rollup = 0, requires_bond_flag = 0, external_offset_flag = 1, internal_offset_flag = 1, requires_county_flag = 1, refund_fraud_flag = 1, refund_fraud_threshold_amt = '0.0000'WHERE code = 'ALC'


-- End of your script
------------------------------------------------------------

        EXEC usp_HandleScriptApplied @ScriptID, @Asset, @NA, @NA, @NA, @RPVer, @NA, @NA;
      END
    END TRY
    BEGIN CATCH
      EXEC usp_HandleErrorApplyingScript @ScriptID,@Asset,@NA,@NA,@NA,@RPVer,@NA,@NA;
    END CATCH;
  ELSE
    BEGIN
      PRINT 'Skipping previously applied script: '+@ScriptID+'. Please refer DB_CHANGE_ID in DATABASE_UPDATES table.';
    END
END
ELSE
      PRINT 'Skipping script: '+@ScriptID+'. Previous error detected.';
GO
