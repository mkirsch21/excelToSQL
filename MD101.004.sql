------------------------------------------------------------
-- DB_Change_ID:    MD101.004
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

SET @ScriptID = 'MD101.004';
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

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_type where code = 'CORP')

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_type where code = 'IIT')

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_type where code = 'ALC')

SET IDENTITY_INSERT dbo.r_account_type OFF

SET IDENTITY_INSERT dbo.r_account_subtype ON

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_subtype where code = 'ALCDIRWINE')

SET IDENTITY_INSERT dbo.r_account_subtype OFF

SET IDENTITY_INSERT dbo.r_account_status ON

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_status where code = 'CLOSED')

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_status where code = 'HOLD')

IF NOT EXISTS(SELECT 1 FROM dbo.r_account_status where code = 'OPEN')

SET IDENTITY_INSERT dbo.r_account_status OFF

SET IDENTITY_INSERT dbo.r_acc_close_rsn_x_acc_type ON

IF NOT EXISTS(SELECT 1 FROM dbo.r_acc_close_rsn_x_acc_type where  account_close_reason_key = 500008 and account_type_key = 12 and acount_subtype_key = NULL)

IF NOT EXISTS(SELECT 1 FROM dbo.r_acc_close_rsn_x_acc_type where  account_close_reason_key = 500009 and account_type_key = 500001 and acount_subtype_key = 900001)

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