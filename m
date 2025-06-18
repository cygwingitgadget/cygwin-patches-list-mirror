Return-Path: <SRS0=pByE=ZB=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072f.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::72f])
	by sourceware.org (Postfix) with ESMTPS id AD802385702B
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 16:02:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AD802385702B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AD802385702B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::72f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750262566; cv=pass;
	b=ZSl9CgKeS3xFTmIjk2dMUwR9434zjTbg2KVK2zXEOxfnhRbRwFavvhh0TjC/tJpMYtKmOV7lccXXVim/m9q1H2JEQ3S9iu2X/N3iblFIPWymEJWdXBA+jPGppiUcARwV5ccZ5twEXLQYvtQOaWUlSK4z+WtY6Ul4JdeGghr5Rus=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750262566; c=relaxed/simple;
	bh=zThBC0EchHQRJabTLIYk3st1B2N86UkxiwWVWyB3xFE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=cEkVHpySeCKUgOqyMRyFd1gH/Zcew6iDCWn8wZCCrKU6gMVFqO9vFPp7t2lZVc4f/DkhzVHymdjRuoVfbNYMfHyGbqaksWYTp2U5w2cA0pP4+FiVDO59CfRq3vOznz8iccU3ordepfIyHVVnMN1QmSghNBlG+MweSNiWxTHD0ME=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AD802385702B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=LsKwZpJj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w91VJct2t15gNdRgGoYr0/E3QwDlzkpz03YNLreF7keweCKf5NG1vnxC7clerrxxr7jRIlXf6vONdYgeocs8/ztSKxqU/uIb5RwA2X8IXaaVqVt4CS9xB/Z0HCCDDT3TGAdo5INTDu/ji2XMmX4ef5J4InFYHpLPWxTFaWMUHuEyQ39wg05OKheqGucnSsFVgQ6Kgz6MwqSVy3rln6egDvAzquITnLg6qkxPtTqcS/cjp9a8tpjc01DvQnwiXo1ivBCFvkC7oqmT3bGraLEMQjF0voINOu6QvaAzSG8KXz0+pmmA4MF4hY0szj4qZqTtbiP5t7xNggIPi7e7rRF4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EDYpi1VHAyqN4AUvKyRb9cuXB7469cZH/mGzz6LHpE=;
 b=QMBiN5Xf9iEMm+dmIeWaopkJUrpKyDSMRi82ti0nQ+UtPWyu23j+bdrEu7zIA7wCnTS1u8xNWheN7k7R5cvnKTION/iIqdUeW5+dvZkVVHNpluYhrjPrhf1TwFlyJ7zp0JXN8V1dPY15pysHMnp44cECsu47E4oAElIepc11jGn4WZJ1vx54XAW6vSXq13V3qKdVxDZQPdz0vRcR4/DwkRDdJDy1Fh81qyzNZXw/NOa8ZxwgaXAO5FfP0jpj3nkl7wdz8Onq7heK10KkdUgoGgVb2spYnzClwxDBRRLu1HH7uw4jSt+dw1LunHmCE4Z+lkOAPCL5S9+eDrVVdoncDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EDYpi1VHAyqN4AUvKyRb9cuXB7469cZH/mGzz6LHpE=;
 b=LsKwZpJjOUeabQoGuiLtWyALMCEB49sXPx0NHWrMkq6IsT6p4IkkiuTM8XlDR747oFlLp9uAk0i7nNoXVMJmxLV1Gix3YNRhE6Z8CR9NOeqlhpKz92Ntq/mhqFSAdqJ5m7y8PLqQuBfZFXwDfWdQs9eex1iNePONRcfjFhth6rE=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0730.EURPRD83.prod.outlook.com (2603:10a6:150:20e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.8; Wed, 18 Jun
 2025 16:02:32 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.006; Wed, 18 Jun 2025
 16:02:31 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: stack base initialization for AArch64
Thread-Topic: [PATCH] Cygwin: stack base initialization for AArch64
Thread-Index: AQHb4GohaV9RByzWEkuse0eJGFCLSw==
Date: Wed, 18 Jun 2025 16:02:31 +0000
Message-ID:
 <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-18T16:02:30.379Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0730:EE_
x-ms-office365-filtering-correlation-id: 10dc61ce-ba08-45db-c445-08ddae81881b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?83wXum9v0RDu7HGEaeNkxCt3L3nEOaVJ52NIZF6KV2YuNPaDP8wiwoRsyj?=
 =?iso-8859-2?Q?9ROWQy5pNHb54jAu7FzRsMLSaayMpDQ5Z7ZOHHrT+bsvOtlK/TKOjhH/Zc?=
 =?iso-8859-2?Q?n2PpRVdGROq3Nbm1LU/BmAgYGbJUJOCbu9PXKxvzdS/rWUPXSKpQ0hB45E?=
 =?iso-8859-2?Q?JSwsLKdb60NkhEQaWPfSTZ4zaj9FbwDkEhR+Ij7iS2dPFSM05/D1YFgYAV?=
 =?iso-8859-2?Q?1N4vQgJ7h2KIEgTOYZ6SP82VWu8Sxo1OZorDbRENAmfuXWdUW6V8TeiTJF?=
 =?iso-8859-2?Q?P1+ZzLEhA0yO4YIpZyu/0Lt2s39GT4C0z84AUIgJ3pA6P/xik6ffZw372b?=
 =?iso-8859-2?Q?2tAMV3qfS63hSGQQMZMRCWGgo1kVYj0IyzY7fXHS9IYnbz8upbM/+sobPH?=
 =?iso-8859-2?Q?a8fcrJ8+RJjjw7hvje/RcGJEdB6OpHxt85HvqikskVWT4pUlzEHaNHab9j?=
 =?iso-8859-2?Q?UeIxYioeMPvGFY2h7fFMDLRMeyERxbRT0rDWBFAwAUmeg0+RS/7oci7pCW?=
 =?iso-8859-2?Q?/L1AyHxgY4MzXVWqYxgJqPgVrs0jMuNC8PRwPwRHSk6RiQILuFpRiYQ41A?=
 =?iso-8859-2?Q?6juTQv1TCyCq+JMtBKKkipwWLfggnAtPpvL5QCyNQXxrRDEcvXMyQRL5zX?=
 =?iso-8859-2?Q?4HRG5yRmrnQCzabahvRKJYpqq2wCWW/2MOzHGEwjPjGPZLlFVM7zZGA/5i?=
 =?iso-8859-2?Q?xs86I/TlkS9muqB9LYIdmF/Q4pdpx/EZvjeDvimMjxQTcnfhQ37uFQ3oGa?=
 =?iso-8859-2?Q?jJhk9YOcbAZAvFBofcMH7qnurV69aurzSbibYhMeGurFkPwG7aLeP7nExm?=
 =?iso-8859-2?Q?Pa/Uva1VT0AWYho+qs7ip0IWa+ywM/FV/bAgypfRsupofE7L3wR1VHuOjP?=
 =?iso-8859-2?Q?GkOj7liiw7jPr6fzQnwU1NpfqXRU+e7vdhj2ea3TjtkHgb4enKcW7WAtQ8?=
 =?iso-8859-2?Q?tsHiuwzqrHQPElqBhNP+4amq4uC7zN7Y4cBV5TgnW9zKdNsa4I2Rv+0K9+?=
 =?iso-8859-2?Q?K8IMqq+t8EnupclFvg7exbmuRT9EpkzmmWBALSv7V5zVpU5x+FGoe3gkaG?=
 =?iso-8859-2?Q?fkJsRTwj7WVz83RVivucqlEnjzaVS3l1/f0NYzgUmUgespy3V1bcRZNO6s?=
 =?iso-8859-2?Q?ejqGGB5/rrFoj8d1GMxVlzmYdIs/3hgNllJfYhlv2+eo688fLOriEzugV9?=
 =?iso-8859-2?Q?s8ChSuH1hJsMJrTQO/pVF9kk/O+I0x50KFq5PVKzcWHkm9xtRf35LuuHXg?=
 =?iso-8859-2?Q?OOU/80nKZ89gGLfmCEV1MCGZw1nx5rKjdB6cNKPFsONmZ4Pvth+VSPFgRl?=
 =?iso-8859-2?Q?kLYx/jl2D1bt5IuacF8lKCo40XXA2i/fl3vxR0IbkoQ0R0VnxaXIkMRGgk?=
 =?iso-8859-2?Q?BcO8JZ/q04mt9SlVAT9soySfdrX1aNeZH50v6uMjaae6PjJsgV0nmoJlWr?=
 =?iso-8859-2?Q?HAghqPaR3HC4HQgFkUol1XWOgbnWT0+1ecQ8P9FHZs8xuSQHNZCpxEPwew?=
 =?iso-8859-2?Q?k7onxDsFBZ3j2O7boSnIb0Bqsspk9sl1cr9229yEy/GA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?c71bq7zZM6uCoqvioRdMBGNZBPRq/OxuBC1ObCX6x1DcFZflVtzKcRSlmG?=
 =?iso-8859-2?Q?s2Q9AeaA7Ty6X3jQoSbiVzzveG4gA9oUFYkKVkqiPqNNiZQhYMqnSLCg0T?=
 =?iso-8859-2?Q?FqiJsnrFF6rFSvAiaJ8XI1VFjC1jF1rssB4GhbqkrSS4HIqQsxm4W1ziwr?=
 =?iso-8859-2?Q?PWdQKCIx7SoeFmPCmphLaY991Zfw8M8rdonteIW0loEka+nj1dMXFyCwV+?=
 =?iso-8859-2?Q?iKi0dYFa94rE4BWwHS22dCr9rxs6gttPISyC7f0y4b3gD+dPl2wbhQaZc0?=
 =?iso-8859-2?Q?nLFz02WuP3nBJFF/wBiERDT7nOgdRPQin0FInG92plA1lZh1rwKmtnM9sp?=
 =?iso-8859-2?Q?4Kq6CUUcb5G92VH2rUyqjROCTEOzhxMNm0NbYqUCxR13s/n0DvpxX1W9w9?=
 =?iso-8859-2?Q?Yzj0O8j7iiILBDEtgLtJSo3JHRMCou2ZceCORO3LX6HT+ltGduUWkNSIxu?=
 =?iso-8859-2?Q?2LGh9aItQ9kqstpGwJ6AymTe63eFpEVc57g9YO38oDCZUYhGw2/z4/w4M3?=
 =?iso-8859-2?Q?19rZ3DjKTIWKyNwKKSAxjo+IkT5yrkuAwnAhv0V8iQB68Z0l+pwqHGFf/J?=
 =?iso-8859-2?Q?60Ith2jlcfJx5cgMC/uezJIZKHslNN9duM2vPsPQXpCu2wnJ0HRNyqXDaW?=
 =?iso-8859-2?Q?QkVZMuHFP9EGXCRv3wfUmenb2hLExZ1Hj9799pDf0NXJ4E+hHniZl3lzNN?=
 =?iso-8859-2?Q?DHghgaxkepBaz3yQo2AJWfIUZSxQZXgA4DhLjxkgSJPGy+ebS5RgNdkwnR?=
 =?iso-8859-2?Q?8maYpE3DyJIhQQf072ZyQCPG84QZ+l7i2E/ZKZrjOmtazYbbr8l+oCJlFA?=
 =?iso-8859-2?Q?PUfmKoPo65dHCv3s6XxISI4yjeM+jxXr+03GRuaTscpwtU8xPmLjrbKnfp?=
 =?iso-8859-2?Q?WMX7HywuhFv/OEGVUw5+b3/56KJhkIzNE2niUyN37/1sc/hd/R1WS5qagq?=
 =?iso-8859-2?Q?AsxvVsHzR2RbkY6RDYzFJ20+vPZSO320rJGBnEEpq7F4rNbdELeylUi315?=
 =?iso-8859-2?Q?BJPI1ONmKTBnNoEGzzBZ1ldiX8BJMx3xMbNChiptxMWxdAj7YL54okE9QD?=
 =?iso-8859-2?Q?OqF2cUFpz2CJvwcY+Hbet/azwhDXrPzT9AYAL4yIb14oGuWdNBTYU9WwYa?=
 =?iso-8859-2?Q?Cq7wyKNdRZAI+02hm2ukuqSqA53iU1GSZb5ETilJNfZow/cj67EyrhkTvR?=
 =?iso-8859-2?Q?N04Pdd1Le6Q8ef6NfO6s6mtEMGIYuVHZvUIsjuy6GoVWC/xASn5v1HhuBX?=
 =?iso-8859-2?Q?f2uuA4zGp9BJrjEKhuKCSj7GfPeLXMPi5u9wTmF292sPtVP89tSR5KBcKt?=
 =?iso-8859-2?Q?oCwuITsSPQjTKfcwboj/pmNejMdZsonV+0L3IiAVfm16ZoAdioqDfghdPA?=
 =?iso-8859-2?Q?1eJo5hRNKB5G6Um8Wmu058IoOt8xnM+yVfu1y5HiShOm/FljgJWy2mAqWB?=
 =?iso-8859-2?Q?/O8gVoZTDNT43y8NJKwy26YpgUKTvxbfa+3YLKCfVEZhHdmFSQie6dV90a?=
 =?iso-8859-2?Q?17zocR/w/wkIB8ivIuRvql5dQJe9tUKj489Euas/LoVsJxU42861Iw0+Xc?=
 =?iso-8859-2?Q?F8Oj1Jq4OhZAavI47qjP1xQylt3N?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dc61ce-ba08-45db-c445-08ddae81881b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:02:31.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RblcTbkSYPNl7u7Wk2CnYNzW4ch798A5s/jNyqu2WgLD4ac7WJ4OdaRMUjbh8GCv2o8+eGa3SedsiSB+00byAWFtPAvPG2T9pFlmY3MG9Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0730
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
This patch ports stack base initialization at dcrt0.cc to AArch64.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 5d470261d9b865bf709f9f4d8da350e3536e6251 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 13:15:22 +0200=0A=
Subject: [PATCH] Cygwin: stack base initialization for AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/dcrt0.cc | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc=0A=
index f4c09befd..15b3479d3 100644=0A=
--- a/winsup/cygwin/dcrt0.cc=0A=
+++ b/winsup/cygwin/dcrt0.cc=0A=
@@ -1030,14 +1030,20 @@ _dll_crt0 ()=0A=
 	  PVOID stackaddr =3D create_new_main_thread_stack (allocationbase);=0A=
 	  if (stackaddr)=0A=
 	    {=0A=
-#ifdef __x86_64__=0A=
 	      /* Set stack pointer to new address.  Set frame pointer to=0A=
 	         stack pointer and subtract 32 bytes for shadow space. */=0A=
+#if defined(__x86_64__)=0A=
 	      __asm__ ("\n\=0A=
 		       movq %[ADDR], %%rsp \n\=0A=
 		       movq  %%rsp, %%rbp  \n\=0A=
 		       subq  $32,%%rsp     \n"=0A=
 		       : : [ADDR] "r" (stackaddr));=0A=
+#elif defined(__aarch64__)=0A=
+	      __asm__ ("\n\=0A=
+		       mov fp, %[ADDR] \n\=0A=
+		       sub sp, fp, #32 \n"=0A=
+		       : : [ADDR] "r" (stackaddr)=0A=
+		       : "memory");=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
-- =0A=
2.49.0.vfs.0.4=
