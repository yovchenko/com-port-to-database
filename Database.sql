USE [master]
GO
/****** Object:  Database [Com_Port]    
Script Date: 12/8/2020 9:26:48 PM 
The script was generated with MS SQL Express v.15.0.2000.5 
Author Volodymyr M. Yovchenko ******/
CREATE DATABASE [Com_Port]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Com_Port', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Com_Port.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Com_Port_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Com_Port_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Com_Port] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Com_Port].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Com_Port] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Com_Port] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Com_Port] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Com_Port] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Com_Port] SET ARITHABORT OFF 
GO
ALTER DATABASE [Com_Port] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Com_Port] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Com_Port] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Com_Port] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Com_Port] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Com_Port] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Com_Port] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Com_Port] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Com_Port] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Com_Port] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Com_Port] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Com_Port] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Com_Port] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Com_Port] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Com_Port] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Com_Port] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Com_Port] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Com_Port] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Com_Port] SET  MULTI_USER 
GO
ALTER DATABASE [Com_Port] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Com_Port] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Com_Port] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Com_Port] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Com_Port] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Com_Port] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Com_Port] SET QUERY_STORE = OFF
GO
USE [Com_Port]
GO
/****** Object:  Table [dbo].[port_config]    Script Date: 12/8/2020 9:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[port_config](
	[port_name] [varchar](31) NOT NULL,
	[baud_rate] [int] NOT NULL,
	[data_bits] [smallint] NOT NULL,
	[stop_bits] [varchar](31) NOT NULL,
	[parity] [varchar](31) NOT NULL,
	[handshake] [varchar](31) NOT NULL,
	[timeout] [int] NOT NULL,
 CONSTRAINT [PK_portConfig] PRIMARY KEY CLUSTERED 
(
	[port_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[port_data]    Script Date: 12/8/2020 9:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[port_data](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[port_name] [varchar](31) NOT NULL,
	[send_data] [varchar](max) NULL,
	[response_data] [varchar](max) NULL,
	[response_date_time] [datetime] NULL,
 CONSTRAINT [PK_dataTable] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[port_data]  WITH CHECK ADD  CONSTRAINT [FK_port_data_port_config] FOREIGN KEY([port_name])
REFERENCES [dbo].[port_config] ([port_name])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[port_data] CHECK CONSTRAINT [FK_port_data_port_config]
GO
ALTER TABLE [dbo].[port_config]  WITH CHECK ADD  CONSTRAINT [CK__port_conf__data] CHECK  (([data_bits]=(4) OR [data_bits]=(5) OR [data_bits]=(6) OR [data_bits]=(7) OR [data_bits]=(8)))
GO
ALTER TABLE [dbo].[port_config] CHECK CONSTRAINT [CK__port_conf__data]
GO
ALTER TABLE [dbo].[port_config]  WITH CHECK ADD  CONSTRAINT [CK__port_conf__hands] CHECK  (([handshake]='None' OR [handshake]='RequestToSend' OR [handshake]='RequestToSendXOnXOff' OR [handshake]='XOnXOff'))
GO
ALTER TABLE [dbo].[port_config] CHECK CONSTRAINT [CK__port_conf__hands]
GO
ALTER TABLE [dbo].[port_config]  WITH CHECK ADD  CONSTRAINT [CK__port_conf__parit] CHECK  (([parity]='Even' OR [parity]='Mark' OR [parity]='None' OR [parity]='Odd' OR [parity]='Space'))
GO
ALTER TABLE [dbo].[port_config] CHECK CONSTRAINT [CK__port_conf__parit]
GO
ALTER TABLE [dbo].[port_config]  WITH CHECK ADD  CONSTRAINT [CK__port_conf__port] CHECK  (([port_name] like 'COM[1-9][0-9]' OR [port_name] like 'COM[1-9]'))
GO
ALTER TABLE [dbo].[port_config] CHECK CONSTRAINT [CK__port_conf__port]
GO
ALTER TABLE [dbo].[port_config]  WITH CHECK ADD  CONSTRAINT [CK__port_conf__stop] CHECK  (([stop_bits]='One' OR [stop_bits]='OnePointFive' OR [stop_bits]='Two'))
GO
ALTER TABLE [dbo].[port_config] CHECK CONSTRAINT [CK__port_conf__stop]
GO
USE [master]
GO
ALTER DATABASE [Com_Port] SET  READ_WRITE 
GO
