Return-Path: <cygwin-patches-return-9882-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6227 invoked by alias); 28 Dec 2019 19:52:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6147 invoked by uid 89); 28 Dec 2019 19:52:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2091.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 28 Dec 2019 19:52:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=XiR+fqcZ88VD+Mbc/KCqfD9JyXz1dCn+JTH28TuAvTLokwRJjdjTddmZy7oVDQJsEBhMBmwHZoZb/2EsV2jNNev6F3AkQIVnUMUsYtol4kt+a8GuhrQCn5rwgGSjqPsd9SxVl/CCb6HHd99S1JBXUyNXDPu9djZaYmKEkCZHLrmuOXMeYJnlIKB/vCsCjSP2XfpXXCGbmXSZG3TY50bBl00YmCKAlTdobA0u1amm1wo8q5di7NufaIhSRdt0u1YCTM9CHAfs8sfeFF6pZw0R7sljCF5Rv2FJXgFjkCWj3E8H6GJWcHVboH5kbRRLvEHdJbnYG6d8FZInsFHQFFCcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=f1di2E5274nSlcx2/gRt2QK8fiZR0kIcPowCmjHlPiI=; b=nuWIrcZAhlM7ZXYwhhmRFOrDA27jciT8CeUQoXiFNA2Smc7D9Xa7iVH6G27BQhZWoz+zLKBn7+UQwbsZIXvGmgs+mvH1Luk8Uv7CB0xN7jQf5aJ9qFBvYJRkNi2Vrs0RB/6RDT32LXLfadS8zwGa5jf9m0J0LRaiBY4CQNmlGRn1XiNQdtXXUIKZy4Ch4uuzk10IvIe6HpJ9Y8nY9iWqT1dOS7iAOi5N68I2OxqIMigpEzMnkDwR7drdboS22hGAswKoUln+e2KoFI6Im97PDRJjpCC438GzWurRjKHP8JqhrwWPJTdTGDC3+T45a1v3znC5oa6fJ4JewqCR3Y/MXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=f1di2E5274nSlcx2/gRt2QK8fiZR0kIcPowCmjHlPiI=; b=SdKIcLkwDHrK/oxCmr4B5RvDsl4De2o16wMLD9D65FItD/6u9+USPgGqqgcztkli1s53/5MXM6p76MCCI4G3vk/MkHzkt4bfltb0lYmcWr7IAPTGLeeNPfc9KygOPdGEH6WzHF/uuIHoIo6Pymn6VaSW0QIZSk+r4Tsgqbu2Uvk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5210.namprd04.prod.outlook.com (20.178.24.151) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Sat, 28 Dec 2019 19:52:31 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Sat, 28 Dec 2019 19:52:31 +0000
Received: from localhost.localdomain (68.175.129.7) by CH2PR18CA0048.namprd18.prod.outlook.com (2603:10b6:610:55::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Sat, 28 Dec 2019 19:52:30 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 3/3] Cygwin: fchownat and fstatat: support the AT_EMPTY_PATH flag
Date: Sat, 28 Dec 2019 19:52:00 -0000
Message-ID: <20191228195213.1570-4-kbrown@cornell.edu>
References: <20191228195213.1570-1-kbrown@cornell.edu>
In-Reply-To: <20191228195213.1570-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eP68TxgfLavIEvfvx/bJoby201m87bTAHY+aG5ZB4EWRkna4d37iQaW5qGirVnWaPzCtjjlKI6g3dGUmks0kBQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00152.txt.bz2

Following Linux, allow the pathname argument to be empty if the
AT_EMPTY_PATH is specified.  In this case the dirfd argument can refer
to any type of file, not just a directory, and the call operates on
that file.  In particular, dirfd can refer to a symlink that was
opened with O_PATH and O_NOFOLLOW.

Add a new optional argument to gen_full_path_at to help implement
this.
---
 winsup/cygwin/syscalls.cc | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 2be8693c9..1bc856268 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4635,7 +4635,8 @@ pclose (FILE *fp)
=20
 static int
 gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
-		  bool null_pathname_allowed =3D false)
+		  bool null_pathname_allowed =3D false,
+		  bool at_empty_path_flag =3D false)
 {
   /* Set null_pathname_allowed to true to allow GLIBC compatible behaviour
      for NULL pathname.  Only used by futimesat. */
@@ -4644,20 +4645,25 @@ gen_full_path_at (char *path_ret, int dirfd, const =
char *pathname,
       set_errno (EFAULT);
       return -1;
     }
+  bool empty_path =3D false;
   if (pathname)
     {
       if (!*pathname)
 	{
-	  set_errno (ENOENT);
-	  return -1;
+	  empty_path =3D true;
+	  if (!at_empty_path_flag)
+	    {
+	      set_errno (ENOENT);
+	      return -1;
+	    }
 	}
-      if (strlen (pathname) >=3D PATH_MAX)
+      else if (strlen (pathname) >=3D PATH_MAX)
 	{
 	  set_errno (ENAMETOOLONG);
 	  return -1;
 	}
     }
-  if (pathname && isabspath (pathname))
+  if (pathname && !empty_path && isabspath (pathname))
     stpcpy (path_ret, pathname);
   else
     {
@@ -4674,12 +4680,14 @@ gen_full_path_at (char *path_ret, int dirfd, const =
char *pathname,
 	  cygheap_fdget cfd (dirfd);
 	  if (cfd < 0)
 	    return -1;
-	  if (!cfd->pc.isdir ())
+	  if (!empty_path && !cfd->pc.isdir ())
 	    {
 	      set_errno (ENOTDIR);
 	      return -1;
 	    }
 	  p =3D stpcpy (path_ret, cfd->get_name ());
+	  if (empty_path)
+	    return 0;
 	}
       if (!p)
 	{
@@ -4785,13 +4793,14 @@ fchownat (int dirfd, const char *pathname, uid_t ui=
d, gid_t gid, int flags)
   tmp_pathbuf tp;
   __try
     {
-      if (flags & ~AT_SYMLINK_NOFOLLOW)
+      if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
 	{
 	  set_errno (EINVAL);
 	  __leave;
 	}
       char *path =3D tp.c_get ();
-      if (gen_full_path_at (path, dirfd, pathname))
+      if (gen_full_path_at (path, dirfd, pathname, false,
+			    flags & AT_EMPTY_PATH))
 	__leave;
       return chown_worker (path, (flags & AT_SYMLINK_NOFOLLOW)
 				 ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW, uid, gid);
@@ -4808,13 +4817,14 @@ fstatat (int dirfd, const char *__restrict pathname=
, struct stat *__restrict st,
   tmp_pathbuf tp;
   __try
     {
-      if (flags & ~AT_SYMLINK_NOFOLLOW)
+      if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
 	{
 	  set_errno (EINVAL);
 	  __leave;
 	}
       char *path =3D tp.c_get ();
-      if (gen_full_path_at (path, dirfd, pathname))
+      if (gen_full_path_at (path, dirfd, pathname, false,
+			    flags & AT_EMPTY_PATH))
 	__leave;
       path_conv pc (path, ((flags & AT_SYMLINK_NOFOLLOW)
 			   ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW)
--=20
2.21.0
