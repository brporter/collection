CREATE TABLE [dbo].[user]
(
  [id] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
  [key] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID(),
  [email] NVARCHAR(2048) NOT NULL,
  [tenant_id] BIGINT NOT NULL,
  [enabled] BIT NOT NULL DEFAULT 1,
  [date_created] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
  [date_modified] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
  CONSTRAINT FK_user_tenant FOREIGN KEY (tenant_id) REFERENCES [dbo].[tenant] (id) ON DELETE CASCADE
)
