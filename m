Return-Path: <SRS0=pByE=ZB=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20707.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::707])
	by sourceware.org (Postfix) with ESMTPS id BED0D3841BB7
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 12:12:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BED0D3841BB7
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BED0D3841BB7
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::707
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750248729; cv=pass;
	b=lyzPuSXcDFcPUfgNeXLqT38LbvS1IdrSUXDXP8gpQ9AvvfEIj//UViIaNQvkJ+zch12JD11GPuSQVnoIReSW88BDu1iQEr6quqAVQPczIhWlP9PzCZKKFvRkAl7+AmGVhwBtI4zAo270i+BX/hGLPtVmxMkqOHZjMlqLD5uxMLw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750248729; c=relaxed/simple;
	bh=6nazBX5W/dy9eUe8BnG/6yTm9SWATKPimtmzoGFHBs8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=AeWTQVpvTs0wMMkWdbAMY04QkThIDenP4skrBYinCkm7uNrdliBLbUZqvfd8gGiMOuEgR9ViVc2EwZBSEVbCqwBQYKVkTbeSvAndQTUI/q+EOu99nThlhiWJBu56HqU/TxyIm6WcOVTlbRK0nO6OfMBkshpVEZEN6jTeZCEtHP0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BED0D3841BB7
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=YlxgaeY+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOq3h83jBuuLp0XBoHlR5haGoPLi0Qi0AQrUrulQsJBR72rcQ9m8WPI4Y45G8Qb4YT4ZCvM8dDARbtsSuGO7BKo/XN2TYSCwHDXzMVzljvSGLD0IzAPc532FmhBaOtLnaGINDfCi+FzHkxQKzN0QwhvFvEHBVX5PYXfLXqoGPcgc3sRKzgV3pnonOc+8zcjdvApfgrz8joFCkBykxDcLqmSJ9QAzBM3jfMyu42J0ZUNQx9UmHBxMATbcwgXweXxph8+/L1MaLN/7YAKRY/4NT3f5NT5E2bV1R56TNoLlEczV1QpqM89N66UTpvkzfWq6fVhqseQsjZB182YAkA5Ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph9Ri4SaFig60JP2Q0OsYjwD3VJFn/fPR6tk7fhPPa8=;
 b=BajYUXHOQ7M3tlHdKclB6wz3PN5yRGhTMVQfrhgCKWymeO7IVwkf8fNGL5qPWcvxUFgPhSRAsrDSrGlUpLJ/Nn0M1B6OB4IR1LT25B8l3Mecbd71awEdvtPvljXgNWttLxCxyElVwSQ6BpvrGozT1OzR38+qI0gpcqPhekoDMevD+lQBWqXNYTfIeB3fPpXOLx6gXgKcPC//5CFJMy7V3WnLul2KXSngT7jEa4LtmaBSDZm6VPNZxyEXR27x2hJwdcToNH2ge+FY30jcj8t2ExaDcVc7x4U0q65Jhf008XqzZg8bp5tgSfQOQP2J5LiwLMq4YgDuXBm0aXRuWIR5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph9Ri4SaFig60JP2Q0OsYjwD3VJFn/fPR6tk7fhPPa8=;
 b=YlxgaeY+FMVrSLxQsLPXv37xmu2UUlr+f9O7DNBDi/oAPE/CFWl5vq6h6giHgYn5cgvRP4YwYffRJqq0KnUAG0q4AFlV9MtfjRGCjJWOATVceRXmSrHFt8mL4N2LqrSQK166cJBv0kVOf4V8nWB3KC4CWRQK8SeHoa/H1zx/8hE=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0650.EURPRD83.prod.outlook.com (2603:10a6:150:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.16; Wed, 18 Jun
 2025 12:11:52 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.006; Wed, 18 Jun 2025
 12:11:51 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: configure: allow configuring
 winsup for AArch64
Thread-Topic: [EXTERNAL] Re: [PATCH] Cygwin: configure: allow configuring
 winsup for AArch64
Thread-Index: AQHb25ThCk+L1aBZXkuyGF5yJxkma7QHNzQAgAGlp5w=
Date: Wed, 18 Jun 2025 12:11:51 +0000
Message-ID:
 <DB9PR83MB0923C93F18F0A940A66A21269272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923C4B40A6602F4A39784CC9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFFLDAWNXM2O5D5P@calimero.vinschen.de>
In-Reply-To: <aFFLDAWNXM2O5D5P@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-18T12:11:50.445Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0650:EE_
x-ms-office365-filtering-correlation-id: 62b08405-8795-4f19-a911-08ddae614ecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?oZSnKTSuo/eoBkq4nROd1Jxw67dTSU2DuFDUpOM9lUZzpg1Uv/k6II28D+?=
 =?iso-8859-2?Q?c5qtDsMdxwtZWUIws6uBTn7YOmqLdS+VaUdxcMGe1LxLQxPv7zX6jHKfls?=
 =?iso-8859-2?Q?axZnspN3I+ud23o41P8a/gV2BKiywMaxgZOIJIVi6KpN4eBRouhSNiwvgq?=
 =?iso-8859-2?Q?tebi2bcHE5CSjiWNH9XF/5htl/uK1Y3p/dS6q18wPKyjQyL45S0s1abGiU?=
 =?iso-8859-2?Q?I5h2mv7SUur/msLDQ1WrzdLJq+Al1/gH7Jl6xYNrryfqf5Su0XaQa1toSb?=
 =?iso-8859-2?Q?sToglB0xd8aZQFA4gIQYkPaV9NrJKBpCtfwyJmXT/YD4hHYcnTk9/Vu41T?=
 =?iso-8859-2?Q?lQEotZ/Y2Ur2p6vJ5VlVzaYwtwVknxQXvK5uyS9gyHiJgzlXegcUPbZ2Gr?=
 =?iso-8859-2?Q?fyBAdg4STT0kwpBqq/mU3u2fLuR10s4K9Auajjxb08s4WMlnsd9IN8mzxm?=
 =?iso-8859-2?Q?eqTc2AlGFHK1eoCO5UmPmjFqYycMEdyp6emxQEMRVJsY3KLJ9Nrw5G33/H?=
 =?iso-8859-2?Q?qZDWK43ndYTkui+8YYrHshEKN6LbQKKRD3xLU0AZK5Qiv6mPai/H73cEnG?=
 =?iso-8859-2?Q?TcDmzQIQNahvtcZq/b4C5NBFkT/P1Hqvok/+JioVsSy5x+NOxTYt2R+mNj?=
 =?iso-8859-2?Q?cU9ebQK4/wfvrjE0xp2IJepIYV4poWzqnXuIUaoJSaYqAKp4F6dRs0KfXs?=
 =?iso-8859-2?Q?YqfHZg1EJxBVWk5XbO2U1iQUOeM0Yn6XKdSXKzWqd0/lOKu0PqYnoricMK?=
 =?iso-8859-2?Q?kAvsW75wvFyllDpXG6e4f1hKhdBUuQ3sLHaQFO2pLu8NXFpmo1IffCt6XL?=
 =?iso-8859-2?Q?uRmtf71GaXjTPbgd446VCG+WmCicTay+DXI2cPQFsIzpbNKUjecqjYZpd/?=
 =?iso-8859-2?Q?lcrNaWNSdeZOku7W+tzIF5yXEiZSvZ2DwlZI04dnNW56cmMhtvwNMI6kqt?=
 =?iso-8859-2?Q?8qHOhpp/jaIFYBPfmO4CtXBWaHCYRgwKYL1dp9xe3s147F7OXVrp5tjrIs?=
 =?iso-8859-2?Q?9ouYKbXZ4Dhlc/g7HX/IrBXQZUX5Wgkewq9B8paP7fv90Zro0DVjPv1JbV?=
 =?iso-8859-2?Q?ndO7FyxQ+raNmDmHh9Pit1zv9O/s2FaX46sDtLg4MZ5s7OFhofj0h+63iG?=
 =?iso-8859-2?Q?a+ynU8Cmj3YbGl+IZ6KLDAdQnLt+cjL4oUy3h+jGr/43DGqIMi6E+0Whgy?=
 =?iso-8859-2?Q?WT3seIqUH1R72pkEDI9utZ4wfGJnoQSfr6hT/txVUr/HVLpogjPbpydHET?=
 =?iso-8859-2?Q?5Udqzxyzf2tutQnKMexLRG8QQ1dS4nHicevsWk/1Dt3u05Y9cimxWxmLZ0?=
 =?iso-8859-2?Q?7u8zQd9FfhxGZDOzowY7ikyBWXpCUD7x1CPo3MFVME/QLQXPl6NU4H1dbh?=
 =?iso-8859-2?Q?9K+N5cSueMSKeiR/JQfrK21rYfvULjvm94R0TyaY1suD5WpHGDnjGowKI7?=
 =?iso-8859-2?Q?aQ2WKbYpevMFpBlzuENZcnxjIwOZ72wnmP7yZtmh4Rx+YFPDvxKunDMt0t?=
 =?iso-8859-2?Q?RVY45Q1zRfEXcGRKW5CIdjdIiQ3TzutkpV8NnPtSOsaQQUGw4zHAv4LZ89?=
 =?iso-8859-2?Q?qEcHRO0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?wUsezpRfcLbuFksUaUbd8SS/LoAcVUIof7P5dcYHUO2JYAxUOHfSrn2E9a?=
 =?iso-8859-2?Q?1tMONhYQHvhSRBe53XR1jnuOpj5juGqg91S6S5uWi+s5xV42Vm67lVrqGC?=
 =?iso-8859-2?Q?t9EB5/PJgzL7tUD0WcJWYuWLc3uJ6GzA4d1mXVOehAFk81XSTEnsig0+/U?=
 =?iso-8859-2?Q?DLix1JaRuOo4xyiAg9G+FaQId3XPQT4lQq4XD6xBelN4/d0pnMDfUPTQgr?=
 =?iso-8859-2?Q?BhEzG8gMP3D1w2Eagl6HDvIwIP0wSyDKMvHvXgjqCpUuE1sfiTtvolHYpC?=
 =?iso-8859-2?Q?k7hirjkt2qCkolOg0+QpOX4JCEAADcD0XgGliGLBnNe0pOo8d9h6ED5P8M?=
 =?iso-8859-2?Q?vKhlqc9wgsAq3NM19PbsWLVrRZSeHHxbn1MJR7+OYlyyPAlPj6zJlRE/5E?=
 =?iso-8859-2?Q?oP+KkC3XC6XxzCFd/reG7bP1FCWXNoUxOR1TVHVka/A4icoSeggRs9h7jL?=
 =?iso-8859-2?Q?40vLgkj44R4RsBj3l+AqULikTpvJkfxB2ZeM9zdZMgdg7pp3kUjwOfqZ5W?=
 =?iso-8859-2?Q?6l/IV/QgSpaGlbab+FrqaCxvKG5yzyfPOh9f7c/x7tS4mDYdrYFZ1udlHU?=
 =?iso-8859-2?Q?M+/yE4gnEhrgxI/oj+YhrulCuYogrm5J+p2aatAEV8DBrQqXdC/Z1cp0qf?=
 =?iso-8859-2?Q?Ma0Kgx8wlRtyAK6mIIeVrcUmFbykd5dhXZPTvdMN4MJC8ZjJd9L+bdwxAk?=
 =?iso-8859-2?Q?WfnJ1Or3OP5BWO+0PXFWmjMZA8NqeXJb9gHce4onrDvtWO8jlv9iPbQaKA?=
 =?iso-8859-2?Q?i/fGU7nKYpoyLWRHA3r/FqnVGYioUrSh6hUfN0NW+yhliwgYiUYXlSGwCv?=
 =?iso-8859-2?Q?SnrYVuHhHvbEEW2q15FPlz3egCFS6I2kkMLVnfAs6uPWkSFzrk8W1zODh6?=
 =?iso-8859-2?Q?NTT0rHugzel7i0+GOwiW4rI/dnWAM8Qnk55yM5Kt4PZvoBcik8ZHA1GnKI?=
 =?iso-8859-2?Q?0WuuqYK1Yf3xpzPcLEPvOYy3+1cpxMcpwV1dK5ipsKrAPRGHSzFY9/9wdU?=
 =?iso-8859-2?Q?h48XdjoMoaesGPYJB2AxIXn9R3JoH4Y5LwtlqqAEey8xnMCFSPd1mlwJgn?=
 =?iso-8859-2?Q?5VBZ7Mr+qMpufM5F5QpUEiD5xZHzwAWKTaGWUI+b4oRubVUzctskWwk8fb?=
 =?iso-8859-2?Q?6709BUrq19ueCVLs4Dkf7YlxgAWmo+clKp2XK/rDXnoLnW8OI3ReerViO+?=
 =?iso-8859-2?Q?XOazcZBkgvrDGTA1UjjTpsur+cbgBTb14YT7JwWfopoLRAO1qnD4Tvdbcp?=
 =?iso-8859-2?Q?cPiRUYkwSqxExaQ/HXZlPe/qa+ShMwYQXiCgUchP+L0qkVHtv2LgS9QhZi?=
 =?iso-8859-2?Q?R2SHtWg+SF7uJYAQwj9T2MhMImWtU+pabtHkZp3Wv+Zq6olwZfHteyYkbl?=
 =?iso-8859-2?Q?WPVZ9p0ZwGydmzvil4dLLCfr9hauncSgEGv4DPKxypxkX0HEegqmHSpzqo?=
 =?iso-8859-2?Q?aRX4zGZZdW+ZXUE3KS6lJm89cw61a7X2XwkDHdNtHLoD5uKIdVwypEaiqK?=
 =?iso-8859-2?Q?yGF23s8g6+i/Yl61kNxWrveM5iT3hdVatGftaTRTBgvVmLqz/bKURTUajm?=
 =?iso-8859-2?Q?6O0jpE0RoMiu0JcRsr3mXaQUZb1F?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923C93F18F0A940A66A21269272ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b08405-8795-4f19-a911-08ddae614ecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:11:51.3253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzJp5VnxYmCjjzE1C+1qQIwriFK0sR2mDRFFVnzSx2RbzyvDGp0i1dV+cl1S9ruXFQhuzmuYu+TjxhiLbREJqKxW9wuE5IzTkPoPfUmZD5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0650
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923C93F18F0A940A66A21269272ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello=0A=
=0A=
Sending the second version with Signed-off-by header.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 96f305fb51e02ac4430640457b4c3e2f0c0dee10 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 11:44:23 +0200=0A=
Subject: [PATCH v2] Cygwin: configure: allow configuring winsup for=0A=
 AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/configure.ac | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/winsup/configure.ac b/winsup/configure.ac=0A=
index 9b9b59dbc..18adf3d97 100644=0A=
--- a/winsup/configure.ac=0A=
+++ b/winsup/configure.ac=0A=
@@ -69,12 +69,14 @@ DLL_ENTRY=3D"dll_entry"=0A=
 =0A=
 case "$target_cpu" in=0A=
    x86_64)	;;=0A=
+   aarch64)	;;=0A=
    *)		AC_MSG_ERROR([Invalid target processor "$target_cpu"]) ;;=0A=
 esac=0A=
 =0A=
 AC_SUBST(DLL_ENTRY)=0A=
 =0A=
 AM_CONDITIONAL(TARGET_X86_64, [test $target_cpu =3D "x86_64"])=0A=
+AM_CONDITIONAL(TARGET_AARCH64, [test $target_cpu =3D "aarch64"])=0A=
 =0A=
 AC_ARG_ENABLE(doc,=0A=
 	      [AS_HELP_STRING([--disable-doc], [do not build documentation])],,=
=0A=
-- =0A=
2.49.0.vfs.0.4=0A=

--_002_DB9PR83MB0923C93F18F0A940A66A21269272ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-v2-Cygwin-configure-allow-configuring-winsup-for-AArch64.patch"
Content-Description:
 v2-0001-v2-Cygwin-configure-allow-configuring-winsup-for-AArch64.patch
Content-Disposition: attachment;
	filename="v2-0001-v2-Cygwin-configure-allow-configuring-winsup-for-AArch64.patch";
	size=1045; creation-date="Wed, 18 Jun 2025 12:11:35 GMT";
	modification-date="Wed, 18 Jun 2025 12:11:35 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5NmYzMDVmYjUxZTAyYWM0NDMwNjQwNDU3YjRjM2UyZjBjMGRlZTEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDExOjQ0OjIzICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQ3lnd2luOiBjb25maWd1cmU6IGFsbG93IGNvbmZpZ3Vy
aW5nIHdpbnN1cCBmb3IKIEFBcmNoNjQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0
ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQK
ClNpZ25lZC1vZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29t
PgotLS0KIHdpbnN1cC9jb25maWd1cmUuYWMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2NvbmZpZ3VyZS5hYyBiL3dpbnN1cC9jb25m
aWd1cmUuYWMKaW5kZXggOWI5YjU5ZGJjLi4xOGFkZjNkOTcgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9j
b25maWd1cmUuYWMKKysrIGIvd2luc3VwL2NvbmZpZ3VyZS5hYwpAQCAtNjksMTIgKzY5LDE0IEBA
IERMTF9FTlRSWT0iZGxsX2VudHJ5IgogCiBjYXNlICIkdGFyZ2V0X2NwdSIgaW4KICAgIHg4Nl82
NCkJOzsKKyAgIGFhcmNoNjQpCTs7CiAgICAqKQkJQUNfTVNHX0VSUk9SKFtJbnZhbGlkIHRhcmdl
dCBwcm9jZXNzb3IgIiR0YXJnZXRfY3B1Il0pIDs7CiBlc2FjCiAKIEFDX1NVQlNUKERMTF9FTlRS
WSkKIAogQU1fQ09ORElUSU9OQUwoVEFSR0VUX1g4Nl82NCwgW3Rlc3QgJHRhcmdldF9jcHUgPSAi
eDg2XzY0Il0pCitBTV9DT05ESVRJT05BTChUQVJHRVRfQUFSQ0g2NCwgW3Rlc3QgJHRhcmdldF9j
cHUgPSAiYWFyY2g2NCJdKQogCiBBQ19BUkdfRU5BQkxFKGRvYywKIAkgICAgICBbQVNfSEVMUF9T
VFJJTkcoWy0tZGlzYWJsZS1kb2NdLCBbZG8gbm90IGJ1aWxkIGRvY3VtZW50YXRpb25dKV0sLAot
LSAKMi40OS4wLnZmcy4wLjQKCg==

--_002_DB9PR83MB0923C93F18F0A940A66A21269272ADB9PR83MB0923EURP_--
