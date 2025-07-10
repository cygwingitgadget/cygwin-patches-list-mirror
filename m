Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20730.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::730])
	by sourceware.org (Postfix) with ESMTPS id C8C893858CD9
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 10:30:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C8C893858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C8C893858CD9
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::730
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752143443; cv=pass;
	b=QviebbzWNdwlpdyIvvfodR1N9Ufiro9WFQuIL7RBsVDyuADIEzqZa/dqLnXdoBx9y/8ql3UpGVmlhTYKG+riFSCEhNEk0U8OL/UOwPol1+F09CzZwRVRvj7MW3VYO61PNQ6CzYTPboslExp/SBfLxxgFRkDz57X2MxZ8Uml3g/g=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752143443; c=relaxed/simple;
	bh=BKzB7QmeuBgrH9+NIUH7T5arQYrz7cmShRyUAYH2qQk=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=urUfNacmunl2vkZqZkWxV/rsa0GI43l3AZ2Fx/iUQMDQZV1OpYN03NFRIs1na9Zs1JZPFKjOspIJ7HisSV8GivNInLfvp07KwvsbDBnVsLgaiNHy3zfpQWIH1NhW+G823Vmjk5xfg+Jyro/tFlPjTjILg+Piube7tcPn8nrcCRw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C8C893858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=QLGLr/2l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5TPnu0hwvZc1jXA3g0WUdylViV3xf7OwRwnvP1/U959IQ1ykIILsDBGpjVMLvmLYKP6birsh/0AT49mZNFBsZy3NbHJWbDQm5sTTrkma5a2wxPRt3rDQXLDiKuSQp103Mj6XDdXUTejID2WahmmVZaK7zoEnWlVVaak0WJR21kiVbVovdrNVOlncP7S8o8M7Qyqgd0tp7xLR20/ddA1M0P471MnrniskyrDHOlS4fk5JBH4M1jvsWhGNRXGci7tmFKkBybjWACQGeqgZF8wMfiSCl4zzH3ebUhUNBzUWNm14q3LboGITaKeEkIREe8dxhpxsSdSFJd0h1UcC0bLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lCCz6kpbL+al8iYb95CCujKSvrhLAWA10zp2ote8y0=;
 b=BTr7m23BZAzK/p3fsGk1gJC8xSxNSoBGQAWNsQ+XYivbUQcdx4B4ABBw93Y2diVDCrxKKfFgkg5bIo/zGDng+wg8BdffbkjiCykYW3gy7sXl40A49qLZLgMPN1mjY5Thhh78QrH2z2/qTFG87KCatinG796hR/wW3Ztwa+THORbHeAu5asddowWwfDYciIwM3LF5uT+WM+4w2aqlBV3u5UscZ/sRoOW16hXmfuZLRheUHaYe5fcsWyuCwasZuDo7KS+inn2IAgmXuIC6lzQjysHg4RWEqgTmIX7jKkAyEIrlCotB1LoBhwDhGmXGwu8FcjVtrPnrsdeZ+m4EuY8Mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lCCz6kpbL+al8iYb95CCujKSvrhLAWA10zp2ote8y0=;
 b=QLGLr/2lSv9XPg/3s/AbBpkR0joeiZDlQgX59cFt2mjzZZDXqVbYFfl8M57/uiFPg64toOdbHFvkXI5vlkdQFEOYSWZYq1XIVCMrYKa0Xn3JepgC3/Fcg+c4wSzgH9yIfieN1dBUOPOkFJZtSPM0QLhYev5v+mhvthKlQJdeYZg=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0746.EURPRD83.prod.outlook.com (2603:10a6:10:586::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.22; Thu, 10 Jul
 2025 10:30:40 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 10:30:40 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Radek Barton
	<radek.barton@microsoft.com>
Subject: [PATCH v2] Cygwin: dumper: port to AArch64
Thread-Topic: [PATCH v2] Cygwin: dumper: port to AArch64
Thread-Index: AQHb8YWuRGWVkp5e+0uVgvY31JDUFQ==
Date: Thu, 10 Jul 2025 10:30:40 +0000
Message-ID:
 <DB9PR83MB0923B2E497E8B66E7F20A5D49248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923715C769A4815ECC3D81A9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB0923715C769A4815ECC3D81A9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T10:30:37.898Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0746:EE_
x-ms-office365-filtering-correlation-id: 72f6df77-f264-482d-d02f-08ddbf9cd12b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?8VceMO1wb3DaF84IKeRnDr9HsFCCW0a3ncriav2F77oMVXLKzo7mMdkkte?=
 =?iso-8859-2?Q?IVIFWtdpPaaUqqZXlBpuninWBxvjHG1usEwr+nZSWil8Ehe1ZfcQ/ifDp9?=
 =?iso-8859-2?Q?+f8WZ7k39aWZtlquziXIXFEHG4WYonudVitV1snMMmfG0cdCzJHYeI9RB6?=
 =?iso-8859-2?Q?WOzG2wWvkZDOW7KUX4QGzG277V2DOSAkXcaWOY6UEVdMBUF/hd5uA3U05z?=
 =?iso-8859-2?Q?jihoRYXitpvFB8CClEzKpaAIQzl2v1jWGMIZf5hO8AzTtKnXjVYCUoukbN?=
 =?iso-8859-2?Q?BfDydQgFS/kXN5vI98XzPqd5LRvWJRc+ugZr5tucsM+eCxCm1QXkOFLSaf?=
 =?iso-8859-2?Q?UBj5HQ4JYrFNShx5Oawn0PdT2vUJr3yEdZuAqZLxyHQX0b2RK7vPnkV1U/?=
 =?iso-8859-2?Q?rNanBYTwv2hdie7TP8VebhtoIqE00FpbP4I+MJtMaCc3AnWlCIGo2Fn/fu?=
 =?iso-8859-2?Q?/IyIo2SbYKWBbEwU9xWaTqxQDcDQyjHK7/SvaVd6nYVeoRcum4EmKsg8EZ?=
 =?iso-8859-2?Q?wC5YZU28/xCVC1QRa0QX9PtQEzVS56bLclpmikPfKqrF2xOxSdB6+UfVPQ?=
 =?iso-8859-2?Q?1AIFtXop2G4vWpTh+PmD1MwfG4L3hvM5HRYg9X/P0m0O0dFZT6Hn0u9Q96?=
 =?iso-8859-2?Q?DfnULlzdGddmXc8YdW7eZw7MOLYLCy+RZgNZ7WPL3Cti4i8jPCRjzpW4Za?=
 =?iso-8859-2?Q?QsDPtkrpGqVTxvgw7C2SPK6Z1oIVNtQTectU2YMph4sUK22mA48x6y4JUu?=
 =?iso-8859-2?Q?0ZPhKDWfQgptWVtJMsETe1/CWJSszvogTSVuri90XieDnMNRXJ/MXkb3bM?=
 =?iso-8859-2?Q?jV9SJXjqWbMlZPq6l94ja5yyqCcWK03yhKzxCAK30gUVYH9NhG02luf8lV?=
 =?iso-8859-2?Q?BDycO4WnfBNAL/dheuHUOOxYrVsaVJ5wil0lDsu8oWawCmXVntCHX61nWi?=
 =?iso-8859-2?Q?F/lfzQgzjzcn3hPkSZOJcubndWS6+MA1rN7aF41QuORoqCoChSB0M+vqvG?=
 =?iso-8859-2?Q?aO7pg/4ZLyC4EtTXREignRcQtsC9phVM0eY1yrp97KBRwfkC2XEjxh8slu?=
 =?iso-8859-2?Q?oBIRXmVYnGSsYOtCEpxG7IP8ECDJd6FddyFjJ/Zq1PPOBnoxb0pyQLDOit?=
 =?iso-8859-2?Q?Ac4Y9DlVxe89diKD2hbF4jrORCLLJo/lWwxtNKDL2kwBgRWpaAJ7kOTh9y?=
 =?iso-8859-2?Q?XDtagMys7o8RNZEbXsJMXytILMYzLD27sbePXVnR/YN6hIl/nB6w+SgbXl?=
 =?iso-8859-2?Q?WMFb2Q5PvnkDHNCqcMrkTUrY528YfwWFNW6cTdt0Xq5tWzvCcM7vYMNZoM?=
 =?iso-8859-2?Q?SWCD482YXMewM1ha0n/kvO+yR2IaPyAuvdpflauulY67c5tqlnPey8X9PJ?=
 =?iso-8859-2?Q?x3OjSzoOcFQsoy/lS8dqLGIzIFyVf+d/jaOC3v7JPW+4pn8zs9dg7m2Jls?=
 =?iso-8859-2?Q?yN47GtsIVcJOCAWrxyois1fUQl1ujVxMkQgq/kbQIM9qkQ98ya069pc+8W?=
 =?iso-8859-2?Q?G0PlWezZT6n0AssDz32HxKIBcvKgp7Sops6xDaWzOaHSEAsZynFExU0Q+L?=
 =?iso-8859-2?Q?M3xpr/0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?HDc6Wwi7avD3ww3hLZ+5HOjGxibiq7SLs4jXJxJICT16hJpm0vCnqR6q0K?=
 =?iso-8859-2?Q?P+FnEDKDQUhrdxMQL43mlud5HwDYJAcexHZjKZjgb+XjXoG6faqn+5WLnn?=
 =?iso-8859-2?Q?B9GAKNF1yfiv8r71B1nstM0TRpZeePTjwp/QsD1pu1CnbSjbGqnWtPhFfW?=
 =?iso-8859-2?Q?PEBFrbqteC7Qy9I5mgM/7dLUJvr/FZnQD98HrRkfiGFxoHOMh8hKEfa43k?=
 =?iso-8859-2?Q?QVllu2NR3eZYhQBjQtAbK7b/OReQScX+vb7VlMBQBebr7uOr3hLDEwYmei?=
 =?iso-8859-2?Q?HZN8nhnc2B41BMoXyx9Cwr3Ew/7DmmM768w4w6x/e1mTI+nyYJRL266qzS?=
 =?iso-8859-2?Q?rNS27cir7+B9vAd71xfLawg4YSRGDGHbpppzKeY8VKZ/k3FlYctlvGHLEG?=
 =?iso-8859-2?Q?AbKeOFWewZ0a3452t9UmHRxpjaz3Q8AxepC8mnRju3Nm3W137IyHTvlLPA?=
 =?iso-8859-2?Q?9i9i6Y3pf2gUOkzYECenPDlMJapB1Fdgn0Xdp+EQalX9eof9Je6Zu8VRBh?=
 =?iso-8859-2?Q?VUQVwfwrnlhUV9pJbHR0DY56/ffhp/X09AwTtLSoMapuj4BOH74+BjvONW?=
 =?iso-8859-2?Q?syO50wC3ordXxweHSwezewjvvqP5bYXGpK9Cue49mMhisguDIImJ8GSSB2?=
 =?iso-8859-2?Q?ZEb6ImhEz+AOm4CU6HxjCLcnh6kT/B4HfavIECAMyfLBP6OdCWfidm1z+s?=
 =?iso-8859-2?Q?qmTwnWNIb1hMZ30pSaKZorvxIXp1LfUdpxehCBKxtjOZ281iaUaGn0Z3ku?=
 =?iso-8859-2?Q?HMBpc5egwJ2nwSdHuDsMqgiIndLRxZPEXJgxczh5KlGm0ZC09ss9MGwVF3?=
 =?iso-8859-2?Q?tqvexpaguwYj0dHs27qPf00jl1ERlDI82bGuRA5wlGLf28M+PvkgXrR35C?=
 =?iso-8859-2?Q?t7xhgnpBjKwlZe9urUY254vHrfADcxe5MjtjzGS7RLQ48TJAxD92YeQgEa?=
 =?iso-8859-2?Q?3ymWzit6R4X9ErnWgHLPFfVoyYqQozEmr/u6L8ohKT/ppMlwgbOpuODWU3?=
 =?iso-8859-2?Q?TT38RP40Mh6GAwsBcqBmq1GbxDYClUcUR3/8phDHC5x5VChGH+w9f2YY8n?=
 =?iso-8859-2?Q?Cwmjvfvzn1hXFEXpD0Z59sra9cHHMekw/nlycWjqbMb7+OaUYpcrBvcJGV?=
 =?iso-8859-2?Q?JIp7sM6LjmzqmHtloLOM2xFYQI0uUPGa+QTUwyLsKKM6WSLb+EI5Tjp0nZ?=
 =?iso-8859-2?Q?re+UtFElaXomXigWl1iick3sH+6NJwEzF21meDgekXFHHqR8v/4WY/14uP?=
 =?iso-8859-2?Q?0qjLQKx/kx3yc6oHh5rmuTda2C8dUPZk7D0IpGYMJab3Otx83VDQ9Nyliy?=
 =?iso-8859-2?Q?xf1r+wQkf2X+STHJcdx+wUaOcrB2U4jThqFFugM+M3YjfNhhh/n/c+hS9e?=
 =?iso-8859-2?Q?L9PXOJr2ojSQEUIuceK3rIcuob91o1KGwbMRx5fftCFQlVXE4wnNKBq7A3?=
 =?iso-8859-2?Q?g/lr5ESgVyTvyRy3xBr0bQ69zzbSbP4DbnXUCZGbJ7RxdbFHkXh3nPML+B?=
 =?iso-8859-2?Q?SlOQYBxdQ5Tse9OTbII13icq8rp6AGsS71IpUjos1DW5YxcugM21bK8iO7?=
 =?iso-8859-2?Q?IdSO/VEuVNtGCX+2bcdSRBfFj0bf?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923B2E497E8B66E7F20A5D49248ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f6df77-f264-482d-d02f-08ddbf9cd12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 10:30:40.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GubPX6QEbAVGPsVh+58Rk1EMVHJFyN7gCC0FSfb2nOrPzG+07psab59QHhLbMeAXbfhNSpv2zIroCTJ3BQzSmAhytWR7nL/GBnoBStXZHX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0746
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923B2E497E8B66E7F20A5D49248ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending the same patch with more detailed commit message added.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 5df85fa4e3a92d96fedc9ede03523b320e9be3db Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Wed, 11 Jun 2025 23:07:21 +0200=0A=
Subject: [PATCH v2] Cygwin: dumper: port to AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch allows to build winsup/utils/dumper.cc for AArch64 by handling t=
arget=0A=
architecture condition in dumper::init_core_dump.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/utils/dumper.cc | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc=0A=
index 994f9b683..b3151e66d 100644=0A=
--- a/winsup/utils/dumper.cc=0A=
+++ b/winsup/utils/dumper.cc=0A=
@@ -700,8 +700,10 @@ dumper::init_core_dump ()=0A=
 {=0A=
   bfd_init ();=0A=
 =0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
   const char *target =3D "elf64-x86-64";=0A=
+#elif defined(__aarch64__)=0A=
+  const char *target =3D "elf64-aarch64";=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB0923B2E497E8B66E7F20A5D49248ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-dumper-port-to-AArch64.patch"
Content-Description: v2-0001-Cygwin-dumper-port-to-AArch64.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-dumper-port-to-AArch64.patch"; size=1042;
	creation-date="Thu, 10 Jul 2025 10:30:30 GMT";
	modification-date="Thu, 10 Jul 2025 10:30:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1ZGY4NWZhNGUzYTkyZDk2ZmVkYzllZGUwMzUyM2IzMjBlOWJlM2RiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogV2VkLCAxMSBKdW4gMjAyNSAyMzowNzoyMSAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIEN5Z3dpbjogZHVtcGVyOiBwb3J0IHRvIEFBcmNoNjQK
TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04
CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRoaXMgcGF0Y2ggYWxsb3dzIHRvIGJ1
aWxkIHdpbnN1cC91dGlscy9kdW1wZXIuY2MgZm9yIEFBcmNoNjQgYnkgaGFuZGxpbmcgdGFyZ2V0
CmFyY2hpdGVjdHVyZSBjb25kaXRpb24gaW4gZHVtcGVyOjppbml0X2NvcmVfZHVtcC4KClNpZ25l
ZC1vZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0K
IHdpbnN1cC91dGlscy9kdW1wZXIuY2MgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvdXRpbHMvZHVtcGVy
LmNjIGIvd2luc3VwL3V0aWxzL2R1bXBlci5jYwppbmRleCA5OTRmOWI2ODMuLmIzMTUxZTY2ZCAx
MDA2NDQKLS0tIGEvd2luc3VwL3V0aWxzL2R1bXBlci5jYworKysgYi93aW5zdXAvdXRpbHMvZHVt
cGVyLmNjCkBAIC03MDAsOCArNzAwLDEwIEBAIGR1bXBlcjo6aW5pdF9jb3JlX2R1bXAgKCkKIHsK
ICAgYmZkX2luaXQgKCk7CiAKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82
NF9fKQogICBjb25zdCBjaGFyICp0YXJnZXQgPSAiZWxmNjQteDg2LTY0IjsKKyNlbGlmIGRlZmlu
ZWQoX19hYXJjaDY0X18pCisgIGNvbnN0IGNoYXIgKnRhcmdldCA9ICJlbGY2NC1hYXJjaDY0IjsK
ICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgotLSAK
Mi41MC4xLnZmcy4wLjAKCg==

--_002_DB9PR83MB0923B2E497E8B66E7F20A5D49248ADB9PR83MB0923EURP_--
