Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
 by sourceware.org (Postfix) with ESMTPS id B2CD13858D37
 for <cygwin-patches@cygwin.com>; Mon, 17 Aug 2020 20:44:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B2CD13858D37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpR1XoDDmswi4UmOBYgwc8oJa3fYVd04YURIMu8EGOdBjsPTNkRp/DN9oi4ndA4yJrmK9Owg6kcVSTlEMByWQZfqUgczVC1VWG209rtzmUXR31I4Y7tMFFUixOJjpe6qeU6BjSvjvGE8m8/X+FQnJ1AIrNNv7VGadc6aDziG/hEm5f4Phpn7BbATeOIlrsgZAk/WClc9Ju+ybCCiGW36SP5Kfr/wDikcgLoTIR9PU8XVWT7qL8VpyYeMHTxfeIsAv5/u0WtI+i781iWctoo7tfqPbopVGxt5fQ762Y5TnoPdGFhuWm2j3irPE6NJqPNdNKaMxDbLnXvDlsoGceVEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpK8tjhgByyKEQRUKYqLQ87nHSIYVWxzz3ulfEOoejU=;
 b=J06wiMdXeVyJOH0eiTX6E4jgyyEe7NPSVNtiztJFkmB0xBCtzHzziZEpOwMviHtvpH7L69WJY9zfLP2QFzY8W2+eL2OXzaAo5S/aUt0sqH9PLabWrbQNvTUBCO/g2Oq2OLx10VKXfBQo3ZE1Zf7SzUflhJm2KjlgAj7sEbeTX/dSDYHBlHmaqibMgpz1BDHB31WVPRP6DhmjqhpzyrB3SO7ilkOMpJCgcgu5Nw94xXUFMdftl7cLssWVx4gYEG+GYjVCG0Lr/Z0EX2/XClPSlJGmhLHVx2L5FMk3UO0LZ9gkyqvfQimiImi362bRLbLvp4Sh+x6zJOpc0YAhFUzx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5901.namprd04.prod.outlook.com (2603:10b6:208:a3::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 20:44:52 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 20:44:52 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: main exception handler (64-bit): continue GCC
 exceptions
Date: Mon, 17 Aug 2020 16:44:36 -0400
Message-Id: <20200817204436.53379-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0003.prod.exchangelabs.com (2603:10b6:208:10c::16)
 To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:6ddb:1b9b:deef:3580)
 by MN2PR01CA0003.prod.exchangelabs.com (2603:10b6:208:10c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 20:44:52 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:6ddb:1b9b:deef:3580]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247bb93a-84c4-45e1-1970-08d842ee644a
X-MS-TrafficTypeDiagnostic: MN2PR04MB5901:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5901BE3C193B2F3380B46F3ED85F0@MN2PR04MB5901.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pD7JLj29syy5CfXcFs4qR557DaNgMbcmCYyCE4Cgz/4JL5ASmOtRmvHmHGFL1eMwkJkYzci+9bPsJjdmCv1dfB6ktwb3S6dn0EF3NxRCCwYw25dduLHEPCr+pf54WVJ7xxvgmtuGp8g1Y1GBIBR5ZKW/YuQ+sQ5Pnm2+KdLwrsgU0Fb2UlicimwL/vPMQgFyaqcqkX5vdpusaIomoBGOIOHbxB+qWgtkkT/J4D/lvWROvD7fKMS4CvtT/4pErg9bNK5198d2jaJLoG2ftQtOjoeKbnJz4kXCMGMoOEIipn5h/m7R0BDdoRL1mJbfFGSOBcy6ZQ4mnIhSgHawXOmgkVBKPR471OZZ2od75ZHZPy59E1IFWU+/DbYN7alWwlUAc5Ec8t6jmjbNFBymLI/mMOIwYHk3dKaOV9jE9WOFx5wkaeiCJI6hWjw4iptCh8DSa6fVI29BTwIqDi1O2ZRT2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(966005)(316002)(6486002)(75432002)(16526019)(83380400001)(786003)(2906002)(66946007)(6666004)(66556008)(66476007)(186003)(1076003)(6512007)(6916009)(478600001)(8676002)(36756003)(8936002)(52116002)(5660300002)(86362001)(2616005)(69590400007)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ytzo1LkhGpepjkbJyrjqkKguk6ZEJ7lL1k124zgkWeQuVrN60BN/klhXuaWbKlQeelonfRedoeFKuNiIKNmT9f/C83XOjQQ1SGQio3yjqZtwdGjJ700vCVDSOcp9hSlst+Zkvnh/sAv8axB3gNM/E0IB4J/Wzmw4SgRDVv1dtDB8+wn8fCPIGT63FDwRYta1hAv8DTuiofTyBG1motL4+I5dVGmZYREtmVRR+WyreIGD19vE4JyHm2C9WPALYN6o4OrMgHlHJUqkNWrALnkawMEvcDjBJZrZNx67oFrVKZDWrBJyChvY3Kxnck++zgzsNxpOW9bdjg8PPSjzSNwEwd+wYrP3bjXLvp5EA9fyncd7aJkhkQusHdrw1srJsfHC+x21TcuHx22Or3yavcZL4hp/mbdx5FllBny0POgaRchYMemV7qHv4FWM3KF/33M5AwUf3LYmuI9JXhFFF6TfP9ypPkZgRBIRwzBTYawSXkHyMTZ3SA4Oc0lRpXCocrfOgQlYnl/tGiiF1PnBqOgC98n6SGggxNFdqjN2yl5IkYGQ32G9s/Qav9wya4CtxJ/dMoYPERU598hkj8wnhsJ14FP2IANcLhVFG/tL/C48BuL2GNAjAMOLI92qYCfITDaRkUDouGx1WTTVoNnR1DbzWuJoJPtWCadL/j1cWJP5TP0XmV605W6ysgPunxdm8ORvTcdiK6XBE4u7EQDUaha9PA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 247bb93a-84c4-45e1-1970-08d842ee644a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 20:44:52.6611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqRZUYSOGbEITh46XRdk2fJbQBbDMF7v5rmaemZxOEbX/Q532SCaaSBfeTlraYOMHZHmaDZMQvcGF/ZYq69Prw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5901
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 17 Aug 2020 20:44:56 -0000

This is necessary in order to be consistent with the following comment
in the definition of _Unwind_RaiseException() in the GCC source file
libgcc/unwind-seh.c:

     The exception handler installed in crt0 will continue any GCC
     exception that reaches there (and isn't marked non-continuable).

Previously we failed to do this and, as a consequence, the C++ runtime
didn't call std::terminate after an unhandled exception.

This fixes the problem reported here:

  https://sourceware.org/pipermail/cygwin/2020-August/245897.html
---
 winsup/cygwin/exceptions.cc | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 0d9e8f70e..f8da7529b 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -647,6 +647,17 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
   if (exit_state || e->ExceptionFlags)
     return ExceptionContinueSearch;
 
+/* From the GCC source file libgcc/unwind-seh.c. */
+#ifdef __x86_64__
+#define STATUS_USER_DEFINED		(1U << 29)
+#define GCC_MAGIC			(('G' << 16) | ('C' << 8) | 'C')
+#define GCC_EXCEPTION(TYPE)		\
+       (STATUS_USER_DEFINED | ((TYPE) << 24) | GCC_MAGIC)
+#define STATUS_GCC_THROW		GCC_EXCEPTION (0)
+#define STATUS_GCC_UNWIND		GCC_EXCEPTION (1)
+#define STATUS_GCC_FORCED		GCC_EXCEPTION (2)
+#endif
+
   siginfo_t si = {};
   si.si_code = SI_KERNEL;
   /* Coerce win32 value to posix value.  */
@@ -762,6 +773,16 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
 	 handling.  */
       return ExceptionContinueExecution;
 
+#ifdef __x86_64__
+      /* According to a comment in the GCC function
+	 _Unwind_RaiseException(), GCC expects us to continue all the
+	 (continuable) GCC exceptions that reach us. */
+    case STATUS_GCC_THROW:
+    case STATUS_GCC_UNWIND:
+    case STATUS_GCC_FORCED:
+      return ExceptionContinueExecution;
+#endif
+
     default:
       /* If we don't recognize the exception, we have to assume that
 	 we are doing structured exception handling, and we let
-- 
2.28.0

