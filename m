Return-Path: <cygwin-patches-return-9952-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48985 invoked by alias); 17 Jan 2020 16:11:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48974 invoked by uid 89); 17 Jan 2020 16:11:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-21.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690122.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Jan 2020 16:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=dt1EVQeKLrfkdBo0tzgl85lVqudA4jcrMdCoiR99eQfby6d7175Jm48io862+xlQ4hM+rDQRagr+E63JcgxH4dZRinNGiRHCdH2HkQHbrJ9fNXzbvsSHniPnW2KwTs0vpemeoCrv61VBGtzm2sEnYeCPLjPbwCBxMhtyCXAEttPr78sFXPXpxtSCgbgEIeMn0w1GKTtqAvZHkNOXCmhQL/Lv9iJ3SfvgQmBM6v2CcbFruFsw6g9nDIUZBfCA4pkRA1gL3He94F4bMyL949VPJqtW/Dg7/iLV39D82rKDMCKrY9X6O6naATAUZoI3XsoNRoTnDYxikvmRatdrfF5UWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+UzuasEI2FWx/EN5SWOXiRJth87YVOhsqNj/G47sYR0=; b=JCFXCfxTDwe/exvztnQ/R65H8lSPO+UBPfsWL8cOO1Vs8PXlMWkiktr4rYUJ/fA66n1+Sr0sP/qXsHFOzIOuCQ7QCy33qbFlzZUfK314QGz8MDlzVuWFuDYDk92CDh1VsHicnPBI9GAsadY9UhTLNDJQA7cn4sCG9y7t9ox9M/gjw84jW+/PzbV5IW24vzqVyrI4mcdZowI6SDgCMVbpPUZ8ZnZj1VW4MVY92gtZyY2i4hc3fQWktkDANhNWoaL+CNepIZ0plz+qSmgT0KZTJwkgmPsSjRwUdCxK3/xXAdWgKwU2c/A/RNpZb5XbS25UY52tUAOnKaGOur7Jp5cifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+UzuasEI2FWx/EN5SWOXiRJth87YVOhsqNj/G47sYR0=; b=CA+Q8+Z4okFptUbgInDqrWQwwNgMFGwzebB1FbGrHV9XMqk/Fhw6nfPW77yp9Z+wSclihid663Srklzrb2tOpXWS8t7+kL7CdtZtZWDvFfYG+gCRFPyxtElWzN+dIHGtoP0rykm3RNSmSVRXGyd8dTH/opU7H8WLpispWefNpLU=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4761.namprd04.prod.outlook.com (20.176.107.144) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Fri, 17 Jan 2020 16:11:04 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020 16:11:04 +0000
Received: from localhost.localdomain (65.112.130.194) by BN6PR14CA0035.namprd14.prod.outlook.com (2603:10b6:404:13f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Fri, 17 Jan 2020 16:11:02 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v4 4/4] Cygwin: document recent changes
Date: Fri, 17 Jan 2020 16:11:00 -0000
Message-ID: <20200117161037.1828-5-kbrown@cornell.edu>
References: <20200117161037.1828-1-kbrown@cornell.edu>
In-Reply-To: <20200117161037.1828-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6790;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzgCWicHhu61J5tXgvrZvI2X3RqNeBx+w0QcM42sErj44LiK4t592khpIyDbdRggad3k5j0mZEiKZBys6P60aA==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00058.txt

---
 winsup/cygwin/release/3.1.3 | 19 ++++++++++++++++---
 winsup/doc/new-features.xml | 15 +++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/release/3.1.3 b/winsup/cygwin/release/3.1.3
index 489741136..425d8bb2d 100644
--- a/winsup/cygwin/release/3.1.3
+++ b/winsup/cygwin/release/3.1.3
@@ -1,5 +1,18 @@
-Bug Fixes
----------
+What changed:
+-------------
+
+- Allow symlinks to be opened with O_PATH | O_NOFOLLOW.
+
+- Allow the pathname argument to readlinkat(2) to be an empty string,
+  provided the dirfd argument refers to a symlink opened with
+  O_PATH | O_NOFOLLOW.  The readlinkat call then operates on that
+  symlink.
+
+- Support the Linux-specific AT_EMPTY_PATH flag for fchownat(2) and
+  fstatat(2).
+
+Bug Fixes:
+----------
=20
 - Define CPU_SETSIZE, as on Linux.
   Addresses: https://cygwin.com/ml/cygwin/2019-12/msg00248.html
@@ -7,6 +20,6 @@ Bug Fixes
 - Fix the problem which overrides the code page setting.
   Addresses: https://www.cygwin.com/ml/cygwin/2019-12/msg00292.html
=20
-- Fix a regression that prevents the root of a drive from being the
+- Fix a regression that prevented the root of a drive from being the
   Cygwin installation root.
   Addresses: https://cygwin.com/ml/cygwin/2020-01/msg00111.html
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 65bdc17ab..967c64ac5 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -54,6 +54,21 @@ Allow times(2) to have a NULL argument, as on Linux.
 Improve /proc/cpuinfo output and align more closely with Linux.
 </para></listitem>
=20
+<listitem><para>
+Allow symlinks to be opened with O_PATH | O_NOFOLLOW.
+</para></listitem>
+
+<listitem><para>
+Allow the pathname argument to readlinkat(2) to be an empty string,
+provided the dirfd argument refers to a symlink opened with O_PATH |
+O_NOFOLLOW.  The readlinkat call then operates on that symlink.
+</para></listitem>
+
+<listitem><para>
+Support the Linux-specific AT_EMPTY_PATH flag for fchownat(2) and
+fstatat(2).
+</para></listitem>
+
 </itemizedlist>
=20
 </sect2>
--=20
2.21.0
