------------------------------------------------------------
-- DB_Change_ID:    MD101.001
-- DB_ASSET:        EI
-- DB_RPE_VER:      V3_12_02_00
------------------------------------------------------------
DECLARE @ErrorCount INT;
DECLARE @ShouldApply VARCHAR(5);
DECLARE @ScriptID VARCHAR(30);
DECLARE @NA VARCHAR(16)
DECLARE @RPVer VARCHAR(16);
DECLARE @Asset VARCHAR(30);
SET @NA = 'NA'

SET @ScriptID = 'MD101.001';
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

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_type where code = 'CORP')INSERT INTO dbo.r_account_type(account_type_key, code, desc_short, desc_long, global_address_flag, view_image_enable_flag, collection_threshold_amount, sequence_pos, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, requires_juris_loc_flag, is_external, addr_change_service_req_flag, pft_juris_loc_rollup, requires_bond_flag, external_offset_flag, internal_offset_flag, requires_county_flag, refund_fraud_flag, refund_fraud_threshold_amt)VALUES(12, 'CORP', 'CORPORATE INCOME TAX', 'CORPORATE INCOME TAX', 1, 0, '15.0000', 2, 1, GETDATE(), 0, GETDATE(), 0, 2, 0, 1, NULL, 0, 0, 1, 1, 1, 0, '0.0000')
IF NOT EXISTS(SELECT 1 FROM dbo.r_account_type where code = 'IIT')INSERT INTO dbo.r_account_type(account_type_key, code, desc_short, desc_long, global_address_flag, view_image_enable_flag, collection_threshold_amount, sequence_pos, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, requires_juris_loc_flag, is_external, addr_change_service_req_flag, pft_juris_loc_rollup, requires_bond_flag, external_offset_flag, internal_offset_flag, requires_county_flag, refund_fraud_flag, refund_fraud_threshold_amt)VALUES(29, 'IIT', 'INDIV INCOME TAX', 'INDIVIDUAL INCOME TAX', 1, 0, '15.0000', 7, 1, GETDATE(), 0, GETDATE(), 0, 2, 0, 1, NULL, 0, 0, 1, 1, 1, 1, '100.0000')

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
