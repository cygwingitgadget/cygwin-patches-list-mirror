Return-Path: <cygwin-patches-return-9491-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68613 invoked by alias); 18 Jul 2019 20:02:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68599 invoked by uid 89); 18 Jul 2019 20:02:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM03-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr800112.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) (40.107.80.112) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Jul 2019 20:02:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=ZiuUvavlIpcvqukwzg38DUA9dsP2FDTrlXMoYWUxu5LbrYprEucu06OjBp5z9PQ5UTS9hXE9OO9gKFvoUtQhrcIZPCCWtbnsh+VezONrbc5D+gW83xQrmUdSSKuBjN5QUb4NEuIs85n3CkMxKGFk+mFtPEgf+MNIVX2vsTdMB3zdjMKv9stMnRhulZdKl5c2UL5yrgRXqQtceVF19T8qNNfHAdsyj3VzF9qFoFFHEvxJ2As1Mv6dw5/QClzHnAfUwFaRcSw74HJQuEqPULE8zKT4hpcIj0Ok6PDvSgSrZSRMn4KXFE1KPtDbovUPIJuaNz0DZ9bZYKJJy2iPtOttrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=WpNMcwcivXXJSEiFp5l8Ixrrnak7AX8aNYghh8lNCE8=; b=bYt1EuBsO8IPDnN7EEtpd8EKm75y9k85Y1A3AUjYxIf6BUhy+JTCDhvLd/kyTaZtdBKKVzWmZCKXGHmuINl19RzQlc3LmPwDoyTPxbY6XrjsP7la+bB5E53xbt7i5oGEE5yAT6PACJP6m6LM1FZjxL79NJkBSQwphtMb1uJbLHlgmMpvn8NihjfYaC3v8UHOY3fosAA/s8LVKl5MCUt10eHbk/afl2jE/9AESkEgN68gCRhrAiAhoFimqnFGhDbW76/XfZuavQ/ela/KMKFNhWipdsefGXQr6IGuGT3qU5U7fJH++yPsLHXTyPiDYUK2aAhqlo18UR9sY7D4/SRXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=WpNMcwcivXXJSEiFp5l8Ixrrnak7AX8aNYghh8lNCE8=; b=N8E+KiMKwIwLieOrz9hhI3evBQd8t/SLWc1Fz4uX0mCMl3Koj7+0a8L7et+vXxmdMKt0pxxpMrqEI7AZ7aJ/UgsPQ4AqQH96Ax6vwGFkFizeDU/rVXYQFw5P0jdhSCZqaePoXLBampA5kuRjAQLEXL2dA7z2nMewyXY2maFQuWg=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2363.namprd04.prod.outlook.com (10.167.8.141) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.11; Thu, 18 Jul 2019 20:02:10 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.011; Thu, 18 Jul 2019 20:02:10 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: make path_conv::isdevice() return false on socket files
Date: Thu, 18 Jul 2019 20:02:00 -0000
Message-ID: <20190718200026.1377-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 2
x-ms-oob-tlc-oobclassifiers: OLM:4714;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00011.txt.bz2

As a result, socket files are no longer treated as lnk special files.
This prevents rename() from adding ".lnk" when renaming a socket file.

Remove a redundant !pc.issocket() from fhandler_disk_file::link().
---
 winsup/cygwin/fhandler_disk_file.cc | 4 ++--
 winsup/cygwin/path.h                | 2 +-
 winsup/cygwin/release/3.0.8         | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

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
index 0c94c6152..5571218bd 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -179,7 +179,7 @@ class path_conv
   int issymlink () const {return path_flags & PATH_SYMLINK;}
   int is_lnk_symlink () const {return path_flags & PATH_LNK;}
   int is_known_reparse_point () const {return path_flags & PATH_REP;}
-  int isdevice () const {return dev.not_device (FH_FS) && dev.not_device (=
FH_FIFO);}
+  int isdevice () const {return dev.not_device (FH_FS) && dev.not_device (=
FH_FIFO) && !issocket ();}
   int isfifo () const {return dev.is_device (FH_FIFO);}
   int isspecial () const {return dev.not_device (FH_FS);}
   int iscygdrive () const {return dev.is_device (FH_CYGDRIVE);}
diff --git a/winsup/cygwin/release/3.0.8 b/winsup/cygwin/release/3.0.8
index e3734c9b7..11d11db6f 100644
--- a/winsup/cygwin/release/3.0.8
+++ b/winsup/cygwin/release/3.0.8
@@ -11,3 +11,6 @@ Bug Fixes
=20
 - Fix a hang when opening a FIFO with O_PATH.
   Addresses: https://cygwin.com/ml/cygwin-developers/2019-06/msg00001.html
+
+- Don't append ".lnk" when renaming a socket file.
+  Addresses: https://cygwin.com/ml/cygwin/2019-07/msg00139.html
--=20
2.21.0
