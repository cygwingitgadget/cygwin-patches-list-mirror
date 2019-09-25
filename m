Return-Path: <cygwin-patches-return-9724-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59840 invoked by alias); 25 Sep 2019 18:47:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59831 invoked by uid 89); 25 Sep 2019 18:47:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770100.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Sep 2019 18:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=IDPRJaO2L+9i3VeLd86DeGoe5AzpCxUVa7Bi8x1GgXOOGE+qzpHZ2mK2Zf5Pnt8bYypJoMXdLLGJoig8HrFxdA1Yq7BPzBesB0FWwexZiGgX80lE5Tc+2ibE5f8FlT33vh+ZhEXe9NM0PmfBO69hz4r6ofVg4ews6rDttCMwxTZjoWVDcoqyuVlyiKn7N9j59d/ndb6in37HoHo29RFMxlKRTJd77mBM2hB6NrP39LVjaOjqX05zRBQTA9lw/WNPO3Bv9BNr4D7oQQgg8z65YAKugFIvBnb0wgRDQpm2fNntEa/G2tyhqRl90vP6i9Ts+sbGAT5fPf2OX8FksPW5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=CNjDwN4FL71ZoexTR8wbA0TiL0muZ1DlfL8W1O9u5kQ=; b=jbpdYF7+CupoJ32guHMcfX5ul1zjdkoX3DW85yIVVz19S6yxaDhOZ/OWIbbrjvGoHV/obfbHTiQnz+E2p8EChg61ha+OCOHolxFfGm2HWeNgFkvKy9LRWwLQJHGvMAnkC02Cq/pdh1T8u6JFazRrljMMvEQI26ZNb8i4P1pijGnJ0GqK+Sy9xSfOKlJaZCMGKQdh3DCehmrWu1SSKHWEwcGneLMFNxnZ2YJG1h/PqgyjzgnY0QM2XxHFtrHg1qiw00FgVfVBoZpXftaXpPf8XN+ehfvSwEpQYGf8PGvibhxD8m8I2LhfV11yResksunDAy2paM+nUPWl7ZxWmz6cjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=CNjDwN4FL71ZoexTR8wbA0TiL0muZ1DlfL8W1O9u5kQ=; b=BYWaayPfLxsOE4LTym+/lIYGDY7y6gFWMALBihZsxbybj9jY4bPMcV0CNyxCRHuKl9KoAUF17zO92btf82uZXyBzLPk5/YPiU/+oGkVxFXdosOVbq81k7CVAAusHfRQ7zOgZZi5Q4xtFN6V6m1CyqACtIFZQX+FxyBAAAwIs7RQ=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6635.namprd04.prod.outlook.com (10.186.141.77) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Wed, 25 Sep 2019 18:47:12 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019 18:47:12 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: normalize_win32_path: improve error checking
Date: Wed, 25 Sep 2019 18:47:00 -0000
Message-ID: <20190925184655.336-1-kbrown@cornell.edu>
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
X-MS-Exchange-CrossTenant-userprincipalname: yGgiH7ZPE3bsjuo3nq+eW5qPKhY1V9pO5w8e1G9AgHQwlcLB2mocWzitEFX11IKejq/1PYMe9iIVVt2l7hkw8g==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00244.txt.bz2

If the src path starts with the Win32 long path prefix \\?\ or the NT
object directory prefix \??\, require the prefix to be followed by
UNC\ or <drive letter>:\.  Otherwise return EINVAL.

This fixes the assertion failure in symlink_info::check that was
reported here:

  https://cygwin.com/ml/cygwin/2019-09/msg00228.html

That assertion failure was caused by normalize_win32_path returning a
path with no backslashes when the input src path was '\\?\DRIVE'.
---
 winsup/cygwin/path.cc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 2fbacd881..2eeb4fd1c 100644
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
+      if (src[1] =3D=3D ':' && isdirsep (src[2]))
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
