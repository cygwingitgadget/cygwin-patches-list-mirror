Return-Path: <cygwin-patches-return-9718-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 57658 invoked by alias); 22 Sep 2019 17:19:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 57649 invoked by uid 89); 22 Sep 2019 17:19:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Following, resolves
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690107.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.107) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 22 Sep 2019 17:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=ctuh6Jy6ZEckUsHSY5LVYwnTooDJeiUg6C/SSBz11Ro8sIGJavHkKfaOOFNowGaMOM1KhXmCzpECItDMrPL7QpBnoBDSYHb8Fsn9ckr0GCFCg9JgkwJ4gUGFEnj90QJWkYQCDv5fvc9yhlkNSuuqE1wjtREZXWDVfwluu+8GHq+FVIr86P1bd7W9hEoK2vAr41SJ/55ia+foJP440VGhqzicySW+TZ9G2trRJeaVS2z0T8b1vjItxeC5MH4VWJHlUSIsJu/VKKTvmqs/H54QyorGZ2FJXNBLbU4NzCuSkeBFJyrz9jgkFfU1Vdykss9jl6TGAWlu7gwTyW/+gTuDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=vfTxqOLuiez3Xaalw/NWZXg98H5p11b+n5cTtCgbH+M=; b=lM8XWVXeqxwqCKvHiqqJYqSSBWX20ZLaACSc3TQolXyiQRVX+zHFSFf03W9m4KL8+1NCty75Nb3S6CukGQy2/fnNDn68pu4XiY1dZ2XHh8L2P3VHxdDDCd6T1f6TQIgXm4Y1nys3fybz1FWLPDttOxMiHiQDtYz/lrEV0GCqF/TwlZrf2tdec4tnUAiZEi/GmpDOQpAkA2GBJhY5RHojWwdg9QU+SFJSbjwTuFWgphb+65UKRW1P9fhdNinYGW1Eew2PP+Qdy6+Pc3lvXIH2lKjVhhid7z+phw6lvNM5y5AFPaBaiYjxSZE5XNjoGhRRJS0p2QqvKE2Zo559LbYQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=vfTxqOLuiez3Xaalw/NWZXg98H5p11b+n5cTtCgbH+M=; b=UsJILgNvnWFXwOhbuW8yNTeS4s0m7FHP9k92EhKLHrWvQ8wfTsGIch2nX46a6raXYLSYpEGuehNfb+vCsDEoBF9gYIIlX5hCigS3Skw64WGLS19DSdAVpEeqLJYJbRJQJUN8YqcG1UTOXxbCjuT0avv4kkZqSge4jX5xE4CMS1M=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4667.namprd04.prod.outlook.com (20.176.107.140) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Sun, 22 Sep 2019 17:18:46 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2284.023; Sun, 22 Sep 2019 17:18:46 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "eblake@redhat.com" <eblake@redhat.com>
Subject: [PATCH] Cygwin: rmdir: fail if last component is a symlink, as on Linux
Date: Sun, 22 Sep 2019 17:19:00 -0000
Message-ID: <20190922171823.3134-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:2043;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ueyblVsqJ1dmkN5MclLe8ipAnK6SLaoKEPjNjrNspQ74PePJbUEbhLIuLOwc1U6jROO/Jx9rkzHKyKy5pPrOg==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00238.txt.bz2

If the last component of the directory name is a symlink followed by a
slash, rmdir should fail, even if the symlink resolves to an existing
empty directory.

mkdir was similarly fixed in 2009 in commit
52dba6a5c45e8d8ba1e237a15213311dc11d91fb.  Modify a comment to clarify
the purpose of that commit.

Addresses https://cygwin.com/ml/cygwin/2019-09/msg00221.html.
---
 winsup/cygwin/dir.cc | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index b757851d5..f65c9bdad 100644
--- a/winsup/cygwin/dir.cc
+++ b/winsup/cygwin/dir.cc
@@ -305,15 +305,14 @@ mkdir (const char *dir, mode_t mode)
=20
   __try
     {
-      /* POSIX says mkdir("symlink-to-missing/") should create the
-	 directory "missing", but Linux rejects it with EEXIST.  Copy
-	 Linux behavior for now.  */
-
       if (!*dir)
 	{
 	  set_errno (ENOENT);
 	  __leave;
 	}
+      /* Following Linux, do not resolve the last component of DIR if
+	 it is a symlink, even if DIR has a trailing slash.  Achieve
+	 this by stripping trailing slashes or backslashes.  */
       if (isdirsep (dir[strlen (dir) - 1]))
 	{
 	  /* This converts // to /, but since both give EEXIST, we're okay.  */
@@ -354,6 +353,25 @@ rmdir (const char *dir)
=20
   __try
     {
+      if (!*dir)
+	{
+	  set_errno (ENOENT);
+	  __leave;
+	}
+
+      /* Following Linux, do not resolve the last component of DIR if
+	 it is a symlink, even if DIR has a trailing slash.  Achieve
+	 this by stripping trailing slashes or backslashes.  */
+      if (isdirsep (dir[strlen (dir) - 1]))
+	{
+	  /* This converts // to /, but since both give ENOTEMPTY,
+	     we're okay.  */
+	  char *buf;
+	  char *p =3D stpcpy (buf =3D tp.c_get (), dir) - 1;
+	  dir =3D buf;
+	  while (p > dir && isdirsep (*p))
+	    *p-- =3D '\0';
+	}
       if (!(fh =3D build_fh_name (dir, PC_SYM_NOFOLLOW)))
 	__leave;   /* errno already set */;
=20
--=20
2.21.0
