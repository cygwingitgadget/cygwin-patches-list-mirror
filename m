Return-Path: <SRS0=pByE=ZB=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070e.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::70e])
	by sourceware.org (Postfix) with ESMTPS id 62FE53866230
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 12:15:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 62FE53866230
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 62FE53866230
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::70e
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750248954; cv=pass;
	b=iyIWundRwrOoGFAUEforJcmabmgk52t80kp9cKJK9Tm/xp05Tl4PIXclYiL9Pn+HaY48JdO3jsO9UMTZM0RuaqgE8xwTTfxUDuj+y6HzfnlTtNy8AjRrdgcE1EAfbL1/ynjGjHVSp/85Wes/TOaXEn1d/Q4mC0IgsmhchMMCSqg=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750248954; c=relaxed/simple;
	bh=sWG8XjhjYFiaK5VsVs/TX7Yg3QW7qVRvDsaSnU1RnUA=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ju97YbYyPDCFbFtQH5fMwJTjB/yJz+akb/fTfFLdHONeugK2eg7uE1FBrgANFVlus3JnoaGgCIq7dABsRbHy6vdQsnduau2zgt/WK2+61C3fiC5KrDehecVTOvUeXJMaEH+AzcsWKsK62vPBLEr5O5DRLBZSlQDbw0t0G2vi0wQ=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 62FE53866230
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=VD913e+0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkBMKbmfxBW2cVNJsHQ85XhWgwZLqZPIXKbUaR10X0E+cKXTzBz9f/xY8cGyc8QR+ytUuoT30FPK/ux+GNPizF+szyFIDEyz4ZJ458FVpz5qtYccY/0Hl5M4TpiYPDS9CtgF44o+BjWekvF5T4AXNr4Nx47MeKYczRHfU/0QprZxywASYPUNgiiyn4LhlpZg0EzI0AgxLfTEC4EgUqPOz6Ige4yFjZbYBRBv6+0mgvITit5l13s6muGQP1RKZY0Uuv//EmH1W4J3QWY0foKRGmesx7DQXu8VULTNcQ7yEDR81eOBlblzVjehks2lvf6jruFHxow8PzrHKG1zYJM+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgLEtVA3Q7IKcXD+n1R5Yrn86+XiyAgpGi0f1ReScSU=;
 b=DD4i1DOvJQWPkC9+6Gappwzp8YlZh9NQfH4x1lV9lOfyblTf+vxbslHYiTe6vly2HdRq8qm/OKu9XU1QE5+gXPckXsQkHVLShJnkiGhmL06A7JzojuXLEjcjl3DSNaA5aLcAe146NvZICjOELkjrxE3Xbq2vJ+AtcBYS6udnXtJV776hja/Wi7l6jFrAnOiRloQPedT7qJzCRBUoB5BYcjwAefhg4sK0Ljk7q9AvCcopS/2EggavsfEwBDD3Zpfjdw1a3Ypb03oPAswvE71q8QjpvOo1GlMC4lJe4nEITtMDX+5yDsw8XPHA8Bb5Rj+Lo+740jEEavUzi04/VelqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgLEtVA3Q7IKcXD+n1R5Yrn86+XiyAgpGi0f1ReScSU=;
 b=VD913e+0/AFKZX5dX9cg+MeME/3Ne3bnUE2GbGG4KAz8ijiZ1KaYBXVNOtm70zNcKfQR8B58MkQn67MxIvph65cwnCud7BnMsl0tCQ0UaFJC+AgM5W1U1PPGb0Vt3sSYDghm2t3En1XX6cFp9y1gURVRFvQa6CJa4O9XcsPSQ/s=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU6PR83MB0851.EURPRD83.prod.outlook.com (2603:10a6:10:5c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.7; Wed, 18 Jun
 2025 12:15:50 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.006; Wed, 18 Jun 2025
 12:15:50 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [EXTERNAL] [PATCH] Cygwin: fix MALLOC_ALIGNMENT already defined
 in newlib for AArch64
Thread-Topic: [EXTERNAL] [PATCH] Cygwin: fix MALLOC_ALIGNMENT already defined
 in newlib for AArch64
Thread-Index: AQHb4Eq6LnbjKtLyI0ungFtkcwgy7g==
Date: Wed, 18 Jun 2025 12:15:50 +0000
Message-ID:
 <DB9PR83MB092321E4E33CF50011F35A809272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB092385493BAC19ED728089929270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB092385493BAC19ED728089929270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-18T12:15:49.766Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU6PR83MB0851:EE_
x-ms-office365-filtering-correlation-id: ae04ec4f-92be-49f2-6548-08ddae61dd72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?9uXh7jjHoiQcME79jiA8a5TTYmRIXmqrAoyi/eVcxDkRqQMaNEQcfceHss?=
 =?iso-8859-2?Q?HA2v0IZGHHYqrgchTW2CctwGRMPX/y5n2fOKCW0vPSY57II7RcwwpjUNvr?=
 =?iso-8859-2?Q?SEs7f1kFn+6x64MuXwcreB9sUDutqg0oTF/1zDmyBQYuFlTqdxdn59z6t5?=
 =?iso-8859-2?Q?wb0zFtw0ro15fu0ZE8pau7q7hWQew3orMkf4jtgbdfbSK6rBMvPYYgt6TG?=
 =?iso-8859-2?Q?VbIswrOpYVt3Q7RYcP8hOHUIoRpIEfrJKRWz6UyxVZx5xB8qgnkhT3uk7J?=
 =?iso-8859-2?Q?dsZCL+0DmxgYIE9Kb93lf/zlheSm7Rn8aLPZlq8LgdloyIE4dOJaXCC3Nr?=
 =?iso-8859-2?Q?4JEn9C6JaS9pZ106AffgV+ptlL6kgpWnGWt6QlpX9OEygvzuAOnJrKcJBb?=
 =?iso-8859-2?Q?mXNzFaDW13WmU/YsnMpL6SE8mIPNQvSHKHHRdqLBDHj5aNyoO0BUmYPGwC?=
 =?iso-8859-2?Q?wdS+AWP60G1JYO1G76R/5XnWBy8zfyLRw0irikOz3Ga3u2u9b4vMQpAmgC?=
 =?iso-8859-2?Q?oCoJMPDi1dNpo+VzcZie72J8GIMEUhg7KVfv4MdHIvzYtx3HxBnn2MnCzJ?=
 =?iso-8859-2?Q?qg+svsn9lPkwte/JA2JQetafiDPH8DQJAo3UaEyhMp5L+GsaEe6NBxOoWx?=
 =?iso-8859-2?Q?cjkQNlJUqRkF3KE+aBBwvT4K2Ta/hPmd5felQEeFC+x0jS6vfMjnAc8PAS?=
 =?iso-8859-2?Q?SxGE4HF/oFuEC/z8sf5ibrVNPmf0socz9WShEHGtSDmg4xd6vi1ObWOwUv?=
 =?iso-8859-2?Q?W4ZYXaGbHplZlwxhGXjDxdcvmSJYODtkflAUqKHloTvZVeVbpC6ExgYVD7?=
 =?iso-8859-2?Q?DhmosNNEfSEZ6zlHFP3VZfZKXfoNReC8TNl93GwDvSqTPqAmHicMMIkWIC?=
 =?iso-8859-2?Q?zCZK6Efo4OofiOJXWyZK+vJ1A99QCnE+I8RDJbOJYN/GJi/8CPJxs6/iCl?=
 =?iso-8859-2?Q?kY0WWKRlxXOcbhaEAxPo1HiNRMSWk1CpWwyG2XQ365rUxj9UZ/GjYm1TBb?=
 =?iso-8859-2?Q?lyImaLDjneYsYpti4KspFv8eg8rHLpDh91osmcxnYV7dTXcWmWCtFaLCOP?=
 =?iso-8859-2?Q?kACrSUxZpeCDa6kH5soEJwY0Av9RSwkALzIkIkpK9LI/nf+KtCiEssDmtT?=
 =?iso-8859-2?Q?07OrICVarnAzLRyeKF87eh96lJXX65wOF/eae4qeRs9TRP4Ve2X8euDD8Y?=
 =?iso-8859-2?Q?3FyZm3858HDJ1yjdeOFVh6YIoftT70GjaxIURbCYxIOAFMSdffnVoYO5ZS?=
 =?iso-8859-2?Q?X9+oAVqrO+eYSOr7AhYpmHBao4A8IY6wPGq8cPRr3dczeXahZ5G81plex4?=
 =?iso-8859-2?Q?1zoO5yWLS3Z3/9C3fwWeP5TNppsom+cTWcJUpMP/YZPkWTopfa0Yv9flBd?=
 =?iso-8859-2?Q?f1xmf0rRFWmClZ9HYIqnbd1tj0zsyEcK19GZiwNPDCAbEt8aMfvqbGj5Ni?=
 =?iso-8859-2?Q?Dqco/qOWO4jQih8HLWKx95phNFS3yzgs41c1wBxYdefS5wz2U5eqpNRQwH?=
 =?iso-8859-2?Q?ALoTQxPZO4JrRJJyeKjlrevhS8e8/d7zWAa7Nk8aXq0Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?3bt0eX3lvQ7+CNpe+04elBP3arpN1BmLX7M4F+LO9HAB02oqsk7xoU6sYX?=
 =?iso-8859-2?Q?/kzhI0qsBF1E4OTxKJL/smjClIOOb72/Wuloms8bimb+tmrf+wcRXwwbYU?=
 =?iso-8859-2?Q?z5SWnHsRzWjVSVS8SboHfBTyD9fb3SNIznSiIE4jX6+6OKYtZDngY/FLL9?=
 =?iso-8859-2?Q?9TaKCDpcmzBxO/GhoZKtiJNpBV2EFn4XzlzAHDcaba873iQmHTy1+9jUHB?=
 =?iso-8859-2?Q?Up3FKSHckmXeAEHC+lhA+ubZbTP1skXiBGmRq4+7SowrOBvUk5Wdg6+TI9?=
 =?iso-8859-2?Q?cfNNDixQB15vi3INtE3y3rYqMwbB4WV0PomYMPjUujlzdBCoemc0o123dZ?=
 =?iso-8859-2?Q?uRFeitvjKW90IdgRz/r29XJ1w6zLGA2LINqoCMu+2GMor7s+8qET2e/ZTO?=
 =?iso-8859-2?Q?SmJZzQTHYDXE6HLAdkqAJaQ6xiN08PeeQKXtIdv9JrFj1dcUjCam5/ftc3?=
 =?iso-8859-2?Q?yTKQjvhevg+CReiNJ7zR8WyMSy0jM0YsncMihwyA6q9qGsnUl3s4rbAUhz?=
 =?iso-8859-2?Q?ZmLgawyabam/EP7sLM2uV0m92d6vaWsXS37yKgRXSZ2tT8+mFxGXP5c+hN?=
 =?iso-8859-2?Q?u6IHrtnid8s5jCXtnRbOxkFy/aJBN1l9+uinmS1t0d1vAScNy9lLxfzues?=
 =?iso-8859-2?Q?BbGWC1URTtgwyf8VG7xoAGBJTfQoEA/r68/ObRzo5I2t0b7+sTm4XhzBSx?=
 =?iso-8859-2?Q?gx/2laBmEqJJlL9uC9ZlrQhJdRuIsmPHAPzmexlhhR5OkV7z18MqyPLAyk?=
 =?iso-8859-2?Q?Ir4iRiA7/BIjwXXhg35P1UD9QyuY9WM5kL5RqbIVWe9IZ3A5jmOoHrPBWZ?=
 =?iso-8859-2?Q?zgRZEGJRNnjsOA4I7eerCd63k26y6VeKMswpzwci3PHX2H7sBPDX5hjFrI?=
 =?iso-8859-2?Q?IKHBA+FR2Pg4wRNYyVwMPTalUbgliTMAII4GtTNCImUA8vUXfisnJmG4lB?=
 =?iso-8859-2?Q?2/ZwqkL2jWTbCJ+ug30QBgFehdJWNDSTGEBQlb1+hS4/6e5NAmy2czGAkv?=
 =?iso-8859-2?Q?kT0JoP23u0W6h8D5sMAcT2vqmZAasLyIKIxJ3cTYLVWOnjAz02ysifw3pn?=
 =?iso-8859-2?Q?kSDr3140wpdh9aNWenUR8BW6tRHlfmNaAzOtV7kFZPIRP5L15dlWk53mwS?=
 =?iso-8859-2?Q?ZMPDZbvGrayGwN9S+leyEzNH+XrQblhy1ZaTEoIugKrQJFKTnVtGptO1MU?=
 =?iso-8859-2?Q?uyfzbnMduJvTg3RjaIAoXZ8exEHAt9liOcfGdVZlCFqMY0kysSNqI5Q8Pe?=
 =?iso-8859-2?Q?V98sDr3wIJ0cRPDNprd0faDET0mBD/oDP3JtHTKijidkDx1gRj17aJAoN7?=
 =?iso-8859-2?Q?ZJWnD5p7ZH7k53VfuJhZaXGC5JAd50og4SkouT99qqk+q0lzslvUJZV4GP?=
 =?iso-8859-2?Q?ZJuDaDHmsLX1/6cJ92Tqfh5GvCMqNUCIw9qoDZeXzGIpdva5Dawv5B05Fr?=
 =?iso-8859-2?Q?1K3AuljlDazlHmO2U4s/PGkNQ7LCIRe34ZX3Bb49zBD+3D0GR8fJ81BF5K?=
 =?iso-8859-2?Q?YOxjdwIpEPx+Gb4V3jSpQLeTIt4AQ1OYqmn7euqjLNjUAvIjT4D3vRToPX?=
 =?iso-8859-2?Q?yamrmOGJrTvCmjwhz3KDKr2kxk/V?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB092321E4E33CF50011F35A809272ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae04ec4f-92be-49f2-6548-08ddae61dd72
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:15:50.6559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JaD084QZbclq9mh+UXZVmaAjIBu6agoCfRkfCKZCl8tCh9nNGTaOdizbt4emVAQcVpe1XKyHu9kUPIMDvll6zYgmqUcFhVol2aKY5eJLqM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR83MB0851
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB092321E4E33CF50011F35A809272ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello=0A=
=0A=
Sending second version with Signed-off-by header.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From e479be6a67118e70898145d478d0e0b88565f0d1 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 13:16:20 +0200=0A=
Subject: [PATCH v2] Cygwin: fix MALLOC_ALIGNMENT already defined in=0A=
 newlib for AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/local_includes/cygmalloc.h | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/winsup/cygwin/local_includes/cygmalloc.h b/winsup/cygwin/local=
_includes/cygmalloc.h=0A=
index 5e1fe8154..898ea56a5 100644=0A=
--- a/winsup/cygwin/local_includes/cygmalloc.h=0A=
+++ b/winsup/cygwin/local_includes/cygmalloc.h=0A=
@@ -21,7 +21,10 @@ int dlmalloc_trim (size_t);=0A=
 int dlmallopt (int p, int v);=0A=
 void dlmalloc_stats ();=0A=
 =0A=
+// Already defined for AArch64 in newlib/libc/include/sys/config.h=0A=
+#ifndef MALLOC_ALIGNMENT=0A=
 #define MALLOC_ALIGNMENT ((size_t)16U)=0A=
+#endif=0A=
 =0A=
 #if defined (DLMALLOC_VERSION)	/* Building malloc.cc */=0A=
 =0A=
-- =0A=
2.49.0.vfs.0.4=0A=

--_002_DB9PR83MB092321E4E33CF50011F35A809272ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-fix-MALLOC_ALIGNMENT-already-defined-in-newlib-for-AArch64.patch"
Content-Description:
 v2-0001-Cygwin-fix-MALLOC_ALIGNMENT-already-defined-in-newlib-for-AArch64.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-fix-MALLOC_ALIGNMENT-already-defined-in-newlib-for-AArch64.patch";
	size=1053; creation-date="Wed, 18 Jun 2025 12:15:38 GMT";
	modification-date="Wed, 18 Jun 2025 12:15:38 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlNDc5YmU2YTY3MTE4ZTcwODk4MTQ1ZDQ3OGQwZTBiODg1NjVmMGQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEzOjE2OjIwICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQ3lnd2luOiBmaXggTUFMTE9DX0FMSUdOTUVOVCBhbHJl
YWR5IGRlZmluZWQgaW4KIG5ld2xpYiBmb3IgQUFyY2g2NApNSU1FLVZlcnNpb246IDEuMApDb250
ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNv
ZGluZzogOGJpdAoKU2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1p
Y3Jvc29mdC5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWdtYWxsb2Mu
aCB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWdtYWxsb2MuaCBiL3dpbnN1cC9jeWd3aW4v
bG9jYWxfaW5jbHVkZXMvY3lnbWFsbG9jLmgKaW5kZXggNWUxZmU4MTU0Li44OThlYTU2YTUgMTAw
NjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lnbWFsbG9jLmgKKysrIGIv
d2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWdtYWxsb2MuaApAQCAtMjEsNyArMjEsMTAg
QEAgaW50IGRsbWFsbG9jX3RyaW0gKHNpemVfdCk7CiBpbnQgZGxtYWxsb3B0IChpbnQgcCwgaW50
IHYpOwogdm9pZCBkbG1hbGxvY19zdGF0cyAoKTsKIAorLy8gQWxyZWFkeSBkZWZpbmVkIGZvciBB
QXJjaDY0IGluIG5ld2xpYi9saWJjL2luY2x1ZGUvc3lzL2NvbmZpZy5oCisjaWZuZGVmIE1BTExP
Q19BTElHTk1FTlQKICNkZWZpbmUgTUFMTE9DX0FMSUdOTUVOVCAoKHNpemVfdCkxNlUpCisjZW5k
aWYKIAogI2lmIGRlZmluZWQgKERMTUFMTE9DX1ZFUlNJT04pCS8qIEJ1aWxkaW5nIG1hbGxvYy5j
YyAqLwogCi0tIAoyLjQ5LjAudmZzLjAuNAoK

--_002_DB9PR83MB092321E4E33CF50011F35A809272ADB9PR83MB0923EURP_--
