Return-Path: <cygwin-patches-return-9500-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18932 invoked by alias); 21 Jul 2019 01:53:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18842 invoked by uid 89); 21 Jul 2019 01:53:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690126.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 01:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=DI3LGmz+l+l9o87agasdNke8tqk3P0wcBRoksZz7qPTBegnnNK/v4nsdXRgTDYV60alSg2J4dAdRQQQxKbsNva6aKdRKei6bpHyRwry5f7HZBxgI3XtW/b3SvgWCFT3lR0ocRX96Vm5y4YgV4dWfPdXzUKbOxINkjjrcvrBUB2Ef04fCjfy7QJcuqehvAij1HlKlMzfLtzV8D0rpERjG9IYnqg8nncs0FEdBMsMEVHCZ1cwurz6Sjtd+MmAq+ssTmKyVBzjHeJKqahha6PjqcC/Q/S55yXWe+fqwJhW5f446udo/FHOoumYjzFQOcvCzFGrHn3hHd6EZ6FTSIK9Mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=eTlt80V4/2c0I8goV+neZwfvOY3HEW7NQKCJ+7AG/mM=; b=RlW4DjBbQJ6blopWh0+Myjo1UUcZyQPcf+pzQ+VMmJJ1Zo21mPKG/sXy/ww37X/CmjH+XHbuYuvnqkHd5cM2aWU3Zv5uGIoazM4+k+XtFmcwFHLxX6TV3VJR3+MchHEePwF9qU8aCgWc5recTS2x3BV2Q++jg7vEZ12J8ABtBeINuRFydsu+SVDgktAN3zwf7H+zyL2kcSSAt+zijm6bKHJECQbjARX7cEU0udAEdd9reAdaGDAVBm7bbDSdzvZTqf9WJ/GZmP2OVKAT0/mtQTK3QGIM9WmsCRoRZdQlRaJgXhC2AGT3NXi6aZwvrcIQrlDCHqijaCeDs01fGXIbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=eTlt80V4/2c0I8goV+neZwfvOY3HEW7NQKCJ+7AG/mM=; b=KMt6dIhxPPTn2a2Em7x9UyxZqGMd17WS7V2NDczBH2kuFM7ORDPI7GOIt8QFBUnfYVtW93VGvQwsNLgnmptlIhl++ggptHFF3pdE4/tphYCnFh71Gav2sUll2hsRDLlmYnQIopkWQsMmBx+g1PRRhtBqIAZANhgYSytlbvhMDtQ=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2250.namprd04.prod.outlook.com (10.167.8.150) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14; Sun, 21 Jul 2019 01:53:03 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.013; Sun, 21 Jul 2019 01:53:03 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 4/4] Cygwin: socket files are not lnk special files
Date: Sun, 21 Jul 2019 01:53:00 -0000
Message-ID: <20190721015238.2127-5-kbrown@cornell.edu>
References: <20190721015238.2127-1-kbrown@cornell.edu>
In-Reply-To: <20190721015238.2127-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6790;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00019.txt.bz2

Change path_conv::is_lnk_special() so that it returns false on socket
files.

is_lnk_special() is called by rename2() in order to deal with special
files (FIFOs and symlinks, for example) whose Win32 names usually have
a ".lnk" suffix.  Socket files do not fall into this category, and
this change prevents ".lnk" from being appended erroneously when such
files are renamed.

Remove a now redundant !pc.issocket() from fhandler_disk_file::link().
---
 winsup/cygwin/fhandler_disk_file.cc | 4 ++--
 winsup/cygwin/path.h                | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_d=
isk_file.cc
index 193192762..fe4ee6971 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1190,10 +1190,10 @@ fhandler_disk_file::link (const char *newpath)
   char new_buf[nlen + 5];
   if (!newpc.error)
     {
-      /* If the original file is a lnk special file (except for sockets),
+      /* If the original file is a lnk special file,
 	 and if the original file has a .lnk suffix, add one to the hardlink
 	 as well. */
-      if (pc.is_lnk_special () && !pc.issocket ()
+      if (pc.is_lnk_special ()
 	  && RtlEqualUnicodePathSuffix (pc.get_nt_native_path (),
 					&ro_u_lnk, TRUE))
 	{
diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index 2fd9133c4..65cfa7e7c 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -184,7 +184,9 @@ class path_conv
   int isspecial () const {return dev.not_device (FH_FS);}
   int iscygdrive () const {return dev.is_device (FH_CYGDRIVE);}
   int is_fs_special () const {return dev.is_fs_special ();}
-  int is_lnk_special () const {return (isdevice () && is_fs_special ())
+
+  int is_lnk_special () const {return (isdevice () && is_fs_special ()
+				       && !issocket ())
       || isfifo () || is_lnk_symlink ();}
 #ifdef __WITH_AF_UNIX
   int issocket () const {return dev.is_device (FH_LOCAL)
--=20
2.21.0
