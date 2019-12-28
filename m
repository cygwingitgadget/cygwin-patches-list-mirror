Return-Path: <cygwin-patches-return-9881-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5634 invoked by alias); 28 Dec 2019 19:52:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5546 invoked by uid 89); 28 Dec 2019 19:52:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=refers
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2091.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 28 Dec 2019 19:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Pi1sUG2OLMp9v4/ViIhfg3LogovB4q53XEvjAbBBkug31X9m5cljXxNWKFX4nJr3UAcPEHJcneeqz4oALrAG72laJpVhk1cA3du2F+AdvicZ9NcXVl3ri7UVw0vfWiu9UCllKCwnjCuZniruZ/HXScGC+6kCcPkae8j9W++X5C/gXMB+PR2/aaSiJRhi3xlcCBUMG8ObNuSY3c392QzJBLDmWy4GSHIpQ6NICQM4J7JNNW6sxbMWM0EQCdk37rfmygmP/bvpKyndxCNbNmNbGchLwqyilmslYpNpREvno2KmnDAo4qm7dUG2ynR57Ub/j6QWSqdOepCv7KoCafiE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=hrW+iTis3dhRWoNkd6xSIi6yonrQUAXFyfQRA8slrmw=; b=LoeAA46lua6Lds9IfBH08f66VYyspVBZkPkV+KcdQeNOQx/SYjm4GNeKtzq5gkZzLrbfs6A79dgrG4BMOna4mOSpCmbLcX+6Jv/aqE1NSYyhI84XLOYCgLf2iya9l6Ku3ePftw9U/PBogc5UyPYihslpg+ZZSQJ4aCbIzkNM/wmvwzQeyqVpL+XXzqy9Q8WLVLgZ/8wBXZ1p2m3tRF1fmM9BmMhZZ4Qs/RvLCr2eAmgMdIu+ofZ/H44pyWXjK5ZJEwmO8JaaSJVTJTOun40ygmznnbEZG5Z9NrEWu856GYBd9lLxMO0mReCNZ20KnoBNcDLDIKJsiCnZfX7wbvzi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=hrW+iTis3dhRWoNkd6xSIi6yonrQUAXFyfQRA8slrmw=; b=DPAUUyWfs89SOJYI750lWMdphMnlihmiuPsTMtPno/2F7HOiFHaTVaBed05GzTmgN7EuCLenna6hKyZLex7Ey4kth72ZZ/+acsweNcTYQZb73T+aLPAbUdjsJd6ItpcuGn4RRTiSgZEyeMdavn6Tog89spnaI6lpwSQrhZXXeeY=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5210.namprd04.prod.outlook.com (20.178.24.151) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Sat, 28 Dec 2019 19:52:30 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Sat, 28 Dec 2019 19:52:30 +0000
Received: from localhost.localdomain (68.175.129.7) by CH2PR18CA0048.namprd18.prod.outlook.com (2603:10b6:610:55::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Sat, 28 Dec 2019 19:52:30 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 2/3] Cygwin: readlinkat: allow pathname to be empty
Date: Sat, 28 Dec 2019 19:52:00 -0000
Message-ID: <20191228195213.1570-3-kbrown@cornell.edu>
References: <20191228195213.1570-1-kbrown@cornell.edu>
In-Reply-To: <20191228195213.1570-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7219;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/gt0kDNmRKjsKo212/qJo0iUOlgzq8YeeRPQpnRDSYi1AafR1BW7HviO5H7eUIUNzytXBT7jImhscCMu9yl+A==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00153.txt.bz2

Following Linux, allow the pathname argument to be an empty string,
provided the dirfd argument refers to a symlink opened with O_PATH and
O_NOFOLLOW.  The readlinkat call then operates on that symlink.
---
 winsup/cygwin/syscalls.cc | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 038a316db..2be8693c9 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4979,8 +4979,23 @@ readlinkat (int dirfd, const char *__restrict pathna=
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
