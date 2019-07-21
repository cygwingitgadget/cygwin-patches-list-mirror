Return-Path: <cygwin-patches-return-9501-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19026 invoked by alias); 21 Jul 2019 01:53:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18925 invoked by uid 89); 21 Jul 2019 01:53:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=supposed, meaning
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730101.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.101) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 01:53:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=cXrpHJmKAKRvh5El4bByBnLXSR/rtqr8x3lBwzTXRKjV8XARNs0YQSwp1WXiioa9uRJ1UK97sa6HI+th2j8yvtm2iLcW0OGYLe+mmSPFdRnKNWsmEc5JkP92qBaoBVq1G3Wt/7Jp1LgwPGMwQH0rj77g3iGxT8J4M2eLRonp6BYnIeAiGmc6hH/jj8vf0Uo4ZvtTK6wIiil62/cOPLefG9BCuRqJe3Hc+UlYZl88KV0vC23RZIzVjeiPcwtEXmtVWIYmthcBbzaT1yc41BgkQ4DRGZ4i79LTNWirOhObCNTj9RM3dVQAOULTTQOr0fFNpROTPIznYSu1XBBOvhdSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8p0mQOZ8yTViXRkR6/ItJlWCrjdSRHjSaBB6EVDIZc8=; b=ZCg03Na9m1cDJ6XhEHPIhQy6LddNrKmFLla2bzz+aTgolu8eYByrMLwDkqrMN/3ep9bKkzgzOQLIBmnmIKrZljEE8u1SJfPiyhoeaCaySPIUf0d88Qa/bz1fr6jdQ6yML6cQo+UCEV+ZpaK5sIdQmuUzWBcJ2F2NfFDL/qsk33vm2KOe0v+C2bmbacmWnn2+e/1ZtPDoHQ7G0/QEMNgCR8rCJM+qAonsUBVIcpqNApnyvts5+F5fRTcaGfnBTDFnb7ibe3yQxcF1YKoakQeCkrfD8T+GDn0dAM0VnmtX1oQnXgxV1ASEiwblql7EvP1UCOT1JimWrY0auu1hhbJY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8p0mQOZ8yTViXRkR6/ItJlWCrjdSRHjSaBB6EVDIZc8=; b=etOVZzZM91nfyc9gHTL4GqIpma3sjRXYw8dtmNLPWv9cBxsRJm/r9OhcP+PBP86uAKMUfgPDxnoypOyuQZP/ALz5OMIQQ8GZAMPB7UMyaebs5AtqYwxd7ErNktO7ZQp6atzEtU7qD4a5POeZZfbDn5hoIMOZ/xaNBTAZKhHis44=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2313.namprd04.prod.outlook.com (10.166.204.8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14; Sun, 21 Jul 2019 01:53:02 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.013; Sun, 21 Jul 2019 01:53:02 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 2/4] Cygwin: remove path_conv::is_auto_device()
Date: Sun, 21 Jul 2019 01:53:00 -0000
Message-ID: <20190721015238.2127-3-kbrown@cornell.edu>
References: <20190721015238.2127-1-kbrown@cornell.edu>
In-Reply-To: <20190721015238.2127-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7691;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00021.txt.bz2

It is used only once, and the name is supposed to suggest "device that
is not based on the filesystem".  This intended meaning is clearer if
we just replace is_auto_device() by its definition at the place where
it's used.
---
 winsup/cygwin/path.cc | 2 +-
 winsup/cygwin/path.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 158f1e5fb..ed58e966f 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1921,7 +1921,7 @@ symlink_worker (const char *oldpath, const char *newp=
ath, bool isdevice)
 		      win32_newpath.get_nt_native_path (), wsym_type);
=20
       if ((!isdevice && win32_newpath.exists ())
-	  || win32_newpath.is_auto_device ())
+	  || (win32_newpath.isdevice () && !win32_newpath.is_fs_special ()))
 	{
 	  set_errno (EEXIST);
 	  __leave;
diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index 0c94c6152..d1be1dba0 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -183,7 +183,6 @@ class path_conv
   int isfifo () const {return dev.is_device (FH_FIFO);}
   int isspecial () const {return dev.not_device (FH_FS);}
   int iscygdrive () const {return dev.is_device (FH_CYGDRIVE);}
-  int is_auto_device () const {return isdevice () && !is_fs_special ();}
   int is_fs_device () const {return isdevice () && is_fs_special ();}
   int is_fs_special () const {return dev.is_fs_special ();}
   int is_lnk_special () const {return is_fs_device () || isfifo () || is_l=
nk_symlink ();}
--=20
2.21.0
