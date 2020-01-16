Return-Path: <cygwin-patches-return-9943-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29915 invoked by alias); 16 Jan 2020 20:50:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29903 invoked by uid 89); 16 Jan 2020 20:50:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM10-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam10on2122.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) (40.107.94.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Jan 2020 20:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=SN/eZO+TU2uHnAavMRAk8fGnMqrzP7wv1FsB2IGf6Y3mzyHxBymLLCcNjXq2uM901plwG3jhW5bm4GciOgcROwAKKyonhOQmrToJ7uW1LvSm1TXgzJUxVyHhUD9i8qjFUIMzlQ4/IMnEQKcEHmEqO7c0rfZX3fr+2vq3xx6X/ZwL74TTYMU60tzuICozCozJli2kNU7tJ1AFcEQq86VOdCokHPpdk+0YZKhVO3/KM5nEWX9KzeE2ly0u3o5oEJtXw0/ylEPUNTYyU7KtZ0ElAXtoWvg4/a8Gua6Akdl1cry1MLMiX3LWMGlwDBIsoMvbbi7UErRaRLcXRl4u+L6eFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=OXIByidA34nh1uBFVTR5fxrhl7PZ6gCzHPhc38+q+pE=; b=Vxd2Apxh+PX9s9UOGa/8tAoYY2/x34sDZ6Ti9sCOAjQ3eN0Ws6dIpFDA1bZTF8yXyVnChE6O0GMErl16mY9G52gSHtgW5iihF4T78gV7apPOTXaGRYLZUp6HPVqUDxCENI4oKBxGr7a6N+TW0Ge3JZ19dU94kLBDIzWvyrydyBSurAy+Ekm7YzQ78ppEk3gdGQDw09WOs1gWlArQRdJazotmmAGhAKWvopmeb6ZwoPUUoeitxhyfbWA0pPK33Ogh3ctBF5nb0J71tDl+QurXXmTrlldEEnSc2j/bBM3Q54tOZaUfp4pkts8m7RgUT4Q+VlIcTEeJXQGIFApIcRUsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=OXIByidA34nh1uBFVTR5fxrhl7PZ6gCzHPhc38+q+pE=; b=EBOa0YDMLCmW1dc9KZa67G1ayif1TjD9/Wl3c6UN/c4G9M81S5xUJ6d/vrJzifHCFU61zjgt+4uH9t6tbMAasUdwRpMRGImcs9XACf0+YcgQqnq1wCqoiMDuD1vuJKfxseOYQ7hqIHa2YSuZcv2PLJfUD/J9Hc/wzClmfw1ycvw=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6378.namprd04.prod.outlook.com (10.141.160.86) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Thu, 16 Jan 2020 20:50:08 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020 20:50:08 +0000
Received: from localhost.localdomain (65.112.130.194) by BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 20:50:07 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3 3/3] Cygwin: fstatat: support the AT_EMPTY_PATH flag
Date: Thu, 16 Jan 2020 20:50:00 -0000
Message-ID: <20200116204944.2348-4-kbrown@cornell.edu>
References: <20200116204944.2348-1-kbrown@cornell.edu>
In-Reply-To: <20200116204944.2348-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwPCSvgF9QS802jsLFozJ6MgdG39yOrFSmsz6BGEpdTrW3301c9EKst8VAlEk9Wf9BW3HIU+MflO8PoD2e6tnw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00049.txt

Following Linux, allow the pathname argument to be empty if the
AT_EMPTY_PATH is specified.  In this case the dirfd argument can refer
to any type of file, not just a directory, and the call operates on
that file.  In particular, dirfd can refer to a symlink that was
opened with O_PATH and O_NOFOLLOW.
---
 winsup/cygwin/syscalls.cc | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 3d87fd685..e7298fd43 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4823,14 +4823,27 @@ fstatat (int dirfd, const char *__restrict pathname=
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
-	__leave;
+      int res =3D gen_full_path_at (path, dirfd, pathname);
+      if (res)
+	{
+	  if (!(errno =3D=3D ENOENT && (flags & AT_EMPTY_PATH)))
+	    __leave;
+	  /* pathname is an empty string.  Operate on dirfd. */
+	  if (dirfd =3D=3D AT_FDCWD)
+	    {
+	      cwdstuff::cwd_lock.acquire ();
+	      strcpy (path, cygheap->cwd.get_posix ());
+	      cwdstuff::cwd_lock.release ();
+	    }
+	  else
+	    return fstat (dirfd, st);
+	}
       path_conv pc (path, ((flags & AT_SYMLINK_NOFOLLOW)
 			   ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW)
 			  | PC_POSIX | PC_KEEP_HANDLE, stat_suffixes);
--=20
2.21.0
