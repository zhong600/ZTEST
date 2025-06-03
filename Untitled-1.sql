CREATE OR REPLACE PROCEDURE "AEAU_DEMO_REFRESH_TRIGGER"()
RETURNS FLOAT
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
var errorText="";
try {

// check to see if table has been refreshed
var sql_command  = " SELECT case when SYSTEM$LAST_CHANGE_COMMIT_TIME(''CLIENT_AUSTRALIA.AE_SHARE.VW_TBL_ATTRS_DEMO'') " ;
sql_command += " <> (SELECT TOP 1 LAST_CHANGE_COMMIT_TIME FROM TEAM_AUTOMATION.LOGS.LOAD_LOG_AU  WHERE TABLE_NAME = ''TBL_ATTRS_DEMO'' ";
sql_command += " ORDER BY LOAD_START_TIME DESC) then 1 else 0 end as UpdateResult  ";

return UpdateResult; 

}
catch (err) {
               var errorText =  err.message.replace(/(\\r\\n|\\n|\\r)/gm, " - ").replace(/''/g,'''');
               return errorText; 
            }

';