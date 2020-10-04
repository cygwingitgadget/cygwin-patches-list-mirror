Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
 by sourceware.org (Postfix) with ESMTPS id 044DC386F83F
 for <cygwin-patches@cygwin.com>; Sun,  4 Oct 2020 16:50:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 044DC386F83F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5I40FFkuLjyGDL1XgLGC1HTQI+Xk70O+cBxbrdRPvHva/60+ospm78nkk7pClvssfZdFllKtHxbEpPQFJPRv8nBrsD+0HbVuuaeU8nIJVBrhzLsAem9n1EhUP+ecdemEf/yU7kiGz2JwtIfuCP/ZPB1hZQ/9DbvZ859V/aOzGEY7nuJ9wM/Kv5ddJTLzEXCPvWwXKVDHGIftcsXyVegTbScgvJV0j9Qjgp7h6clRdzZ0lXVrsAOXgYcrMrTwH5ZybqOGAGYOrgY2gUKfzf0bmxeQny65AixC+A0vLsWq70E8ENh7TazjBH+IYkvBwpTaYKPW7raeYlGD3i3aF4KTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyIOSwyUBrc9XjscUzFKioiaH3Ghofnoa3AaDNa6nMA=;
 b=LtKpoQSfjapjmk+o+a/kM7Gy3iuaRVvghKLajPRpH0HEwQ+Z0B4PHKnp2fEbxnBo+fERs/0GYd6NLLXRjHXReKYsZg8YwYRmI06oY3dYKaYuq84BDFQJpEA3+PjKQqwdFWJVzOv8x9lBPKaqxnz7PsAUbfWEdLbuW2xokEtKxmWoBfzBrK3053xFJop2NV+2oa6nNUMO8gK3kbPtXUc3AujRpWzLH1RMdqJec6S5Ag9PA96/xZSkKFEtEuQWBCN492jIgn/nkHydIMAKO9CT9w+cu0X7AYdSoqy/xAG9Vp4uq4Q3qhdvUVh3/xMSsSv0Vki+vJvIQNLAIIhJEhn8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 16:50:09 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 16:50:09 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 5/6] Cygwin: AF_UNIX: listen_pipe: check for STATUS_SUCCESS
Date: Sun,  4 Oct 2020 12:49:47 -0400
Message-Id: <20201004164948.48649-6-kbrown@cornell.edu>
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
 Transport; Sun, 4 Oct 2020 16:50:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d36797ca-4ac4-4160-d28d-08d868858dd3
X-MS-TrafficTypeDiagnostic: MN2PR04MB6176:
X-Microsoft-Antispam-PRVS: <MN2PR04MB61768EF6DEC57B4E89A4BBC9D80F0@MN2PR04MB6176.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1t0lIeZdJ9jwWUBqBZKBp2aEZBtlbM4ZjAK5kDEUM5/jfC67OIlgK0kxihTmSN0nAYI1ddPdPOvbsCT26OYvc2xWtK/9PIbDPBgiQ6bHfUPnPD2lVxhQihixkOVlWn8lIuJO+xaWU3K5VkFCtH2/oCNX7QAs1J/LnXxQaJcTKlCEFBf5omomQfDmZHQoLTVf2yHc4eniHDjmW335abNnt0o5SEoz8ecVYm41lyGGkSexiXN6o8pLAKZ1RklnrtXWvOd6F/adbp/wXNu6sFzvkOGarOPY/71c8SFrrP/0E9eHvWmVxaJnko2wlwNJun15AB8JI5vB0jqaX+6jSZwBRHTxvrff7861yjwbPBDyNnADLhHrzQihB2PrfP0riqL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2616005)(186003)(16526019)(5660300002)(75432002)(52116002)(66476007)(66556008)(66946007)(316002)(786003)(8676002)(36756003)(6512007)(6506007)(478600001)(8936002)(1076003)(69590400008)(6486002)(83380400001)(6916009)(2906002)(86362001)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WLDxTa4Ek8KRBi+WLQQ5lltMOrSygKVKkX/wTz7hMjygajXBgUB/tCOeLUSyxKPeVuwH76afqH64OwaKwaCoU5C/rFPdVdaZ5Y4iuNTnxmX2thmDeyfMKUopVN4ARmxCNgz7J33ba0Cp2QI6zhTqL7BUy3b0zylo41VFPFh+hHXxNaq/tcWbIEvXEjbc1r1JHno0XWSGsyU3Rxc71EXaKei3MHHQynnlvecsZ7Sasbgq+YOSpIY5FBkjSe/krvft14LOi1UFR1gRNEjQyhFUxYfP0ikpC9H7frS6ooavIHOlk/JKftnFXUMWrnE7JqzNtuVj7g86SVsHSas8yIZWu95JMhlSzspCn23+WgGYdm5houD9L6HPwBuYDu8o+NJNFTPHjjrUwtKJUPueEZ0ic3v991Yxd3gCKo9Zkd/L1uz9vUPyEyL9OptGbsv+DCr4nJQ8AEm+SJAFp6sjzeMqCCQ2XCkDfMPAJFatsq8N/wN+tb7OA5A2wfaeMIwosSzZ4Q9QSa6Jith1PCu3kSsqSmgZwmDECRQX4huwXsVEJknt1Tl5ognc66W/wef/4Rj87v2hb3PQfamcW7+f2HmkPHyW1GditTL6MTiLob9X5iQihGTh5SqNLPjWwXolicfEnWRIovpYUhoeNABDda9dy++4biAGhvX2MUZgbTONrgTQZoK6F0EBsQUNV5Z1M67w+Pive0nhXlgkkzJxLaL0eg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d36797ca-4ac4-4160-d28d-08d868858dd3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 16:50:09.4302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0db0LHFerXVD6w+yFI3jrz1g2m/RJPRtOWJtkgCDy85tXyl/WOtkN1ew9D99JCQYLwFA5tRFvGMgWy7t5SrVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6176
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sun, 04 Oct 2020 16:50:16 -0000

A successful connection can be indicated by STATUS_SUCCESS or
STATUS_PIPE_CONNECTED.  Previously we were checking only for the
latter.
---
 winsup/cygwin/fhandler_socket_unix.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index 0ae7fe125..1a9532fe5 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -1064,6 +1064,7 @@ fhandler_socket_unix::listen_pipe ()
   IO_STATUS_BLOCK io;
   HANDLE evt = NULL;
   DWORD waitret = WAIT_OBJECT_0;
+  int ret = -1;
 
   io.Status = STATUS_PENDING;
   if (!is_nonblocking () && !(evt = create_event ()))
@@ -1085,9 +1086,11 @@ fhandler_socket_unix::listen_pipe ()
     set_errno (EINTR);
   else if (status == STATUS_PIPE_LISTENING)
     set_errno (EAGAIN);
-  else if (status != STATUS_PIPE_CONNECTED)
+  else if (status == STATUS_SUCCESS || status == STATUS_PIPE_CONNECTED)
+    ret = 0;
+  else
     __seterrno_from_nt_status (status);
-  return (status == STATUS_PIPE_CONNECTED) ? 0 : -1;
+  return ret;
 }
 
 ULONG
-- 
2.28.0

