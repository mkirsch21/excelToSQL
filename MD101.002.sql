------------------------------------------------------------
-- DB_Change_ID:    MD101.002
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

SET @ScriptID = 'MD101.002';
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

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_subtype where code = 29)INSERT INTO dbo.r_account_subtype(account_subtype_key, account_type_key, code, desc_short, desc_long, sequence_pos, active_flag, created_dttm, created_by, updated_dttm, updated_by, core, req_account_schedule_flag, is_external)VALUES(1, 29, 'IIT', 'Individual Income', 'Individual Income', 0, 1, GETDATE(), 0, GETDATE(), 0, 9, 1, 1)

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
