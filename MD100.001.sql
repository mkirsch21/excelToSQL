------------------------------------------------------------
-- DB_Change_ID:    MD100.001
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

SET @ScriptID = 'MD100.001';
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

SET IDENTITY_INSERT dbo.r_account_type ON

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_type where code = 'CORP')INSERT INTO dbo.r_account_type(account_type_key, code, desc_short, desc_long, global_address_flag, view_image_enable_flag, collection_threshold_amount, sequence_pos, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, requires_juris_loc_flag, is_external, addr_change_service_req_flag, pft_juris_loc_rollup, requires_bond_flag, external_offset_flag, internal_offset_flag, requires_county_flag, refund_fraud_flag, refund_fraud_threshold_amt)VALUES(12, 'CORP', 'CORPORATE INCOME TAX', 'CORPORATE INCOME TAX', 1, 0, '15.0000', 2, 1, GETDATE(), 0, GETDATE(), 0, 2, 0, 1, NULL, 0, 0, 1, 1, 1, 0, '0.0000')

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_type where code = 'IIT')INSERT INTO dbo.r_account_type(account_type_key, code, desc_short, desc_long, global_address_flag, view_image_enable_flag, collection_threshold_amount, sequence_pos, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, requires_juris_loc_flag, is_external, addr_change_service_req_flag, pft_juris_loc_rollup, requires_bond_flag, external_offset_flag, internal_offset_flag, requires_county_flag, refund_fraud_flag, refund_fraud_threshold_amt)VALUES(29, 'IIT', 'INDIV INCOME TAX', 'INDIVIDUAL INCOME TAX', 1, 0, '15.0000', 7, 1, GETDATE(), 0, GETDATE(), 0, 2, 0, 1, NULL, 0, 0, 1, 1, 1, 1, '100.0000')

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_type where code = 'ALC')INSERT INTO dbo.r_account_type(account_type_key, code, desc_short, desc_long, global_address_flag, view_image_enable_flag, collection_threshold_amount, sequence_pos, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, requires_juris_loc_flag, is_external, addr_change_service_req_flag, pft_juris_loc_rollup, requires_bond_flag, external_offset_flag, internal_offset_flag, requires_county_flag, refund_fraud_flag, refund_fraud_threshold_amt)VALUES(500001, 'ALC', 'ALCOHOL BEVERAGE TAX', 'ALCOHOL BEVERAGE TAX', 1, 0, '15.0000', 15, 1, GETDATE(), 0, GETDATE(), 0, 9, 0, 1, NULL, 0, 0, 1, 1, 1, 1, '0.0000')

SET IDENTITY_INSERT dbo.r_account_type OFF

SET IDENTITY_INSERT dbo.r_account_subtype ON

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_subtype where code = 'ALCDIRWINE')INSERT INTO dbo.r_account_subtype(account_subtype_key, account_type_key, code, desc_short, desc_long, sequence_pos, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, req_account_schedule_flag, is_external)VALUES(900001, 500001, 'ALCDIRWINE', 'DIRECT WINE SHIPPER', 'DIRECT WINE SHIPPER', 0, 1, GETDATE(), 0, GETDATE(), 0, 9, 1, 1)

SET IDENTITY_INSERT dbo.r_account_subtype OFF

SET IDENTITY_INSERT dbo.r_account_status ON

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_status where code = 'CLOSED')INSERT INTO dbo.r_account_status(account_status_key, code, desc_short, desc_long, sequence_pos, filter_mask, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, is_closed)VALUES(2, 'CLOSED', 'CLOSED', 'CLOSED', 7, 0, 1, GETDATE(), 0, GETDATE(), 0, 2, 1)

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_status where code = 'HOLD')INSERT INTO dbo.r_account_status(account_status_key, code, desc_short, desc_long, sequence_pos, filter_mask, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, is_closed)VALUES(9, 'HOLD', 'HOLD', 'FILED RETURN BUT NOT REGISTERED (FEE NOT PAID)', 0, 0, 1, GETDATE(), 0, GETDATE(), 0, 1, 0)

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_status where code = 'OPEN')INSERT INTO dbo.r_account_status(account_status_key, code, desc_short, desc_long, sequence_pos, filter_mask, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, is_closed)VALUES(12, 'OPEN', 'OPEN', 'OPEN', 1, 0, 1, GETDATE(), 0, GETDATE(), 0, 2, 0)

SET IDENTITY_INSERT dbo.r_account_status OFF

SET IDENTITY_INSERT dbo.r_acc_close_rsn_x_acc_type ON

IF NOT EXISTS(SELECT 1 FROM dbo.r_acc_close_rsn_x_acc_type where  account_close_reason_key = 500008 and account_type_key = 12 and acount_subtype_key = NULL)INSERT INTO dbo.r_acc_close_rsn_x_acc_type(acc_close_rsn_x_acc_type_key, account_close_reason_key, account_type_key, acount_subtype_key, active_flag, created_dttm, created_by, updated_dttm, updated_by, core)VALUES(900005, 500008, 12, NULL, 1, GETDATE(), 0, GETDATE(), 0, 8)

IF NOT EXISTS(SELECT 1 FROM dbo.r_acc_close_rsn_x_acc_type where  account_close_reason_key = 500009 and account_type_key = 500001 and acount_subtype_key = 900001)INSERT INTO dbo.r_acc_close_rsn_x_acc_type(acc_close_rsn_x_acc_type_key, account_close_reason_key, account_type_key, acount_subtype_key, active_flag, created_dttm, created_by, updated_dttm, updated_by, core)VALUES(900359, 500009, 500001, 900001, 1, GETDATE(), 0, GETDATE(), 0, 9)

SET IDENTITY_INSERT dbo.r_acc_close_rsn_x_acc_type OFF


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
