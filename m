Return-Path: <cygwin-patches-return-9510-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29629 invoked by alias); 23 Jul 2019 16:12:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29546 invoked by uid 89); 23 Jul 2019 16:12:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1065
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730130.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Jul 2019 16:12:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=h437vFvL2S2RGz4O+W4e7Z3kWnd0J8dXjfzMfqsrH0WhjAyskPETf6zzQovpytgDizXDCuttre1LZBpO2p70geKjbfXgv0+PTypB5DgBxsSQc99yywYzhUQetPaIEedShmQyqQXzEl6Xi2pgVmXe8D1pynUk3uO5J4EmafElCiHcgsayR0aK8Ze7c7iAxXDQQGtJ7DJjeogT3BYtM+UQb6pWTdYSnKz+4XXTS+yGee6k1hUCmWWkskDPc8zlmVXx8kd+Jf3+eO/IwhsGMJHOvLWKuFI+4erRnNCllxvf71PJjLELJlfaifB3+ZZqpd15EUy8LswGs4/TN0l9OyLegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=wfF3QAu4+1FsErRsTzuYhhWj/Zat8J2N/xaXd4N7Hjc=; b=eZdVmkQA52Mpbq5jXKHi9BrA/ijOGxg8IP/QoVTyVKfUc6GvYIuscuhNa1ClA5Ea4MyA5lRNimybDQ7LcWuK/d8K4uoW7PbOX89Lgb2BWfuyEyN9Ko+0dud/7VX0pO53/fG+Bs+I7VXHIV89tMk+vVnYLs2+YNamAZO3XbDixU/rYlesIENeNn6C+y+66m9P/5WdM8tJkRPKhfyHO3FU8nqNBJz/ejWQQkcKlfH2ihEXKzUVyp8ItqOzr/o5aunMQPIfAVx9RvSQcXvKpljcY6LE3FWIzhzKUcqhxKXA+Bvqq5oTan/HwGPpDJtwobH1aVprpIftxnx6jtvTN5khDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=wfF3QAu4+1FsErRsTzuYhhWj/Zat8J2N/xaXd4N7Hjc=; b=ekC/0aWnY9X7tn62gYQyaHOyOTNpXM5fuaeirycSdxrtcwQO17itF/HWEjMkozJOnh+0dZiXiAiAbLWFqyNSuzALS88tBvgzUmJEFAKANOyguQfxHb/jcQmrFxaCJW0tAJ0teIe5UbDrJAh3xMwUwrZhUdqNoS3yskHgx7HNQOc=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2331.namprd04.prod.outlook.com (10.167.17.12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Tue, 23 Jul 2019 16:12:41 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.017; Tue, 23 Jul 2019 16:12:41 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 1/1] Cygwin: don't allow getpgrp() to fail
Date: Tue, 23 Jul 2019 16:12:00 -0000
Message-ID: <20190723161100.1045-2-kbrown@cornell.edu>
References: <20190723161100.1045-1-kbrown@cornell.edu>
In-Reply-To: <20190723161100.1045-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7219;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00030.txt.bz2

According to POSIX, "The getpgrp() function shall always be successful
and no return value is reserved to indicate an error."  Cygwin's
getpgrp() is defined in terms of getpgid(), which is allowed to fail.
Change getpgrp() so that it doesn't fail even if getpgid() fails.
---
 winsup/cygwin/syscalls.cc | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index a914ae8a9..3fd62c286 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -3339,7 +3339,19 @@ setpgrp (void)
 extern "C" pid_t
 getpgrp (void)
 {
-  return getpgid (0);
+  pid_t pid =3D getpgid (0);
+  if (pid !=3D -1)
+    return pid;
+  else
+    {
+      /* According to POSIX, "The getpgrp() function shall always be
+	 successful and no return value is reserved to indicate an
+	 error."  We return 0 instead of -1 for the sake of
+	 applications that mistakenly check whether the return value
+	 is -1. */
+      set_errno (0);
+      return 0;
+    }
 }
=20
 extern "C" char *
--=20
2.21.0
