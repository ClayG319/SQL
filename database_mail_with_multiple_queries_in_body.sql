DECLARE @databasename VARCHAR(200) = (<Query to return database selected>)
      , @FailedStep sysname
      , @Message NVARCHAR(4000);

SELECT   TOP 1 @FailedStep = [jh].[step_name]
       , @Message = [jh].[message]
FROM     [msdb].[dbo].[sysjobs] [j]
INNER JOIN [msdb].[dbo].[sysjobhistory] [jh] ON [j].[job_id] = [jh].[job_id]
WHERE    [jh].[sql_severity] > 0
ORDER BY [jh].[run_date] DESC
       , [jh].[run_time] DESC;

DECLARE @emailmessage NVARCHAR(4000) = 'The job failed on step "' + @FailedStep + '", while ' + @databasename + ' was selected to be restored.';

SET @emailmessage += CHAR(13) + CHAR(13) + 'The error message is:' + CHAR(13) + @Message; 

EXEC [msdb].[dbo].[sp_send_dbmail] @profile_name = '<Profile name>'
                                 , @recipients = '<Recipient email address'
                                 , @subject = '<Email subject>'
                                 , @body = @emailmessage;
