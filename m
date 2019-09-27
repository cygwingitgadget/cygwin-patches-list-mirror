Return-Path: <cygwin-patches-return-9728-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112810 invoked by alias); 27 Sep 2019 18:44:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112794 invoked by uid 89); 27 Sep 2019 18:44:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Following
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740113.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.113) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 27 Sep 2019 18:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Pry+my9rR9eosiq5rCFHgDN8n+xxoxLcTaAeLhPg+EJwTwh/DrmrJ+e07mo/ftZ8phvjkzoH3R/+L+N1neOsYtSoIghfRd6otdLcXmGrFWOYyYp8t/XS+TZCMeHelmBcGs9iiTKc//AxCWntwQGI70jLkzR4ZecDzsTPkmZ3nrzX5/56oGYBdngzd/6RRaNAcmR0wlMqSBAcPGudEoFwjS2PCQLaNe793Qzy7IkS42c7SWobhCdQnU8o3xCKU/JZuEDvD2yC9a5EfZetenL+qnLBtOuId1dHtfsGRTDBhGmiLQ1ul6R/CjJShZeLVI4CrqXwSB8XnuX3dY8DVIxbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=qGRsYCO7Jd+YUxBVJJEFsn6fJBAxKqiNec5jl0HI62k=; b=eZ24niln957Mee2eQQmBOFtLWOFHhJ2FULpB7/8JY2gp5S/FqLScFn5xZKfQ/t5MFVfAj+si5rO3egJXhoS2IkVfD2V8Lh5GM/91xhz6haMvQJp0bEGcyVmoLaKCLsYE5t51CxFnUFGbkHdfbf2uhPwJsuO0OQHNRI7cMMpYfhzxQ0qtK4HrcM8FT1Aq4M19sOYxfK5MJY6+fC9zY+g8pJrlXO1rTEuiapCTFSqc2Bv+PgCnkVxG1NTswlv9CzFEnmnGOvxS7ixPGPRa8tFk/pFgSdNHrPFigDIuHmmYKgpaeyzpkl2DT4xoNG44TR6bbopL0SvpkLKZCHNC2hlyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=qGRsYCO7Jd+YUxBVJJEFsn6fJBAxKqiNec5jl0HI62k=; b=HL73815Qcv+/k5eridtAudK1z8YFHOpVOA+KpMjEWOaAr+vdY5UysZ5fXufqwVqCZT5gvea6XU0P19n0BxG5X7tXqd4GhvUMgPlLzMq8vzHvftJLXbpl4xCGgzpbrnOkWRen2NRtw6pRzjWFSOQpA50TkWpLf7DN4m2E2476z4I=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5195.namprd04.prod.outlook.com (20.178.24.148) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.16; Fri, 27 Sep 2019 18:44:17 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019 18:44:17 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "eblake@redhat.com" <eblake@redhat.com>
Subject: [PATCH] Cygwin: mkdir and rmdir: treat drive names specially
Date: Fri, 27 Sep 2019 18:44:00 -0000
Message-ID: <20190927184400.1478-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2KGjhInqPu4QTQUgJui3Ig64Lapuav/vVHYGp8t5k0grlyXqr9NuPrycyGMALpOxY1ZwBDGTfdLWoYfuBTNyQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00248.txt.bz2

If the directory name has the form 'x:' followed by one or more
slashes or backslashes, and if there's at least one backslash, assume
that the user is referring to 'x:\', the root directory of drive x,
and don't strip the backslash.

Previously all trailing slashes and backslashes were stripped, and the
name was treated as a relative file name containing a literal colon.

Addresses https://cygwin.com/ml/cygwin/2019-08/msg00334.html.
---
 winsup/cygwin/dir.cc | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index 29a9dfa83..3429fe022 100644
--- a/winsup/cygwin/dir.cc
+++ b/winsup/cygwin/dir.cc
@@ -313,15 +313,27 @@ mkdir (const char *dir, mode_t mode)
       /* Following Linux, and intentionally ignoring POSIX, do not
 	 resolve the last component of DIR if it is a symlink, even if
 	 DIR has a trailing slash.  Achieve this by stripping trailing
-	 slashes or backslashes.  */
+	 slashes or backslashes.
+
+	 Exception: If DIR =3D=3D 'x:' followed by one or more slashes or
+	 backslashes, and if there's at least one backslash, assume
+	 that the user is referring to the root directory of drive x.
+	 Retain one backslash in this case.  */
       if (isdirsep (dir[strlen (dir) - 1]))
 	{
 	  /* This converts // to /, but since both give EEXIST, we're okay.  */
 	  char *buf;
 	  char *p =3D stpcpy (buf =3D tp.c_get (), dir) - 1;
+	  bool msdos =3D false;
 	  dir =3D buf;
 	  while (p > dir && isdirsep (*p))
-	    *p-- =3D '\0';
+	    {
+	      if (*p =3D=3D '\\')
+		msdos =3D true;
+	      *p-- =3D '\0';
+	    }
+	  if (msdos && p =3D=3D dir + 1 && isdrive (dir))
+	    p[1] =3D '\\';
 	}
       if (!(fh =3D build_fh_name (dir, PC_SYM_NOFOLLOW)))
 	__leave;   /* errno already set */;
@@ -360,20 +372,31 @@ rmdir (const char *dir)
 	  set_errno (ENOENT);
 	  __leave;
 	}
-
       /* Following Linux, and intentionally ignoring POSIX, do not
 	 resolve the last component of DIR if it is a symlink, even if
 	 DIR has a trailing slash.  Achieve this by stripping trailing
-	 slashes or backslashes.  */
+	 slashes or backslashes.
+
+	 Exception: If DIR =3D=3D 'x:' followed by one or more slashes or
+	 backslashes, and if there's at least one backslash, assume
+	 that the user is referring to the root directory of drive x.
+	 Retain one backslash in this case.  */
       if (isdirsep (dir[strlen (dir) - 1]))
 	{
 	  /* This converts // to /, but since both give ENOTEMPTY,
 	     we're okay.  */
 	  char *buf;
 	  char *p =3D stpcpy (buf =3D tp.c_get (), dir) - 1;
+	  bool msdos =3D false;
 	  dir =3D buf;
 	  while (p > dir && isdirsep (*p))
-	    *p-- =3D '\0';
+	    {
+	      if (*p =3D=3D '\\')
+		msdos =3D true;
+	      *p-- =3D '\0';
+	    }
+	  if (msdos && p =3D=3D dir + 1 && isdrive (dir))
+	    p[1] =3D '\\';
 	}
       if (!(fh =3D build_fh_name (dir, PC_SYM_NOFOLLOW)))
 	__leave;   /* errno already set */;
--=20
2.21.0
