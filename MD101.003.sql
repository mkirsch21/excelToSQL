------------------------------------------------------------
-- DB_Change_ID:    MD101.003
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

SET @ScriptID = 'MD101.003';
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

SET IDENTITY_INSERT dbo.r_account_status ON

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_status where code = 'CLOSED')INSERT INTO dbo.r_account_status(account_status_key, code, desc_short, desc_long, sequence_pos, filter_mask, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, is_closed)VALUES(2, 'CLOSED', 'CLOSED', 'CLOSED', 7, 0, 1, GETDATE(), 0, GETDATE(), 0, 2, 1)

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_status where code = 'HOLD')INSERT INTO dbo.r_account_status(account_status_key, code, desc_short, desc_long, sequence_pos, filter_mask, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, is_closed)VALUES(9, 'HOLD', 'HOLD', 'FILED RETURN BUT NOT REGISTERED (FEE NOT PAID)', 0, 0, 1, GETDATE(), 0, GETDATE(), 0, 1, 0)

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_status where code = 'OPEN')INSERT INTO dbo.r_account_status(account_status_key, code, desc_short, desc_long, sequence_pos, filter_mask, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, is_closed)VALUES(12, 'OPEN', 'OPEN', 'OPEN', 1, 0, 1, GETDATE(), 0, GETDATE(), 0, 2, 0)

SET IDENTITY_INSERT dbo.r_account_status OFF


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
