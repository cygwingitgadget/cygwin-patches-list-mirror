Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
 by sourceware.org (Postfix) with ESMTPS id 11C903972004
 for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2021 22:48:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 11C903972004
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNvYSGNVLu2bYPU5agg1VDcm2YJd5E1p/ZBw1TD11MO9yht8+c/hSmlgALjoxAS30Pud0HOJzR8C7Ii9OeDVG0TnY0P1xiW3mbQNLMoHokUIzwxMj9rlYCjv/e1L4PiMduCH0X+UXq8ywU4JXC+DCSFvYn1UYKRn8C862wsT57G2oIvQi6RP6JrF+e864wklEZOOtKzVpz8HTYsS16ECdUu9jna1Cd/It0wXJ7O/9cYc3m+HFQ9Gzw9I1gBgAd0t9uQQur3gKVkz6NTDy3aAvAR/MF9iWZ2pKYrzPDUOVKIs/NBHVmZkjsSzCntf896fSpAYrCEBuXO88+tH74Qz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1A6+cS1krad2INLvKazZAqaDy1zo6dbBMoGoFQ1Gcg=;
 b=IYOtEQobFpNkyAnIcO8VdPxxdZGjSf6sJ4zvzmzlIDjeu8AHl0I1mamRRctYGs8pxDItCwQuRjRVKjU+k+EaWuC5RRpZRdguGtvUB7sDUIEFMu3k3wHYTbPYjWkBrQpKeVCpsrTRpEZQevRiff9LxXH6TgPAI3UJLvcI8tBCNq1hSOsQlXOR1rSIIiImzFpeHbqI/NbUCSN7a6mqH4tLj7JMy6BdkgHDDZrO+x5//OEkDrb7sGjM1alqL/uxxrf7k+A0F5YgzGZbHfZ6PnNVltP8K6wpWsOOOCOo1ga0JI21I4KgPhVIs39mQfkNQ4GV7uXNcvQ572FKgAeTkIS2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6163.namprd04.prod.outlook.com (2603:10b6:408:5c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 22:48:35 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 22:48:35 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/7] Cygwin: fix fstatvfs on sockets that are not socket files
Date: Thu, 25 Feb 2021 17:48:07 -0500
Message-Id: <20210225224812.61523-3-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225224812.61523-1-kbrown@cornell.edu>
References: <20210225224812.61523-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.194.34.31]
X-ClientProxiedBy: MN2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:208:236::23) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (24.194.34.31) by
 MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend
 Transport; Thu, 25 Feb 2021 22:48:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c98fe3d-c869-4c6d-f1dd-08d8d9df7bac
X-MS-TrafficTypeDiagnostic: BN8PR04MB6163:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6163DBA0979BEC415C5680DFD89E9@BN8PR04MB6163.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pzBHFlUJ9YtpFgMJTHjcXYgQOLrfeLFntERo8gXn0vUUYZ7XMMy3f4xW49wd9/0yVFf1MQAtQvJw4BszJg8logY1mZ9CWYzmL/ThjA3SH2H5kyTKwPp3LAUCEyE9bO9n7hyzpcbwHzXE33dJbJB1JU9Isa1eWIiQph7E7W3GU4MaZ2lSDmEd4/dEKGY0owbgO6icm+77Hq+clG2CgzZJ5T4/C8CdGEotObZvnZwAE+unCTaUW71ox1/vLivNmcaDBO3uKWkNxSYnrCBcy333Mup59e5ajkskB9pT/UQznPbvuhnd8KVrg6oi1eVj0VLBu5BvbEr2D35yam8GknrvBMQSdoPI5wz7MtIQWqK3SwknzNe7peqHRl42Ms5WTc+ZJWZfU7U9eeavkJgodFkrv9lMu9LgmIkt3qvlW2L45V+TyswayGLuPoV/AFC/Ul1E8dtqrzOjxzM7dXq+gMC8HU9eChNjzn2wKyye3fiVhA9KKk04Ia5ushQgGzNR43i90HnA2A+UYlvJja+9gvvpmPzQC8hyB0KSTj0vg4U/72jYsT1GjdyLR9FC+/EAsntIrYTKunK9T+1fvkRd99M1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(26005)(8936002)(66476007)(66556008)(86362001)(6916009)(16526019)(186003)(8676002)(66946007)(2616005)(316002)(36756003)(6512007)(956004)(75432002)(52116002)(83380400001)(2906002)(6486002)(69590400012)(478600001)(6506007)(786003)(5660300002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pQxbok4qsARMeHjXn9beNaESbdCO0NtW4TiF6/RdSgLNleMSnxcpGXQUMrxU?=
 =?us-ascii?Q?R0az9ma1L8UPXCx5bZJOYW6bqEiI9mxfYQARmiWu/uECXfqC0EmloYKgjXJr?=
 =?us-ascii?Q?BR7AIi0gRDFdLrLTbJ1FV5wQFjTdL7Ae9iujOe/QNAIsCVlIRgV1HbxQb+Xw?=
 =?us-ascii?Q?+zJocZ1o5DkneS7YvI3xHWvRtAtfbWTUCkcab8xSb4VGyMwKTKFjqGy4Pxs/?=
 =?us-ascii?Q?2dUsdnsphpcSEDTMAYkIthEdyH7Ib0mypyHOlqbZwwaD3K5iLVTBsj7q02M+?=
 =?us-ascii?Q?a2Xecmbbj7NJEEBfKzHPfvhVwbmuwdUF7IkYBaSZPW4LjgwdLRXP9Y7Rj7Iw?=
 =?us-ascii?Q?9u/Z2dpJYTreLYlNpb7HEZFnekC1kCHxw2jJBxXdz58iWBPw6daQ631CraH7?=
 =?us-ascii?Q?tiE7sF+C0CxG9d/XQDxSIqdbNeDysS3R5QLN+Jrvl6K367BEB+zQiMPs12Lf?=
 =?us-ascii?Q?yFnbWHoe+IVqewaU6WaJhbza0Jvq2eybakBTK98tNWpCucWg7mtqfozIMwmd?=
 =?us-ascii?Q?iUdnsJo/myVIYeJn7dCFiwqIj7GaOW1LzrDh4/sAWp77+UZ39wV023CzRlsx?=
 =?us-ascii?Q?zDIZgE+DrvS5I4ggCy2saAZiuVswHlTRXRw+1s8PMS3jp4O37/8eDOZpdc6n?=
 =?us-ascii?Q?24TW8HCYQ5iKK/KDrSKUdyB3KmuYVrY+ZBImGpIU1PM8Czl/mck6vchzZcok?=
 =?us-ascii?Q?+Srp2hOHVNaJl7tgP+Ysg1WmWNff9T/08WVuVkUQfg2JVWFk881tZ5VTkbCT?=
 =?us-ascii?Q?jQQyC1qBNIKIWcxF+dm6zD1Q8wsehUGkuspJ5WtwDBymE2/VQ+Ju3YaJbZsV?=
 =?us-ascii?Q?ZGUb9LUFI98L6+xoOSlhC0WHPRZVO9Lo7+bPHVtR922tbBoAVtE9oUy96cYc?=
 =?us-ascii?Q?z7A0tFhYmFsluWJxGB8RkA8SvMhNPKwiav0pCzKQgKM9d/JIc65ZhIxpLQb+?=
 =?us-ascii?Q?K+o4BUR1dULFPuyK8n87ihp5ipguuArvrZ8w+FqXZq8ObhUsV5epAOKHhk5C?=
 =?us-ascii?Q?oaBYH06FqvzxFfwNXtuGNRcSQoQf5tStS7We34WwfR7oXmX5+QaKHfpNMd6M?=
 =?us-ascii?Q?zgiT51UTIoX/OkScuLvUf9vXD2wAHJFsZfA5OkQbi3w2DQGlN/NM5XGoFjWn?=
 =?us-ascii?Q?pD8Fxbzyz1FIjcf+0L1sgup9g6bOU7+4NmmqyMSLEsZyWkEXxOrrEj21TT4d?=
 =?us-ascii?Q?DWXnDU3IM2EJnyvlt0BqLfj8QtWRijiOXLqZKET/mCpDmIIs4FGwOH1OATr9?=
 =?us-ascii?Q?8piCbbgHxbhO1bGM/ARTOCgZDiDafOVXi0CuKq0IMLNMbYDSEeA+1RJ71j0d?=
 =?us-ascii?Q?c24brnX1m30JnwON/wG309zz?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c98fe3d-c869-4c6d-f1dd-08d8d9df7bac
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 22:48:35.0860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmW1AySmEmT0kpeNGX3hTvU+5yQGEum89BVwKksrpL5et0wEUuMtVCtXHVCdEFqT5j1Inclm+VX7FF3xBJGpwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6163
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 25 Feb 2021 22:48:40 -0000

If fstatvfs(2) is called on an AF_LOCAL or AF_UNIX socket that is not
a socket file, the current code calls fhandler_disk_file::fstatvfs in
most cases.  The latter expects to be operating on a disk file and
uses the socket's io_handle, which is not a file handle.

Fix this by calling fhandler_disk_file::fstatvfs only if the
fhandler_socket object is a socket file (determined by testing
dev().isfs()).
---
 winsup/cygwin/fhandler_socket_local.cc |  5 ++++-
 winsup/cygwin/fhandler_socket_unix.cc  | 14 +++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index f8adf6c46..5ca6d8550 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -690,8 +690,11 @@ fhandler_socket_local::fstat (struct stat *buf)
 int __reg2
 fhandler_socket_local::fstatvfs (struct statvfs *sfs)
 {
-  if (get_sun_path () && get_sun_path ()[0] == '\0')
+  if (!dev ().isfs ())
+    /* fstatvfs called on a socket. */
     return fhandler_socket_wsock::fstatvfs (sfs);
+
+  /* statvfs on a socket file or fstatvfs on a socket opened w/ O_PATH. */
   if (get_flags () & O_PATH)
     /* We already have a handle. */
     {
diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index 8091fa820..06db929ed 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -2354,10 +2354,18 @@ fhandler_socket_unix::fstat (struct stat *buf)
 int __reg2
 fhandler_socket_unix::fstatvfs (struct statvfs *sfs)
 {
-  if (sun_path ()
-      && (sun_path ()->un_len <= (socklen_t) sizeof (sa_family_t)
-	  || sun_path ()->un.sun_path[0] == '\0'))
+  if (!dev ().isfs ())
+    /* fstatvfs called on a socket. */
     return fhandler_socket::fstatvfs (sfs);
+
+  /* statvfs on a socket file or fstatvfs on a socket opened w/ O_PATH. */
+  if (get_flags () & O_PATH)
+    /* We already have a handle. */
+    {
+      HANDLE h = get_handle ();
+      if (h)
+	return fstatvfs_by_handle (h, sfs);
+    }
   fhandler_disk_file fh (pc);
   fh.get_device () = FH_FS;
   return fh.fstatvfs (sfs);
-- 
2.30.0

