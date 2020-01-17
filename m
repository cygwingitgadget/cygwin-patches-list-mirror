Return-Path: <cygwin-patches-return-9951-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48510 invoked by alias); 17 Jan 2020 16:11:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48501 invoked by uid 89); 17 Jan 2020 16:11:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690122.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Jan 2020 16:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=SOEcfnVRyQBMqO/qcsrI4d0M1Ud11NcQOJ2MC+N0MRlhnLMBx7QSfT+/lP6lffGJ/0sikzEiYd/b7bfyHObHGuRM6r4Agx0letoNGk5UQjH+xETX20+iIWFgnYiAo+4TcBvsQRxAloX2uePoeKcaWpucFpbIDLxc9QHWuYttASGuDxF/hTeLzfJ3v6BoxZEfwXSrLduWM5OzKrO3xcYLlXxXCUK45bOIITqrl9OJTwsDBPAl+TwYks2cG/SGf3HQnA1ubDz0a36ElFVK6oYzGw8W4lZyleHl8b25YW0kRQEJXk/hldK3c1DtcR3aseqBukisAz36ijODqouURAnWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=bA/vkyhg3GOUS2FZD4SOanozKogl6daj6GEOd1wqBDM=; b=NHrAU9ZV0JjjMARutjAtpyHrxsCAV9kknrTaRvtI/Xto5t5mmU8MhshpWcCm4PWhaD0CAKro2YxMKRAC9xzcKUMih1yszy4Bx+FCTQRU/eriSTYQb1kNejSE2ebdUpJmf5s7CeHY4O+zwV1Jm2bBWHzitr1Ai4eFdOZUXoaQmMl8YaNUlRokWDMdG5MHeBwnGBiyY2z+NP5DBMLIznuO65929jJuqF70sifJjoGmk0imxP6nfl9EEOgx3bcgVYZVr+SMvZejyuku+b/FLtKPE2oIZO2wjmSptu9CsS3ke5HKAwIqKNn3mKNG1TWJRu8MIQsP7cMuP56L90xAgFrngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=bA/vkyhg3GOUS2FZD4SOanozKogl6daj6GEOd1wqBDM=; b=afQq7IDGh3BUfw9p1KCuVxSsxNLA7R0QyXaXMbDIwMNPP6ALjqV6FTz82BODrEbG3FtKdzSi255xTCdekUW8W8GkrOuj405wx3EWbBuEWdD79MRv//3o/6Ek/WC19yg6cgky539WxknvfPktsIz+3IckbpjE2ZJtsFwedBb7WXM=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4761.namprd04.prod.outlook.com (20.176.107.144) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Fri, 17 Jan 2020 16:11:03 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020 16:11:02 +0000
Received: from localhost.localdomain (65.112.130.194) by BN6PR14CA0035.namprd14.prod.outlook.com (2603:10b6:404:13f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Fri, 17 Jan 2020 16:11:01 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v4 3/4] Cygwin: fstatat, fchownat: support the AT_EMPTY_PATH flag
Date: Fri, 17 Jan 2020 16:11:00 -0000
Message-ID: <20200117161037.1828-4-kbrown@cornell.edu>
References: <20200117161037.1828-1-kbrown@cornell.edu>
In-Reply-To: <20200117161037.1828-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtvwvVX8o/gsVrBDkC9a327p13AWEjiYsI6NwofYTvX/wa1kg2RD1gFrv/O94C/VfkY+TufQx3ZMgBHPnT2hxA==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00057.txt

Following Linux, allow the pathname argument to be an empty string if
the AT_EMPTY_PATH flag is specified.  In this case the dirfd argument
can refer to any type of file, not just a directory, and the call
operates on that file.  In particular, dirfd can refer to a symlink
that was opened with O_PATH and O_NOFOLLOW.
---
 winsup/cygwin/syscalls.cc | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 282d9e0ee..4956b6ff5 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4785,14 +4785,36 @@ fchownat (int dirfd, const char *pathname, uid_t ui=
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
+	    {
+	      cygheap_fdget cfd (dirfd);
+	      if (cfd < 0)
+		__leave;
+	      strcpy (path, cfd->get_name ());
+	      /* If dirfd refers to a symlink (which was necessarily
+		 opened with O_PATH | O_NOFOLLOW), we must operate
+		 directly on that symlink.. */
+	      flags =3D AT_SYMLINK_NOFOLLOW;
+	    }
+	}
       return chown_worker (path, (flags & AT_SYMLINK_NOFOLLOW)
 				 ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW, uid, gid);
     }
@@ -4808,14 +4830,27 @@ fstatat (int dirfd, const char *__restrict pathname=
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
