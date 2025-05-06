
/****** Object:  Table [dbo].[GlobalConfigurationHistory]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalConfigurationHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[OragnizationUnitId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NULL,
	[ConfigurationType] [tinyint] NOT NULL,
	[PeriodEnd] [datetime2](7) NOT NULL,
	[PeriodStart] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GlobalConfiguration]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalConfiguration](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[OragnizationUnitId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NULL,
	[ConfigurationType] [tinyint] NOT NULL,
	[PeriodEnd] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
	[PeriodStart] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
 CONSTRAINT [PK_GlobalConfiguration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([PeriodStart], [PeriodEnd])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[GlobalConfigurationHistory])
)
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carrier]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrier](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Name] [nvarchar](100) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NOT NULL,
	[FocalPerson] [nvarchar](100) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NULL,
	[CarrierId] [nvarchar](50) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NOT NULL,
	[SEnr] [bigint] MASKED WITH (FUNCTION = 'default()') NULL,
	[Email] [nvarchar](100) MASKED WITH (FUNCTION = 'email()') NULL,
	[Address1] [nvarchar](255) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[Address2] [nvarchar](255) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[City] [nvarchar](100) NULL,
	[Zipcode] [nvarchar](20) NULL,
	[Phone] [nvarchar](20) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[Mobile1] [nvarchar](20) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[Mobile2] [nvarchar](20) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[Fax] [nvarchar](20) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Carrier] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[DisplayName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerIntegration]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerIntegration](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[ServiceId] [uniqueidentifier] NOT NULL,
	[ContainerId] [uniqueidentifier] NOT NULL,
	[Barcode] [nvarchar](max) NOT NULL,
	[AcknowledgementType] [tinyint] NOT NULL,
	[PayLoad] [nvarchar](max) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[TransferredOn] [datetime] NULL,
	[ErrorDetail] [nvarchar](max) NULL,
	[RetryCount] [tinyint] NOT NULL,
	[Response] [nvarchar](max) NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_CustomerIntegration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DashboardUserBasedJobsSeen]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DashboardUserBasedJobsSeen](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[IsJobViolationSeen] [bit] NOT NULL,
	[JobViolationSeenBy] [nvarchar](max) NULL,
	[JobViolationSeenOn] [datetime] NULL,
	[IsJobMaxProblemSeen] [bit] NOT NULL,
	[JobMaxProblemSeenBy] [nvarchar](max) NULL,
	[JobMaxProblemSeenOn] [datetime] NULL,
	[IsJobMaxProductSeen] [bit] NOT NULL,
	[JobMaxProductSeenBy] [nvarchar](max) NULL,
	[JobMaxProductSeenOn] [datetime] NULL,
 CONSTRAINT [PK_DashboardUserBasedJobsSeen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DashboardUserBasedSetting]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DashboardUserBasedSetting](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Threshold_ChartLateArrival_OnLateStart] [int] NULL,
	[Threshold_ChartLateArrival_OnLateEnd] [int] NULL,
	[Threshold_ChartLateArrival_LateStart] [int] NULL,
	[Threshold_ChartLateArrival_LateEnd] [int] NULL,
	[Threshold_ChartLateArrival_VeryLate] [int] NULL,
	[Threshold_ChartLateEnd_OnLateStart] [int] NULL,
	[Threshold_ChartLateEnd_OnLateEnd] [int] NULL,
	[Threshold_ChartLateEnd_LateStart] [int] NULL,
	[Threshold_ChartLateEnd_LateEnd] [int] NULL,
	[Threshold_ChartLateEnd_VeryLate] [int] NULL,
	[Threshold_Violation_Location] [int] NULL,
	[Threshold_Violation_Terminal] [int] NULL,
	[Threshold_MaxProblems] [int] NULL,
	[Threshold_MaxProducts] [int] NULL,
	[IsDefaultSetting] [bit] NULL,
 CONSTRAINT [PK_DashboardUserBasedSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceDeliveryReport]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceDeliveryReport](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[Content] [nvarchar](max) NOT NULL,
	[ReportId] [uniqueidentifier] NULL,
	[DeviceId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[RetryCount] [int] NOT NULL,
	[TenantId] [uniqueidentifier] NULL,
	[JobId] [uniqueidentifier] NULL,
	[Priority] [int] NOT NULL,
 CONSTRAINT [PK_DeviceDeliveryReport] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceLog]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceLog](
	[Id] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[DeviceId] [uniqueidentifier] NOT NULL,
	[ExtraInfo] [nvarchar](1000) NULL,
	[Reason] [nvarchar](1000) NULL,
	[Path] [nvarchar](500) NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_DeviceLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Devices]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Devices](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[UniqueIdentifier] [nvarchar](100) NOT NULL,
	[Tag] [nvarchar](1000) NULL,
	[HubRegistrationId] [nvarchar](1000) NULL,
	[Handler] [nvarchar](1000) NULL,
	[AppVersion] [nvarchar](150) NULL,
	[Status] [tinyint] NOT NULL,
	[AssigendUserId] [uniqueidentifier] NULL,
	[LastActiveUserId] [uniqueidentifier] NULL,
	[Latitude] [decimal](10, 7) NULL,
	[Longitude] [decimal](10, 7) NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
	[LatestActive] [datetime] NULL,
 CONSTRAINT [PK_Devices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailedInjectedServices]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailedInjectedServices](
	[Id] [uniqueidentifier] NOT NULL,
	[ImportTriggerId] [uniqueidentifier] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[FailedServices] [nvarchar](max) NOT NULL,
	[JobIds] [nvarchar](max) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[FailureReasonId] [tinyint] NOT NULL,
	[Reason] [nvarchar](max) NOT NULL,
	[ProductionDate] [date] NOT NULL,
	[ErrorMessage] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_FailedInjectedServices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FailspotItemTracking]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailspotItemTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[ItemId] [nvarchar](max) NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[JobNumber] [nvarchar](max) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ServiceWorkerId] [uniqueidentifier] NOT NULL,
	[ActualJobId] [uniqueidentifier] NULL,
	[ActualJobNumber] [nvarchar](max) NULL,
	[ActualServiceWorkerId] [uniqueidentifier] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[ProductionDate] [date] NOT NULL,
 CONSTRAINT [PK_FailspotItemTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GlobalState]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalState](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Key] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_GlobalState] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportError]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportError](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ErrorMessage] [nvarchar](1000) NOT NULL,
	[ErrorDetail] [nvarchar](max) NOT NULL,
	[IsMarkedRead] [bit] NOT NULL,
	[IsAlarmEnabled] [bit] NOT NULL,
	[ImportErrorTypeId] [tinyint] NOT NULL,
	[ImportTriggerId] [uniqueidentifier] NULL,
	[OrganizationUnitId] [uniqueidentifier] NULL,
	[ReadBy] [nvarchar](50) NULL,
	[TenantId] [uniqueidentifier] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_ImportError] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportErrorType]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportErrorType](
	[Id] [tinyint] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_ImportErrorType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportTrigger]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportTrigger](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[FileName] [nvarchar](1000) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[ProductionDate] [date] NOT NULL,
	[ImportTypeId] [int] NOT NULL,
	[TriggerOutput] [nvarchar](max) NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[TemplateName] [nvarchar](max) NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ImportTrigger] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportTriggerType]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportTriggerType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_ImportTriggerType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Job]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[SourceJobId] [nvarchar](max) NOT NULL,
	[JobNumber] [nvarchar](100) NOT NULL,
	[Note] [nvarchar](500) NULL,
	[JobVersion] [nvarchar](100) NOT NULL,
	[TemplateName] [nvarchar](100) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[ProductionDate] [date] NOT NULL,
	[ExpiryDate] [date] NULL,
	[ParentId] [uniqueidentifier] NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
	[StartTerminalId] [uniqueidentifier] NOT NULL,
	[EndTerminalId] [uniqueidentifier] NOT NULL,
	[PlanId] [uniqueidentifier] NOT NULL,
	[CarrierId] [uniqueidentifier] NULL,
	[ServiceWorkerId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[DeviceName] [nvarchar](max) NULL,
	[VehicleNo] [nvarchar](max) NULL,
 CONSTRAINT [PK_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobDetail]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobDetail](
	[Id] [uniqueidentifier] NOT NULL,
	[JobStartTime] [time](7) NULL,
	[JobEndTime] [time](7) NULL,
	[StartTime] [time](7) NULL,
	[DepartureTime] [time](7) NULL,
	[ReturnTime] [time](7) NULL,
	[LateOffset] [int] NULL,
	[LateOffsetArrivalAtLocation] [int] NULL,
	[LastActivityOn] [datetime] NULL,
	[PlannedKm] [decimal](18, 6) NULL,
	[PlannedTime] [time](7) NULL,
 CONSTRAINT [PK_JobDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobGeoTagging]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobGeoTagging](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[ServiceWorkerId] [uniqueidentifier] NOT NULL,
	[DeviceId] [uniqueidentifier] NOT NULL,
	[DeliveryReportId] [uniqueidentifier] NOT NULL,
	[Latitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[Longitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[ServiceTypeId] [int] NULL,
	[LocationName] [nvarchar](max) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[LocationAddress] [nvarchar](max) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[SwipeDistance] [float] NULL,
	[ReportedTime] [datetime] NOT NULL,
	[JsonContent] [nvarchar](max) NULL,
 CONSTRAINT [PK_JobGeoTagging] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobHistory]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[JobPrimayId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[SourceJobId] [nvarchar](max) NOT NULL,
	[JobNumber] [nvarchar](100) NOT NULL,
	[Note] [nvarchar](500) NULL,
	[JobVersion] [nvarchar](100) NOT NULL,
	[TemplateName] [nvarchar](100) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[ProductionDate] [date] NOT NULL,
	[ExpiryDate] [date] NULL,
	[ParentId] [uniqueidentifier] NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
	[StartTerminalId] [uniqueidentifier] NOT NULL,
	[EndTerminalId] [uniqueidentifier] NOT NULL,
	[PlanId] [uniqueidentifier] NOT NULL,
	[CarrierId] [uniqueidentifier] NULL,
	[ServiceWorkerId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[DeviceName] [nvarchar](max) NULL,
	[VehicleNo] [nvarchar](max) NULL,
	[OperationTime] [datetime] NOT NULL,
	[OperationType] [tinyint] NOT NULL,
 CONSTRAINT [PK_JobHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobInjectedServices]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobInjectedServices](
	[Id] [uniqueidentifier] NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[ServiceJson] [nvarchar](max) NOT NULL,
	[ServiceIds] [nvarchar](max) NOT NULL,
	[IsServiceSend] [bit] NOT NULL,
	[JobProductionDate] [date] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ServiceJsonStatus] [tinyint] NOT NULL,
 CONSTRAINT [PK_JobInjectedServices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobJsonData]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobJsonData](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[Json] [nvarchar](max) NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobJsonData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobJsonTemplate]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobJsonTemplate](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[ContainerId] [uniqueidentifier] NOT NULL,
	[JobTemplate] [tinyint] NOT NULL,
	[NetworkType] [tinyint] NOT NULL,
	[ProductType] [tinyint] NULL,
	[Name] [nvarchar](200) NOT NULL,
	[TemplateJson] [nvarchar](max) NULL,
	[GroupType] [nvarchar](100) NULL,
	[OrganizationUnitId] [uniqueidentifier] NULL,
	[IsMultiServiceTemplate] [bit] NOT NULL,
	[DisplayName] [nvarchar](200) NULL,
	[HasGrid] [bit] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobJsonTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobJsonTemplateHistory]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobJsonTemplateHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[TemplateId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[ContainerId] [uniqueidentifier] NOT NULL,
	[ClientId] [int] NULL,
	[Name] [nvarchar](200) NOT NULL,
	[TemplateJson] [nvarchar](max) NULL,
	[GroupType] [nvarchar](100) NULL,
	[OrganizationUnitId] [uniqueidentifier] NULL,
	[IsMultiServiceTemplate] [bit] NOT NULL,
 CONSTRAINT [PK_JobJsonTemplateHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobLastDayCarrierHistory]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobLastDayCarrierHistory](
	[JobNumber] [nvarchar](100) NOT NULL,
	[CarrierId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobLocation]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobLocation](
	[Id] [uniqueidentifier] NOT NULL,
	[SourceLocationId] [nvarchar](max) NOT NULL,
	[StopNumber] [nvarchar](100) NOT NULL,
	[Sequence] [int] NOT NULL,
	[ETA] [time](7) NULL,
	[DropTime] [time](7) NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[LocationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobLocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobStats]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobStats](
	[Id] [uniqueidentifier] NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[LoadscanPending] [int] NOT NULL,
	[LoadscanProblem] [int] NOT NULL,
	[LoadscanSuccess] [int] NOT NULL,
	[DeliveryPending] [int] NOT NULL,
	[DeliveryProblem] [int] NOT NULL,
	[DeliverySuccess] [int] NOT NULL,
	[PickupPending] [int] NOT NULL,
	[PickupProblem] [int] NOT NULL,
	[PickupSuccess] [int] NOT NULL,
	[OffloadPending] [int] NOT NULL,
	[OffloadProblem] [int] NOT NULL,
	[OffloadSuccess] [int] NOT NULL,
	[CompletedStops] [int] NOT NULL,
	[PendingStop] [int] NOT NULL,
	[ProblemStops] [int] NOT NULL,
	[OverallStops] [int] NOT NULL,
	[TruckIn] [int] NOT NULL,
	[TruckOut] [int] NOT NULL,
	[PackagingSacks] [int] NOT NULL,
	[PackagingCages] [int] NOT NULL,
	[PackagingPallets] [int] NOT NULL,
	[DeliveredPackagingCages] [int] NOT NULL,
	[DeliveredPackagingPallets] [int] NOT NULL,
	[DeliveredPackagingSacks] [int] NOT NULL,
	[ProductionDate] [date] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobStats] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobTaskQueue]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobTaskQueue](
	[Id] [uniqueidentifier] NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[TypeId] [tinyint] NOT NULL,
	[RequestJson] [nvarchar](max) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[StartedOn] [datetime] NULL,
	[CompletedOn] [datetime] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[AcknowledgeType] [tinyint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastJobStatus] [tinyint] NOT NULL,
 CONSTRAINT [PK_JobTaskQueue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobWayPoint]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobWayPoint](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[Json] [nvarchar](max) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_JobWayPoint] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobWayPointTrigger]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobWayPointTrigger](
	[Id] [uniqueidentifier] NOT NULL,
	[ImportTriggerId] [uniqueidentifier] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[ProductionDate] [date] NOT NULL,
	[ResponseTime] [datetime] NULL,
	[RequestPayload] [nvarchar](max) NOT NULL,
	[JobIds] [nvarchar](max) NOT NULL,
	[ResponsePayload] [nvarchar](max) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[ResponseMessage] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_JobWayPointTrigger] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[SourceId] [bigint] NOT NULL,
	[Name] [nvarchar](100) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NOT NULL,
	[Address] [nvarchar](255) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NULL,
	[PhoneNo] [nvarchar](20) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[PostalCode] [nvarchar](20) NULL,
	[City] [nvarchar](100) NULL,
	[Latitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[Longitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[LocationNumber] [bigint] NOT NULL,
	[MLSLocationNumber] [nvarchar](max) NOT NULL,
	[LocationType] [smallint] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Template] [nvarchar](200) NOT NULL,
	[AccessCode] [nvarchar](200) NULL,
	[Key] [nvarchar](200) NULL,
	[ScanItem] [int] NOT NULL,
	[TakePicture] [int] NOT NULL,
	[ProductType] [nvarchar](max) NULL,
	[ServiceHours] [nvarchar](100) NULL,
	[ExtraInfo] [nvarchar](max) NULL,
	[ProductionDate] [date] NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[DropTime] [time](7) NULL,
	[ETA] [time](7) NULL,
	[Sequence] [int] NOT NULL,
	[StopNumber] [nvarchar](100) NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[ShouldVisitIfNoService] [int] NOT NULL,
	[ServiceFromTime] [time](7) NULL,
	[ServiceToTime] [time](7) NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocationProductMapping]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationProductMapping](
	[Id] [uniqueidentifier] NOT NULL,
	[LocationId] [uniqueidentifier] NOT NULL,
	[DAOLocationId] [nvarchar](max) NOT NULL,
	[ProductType] [nvarchar](max) NULL,
 CONSTRAINT [PK_LocationProductMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocationtoAdd]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationtoAdd](
	[Id] [uniqueidentifier] NOT NULL,
	[SourceLocationId] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](100) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NOT NULL,
	[Address] [nvarchar](255) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NULL,
	[PhoneNo] [nvarchar](20) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[PostalCode] [nvarchar](20) NULL,
	[City] [nvarchar](100) NULL,
	[Latitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[Longitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[LocationNumber] [bigint] NOT NULL,
	[LocationType] [smallint] NOT NULL,
	[Description] [nvarchar](255) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NULL,
	[Template] [nvarchar](200) NOT NULL,
	[AccessCode] [nvarchar](200) MASKED WITH (FUNCTION = 'default()') NULL,
	[Key] [nvarchar](200) MASKED WITH (FUNCTION = 'partial(2, "XXXX", 1)') NULL,
	[ScanItem] [int] NOT NULL,
	[TakePicture] [int] NOT NULL,
	[ServiceHours] [nvarchar](100) NULL,
	[ExtraInfo] [nvarchar](max) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NULL,
	[ProductionDate] [date] NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_LocationtoAdd] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MobileJobJsonTemplate]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileJobJsonTemplate](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[ContainerId] [uniqueidentifier] NOT NULL,
	[JobTemplate] [tinyint] NOT NULL,
	[NetworkType] [tinyint] NOT NULL,
	[ProductType] [tinyint] NULL,
	[Name] [nvarchar](200) NOT NULL,
	[TemplateJson] [nvarchar](max) NULL,
	[GroupType] [nvarchar](100) NULL,
	[OrganizationUnitId] [uniqueidentifier] NULL,
	[IsMultiServiceTemplate] [bit] NOT NULL,
	[DisplayName] [nvarchar](200) NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_MobileJobJsonTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MoveLocationHistory]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MoveLocationHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[LocationId] [uniqueidentifier] NOT NULL,
	[SourceJobId] [uniqueidentifier] NOT NULL,
	[DestinationJobId] [uniqueidentifier] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[MLSLocationNumber] [nvarchar](max) NOT NULL,
	[DestinationJobSourceId] [nvarchar](max) NOT NULL,
	[SourceJobSourceId] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_MoveLocationHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationTemplate]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationTemplate](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Subject] [nvarchar](255) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[TypeId] [tinyint] NOT NULL,
 CONSTRAINT [PK_NotificationTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationTemplateType]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationTemplateType](
	[Id] [tinyint] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_NotificationTemplateType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrganizationUnit]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationUnit](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](255) NULL,
	[Telephone] [nvarchar](20) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Address] [nvarchar](255) NULL,
	[City] [nvarchar](100) NULL,
	[Latitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[Longitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[PostalCode] [nvarchar](20) NULL,
	[Theme] [nvarchar](100) NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_OrganizationUnit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrganizationUnitCarrierMapping]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationUnitCarrierMapping](
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
	[CarrierId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_OrganizationUnitCarrierMapping] PRIMARY KEY CLUSTERED 
(
	[OrganizationUnitId] ASC,
	[CarrierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plan]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plan](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[ProductionDate] [date] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Plan] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProblemType]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemType](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Action] [nvarchar](4000) NOT NULL,
	[EnText] [nvarchar](512) NOT NULL,
	[DkText] [nvarchar](512) NULL,
	[Code] [nvarchar](200) NULL,
	[GroupType] [nvarchar](200) NULL,
	[GroupName] [nvarchar](200) NULL,
	[OrganizationUnitId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ProblemType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PushNotification]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PushNotification](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[NotificationTemplateTypeId] [tinyint] NOT NULL,
 CONSTRAINT [PK_PushNotification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PushNotificationDetail]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PushNotificationDetail](
	[Id] [uniqueidentifier] NOT NULL,
	[PushNotificationId] [uniqueidentifier] NOT NULL,
	[JobId] [uniqueidentifier] NULL,
	[ServiceWorkerId] [uniqueidentifier] NULL,
	[UniqueIdentifier] [nvarchar](max) NOT NULL,
	[JsonContent] [nvarchar](max) NOT NULL,
	[Status] [int] NULL,
	[AcknowledgeType] [tinyint] NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[RetryCount] [int] NOT NULL,
 CONSTRAINT [PK_PushNotificationDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleClaims]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_RoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalarySettlement]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalarySettlement](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastModifiedOn] [datetime] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[JsonContent] [nvarchar](max) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[TransferredOn] [datetime] NULL,
	[Response] [nvarchar](max) NULL,
	[RetryCount] [tinyint] NOT NULL,
 CONSTRAINT [PK_SalarySettlement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalarySettlementEmailStatus]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalarySettlementEmailStatus](
	[Id] [uniqueidentifier] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[ProductionDate] [date] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Subject] [nvarchar](max) NOT NULL,
	[JobCount] [int] NOT NULL,
	[JobIds] [nvarchar](max) NOT NULL,
	[EmailType] [tinyint] NOT NULL,
	[IsEmailSent] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastModifiedOn] [datetime] NULL,
	[TotalAttempts] [int] NOT NULL,
	[LogGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SalarySettlementEmailStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[Id] [uniqueidentifier] NOT NULL,
	[ContainerId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TypeId] [tinyint] NOT NULL,
	[SortOrder] [float] NOT NULL,
	[ExtraInfo] [nvarchar](max) NULL,
	[ProductionDate] [date] NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[DisplayName] [nvarchar](200) NULL,
	[HasChild] [bit] NOT NULL,
	[HasGrid] [bit] NOT NULL,
	[ProductTypeId] [tinyint] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[ContainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Service_Id] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceContainerMapping]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceContainerMapping](
	[Id] [uniqueidentifier] NOT NULL,
	[ParentContainerId] [uniqueidentifier] NULL,
	[ServiceId] [uniqueidentifier] NOT NULL,
	[JobLocationId] [uniqueidentifier] NULL,
	[ProductContainerId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ServiceContainerMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceDetail]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceDetail](
	[Id] [uniqueidentifier] NOT NULL,
	[ItemId] [nvarchar](200) NOT NULL,
	[AlternativeItemId] [nvarchar](200) NULL,
	[Action] [nvarchar](100) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ObjectType] [nvarchar](200) NULL,
	[IsUnknown] [bit] NOT NULL,
	[HandoverDestination] [nvarchar](255) NULL,
	[ReceiptType] [tinyint] NULL,
	[HandlingUnit] [nvarchar](400) NULL,
	[QuantityPerHandlingUnit] [int] NULL,
	[Size] [nvarchar](100) NULL,
	[Weight] [decimal](18, 6) NULL,
	[Priority] [nvarchar](100) NULL,
	[Description] [nvarchar](1500) NULL,
	[ExtraInfo] [nvarchar](max) NULL,
	[LcCode] [nvarchar](50) NULL,
	[LabelCode] [nvarchar](max) NULL,
	[ProductType] [nvarchar](max) NULL,
	[ServiceProductId] [nvarchar](150) NULL,
	[ServiceProductName] [nvarchar](150) NULL,
 CONSTRAINT [PK_ServiceDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceJsonData]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceJsonData](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[Json] [nvarchar](max) NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ServiceJsonData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServicesPerformedFromBackend]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicesPerformedFromBackend](
	[Id] [uniqueidentifier] NOT NULL,
	[JobId] [uniqueidentifier] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ServicesPerformedFromBackend] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceStatus]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceStatus](
	[Id] [uniqueidentifier] NOT NULL,
	[ServiceId] [uniqueidentifier] NOT NULL,
	[Status] [smallint] NOT NULL,
	[Latitude] [decimal](10, 7) NOT NULL,
	[Longitude] [decimal](10, 7) NOT NULL,
	[PlannedLatitude] [decimal](10, 7) NOT NULL,
	[PlannedLongitude] [decimal](10, 7) NOT NULL,
	[SwipeDistance] [decimal](18, 6) NOT NULL,
	[IsOverflowed] [bit] NOT NULL,
	[SwipeTime] [datetime] NOT NULL,
	[NoteType] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[NoteId] [nvarchar](max) NULL,
	[Quantity] [int] NULL,
	[NoteText] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ExtraInfo] [nvarchar](max) NULL,
	[ProductionDate] [date] NOT NULL,
	[DeviceId] [uniqueidentifier] NULL,
	[SwipeType] [nvarchar](50) NULL,
	[IsScanThroughLC] [bit] NOT NULL,
 CONSTRAINT [PK_ServiceStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TablesForArchiving]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablesForArchiving](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](255) NOT NULL,
	[AdditionalFilterQuery] [nvarchar](500) NULL,
	[DateColumnToCompareForDelete] [nvarchar](255) NULL,
	[DeleteDataAfterDays] [smallint] NOT NULL,
 CONSTRAINT [PK_TablesForArchiving] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temGlobalConfiguration]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temGlobalConfiguration](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[OragnizationUnitId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NULL,
	[ConfigurationType] [tinyint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tenant]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tenant](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](255) NULL,
	[Telephone] [nvarchar](20) NULL,
	[TenantLogo] [nvarchar](max) NULL,
	[TenantTheme] [nvarchar](max) NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Tenant] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TenantOrganizationUnitMapping]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TenantOrganizationUnitMapping](
	[UserId] [uniqueidentifier] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TenantOrganizationUnitMapping] PRIMARY KEY CLUSTERED 
(
	[TenantId] ASC,
	[OrganizationUnitId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TenantUserMapping]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TenantUserMapping](
	[UserId] [uniqueidentifier] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TenantUserMapping] PRIMARY KEY CLUSTERED 
(
	[TenantId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Terminal]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Terminal](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Name] [nvarchar](100) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NOT NULL,
	[Address] [nvarchar](255) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NULL,
	[City] [nvarchar](100) NULL,
	[Latitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[Longitude] [decimal](10, 7) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[PostalCode] [nvarchar](20) NULL,
	[OrganizationUnitId] [uniqueidentifier] NOT NULL,
	[SubOrganizationUnitId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Terminal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Thread]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thread](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Title] [nvarchar](100) MASKED WITH (FUNCTION = 'default()') NULL,
	[LastMessge] [nvarchar](255) MASKED WITH (FUNCTION = 'default()') NULL,
	[FromUserId] [uniqueidentifier] NOT NULL,
	[ToUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Thread] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThreadMessage]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThreadMessage](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Message] [nvarchar](255) MASKED WITH (FUNCTION = 'default()') NOT NULL,
	[ThreadId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ThreadMessage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThreadMessageRead]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThreadMessageRead](
	[Id] [uniqueidentifier] NOT NULL,
	[ReadOn] [datetime] NOT NULL,
	[MessageId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ThreadMessageRead] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Threshold]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Threshold](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ThresholdType] [int] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[ServiceProviderId] [uniqueidentifier] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Threshold] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Translation]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Translation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Key] [nvarchar](max) NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_Translation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCarrierMapping]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCarrierMapping](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[CarrierId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserCarrierMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClaims]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLoginHistory]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLoginHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[IpAddress] [nvarchar](max) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_UserLoginHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[LastModifiedOn] [datetime] NULL,
	[LastModifiedBy] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[FirstName] [nvarchar](100) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NOT NULL,
	[LastName] [nvarchar](100) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NULL,
	[AuthCode] [nvarchar](max) NOT NULL,
	[AuthCodeGeneratedOn] [datetime] NOT NULL,
	[UserType] [tinyint] NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[CarrierId] [uniqueidentifier] NULL,
	[LastLoginDeviceId] [uniqueidentifier] NULL,
	[LastActive] [datetime] NULL,
	[UserName] [nvarchar](256) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NULL,
	[NormalizedUserName] [nvarchar](256) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 1)') NULL,
	[Email] [nvarchar](256) MASKED WITH (FUNCTION = 'email()') NULL,
	[NormalizedEmail] [nvarchar](256) MASKED WITH (FUNCTION = 'email()') NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) MASKED WITH (FUNCTION = 'partial(3, "XXXX", 3)') NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTokens]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTokens](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[TokenId] [nvarchar](max) NOT NULL,
	[IsUsed] [bit] NOT NULL,
	[IsRevoked] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ExpiresOn] [datetime] NOT NULL,
	[SessionGuid] [uniqueidentifier] NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserWidgets]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserWidgets](
	[Id] [uniqueidentifier] NOT NULL,
	[Setting] [nvarchar](max) NOT NULL,
	[Filters] [nvarchar](max) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[WidgetId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_UserWidgets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Widget]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Widget](
	[Id] [uniqueidentifier] NOT NULL,
	[WidgetName] [nvarchar](max) NOT NULL,
	[WidgetDescription] [nvarchar](max) NOT NULL,
	[ImgSrc] [nvarchar](max) NOT NULL,
	[OrgnizationUnitId] [uniqueidentifier] NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDetailShow] [bit] NOT NULL,
	[Setting] [nvarchar](max) NOT NULL,
	[Filters] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DisplayName] [nvarchar](max) NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Widget] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WidgetCategory]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WidgetCategory](
	[Id] [uniqueidentifier] NOT NULL,
	[Category] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_WidgetCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carrier] ADD  DEFAULT ('91c7c938-87ff-4d4f-88df-057507e0daf1') FOR [CustomerId]
GO
ALTER TABLE [dbo].[DeviceDeliveryReport] ADD  DEFAULT ((0)) FOR [Priority]
GO
ALTER TABLE [dbo].[FailedInjectedServices] ADD  DEFAULT (N'') FOR [Reason]
GO
ALTER TABLE [dbo].[FailedInjectedServices] ADD  DEFAULT ('0001-01-01') FOR [ProductionDate]
GO
ALTER TABLE [dbo].[FailedInjectedServices] ADD  DEFAULT (N'') FOR [ErrorMessage]
GO
ALTER TABLE [dbo].[FailspotItemTracking] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantId]
GO
ALTER TABLE [dbo].[FailspotItemTracking] ADD  DEFAULT ('0001-01-01') FOR [ProductionDate]
GO
ALTER TABLE [dbo].[GlobalConfiguration] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[GlobalConfiguration] ADD  DEFAULT (CONVERT([tinyint],(0))) FOR [ConfigurationType]
GO
ALTER TABLE [dbo].[GlobalConfiguration] ADD  DEFAULT ('9999-12-31T23:59:59.9999999') FOR [PeriodEnd]
GO
ALTER TABLE [dbo].[GlobalConfiguration] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [PeriodStart]
GO
ALTER TABLE [dbo].[JobInjectedServices] ADD  DEFAULT (CONVERT([tinyint],(0))) FOR [ServiceJsonStatus]
GO
ALTER TABLE [dbo].[JobJsonTemplate] ADD  DEFAULT (CONVERT([bit],(0))) FOR [HasGrid]
GO
ALTER TABLE [dbo].[JobJsonTemplate] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantId]
GO
ALTER TABLE [dbo].[JobStats] ADD  DEFAULT ('0001-01-01') FOR [ProductionDate]
GO
ALTER TABLE [dbo].[JobStats] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantId]
GO
ALTER TABLE [dbo].[JobTaskQueue] ADD  DEFAULT (CONVERT([tinyint],(0))) FOR [AcknowledgeType]
GO
ALTER TABLE [dbo].[JobTaskQueue] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[JobTaskQueue] ADD  DEFAULT (CONVERT([tinyint],(0))) FOR [LastJobStatus]
GO
ALTER TABLE [dbo].[Location] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantId]
GO
ALTER TABLE [dbo].[Location] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[Location] ADD  DEFAULT (N'') FOR [StopNumber]
GO
ALTER TABLE [dbo].[Location] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [JobId]
GO
ALTER TABLE [dbo].[Location] ADD  DEFAULT ((0)) FOR [ShouldVisitIfNoService]
GO
ALTER TABLE [dbo].[MobileJobJsonTemplate] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantId]
GO
ALTER TABLE [dbo].[MoveLocationHistory] ADD  DEFAULT (N'') FOR [MLSLocationNumber]
GO
ALTER TABLE [dbo].[MoveLocationHistory] ADD  DEFAULT (N'') FOR [DestinationJobSourceId]
GO
ALTER TABLE [dbo].[MoveLocationHistory] ADD  DEFAULT (N'') FOR [SourceJobSourceId]
GO
ALTER TABLE [dbo].[SalarySettlementEmailStatus] ADD  DEFAULT ((0)) FOR [TotalAttempts]
GO
ALTER TABLE [dbo].[SalarySettlementEmailStatus] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [LogGuid]
GO
ALTER TABLE [dbo].[Service] ADD  DEFAULT (CONVERT([bit],(0))) FOR [HasChild]
GO
ALTER TABLE [dbo].[Service] ADD  DEFAULT (CONVERT([bit],(0))) FOR [HasGrid]
GO
ALTER TABLE [dbo].[Service] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantId]
GO
ALTER TABLE [dbo].[ServicesPerformedFromBackend] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantId]
GO
ALTER TABLE [dbo].[ServiceStatus] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsScanThroughLC]
GO
ALTER TABLE [dbo].[Tenant] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CustomerId]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ('91c7c938-87ff-4d4f-88df-057507e0daf1') FOR [CustomerId]
GO
ALTER TABLE [dbo].[Carrier]  WITH CHECK ADD  CONSTRAINT [FK_Carrier_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Carrier] CHECK CONSTRAINT [FK_Carrier_Customer_CustomerId]
GO
ALTER TABLE [dbo].[DeviceLog]  WITH CHECK ADD  CONSTRAINT [FK_DeviceLog_Devices_DeviceId] FOREIGN KEY([DeviceId])
REFERENCES [dbo].[Devices] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DeviceLog] CHECK CONSTRAINT [FK_DeviceLog_Devices_DeviceId]
GO
ALTER TABLE [dbo].[Devices]  WITH CHECK ADD  CONSTRAINT [FK_Devices_OrganizationUnit_OrganizationUnitId] FOREIGN KEY([OrganizationUnitId])
REFERENCES [dbo].[OrganizationUnit] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Devices] CHECK CONSTRAINT [FK_Devices_OrganizationUnit_OrganizationUnitId]
GO
ALTER TABLE [dbo].[Devices]  WITH CHECK ADD  CONSTRAINT [FK_Devices_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[Devices] CHECK CONSTRAINT [FK_Devices_Tenant_TenantId]
GO
ALTER TABLE [dbo].[Devices]  WITH CHECK ADD  CONSTRAINT [FK_Devices_Users_AssigendUserId] FOREIGN KEY([AssigendUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Devices] CHECK CONSTRAINT [FK_Devices_Users_AssigendUserId]
GO
ALTER TABLE [dbo].[Devices]  WITH CHECK ADD  CONSTRAINT [FK_Devices_Users_LastActiveUserId] FOREIGN KEY([LastActiveUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Devices] CHECK CONSTRAINT [FK_Devices_Users_LastActiveUserId]
GO
ALTER TABLE [dbo].[FailedInjectedServices]  WITH CHECK ADD  CONSTRAINT [FK_FailedInjectedServices_ImportTrigger_ImportTriggerId] FOREIGN KEY([ImportTriggerId])
REFERENCES [dbo].[ImportTrigger] ([Id])
GO
ALTER TABLE [dbo].[FailedInjectedServices] CHECK CONSTRAINT [FK_FailedInjectedServices_ImportTrigger_ImportTriggerId]
GO
ALTER TABLE [dbo].[GlobalConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_GlobalConfiguration_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[GlobalConfiguration] CHECK CONSTRAINT [FK_GlobalConfiguration_Tenant_TenantId]
GO
ALTER TABLE [dbo].[ImportError]  WITH CHECK ADD  CONSTRAINT [FK_ImportError_ImportErrorType_ImportErrorTypeId] FOREIGN KEY([ImportErrorTypeId])
REFERENCES [dbo].[ImportErrorType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ImportError] CHECK CONSTRAINT [FK_ImportError_ImportErrorType_ImportErrorTypeId]
GO
ALTER TABLE [dbo].[ImportError]  WITH CHECK ADD  CONSTRAINT [FK_ImportError_ImportTrigger_ImportTriggerId] FOREIGN KEY([ImportTriggerId])
REFERENCES [dbo].[ImportTrigger] ([Id])
GO
ALTER TABLE [dbo].[ImportError] CHECK CONSTRAINT [FK_ImportError_ImportTrigger_ImportTriggerId]
GO
ALTER TABLE [dbo].[ImportTrigger]  WITH CHECK ADD  CONSTRAINT [FK_ImportTrigger_ImportTriggerType_ImportTypeId] FOREIGN KEY([ImportTypeId])
REFERENCES [dbo].[ImportTriggerType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ImportTrigger] CHECK CONSTRAINT [FK_ImportTrigger_ImportTriggerType_ImportTypeId]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Carrier_CarrierId] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([Id])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Carrier_CarrierId]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_OrganizationUnit_OrganizationUnitId] FOREIGN KEY([OrganizationUnitId])
REFERENCES [dbo].[OrganizationUnit] ([Id])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_OrganizationUnit_OrganizationUnitId]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Plan_PlanId] FOREIGN KEY([PlanId])
REFERENCES [dbo].[Plan] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Plan_PlanId]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Tenant_TenantId]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Terminal_EndTerminalId] FOREIGN KEY([EndTerminalId])
REFERENCES [dbo].[Terminal] ([Id])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Terminal_EndTerminalId]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Terminal_StartTerminalId] FOREIGN KEY([StartTerminalId])
REFERENCES [dbo].[Terminal] ([Id])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Terminal_StartTerminalId]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Users_ServiceWorkerId] FOREIGN KEY([ServiceWorkerId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Users_ServiceWorkerId]
GO
ALTER TABLE [dbo].[JobDetail]  WITH CHECK ADD  CONSTRAINT [FK_JobDetail_Job_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Job] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobDetail] CHECK CONSTRAINT [FK_JobDetail_Job_Id]
GO
ALTER TABLE [dbo].[JobJsonData]  WITH CHECK ADD  CONSTRAINT [FK_JobJsonData_Job_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Job] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobJsonData] CHECK CONSTRAINT [FK_JobJsonData_Job_Id]
GO
ALTER TABLE [dbo].[JobLocation]  WITH CHECK ADD  CONSTRAINT [FK_JobLocation_Job_JobId] FOREIGN KEY([JobId])
REFERENCES [dbo].[Job] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobLocation] CHECK CONSTRAINT [FK_JobLocation_Job_JobId]
GO
ALTER TABLE [dbo].[JobLocation]  WITH CHECK ADD  CONSTRAINT [FK_JobLocation_Location_LocationId] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[JobLocation] CHECK CONSTRAINT [FK_JobLocation_Location_LocationId]
GO
ALTER TABLE [dbo].[JobStats]  WITH CHECK ADD  CONSTRAINT [FK_JobStats_Job_JobId] FOREIGN KEY([JobId])
REFERENCES [dbo].[Job] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobStats] CHECK CONSTRAINT [FK_JobStats_Job_JobId]
GO
ALTER TABLE [dbo].[JobWayPoint]  WITH CHECK ADD  CONSTRAINT [FK_JobWayPoint_Job_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Job] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[JobWayPoint] CHECK CONSTRAINT [FK_JobWayPoint_Job_Id]
GO
ALTER TABLE [dbo].[JobWayPointTrigger]  WITH CHECK ADD  CONSTRAINT [FK_JobWayPointTrigger_ImportTrigger_ImportTriggerId] FOREIGN KEY([ImportTriggerId])
REFERENCES [dbo].[ImportTrigger] ([Id])
GO
ALTER TABLE [dbo].[JobWayPointTrigger] CHECK CONSTRAINT [FK_JobWayPointTrigger_ImportTrigger_ImportTriggerId]
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_OrganizationUnit_OrganizationUnitId] FOREIGN KEY([OrganizationUnitId])
REFERENCES [dbo].[OrganizationUnit] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Location] CHECK CONSTRAINT [FK_Location_OrganizationUnit_OrganizationUnitId]
GO
ALTER TABLE [dbo].[LocationProductMapping]  WITH CHECK ADD  CONSTRAINT [FK_LocationProductMapping_Location_LocationId] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Location] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LocationProductMapping] CHECK CONSTRAINT [FK_LocationProductMapping_Location_LocationId]
GO
ALTER TABLE [dbo].[NotificationTemplate]  WITH CHECK ADD  CONSTRAINT [FK_NotificationTemplate_NotificationTemplateType_TypeId] FOREIGN KEY([TypeId])
REFERENCES [dbo].[NotificationTemplateType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NotificationTemplate] CHECK CONSTRAINT [FK_NotificationTemplate_NotificationTemplateType_TypeId]
GO
ALTER TABLE [dbo].[OrganizationUnit]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationUnit_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrganizationUnit] CHECK CONSTRAINT [FK_OrganizationUnit_Tenant_TenantId]
GO
ALTER TABLE [dbo].[OrganizationUnitCarrierMapping]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationUnitCarrierMapping_Carrier_CarrierId] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrganizationUnitCarrierMapping] CHECK CONSTRAINT [FK_OrganizationUnitCarrierMapping_Carrier_CarrierId]
GO
ALTER TABLE [dbo].[OrganizationUnitCarrierMapping]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationUnitCarrierMapping_OrganizationUnit_OrganizationUnitId] FOREIGN KEY([OrganizationUnitId])
REFERENCES [dbo].[OrganizationUnit] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrganizationUnitCarrierMapping] CHECK CONSTRAINT [FK_OrganizationUnitCarrierMapping_OrganizationUnit_OrganizationUnitId]
GO
ALTER TABLE [dbo].[Plan]  WITH CHECK ADD  CONSTRAINT [FK_Plan_OrganizationUnit_OrganizationUnitId] FOREIGN KEY([OrganizationUnitId])
REFERENCES [dbo].[OrganizationUnit] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Plan] CHECK CONSTRAINT [FK_Plan_OrganizationUnit_OrganizationUnitId]
GO
ALTER TABLE [dbo].[Plan]  WITH CHECK ADD  CONSTRAINT [FK_Plan_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[Plan] CHECK CONSTRAINT [FK_Plan_Tenant_TenantId]
GO
ALTER TABLE [dbo].[PushNotificationDetail]  WITH CHECK ADD  CONSTRAINT [FK_PushNotificationDetail_PushNotification_PushNotificationId] FOREIGN KEY([PushNotificationId])
REFERENCES [dbo].[PushNotification] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PushNotificationDetail] CHECK CONSTRAINT [FK_PushNotificationDetail_PushNotification_PushNotificationId]
GO
ALTER TABLE [dbo].[RoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_RoleClaims_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RoleClaims] CHECK CONSTRAINT [FK_RoleClaims_Roles_RoleId]
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD  CONSTRAINT [FK_Service_Job_JobId] FOREIGN KEY([JobId])
REFERENCES [dbo].[Job] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Service] CHECK CONSTRAINT [FK_Service_Job_JobId]
GO
ALTER TABLE [dbo].[ServiceContainerMapping]  WITH CHECK ADD  CONSTRAINT [FK_ServiceContainerMapping_JobLocation_JobLocationId] FOREIGN KEY([JobLocationId])
REFERENCES [dbo].[JobLocation] ([Id])
GO
ALTER TABLE [dbo].[ServiceContainerMapping] CHECK CONSTRAINT [FK_ServiceContainerMapping_JobLocation_JobLocationId]
GO
ALTER TABLE [dbo].[ServiceContainerMapping]  WITH CHECK ADD  CONSTRAINT [FK_ServiceContainerMapping_Service_ServiceId] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Service] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceContainerMapping] CHECK CONSTRAINT [FK_ServiceContainerMapping_Service_ServiceId]
GO
ALTER TABLE [dbo].[ServiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_ServiceDetail_Service_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Service] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceDetail] CHECK CONSTRAINT [FK_ServiceDetail_Service_Id]
GO
ALTER TABLE [dbo].[ServiceJsonData]  WITH CHECK ADD  CONSTRAINT [FK_ServiceJsonData_Job_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Job] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceJsonData] CHECK CONSTRAINT [FK_ServiceJsonData_Job_Id]
GO
ALTER TABLE [dbo].[ServiceStatus]  WITH CHECK ADD  CONSTRAINT [FK_ServiceStatus_Devices_DeviceId] FOREIGN KEY([DeviceId])
REFERENCES [dbo].[Devices] ([Id])
GO
ALTER TABLE [dbo].[ServiceStatus] CHECK CONSTRAINT [FK_ServiceStatus_Devices_DeviceId]
GO
ALTER TABLE [dbo].[ServiceStatus]  WITH CHECK ADD  CONSTRAINT [FK_ServiceStatus_ServiceContainerMapping_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[ServiceContainerMapping] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceStatus] CHECK CONSTRAINT [FK_ServiceStatus_ServiceContainerMapping_Id]
GO
ALTER TABLE [dbo].[Tenant]  WITH CHECK ADD  CONSTRAINT [FK_Tenant_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Tenant] CHECK CONSTRAINT [FK_Tenant_Customer_CustomerId]
GO
ALTER TABLE [dbo].[TenantOrganizationUnitMapping]  WITH CHECK ADD  CONSTRAINT [FK_TenantOrganizationUnitMapping_OrganizationUnit_OrganizationUnitId] FOREIGN KEY([OrganizationUnitId])
REFERENCES [dbo].[OrganizationUnit] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TenantOrganizationUnitMapping] CHECK CONSTRAINT [FK_TenantOrganizationUnitMapping_OrganizationUnit_OrganizationUnitId]
GO
ALTER TABLE [dbo].[TenantOrganizationUnitMapping]  WITH CHECK ADD  CONSTRAINT [FK_TenantOrganizationUnitMapping_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[TenantOrganizationUnitMapping] CHECK CONSTRAINT [FK_TenantOrganizationUnitMapping_Tenant_TenantId]
GO
ALTER TABLE [dbo].[TenantOrganizationUnitMapping]  WITH CHECK ADD  CONSTRAINT [FK_TenantOrganizationUnitMapping_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TenantOrganizationUnitMapping] CHECK CONSTRAINT [FK_TenantOrganizationUnitMapping_Users_UserId]
GO
ALTER TABLE [dbo].[TenantUserMapping]  WITH CHECK ADD  CONSTRAINT [FK_TenantUserMapping_Tenant_TenantId] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([Id])
GO
ALTER TABLE [dbo].[TenantUserMapping] CHECK CONSTRAINT [FK_TenantUserMapping_Tenant_TenantId]
GO
ALTER TABLE [dbo].[TenantUserMapping]  WITH CHECK ADD  CONSTRAINT [FK_TenantUserMapping_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TenantUserMapping] CHECK CONSTRAINT [FK_TenantUserMapping_Users_UserId]
GO
ALTER TABLE [dbo].[Terminal]  WITH CHECK ADD  CONSTRAINT [FK_Terminal_OrganizationUnit_OrganizationUnitId] FOREIGN KEY([OrganizationUnitId])
REFERENCES [dbo].[OrganizationUnit] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Terminal] CHECK CONSTRAINT [FK_Terminal_OrganizationUnit_OrganizationUnitId]
GO
ALTER TABLE [dbo].[ThreadMessage]  WITH CHECK ADD  CONSTRAINT [FK_ThreadMessage_Thread_ThreadId] FOREIGN KEY([ThreadId])
REFERENCES [dbo].[Thread] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ThreadMessage] CHECK CONSTRAINT [FK_ThreadMessage_Thread_ThreadId]
GO
ALTER TABLE [dbo].[ThreadMessageRead]  WITH CHECK ADD  CONSTRAINT [FK_ThreadMessageRead_ThreadMessage_MessageId] FOREIGN KEY([MessageId])
REFERENCES [dbo].[ThreadMessage] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ThreadMessageRead] CHECK CONSTRAINT [FK_ThreadMessageRead_ThreadMessage_MessageId]
GO
ALTER TABLE [dbo].[ThreadMessageRead]  WITH CHECK ADD  CONSTRAINT [FK_ThreadMessageRead_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ThreadMessageRead] CHECK CONSTRAINT [FK_ThreadMessageRead_Users_UserId]
GO
ALTER TABLE [dbo].[Translation]  WITH CHECK ADD  CONSTRAINT [FK_Translation_Language_LanguageId] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Translation] CHECK CONSTRAINT [FK_Translation_Language_LanguageId]
GO
ALTER TABLE [dbo].[UserCarrierMapping]  WITH CHECK ADD  CONSTRAINT [FK_UserCarrierMapping_Carrier_CarrierId] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserCarrierMapping] CHECK CONSTRAINT [FK_UserCarrierMapping_Carrier_CarrierId]
GO
ALTER TABLE [dbo].[UserCarrierMapping]  WITH CHECK ADD  CONSTRAINT [FK_UserCarrierMapping_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserCarrierMapping] CHECK CONSTRAINT [FK_UserCarrierMapping_Users_UserId]
GO
ALTER TABLE [dbo].[UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_UserClaims_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserClaims] CHECK CONSTRAINT [FK_UserClaims_Users_UserId]
GO
ALTER TABLE [dbo].[UserLoginHistory]  WITH CHECK ADD  CONSTRAINT [FK_UserLoginHistory_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserLoginHistory] CHECK CONSTRAINT [FK_UserLoginHistory_Users_UserId]
GO
ALTER TABLE [dbo].[UserLogins]  WITH CHECK ADD  CONSTRAINT [FK_UserLogins_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserLogins] CHECK CONSTRAINT [FK_UserLogins_Users_UserId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles_RoleId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users_UserId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Carrier_CarrierId] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Carrier_CarrierId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Customer_CustomerId]
GO
ALTER TABLE [dbo].[UserTokens]  WITH CHECK ADD  CONSTRAINT [FK_UserTokens_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserTokens] CHECK CONSTRAINT [FK_UserTokens_Users_UserId]
GO
ALTER TABLE [dbo].[UserWidgets]  WITH CHECK ADD  CONSTRAINT [FK_UserWidgets_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserWidgets] CHECK CONSTRAINT [FK_UserWidgets_Users_UserId]
GO
ALTER TABLE [dbo].[UserWidgets]  WITH CHECK ADD  CONSTRAINT [FK_UserWidgets_Widget_WidgetId] FOREIGN KEY([WidgetId])
REFERENCES [dbo].[Widget] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserWidgets] CHECK CONSTRAINT [FK_UserWidgets_Widget_WidgetId]
GO
ALTER TABLE [dbo].[Widget]  WITH CHECK ADD  CONSTRAINT [FK_Widget_WidgetCategory_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[WidgetCategory] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Widget] CHECK CONSTRAINT [FK_Widget_WidgetCategory_CategoryId]
GO
/****** Object:  StoredProcedure [dbo].[SP_ArchiveData]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ArchiveData]
  @productionDate DATE,
  @tenantId UNIQUEIDENTIFIER
AS
  BEGIN
    IF EXISTS
    (
           SELECT 1
           FROM   job
           WHERE  productiondate = @productionDate
           AND    tenantid=@tenantId)
    BEGIN
      RETURN;
    END
    DECLARE @Id                    INT =1,
      @maxId                       INT=0;
    DECLARE @tableName             NVARCHAR(255);
    DECLARE @AdditionalFilterQuery NVARCHAR(500);
    DECLARE @TableHasIdentity      BIT=0;
    DECLARE @sourceDB              NVARCHAR(255)
    DECLARE @destinationDB         NVARCHAR(255)
    DECLARE @query                 NVARCHAR (max);
    DECLARE @primaryKey            NVARCHAR (255);
    -- Disable all constraints for database
    SELECT @destinationDB=[Value]
    FROM   globalconfiguration
    WHERE  [Key]='106'
    SELECT @sourceDB='['+Db_name()+']' ;
    
    PRINT(@sourceDB)
    EXEC ('EXEC '+@destinationDB+'..sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"')
    --EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
    PRINT(@destinationDB)
    SELECT @maxId=Max(id)
    FROM   tablesforarchiving
    WHERE  tablename <>'GlobalConfiguration'
    SET @query='';
    WHILE (@Id <= @maxId)
    BEGIN
      IF EXISTS
      (
             SELECT 1
             FROM   tablesforarchiving
             WHERE  id=@Id
             AND    tablename <>'GlobalConfiguration')
      BEGIN
        SELECT @tableName =tablename,
               @AdditionalFilterQuery = Isnull(additionalfilterquery,'')
        FROM   tablesforarchiving
        WHERE  id=@Id
        AND    tablename <>'GlobalConfiguration'
        IF (@tableName = 'JobGeoTagging')
        BEGIN
          -- this table is being moved in a different way because it has to serialize the content
          -- for the archive database
          -- create temporary synonym as this dynamic query will sow the archiving process
          EXEC ('CREATE SYNONYM SourceJobGeoTagging FOR '+@SourceDB+'..JobGeoTagging;')
          EXEC ('CREATE SYNONYM DestJobGeoTagging FOR '  +@DestinationDB+'..JobGeoTagging;')
          EXEC ('CREATE SYNONYM SourceJob FOR '          +@SourceDB+'..Job;')
          INSERT INTO destjobgeotagging
          SELECT     Max(outertable.id)        AS id,
                     Max(outertable.createdon) AS createdon,
                     Max(outertable.createdby) AS createdby,
                     0                         AS isdeleted,
                     outertable.jobid,
                     Max(outertable.serviceworkerid)  AS serviceworkerid,
                     Max(outertable.deviceid)         AS deviceid,
                     Max(outertable.deliveryreportid) AS deliveryreportid,
                     0                                AS latitude,
                     0                                AS longitude,
                     NULL                             AS servicetypeid,
                     NULL                             AS locationname,
                     NULL                             AS locationaddress,
                     NULL                             AS swipedistance,
                     Max(outertable.reportedtime)     AS reportedtime,
                     (
                            SELECT id,
                                   latitude,
                                   longitude,
                                   reportedtime,
                                   jobid,
                                   servicetypeid,
                                   swipedistance,
                                   locationaddress,
                                   locationname
                            FROM   sourcejobgeotagging AS innertable
                            WHERE  innertable.jobid = outertable.jobid FOR json path ) AS jsoncontent
          FROM       sourcejobgeotagging                                               AS outertable
          INNER JOIN sourcejob sj
          ON         sj.id=outertable.jobid
          AND        sj.tenantid=@tenantId
          GROUP BY   outertable.jobid
          -- Dropping temporary synonym
          EXEC ('DROP SYNONYM SourceJobGeoTagging;')
          EXEC ('DROP SYNONYM DestJobGeoTagging;')
          EXEC ('DROP SYNONYM SourceJob;')
        END
        ELSE
        BEGIN
          SELECT @primaryKey=column_name
          FROM   information_schema.key_column_usage
          WHERE  table_name LIKE @tableName
          AND    constraint_name LIKE 'PK%'
          --Select @primaryKey
          SET @tableName ='['+@tableName+']'
          --print @primarykey
          SET @TableHasIdentity =Objectproperty(Object_id(@tableName), 'TableHasIdentity') ;
          IF (@TableHasIdentity = 1)
          BEGIN
            SET @query= @query+'set identity_insert '+@destinationDB+'..'+ @tableName+' on;';
          END
          DECLARE @columns NVARCHAR(max)=
          (
                 SELECT '['+NAME +'], ' AS [text()]
                 FROM   sys.columns
                 WHERE  object_id = Object_id(@tableName) FOR xml path(''))
          SELECT @columns=LEFT(@columns,Len(@columns)-1)--remove last comma
          SET @query= @query+ ' INSERT INTO '+@destinationDB+'..'+@tableName+' ('+@columns+')          SELECT '+@columns+' FROM '+@sourceDB+'..'+@tableName+' with (nolock) WHERE '+@primaryKey+' NOT IN (SELECT DISTINCT '+@primaryKey+' FROM '+@destinationDB+'..'+@tableName +' with (nolock)) '+ Replace(Replace(Replace(Replace(@AdditionalFilterQuery,'@destinationDB',@destinationDB),'@DB',@sourceDB),'@productionDate',@productionDate),'@tenantId',@tenantId) +';';
          IF @columns LIKE '%ProductionDate%'
          BEGIN
            SET @query= @query+ ' Update '+ @destinationDB+'..'+@tableName+' set ProductionDate=''+Cast(@productionDate AS VARCHAR(20))+'' where ProductionDate is null; ';
          END
          --if @columns like '%TenantId%'
          --begin
          --set @query= @query+ ' Update '+ @destinationDB+'..'+@tableName+' set TenantId=''+CAST(@tenantId AS nvarchar(max))+'' where tenantId is null; ';
          --end
          IF (@TableHasIdentity = 1)
          BEGIN
            SET @query =@query+' set identity_insert '+@destinationDB+'.dbo.'+ @tableName+' off;';
          END
          --print @query
        END
      END
      SET @Id=@Id+1;
    END
    --Select @query
    EXEC(@query)
    EXEC sp_updatestats
      -- Enable all constraints for database
      --EXEC sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"
    EXEC ('EXEC '+@destinationDB+'..sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"')
    --UPDATE ServiceWorker SET StatusId=3 WHERE StatusId<>3
  END
GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Job_Related_Table_In_Go]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Delete_Job_Related_Table_In_Go]
AS
BEGIN
               -- Location and Job Related Data Selection ---

--Select count(*) from JobDetail jd with (nolock) LEFT JOIN Job j with (nolock) ON jd.Id=j.Id WHERE j.Id IS NULL

--select count(*) from JobJsonData jjd with (nolock) LEFT JOIN Job j with (nolock) ON jjd.Id = j.Id WHERE j.Id IS NULL

--select count(*) from JobLocation jl with (nolock) LEFT JOIN [Location] l with (nolock) ON jl.LocationId = l.Id WHERE l.Id IS NULL

--Select count(*) from JobLocation jl with (nolock) LEFT JOIN Job j with (nolock) ON jl.JobId = j.Id where j.Id IS NULL

--select count(*) from JobStats js with (nolock) LEFT JOIN Job j with (nolock) ON js.JobId = j.Id WHERE j.Id IS NULL

--select count(*) from LocationProductMapping lpm with (nolock) LEFT JOIN [Location] l with (nolock) ON lpm.LocationId = l.Id WHERE l.Id IS NULL 

              -- Delete Query (Location and Job Related Data)

Delete jd from JobDetail jd LEFT JOIN Job j ON jd.Id=j.Id WHERE j.Id IS NULL

Delete jjd from JobJsonData jjd LEFT JOIN Job j ON jjd.Id = j.Id WHERE j.Id IS NULL

Delete jl from JobLocation jl LEFT JOIN [Location] l ON jl.LocationId = l.Id WHERE l.Id IS NULL

Delete jl from JobLocation jl LEFT JOIN Job j ON jl.JobId = j.Id where j.Id IS NULL

Delete js from JobStats js LEFT JOIN Job j ON js.JobId = j.Id WHERE j.Id IS NULL

Delete lpm from LocationProductMapping lpm LEFT JOIN [Location] l ON lpm.LocationId = l.Id WHERE l.Id IS NULL 
 
                   -- User Related Data Issue ---
--select count(*) from TenantOrganizationUnitMapping tom with (nolock) LEFT JOIN Users u with (nolock) ON tom.UserId = u.Id WHERE u.Id IS NULL

--select count(*) from UserRoles ur with (nolock) LEFT JOIN Users u with (nolock) ON ur.UserId=u.Id WHERE u.Id IS NULL

                   -- Delete Query ( User Related Data)
delete tom from TenantOrganizationUnitMapping tom LEFT JOIN Users u ON tom.UserId = u.Id WHERE u.Id IS NULL

delete ur from UserRoles ur LEFT JOIN Users u ON ur.UserId=u.Id WHERE u.Id IS NULL

END
GO
/****** Object:  StoredProcedure [dbo].[SP_Reset_History_Tables]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

					CREATE PROCEDURE [dbo].[SP_Reset_History_Tables]
                    AS
                    BEGIN
                        DELETE FROM UserLoginHistory WHERE DATEDIFF(DAY,CreatedOn,GETUTCDATE())>28
                        DELETE FROM ServicesPerformedFromBackend WHERE JobId NOT IN (SELECT Id FROM Job) 
                        DELETE FROM JobTaskQueue WHERE DATEDIFF(DAY,CreatedOn,GETUTCDATE())>7
                        DELETE FROM SalarySettlementEmailStatus WHERE DATEDIFF(DAY,CreatedOn,GETUTCDATE())>7 
                        DELETE FROM ImportError WHERE DATEDIFF(DAY,CreatedOn,GETUTCDATE())>7
                        DELETE FROM DashboardUserBasedJobsSeen WHERE JOBID NOT IN (select id from Job)
                    END
GO
/****** Object:  StoredProcedure [dbo].[SP_ResetJobAndTasks]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

				CREATE PROCEDURE [dbo].[SP_ResetJobAndTasks]
				@productionDate Date = Null,
				@tenantId uniqueidentifier  = Null
				AS
				BEGIN
					-- SET NOCOUNT ON added to prevent extra result sets from
					-- interfering with SELECT statements.
					SET NOCOUNT ON;

					ALTER DATABASE [EKL_Packages_Uplift]
					SET RECOVERY SIMPLE

					-- Disable all constraints for database
					EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT all'

					DELETE FROM [Job] WHERE TenantId = @tenantId
					DELETE FROM [JobDetail] WHERE Id NOT IN (SELECT Id FROM Job)  
					DELETE FROM [JobHistory] WHERE JobPrimayId NOT IN (SELECT Id FROM Job)  

					DELETE FROM [JobLocation] WHERE JobId NOT IN (SELECT Id FROM Job)  
					DELETE FROM [Location] WHERE Id NOT IN (SELECT LocationId FROM JobLocation)  
					DELETE FROM [LocationProductMapping] WHERE LocationId NOT IN (SELECT Id FROM Location)

					DELETE FROM [Service] WHERE JobId NOT IN (SELECT Id FROM Job)  
					DELETE FROM [ServiceDetail] WHERE Id NOT IN (SELECT Id FROM [Service])  
					DELETE FROM [ServiceContainerMapping] WHERE ServiceId NOT IN (SELECT Id FROM [Service])  
					DELETE FROM [ServiceStatus] WHERE Id NOT IN (SELECT Id FROM [ServiceContainerMapping])  

					DELETE FROM [JobWayPoint] WHERE Id NOT IN (SELECT Id FROM Job)  
					DELETE FROM [JobJsonData] WHERE Id NOT IN (SELECT Id FROM Job)  
					DELETE FROM [ServiceJsonData] WHERE Id NOT IN (SELECT Id FROM Job)  
					DELETE FROM [Plan] WHERE Id NOT IN (SELECT PlanId FROM Job) AND [Plan].TenantId = @tenantId

					DELETE FROM [PushNotification]
					DELETE FROM [PushNotificationDetail] 
	
					DELETE FROM [CustomerIntegration] WHERE TenantId = @tenantId

					DELETE FROM [DeviceDeliveryReport] WHERE TenantId = @tenantId

					--DELETE FROM FailspotItemTracking  
					DELETE FROM [JobGeoTagging] WHERE JobId NOT IN (SELECT Id FROM Job)
					DELETE FROM [JobInjectedServices] WHERE JobId NOT IN (SELECT Id FROM Job)

					--DELETE FROM [UserTokens] WHERE CAST(CreatedOn AS DATE) <> CAST(GETDATE() AS DATE)
					--AND UserId IN (SELECT UserId FROM [dbo].[TenantUserMapping] WHERE TenantId = @tenantId)

					DELETE FROM [SalarySettlement] WHERE TenantId = @tenantId
					DELETE FROM [JobStats] WHERE TenantId = @tenantId
					Delete from MoveLocationHistory WHERE TenantId = @tenantId
					
					Delete from UserTokens where UserId in (
					select AssigendUserId from Devices where AssigendUserId is not null and  IsDeleted=0 and AssigendUserId in (
					select ServiceWorkerId from Job where TenantId=@tenantId
					))
					and ExpiresOn< GETDATE()

                    DELETE FROM FailspotItemTracking WHERE JobId NOT IN (SELECT Id FROM Job) 

                    DELETE FROM FailedInjectedServices WHERE TenantId = @tenantId
                    
                    DELETE FROM JobWayPointTrigger WHERE TenantId = @tenantId

					ALTER DATABASE [EKL_Packages_Uplift]
					SET RECOVERY FULL

					-- Enable all constraints for database
					EXEC sp_msforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all'
   
				END
GO
/****** Object:  StoredProcedure [dbo].[SP_ServicesListForJobsDetailReport]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ServicesListForJobsDetailReport]
                                @JobIds NVARCHAR(MAX)
                            AS
                            BEGIN
                                -- Drop temporary table if it already exists
                                DROP TABLE IF EXISTS #LocationNumbers;

                                -- Create temporary table to hold location numbers
                                SELECT 
                                    lp.LocationId,
                                    LocationNumber = STUFF(
                                        (
                                            SELECT ',' + CAST(lp2.DAOLocationId AS NVARCHAR)
                                            FROM LocationProductMapping lp2
                                            WHERE lp2.LocationId = lp.LocationId
                                            FOR XML PATH(''), TYPE
                                        ).value('.', 'VARCHAR(MAX)'), 
                                        1, 1, ''
                                    )
                                INTO #LocationNumbers
                                FROM LocationProductMapping lp
                                GROUP BY lp.LocationId;

                                -- Main query to generate report data
                                SELECT 
                                    s.ProductionDate AS ProductionDate,
                                    ISNULL(s.TypeId, 0) AS TypeId,
                                    ISNULL(ss.Status, 0) AS ServiceStatus,
                                    ISNULL(ss.SwipeTime, '1900-01-01') AS SwipeTime,
				                    CAST(ISNULL(SS.SwipeDistance, 0) AS FLOAT) SwipeRadius,
				                    SS.SwipeType SwipeType,
                                    ss.NoteText AS NoteText,
                                    s.SortOrder AS SortOrder,
                                    j.JobNumber AS Route,
                                    ISNULL(c.ProductContainerId, '00000000-0000-0000-0000-000000000000') AS ProductContainerId,
                                    l.Name AS LocationName,
                                    ln.LocationNumber AS LocationNumber,
                                    IIF(ss.NoteType = 'Problem', ss.NoteText, NULL) AS ProblemType,
                                    sd.ProductType AS ProductTypeId,
                                    sd.ItemId AS ItemId,
                                    sd.ObjectType AS ObjectType,
                                    ISNULL(sd.ReceiptType, 0) AS ReceiptType,
                                    s.Id AS ServiceId,
                                    c.JobLocationId AS JobLocationId,
                                    ISNULL(s.ProductTypeId, 0) AS ProductType,
                                    s.JobId AS JobId,
                                    ISNULL(c.ParentContainerId, '00000000-0000-0000-0000-000000000000') AS ParentContainerId,
                                    s.DisplayName AS DisplayName,
                                    ss.Quantity AS ServiceStatusQuantity,
                                    ss.NoteType AS NoteType,
                                    sd.Action AS ServiceAction,
                                    sd.LabelCode AS LabelCode,
                                    c.Id AS ContainerId,
                                    jl.LocationId AS LocationId
                                FROM ServiceContainerMapping c
                                LEFT JOIN Service s ON c.ServiceId = s.Id
                                INNER JOIN (
                                    SELECT value AS JobId 
                                    FROM STRING_SPLIT(@JobIds, ',')
                                ) jt ON s.JobId = jt.JobId
                                LEFT JOIN Job j ON j.Id = s.JobId
                                LEFT JOIN JobLocation jl ON c.JobLocationId = jl.Id
                                LEFT JOIN Location l ON jl.LocationId = l.Id
                                LEFT JOIN #LocationNumbers ln ON l.Id = ln.LocationId
                                LEFT JOIN ServiceDetail sd ON s.Id = sd.Id
                                LEFT JOIN ServiceStatus ss ON c.Id = ss.Id;

                                -- Uncomment if ordering is required
                                -- ORDER BY s.ProductionDate;
                            END;
            
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateGeoTaggingData]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateGeoTaggingData] 
@JobId uniqueidentifier,
@data NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

	--ALTER DATABASE [EKL_Packages_Uplift] SET RECOVERY SIMPLE;

    IF EXISTS (SELECT * FROM JobGeoTagging WHERE JobId = @JobId)
		BEGIN
			DECLARE @existingJson NVARCHAR(MAX);

			-- Get the existing JsonContent for the specified JobId
			SELECT @existingJson = JsonContent
			FROM JobGeoTagging
			WHERE JobId = @JobId;

			IF @existingJson IS NULL
			BEGIN
				-- If JsonContent is NULL, set it to the input JSON array
				UPDATE JobGeoTagging 
				SET JsonContent = @data
				WHERE JobId = @JobId;
			END
			ELSE
			BEGIN
				-- Extract all the objects from the input JSON array
				DECLARE @jsonDataObjects TABLE (JsonData NVARCHAR(MAX));
				INSERT INTO @jsonDataObjects
				SELECT [value]
				FROM OPENJSON(@data);

				DECLARE @jsonDataObject NVARCHAR(MAX);
				DECLARE jsonDataCursor CURSOR FOR
				SELECT JsonData
				FROM @jsonDataObjects;

				OPEN jsonDataCursor;
				FETCH NEXT FROM jsonDataCursor INTO @jsonDataObject;

				-- Append each extracted object to the existing JSON array
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @existingJson = JSON_MODIFY(@existingJson, 'append $', JSON_QUERY(@jsonDataObject));
					FETCH NEXT FROM jsonDataCursor INTO @jsonDataObject;
				END;

				CLOSE jsonDataCursor;
				DEALLOCATE jsonDataCursor;

				-- Update the JsonContent with the appended JSON array
				UPDATE JobGeoTagging 
				SET JsonContent = @existingJson
				WHERE JobId = @JobId;
			END
		END
    
	--ALTER DATABASE [EKL_Packages_Uplift] SET RECOVERY FULL;
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_UpdateJobsStats]    Script Date: 06/05/2025 12:22:21 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_UpdateJobsStats] 
    
AS
BEGIN
   MERGE INTO JobStats AS Target
USING (
SELECT 
    j.Id as JobId,
	s.TenantId,
	j.ProductionDate,
	s.LoadscanPending,
	s.LoadscanProblem,
	s.LoadscanSuccess,
	s.DeliveryPending -s.LoadscanProblem as DeliveryPending,
	s.DeliveryProblem,
	s.DeliverySuccess,
	s.PickupPending,
	s.PickupProblem,
	s.PickupSuccess,
	s.OffloadPending -(s.DeliverySuccess + s.DeliveryPending + s.PickupProblem) as OffloadPending ,
	s.OffloadProblem,
	s.OffloadSuccess,
	s.CompletedStops,
	s.PendingStop,
	s.ProblemStops,
	s.OverallStops,
	(s.LoadscanSuccess+s.PickupSuccess) as TruckIn,
	(s.DeliverySuccess+s.OffloadSuccess) as TruckOut,
	s.PackagingSacks,
	s.PackagingCages,
	s.PackagingPallets,
	s.DeliveredPackagingCages,
	s.DeliveredPackagingPallets,
	s.DeliveredPackagingSacks


FROM Job j
inner JOIN (select  
-- Loadscan section
 Count(CASE WHEN (ServiceDetail.Action='Delivery' and ss.Status is null  AND sc.ProductContainerId in('DAD424A9-CABF-49C0-8C13-F08E778B7F0E','F2358F1B-C1B6-4CF8-AD65-137A6FA2E922','33046DA1-409F-4442-9924-B72CFD5AA552','D1B20A2D-E38A-4A9B-AFEC-870AB1AE4932','3222FAA8-2817-4828-8C94-9CBB8D64E2E9','F97B5D51-EA7B-454B-8058-418FC3210EC6','F79A2511-F18C-42D8-92F4-7BADE17D0B17','3D4817DD-4AE4-4945-B06D-1F963CB9F37D','6BB0400A-DAED-4338-A310-007431388A48','0A1AAC32-6AF0-4423-A7CD-4353B03917B2','7E9021F6-C6E3-40AE-AFAD-A10B607D8D1F','7B2C8884-43F2-4332-B203-F409163E3FDB')) THEN 1  ELSE NULL END) as LoadscanPending,
 Count(CASE WHEN ( ServiceDetail.Action='Delivery' and ss.Status is not null and ss.Status=4  AND sc.ProductContainerId in('DAD424A9-CABF-49C0-8C13-F08E778B7F0E','F2358F1B-C1B6-4CF8-AD65-137A6FA2E922','33046DA1-409F-4442-9924-B72CFD5AA552','D1B20A2D-E38A-4A9B-AFEC-870AB1AE4932','3222FAA8-2817-4828-8C94-9CBB8D64E2E9','F97B5D51-EA7B-454B-8058-418FC3210EC6','F79A2511-F18C-42D8-92F4-7BADE17D0B17','3D4817DD-4AE4-4945-B06D-1F963CB9F37D','6BB0400A-DAED-4338-A310-007431388A48','0A1AAC32-6AF0-4423-A7CD-4353B03917B2','7E9021F6-C6E3-40AE-AFAD-A10B607D8D1F','7B2C8884-43F2-4332-B203-F409163E3FDB')) THEN 1  ELSE NULL END) as LoadscanProblem,
 Count(CASE WHEN ( ServiceDetail.Action='Delivery' and ss.Status is not null and ss.Status=3  AND sc.ProductContainerId in('DAD424A9-CABF-49C0-8C13-F08E778B7F0E','F2358F1B-C1B6-4CF8-AD65-137A6FA2E922','33046DA1-409F-4442-9924-B72CFD5AA552','D1B20A2D-E38A-4A9B-AFEC-870AB1AE4932','3222FAA8-2817-4828-8C94-9CBB8D64E2E9','F97B5D51-EA7B-454B-8058-418FC3210EC6','F79A2511-F18C-42D8-92F4-7BADE17D0B17','3D4817DD-4AE4-4945-B06D-1F963CB9F37D','6BB0400A-DAED-4338-A310-007431388A48','0A1AAC32-6AF0-4423-A7CD-4353B03917B2','7E9021F6-C6E3-40AE-AFAD-A10B607D8D1F','7B2C8884-43F2-4332-B203-F409163E3FDB')) THEN 1  ELSE NULL END) as LoadscanSuccess,
 -- Loadscan End

 Count(CASE WHEN ( ServiceDetail.Action='Delivery' and  ss.Status is null and sc.ProductContainerId in('DCC54AA5-0C84-4379-867C-F78C29E98EB5','8B022DD1-8D0B-4C09-AD9A-F97838040E97','8725E679-2D64-43BE-8E73-A1725E46D08A'
 ,'6130CBFA-6389-4318-9514-E9CB874F8F75','A1D51666-8FC5-4B5C-9329-79F5FACB8AE5','E62E61FA-423D-4D6E-80CA-133DBF6D4004','C5170A1B-4F91-4414-AAEB-306D0520749A','D8E872BA-F3E2-4EE6-9DA4-0DEA8E47C96B'
 ,'6B3E8533-1809-4653-B5E5-C124D5B48E41','90fd9406-e08d-4a28-8114-e6e0a0550330','D9A25BDD-060B-4EDC-9D44-AFD280110D91','264E1360-CC69-4E34-99CB-FFE2746DABB0','7C2AEA08-F83D-4C01-91E0-19DCCC08AD2E') 
 )THEN 1  ELSE NULL END) as DeliveryPending,
 Count(CASE WHEN ( ServiceDetail.Action='Delivery' and ss.Status is not null and ss.Status=3 and sc.ProductContainerId in('DCC54AA5-0C84-4379-867C-F78C29E98EB5','8B022DD1-8D0B-4C09-AD9A-F97838040E97','8725E679-2D64-43BE-8E73-A1725E46D08A'
 ,'6130CBFA-6389-4318-9514-E9CB874F8F75','A1D51666-8FC5-4B5C-9329-79F5FACB8AE5','E62E61FA-423D-4D6E-80CA-133DBF6D4004','C5170A1B-4F91-4414-AAEB-306D0520749A','D8E872BA-F3E2-4EE6-9DA4-0DEA8E47C96B'
 ,'6B3E8533-1809-4653-B5E5-C124D5B48E41','90fd9406-e08d-4a28-8114-e6e0a0550330','D9A25BDD-060B-4EDC-9D44-AFD280110D91','264E1360-CC69-4E34-99CB-FFE2746DABB0','7C2AEA08-F83D-4C01-91E0-19DCCC08AD2E') 
 )THEN 1  ELSE NULL END) as DeliverySuccess,
 Count(CASE WHEN ( ServiceDetail.Action='Delivery' and ss.Status is not null and ss.Status=4  and sc.ProductContainerId in('DCC54AA5-0C84-4379-867C-F78C29E98EB5','8B022DD1-8D0B-4C09-AD9A-F97838040E97','8725E679-2D64-43BE-8E73-A1725E46D08A'
 ,'6130CBFA-6389-4318-9514-E9CB874F8F75','A1D51666-8FC5-4B5C-9329-79F5FACB8AE5','E62E61FA-423D-4D6E-80CA-133DBF6D4004','C5170A1B-4F91-4414-AAEB-306D0520749A','D8E872BA-F3E2-4EE6-9DA4-0DEA8E47C96B'
 ,'6B3E8533-1809-4653-B5E5-C124D5B48E41','90fd9406-e08d-4a28-8114-e6e0a0550330','D9A25BDD-060B-4EDC-9D44-AFD280110D91','264E1360-CC69-4E34-99CB-FFE2746DABB0','7C2AEA08-F83D-4C01-91E0-19DCCC08AD2E') 
 )THEN 1  ELSE NULL END) as DeliveryProblem,
  -- Pickup section
 Count(CASE WHEN ( ServiceDetail.Action='Pickup' and  ss.Status is null and sc.ProductContainerId in('8B022DD1-8D0B-4C09-AD9A-F97838040E97','8725E679-2D64-43BE-8E73-A1725E46D08A'
 ,'6130CBFA-6389-4318-9514-E9CB874F8F75','A1D51666-8FC5-4B5C-9329-79F5FACB8AE5','E62E61FA-423D-4D6E-80CA-133DBF6D4004','C5170A1B-4F91-4414-AAEB-306D0520749A','D8E872BA-F3E2-4EE6-9DA4-0DEA8E47C96B'
 ,'6B3E8533-1809-4653-B5E5-C124D5B48E41','90fd9406-e08d-4a28-8114-e6e0a0550330','D9A25BDD-060B-4EDC-9D44-AFD280110D91','264E1360-CC69-4E34-99CB-FFE2746DABB0','7C2AEA08-F83D-4C01-91E0-19DCCC08AD2E','DCC54AA5-0C84-4379-867C-F78C29E98EB5') 
 )THEN 1  ELSE NULL END) as PickupPending,
 Count(CASE WHEN ( ServiceDetail.Action='Pickup' and ss.Status is not null and ss.Status=3 and sc.ProductContainerId in('8B022DD1-8D0B-4C09-AD9A-F97838040E97','8725E679-2D64-43BE-8E73-A1725E46D08A'
 ,'6130CBFA-6389-4318-9514-E9CB874F8F75','A1D51666-8FC5-4B5C-9329-79F5FACB8AE5','E62E61FA-423D-4D6E-80CA-133DBF6D4004','C5170A1B-4F91-4414-AAEB-306D0520749A','D8E872BA-F3E2-4EE6-9DA4-0DEA8E47C96B'
 ,'6B3E8533-1809-4653-B5E5-C124D5B48E41','90fd9406-e08d-4a28-8114-e6e0a0550330','D9A25BDD-060B-4EDC-9D44-AFD280110D91','264E1360-CC69-4E34-99CB-FFE2746DABB0','7C2AEA08-F83D-4C01-91E0-19DCCC08AD2E','DCC54AA5-0C84-4379-867C-F78C29E98EB5') 
 )THEN 1  ELSE NULL END) as PickupSuccess,
 Count(CASE WHEN ( ServiceDetail.Action='Pickup' and ss.Status is not null and ss.Status=4  and sc.ProductContainerId in('8B022DD1-8D0B-4C09-AD9A-F97838040E97','8725E679-2D64-43BE-8E73-A1725E46D08A'
 ,'6130CBFA-6389-4318-9514-E9CB874F8F75','A1D51666-8FC5-4B5C-9329-79F5FACB8AE5','E62E61FA-423D-4D6E-80CA-133DBF6D4004','C5170A1B-4F91-4414-AAEB-306D0520749A','D8E872BA-F3E2-4EE6-9DA4-0DEA8E47C96B'
 ,'6B3E8533-1809-4653-B5E5-C124D5B48E41','90fd9406-e08d-4a28-8114-e6e0a0550330','D9A25BDD-060B-4EDC-9D44-AFD280110D91','264E1360-CC69-4E34-99CB-FFE2746DABB0','7C2AEA08-F83D-4C01-91E0-19DCCC08AD2E','DCC54AA5-0C84-4379-867C-F78C29E98EB5') 
 )THEN 1  ELSE NULL END) as PickupProblem,
  -- Pickup section End

    -- Offload section
 Count(CASE WHEN (   ss.Status is null and sc.ProductContainerId in('839A9D6E-A0FD-494E-A9AE-8D16F58E0335','77547727-215D-46E4-9257-2E01604850D7','52D24E42-446C-4F2E-AF32-1765DE3668F5'
 ,'8AC59845-0020-4D36-96AD-46F5A3BAD3D9','B9E3B612-58A0-4FB8-BEC0-A044AC960705','0D43097D-4D1B-4761-B21F-4039D07D49E5','B58D3D7A-BEAD-4C35-9665-BB2D21BD2E60','19357951-AA6D-4658-BC02-D53F1BD4CA20'
 ,'A1C9D1B7-D0AE-4F05-AC35-B939727A1788','D3073D3C-A538-464B-98EA-26690E9B547C','E9070B51-110F-4BFE-A3E9-981C4FA87D72','12C7EB59-AE18-4FF3-A48E-E58096A81A27') 
 )THEN 1  ELSE NULL END) as OffloadPending,
 Count(CASE WHEN (   ss.Status is not null and ss.Status=3 and sc.ProductContainerId in('839A9D6E-A0FD-494E-A9AE-8D16F58E0335','77547727-215D-46E4-9257-2E01604850D7','52D24E42-446C-4F2E-AF32-1765DE3668F5'
 ,'8AC59845-0020-4D36-96AD-46F5A3BAD3D9','B9E3B612-58A0-4FB8-BEC0-A044AC960705','0D43097D-4D1B-4761-B21F-4039D07D49E5','B58D3D7A-BEAD-4C35-9665-BB2D21BD2E60','19357951-AA6D-4658-BC02-D53F1BD4CA20'
 ,'A1C9D1B7-D0AE-4F05-AC35-B939727A1788','D3073D3C-A538-464B-98EA-26690E9B547C','E9070B51-110F-4BFE-A3E9-981C4FA87D72','12C7EB59-AE18-4FF3-A48E-E58096A81A27') 
 )THEN 1  ELSE NULL END) as OffloadSuccess,
 Count(CASE WHEN (  ss.Status is not null and ss.Status=4  and sc.ProductContainerId in('839A9D6E-A0FD-494E-A9AE-8D16F58E0335','77547727-215D-46E4-9257-2E01604850D7','52D24E42-446C-4F2E-AF32-1765DE3668F5'
 ,'8AC59845-0020-4D36-96AD-46F5A3BAD3D9','B9E3B612-58A0-4FB8-BEC0-A044AC960705','0D43097D-4D1B-4761-B21F-4039D07D49E5','B58D3D7A-BEAD-4C35-9665-BB2D21BD2E60','19357951-AA6D-4658-BC02-D53F1BD4CA20'
 ,'A1C9D1B7-D0AE-4F05-AC35-B939727A1788','D3073D3C-A538-464B-98EA-26690E9B547C','E9070B51-110F-4BFE-A3E9-981C4FA87D72','12C7EB59-AE18-4FF3-A48E-E58096A81A27') 
 )THEN 1  ELSE NULL END) as OffloadProblem,
  -- Offload section End
  --location Section
 Count(CASE WHEN (   ss.Status is null and sr.TypeId=7 
 )THEN 1  ELSE NULL END) as PendingStop,
 Count(CASE WHEN (   ss.Status is not null and ss.Status=3 and sr.TypeId=7
 )THEN 1  ELSE NULL END) as CompletedStops,
 Count(CASE WHEN (  ss.Status is not null and ss.Status=4 and sr.TypeId=7
 )THEN 1  ELSE NULL END) as ProblemStops,
  Count(CASE WHEN ( sr.TypeId=7
 )THEN 1  ELSE NULL END) as OverallStops,
 --location section End

 --packaging section
  sum(CASE WHEN (   ss.Status is not null and sr.TypeId=22 and sc.ParentContainerId in('6B98513D-24F6-43F4-B087-96F61930D532') 
 )THEN ss.Quantity ELSE 0 END) as PackagingSacks,
 sum(CASE WHEN (   ss.Status is not null and sr.TypeId=20 and sc.ParentContainerId in('6B98513D-24F6-43F4-B087-96F61930D532') 
 )THEN ss.Quantity ELSE 0 END) as PackagingCages,
 sum(CASE WHEN (   ss.Status is not null and sr.TypeId=21 and sc.ParentContainerId in('6B98513D-24F6-43F4-B087-96F61930D532') 
 )THEN ss.Quantity ELSE 0 END) as PackagingPallets,
  sum(CASE WHEN (   ss.Status is not null and sr.TypeId=22 and sc.ParentContainerId in('B71255CC-6F14-4E00-AA20-37C5B5B49D62') 
 )THEN ss.Quantity ELSE 0 END) as DeliveredPackagingSacks,
 sum(CASE WHEN (   ss.Status is not null and sr.TypeId=20 and sc.ParentContainerId in('B71255CC-6F14-4E00-AA20-37C5B5B49D62') 
 )THEN ss.Quantity ELSE 0 END) as DeliveredPackagingCages,
 sum(CASE WHEN (   ss.Status is not null and sr.TypeId=21 and sc.ParentContainerId in('B71255CC-6F14-4E00-AA20-37C5B5B49D62') 
 )THEN ss.Quantity ELSE 0 END) as DeliveredPackagingPallets,

 --packaging end 

 sr.JobId ,
 sr.TenantId

from ServiceContainerMapping sc
left join ServiceDetail on sc.ServiceId=ServiceDetail.Id
inner JOIN Service sr ON sr.Id = sc.ServiceId
left JOIN ServiceStatus ss ON sc.Id = ss.Id
group by sr.JobId ,sr.TenantId
) s ON j.Id = s.JobId
group  by j.Id,
	s.TenantId,

	j.ProductionDate,
	s.LoadscanPending,
	s.LoadscanProblem,
	s.LoadscanSuccess,
	s.DeliveryPending,
	s.DeliveryProblem,
	s.DeliverySuccess,
	s.PickupPending,
	s.PickupProblem,
	s.PickupSuccess,
	s.OffloadPending,
	s.OffloadProblem,
	s.OffloadSuccess,
	s.TenantId,s.CompletedStops,
	s.PendingStop,
	s.ProblemStops,
	s.OverallStops,
	s.PackagingSacks,
	s.PackagingCages,
	s.PackagingPallets,
	s.DeliveredPackagingCages,
	s.DeliveredPackagingPallets,
	s.DeliveredPackagingSacks

	)as Source

	ON Target.JobId = Source.JobId

	WHEN MATCHED THEN 
    UPDATE SET 
	
			  Target.LoadscanPending = Source.LoadscanPending, 
			  Target.LoadscanProblem= Source.LoadscanProblem,
			  Target.LoadscanSuccess  = Source.LoadscanSuccess,  
			  Target.DeliveryPending  = Source.DeliveryPending,  
			  Target.DeliveryProblem  = Source.DeliveryProblem , 
			  Target.DeliverySuccess = Source.DeliverySuccess, 
			  Target.PickupPending = Source.PickupPending, 
			  Target.PickupProblem  = Source.PickupProblem , 
			  Target.PickupSuccess= Source.PickupSuccess,
			  Target.OffloadPending = Source.OffloadPending ,
			  Target.OffloadProblem = Source.OffloadProblem, 
			  Target.OffloadSuccess = Source.OffloadSuccess ,
			  Target.CompletedStops = Source.CompletedStops, 
			  Target.PendingStop = Source.PendingStop ,
			  Target.ProblemStops = Source.ProblemStops ,
			  Target.OverallStops = Source.OverallStops, 
			  Target.TruckIn  = Source.TruckIn , 
			  Target.TruckOut = Source.TruckOut, 
			  Target.PackagingSacks  = Source.PackagingSacks , 
			  Target.PackagingCages  = Source.PackagingCages , 
			  Target.PackagingPallets  = Source.PackagingPallets , 
			  Target.DeliveredPackagingCages = Source.DeliveredPackagingCages , 
			  Target.DeliveredPackagingPallets= Source.DeliveredPackagingPallets, 
			  Target.DeliveredPackagingSacks = Source.DeliveredPackagingSacks 
			   
WHEN NOT MATCHED BY TARGET THEN 
    INSERT (Id,JobId,TenantId,ProductionDate,
	LoadscanPending, 
	LoadscanProblem,  
	LoadscanSuccess,  
	DeliveryPending,  
	DeliveryProblem , 
	DeliverySuccess, 
	PickupPending, 
	PickupProblem , 
	PickupSuccess,
	OffloadPending ,
	OffloadProblem, 
	OffloadSuccess ,
	CompletedStops, 
	PendingStop ,
	ProblemStops ,
	OverallStops, 
	TruckIn , 
	TruckOut, 
	PackagingSacks , 
	PackagingCages , 
	PackagingPallets , 
	DeliveredPackagingCages ,
	DeliveredPackagingPallets,
	DeliveredPackagingSacks )

    VALUES (
	newid(),
	Source.JobId, 
	Source.TenantId, 
	Source.ProductionDate, 
	Source.LoadscanPending, 
			 Source.LoadscanProblem,
			 Source.LoadscanSuccess,  
			 Source.DeliveryPending,  
			 Source.DeliveryProblem , 
			 Source.DeliverySuccess, 
			 Source.PickupPending, 
			 Source.PickupProblem , 
			 Source.PickupSuccess,
			 Source.OffloadPending ,
			 Source.OffloadProblem, 
			 Source.OffloadSuccess ,
			 Source.CompletedStops, 
			 Source.PendingStop ,
			 Source.ProblemStops ,
			 Source.OverallStops, 
			 Source.TruckIn , 
			 Source.TruckOut, 
			 Source.PackagingSacks , 
			 Source.PackagingCages , 
			 Source.PackagingPallets , 
			 Source.DeliveredPackagingCages ,
			 Source.DeliveredPackagingPallets,
			 Source.DeliveredPackagingSacks );

END;
GO
