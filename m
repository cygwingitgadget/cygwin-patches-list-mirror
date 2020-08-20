Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2099.outbound.protection.outlook.com [40.107.92.99])
 by sourceware.org (Postfix) with ESMTPS id 2C7ED385DC37
 for <cygwin-patches@cygwin.com>; Thu, 20 Aug 2020 13:54:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2C7ED385DC37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhuxM2AvCrbvCf3Zhqxd9OoTuDd4CUxSRrHMpslXLTRENPDohGkya6daGtJmw/mycG54sUvBsRcmtOK8DtkoiaqUxYvCnp9uZAiDn81NXt9p7+bPQ3VgJF1wUp7txX88ChKR66EvzobFMsFTmRkGQqQQxc3INb9EY7l2FMBG6gChWvQpzjm1IyuUIir+Tf+/hN+tVaee7H0Y6ZiV/eIJGB11NP/5Kp+Z3uwDW6CpvWfx5EmYsnDWJisq7Yc6BL9km0YPoehgkCxO1ZywMJNNOjQ5tTbdKSF81jRBI40QCXN84Rd0cWans3N5Dnd0316nZPzIcHBWCm6JSGJqtPcPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pQey1l7stHcXNRQNzzE03exUQ191/kIFfv0q1ImYI8=;
 b=G8cH/M2Jb/YVJ0lH12HOlTsk8WyXuAwurmoxzkQWQ50fdCZnUWIefHiFzfsv4C6NgNp5NEvcMDXv23xyPPeECssmdAudxgPcCh2uCsd4tjPUhp0VwGNA6WmnDLuwGCHYnQHMTdVZXyw/oNqkXVg6hpjmP/TqedFdu8NQ7bA736AsL+vikqN4OOBpUO9OLsU2DBD7LUAR6GRRZ8R8xZwyg2iumogQrM+eK9/ufvICqLgXXappc7UIt+UeraupG/p+TPkCmu2Xnd33BRaRnO4wtZGR5WDT5On8zY6xI+YY1sgRbb4NYIFI8wRsPTTy/3EY4pJ2/EgOXA9EZ6Qn+rQu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 20 Aug
 2020 13:54:50 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 13:54:50 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: strace: ignore GCC exceptions
Date: Thu, 20 Aug 2020 09:54:33 -0400
Message-Id: <20200820135433.19279-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 13:54:49 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:6ddb:1b9b:deef:3580]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0edff923-7a1c-4ebd-7920-08d845109b15
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6112CDD25B763EB1C02465AAD85A0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1PJi9jlLys4etanixAMK30idvYpv6rTK1dUNtMouC8l7p6KmZrKLJQ6SQvEUEef2WM9LeOCAkJiGmOuZhLnXgbiHLgEERAPIE+XWSrLN7cSQAWLOp7TagWL7NZ0mvSdToYcKHMt+Z7VNxa7GzrEKEDqWcFhSNfiDLug+K2qEtgkg88SO0AuCsxeamxwUhkQqDAC1rM1Aawvfqo4foJQ3b7IaMveKY2zh1pm59bCJmV84UHLQSdfpCQeug5MTuL9PzI8ZwtQmE/RyX4nbx/pwuottYfRunYzMMyWrxHZ59ZUX7FNtjtbYokZSslgIr3/vKfF4NP5p4Grn6kca0A5HGivW9NOrDLr/8u6UdS3rnWvyrGkanJpBr2Nw0w0WhKW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(8936002)(956004)(8676002)(786003)(186003)(478600001)(316002)(6916009)(75432002)(16576012)(52116002)(2616005)(2906002)(6486002)(86362001)(66946007)(5660300002)(36756003)(66476007)(6666004)(4744005)(1076003)(66556008)(110011004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eYrjQvL9XNBHLEz2kc3k3A7oidt/cKYIh/xGxQp80HMd6LS5BBsbu9qYQXBPIy45G9Ij/ou2sAoJVJUea/EpzAa4mUYJ+83iTg/NiQfk+iW9wkERCkBSMGGYaG56snz2QbSwVvJpkPIs499H/kZRcjOdFhB32eqVGolIzJGVyYeSTDJyD6dSYyw5RQhXKWWiTDFwwq3pNYFPwystuR/4qgXrkuRKPKtbD7eZzWl4mdr26BbHZ9CcuRWmk8rZdlUg8kK60lgzC4rXYzWpI33I+I8dgQI9PMpZFlSHq8WfCUZ36JC8DgmjITJpK7A03dOQGBIiv3h3zeKyeMp7kcZnGOdgs2octluVlr5JGciMpHNVBs67j2jw6FjCgEtoMv5heNLdvrxr53PEsfxIMWlxezmbOPHBSHAg3nJKoLSCuzmsi3Qq5w5wgLzpw07AJ9xEQtq5RwiwpNpyfdJNCOhpDp73YlcLMtCL/biWPQ5FRwFmqro9vbqxXW2V4bmk65dJoLweXQ9/6DZWwxiUUXWtww/SvssulN/6d5dYpvmRi2TzbbU3Uq1R0HCHTB/B9J1Th4U5CWcSrHOXI0kT34f2Lougf50NkGTRZfeff800ETrUhrOvYJcIu4SnXLnU9lVIeffJ6CJ8qKENbJCrtbxijYxeO+TUGcyvX/IEgfZ6RgSpycmT2nXF4Mj/rkUEboGsYqEwzeLMfLCjXLwUms4AVw==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edff923-7a1c-4ebd-7920-08d845109b15
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 13:54:50.1141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEqfd8wv41AtGOmMctRhWg3QRp3OotetPrWxQK7x5OxReJdVyJAyXpUyWU8wVDplJbOZp7V/a8cUh8JYoav0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_ILLEGAL_IP, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
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
X-List-Received-Date: Thu, 20 Aug 2020 13:54:53 -0000

Any C++ app that calls 'throw' on 64-bit Cygwin results in an
exception of type STATUS_GCC_THROW (0x20474343) generated by the C++
runtime.  Don't pollute the strace output by printing information
about this and other GCC exceptions.
---
 winsup/utils/strace.cc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
index 9b6569a70..2b317012d 100644
--- a/winsup/utils/strace.cc
+++ b/winsup/utils/strace.cc
@@ -790,6 +790,13 @@ proc_child (unsigned mask, FILE *ofile, pid_t pid)
 	    case STATUS_BREAKPOINT:
 	    case 0x406d1388:		/* SetThreadName exception. */
 	      break;
+#ifdef __x86_64__
+	    case 0x20474343:		/* STATUS_GCC_THROW. */
+	    case 0x21474343:		/* STATUS_GCC_UNWIND. */
+	    case 0x22474343:		/* STATUS_GCC_FORCED. */
+	      status = DBG_EXCEPTION_NOT_HANDLED;
+	      break;
+#endif
 	    default:
 	      status = DBG_EXCEPTION_NOT_HANDLED;
 	      if (ev.u.Exception.dwFirstChance)
-- 
2.28.0

