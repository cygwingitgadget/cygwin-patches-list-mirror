Return-Path: <SRS0=s6lY=ZR=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20730.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::730])
	by sourceware.org (Postfix) with ESMTPS id 6428C385140C
	for <cygwin-patches@cygwin.com>; Fri,  4 Jul 2025 08:37:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6428C385140C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6428C385140C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::730
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751618231; cv=pass;
	b=dKDqMaonJ9moLgVNRHwOhTYV1B/4rtRBXuB8PIQ86zwib7Uzdgk/SWNen64qLj0ge/hgpJ7rPvHC0ZHxCESDB5NEq87EJPgar9Hc3SBBD31H5juB0kRFrT3IIpvda+33AkmskYwV4N2dI+58NxaptTvFcIRWwuc8VUc5neWjPAY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751618231; c=relaxed/simple;
	bh=uL7YKhcnt5s6lGPsJb+bM4rlKKtE8uGS+4LUiaTGNYI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=SEPDoyhsFpZi1x1DmpPjW1FUYDrfR4KBD4ydAalqC96dsre5we58ON6W43xuQC8aZuAnp8xFB3uFAwzZ8qs7Th4Yy5SfYgYNW36QC8eUrLwcg8MuQAcrZPcEIH7d0e+HPCzE1wQ1SQwhNX3/rhZKXjN+7zszOaT6JlfnNzIAFME=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6428C385140C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=Rq/T7tuD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRPLyYZ++8WHlR9aYONo3mN6ITXTo7MGa9VVrKhW1afbdnilKZr/IQ2C78BMJmK0mawpnOX7A5EjNJ8w4xpJJdU9tCnx3QGL8eeJ+MievvVEo8ALE6Zj9QQ/9BYX1tV93PinW/dMj+JlLTN4HCMmKCx8mHC0uOC6ueuoFiMc23ywC3fV3K1VOhatPyHdBqO4ApEmSrnmZRiGbcGh++UDBsrUIlfzXI+rNxqe+unThbwivqopifV4dGXy4EMjxNLZTNfivWxGQLv094zmxcNf41lCgKAJZiXFUaQQe/dxY8IuEdCiU68fZS90jzkfSr3r4GT3RHjCdjy3lQvaR5f+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HabLkwrFPNwnlORkiJGt5bju/Q7NoVfBvC8R8H6IM8M=;
 b=x0own5Od93+sHRMReBNJYgFPk3eDP8fnPEqpnf41O0pCtn7G0n2T16zbP/7yDyLie8sznDLxBuKuQ8LlBBr+qy6ibTKGj5Qr9369CXuCcxe3v5VR0RlH4tiSVJaUWBL4OAVFGv/PocPhixslduopNbkUoofOlk7cJrl0X5Ffg5HUs6DxtoGWH4Q0G2MSmSYsEkRBSVe3EcISFq6fOU/QPK6Fm+WiWTq8SDyCGOKRTr5dV+hgxLE0XjcVpKqM7v4BoXhyF24O/94YeKqOK2tw/c1xJyCzxVr+/en7xhFItTwzKtdZmQsnnefgkAeRvt40V+x7BRTr9+LuhXwObqJ6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HabLkwrFPNwnlORkiJGt5bju/Q7NoVfBvC8R8H6IM8M=;
 b=Rq/T7tuDeP/8Y4OtyYWjBeSRp5ZGh4+Redvl4vBd1YGrLfD5nHTlhiOlUQLp+DQ+hr0Ez63ZOA0W5MSNe0tsS7cYBg0uWoqI4EzSD13k7VjHH8BOC57mwZGqRvv+Cq8vwfgZWUIXd/wfNyTflQRI2wOpKUb+FsQnWaAb+UHrz6c=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0801.EURPRD83.prod.outlook.com (2603:10a6:150:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.6; Fri, 4 Jul
 2025 08:37:06 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Fri, 4 Jul 2025
 08:37:06 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: cygserver: add possibility to skip cygserver build
Thread-Topic: [PATCH] Cygwin: cygserver: add possibility to skip cygserver
 build
Thread-Index: AQHb7L5s7tzsF2RtdU6JLHVvq3WuQg==
Date: Fri, 4 Jul 2025 08:37:06 +0000
Message-ID:
 <DB9PR83MB09232A0A1E4EC3D43BBAFA089242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-04T08:37:05.952Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0801:EE_
x-ms-office365-filtering-correlation-id: a91195a5-79a3-4302-c839-08ddbad5f577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?HKCap+it/lZHTPHSVcQh2QeD7I+FRlteU+3R2wWRIXRIiT47NkNH5NH1UC?=
 =?iso-8859-2?Q?dArM5s5dM2Ci6bgQvYbsCH3hQeYu9dV21J9WUhWtJa+JvSlqmeKVzHgzd+?=
 =?iso-8859-2?Q?9ckA8P6555ldkZg+XfmMmjggx81Mbx+h+jplyb8P9XLKEFxlYCUSx1gJtI?=
 =?iso-8859-2?Q?TzybffDoV0X0xzeRgZEM9b9sj6udwk7DKicILlVEgn1F1KKVVhrcdBd72y?=
 =?iso-8859-2?Q?KzkH9cgdL8TgTktL1eHMd/LWRzQD3G3gcpoq+ENOB5k0dhttyZAx/20oXj?=
 =?iso-8859-2?Q?vXQM0Edg6+88U/7Q3gST5uJkuOTlYD+vMtczJK6f7PmLh2r/0Z74YoH9Qg?=
 =?iso-8859-2?Q?WdXFmOSt/mOkkOZuc/JtS1OJWfJLZhXst08QHQMzORptyaWgVQMES7dDD1?=
 =?iso-8859-2?Q?LUOH6IY8KoR5fyfTNUELBZIRAaqElNFRg+X8J2HkTqYztTFr594iHB5Bbd?=
 =?iso-8859-2?Q?KUDJCd2ln5W34ZPZJJXOu2sc8uO9SfyuHmFqQfeASsMTQuQwrCX9uLYeTp?=
 =?iso-8859-2?Q?gHPoWJrLyGIgU4+6jbqqRAWk3sIgE17CiOGuCfJKDWchjiuz3Far7sRaoM?=
 =?iso-8859-2?Q?j32+7GpFUVTlowcX8ZpSpA48mrDE44NiVGmo7mpkSEYy6nkr3ettIenlQG?=
 =?iso-8859-2?Q?/vZeUSif8G3aFgykarRd/Iy7J4mRfNfgk6XV2mr3MxStJNf522svkoz+ZM?=
 =?iso-8859-2?Q?3Ar5ZroMj40IgpkmZaU0x4+B1Kc4MhFlusZdQoh4Xz7sQRuJiZg4/I7YkX?=
 =?iso-8859-2?Q?6k8fOnQBQtqSQvCIMTYbfgk9gIE0B/EWW9qEtxIhGGfCgwJ+ozpTnW28Ak?=
 =?iso-8859-2?Q?KDZmQqGW32F3jgq6cfCnPvBcglgcyx0vTJ6aZ+zcZn4uUCjMX/HAFeNgsm?=
 =?iso-8859-2?Q?uoA/GXCyjFBl5PVq9ciAHISIiqZh3FjQDQiWgkcMr7IZ7waOqfA49Rjlh+?=
 =?iso-8859-2?Q?fJK3mzqpANo385p3bbc17kE9KwcqMq0HDN5zMBw0SQNCPoJAVMaOsuqs4J?=
 =?iso-8859-2?Q?DgpwEIoNYbq+HQ0xW5vn4GRjDQ0q3SS1lZkJxn4OF6yAZAlOLSWUwQkpf+?=
 =?iso-8859-2?Q?N5+rnIB51Ojpemn5/qqzpemROUVE+J6AY0QuaRn3sC7/wQHB8kRWHvbQT3?=
 =?iso-8859-2?Q?b4WRqif0BQbf7e9faArcTLKvSlNVWtLq5vn2VBVClZJ9BPkRSZxKjzWpl3?=
 =?iso-8859-2?Q?Z6XH8kMlBjj08y2hD6fDySJWcfIa3r8iwnTs5Vi26Q230s1EdofpuT7004?=
 =?iso-8859-2?Q?kw6K9NmmAKFH81y3P8SrmuyNADD6dAYe7NETQnQ1axIzA7t7BpPzaiyQlS?=
 =?iso-8859-2?Q?sBjPHoOd0TY891N7wm8z3Uhh3fmu+YDFZiQOwnyHn+KRyDFCV36jCR2e88?=
 =?iso-8859-2?Q?/C5OVAi0i/HX11bqmn5TJ6Nbw/BivkhCAhhY4TcXKhoEMmlWrHvdaI9Kcg?=
 =?iso-8859-2?Q?KkrmJD7Mt+VcW56CfesFM+USXg9r2FhSs9dxBkWOYRM7lEO+XECI8P9r3Y?=
 =?iso-8859-2?Q?lc/7aUK6/fJpT3LG4FvMLFn6QWpAuIjYu0T9+dMxXWnbt0caVNyPv9+3B/?=
 =?iso-8859-2?Q?k04tbVE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?PELHozn7e4LbGdj0JSTtbioVj0uQME6ZlPYsO3cTbgnnOeHb/bW90tf3L1?=
 =?iso-8859-2?Q?4mZzQJvpr0AnC4VMUHVUI8JAcHZRGwQG0elmqcZexiiZmcxpqhWR/u9bPQ?=
 =?iso-8859-2?Q?BKUGGC38lIeTb7b4hwAxmO5deSqbHL9KzvBVZObcY9/q/DzXVw+y88rfoz?=
 =?iso-8859-2?Q?fjVggA+/MPcwbW1pOQS1wvbY9OaNSiyl9qdTDpJm9GcenHdH/8dXrUs0oL?=
 =?iso-8859-2?Q?c5a590goA+V7sy4mtnmc+k35fELaos5BV1LY1TCLGQE+cMX18KNZgBmLEv?=
 =?iso-8859-2?Q?GqUfElMz3Gmf09WwcPiMUzd63FLmcAJqSqXrgKWSlbnGYwDM+D+FxaXL4J?=
 =?iso-8859-2?Q?avTN88HDT3p3IOvR7tAiFpRbWAy5n1DqrJge7I6V501wdVmwWpWPRJs9uE?=
 =?iso-8859-2?Q?/U4F+HxtRFv/CLHDd5baInPlD5HLsrAba7YsMBkp/0JwpgY+w3H4LFcZv/?=
 =?iso-8859-2?Q?xxdFmM+WsATZK3AN5Xrh/wfWmvn46UEkbr52qAPBqQt5ShlQNsRkc6qqrX?=
 =?iso-8859-2?Q?aV5HQwjiZIfzwuM0siKf0pVEwY4LkePDwWw2Szr9fQYxJGokruf4nlUls0?=
 =?iso-8859-2?Q?2VPpP+EVYXaxwmDQ0WyuV7m0WutgRqWtJWbN0Hm+Dc6xP1sWMlIAwgxve5?=
 =?iso-8859-2?Q?l38gRx/JoFwQrlytyRt40J1wd/fq2uypKsqbcMj4aIomFNV6iEDoJjLmRC?=
 =?iso-8859-2?Q?mTYQQXtYQE3eoJWWAeAmrZ+SV+X189Bye2fk0rSDvnKMBnNuzdjud3StCJ?=
 =?iso-8859-2?Q?SDiVkEfvHwp2D7ou8n/hxnT/uSZyxVgsP7UokctQXVlGNrseqy26rajSpS?=
 =?iso-8859-2?Q?xiBtbKbQgUBdv52F5mFG4i/zUOIv0/FbIN3hTdz3tLOcEjmfibIqDcRt2D?=
 =?iso-8859-2?Q?Px318u/0OdC1Ns/aooXCE0BY04e0EJksX5wF5leClGP2DJgBb92okWLgCg?=
 =?iso-8859-2?Q?9OHT+GXPrwQlpb7pEsh5EmfHUFeiSoWb+woqfblv9MvLBe+hnLMWscwCRV?=
 =?iso-8859-2?Q?6AL2sU2zk8I7/e0DZdVgF4JruKkiTqqYoz/aMAV2SXQaEQq/RZCBVlTzC8?=
 =?iso-8859-2?Q?9T/2dV8ee8WuS6PWG/iQKBcycktpnJZ1556aVwLfko7O0E/KBb4/t4TQdF?=
 =?iso-8859-2?Q?8r6N+sqcFJO5JLF4RaQ2olFdvvS7hh9SVAR+3wMK8CE0uU64w7oZ1uEEGA?=
 =?iso-8859-2?Q?S8iAN8L2cv/lSyZmWqlIpv1JTJQxA5CgssANs9qCI6RTuZ5olUYFxnRNlN?=
 =?iso-8859-2?Q?gE9wFY5dXmi0013cRrWOZ0T1f0OBqPlYao30zGcsb9s8h2lne7lQBay7x/?=
 =?iso-8859-2?Q?HoA+OUFV6Er6t2uO6MiF3d25asvXyvWCHKQ1CMR+bjZCTMPUaF7O0k382P?=
 =?iso-8859-2?Q?p3V7utzYFf7U3G6LAPt4Oj8VF3dYOW0UtTTUiKnNLctNhzwTpcY0a+jZ52?=
 =?iso-8859-2?Q?m2yDLlDQBrfKfA1TFU7fhO3yHBY6qODrrcz4mTWzVb5C0ditZSA/NNC2Cp?=
 =?iso-8859-2?Q?HQcjHTTi8CYXldCfkTfiHTD3/G6idBcvxoi383Ebm2iaYSL68a5nr1LIvK?=
 =?iso-8859-2?Q?Vx0n+ikqM97zVicwYkdtriCTeDpq?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09232A0A1E4EC3D43BBAFA089242ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91195a5-79a3-4302-c839-08ddbad5f577
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 08:37:06.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eciTX8GkvGECz6h4xvOmUoCy30WlAujgafM/R9tljonfNmSGyQAhutLco6UnE+zVdRFLDyh+Viav9r7js4YwnMLxP95XFOqjQzje9aYZ4y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0801
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09232A0A1E4EC3D43BBAFA089242ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch adds configure option allowing to disable build of `cygserver`. =
This is useful when one needs to build only `cygwin1.dll` with stage1 compi=
ler that is not yet capable of linking executables as it's missing `cygwin1=
.dl` and `crt0.o`.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From c0254ff2f6631a2775bfb74483b7813f0822fb0a Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 21 Jun 2025 22:56:58 +0200=0A=
Subject: [PATCH] Cygwin: cygserver: add possibility to skip cygserver build=
=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
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
index 13aa309b2..59b19486c 100644=0A=
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
2.49.0.vfs.0.4=0A=

--_002_DB9PR83MB09232A0A1E4EC3D43BBAFA089242ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-cygserver-add-possibility-to-skip-cygserver-build.patch"
Content-Description:
 0001-Cygwin-cygserver-add-possibility-to-skip-cygserver-build.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-cygserver-add-possibility-to-skip-cygserver-build.patch";
	size=2301; creation-date="Fri, 04 Jul 2025 08:36:58 GMT";
	modification-date="Fri, 04 Jul 2025 08:36:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjMDI1NGZmMmY2NjMxYTI3NzViZmI3NDQ4M2I3ODEzZjA4MjJmYjBhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAyMSBKdW4gMjAyNSAyMjo1Njo1OCAr
MDIwMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogY3lnc2VydmVyOiBhZGQgcG9zc2liaWxpdHkg
dG8gc2tpcCBjeWdzZXJ2ZXIgYnVpbGQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0
ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQK
ClNpZ25lZC1vZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29t
PgotLS0KIHdpbnN1cC9NYWtlZmlsZS5hbSAgICAgICAgICAgfCAxMiArKysrKysrKysrLS0KIHdp
bnN1cC9jb25maWd1cmUuYWMgICAgICAgICAgfCAgNyArKysrKysrCiB3aW5zdXAvY3lnc2VydmVy
L01ha2VmaWxlLmFtIHwgIDIgKysKIDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvTWFrZWZpbGUuYW0gYi93aW5zdXAv
TWFrZWZpbGUuYW0KaW5kZXggOWVmZGQ0Y2IxLi5hOGE4MmQ0YzggMTAwNjQ0Ci0tLSBhL3dpbnN1
cC9NYWtlZmlsZS5hbQorKysgYi93aW5zdXAvTWFrZWZpbGUuYW0KQEAgLTE0LDEwICsxNCwxOCBA
QCBjeWdkb2NfREFUQSA9IFwKIAlDWUdXSU5fTElDRU5TRSBcCiAJQ09QWUlORwogCi1TVUJESVJT
ID0gY3lnd2luIGN5Z3NlcnZlciB1dGlscyB0ZXN0c3VpdGUKK1NVQkRJUlMgPSBjeWd3aW4gdXRp
bHMgdGVzdHN1aXRlCisKK2lmIEJVSUxEX0NZR1NFUlZFUgorU1VCRElSUyArPSBjeWdzZXJ2ZXIK
K2VuZGlmCiAKIGlmIEJVSUxEX0RPQwogU1VCRElSUyArPSBkb2MKIGVuZGlmCiAKLWN5Z3NlcnZl
ciB1dGlscyB0ZXN0c3VpdGU6IGN5Z3dpbgordXRpbHMgdGVzdHN1aXRlOiBjeWd3aW4KKworaWYg
QlVJTERfQ1lHU0VSVkVSCitjeWdzZXJ2ZXI6IGN5Z3dpbgorZW5kaWYKZGlmZiAtLWdpdCBhL3dp
bnN1cC9jb25maWd1cmUuYWMgYi93aW5zdXAvY29uZmlndXJlLmFjCmluZGV4IDEzYWEzMDliMi4u
NTliMTk0ODZjIDEwMDY0NAotLS0gYS93aW5zdXAvY29uZmlndXJlLmFjCisrKyBiL3dpbnN1cC9j
b25maWd1cmUuYWMKQEAgLTgzLDYgKzgzLDEzIEBAIEFDX0FSR19FTkFCTEUoZG9jLAogCSAgICAg
IGVuYWJsZV9kb2M9eWVzKQogQU1fQ09ORElUSU9OQUwoQlVJTERfRE9DLCBbdGVzdCAkZW5hYmxl
X2RvYyAhPSAibm8iXSkKIAorIyBEaXNhYmxpbmcgYnVpbGQgb2YgY3lnc2VydmVyIGlzIG5lZWRl
ZCBmb3IgemVyby1ib290c3RyYXAgYnVpbGQgb2Ygc3RhZ2UgMQorIyBDeWd3aW4gdG9vbGNoYWlu
IHdoZXJlIHRoZSBsaW5rZXIgaXMgbm90IGFibGUgdG8gcHJvZHVjZSBleGVjdXRhYmxlcyB5ZXQu
CitBQ19BUkdfRU5BQkxFKGN5Z3NlcnZlciwKKwkgICAgICBbQVNfSEVMUF9TVFJJTkcoWy0tZGlz
YWJsZS1jeWdzZXJ2ZXJdLCBbZG8gbm90IGJ1aWxkIGN5Z3NlcnZlcl0pXSwsCisJICAgICAgZW5h
YmxlX2N5Z3NlcnZlcj15ZXMpCitBTV9DT05ESVRJT05BTChCVUlMRF9DWUdTRVJWRVIsIFt0ZXN0
ICRlbmFibGVfY3lnc2VydmVyICE9ICJubyJdKQorCiBBQ19DSEVDS19QUk9HUyhbRE9DQk9PSzJY
VEVYSV0sIFtkb2Nib29rMngtdGV4aSBkYjJ4X2RvY2Jvb2sydGV4aV0pCiBpZiB0ZXN0IC16ICIk
RE9DQk9PSzJYVEVYSSIgOyB0aGVuCiAgICAgaWYgdGVzdCAieCRlbmFibGVfZG9jIiAhPSAieG5v
IjsgdGhlbgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3NlcnZlci9NYWtlZmlsZS5hbSBiL3dpbnN1
cC9jeWdzZXJ2ZXIvTWFrZWZpbGUuYW0KaW5kZXggZWM3YTYyMjQwLi5lZmI1NzhlNTMgMTAwNjQ0
Ci0tLSBhL3dpbnN1cC9jeWdzZXJ2ZXIvTWFrZWZpbGUuYW0KKysrIGIvd2luc3VwL2N5Z3NlcnZl
ci9NYWtlZmlsZS5hbQpAQCAtMTIsNyArMTIsOSBAQCBjeWdzZXJ2ZXJfZmxhZ3M9JChjeHhmbGFn
c19jb21tb24pIC1XaW1wbGljaXQtZmFsbHRocm91Z2g9NSAtV2Vycm9yIC1EU1lTQ09ORkRJUgog
QU1fQ1hYRkxBR1MgPSAkKENGTEFHUykKIAogbm9pbnN0X0xJQlJBUklFUyA9IGxpYmN5Z3NlcnZl
ci5hCitpZiBCVUlMRF9DWUdTRVJWRVIKIHNiaW5fUFJPR1JBTVMgPSBjeWdzZXJ2ZXIKK2VuZGlm
CiBiaW5fU0NSSVBUUyA9IGN5Z3NlcnZlci1jb25maWcKIAogY3lnc2VydmVyX1NPVVJDRVMgPSBc
Ci0tIAoyLjQ5LjAudmZzLjAuNAoK

--_002_DB9PR83MB09232A0A1E4EC3D43BBAFA089242ADB9PR83MB0923EURP_--
