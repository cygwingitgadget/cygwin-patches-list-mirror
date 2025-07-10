Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20729.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::729])
	by sourceware.org (Postfix) with ESMTPS id C7D863858C24
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 10:15:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C7D863858C24
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C7D863858C24
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::729
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752142514; cv=pass;
	b=HoFPG8S46ayhg1FGZPWfzu++bIqfOymG5ZJbbM4oWYuh7Xmet+NnyXgOlJh1GR2lf9DXGKNBsZISg6rZfobP+NKzM5e5m0c41se6DvQGH4/EKSUyLmr0xJwwWAdizK+Ydkvo17L6XNFMAk3jaexGG0Z6XXOcwOPG74wbk51i0Eg=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752142514; c=relaxed/simple;
	bh=vIYekxJc4UMUDaviQbASPiSa7osMs4rQKlTYVyR6IJ0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=XtmikZ0MIY+Hd9R11Pn3hRpY1g9M2Nm/sRAnW1nCVKg3L2iXhzeBV3KrCEnmAFJT5tbU3id2ZrdJ1GPxC3t3nFdkLry5C0j8qCLrt2ls6xm1OvHV52AaysOr74NtyZ9riyKAvGIniAmGNbUzBZuTsDUDDdYBRBrRv4fH/pcWVFI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C7D863858C24
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=gvre1SBl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxc+/UwR7A9+WdCrN80p9U9eXWX/9dnlpfKJDPdtjqurO+D6EY0SK8hRTrxzwGBinSWOqw6OMBsphz6WCUNhngSMSAfgH58GpGHGSTauLuRvnstzvIaWC137NdN4u59xfzkt9Rgw7fwxRIMLfVX9PK1FRT4MLcTAi10J36isHEVnJ7a9J2Q4JZVGd9WZbF/LjbnkEctxfKG0flEytsBb1EiReBpes5kY5KLIDHbZXDGFjczR4FL3xgBdnfafb1OglN9Z8gHBRMZg2INUsuSONZkkeVqVVUaYcnGNhMqCpqWk3VO3YPGHojJsTve3pRkqNNt1kjIyqBLgdWRMQxfSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoKrInveqzAkkT6tVforkH4OvdxdZXbdOAJL6xaDYyU=;
 b=WDhpA2C5e+CiU2+Nu8SF3sEFIrKPUkCSnAiTvEltX+N4+tvo6ZkTg6xW6mOmcvrCaw6qbrgKfFC6vwNU7GvK5ppeTB9g07S5B3eqOGSfmQOYTUU1YnIzZpJeBTuOtAs1xz2RBqg9fokHPdRC6YOb3KVa9z0JTHTjNWHco7mRiNScB+ToqWjMacnV9D/rvy6XH4ufaVRuFy0Td/zZXlD9+n+jE9VZRRdvlWgVvFn8hnY7PGjlLcSoZfg4smpowvn6mRvpYG1uOmKhnqGQcAA4OIwoywtJ8BAIOBZw4nwiyaBn5G/NXxwhHdYeWyrRMj0oe3Mt8+sa5Dusc6ky/MEF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoKrInveqzAkkT6tVforkH4OvdxdZXbdOAJL6xaDYyU=;
 b=gvre1SBl8JOieJvNv2f4xm6/3iZBzEajy1DncmWUEJOa57RTF5NhK13UU8FJqbcHivrJ9MifcxnhytEI8Wl2x50M495yVbi1f4mCWamH2ZcakBL5geVxN2Ibpt1o4x8I23pZgS07vKQG/Zduo74JHXRI97SWs0qx7U+eYC+07Ac=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DBBPR83MB0564.EURPRD83.prod.outlook.com (2603:10a6:10:533::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.8; Thu, 10 Jul
 2025 10:15:10 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 10:15:10 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Radek Barton
	<radek.barton@microsoft.com>
Subject: [PATCH v2] Cygwin: cygserver: add possibility to skip cygserver build
Thread-Topic: [PATCH v2] Cygwin: cygserver: add possibility to skip cygserver
 build
Thread-Index: AQHb8YOEwKVGrZhPVEaQwkccTO8AFQ==
Date: Thu, 10 Jul 2025 10:15:10 +0000
Message-ID:
 <DB9PR83MB0923C35FB2253C8C2A21927C9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB09232A0A1E4EC3D43BBAFA089242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB09232A0A1E4EC3D43BBAFA089242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T10:15:08.063Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DBBPR83MB0564:EE_
x-ms-office365-filtering-correlation-id: 9ca0ec4b-a495-490e-2132-08ddbf9aa702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?FH6iPDrTlsSRlSJLp7ERRsB8Prxh+bKUlgd09XK6ACwbeJvEjLdCnLBBlS?=
 =?iso-8859-2?Q?nTeT5i/AHbPZQuQgoUJv8rowsFSFUzrhUF5FNgqEJiKb++yQQkQl449GI1?=
 =?iso-8859-2?Q?Xlc97A3Zktwj8hxekid3riyaaM+4x+mu2FPgNqPguVSjTJlL8bjIQgXPH1?=
 =?iso-8859-2?Q?KYt/9Nui1uuzUUhfiA8NP89cHwkNDKOON+1w4E3NA/0f4xUwc/aM3ev+Oz?=
 =?iso-8859-2?Q?8VkUgUVkR4LqBabKfaxCYXEz+l4Qbl29gDZ+875o0zw23/m3yGgzbJt7k+?=
 =?iso-8859-2?Q?n2mTAST/yVqCx1NF6heKTQ4CuhOzsmSKnRRpvbejMBhDTSuU3htpys99hH?=
 =?iso-8859-2?Q?4VRR5ERzkEnLXY8n93TYlNPKhY+as0k+XQiFIn5qGlRbqN8yOIoisrC5N/?=
 =?iso-8859-2?Q?cy7FS/z1KQJZY+LsaSh/JgbTMpR/v+BkjU/oPR6wC9mgbFOuBjX1TR1cO+?=
 =?iso-8859-2?Q?RuaZMfSDo9c5WFOcQhwnuv9EnAARSQtDw0IsKGOtP78uOnFu/+LuE3ISp3?=
 =?iso-8859-2?Q?LqYzCJ8tTSsr7/zUD7UIZc9FBq/KK2E3CT3wlGhgkV5Sm49j0bWKCiKik7?=
 =?iso-8859-2?Q?S3duc+cGouM2eha8fb6no3Piih2iObENhBjNxCDM4d3JERncs+k3CgcpYC?=
 =?iso-8859-2?Q?JS4QIYgyB6TpaZt9wUdxwBFj6pRClOD309/MDxnJoKAticOOQ6yxLFaYMt?=
 =?iso-8859-2?Q?2Nm1ggnWs2mDDnvNQdznEATz738yxbB9Db2YkTQToD7b7XVIscaIofM4jh?=
 =?iso-8859-2?Q?XavtLSZ801DCPook5DJ3JovCbQMv3xQpyXYFF997tlL65bbJtmBAy6ltwT?=
 =?iso-8859-2?Q?hfo5fuwUbTqwhWbF7w3/5A9bTax2g9ljrOojXeCnXzT9nflWmnRHTMu8On?=
 =?iso-8859-2?Q?FLDD39WxSFnnBzQEgH8GdrAXTBvcc791n29E01eW3FxGvDQW2G/B4hh7ww?=
 =?iso-8859-2?Q?eAk/OgO0qBOsbC3kRcNIPwFoFLqBV49OKA+Yl21kUGDuJSFYHsgF1e1Osw?=
 =?iso-8859-2?Q?sEH0bgM4HzRjk1oLM3B1WHhEU4AOLjNmOgkNkdRQ7YyUs8eLWeNuy8nlv8?=
 =?iso-8859-2?Q?fpUPDGW8GnrD+UW4cRmtt1o64HE1MgdRavj/5Dukrn+SGb9eyhSRM25n6S?=
 =?iso-8859-2?Q?yfNqcQXOx06p1T5TSJI/TJGitmE2zj6DWtmVkXC++Qw0hBdWEcwmB3G1Ym?=
 =?iso-8859-2?Q?el8KoUXZzxy8URk5hiSkvJTEUf3ZfBcVF7mwBgQCKkp38EMkTvwKVukcw4?=
 =?iso-8859-2?Q?ttGjKkmNXU/k3S6XkfvFxJXiS31tTkgdv7LaQJ669m6E+AAmKUPTVc1ezQ?=
 =?iso-8859-2?Q?ACMiVIPb3BOWWyhmRXZFNXvvKZFKlL2JltXLxu01do860oPNOhIYRlT+OD?=
 =?iso-8859-2?Q?bx3b38StsAIKcqeIXz6lafWAeS04vycgd0zBGisD5oQrIoMh7bJTBfbmxB?=
 =?iso-8859-2?Q?FiQWf7NbxBfk1WYd1rEmaRtSvnIM1UnukgTvtjkHtwgIA6/r2BiH+VprEQ?=
 =?iso-8859-2?Q?CU7qM1WVifGTzzt++bxzecim8Qc6oeZDRNLS5a8NIdZf7mp9gu4c2wJElk?=
 =?iso-8859-2?Q?CwwMhxw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?acsQdMKk1C2VucMSwTgSIcJxrYbK4ZZD3RYA1/sBgenjTLUJFKkyYIVLjq?=
 =?iso-8859-2?Q?1A7lkK+9tmvc9ykLjkLjoIzXE9yvvddUjzeQiX5dfa2UIVW6jeqsQ5xDGC?=
 =?iso-8859-2?Q?g4d+nFEkUXGVSE56smaokC5+SKERv4vzyzG3hO1PgQTTBxedNx7lXkTet3?=
 =?iso-8859-2?Q?Z148+ibvk6LTVEMYO0YGCbz6+vTyVC9ABtkgbekm2ipXlHk8v6cYKe07hi?=
 =?iso-8859-2?Q?7qRMBsvVdYHTCzh1oflQOE5KSMIh9Lge5N3AB8fmSrb9RmIkH8eWzgSxeR?=
 =?iso-8859-2?Q?qrtLG5p0vjruF9+8IdtnjthHlz/P9jkd/OIuJqAW3VgUQazjoNEzErtHQx?=
 =?iso-8859-2?Q?bZpSQS7Tw2zmltJug3asyYg9C72EzcmSy9j92mihO6rjlZvyFva/wnoti0?=
 =?iso-8859-2?Q?meTHTdYBqPWu68YSHroaY4TNBoYvW2uOV6Aw3wuYbRpLO8am3/GYZCvFi0?=
 =?iso-8859-2?Q?tgKc57DM6brSKaURghK55Uv4jFAjLd1NSXuYcKRGAvixeKLdCJFmnIYhCR?=
 =?iso-8859-2?Q?KYIqbuCLd1D8Uke32l5dAFJj60rmkrOY8RIlXHBTFEN7ZdFZIbOaV5bcdS?=
 =?iso-8859-2?Q?LRJWrVakGAIKof5JZOr334rfwrgGtpmm1yrSSmtzWw1hRJEGGsm2K2s9fi?=
 =?iso-8859-2?Q?CzVV+nxY0n0gCR5LSDRgqEahQ1Wd/mQK6rp2BxdsAfoT/ZxfQpF5gSwASq?=
 =?iso-8859-2?Q?V9ns0ek/wZcfrwtwwkpI5ukm8VKWcacr0/iD2+pljtONBSTa+b9Y9qpLJZ?=
 =?iso-8859-2?Q?XNT8lziFATi7IluPt7rfs14LVfAAsVhX/NXiYXWwoKAso1xXLjiogqbcwc?=
 =?iso-8859-2?Q?FMeoU27RAvlapJqAu/hrtOvRksvu4qzkxlck5HP55P7wuc2hymGLsuIkA+?=
 =?iso-8859-2?Q?rOQde8A4TkWro4j7DTI8pf3Gr9J4q40nVcvPOIYiMHgVJcq9B2+M86Pmnx?=
 =?iso-8859-2?Q?FUAD7iIuDKeuPaAtErSvstngqquNVVNt6yWLWuMfegspSJ3KKkp9LfYUct?=
 =?iso-8859-2?Q?ydKAcLOLiuCXidSV5nRHXnUb2ppHfWqBp5MeyJsps5RXlTwkcB64ig/C3a?=
 =?iso-8859-2?Q?wQtcySVZA6+eVYrzzrUnvoHe7V7fKs17qMQAB2Zwb7wqI6JPXVOsO5wygP?=
 =?iso-8859-2?Q?LwIGp3wamXE58VzpOceHAgPUoBLVjU6vAPMlpQZYMmf8We7AaR4ngiQxX/?=
 =?iso-8859-2?Q?dM06lQQScA5bEiiKAPx+lJCL7+9Dv4VmesYKHxchtYQjmkT07ttXKfGQuk?=
 =?iso-8859-2?Q?L2XzmPu6f/FVlCjl1Pjf1DUsBZPB1kEHuJPBTQwirMiAx2KIoKfn7Dmdkd?=
 =?iso-8859-2?Q?RigEGaWvVcHNDd0tMKjtJJ0nHes1CLTp2onCvDCorfkwW1cHrrKo+YIIBV?=
 =?iso-8859-2?Q?yhfXYVlU0gW9wv5kMOzs/uhQAuCqiS/X0B8cTvQjhqcGOfN81sou46hUOs?=
 =?iso-8859-2?Q?zIpPYmErnxS7rp9XXlu/GZFIGdUEYLDGGKwj6YjwnRoGTSOixub6XCHgZZ?=
 =?iso-8859-2?Q?o4KPH9Fp0U3buAB9GYJXhzN7MP5L0b0HG/6mF/qbyb88s4DQM/CI3GnP3T?=
 =?iso-8859-2?Q?gUWeBDfHIuix5e479Ycn/VxqOscF?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923C35FB2253C8C2A21927C9248ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca0ec4b-a495-490e-2132-08ddbf9aa702
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 10:15:10.3695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zsxdf63yfUd88XCKK4jRABiFnj/q6DvzM9LHy2XZxFjmE4m2HCTEa0btrapXfo1Re5CwQPYBbtkUmbvMn3UkKhgXiY/+vWuNMgoDIam+v54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR83MB0564
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923C35FB2253C8C2A21927C9248ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending the same patch with more detailed commit message added.=0A=
=0A=
Radek=0A=
---=0A=
From e5507371498bc1dca7234ac25b45beb4b0f89f38 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 21 Jun 2025 22:56:58 +0200=0A=
Subject: [PATCH v2] Cygwin: cygserver: add possibility to skip cygserver bu=
ild=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch adds configure option allowing to disable build of cygserver. Th=
is=0A=
is useful when one needs to build only cygwin1.dll with stage1 compiler tha=
t is=0A=
not yet capable of linking executables as it's missing cygwin1.dll and crt0=
.o.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/Makefile.am           | 12 ++++++++++--=0A=
 winsup/configure.ac          |  7 +++++++=0A=
 winsup/cygserver/Makefile.am |  2 ++=0A=
 3 files changed, 19 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/winsup/Makefile.am b/winsup/Makefile.am=0A=
index 9efdd4cb1..a8a82d4c8 100644=0A=
--- a/winsup/Makefile.am=0A=
+++ b/winsup/Makefile.am=0A=
@@ -14,10 +14,18 @@ cygdoc_DATA =3D \=0A=
 	CYGWIN_LICENSE \=0A=
 	COPYING=0A=
 =0A=
-SUBDIRS =3D cygwin cygserver utils testsuite=0A=
+SUBDIRS =3D cygwin utils testsuite=0A=
+=0A=
+if BUILD_CYGSERVER=0A=
+SUBDIRS +=3D cygserver=0A=
+endif=0A=
 =0A=
 if BUILD_DOC=0A=
 SUBDIRS +=3D doc=0A=
 endif=0A=
 =0A=
-cygserver utils testsuite: cygwin=0A=
+utils testsuite: cygwin=0A=
+=0A=
+if BUILD_CYGSERVER=0A=
+cygserver: cygwin=0A=
+endif=0A=
diff --git a/winsup/configure.ac b/winsup/configure.ac=0A=
index 18adf3d97..607f94710 100644=0A=
--- a/winsup/configure.ac=0A=
+++ b/winsup/configure.ac=0A=
@@ -83,6 +83,13 @@ AC_ARG_ENABLE(doc,=0A=
 	      enable_doc=3Dyes)=0A=
 AM_CONDITIONAL(BUILD_DOC, [test $enable_doc !=3D "no"])=0A=
 =0A=
+# Disabling build of cygserver is needed for zero-bootstrap build of stage=
 1=0A=
+# Cygwin toolchain where the linker is not able to produce executables yet=
.=0A=
+AC_ARG_ENABLE(cygserver,=0A=
+	      [AS_HELP_STRING([--disable-cygserver], [do not build cygserver])],,=
=0A=
+	      enable_cygserver=3Dyes)=0A=
+AM_CONDITIONAL(BUILD_CYGSERVER, [test $enable_cygserver !=3D "no"])=0A=
+=0A=
 AC_CHECK_PROGS([DOCBOOK2XTEXI], [docbook2x-texi db2x_docbook2texi])=0A=
 if test -z "$DOCBOOK2XTEXI" ; then=0A=
     if test "x$enable_doc" !=3D "xno"; then=0A=
diff --git a/winsup/cygserver/Makefile.am b/winsup/cygserver/Makefile.am=0A=
index ec7a62240..efb578e53 100644=0A=
--- a/winsup/cygserver/Makefile.am=0A=
+++ b/winsup/cygserver/Makefile.am=0A=
@@ -12,7 +12,9 @@ cygserver_flags=3D$(cxxflags_common) -Wimplicit-fallthrou=
gh=3D5 -Werror -DSYSCONFDIR=0A=
 AM_CXXFLAGS =3D $(CFLAGS)=0A=
 =0A=
 noinst_LIBRARIES =3D libcygserver.a=0A=
+if BUILD_CYGSERVER=0A=
 sbin_PROGRAMS =3D cygserver=0A=
+endif=0A=
 bin_SCRIPTS =3D cygserver-config=0A=
 =0A=
 cygserver_SOURCES =3D \=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB0923C35FB2253C8C2A21927C9248ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-cygserver-add-possibility-to-skip-cygserver-build.patch"
Content-Description:
 v2-0001-Cygwin-cygserver-add-possibility-to-skip-cygserver-build.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-cygserver-add-possibility-to-skip-cygserver-build.patch";
	size=2542; creation-date="Thu, 10 Jul 2025 10:15:02 GMT";
	modification-date="Thu, 10 Jul 2025 10:15:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlNTUwNzM3MTQ5OGJjMWRjYTcyMzRhYzI1YjQ1YmViNGIwZjg5ZjM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAyMSBKdW4gMjAyNSAyMjo1Njo1OCAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIEN5Z3dpbjogY3lnc2VydmVyOiBhZGQgcG9zc2liaWxp
dHkgdG8gc2tpcCBjeWdzZXJ2ZXIgYnVpbGQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBl
OiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhi
aXQKClRoaXMgcGF0Y2ggYWRkcyBjb25maWd1cmUgb3B0aW9uIGFsbG93aW5nIHRvIGRpc2FibGUg
YnVpbGQgb2YgY3lnc2VydmVyLiBUaGlzCmlzIHVzZWZ1bCB3aGVuIG9uZSBuZWVkcyB0byBidWls
ZCBvbmx5IGN5Z3dpbjEuZGxsIHdpdGggc3RhZ2UxIGNvbXBpbGVyIHRoYXQgaXMKbm90IHlldCBj
YXBhYmxlIG9mIGxpbmtpbmcgZXhlY3V0YWJsZXMgYXMgaXQncyBtaXNzaW5nIGN5Z3dpbjEuZGxs
IGFuZCBjcnQwLm8uCgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25A
bWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5zdXAvTWFrZWZpbGUuYW0gICAgICAgICAgIHwgMTIgKysr
KysrKysrKy0tCiB3aW5zdXAvY29uZmlndXJlLmFjICAgICAgICAgIHwgIDcgKysrKysrKwogd2lu
c3VwL2N5Z3NlcnZlci9NYWtlZmlsZS5hbSB8ICAyICsrCiAzIGZpbGVzIGNoYW5nZWQsIDE5IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL01ha2VmaWxl
LmFtIGIvd2luc3VwL01ha2VmaWxlLmFtCmluZGV4IDllZmRkNGNiMS4uYThhODJkNGM4IDEwMDY0
NAotLS0gYS93aW5zdXAvTWFrZWZpbGUuYW0KKysrIGIvd2luc3VwL01ha2VmaWxlLmFtCkBAIC0x
NCwxMCArMTQsMTggQEAgY3lnZG9jX0RBVEEgPSBcCiAJQ1lHV0lOX0xJQ0VOU0UgXAogCUNPUFlJ
TkcKIAotU1VCRElSUyA9IGN5Z3dpbiBjeWdzZXJ2ZXIgdXRpbHMgdGVzdHN1aXRlCitTVUJESVJT
ID0gY3lnd2luIHV0aWxzIHRlc3RzdWl0ZQorCitpZiBCVUlMRF9DWUdTRVJWRVIKK1NVQkRJUlMg
Kz0gY3lnc2VydmVyCitlbmRpZgogCiBpZiBCVUlMRF9ET0MKIFNVQkRJUlMgKz0gZG9jCiBlbmRp
ZgogCi1jeWdzZXJ2ZXIgdXRpbHMgdGVzdHN1aXRlOiBjeWd3aW4KK3V0aWxzIHRlc3RzdWl0ZTog
Y3lnd2luCisKK2lmIEJVSUxEX0NZR1NFUlZFUgorY3lnc2VydmVyOiBjeWd3aW4KK2VuZGlmCmRp
ZmYgLS1naXQgYS93aW5zdXAvY29uZmlndXJlLmFjIGIvd2luc3VwL2NvbmZpZ3VyZS5hYwppbmRl
eCAxOGFkZjNkOTcuLjYwN2Y5NDcxMCAxMDA2NDQKLS0tIGEvd2luc3VwL2NvbmZpZ3VyZS5hYwor
KysgYi93aW5zdXAvY29uZmlndXJlLmFjCkBAIC04Myw2ICs4MywxMyBAQCBBQ19BUkdfRU5BQkxF
KGRvYywKIAkgICAgICBlbmFibGVfZG9jPXllcykKIEFNX0NPTkRJVElPTkFMKEJVSUxEX0RPQywg
W3Rlc3QgJGVuYWJsZV9kb2MgIT0gIm5vIl0pCiAKKyMgRGlzYWJsaW5nIGJ1aWxkIG9mIGN5Z3Nl
cnZlciBpcyBuZWVkZWQgZm9yIHplcm8tYm9vdHN0cmFwIGJ1aWxkIG9mIHN0YWdlIDEKKyMgQ3ln
d2luIHRvb2xjaGFpbiB3aGVyZSB0aGUgbGlua2VyIGlzIG5vdCBhYmxlIHRvIHByb2R1Y2UgZXhl
Y3V0YWJsZXMgeWV0LgorQUNfQVJHX0VOQUJMRShjeWdzZXJ2ZXIsCisJICAgICAgW0FTX0hFTFBf
U1RSSU5HKFstLWRpc2FibGUtY3lnc2VydmVyXSwgW2RvIG5vdCBidWlsZCBjeWdzZXJ2ZXJdKV0s
LAorCSAgICAgIGVuYWJsZV9jeWdzZXJ2ZXI9eWVzKQorQU1fQ09ORElUSU9OQUwoQlVJTERfQ1lH
U0VSVkVSLCBbdGVzdCAkZW5hYmxlX2N5Z3NlcnZlciAhPSAibm8iXSkKKwogQUNfQ0hFQ0tfUFJP
R1MoW0RPQ0JPT0syWFRFWEldLCBbZG9jYm9vazJ4LXRleGkgZGIyeF9kb2Nib29rMnRleGldKQog
aWYgdGVzdCAteiAiJERPQ0JPT0syWFRFWEkiIDsgdGhlbgogICAgIGlmIHRlc3QgIngkZW5hYmxl
X2RvYyIgIT0gInhubyI7IHRoZW4KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWdzZXJ2ZXIvTWFrZWZp
bGUuYW0gYi93aW5zdXAvY3lnc2VydmVyL01ha2VmaWxlLmFtCmluZGV4IGVjN2E2MjI0MC4uZWZi
NTc4ZTUzIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnc2VydmVyL01ha2VmaWxlLmFtCisrKyBiL3dp
bnN1cC9jeWdzZXJ2ZXIvTWFrZWZpbGUuYW0KQEAgLTEyLDcgKzEyLDkgQEAgY3lnc2VydmVyX2Zs
YWdzPSQoY3h4ZmxhZ3NfY29tbW9uKSAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTUgLVdlcnJvciAt
RFNZU0NPTkZESVIKIEFNX0NYWEZMQUdTID0gJChDRkxBR1MpCiAKIG5vaW5zdF9MSUJSQVJJRVMg
PSBsaWJjeWdzZXJ2ZXIuYQoraWYgQlVJTERfQ1lHU0VSVkVSCiBzYmluX1BST0dSQU1TID0gY3ln
c2VydmVyCitlbmRpZgogYmluX1NDUklQVFMgPSBjeWdzZXJ2ZXItY29uZmlnCiAKIGN5Z3NlcnZl
cl9TT1VSQ0VTID0gXAotLSAKMi41MC4xLnZmcy4wLjAKCg==

--_002_DB9PR83MB0923C35FB2253C8C2A21927C9248ADB9PR83MB0923EURP_--
