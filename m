Return-Path: <cygwin-patches-return-9714-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118344 invoked by alias); 21 Sep 2019 17:34:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 118335 invoked by uid 89); 21 Sep 2019 17:34:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=remained, hasn't, hasnt
X-HELO: NAM03-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr790119.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) (40.107.79.119) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 21 Sep 2019 17:34:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=QLgGqzwsUIvAvBzHr8CgZqIampKQzDrCBbSVh52AU0yoiLDyH1EqSpvxWktXpzvyCTUKzYrGLzUBXl2HFdJyO14pqkbtpclGheU+3d7wzMiqK5dWelSSJWKE04Bl2HSZdGOkT20fzp98khw8ScWDiRIkaK7UJ8Myu+NOSFrQvlc2pCXXnMxEuVaOdXdNWPDpDEfLsGGvNopIh/fkVMOMGLJCQ04w6ktnuY1h5jnPl66wIRAJHIiddEhH4wbHiUXeqTHzuG2VpM/I+fjsfGN91FeljcV7JIkZjeRL1tMFcCypLz57HiLoRlJxSM111tuYGk9GBIgo34yKaT92uL5cfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=bStCGnXXWQ4niALyDkpih4EPo1WXnUy6xSYskEpeCEQ=; b=ObBd/zrl/NWGYOtWQ0hxzlG/ciwIcwMi/JWanH6EolQ1Ir1t6sbnsmUgHWag1vaiTjFQ2Q5xQa4AQcvcu3w3oCM6YiThjDN5DjgzC+/kfR02ktexWPLikyBaqTgZpKxVflIGqbni3kmg3YXRWKMDU1TfmEczRHCHQqJj1dwnyQlq64792n15kXEXAR7U/recx4kV/KFcaRcZQ+iODtaYiNnnjPneSawaTwKTOqMpKilO4J9ePYCEmA6UZ/c7PM44M/+iTgT6ZzhK+lncdj7NwkpwHyVTgCCxLJ1djcZKAe3nXr0VIr1uA+INC3at8YqIICn2dPgtrlIWnAVGzagUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=bStCGnXXWQ4niALyDkpih4EPo1WXnUy6xSYskEpeCEQ=; b=GDrfv0LDEYixw6hel8rzfkhIcf6OHUh4TO4LjP+VssCrV522NYxGn0hZyPVM4BCLUol7QCFoP+1ZptueFdEb9wkMJyIZFSf3B7UT0Uzrc3Yb8OorSH4LAHHatC+S56845M5PA6ykJ0BAMvPJMWOamwXJoQFpuxplVv3swzo6PDk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5836.namprd04.prod.outlook.com (20.179.50.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Sat, 21 Sep 2019 17:34:05 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sat, 21 Sep 2019 17:34:05 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: remove old cruft from path_conv::check
Date: Sat, 21 Sep 2019 17:34:00 -0000
Message-ID: <20190921173347.1527-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:2512;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iC7WTcmNQiP553G6TZkspkFLLkVTR208KmHcnxtuCXReqLe39bLkm1wcJgKAeLnizWC7Hv7IALuyaMPEN/tVg==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00234.txt.bz2

Prior to commit b0717aae, path_conv::check had the following code:

      if (strncmp (path, "\\\\.\\", 4))
        {
          /* Windows ignores trailing dots and spaces in the last path
             component, and ignores exactly one trailing dot in inner
             path components. */
          char *tail =3D NULL;
          [...]
          if (!tail || tail =3D=3D path)
            /* nothing */;
          else if (tail[-1] !=3D '\\')
            {
              *tail =3D '\0';
          [...]
        }

Commit b0717aae0 intended to disable this code, but it inadvertently
disabled only part of it.  In particular, the declaration of the local
tail variable was in the disabled code, but the following remained:

          if (!tail || tail =3D=3D path)
            /* nothing */;
          else if (tail[-1] !=3D '\\')
            {
              *tail =3D '\0';
          [...]
        }

[A later commit removed the disabled code.]

The tail variable here points into a string different from path,
causing that string to be truncated under some circumstances.  See

  https://cygwin.com/ml/cygwin/2019-09/msg00001.html

for more details.

This commit fixes the problem by removing the leftover code
that was intended to be removed in b0717aae.
---
 winsup/cygwin/path.cc | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index c13701aa0..2fbacd881 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1168,19 +1168,6 @@ path_conv::check (const char *src, unsigned opt,
=20
       if (dev.isfs ())
 	{
-	  if (strncmp (path, "\\\\.\\", 4))
-	    {
-	      if (!tail || tail =3D=3D path)
-		/* nothing */;
-	      else if (tail[-1] !=3D '\\')
-		*tail =3D '\0';
-	      else
-		{
-		  error =3D ENOENT;
-		  return;
-		}
-	    }
-
 	  /* If FS hasn't been checked already in symlink_info::check,
 	     do so now. */
 	  if (fs.inited ()|| fs.update (get_nt_native_path (), NULL))
--=20
2.21.0
