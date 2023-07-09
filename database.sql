USE [collector]
GO
/****** Object:  Table [dbo].[tenant]    Script Date: 7/9/2023 5:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tenant](
	[tenant_id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](1024) NOT NULL,
	[tenant_key] [uniqueidentifier] NOT NULL,
	[is_enabled] [bit] NOT NULL,
	[date_created] [datetime] NOT NULL,
	[date_modified] [datetime] NOT NULL,
 CONSTRAINT [PK_tenant] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tenant_user]    Script Date: 7/9/2023 5:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tenant_user](
	[tenant_user_id] [bigint] IDENTITY(1,1) NOT NULL,
	[email_address] [nvarchar](1024) NOT NULL,
	[tenant_id] [bigint] NOT NULL,
	[tenant_user_key] [uniqueidentifier] NOT NULL,
	[is_enabled] [bit] NOT NULL,
	[date_created] [datetime2](7) NOT NULL,
	[date_modified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_tenant_user] PRIMARY KEY CLUSTERED 
(
	[tenant_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tenant] ADD  CONSTRAINT [DF_tenant_tenant_key]  DEFAULT (newsequentialid()) FOR [tenant_key]
GO
ALTER TABLE [dbo].[tenant] ADD  CONSTRAINT [DF_tenant_is_enabled]  DEFAULT ((1)) FOR [is_enabled]
GO
ALTER TABLE [dbo].[tenant] ADD  CONSTRAINT [DF_tenant_date_created]  DEFAULT (getutcdate()) FOR [date_created]
GO
ALTER TABLE [dbo].[tenant] ADD  CONSTRAINT [DF_tenant_date_modified]  DEFAULT (getutcdate()) FOR [date_modified]
GO
ALTER TABLE [dbo].[tenant_user] ADD  CONSTRAINT [DF_tenant_user_tenant_user_key]  DEFAULT (newsequentialid()) FOR [tenant_user_key]
GO
ALTER TABLE [dbo].[tenant_user] ADD  CONSTRAINT [DF_tenant_user_date_created]  DEFAULT (getutcdate()) FOR [date_created]
GO
ALTER TABLE [dbo].[tenant_user] ADD  CONSTRAINT [DF_tenant_user_date_modified]  DEFAULT (getutcdate()) FOR [date_modified]
GO
ALTER TABLE [dbo].[tenant_user]  WITH CHECK ADD  CONSTRAINT [FK_tenant_user_tenant] FOREIGN KEY([tenant_id])
REFERENCES [dbo].[tenant] ([tenant_id])
GO
ALTER TABLE [dbo].[tenant_user] CHECK CONSTRAINT [FK_tenant_user_tenant]
GO
