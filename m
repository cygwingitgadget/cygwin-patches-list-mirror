Return-Path: <cygwin-patches-return-9887-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87510 invoked by alias); 29 Dec 2019 17:57:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87443 invoked by uid 89); 29 Dec 2019 17:57:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1483
X-HELO: NAM12-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam12on2132.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) (40.107.244.132) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 29 Dec 2019 17:57:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=ZNVNOl1RclhOYrmSbgnchUqCy/+APqahS6okTZT2U+WOrQgIUFmd5pnHssML9pOjIWcM4ukAoL8Bjc+Ys1xCdWIWxXGXHuUclLFOP5HzTjIluZUbr7I+KFwVovMIYPJLhUckmc+SmxBUs9nu11WnWNG1Bw4LpwPQoz0kMvZ4ByWWyjdbfOazdGZKcOlw53LhOtYQN8PYGEePfLp2D652tAtzagZvOGLpAoe141eMtHDsajESPnElYsBhx5HizZtbNF7d2RcLPo43G0Sfo2Rb3QuS2lziFNSjOSGKJLHADiVxkVrfVstbGB5MqlOKsc0ZdAFul0gUivC0//+BZGM0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Tmgvrkxprk+Eu7QdHrNL6yLZ+zYd/vSTZ3l+y/4zyTU=; b=KxbUYqGDVGQWq6+QGMgdDuaWdDBlP25Fctu69wYcI4qp5DFcJ519ZX4n7B1p7ZuzM3SOzv3bNntBp1VdB8nWlNYANxMRblZp+1WVfevEjzusZc09zXbRaIhNNSe3bKkXBddGv2XShpjBqHJm8OZp8IwT9U6+G56gjkHYlGvjml33KpL3HrFtAeQp1JXE7eciljeAWiC5d5wMy7PQ7noBo+wVgc7/czjDSGc+NxBikZSTCrvPZrJuuAXbRlkHkdLT1hS2EXdV8eCcqRHkjujNeG8i3szewlmRKOCxJLvci+K4l9Q8E15F3Bq9VCT7UMqlsqzSy8Ftd+kSeg96dCTDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Tmgvrkxprk+Eu7QdHrNL6yLZ+zYd/vSTZ3l+y/4zyTU=; b=GbcJlsTJP3qV88RvOj/qw/kgRIbLMi19T0ujOEc36N23x5RiBO0vdRcO5ayYpeZrEXTINmp1gHfpOFUYB3wyxX/nvz8oNxdEr+E7gMHFwaR6y85JkdnPEZbg4K3nTCXvQ/s9vENyFo9bEJwIS59kFXGxaMKP3ImSEXGa5aNlBVo=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4345.namprd04.prod.outlook.com (20.176.76.21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Sun, 29 Dec 2019 17:56:58 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Sun, 29 Dec 2019 17:56:58 +0000
Received: from localhost.localdomain (68.175.129.7) by CH2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:610:51::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend Transport; Sun, 29 Dec 2019 17:56:58 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 3/3] Cygwin: fstatat: support the AT_EMPTY_PATH flag
Date: Sun, 29 Dec 2019 17:57:00 -0000
Message-ID: <20191229175637.1050-4-kbrown@cornell.edu>
References: <20191229175637.1050-1-kbrown@cornell.edu>
In-Reply-To: <20191229175637.1050-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPBQFxIGaSGAH1Fm8WteoLnOfaeJGxNKdhK+Wz9EujdAsXMCcPLg0lEtxmymR3evYOkI0SKmIU/6fuaCpOziFQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00157.txt.bz2

Following Linux, allow the pathname argument to be empty if the
AT_EMPTY_PATH is specified.  In this case the dirfd argument can refer
to any type of file, not just a directory, and the call operates on
that file.  In particular, dirfd can refer to a symlink that was
opened with O_PATH and O_NOFOLLOW.
---
 winsup/cygwin/syscalls.cc | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 2be8693c9..9b7d6dbfd 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4808,14 +4808,27 @@ fstatat (int dirfd, const char *__restrict pathname=
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
