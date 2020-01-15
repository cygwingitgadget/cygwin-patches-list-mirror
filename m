Return-Path: <cygwin-patches-return-9937-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48149 invoked by alias); 15 Jan 2020 17:47:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48131 invoked by uid 89); 15 Jan 2020 17:47:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*r:151, letter
X-HELO: NAM10-DM6-obe.outbound.protection.outlook.com
Received: from mail-dm6nam10on2091.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) (40.107.93.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Jan 2020 17:46:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=JVV+Di//GLY64fUcXr665Bzy+ecLvkE22lAsHOnfiBgxTLN5I6i6ygv8Iwauw+1DI7fZ4XosszPUzNR6B2kWrB4YJwG3U/EClfi77MvCw10NsUWzAC0DZfAubGrI6718ZCO2x2pdfttp8coR1mk8bHNmp6bur6esJKdlqMXfcOQwEDehD0teH0ieMWjlVXk3MC/Xlgh9NnKFT88gOHaF9hwDMZsw15KnTbo1HdFlYBxFL81uuqO+DtIzbYApA/a7jWxQCqmD+puVqMoeWz77ZfcFhis7KiV0yLXiJ7prKBYSAERM8729DDPU/24t9uhaVV0WOfuzkjaXzRd5Q7uvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=BKD8thmdQO4EHRrAi+GIVm2JUmYSABpD0X7qdRup+II=; b=PRdxIiYCccMPyWr1CcDPKaucKBgEonBwskWjUetFVYbfyJAMIndRHOq8Fty11N+njmDpEOeiOru0yVFSjltaQB0lEVl+m0oXfSm9l2BF3o30MWKfIJ5tm23vpah1BvWtFbLQFVhYY4+0Hw7BYGrLtLkVAuphJEdwbPlq5dXB1O8nRJHPG/enmGn/HV2sQyzF1fam+7L02p4XX6BptD8ATxKTTRORBJCuK3S3egy1vO9GDNIg4fwysNI9epQ8qvVJ0IIfAmjHVE5pxzUm7qPsaUFYFQxlMNhgkKQiwi7JXzhbpin1fubNjN5/xu1d/qKMGuaUyTVzhADvelZqyG7VvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=BKD8thmdQO4EHRrAi+GIVm2JUmYSABpD0X7qdRup+II=; b=R2Onza+95AsFqdGr7g1vIaHTYAX58/e3FQLZRDoHPyTiqJLoLXF/K7HzExpuY15ZcLLiCGgrQgdjHPpgD5B19PCy0X6PqwWVoBCH3V63QdRZjmTVtWgl+S+rcTqjAYm5ewPAhYZJTX7cEjhF3ipahS6b9aMg8+dS9DjJcHsdKik=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5753.namprd04.prod.outlook.com (20.179.49.217) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8; Wed, 15 Jan 2020 17:46:54 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020 17:46:54 +0000
Received: from localhost.localdomain (65.112.130.194) by BN6PR20CA0067.namprd20.prod.outlook.com (2603:10b6:404:151::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 17:46:54 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: normalize_win32_path: allow drive without trailing backslash
Date: Wed, 15 Jan 2020 17:47:00 -0000
Message-ID: <20200115174632.7986-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7CjUfPJvK2pNJfxD3UFoDhYmRSQxrJUtsCTRBHcZ7/7cAuPvmvNaKAr926Q51YpJDGqVQV9xn58cHSYbSy1cQ==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00043.txt

Commit 283cb372, "Cygwin: normalize_win32_path: improve error
checking", required a prefix '\\?\' or '\??\' in the source path to be
followed by 'UNC\' or 'X:\', where X is a drive letter.  That was too
restrictive, since it disallowed the paths '\\?\X: and '\??\X:'.  This
caused problems when a user tried to use the root of a drive as the
Cygwin installation root, as reported here:

  https://cygwin.com/ml/cygwin/2020-01/msg00111.html

Modify the requirement so that '\??\X:' and '\\?\X:' are now allowed
as source paths, without a trailing backslash.
---
 winsup/cygwin/path.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index c8e73c64c..a00270210 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1411,7 +1411,7 @@ normalize_win32_path (const char *src, char *dst, cha=
r *&tail)
       && src[2] =3D=3D '?' && isdirsep (src[3]))
     {
       src +=3D 4;
-      if (isdrive (src) && isdirsep (src[2]))
+      if (isdrive (src) && (isdirsep (src[2]) || !src[2]))
 	beg_src_slash =3D false;
       else if (!strncmp (src, "UNC", 3) && isdirsep (src[3]))
 	/* native UNC path */
--=20
2.21.0
