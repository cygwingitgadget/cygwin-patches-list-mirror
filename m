Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
 by sourceware.org (Postfix) with ESMTPS id B30653857C7F
 for <cygwin-patches@cygwin.com>; Sun,  4 Oct 2020 16:50:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B30653857C7F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2CXWhRSISthyJeHeBxHYHbrFXoudDQY6aPK/1H5WhGlA2LwTp3w1O/iOi0IUcLdsC1jAS9HW3zgZO175eUiDFjaHPOJwyl8pIka1kcRkRFxnU+dRtANbeLCDNq4M3A5YU9ZHggssDextPu1GyWz8daHrZGxe3U1mpw0BZOb/NjTQwBjzRNDInVeRJSt6tsd2CEsOrpUgaBd57xd6QEQjpHiMDh8Hk5Nrx5P+aoai7e0BW+sKLygvqOXNS2FTMQiqQ0J0IzLkSuUpxUaZKzi+jtHHzaG3+/G7PDfVYc33yX1G007U568RuyDRgYgC6o481PL1eBSXpBoacIX8R+tYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9HjdVman54xJ78cQWVYt96vXTen0I7P5A9g3nW+QZE=;
 b=Qgip0KcOf1ajePYFHKBj/ytH8IrlSYrYJFAcvDv8GxW+7dQ0H7CBFSgHBycKFUif4GNqGAj27LPmtL3dKx3DfysSTYpMIuLG7pNCjZaXmWTspNjz8c8g1LOyUvXK+ycV1yIKHjJ5kEbgUHxscg2vNZMqv/Lsz35CIe2MeA2JlP69q+NaYY1WlnOcSPnRFEbCTb7jU0ZMLJS2jNMyg1zFBkEh424wJExIpLtG4Zqoxj8ZqdgK67luBn2vLbMDtmVu0YD02XVSuZgGtHzOlbRU7IHHwWuUfuNE5jihEcqTXzkbFkn0IHcV/3mfpxkSblSdjNP+EYUBDsP+8mI9ao1aig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 16:50:07 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 16:50:07 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/6] Cygwin: AF_UNIX: use FILE_OPEN_REPARSE_POINT when
 needed
Date: Sun,  4 Oct 2020 12:49:43 -0400
Message-Id: <20201004164948.48649-2-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004164948.48649-1-kbrown@cornell.edu>
References: <20201004164948.48649-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2604:6000:b407:7f00:48c7:bebb:3651:4c42]
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:48c7:bebb:3651:4c42)
 by MN2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:23a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend
 Transport; Sun, 4 Oct 2020 16:50:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76871476-153c-42f4-557f-08d868858c82
X-MS-TrafficTypeDiagnostic: MN2PR04MB6176:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6176EBE1DEC4109026354CB3D80F0@MN2PR04MB6176.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+obPGxURvO4tTZjHQh/Fx6f55cpY3dVYocHd9diYeEYnj6dGEzh4NxMcdpxeJDUjuFQ08kj9WCz4CSvBdLtCu2FNE0ZngJL+v6PyXPn/3XsosZupJVH0XzIJ7EK9F5xUp+aR/h6s6lk3hiMZxFSa3qV8cXHK2iwDVOh2dlzPzmH4r8Hze8/QWpEl5MqDjIKl8JGZj8ZSMxgrhqDEH/o1wDPpMUTkOCxt9Lz29zWptsjM84D/Qdb/dKKF9x9gJnEuU5uEmORoZ5KQ1vGfg5ft2svilxFkJnX6/uGUBjeQJUN7HQZeNbnsZ6yligTezgu1WKJj22H9dOz0AVW68S5TtkEQ/VSYVN2Nn5AVzzzsE7FJQeuqKuTnjarbX1+D3uL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2616005)(186003)(16526019)(5660300002)(75432002)(52116002)(66476007)(66556008)(66946007)(316002)(786003)(8676002)(36756003)(6512007)(6506007)(478600001)(8936002)(1076003)(69590400008)(6486002)(83380400001)(6916009)(2906002)(86362001)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 14ALZNau1tV4NWGxW87glxp1dYZkSPEOQTaiUzaCKNU5ldS1gsooV0EYCLTjhde8PucBr7q1KjKmTbdgXXTOFCWfI1i867hv4svIDsuqtXz1DhfFAxtQ+BAuDN0SkV7LtXUP5L6lo1aL7oT8jrNqFuszq25HqI/GJRCDI2Ef16wAoj4gI+V7+QdG1laNciEua6U/z29LMJn6xid3zYZLRjvKXjoL3pseOqbTm3sMJWECEhkgJ1IFhWR5uPeCUAPrbqpbUsuIe8FyPvTuy36f+gSgKQxJ5shol4uag8zHqM8p9Kxi51DVOUgrK9FNpSZv4kLqn938Ti58ix+8OpTIGD965gwfCGxnx2xV6669O1ORwJZol1Z/IGsUBkV3htu9s+GQjIn7d0T/cve9XpGscrtk8blvG9eMMKShuJ84Y9OGK3qy8WR9ZQT1pEwrwFqrsnVfUAoXKnixPqjM/cYcEmC5PbuBXYzE0jm76vLanX4YBM5BWBKXl+XCRjORfyOSsi+tGV11DZQCYnZg9bXDMagU05vEHa+1Q7VJvzNXNq0CLFo7jj5wivpCsfnGqj8G8ZKmScxdb32YB8CtYTDUvEDXMRu3K9zAPn6Guz6Ph8u6069VqhDQQSvLYuIEfgFNy9k8GybxZsgTXAKyPofeSsQ7I3dnHesC/ysXQVaNsc8T49spwXryCMuJcMQDQuQfNvpQG1r4AZKB2uq30sYuQA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 76871476-153c-42f4-557f-08d868858c82
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 16:50:07.3114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5KDdO/h3pQ1cqJZIUqCPv10Ibz+qBvE1/kDwn62jz6I3gx8Z1rB1DjQGMu6T7pVe6lwME3m67qSaSWGUVBTZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6176
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 04 Oct 2020 16:50:11 -0000

The following Windows system calls currently fail with
STATUS_IO_REPARSE_TAG_NOT_HANDLED when called on an AF_UNIX socket:

- NtOpenFile in get_file_sd

- NtOpenFile in set_file_sd

- NtCreateFile in fhandler_base::open

Fix this by adding the FILE_OPEN_REPARSE_POINT flag to those calls
when the file is a known reparse point.
---
 winsup/cygwin/fhandler.cc | 11 +++++++++--
 winsup/cygwin/security.cc |  8 ++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index 82b21aff4..5dbbd4068 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -620,13 +620,20 @@ fhandler_base::open (int flags, mode_t mode)
   else
     create_disposition = (flags & O_CREAT) ? FILE_OPEN_IF : FILE_OPEN;
 
-  if (get_device () == FH_FS)
+  if (get_device () == FH_FS
+#ifdef __WITH_AF_UNIX
+      || get_device () == FH_UNIX
+#endif
+      )
     {
-      /* Add the reparse point flag to known repares points, otherwise we
+      /* Add the reparse point flag to known reparse points, otherwise we
 	 open the target, not the reparse point.  This would break lstat. */
       if (pc.is_known_reparse_point ())
 	options |= FILE_OPEN_REPARSE_POINT;
+    }
 
+  if (get_device () == FH_FS)
+    {
       /* O_TMPFILE files are created with delete-on-close semantics, as well
 	 as with FILE_ATTRIBUTE_TEMPORARY.  The latter speeds up file access,
 	 because the OS tries to keep the file in memory as much as possible.
diff --git a/winsup/cygwin/security.cc b/winsup/cygwin/security.cc
index 468b05164..d48526619 100644
--- a/winsup/cygwin/security.cc
+++ b/winsup/cygwin/security.cc
@@ -65,7 +65,9 @@ get_file_sd (HANDLE fh, path_conv &pc, security_descriptor &sd,
 			   fh ? pc.init_reopen_attr (attr, fh)
 			      : pc.get_object_attr (attr, sec_none_nih),
 			   &io, FILE_SHARE_VALID_FLAGS,
-			   FILE_OPEN_FOR_BACKUP_INTENT);
+			   FILE_OPEN_FOR_BACKUP_INTENT
+			   | pc.is_known_reparse_point ()
+			   ? FILE_OPEN_REPARSE_POINT : 0);
       if (!NT_SUCCESS (status))
 	{
 	  sd.free ();
@@ -232,7 +234,9 @@ set_file_sd (HANDLE fh, path_conv &pc, security_descriptor &sd, bool is_chown)
 				  : pc.get_object_attr (attr, sec_none_nih),
 			       &io,
 			       FILE_SHARE_VALID_FLAGS,
-			       FILE_OPEN_FOR_BACKUP_INTENT);
+			       FILE_OPEN_FOR_BACKUP_INTENT
+			       | pc.is_known_reparse_point ()
+			       ? FILE_OPEN_REPARSE_POINT : 0);
 	  if (!NT_SUCCESS (status))
 	    {
 	      fh = NULL;
-- 
2.28.0

