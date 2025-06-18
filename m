Return-Path: <SRS0=pByE=ZB=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20707.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::707])
	by sourceware.org (Postfix) with ESMTPS id D658C385695B
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 16:06:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D658C385695B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D658C385695B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::707
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750262805; cv=pass;
	b=MvtDAN1ZFqUG62jhUM3z0gCKg+TvprWErJz00zCmffJvH6K2N3pZPLQNGIfZPuBR34isuukOoY2KPtCtcwR/NQ+p/f10mbYlU97h+hz/yICo7I57V1Bzfo31U4vxh96IgrGBl4OUE7kAcKkj+1BY26MejdSaZAnHbLKaqzN1SaA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750262805; c=relaxed/simple;
	bh=J5vXFBgiSjXY8UUl7BOApHxp7PhAZOLrKxrMOyqS8QQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=tO1/qhuVuF9Ncq71aVJfUYfQFFksoL9Q2DoD8mWln7T745va4eKe1DedSrioqYR6HmuqdnTnazeizfFIH8Ew2NsGNwwZG9UhE0LW1k+T3wwMJnzQh/7L/zwX6cuOn6a4MpdbS7WCdsOolBPCrR/xq+TvdOOuGTDbRVmw/Wr61sM=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D658C385695B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=PXoTMDna
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI1vqL80jESod6oG/lo2Z13Ipqj6kHzXbnKnxiw4mhfb5BPBA9Wflz3F2c8nE2EtQbjvxgs4N0IHHq3+cu6S45q06uKSkMPDGJL6neQ36lQnpQEXNfiyDlVhxasECglw18XLp++20ihFAE2hLoSWOaMdzhtTDPAD6A68GkoelBkeLyN+s42MAl4/Nxjq17VMaoJv0UKBK/9A8a8H+ML09KbVR1/NwBSBqNdw/ABd3Fz2CtSzBAEe6clUCbr5qRLLL7BG+Y6917jZhL0fzRLwZGopfDHZ7cJcy5/lRp44m3FhJN8IZ4nLLpJumE8bLVSsp1A8wojH0yz4DODL2ak//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSQdtrguXUu+9V4cWPDSlwFB+T61JjMHpQmvgEFLYCY=;
 b=XIp13+BnJvBZs1DUiwIBaSm0T73jo4J8vGkll7x9rNvlhrc93LaO2uh1P8UqEu/bZoGpYQ303204IWhsfDVdBxayTxzEctFkmmLL2vSPUMW6axmUq3ooM0sgZrs85weAdHfWgjdRPqD16QnZq07TtSZrZSh6lvMuIatk7H0NRQt1ne1Kk4c8Q5Wpe9HTB1/fqvZXB2U+rZXasCO2410VQHC2M5cLpDI/n8iQekC9uiPUiwvvDQ0yXIGJ8bxJ/mv1ngiC6XGr6pkjOG1yjAWLZWbGLwVVPejgdx2wZLjUMZvZPdjiDsylS9WZC1r9xK/9htlnclgrlyjdHi5gXuaoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSQdtrguXUu+9V4cWPDSlwFB+T61JjMHpQmvgEFLYCY=;
 b=PXoTMDnanhQgxWS6B4SGT9rQxUei04F/MugfXlE0hb54WXBUhLwCH/y/16ead9nBo7WLIjhxOU3tKoMR19odB/2horgN+yHiO+vU/A8tFCW64t9qI237aYfvXlq0phoEAgHy+Ls/QimNQMfB6VV3TmoGbk4fal7Qn7l9BO6cVqk=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0730.EURPRD83.prod.outlook.com (2603:10a6:150:20e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.8; Wed, 18 Jun
 2025 16:06:40 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.006; Wed, 18 Jun 2025
 16:06:40 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: obtain stack base on AArch64
Thread-Topic: [PATCH] Cygwin: obtain stack base on AArch64
Thread-Index: AQHb4GqiI/EUmZ8PqE6CkhW5ziEveQ==
Date: Wed, 18 Jun 2025 16:06:40 +0000
Message-ID:
 <DB9PR83MB0923187D66011DE1CB903BF09272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-18T16:06:39.410Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0730:EE_
x-ms-office365-filtering-correlation-id: 750d97dc-5c23-4250-2ab6-08ddae821c8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?igBXVYE9/dfDKFQ9IOoUaX1jCj5uXTwguSLZTv6qIFxtdgiiGeXAHn536B?=
 =?iso-8859-2?Q?gudsEIVypbSf3MwdBWhAyvPgVgdlD358S/YFl0lMyaI2lXf+ydB7gynRkJ?=
 =?iso-8859-2?Q?7QQHH561aY6tj/FXqU6yz6SS5nNQg/ep5khKeWbVxi0icr+CqY8Rlki6v+?=
 =?iso-8859-2?Q?GORhoSEsxXczl9RIeEcbkNJhbJ4n+g7giIPdFsoJvkKTnjefoE2A9dsrMo?=
 =?iso-8859-2?Q?jNHZZ/M6vYIc6Y1E1SWIhjO7SIcbww2OBES3esJGNeChDpq8n82ZVZ+b3i?=
 =?iso-8859-2?Q?V4z+EmuokcKLA0Uw2nWg76n9Ah04mEkoo3bW9vwEmjVGj3oTaN7ESA2hzy?=
 =?iso-8859-2?Q?ngJbIUxGH+iiQ2VWi98N8lbA0jng98w6AO3avmaGhNm24OfT49AmCXiTwc?=
 =?iso-8859-2?Q?9egEvVTAcF8pWVrldagrJp3iee0V8XeRpMr6kSqPnGHYi1H1OmXGBO4DoF?=
 =?iso-8859-2?Q?gCGNugQzwiYy0Zr9nGqI+f5tfYSY8i+rameqW5jw41h5Q49n3PfUZvk+xa?=
 =?iso-8859-2?Q?azM2S5HOQW9+2anQEl8ZOZbmMgwmb3Yw3Sw4XUOsbU+5X/7fHL2elSyp86?=
 =?iso-8859-2?Q?dACAzfDu/qTnM4wb1jziK7wprG8SPnbasd35eej827iHWYon2hz2pK2pFC?=
 =?iso-8859-2?Q?qtKPjB3OaJQl+UwgofOFokGhvQXF0vVmb2rIlr/cWMaJmET4fqtRvy3ppV?=
 =?iso-8859-2?Q?1qlnYJB25KwLYoaxl0WsgQ86e0kGUTo2G42PWJk4Tf4QJR3d0whQLmczfH?=
 =?iso-8859-2?Q?/4S2n9we03TjZiWXpjOk+1etJ3Ok7VavZpUpkRaqq9e9jS+aA1MNBSTPYQ?=
 =?iso-8859-2?Q?0nRj5ICzuN7+vbHqfi82wSFVU9+29d1zwkEZaARcPs8nTJ2XQpogYBvl+H?=
 =?iso-8859-2?Q?a+VyByBKP2VOWrHNkLBC2MUWKC2JbgK9sRInRZtMEqVheIPTqKJ0HThuo3?=
 =?iso-8859-2?Q?SW/kp7N01g1p549yecPLOd/kBGEK0rLAgAsu6u7Uhj0g5mrOymf5Fo9/Mi?=
 =?iso-8859-2?Q?gIbql7v/ANzGpP132skjvg7nZ5vUS6vjq4ChQ9M8vCCIs54UstgAE16Vvi?=
 =?iso-8859-2?Q?kBODI7Jo6W2Hqa4VqtLgDSN8Up6OZp5d6iOHAxRjx+O9eRsMEmJlFQkCwF?=
 =?iso-8859-2?Q?31rNzGaHC+gbZyv+TBBZL5EoyhvnutMfaZszkYyXuMk0DtP1o99tcnDipy?=
 =?iso-8859-2?Q?roBuNOdxU9v7jXO8rt06Kzm1lOR9kZ4YqntdloPeHwcO726LI+2cdCZmSM?=
 =?iso-8859-2?Q?PRL73CPu8MabnpPvYpM17WN5mZD225lgIIK+XLPHszjOJTvOmvTLZxN0CW?=
 =?iso-8859-2?Q?vY25yp4F+0QCUBfSgyREUeFoauxm41lwhpHn6V7y+6x8ne+rFte/pmInya?=
 =?iso-8859-2?Q?0PWvKz+HKSiwHuR0SuNgSdvuDkFwaCp5DLv+rchju46SwHLI70/lA9kfDA?=
 =?iso-8859-2?Q?sUmojfoMYaYLLQCQySeJQ13U4D5gfT0afVutVORxKxwOUPp6QeIiP85loR?=
 =?iso-8859-2?Q?dr4Vo+NY5zAzx9RQwT9uE1R7AktwHfPlBVAbn+FK59ytCs0HmSwOQWemAH?=
 =?iso-8859-2?Q?FAGKoH4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?oXzLMCJM1fcNSUBFumqLoByuRtcRCuOp08cGr6EM3b9zjgZ+KinDMWaLHq?=
 =?iso-8859-2?Q?nhoBKer0w8AduiPzw+q3XxunnruxN0gdF8jcjc8E08HCEjz24Mg5kRQxRy?=
 =?iso-8859-2?Q?vMLacaXbLhmdV9J5/wzCTmaEodBOGR8vm5AJkvHoFyyQHKeyujrAKFMR1g?=
 =?iso-8859-2?Q?kBTupfu8oQc1Qg7RiMgThKODilWtFyEPA1tfe2l3OUO7RxImFGMG86Af6K?=
 =?iso-8859-2?Q?OHJNnt3ktZEZO4Lq1nnClYGcKEmnz7kGbf4Tpjn8VzWkO6j2STu5qCG3hU?=
 =?iso-8859-2?Q?jwWOJNZbHU9woJlmWbjv/kp+W/6QXd+Sw8GhQOeh3/olbRP3JngKLufNmh?=
 =?iso-8859-2?Q?2TTKr1XapFqX6CQAsKRfYHOjnOq6ErXyc3XQbPdawVak/19qsFuTqfM7s7?=
 =?iso-8859-2?Q?6zlBpLpDnQVvItQ4twmYMZs/46HQDEb3sDcLKoeQKFN4k+gl9Sp7QdgjtS?=
 =?iso-8859-2?Q?3NzD648j0n9QrCH9xcf8xsLyBtNw8jV8mj/QUkacwtsqQ5g0PWcj/Wkaex?=
 =?iso-8859-2?Q?pq650L/CcfcQFURAXsqsb3lHB/ajV4LotIvxIR50vZDjS2C+l7/DR8PPvt?=
 =?iso-8859-2?Q?Kxa+Q4qesStK3I95ymmTh/qLk7MubwTt2AARW7EcOA9HBwVgU6wP1lnx4d?=
 =?iso-8859-2?Q?2wmu2wVTV1gdsitmqJkLVzBUXIBvqkADOEQfeoQM35t0U8yaN61GKE+ORN?=
 =?iso-8859-2?Q?exN2iKv+mPtgFBn5g97ZPua8ZZh31PCxdhMtOq1fdwGKnksmZYYSsHS415?=
 =?iso-8859-2?Q?kmssPmAX+tUwpBldbbzcpBeJ2V1RQLLdowYr3KI9vumnRIvHHak/GkxK20?=
 =?iso-8859-2?Q?LOtQyyl3fgfDlJw49/XZW0U2UEO6CgCYS6mDqh3rV6MpxEwfI13Umgx+7I?=
 =?iso-8859-2?Q?Vgdy5T8lAXv3NNHOTUqUvduV9BqO6D33gd+2MSYX7VNyPlSflwZZ96nG06?=
 =?iso-8859-2?Q?kRRd7nwFUefUJ45AcBCSPQRbTji7lgpCZn+nw5SGqeDfg4k0lQQ4Uc1yIL?=
 =?iso-8859-2?Q?4YRWYK2Q79WBC3WUwZm/lDRagqzLm0jBJfEPUWc8gGGzncYEWWydjmBRbS?=
 =?iso-8859-2?Q?Km/M0DDXmW12VRWylNhg30oxv705yc7l0wKkwwg7/vdniuAz470OReX041?=
 =?iso-8859-2?Q?GD/DOpk9asqtC89/nYZ0bnFpUokhuSeSwYaNVevvznI8Zww6yeiNBzNN18?=
 =?iso-8859-2?Q?su1MoU1hrKAqaiUzO6Miizw2MlPeLybC1Yth2UbshHesdds38e8urTxaJW?=
 =?iso-8859-2?Q?lJUHN3i27AyHG+Ar0YSRFeJhi/ErbAieg1Sxywe+16E8JKsQRtoSnlDBLu?=
 =?iso-8859-2?Q?LocPxzr8pf3I8tp2Lv61F4hjjzQJGlq4yTZm91RXxd7dGbT8wk2DXvIek/?=
 =?iso-8859-2?Q?L5LC9JghR3EObyPIGK7UkjwtbTZkTEEikHQ+9AgnK+kz/Qx6ryf8y9hN9V?=
 =?iso-8859-2?Q?jcJYkAFT+xDIj8/cBaM/nVstynCbwZrZkeDUpbgIiGWq4DPVp51QWmPLWM?=
 =?iso-8859-2?Q?tCLioTsKUaumhIEqDLIFIavPIDaZEWnHJbtDrzT+miK/Lz0E2BwTAen/BR?=
 =?iso-8859-2?Q?HGil1vu2/nK7ICIhGNYxfEwYpVbh?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923187D66011DE1CB903BF09272ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750d97dc-5c23-4250-2ab6-08ddae821c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:06:40.3967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8KB+eaew7JiwfVV4gVaxbjo5qw5qbD3nT2rqXqay0ODwv8hEuc59RU36fsN4WXtWeZoKyGJwkaiWe0uh7FeQ+L2TwRtsGNbLQ0ZYlYYN7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0730
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923187D66011DE1CB903BF09272ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch ports reading of stack base from TEB on AArch64 at cygload.cc an=
d __getreent.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 08f9be50573a085fd3e5cb840455ea5fc3b1e82a Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Wed, 4 Jun 2025 13:38:10 +0200=0A=
Subject: [PATCH] Cygwin: obtain stack base on AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/include/cygwin/config.h  | 7 ++++++-=0A=
 winsup/testsuite/winsup.api/cygload.cc | 7 +++++++=0A=
 2 files changed, 13 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/include/cygwin/config.h b/winsup/cygwin/include/=
cygwin/config.h=0A=
index 2a7083278..d9f911d47 100644=0A=
--- a/winsup/cygwin/include/cygwin/config.h=0A=
+++ b/winsup/cygwin/include/cygwin/config.h=0A=
@@ -36,8 +36,13 @@ __attribute__((__gnu_inline__))=0A=
 extern inline struct _reent *__getreent (void)=0A=
 {=0A=
   register char *ret;=0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
   __asm __volatile__ ("movq %%gs:8,%0" : "=3Dr" (ret));=0A=
+#elif defined(__aarch64__)=0A=
+  /* x18 register points to TEB, offset 0x8 points to stack base.=0A=
+     See _TEB structure definition in winsup\cygwin\local_includes\ntdll.h=
=0A=
+     for more details. */=0A=
+  __asm __volatile__ ("ldr %0, [x18, #0x8]" : "=3Dr" (ret));=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
diff --git a/winsup/testsuite/winsup.api/cygload.cc b/winsup/testsuite/wins=
up.api/cygload.cc=0A=
index afd3ee90f..08372a302 100644=0A=
--- a/winsup/testsuite/winsup.api/cygload.cc=0A=
+++ b/winsup/testsuite/winsup.api/cygload.cc=0A=
@@ -82,6 +82,13 @@ cygwin::padding::padding ()=0A=
     "movl %%fs:4, %0"=0A=
     :"=3Dr"(stackbase)=0A=
     );=0A=
+# elif __aarch64__=0A=
+  // x18 register points to TEB. See _TEB structure definition in=0A=
+  // winsup\cygwin\local_includes\ntdll.h=0A=
+  __asm__ volatile (=0A=
+    "ldr %0, [x18, #0x8]"=0A=
+   :"=3Dr" (stackbase)=0A=
+   );=0A=
 # else=0A=
 #  error Unknown architecture=0A=
 # endif=0A=
-- =0A=
2.49.0.vfs.0.4=0A=

--_002_DB9PR83MB0923187D66011DE1CB903BF09272ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-obtain-stack-base-on-AArch64.patch"
Content-Description: 0001-Cygwin-obtain-stack-base-on-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-obtain-stack-base-on-AArch64.patch"; size=1878;
	creation-date="Wed, 18 Jun 2025 16:04:31 GMT";
	modification-date="Wed, 18 Jun 2025 16:04:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwOGY5YmU1MDU3M2EwODVmZDNlNWNiODQwNDU1ZWE1ZmMzYjFlODJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogV2VkLCA0IEp1biAyMDI1IDEzOjM4OjEwICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBvYnRhaW4gc3RhY2sgYmFzZSBvbiBBQXJjaDY0
Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYt
OApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBC
YXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL2lu
Y2x1ZGUvY3lnd2luL2NvbmZpZy5oICB8IDcgKysrKysrLQogd2luc3VwL3Rlc3RzdWl0ZS93aW5z
dXAuYXBpL2N5Z2xvYWQuY2MgfCA3ICsrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vaW5jbHVk
ZS9jeWd3aW4vY29uZmlnLmggYi93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL2NvbmZpZy5o
CmluZGV4IDJhNzA4MzI3OC4uZDlmOTExZDQ3IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2lu
Y2x1ZGUvY3lnd2luL2NvbmZpZy5oCisrKyBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4v
Y29uZmlnLmgKQEAgLTM2LDggKzM2LDEzIEBAIF9fYXR0cmlidXRlX18oKF9fZ251X2lubGluZV9f
KSkKIGV4dGVybiBpbmxpbmUgc3RydWN0IF9yZWVudCAqX19nZXRyZWVudCAodm9pZCkKIHsKICAg
cmVnaXN0ZXIgY2hhciAqcmV0OwotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2
XzY0X18pCiAgIF9fYXNtIF9fdm9sYXRpbGVfXyAoIm1vdnEgJSVnczo4LCUwIiA6ICI9ciIgKHJl
dCkpOworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyAgLyogeDE4IHJlZ2lzdGVyIHBvaW50
cyB0byBURUIsIG9mZnNldCAweDggcG9pbnRzIHRvIHN0YWNrIGJhc2UuCisgICAgIFNlZSBfVEVC
IHN0cnVjdHVyZSBkZWZpbml0aW9uIGluIHdpbnN1cFxjeWd3aW5cbG9jYWxfaW5jbHVkZXNcbnRk
bGwuaAorICAgICBmb3IgbW9yZSBkZXRhaWxzLiAqLworICBfX2FzbSBfX3ZvbGF0aWxlX18gKCJs
ZHIgJTAsIFt4MTgsICMweDhdIiA6ICI9ciIgKHJldCkpOwogI2Vsc2UKICNlcnJvciB1bmltcGxl
bWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCmRpZmYgLS1naXQgYS93aW5zdXAvdGVzdHN1
aXRlL3dpbnN1cC5hcGkvY3lnbG9hZC5jYyBiL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9j
eWdsb2FkLmNjCmluZGV4IGFmZDNlZTkwZi4uMDgzNzJhMzAyIDEwMDY0NAotLS0gYS93aW5zdXAv
dGVzdHN1aXRlL3dpbnN1cC5hcGkvY3lnbG9hZC5jYworKysgYi93aW5zdXAvdGVzdHN1aXRlL3dp
bnN1cC5hcGkvY3lnbG9hZC5jYwpAQCAtODIsNiArODIsMTMgQEAgY3lnd2luOjpwYWRkaW5nOjpw
YWRkaW5nICgpCiAgICAgIm1vdmwgJSVmczo0LCAlMCIKICAgICA6Ij1yIihzdGFja2Jhc2UpCiAg
ICAgKTsKKyMgZWxpZiBfX2FhcmNoNjRfXworICAvLyB4MTggcmVnaXN0ZXIgcG9pbnRzIHRvIFRF
Qi4gU2VlIF9URUIgc3RydWN0dXJlIGRlZmluaXRpb24gaW4KKyAgLy8gd2luc3VwXGN5Z3dpblxs
b2NhbF9pbmNsdWRlc1xudGRsbC5oCisgIF9fYXNtX18gdm9sYXRpbGUgKAorICAgICJsZHIgJTAs
IFt4MTgsICMweDhdIgorICAgOiI9ciIgKHN0YWNrYmFzZSkKKyAgICk7CiAjIGVsc2UKICMgIGVy
cm9yIFVua25vd24gYXJjaGl0ZWN0dXJlCiAjIGVuZGlmCi0tIAoyLjQ5LjAudmZzLjAuNAoK

--_002_DB9PR83MB0923187D66011DE1CB903BF09272ADB9PR83MB0923EURP_--
