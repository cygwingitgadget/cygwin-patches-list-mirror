Return-Path: <cygwin-patches-return-9720-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87922 invoked by alias); 24 Sep 2019 17:55:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87906 invoked by uid 89); 24 Sep 2019 17:55:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr680116.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) (40.107.68.116) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 24 Sep 2019 17:55:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=QsbHv/5vV6EH0Ca5rrzV3+HW4JDeb2g5JpTsMI85J/cesOttBxSAGHs13CUFK0KYdVNKwJNDvGRI4xvrSBEMmkO7VAN1pP3TQftRcmtkjObUaLtLdOi82CGnvS2dHF+lWokyyemxu3KmL90GoUjzsZimM7XFSJEeiQpx4K0sqSuEA4/U1T5pu52y3EJE5QFHVY1nQ0IeUvSsxb8sx0W9uH65oKNfwVWP8WdsR3cETwgU31bjVkFpCyUUTqvO2yB77UPkUbAbP+wWOgsJvh76Q8FXV8GurLUTT7QPWm44P5Km/Z3ybdyRE682yYYOptsmoJ6RkTZ11FdnCRkErGXp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZLpkxX8yiZGHQfTQfmcj3BKHhjSLxB68DJL7KX0L15w=; b=IUMW4pRoJ+/TXYZoNeFuuyTxniJOuPx7k2YHXeeCmvoEGBdmLnbyuMFahp8Fj7CcOMgI9Op09rY8IAH7lepVNOT4d9UJcyyYR7WRzo6BsUa4M8xZtbxdYtf0Ccbav8onCwqzuf76bxascQT36DdDb2RYorZocprWuxEFfUZ1PQMM2a3ba8/OyEnjmPNQDfRMlyppo5f84u3IVAHrjfwSFa/1GtVamtMbkWm3k0fYtBRUJP734YwQNjd1/6KKWuf38SDXhRTHenVU0k1DgRnWjXofOcx1L17RkpUOMitb2/TLAk7NX8eXECwB0iSv2GLsOIcEJWS+DFBy01r0+xCdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZLpkxX8yiZGHQfTQfmcj3BKHhjSLxB68DJL7KX0L15w=; b=G/Oz3dLBQ91HVOa3SqfrmBFBd4+3tshsjTB+E3LFH6M56D4Cnqk1Q2z8oBaqdCErFHgCc/yLu7hGk0sQ442wmtmqb2KkiyjF/SbpHJmBsvNdUTN4ezUMXdIMVuGkjSGC9yaF7CbIV2mCSv+KBtR7u9/YnqdPxIndHDOeL6mAiBc=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5482.namprd04.prod.outlook.com (20.178.224.79) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Tue, 24 Sep 2019 17:55:47 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019 17:55:47 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "eblake@redhat.com" <eblake@redhat.com>
Subject: [PATCH v2] Cygwin: rmdir: fail if last component is a symlink, as on Linux
Date: Tue, 24 Sep 2019 17:55:00 -0000
Message-ID: <20190924175530.1565-1-kbrown@cornell.edu>
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
X-MS-Exchange-CrossTenant-userprincipalname: DUrn4R5dd42bkBeiSjm0w8tXNCYcvHutydrtbgXLGCjEfHZTIaxVuy5lnXvqmVEeNYqy6fUB2K9auPu622bGHw==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00240.txt.bz2

If the last component of the directory name is a symlink followed by a
slash, rmdir should fail, even if the symlink resolves to an existing
empty directory.

mkdir was similarly fixed in 2009 in commit
52dba6a5c45e8d8ba1e237a15213311dc11d91fb.  Modify a comment to clarify
the purpose of that commit.

Addresses https://cygwin.com/ml/cygwin/2019-09/msg00221.html.
---
 winsup/cygwin/dir.cc | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index b757851d5..0e0535891 100644
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
@@ -351,9 +350,29 @@ rmdir (const char *dir)
 {
   int res =3D -1;
   fhandler_base *fh =3D NULL;
+  tmp_pathbuf tp;
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
