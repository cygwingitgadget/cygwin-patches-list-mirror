Return-Path: <cygwin-patches-return-9726-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40085 invoked by alias); 26 Sep 2019 12:24:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40068 invoked by uid 89); 26 Sep 2019 12:24:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Spam-Relays-External:sk:NAM02-C, HX-HELO:sk:NAM02-C, H*RU:sk:NAM02-C
X-HELO: NAM02-CY1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr760103.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) (40.107.76.103) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Sep 2019 12:24:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Om6JYnzDcHN1h3ZzoCO6fFzMvneQVJYdbxTF3OsanyF7mKiCKTLi10R3BE5f93z8hU7vlsG/HLLx89i6PARM4ZNsvIdok2z42CMUVwesT2vGkKoibARq/2GbUDUxzGVxIHtXb2iDi6TbxHajtc8H/SB/XAHmAcZ1XSRZ4HSOgwQCPNOrO9ZOOSMehodY1v62QiAjohmpuii9JhRWns3S5ymnfSGjqL2x6NKH0hOPIoMM4uYdygty1sKnn0iNsYqx6dLHoyJJc9h2eDYjMLFiOCL4REWuF9Wjn2lmmlXCEzuC0NjLFIRmdOoeDXGlIDwRtPp4EpQ+cKE8PLCBZc8OBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ogRpONwSKYjgMg1i4j/9Evw1eU+/qbqtLnxDugx/XRM=; b=TDfU6Vu7hCY4Krh48zrUmdYDxDQABUE6ER8qS5pGN/dt47aZr9WuH+yYR7J6oqwxPaJABNWaqYJmRi4vBUIRFSpbbrNTE4/kPWa9IGkf3jpYiQtmS0m5Fjw9AcDWqxAEKkrg/0ZkCm7J5dOYpGFbWNWhosqYJb+7yPyvHixCzRAcxKTtkUOKe8VHANL3aT4InyP3cCIkZhRVmJkHhdk8MO6UqXBi/ga6RGh8unABUZ/gA7b8ic/dxSr5F3Dga3wxFUoZ3n0xvrvdy8PI5aTC0DdN5b7XZdRGvRYQQvDTgwW2izh5upPhlTSYwzNdOY0BxbAInyxmmS5UZ6uwZHqzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ogRpONwSKYjgMg1i4j/9Evw1eU+/qbqtLnxDugx/XRM=; b=dIg1xtXSx6rD/OI7dIx/MK5WdDjqAe7kjUqMfgA/18Dts9TVWa2kY6LANFJsHPhgxnCSV+jZ4kexvtJuGy/aH1LcohEFCzfNc/zOlaorK5NuWbE+tSYdKAVm2B9v9nmr+CECR5WUdNYdMbU4bW00ryFs71ESLT636c6w5o5Q1t0=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6444.namprd04.prod.outlook.com (10.141.160.150) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep 2019 12:23:58 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019 12:23:58 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2] Cygwin: normalize_win32_path: improve error checking
Date: Thu, 26 Sep 2019 12:24:00 -0000
Message-ID: <20190926122335.21294-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:7691;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3oTHaHP4Sn5gcc2u2hdLBEegievPpraa+NEdIIS49vRmtCVyz2axz9NM4sqS9hL5Mr8TvB2d31WS3VGMXcCvw==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00246.txt.bz2

If the source path starts with the Win32 long path prefix '\\?\' or
the NT object directory prefix '\??\', require the prefix to be
followed by 'UNC\' or '<drive letter>:\'.  Otherwise return EINVAL.

This fixes the assertion failure in symlink_info::check that was
reported here:

  https://cygwin.com/ml/cygwin/2019-09/msg00228.html

That assertion failure was caused by normalize_win32_path returning a
path with no backslashes when the source path was '\\?\DRIVE'.

---
v2: use isdrive().
---
 winsup/cygwin/path.cc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 2fbacd881..f61003578 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1406,15 +1406,18 @@ normalize_win32_path (const char *src, char *dst, c=
har *&tail)
   bool beg_src_slash =3D isdirsep (src[0]);
=20
   tail =3D dst;
-  /* Skip long path name prefixes in Win32 or NT syntax. */
+  /* Skip Win32 long path name prefix and NT object directory prefix. */
   if (beg_src_slash && (src[1] =3D=3D '?' || isdirsep (src[1]))
       && src[2] =3D=3D '?' && isdirsep (src[3]))
     {
       src +=3D 4;
-      if (src[1] !=3D ':') /* native UNC path */
+      if (isdrive (src) && isdirsep (src[2]))
+	beg_src_slash =3D false;
+      else if (!strncmp (src, "UNC", 3) && isdirsep (src[3]))
+	/* native UNC path */
 	src +=3D 2; /* Fortunately the first char is not copied... */
       else
-	beg_src_slash =3D false;
+	return EINVAL;
     }
   if (beg_src_slash && isdirsep (src[1]))
     {
--=20
2.21.0
