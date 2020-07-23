------------------------------------------------------------
-- DB_Change_ID:    MD101.006
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

SET @ScriptID = 'MD101.006';
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

IF EXISTS(SELECT 1 FROM dbo.r_account_subtype WHERE code = 'ALCDIRWINE')UPDATE dbo.r_account_subtype SET desc_short = 'DIRECT WINE SHIPPER', desc_long = 'DIRECT WINE SHIPPER', sequence_pos = 0, active_flag = 1, updated_dttm = GETDATE(), updated_by = 0, core = 9, req_account_schedule_flag = 1, is_external = 1WHERE code = 'ALCDIRWINE'


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
