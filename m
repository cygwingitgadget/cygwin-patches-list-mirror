Return-Path: <cygwin-patches-return-9498-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18564 invoked by alias); 21 Jul 2019 01:53:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18492 invoked by uid 89); 21 Jul 2019 01:53:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690126.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 01:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=KAYOES1FWbxNZWiaWQ2wPrpsWiNXpgXhTOt7OXFJ/Z5nsBR1MD78zS677YGh7REnLVMXwGznWb94c/CxIxsxnAh1PybCc7HBXkD8Uy6v8KV090TQX8RqLwPotgpNwVQUtoQdPlDvCJrVd+t6eou+iCRqgD70Ythn5vn5Grwr/H9MbZjn+5KytStTTPGVHYhV6PdLQSeIN2X0ZQFNRxjtovDKl0KDh3fAqSIRHSS0hDou78psOCaUiH6IwjdWnCtHd0G2LZmmc9eZz7hNUj7O1RuC4oLdqFqyk86a0cx2nn1zx7fWpLUC3/6xEIZ3YxFBU8zYsyd48MrhBmy1EjQirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=3iY2OvdmQQzCfK6YTLmD29pNfnubkNLhkHGBEyJfXMY=; b=DwyJcogjtZaT851i0JnniB3u/vUK7ip4RRHjheaQYu3vx1n24qcnf5WOkxMU9nUWTfYcUpBGO0dzrQgf6+UFiIEKkz4mGz7HXRyyObWGU7MPuV2/CNMCZKu6KtpschXZkL2YJR+mS58ereFigyWkpU5hB8zgMuZPJyJNLk9E/T1u/xN5XY4jdJYEEmEL0vNsFErdA6AfzeiHeUopgng3FUvuYBFoEgMxNOCwKw8LUahwQwmcg7udbz16x177s4TBaENLNMaK84Kw2T0kAdXnZz3OwgnqGYubJhFhWTR9hrlPv4BUMNmu90yrybxzZiONfHaJzQyi0F41OJoDZP6Kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=3iY2OvdmQQzCfK6YTLmD29pNfnubkNLhkHGBEyJfXMY=; b=Z9Y7HEozx+zAHUUG/3v1zHToh0Ubi4U1uUPRPGNMlQv8JLPJtowqGYxI6jr3GJo2XPURcyVyeWzpO5mYDK6q2mN4nAQcOeE+DzLyNn/8rLe8PDYYAv9ehiKbk2WL8ifBQv6cfKZhZKi0q+atZjnWgUNvEXq0duYW8+nMTPqtOog=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2250.namprd04.prod.outlook.com (10.167.8.150) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14; Sun, 21 Jul 2019 01:53:03 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.013; Sun, 21 Jul 2019 01:53:03 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 3/4] Cygwin: remove path_conv::is_fs_device()
Date: Sun, 21 Jul 2019 01:53:00 -0000
Message-ID: <20190721015238.2127-4-kbrown@cornell.edu>
References: <20190721015238.2127-1-kbrown@cornell.edu>
In-Reply-To: <20190721015238.2127-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2449;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00018.txt.bz2

It is used only once.
---
 winsup/cygwin/path.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index d1be1dba0..2fd9133c4 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -183,9 +183,9 @@ class path_conv
   int isfifo () const {return dev.is_device (FH_FIFO);}
   int isspecial () const {return dev.not_device (FH_FS);}
   int iscygdrive () const {return dev.is_device (FH_CYGDRIVE);}
-  int is_fs_device () const {return isdevice () && is_fs_special ();}
   int is_fs_special () const {return dev.is_fs_special ();}
-  int is_lnk_special () const {return is_fs_device () || isfifo () || is_l=
nk_symlink ();}
+  int is_lnk_special () const {return (isdevice () && is_fs_special ())
+      || isfifo () || is_lnk_symlink ();}
 #ifdef __WITH_AF_UNIX
   int issocket () const {return dev.is_device (FH_LOCAL)
 				|| dev.is_device (FH_UNIX);}
--=20
2.21.0
