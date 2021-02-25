Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
 by sourceware.org (Postfix) with ESMTPS id 6FA383972004
 for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2021 22:48:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6FA383972004
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8WsSeN8q3/jb4dYxR1qwTpy2G60FQctRYQR8lt4Ranw71eD4ngls/6OjDk76hbH91nGmh2F00A7QtuJHW4v7trglfV5Z6CFo0lKHmub4yK7XZbXu+5ApiGeb8mhgypOYeLwtJyBTCQ2953DRrVjbz7LFjHW51G9bexJAmcUq2WzRUqQimpLhZb4PHgvdriqgKYa33pK+64AlqYyL5DGGNcoMsFYti3OJvaXbTCBIQJZBDQLzIfL2awvBPjDh2S4MMO2ywibV7SXwMGeLEd6AKpjf9wquM6/oGx1QU0gs62kd0l1AHWFIvl5bZmiYn1CbB5YIrqTOB5vb4zS+2ojbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY7WwFiEVmxX6kOUpGgwJQDu6LwSWoMomhcxxHDWRJY=;
 b=hUBYSxOWuFCk9DVVkAUdIjmHmZam4tkUZhO+j716vhRdYfJN4hzQ8TyFx765XDWSbysVYLmuK4G/jo+RQ6FbX5k84iGyLlnA/lRKqqt6YoHLJLML9xqLVxh1YpqyCCXuTtuQO2MVmxGUlBogRKmSiVJ23QMg9H//G6qsT8S8Vo0cIGITD6l/OykAp53ajbdS7jSh0prir8kI6LR7wVcuIZX7TFnA0hAj1sSEpxEEvS0PjBb0C1f4k0JO2XfEwiGZyc7b/0TqmXMCntbaKCvb272ihESxCxwJ/odtDJ8NvSFPpftocHv4X65RniYtz0Wts0ip2kOfWD/tnzu1Uxvs5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6163.namprd04.prod.outlook.com (2603:10b6:408:5c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 22:48:34 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 22:48:34 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/7] Cygwin: fix fstat on sockets that are not socket files
Date: Thu, 25 Feb 2021 17:48:06 -0500
Message-Id: <20210225224812.61523-2-kbrown@cornell.edu>
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
 Transport; Thu, 25 Feb 2021 22:48:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f20033-8a53-4ae8-5ada-08d8d9df7b27
X-MS-TrafficTypeDiagnostic: BN8PR04MB6163:
X-Microsoft-Antispam-PRVS: <BN8PR04MB61635AD60AF639744FA61DE1D89E9@BN8PR04MB6163.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrcBqcmPT8GgVlLBxQiySDaDHdUguINJuDswhGpHePMztNr1U3nmdvfjuKiunvh4/2jl9URWgjweXcd4d3I78DUWQ5D7yFsLJDTM959GUosLkTRORXc+HkLOsJ0hzoEYa+u0X1SlBjZLg4whTPgcRurH8CH6mrIXAiSu54ScUhezryuUhQLqzHt3THOCcYjn/CMoVEJ44hki79jy3dR5KvJDlXzIz8w44qWVxJ7V1dNbJw0jCh388Aq/nhQZovJfhygidXW4wiAqMGRUUBJiXHhymEPvnGxJJRoUJDVry0lulSkNUz1owjrqlnYSiSsb+TSg5pViBC6tEaZJOZLRMfwIfCMJBDHQ8+LhB6iiaQSNRZY2zXCNPqFifL+4H0qejfDW/5nTt5NuFcwVDYcekzIr1fjSErLWL6CdYJPP+cejGURJwntNKmkVhysFZZeyRaS5E3BMcoBLSjNwT+LiM7AN6nKCCbooIA043ThuR9eSy9ZWJ3zPxydx8840oKZdf4MUgLPwuHbN6FP4fTUWCWDGtq1k9N886aRVYQAnBg07Oep8Ia3mgDPONrMT7gSfu65kqI+99i78xdHCLmYBEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(26005)(8936002)(66476007)(66556008)(86362001)(6916009)(16526019)(186003)(8676002)(66946007)(2616005)(316002)(36756003)(6512007)(956004)(75432002)(52116002)(83380400001)(2906002)(6486002)(69590400012)(478600001)(6506007)(786003)(5660300002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XeAYWiTu6Lp0QCrNXDbp5NfuSxUobg4vGRIcE8q96RCbRISP1arT/pP3EwaU?=
 =?us-ascii?Q?Iv1X0eVaN/m9HKAlpX+n5PbL4iZrEZb3pHFSes9HSw0BCj5+aMFwMr6XfptO?=
 =?us-ascii?Q?6FvAl9c0Sso3j2Ye3eYI7eJjh3WHHufz/X/AgWUBI7X9Ss9h4XyJFqlf1zA+?=
 =?us-ascii?Q?vS3HEgfyDau7aN2Ex9hRqSZboeiORWg10teZcGI+28GL9aBf7KdkWLuJY6fG?=
 =?us-ascii?Q?hvKuOVlO2oIailXN48HmwstCaK+IvCUVXEq/+LOKS+iFXodhT/3w2ssny33Z?=
 =?us-ascii?Q?nijbaGup3AnwBCHi1gkM/gWDxZe6agkECLq9UVRrBeWteudqxfjc8+3g5ry6?=
 =?us-ascii?Q?CG7+TfkWzrWs9N2sQCqAF/Uo6WjDYF1QkKOEOFq6ExTe/yYxKeAuarnkUNyG?=
 =?us-ascii?Q?5LBQMvt+o37ZkpetQGXnVc9aH408mQtCYtSxSjRZxR4uQlTpyRzU3zicFx9W?=
 =?us-ascii?Q?eycuxXa9lAfPJVf3CokOjps9toHelcpRyEqddravbIIwo2HFaLfkZcX1iEnZ?=
 =?us-ascii?Q?P9IKTp+ef3hfodSJ5Y7AK2P1Mii7iHLiTBMmg6oPU6fbVvg1SVYQxXwpuNmz?=
 =?us-ascii?Q?pB0/JHqsquYHFYrEd3b8Luz7z5RoTmqtljzlJR1TfXw7+J6izrU3ESMBRkAL?=
 =?us-ascii?Q?MfOdqUbwFaLPG6lIp7gIjyjMgcz7TSg/T6WI0mbHGDlPJ8/2Zn+2pXllrZ+y?=
 =?us-ascii?Q?m6VNShTB9nVPthkaO2jRR5SSXtE3LWZhvDFc5Z6YczUaCHjiCpWZ4fHogj05?=
 =?us-ascii?Q?AB59J78OIlEAG97tuEEjlKkj3p8AjTYFhRwFZALbYCHsaKqstAh012aoYUkw?=
 =?us-ascii?Q?yfrXQE43B4FlXai0KRp3j5AFNtrQVQPlaBQlhls4QHInxgrTe3juS2OxmwL5?=
 =?us-ascii?Q?yJi7BIUnuCH9USOiJ4VfrML3qa8bftH/Z5fjegSbrhSHR71i8Ft4JSxpIAIh?=
 =?us-ascii?Q?ut3za034D+QVq9r2KBTqdU7YBjIde2/67UR+DIdtuqLLN7Klc61RCpDZVl1E?=
 =?us-ascii?Q?yLK+JnzjVnVQd70xeXGhP59bnyB2A3O9aPFNkBwTE31TMaYAV1XUJVtnKvhe?=
 =?us-ascii?Q?8B2YdY96vIum4oHTJYjNQXKzx1hUZKqpFvuJZYZlbUIHQicgpH0LrNlMbKcQ?=
 =?us-ascii?Q?LIEsjq6l8EfZ3b1peMGFiL/mqVFlHqZaSZaF1e8ecxwJTLpIIx8ZuVOibr8a?=
 =?us-ascii?Q?hbxUeInLDPb906mSUhpBa1aFocCNF2Dtpw5t5Wctwe0M2OE1muT8IPT8Yqny?=
 =?us-ascii?Q?IevJ46kJl1B0XDuKvT9JQ1LGlWwwn8z5a/gd0qdBMDHIZiKEQmO6yvLRWh4g?=
 =?us-ascii?Q?Sg4pZVKIrtDGXZjdS6D69nh3?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f20033-8a53-4ae8-5ada-08d8d9df7b27
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 22:48:34.2045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hk+Xxd2wcIDbl98v6xoZB3XOI7g4S2oSM/OEiZHe5qT27KVCPy9+426vlaunE1rSkKyKJL0FDJ759Eg2693/hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6163
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 25 Feb 2021 22:48:38 -0000

If fstat(2) is called on an AF_LOCAL or AF_UNIX socket that is not a
socket file, the current code calls fstat_fs.  The latter expects to
be operating on a disk file and uses the socket's io_handle, which is
not a file handle.

Fix this by calling fstat_fs only if the fhandler_socket object is a
file (determined by testing dev().isfs()).
---
 winsup/cygwin/fhandler_socket_local.cc |  9 +++++----
 winsup/cygwin/fhandler_socket_unix.cc  | 11 +++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index 964f3e819..f8adf6c46 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -673,11 +673,12 @@ fhandler_socket_local::fcntl (int cmd, intptr_t arg)
 int __reg2
 fhandler_socket_local::fstat (struct stat *buf)
 {
-  int res;
-
-  if (get_sun_path () && get_sun_path ()[0] == '\0')
+  if (!dev ().isfs ())
+    /* fstat called on a socket. */
     return fhandler_socket_wsock::fstat (buf);
-  res = fhandler_base::fstat_fs (buf);
+
+  /* stat/lstat on a socket file or fstat on a socket opened w/ O_PATH. */
+  int res = fhandler_base::fstat_fs (buf);
   if (!res)
     {
       buf->st_mode = (buf->st_mode & ~S_IFMT) | S_IFSOCK;
diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index eedb0847e..8091fa820 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -2337,13 +2337,12 @@ fhandler_socket_unix::fcntl (int cmd, intptr_t arg)
 int __reg2
 fhandler_socket_unix::fstat (struct stat *buf)
 {
-  int ret = 0;
-
-  if (sun_path ()
-      && (sun_path ()->un_len <= (socklen_t) sizeof (sa_family_t)
-	  || sun_path ()->un.sun_path[0] == '\0'))
+  if (!dev ().isfs ())
+    /* fstat called on a socket. */
     return fhandler_socket::fstat (buf);
-  ret = fhandler_base::fstat_fs (buf);
+
+  /* stat/lstat on a socket file or fstat on a socket opened w/ O_PATH. */
+  int ret = fhandler_base::fstat_fs (buf);
   if (!ret)
     {
       buf->st_mode = (buf->st_mode & ~S_IFMT) | S_IFSOCK;
-- 
2.30.0

