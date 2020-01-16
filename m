Return-Path: <cygwin-patches-return-9942-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29380 invoked by alias); 16 Jan 2020 20:50:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29358 invoked by uid 89); 16 Jan 2020 20:50:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=operates
X-HELO: NAM10-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam10on2122.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) (40.107.94.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Jan 2020 20:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=MfMYnsZoiY2k/TVbo222D15Yb7zVIuu84+Hw0955GbBjckZ+OrAeesTUbgxExZPXhCnJyTrF5sPN0ESr6ArjovNg5G4tthhKnQh8Te/XEx/ygfZHAqBGm0c3t+dCu6Hdc2H48B7aEWtmP7fZ3Aj3q5ATsAH9+AZ8FWCFx9pKBSEreUqdPWoEub5GJbg1P5AAQLaNIWUhwISnlWly8vslHD+Jb2MTXIeOsqABD0QF9qP1I8KAeg4NWHk9P+2C6q8/jiohdJJxw4YJ7P4jFytkMptvzTSKmuTmge9nZ6PP+ZH+RfveOkjqIa/MFp5GX4mD/YkRYfnpdh3StmuWTy7EFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=3eb38V0BL1QwnfvqVsXQhiRlBokDMXPs7gkTk19gp4c=; b=hO7ijL/R2aSXOdjv5D5+vWBNbGB8oZ63aKKBSP6rFfHSs1yEI5RCheT6O/I8T+1KLX505W+wr3wSz3hwNYA5MT7QQ8TnGflmp0ySRkuTRJ7SDaaC8A3iUoegLDT6wufdQfwODrv09AqgHZILm9CBCpuojVj9SbGyV8x1TXSjovWw4zbffRLk5IZ3cmio3Gs/m5xyxtn776En9Oidh4apZaDOM769uvKq12v0ngqZv6JCw3LOSa4TtYFGlErykWdNGfGv2Y2VCrR1dwnet6yYkhVs/JUgK5HnPPQEMkHFgwgikgU+86i5Tc4JsvVsbCD4McKZEoU4ozuhnTupND/pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=3eb38V0BL1QwnfvqVsXQhiRlBokDMXPs7gkTk19gp4c=; b=M9xadZZnV3MQG1ci4uwJxr/6NIhcEO9lnvc6GGn2EbSc3u34V6QFyEZkXlG9oLawBPtNISgSJQOaH0X5MCO3WQIJGU/dkqfyFfduSQ0sZtXwg7SKm0c9F8K6ftgJm8fk0TFUg791/qTvn9Tv1VFXj9j/O5z5Fa+rBMK78vwaSHo=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6378.namprd04.prod.outlook.com (10.141.160.86) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Thu, 16 Jan 2020 20:50:07 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020 20:50:07 +0000
Received: from localhost.localdomain (65.112.130.194) by BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 20:50:07 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3 2/3] Cygwin: readlinkat, fchownat: allow pathname to be empty
Date: Thu, 16 Jan 2020 20:50:00 -0000
Message-ID: <20200116204944.2348-3-kbrown@cornell.edu>
References: <20200116204944.2348-1-kbrown@cornell.edu>
In-Reply-To: <20200116204944.2348-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7219;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nphCykKLnSw2F97s7btix27Agr65VFIqTohuAM2TEx7foDHWncol4thqwnWvK7c1y/UKh/KhUPJDZHN/unbiw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00048.txt

Following Linux, allow the pathname argument to be an empty string,
provided the dirfd argument refers to a symlink opened with O_PATH and
O_NOFOLLOW.  The readlinkat or fchownat call then operates on that
symlink.  In the case of fchownat, the call must specify the
AT_EMPTY_PATH flag.
---
 winsup/cygwin/syscalls.cc | 40 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 038a316db..3d87fd685 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4785,14 +4785,29 @@ fchownat (int dirfd, const char *pathname, uid_t ui=
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
+	  /* pathname is an empty string.  This is OK if dirfd refers
+	     to a symlink that was opened with O_PATH and O_NOFOLLOW.
+	     In this case, fchownat operates on the symlink. */
+	  cygheap_fdget cfd (dirfd);
+	  if (cfd < 0)
+	    __leave;
+	  if (!(cfd->issymlink ()
+		&& cfd->get_flags () & O_PATH
+		&& cfd->get_flags () & O_NOFOLLOW))
+	    __leave;
+	  return lchown (cfd->get_name (), uid, gid);
+	}
       return chown_worker (path, (flags & AT_SYMLINK_NOFOLLOW)
 				 ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW, uid, gid);
     }
@@ -4979,8 +4994,23 @@ readlinkat (int dirfd, const char *__restrict pathna=
me, char *__restrict buf,
   __try
     {
       char *path =3D tp.c_get ();
-      if (gen_full_path_at (path, dirfd, pathname))
-	__leave;
+      int res =3D gen_full_path_at (path, dirfd, pathname);
+      if (res)
+	{
+	  if (errno !=3D ENOENT)
+	    __leave;
+	  /* pathname is an empty string.  This is OK if dirfd refers
+	     to a symlink that was opened with O_PATH and O_NOFOLLOW.
+	     In this case, readlinkat operates on the symlink. */
+	  cygheap_fdget cfd (dirfd);
+	  if (cfd < 0)
+	    __leave;
+	  if (!(cfd->issymlink ()
+		&& cfd->get_flags () & O_PATH
+		&& cfd->get_flags () & O_NOFOLLOW))
+	    __leave;
+	  strcpy (path, cfd->get_name ());
+	}
       return readlink (path, buf, bufsize);
     }
   __except (EFAULT) {}
--=20
2.21.0
