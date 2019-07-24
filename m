Return-Path: <cygwin-patches-return-9518-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50797 invoked by alias); 24 Jul 2019 15:35:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50788 invoked by uid 89); 24 Jul 2019 15:35:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Hx-clientproxiedby:2603, msg00166.html, Hx-clientproxiedby:404, UD:msg00166.html
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730107.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.107) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Jul 2019 15:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=c1Dpd6QI3+v5r0sOL6F/FIbxF9F6WKoKgujwZJsxczZx40U0AKqTV1KLRgVYMSUrR1tRAe5rVmCRi8dIm7aNG3J514Pn98idqO1F3E0+Q9HtBqcoRNUBo7laQNZGMcVfcm2aeDnRCpQelRbBmgEygkBQYvuTMjNNAG9Jv2wOwUcixDeIqHkMJGVuZQ9YNoKHVp2UrGalFSS9YlhjmxA+ax46eKEW1+O1eb4wAEUb3QIoUqrAHAezHNM/UYQAKzSi+CINxCFQb5nIC6iNOO07VYqwKJ+z7bBbwbSR4LQjYP670ywFIPqk6tN7rHF5g+wQbdppICQ/sXLVkqTj7stJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=pTGsK9ol2WW1aPD7SstNvMOOstHHU53J5eU2jCQ/6RE=; b=UNqnfgYUXIKyHfm42gjLK7mV4m+l8rPc52ZXmyc2Wsoz36VE8tH+u90sRrAijdBFRGUGGvek30mfGKwg+FB2FBYUSiaYUueVj1TrurzQJX9yf7K1V3NZSs3o+P9RGHfWiOJhm9J5UFeA/Mel6j1BjxC9dmRtPviE7kOEq+On535ERoXejoelsn5S0C6Ozo0TaAE3UnPqANKPEQY1XjBAGGLuahC1F6Uf9dW+ASfhmia2heyWPpzN06aiieJemThazTfQVHdb21s+QuPEWMWqRWKSI/69WuKz9rGwJcIKc2qplY/UEII8e5xpqgpDLoqmDBuu8WyjovAVj2Rwxq3+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=pTGsK9ol2WW1aPD7SstNvMOOstHHU53J5eU2jCQ/6RE=; b=HQ8FGkxvwh8RWdPsNTkEnRVlSu9YPc7loRwvJ3uVHB2fNNmUdhoKc7GeNiI1MHDtexp7+DLa5Y+oRtvj9OIYITrSBnoCVskqknAIh6IDbFMEV2SoDst2Q8EF2ReZkte/kBbW1yxtfN4uvTTJ5ZLjFc6xgkF/hi+AntbAm/ZgkHQ=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2252.namprd04.prod.outlook.com (10.167.10.14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.12; Wed, 24 Jul 2019 15:34:55 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.017; Wed, 24 Jul 2019 15:34:55 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: fhandler_termios::tcsetpgrp: check that argument is non-negative
Date: Wed, 24 Jul 2019 15:35:00 -0000
Message-ID: <20190724153438.1240-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:3383;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00038.txt.bz2

Return -1 with EINVAL if pgid < 0.  This fixes the gdb problem
reported here:

  https://cygwin.com/ml/cygwin/2019-07/msg00166.html
---
 winsup/cygwin/fhandler_termios.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_ter=
mios.cc
index 4ce53433a..5b0ba5603 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -69,6 +69,11 @@ fhandler_termios::tcsetpgrp (const pid_t pgid)
       set_errno (EPERM);
       return -1;
     }
+  else if (pgid < 0)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
   int res;
   while (1)
     {
--=20
2.21.0
