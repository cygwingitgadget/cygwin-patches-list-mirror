Return-Path: <SRS0=5B30=C4=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id BA9E44B99F5C
	for <cygwin-patches@cygwin.com>; Wed, 29 Apr 2026 11:33:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BA9E44B99F5C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BA9E44B99F5C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1777462437; cv=pass;
	b=qVdx2NNIdEKWCXOZUUpgUu8J0RpVugiaqi+4Dsw1DtonSMPg9tWFPLpDqNuSqaXiQZkjHC47r3EgLGtxzsCvC9Rrz83QQ8Lo0H10TgplBgPnUH8/5n2CYEnJzQe8/WoymoWiRfxBK2UN+y+btosjXoysJjPKckQi/MB6VK0Cl0M=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1777462437; c=relaxed/simple;
	bh=0bSgDCc6U25ROo0SBFQtZeIkvU4kn34Q9ZIhFwlQGto=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=OZXPqUTf67eKDhz1YdGU5pKtj8EZSurrcxXzYMP/7/kfEWM3va7ZXX/MUs5uEtC0YZWpY5x3I2tVdPFKltUr235aYmODImC5cw1f9QWLNCXBdWASiwIpOaZEcNCSZmDgDvwdBEZP2BnUDccX8Ub536Lx/LgmlPp0KfIqpqucT08=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA9E44B99F5C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=2nMGgP3r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB5wL/PXLZ+XNIlYiDv03LfuYZYE4wezTBbJu3hAkl0yMBS64kpwOewrqEwr6AaWNFqeSse4fbHRcqfoKS67opAMJ+ssY6Yiol3fLaqO8wXZgWF2cwsTqZcq7Nj7OwNG8teRFlFi1bvw7v9PtySTaJas6Fl9w97sNHWuVPpg2nQ1tHXnzJ03SMKgO07EC5Vn2UAoYVChMvA2WSiGoHI5wtTGaugGmAoNUKfgHgqR7BhQIle+J36w3fw2/C2V20vPW3ktbSU6ltU5fI5gHzNfmJP8IAjdA+PxuDVjUdW3lwK5EeIzAtncN0ZiDcSGHRWVNyHh284jR/VzWDq/KnsnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRixg8QlrBuJpYLJHzIXjwnywbZjdDJXtjyrKE/ufs8=;
 b=XZUwC1roVhqbeQptkP0Hoy13a5D/urtUS9dDh3TXnrgQvWR1gKOU041a77XXCrS9VC4NlC8dznjmvKP7dLwYGV8K9dyse7QquuU/v9iZ4D19yvsdLcMquJcg+hEv6d9GiatAu0ZuWtmQmU+OQP5+ynDzrZ3Fn54K6SZ/HY/+I0wVRxm+sMinTGsliR46KHMuiYsqvkIW3AKsOeHXV/VunDL/0L652Ar/UYdr5cLatoqzvvPn7kJ2GpEz/CeDdO3ZkDofVt1P+NfLPeG7/ePjKmj4sacqnpodepaDtJAxWUfdchJfnyuKlMicQG2y/ORdnccYIAjhjp3XhgOLjfRd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRixg8QlrBuJpYLJHzIXjwnywbZjdDJXtjyrKE/ufs8=;
 b=2nMGgP3rkHz1S7Swqn2cjx/lCRJq58UlzOuaw4NA/woU6YGTqF/oVGE8Hp4TwV7qyK4AMXtgo5aq9HRGeKouTny8S0nh54MN3VM9se9MP02+JtUTc/TfyNvtmR+PxGpO7eduGpgoOcbL/dW4FC00y4owInA5MkvIh5yFsgGefYPUhNboHXrFAbSqJ+ohUneCGmX3s9SBgvEkmSTzgdXIWZRoIPJejUb1tW179JnZM0+igzVMgPK5sidEC7xFPsKjXVjkz6+tqMRPklEChDOvHhEPmxz+zHZw4avA+9+z0qsbt6cnkz0GGxSil8rJoGi6BxaeWZXjq5NiOtI0s78Sdg==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by PNYP287MB5704.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 11:33:43 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 11:33:43 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: Adapt math functions to use 64bit long double on
 aarch64
Thread-Topic: [PATCH] Cygwin: Adapt math functions to use 64bit long double on
 aarch64
Thread-Index: AQHc18vKLfRG2GPoDUW2KZ+O1vbL6Q==
Date: Wed, 29 Apr 2026 11:33:43 +0000
Message-ID:
 <PN0P287MB029594AE234FC6A4B7F6B23A92342@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|PNYP287MB5704:EE_
x-ms-office365-filtering-correlation-id: af05bac5-b5c9-4a8b-21c7-08dea5e32b4f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|1800799024|31052699007|39142699007|376014|366016|55112099003|18002099003|38070700021|8096899003|56012099003|4053099003|13003099007;
x-microsoft-antispam-message-info:
 ZSOHxXYTycmZ6XAJDCbfABpJXOlDzlQqpEJeQaGhWUK409wOHY/FxCq0Hud8aqbzEg0c/dQQjfiJxcfp0M4Gn6Gn9/bFd6LvpzHAmBZai1twXhQlYUfHLwWALSzHXFiAe0mDS/fJEjLh1CurcHeHfY6wdx9d8qPch7q5OvalF4xWih2hoTQmZvTeIynFMnm6ijpTnvdubMdPr+MlraDgp9NOZee48BnchwTYdv6gVat/Aw6G6dy1m/JBE/b+ii/ATPTMaWPiN6Dp+Q1UM0h49ghlHbdb+c5o2P4uTDy0RyVgDTfbE4+DqcRPreLAk+zJ249wUsshtFKQLU4TjJZbhrrCwtQnrm8FdptgB79INDQC/T3LIq9nlOaBC81r8xgLTrgRBDNallV/8lL7MeKOCiu1mIHOC2CHF+h19CiyEf0Nn7+sCNJEYDq6a/1yJ3PIA3xwE3LWACp8tX5t/ft5jEequ2vcA2b9eEoW2wqDG4pvzS3wK8g6EFJhpbDBCOmYc+Ppb0BuixIn0rT2A+UAcNxRZCpyvpVUX3TpPgiqSKHG8wTKp8+gmRAg7HIhW3E3S4pp7yLKrVtkUdfgm4V+hxTKcxdfc8IU7NbgN66c9+T2UFmcjbal9GNoihFE+1ook7YQ4znpmhw8i6Ef/ycZjVBadZvR7DyV27haFIKFzU4mUhFoz/lWQbnnM+kLeHtawB5/M6ugwyW9fC2P4tOpfmS2YKTBRzzrby2ugJF8WHaw8G8bBS1yxnHdJqRFnbe50WZqFelJ+eN1C1mukmYzSYkIYvNxe7Lpe5xQOJnhAIg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(31052699007)(39142699007)(376014)(366016)(55112099003)(18002099003)(38070700021)(8096899003)(56012099003)(4053099003)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AGen1LAFLG08m5JW45NHWqLo5vpxQtK2pOBy6ROTmPCva3uJ7XQUTf7w9l?=
 =?iso-8859-1?Q?ERHLZEM9GcmGgmEB5nKNMriKPGFwHRvG/fdFXj0OGBejlCfbEbpEp/dIVh?=
 =?iso-8859-1?Q?oPmz2ppXgV3V5hInnIcDORgn93AU8+Ol7LzOVMTPJhb7W6VorbCS/8vA/m?=
 =?iso-8859-1?Q?W7VO72FcytUPlXqFSgAF1JhMc6YVQiPGVeLTpYQI6cLQfsjlvMZ077ybC+?=
 =?iso-8859-1?Q?8/OM74JYThwwfxLrJGqG+fmdYmg10obvjo79qW0dKc7QMoBAaB46TMF2BC?=
 =?iso-8859-1?Q?/KKmfTq4ohXL7t5fgTvKjRMO+U2orT9XJIL/P4HMfPmaag6B6EUFn49nJK?=
 =?iso-8859-1?Q?HlfUduDRtIpkHDr1vPEfRSpAeK5n+HFmu70v5BZnWBxUnKPFpQLI3DfpPQ?=
 =?iso-8859-1?Q?kHrxEf6d26oQG1/clVVlSZMgI25KV5l5G+JCetlE97N3tpaUxVu7T7ADPp?=
 =?iso-8859-1?Q?Uxumd/O8He7d22XEu66vAMcpPibG9F5jmggxTTlJZdfLmn98Ql7gRdHJMi?=
 =?iso-8859-1?Q?fECEnuqU0mHchmGxmG4tlTJwxZ46cOyav+x08c2O8RNVpfPyfUGxhds16T?=
 =?iso-8859-1?Q?kReW46bIGVJ7aOPrdbqw0OaT1dGNfbGwGrRhIG/noCCvWzHEmvM00OHvgm?=
 =?iso-8859-1?Q?uhB/6bUNcFIvz8WzMqmRyA/GMe8d1YEIGXJk7XIfClG4yAJBe1nPNC6wVH?=
 =?iso-8859-1?Q?Ydznih5tNfC5n645N/fiC9MjmQMEwt2t/8+PHHOIOkf2DBH0Zy+pXJ4BtX?=
 =?iso-8859-1?Q?+UXauzXwvD0hLhtwM7Z18YrZhQOth698pGSdh1tVenknTjpGhmxWQcoYS6?=
 =?iso-8859-1?Q?hOciSxKMrnwVqPztUegLE2Jx3Whe6nCUGyGHVdoqOqdeuL0kkzNZRVwZ3m?=
 =?iso-8859-1?Q?eSrR976P7RUUKU3xHzQfYxlBuSdBcycT11qpYslFarNrtLEDD8v6m70bcG?=
 =?iso-8859-1?Q?o067eBNfYxfvjyeFM64GW21kUoE+0uwLLumvu3f9O/sWZPbwUsRHVQw46u?=
 =?iso-8859-1?Q?69DfjloDqgyF0CV7AUJIidYBrpAJSUszmR6iaXEeEd6Ejg3TwWP36+fLAb?=
 =?iso-8859-1?Q?+wkr0NyrWK3g7eu1XfrrXmcANQcdHDc/LDbM0N45Uw6gHAeHkOSaSOhUJw?=
 =?iso-8859-1?Q?EaarMIoiGECxIrXFEoo9Iyz+Q4Xb7wWAJ0Ne7xAuOkiYXYToOxdYOtECmM?=
 =?iso-8859-1?Q?pcUUTv21YWWGb4lCBxCou7getrc0wGiVDyLh3YRCa2xafKwAkoBS4nKKWj?=
 =?iso-8859-1?Q?yrRiSkNuI/mXpt8xnw+nXIPnrb3NM3YJpA4iZLADCbeJqHmlFjTvIB+zR9?=
 =?iso-8859-1?Q?nhWU7tbErxpuq9P0GV5EGICAd2VaAqYuxeemm96fjFXqhDRGu85kdVheWY?=
 =?iso-8859-1?Q?Vrj6E9dU2jdhk8/+C0Is+of7kvFRiIhyWD27fwyraNdPGRJt3m60mBbM15?=
 =?iso-8859-1?Q?oS2TF1zz4lMgP5JWeNYkTX+lqFGcL+cP0ULx4qB41iRAozlzIoBPchlzZg?=
 =?iso-8859-1?Q?Fz31OwFPYMajBZ0BmLLNp9VDC3ho3Rjf3dPtAj/VnYUG6O2a3Ck1akD69j?=
 =?iso-8859-1?Q?53KAmKJ9Ob4VD3xxrYaNskWggcvQbawhkMv+5WYp/kXsgZXuKWOIq8dde8?=
 =?iso-8859-1?Q?2Ein8YwNtX2vORfDi5inzkN2pQ78SKHhd7HVm3RVO9ViI51x2MCUK0hnAo?=
 =?iso-8859-1?Q?e8HchJqg6vDGyOpMY5MNva/mLhh0/v+v9wQxxHvlFy+XNjhDk7oeJtLLPc?=
 =?iso-8859-1?Q?siXcYQQGoisn2CibXvMgK4Vx5a+B2bWAWwsC4TtKlfNB0Zc8qCqBVDkhrR?=
 =?iso-8859-1?Q?hsaVANAWGU3PBbTC+iJ+t8FW+Sc00vo=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB029594AE234FC6A4B7F6B23A92342PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af05bac5-b5c9-4a8b-21c7-08dea5e32b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 11:33:43.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrvLi9iINBCHCV58upFKj5VUWNgwCL2HIKEyANT87+A/jRy+a14eMd2rMfBpvSFK24fC6eZQNlOHGnsGWmed0g+zI640O9gZH0N04SdzGKbaDrnXqX9YZCCab9jjCTQz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYP287MB5704
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,KAM_LOTSOFHASH,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB029594AE234FC6A4B7F6B23A92342PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB029594AE234FC6A4B7F6B23A92342PN0P287MB0295INDP_"

--_000_PN0P287MB029594AE234FC6A4B7F6B23A92342PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Corinna,
The previously mentioned changes are not the only ones required. A few addi=
tional files also need to be modified to ensure that Cygwin works correctly=
 on aarch64.
The approach taken is consistent with mingw-w64. mingw-w64 uses the __SIZEO=
F_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__ macro to implement aarch64-specifi=
c code for math functions.
For reference, a similar approach is used in this upstream mingw-w64 commit:
https://github.com/mingw-w64/mingw-w64/commit/dbb60ad07c2983027cd09f0f72215=
05400391caa

Thanks & regards
K Chandru

In-lined patch:
---

 winsup/cygwin/math/acosl.c         |  7 +++++++
 winsup/cygwin/math/asinl.c         |  7 +++++++
 winsup/cygwin/math/atan2l.c        |  7 +++++++
 winsup/cygwin/math/atanl.c         |  8 +++++++-
 winsup/cygwin/math/cephes_mconf.h  |  4 ++--
 winsup/cygwin/math/cosl_internal.S |  5 ++++-
 winsup/cygwin/math/cossin.c        | 17 +++++++++++++++++
 winsup/cygwin/math/exp.def.h       |  8 +++++++-
 winsup/cygwin/math/exp2l.S         |  5 ++++-
 winsup/cygwin/math/expm1.def.h     |  4 ++++
 winsup/cygwin/math/fabsl.c         |  2 +-
 winsup/cygwin/math/fastmath.h      | 29 +++++++++++++++++++++++------
 winsup/cygwin/math/fmodl.c         |  7 +++++++
 winsup/cygwin/math/frexpl.S        | 13 +++++++++----
 winsup/cygwin/math/ilogbl.S        | 13 +++++++++----
 winsup/cygwin/math/internal_logl.S | 13 +++++++++----
 winsup/cygwin/math/ldexpl.c        |  4 ++++
 winsup/cygwin/math/lgammal.c       |  4 ++--
 winsup/cygwin/math/log10l.S        | 17 +++++++++++------
 winsup/cygwin/math/log1pl.S        | 15 +++++++++++----
 winsup/cygwin/math/log2l.S         | 13 +++++++++----
 winsup/cygwin/math/logbl.c         |  4 ++++
 winsup/cygwin/math/lrintl.c        |  2 +-
 winsup/cygwin/math/nextafterl.c    |  4 ++++
 winsup/cygwin/math/pow.def.h       | 12 +++++++++---
 winsup/cygwin/math/remainder.S     | 12 ++++++++----
 winsup/cygwin/math/remainderf.S    | 12 ++++++++----
 winsup/cygwin/math/remainderl.S    | 13 +++++++++----
 winsup/cygwin/math/remquol.S       | 13 +++++++++----
 winsup/cygwin/math/rintl.c         |  2 +-
 winsup/cygwin/math/scalbl.S        | 23 +++++++++++++++++++----
 winsup/cygwin/math/scalbnl.S       | 17 ++++++++++++-----
 winsup/cygwin/math/sinl_internal.S | 13 +++++++++----
 winsup/cygwin/math/sqrt.def.h      |  2 ++
 winsup/cygwin/math/tanl.S          | 13 +++++++++----
 winsup/cygwin/math/truncl.c        |  4 ++--
 36 files changed, 267 insertions(+), 81 deletions(-)

diff --git a/winsup/cygwin/math/acosl.c b/winsup/cygwin/math/acosl.c
index 553d06f75..3c3c8580f 100644
--- a/winsup/cygwin/math/acosl.c
+++ b/winsup/cygwin/math/acosl.c
@@ -3,6 +3,9 @@
  * This file is part of the mingw-w64 runtime package.
  * No warranty is given; refer to the file DISCLAIMER.PD within this packa=
ge.
  */
+
+#include <math.h>
+
 long double acosl (long double x);

 long double acosl (long double x)
@@ -10,6 +13,7 @@ long double acosl (long double x)
   long double res =3D 0.0L;

   /* acosl =3D atanl (sqrtl(1 - x^2) / x) */
+#if defined(__x86_64__)
   asm volatile (
    "fld    %%st\n\t"
    "fmul   %%st(0)\n\t"        /* x^2 */
@@ -19,5 +23,8 @@ long double acosl (long double x)
    "fxch   %%st(1)\n\t"
    "fpatan"
    : "=3Dt" (res) : "0" (x) : "st(1)");
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D atanl (sqrtl(1 - x*x) / x);
+#endif
   return res;
 }
diff --git a/winsup/cygwin/math/asinl.c b/winsup/cygwin/math/asinl.c
index 35df3b5dd..3143f405f 100644
--- a/winsup/cygwin/math/asinl.c
+++ b/winsup/cygwin/math/asinl.c
@@ -10,12 +10,16 @@
  */

 /* asin =3D atan (x / sqrt(1 - x^2)) */
+
+#include <math.h>
+
 long double asinl (long double x);

 long double asinl (long double x)
 {
   long double res =3D 0.0L;

+#if defined(__x86_64__)
   asm volatile (
    "fld    %%st\n\t"
    "fmul   %%st(0)\n\t"            /* x^2 */
@@ -24,5 +28,8 @@ long double asinl (long double x)
    "fsqrt\n\t"             /* sqrt (1 - x^2) */
    "fpatan"
    : "=3Dt" (res) : "0" (x) : "st(1)");
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   res =3D (long double)asin((double)x);
+#endif
   return res;
 }
diff --git a/winsup/cygwin/math/atan2l.c b/winsup/cygwin/math/atan2l.c
index a4300cbf4..4571690b8 100644
--- a/winsup/cygwin/math/atan2l.c
+++ b/winsup/cygwin/math/atan2l.c
@@ -3,12 +3,19 @@
  * This file is part of the mingw-w64 runtime package.
  * No warranty is given; refer to the file DISCLAIMER.PD within this packa=
ge.
  */
+
+#include <math.h>
+
 long double atan2l (long double y, long double x);

 long double
 atan2l (long double y, long double x)
 {
   long double res =3D 0.0L;
+#if defined(__x86_64__)
   asm volatile ("fpatan" : "=3Dt" (res) : "u" (y), "0" (x) : "st(1)");
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D (long double)atan2((double)y, (double)x);
+#endif
   return res;
 }
diff --git a/winsup/cygwin/math/atanl.c b/winsup/cygwin/math/atanl.c
index d289ef08c..eb0fdeb29 100644
--- a/winsup/cygwin/math/atanl.c
+++ b/winsup/cygwin/math/atanl.c
@@ -3,16 +3,22 @@
  * This file is part of the mingw-w64 runtime package.
  * No warranty is given; refer to the file DISCLAIMER.PD within this packa=
ge.
  */
+
+#include <math.h>
+
 long double atanl (long double x);

 long double
 atanl (long double x)
 {
   long double res =3D 0.0L;
-
+#if defined(__x86_64__)
   asm volatile (
        "fld1\n\t"
        "fpatan"
        : "=3Dt" (res) : "0" (x));
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D (long double)atan((double)x);
+#endif
   return res;
 }
diff --git a/winsup/cygwin/math/cephes_mconf.h b/winsup/cygwin/math/cephes_=
mconf.h
index 832fae0df..4941dc64f 100644
--- a/winsup/cygwin/math/cephes_mconf.h
+++ b/winsup/cygwin/math/cephes_mconf.h
@@ -66,7 +66,7 @@ extern double __QNAN;
 #endif

 /*long double*/
-#if defined(__arm__) || defined(_ARM_)
+#if __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
 #define MAXNUML    1.7976931348623158E308
 #define MAXLOGL    7.09782712893383996843E2
 #define MINLOGL    -7.08396418532264106224E2
@@ -84,7 +84,7 @@ extern double __QNAN;
 #define PIL    3.1415926535897932384626L
 #define PIO2L  1.5707963267948966192313L
 #define PIO4L  7.8539816339744830961566E-1L
-#endif /* defined(__arm__) || defined(_ARM_) */
+#endif /* __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__ */

 #define isfinitel isfinite
 #define isinfl isinf
diff --git a/winsup/cygwin/math/cosl_internal.S b/winsup/cygwin/math/cosl_i=
nternal.S
index 3c8f60d14..b63c40e4a 100644
--- a/winsup/cygwin/math/cosl_internal.S
+++ b/winsup/cygwin/math/cosl_internal.S
@@ -34,7 +34,7 @@ __MINGW_USYMBOL(__cosl_internal):
    movq    $0,8(%rcx)
    fstpt (%rcx)
    ret
-#else
+#elif __i386__
    fldt    4(%esp)
    fcos
    fnstsw  %ax
@@ -51,5 +51,8 @@ __MINGW_USYMBOL(__cosl_internal):
    fstp    %st(1)
    fcos
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  cos
+   ret
 #endif

diff --git a/winsup/cygwin/math/cossin.c b/winsup/cygwin/math/cossin.c
index 0095daa66..7363ab7ee 100644
--- a/winsup/cygwin/math/cossin.c
+++ b/winsup/cygwin/math/cossin.c
@@ -4,6 +4,8 @@
  * No warranty is given; refer to the file DISCLAIMER.PD within this packa=
ge.
  */

+  #include <math.h>
+
 void sincos (double __x, double *p_sin, double *p_cos);
 void sincosl (long double __x, long double *p_sin, long double *p_cos);
 void sincosf (float __x, float *p_sin, float *p_cos);
@@ -12,6 +14,7 @@ void sincos (double __x, double *p_sin, double *p_cos)
 {
   long double c, s;

+#if defined(__x86_64__)
   __asm__ __volatile__ ("fsincos\n\t"
     "fnstsw    %%ax\n\t"
     "testl     $0x400, %%eax\n\t"
@@ -26,6 +29,10 @@ void sincos (double __x, double *p_sin, double *p_cos)
     "fstp      %%st(1)\n\t"
     "fsincos\n\t"
     "1:" : "=3Dt" (c), "=3Du" (s) : "0" (__x));
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  s =3D sin(__x);
+  c =3D cos(__x);
+#endif
   *p_sin =3D (double) s;
   *p_cos =3D (double) c;
 }
@@ -34,6 +41,7 @@ void sincosf (float __x, float *p_sin, float *p_cos)
 {
   long double c, s;

+#if defined(__x86_64__)
   __asm__ __volatile__ ("fsincos\n\t"
     "fnstsw    %%ax\n\t"
     "testl     $0x400, %%eax\n\t"
@@ -48,6 +56,10 @@ void sincosf (float __x, float *p_sin, float *p_cos)
     "fstp      %%st(1)\n\t"
     "fsincos\n\t"
     "1:" : "=3Dt" (c), "=3Du" (s) : "0" (__x));
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  s =3D sinf(__x);
+  c =3D cosf(__x);
+#endif
   *p_sin =3D (float) s;
   *p_cos =3D (float) c;
 }
@@ -56,6 +68,7 @@ void sincosl (long double __x, long double *p_sin, long d=
ouble *p_cos)
 {
   long double c, s;

+#if defined(__x86_64__)
   __asm__ __volatile__ ("fsincos\n\t"
     "fnstsw    %%ax\n\t"
     "testl     $0x400, %%eax\n\t"
@@ -70,6 +83,10 @@ void sincosl (long double __x, long double *p_sin, long =
double *p_cos)
     "fstp      %%st(1)\n\t"
     "fsincos\n\t"
     "1:" : "=3Dt" (c), "=3Du" (s) : "0" (__x));
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  s =3D sin((double)__x);
+  c =3D cos((double)__x);
+#endif
   *p_sin =3D s;
   *p_cos =3D c;
 }
diff --git a/winsup/cygwin/math/exp.def.h b/winsup/cygwin/math/exp.def.h
index 3066b745d..a99601338 100644
--- a/winsup/cygwin/math/exp.def.h
+++ b/winsup/cygwin/math/exp.def.h
@@ -52,11 +52,12 @@ static long double
 __expl_internal (long double x)
 {
   long double res =3D 0.0L;
+#if defined(__x86_64__) || defined(__i386__)
   asm volatile (
        "fldl2e\n\t"             /* 1  log2(e)         */
        "fmul %%st(1),%%st\n\t"  /* 1  x log2(e)       */

-#ifdef __x86_64__
+#if defined(__x86_64__)
     "subq $8, %%rsp\n"
     "fnstcw 4(%%rsp)\n"
     "movzwl 4(%%rsp), %%eax\n"
@@ -101,6 +102,11 @@ __expl_internal (long double x)
        "fstp   %%st(1)\n\t"    /* 1  */
        "fstp   %%st(1)\n\t"    /* 0  */
        : "=3Dt" (res) : "0" (x), "m" (c0), "m" (c1) : "ax", "dx");
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  (void)c0;
+  (void)c1;
+  res =3D exp((double)x);
+#endif
   return res;
 }

diff --git a/winsup/cygwin/math/exp2l.S b/winsup/cygwin/math/exp2l.S
index b08d8e40a..deeb70f0b 100644
--- a/winsup/cygwin/math/exp2l.S
+++ b/winsup/cygwin/math/exp2l.S
@@ -53,7 +53,7 @@ __MINGW_USYMBOL(exp2l):
    movq    $0,8(%rcx)
    fstpt   (%rcx)
    ret
-#else
+#elif __i386__
    fldt    4(%esp)
 /* I added the following ugly construct because exp(+-Inf) resulted
    in NaN.  The ugliness results from the bright minds at Intel.
@@ -89,4 +89,7 @@ __MINGW_USYMBOL(exp2l):
    fstp    %st
    fldz                /* Set result to 0.  */
 2: ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  exp2
+   ret
 #endif
diff --git a/winsup/cygwin/math/expm1.def.h b/winsup/cygwin/math/expm1.def.h
index 028211f91..0e2cb6725 100644
--- a/winsup/cygwin/math/expm1.def.h
+++ b/winsup/cygwin/math/expm1.def.h
@@ -65,7 +65,11 @@ __FLT_ABI(expm1) (__FLT_TYPE x)
   if (__FLT_ABI (fabs) (x) < __FLT_LOGE2)
     {
       x /=3D __FLT_LOGE2;
+#if defined(_x86_64__)
       __asm__ __volatile__ ("f2xm1" : "=3Dt" (x) : "0" (x));
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  x =3D exp2(x) - 1.0;
+#endif
       return x;
     }
   return __FLT_ABI (exp) (x) - __FLT_CST (1.0);
diff --git a/winsup/cygwin/math/fabsl.c b/winsup/cygwin/math/fabsl.c
index f3864ea13..2f4f7d5af 100644
--- a/winsup/cygwin/math/fabsl.c
+++ b/winsup/cygwin/math/fabsl.c
@@ -12,7 +12,7 @@ fabsl (long double x)
   long double res =3D 0.0L;
   asm volatile ("fabs;" : "=3Dt" (res) : "0" (x));
   return res;
-#elif defined(__arm__) || defined(_ARM_)
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
   return __builtin_fabsl (x);
 #endif /* defined(__x86_64__) || defined(_AMD64_) || defined(__i386__) || =
defined(_X86_) */
 }
diff --git a/winsup/cygwin/math/fastmath.h b/winsup/cygwin/math/fastmath.h
index eb1846cb3..f6d7f7451 100644
--- a/winsup/cygwin/math/fastmath.h
+++ b/winsup/cygwin/math/fastmath.h
@@ -26,7 +26,11 @@ static __inline__ double __fast_sqrt (double x)
 static __inline__ long double __fast_sqrtl (long double x)
 {
   long double res;
+#if defined(__x86_64__)
   asm __volatile__ ("fsqrt" : "=3Dt" (res) : "0" (x));
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D sqrt((double)x);
+#endif
   return res;
 }

@@ -41,22 +45,30 @@ static __inline__ float __fast_sqrtf (float x)
 static __inline__ double __fast_log (double x)
 {
    double res;
+#if defined(__x86_64__)
    asm __volatile__
      ("fldln2\n\t"
       "fxch\n\t"
       "fyl2x"
        : "=3Dt" (res) : "0" (x) : "st(1)");
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D log(x);
+#endif
    return res;
 }

 static __inline__ long double __fast_logl (long double x)
 {
   long double res;
-   asm __volatile__
-     ("fldln2\n\t"
-      "fxch\n\t"
-      "fyl2x"
-       : "=3Dt" (res) : "0" (x) : "st(1)");
+#if defined(__x86_64__)
+  asm __volatile__
+    ("fldln2\n\t"
+     "fxch\n\t"
+     "fyl2x"
+      : "=3Dt" (res) : "0" (x) : "st(1)");
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D log((double)x);
+#endif
    return res;
 }

@@ -93,12 +105,17 @@ static __inline__ long double __fast_log1pl (long doub=
le x)
   /* fyl2xp1 accurate only for |x| <=3D 1.0 - 0.5 * sqrt (2.0) */
   if (fabsl (x) >=3D 1.0L - 0.5L * 1.41421356237309504880L)
     res =3D __fast_logl (1.0L + x);
-  else
+  else {
+#if defined(__x86_64__)
     asm __volatile__
       ("fldln2\n\t"
        "fxch\n\t"
        "fyl2xp1"
        : "=3Dt" (res) : "0" (x) : "st(1)");
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D log1p((double)x);
+#endif
+   }
    return res;
 }

diff --git a/winsup/cygwin/math/fmodl.c b/winsup/cygwin/math/fmodl.c
index 462b6fa79..52cc3ce04 100644
--- a/winsup/cygwin/math/fmodl.c
+++ b/winsup/cygwin/math/fmodl.c
@@ -3,6 +3,9 @@
  * This file is part of the mingw-w64 runtime package.
  * No warranty is given; refer to the file DISCLAIMER.PD within this packa=
ge.
  */
+
+#include <math.h>
+
 long double fmodl (long double x, long double y);

 long double
@@ -10,6 +13,7 @@ fmodl (long double x, long double y)
 {
   long double res =3D 0.0L;

+#if defined(__x86_64__)
   asm volatile (
        "1:\tfprem\n\t"
        "fstsw   %%ax\n\t"
@@ -17,5 +21,8 @@ fmodl (long double x, long double y)
        "jp      1b\n\t"
        "fstp    %%st(1)"
        : "=3Dt" (res) : "0" (x), "u" (y) : "ax", "st(1)");
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D fmod((double)x, (double)y);
+#endif
   return res;
 }
diff --git a/winsup/cygwin/math/frexpl.S b/winsup/cygwin/math/frexpl.S
index 12782c29e..b3129dcd8 100644
--- a/winsup/cygwin/math/frexpl.S
+++ b/winsup/cygwin/math/frexpl.S
@@ -10,14 +10,14 @@
  * It returns an integer power of two to expnt and the significand
  * between 0.5 and 1 to y.  Thus  x =3D y * 2**expn.
  */
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 2
 #endif
 .globl __MINGW_USYMBOL(frexpl)
 __MINGW_USYMBOL(frexpl):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    pushq %rbp
    movq %rsp,%rbp
    subq $48,%rsp
@@ -72,7 +72,7 @@ L24:
    fstpt   (%r9)
    leave
    ret
-#else
+#elif defined(__i386__)
    pushl %ebp
    movl %esp,%ebp
    subl $24,%esp
@@ -127,4 +127,9 @@ L24:
    popl %esi
    leave
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  frexp
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/ilogbl.S b/winsup/cygwin/math/ilogbl.S
index c75a7d0fd..9aea4e3a7 100644
--- a/winsup/cygwin/math/ilogbl.S
+++ b/winsup/cygwin/math/ilogbl.S
@@ -7,15 +7,15 @@

    .file   "ilogbl.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(ilogbl)
    .def    __MINGW_USYMBOL(ilogbl);    .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(ilogbl):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    fldt    (%rcx)
    fxam            /* Is NaN or +-Inf?  */
    fstsw   %ax
@@ -44,7 +44,7 @@ __MINGW_USYMBOL(ilogbl):
 2: fstp    %st
    movl    $0x80000001, %eax   /* FP_ILOGB0  */
    ret
-#else
+#elif defined(__i386__)
    fldt    4(%esp)
 /* I added the following ugly construct because ilogb(+-Inf) is
    required to return INT_MAX in ISO C99.
@@ -76,4 +76,9 @@ __MINGW_USYMBOL(ilogbl):
 2: fstp    %st
    movl    $0x80000001, %eax   /* FP_ILOGB0  */
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  ilogb
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/internal_logl.S b/winsup/cygwin/math/intern=
al_logl.S
index f8a075774..f57f2731a 100644
--- a/winsup/cygwin/math/internal_logl.S
+++ b/winsup/cygwin/math/internal_logl.S
@@ -7,9 +7,9 @@

    .file   "internal_logl.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 one:   .double 1.0
@@ -21,7 +21,7 @@ limit:    .double 0.29
 .globl __MINGW_USYMBOL(__logl_internal)
    .def    __MINGW_USYMBOL(__logl_internal);   .scl    2;  .type   32; .en=
def
 __MINGW_USYMBOL(__logl_internal):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    fldln2          // log(2)
    fldt    (%rdx)      // x : log(2)
    fld %st     // x : x : log(2)
@@ -45,7 +45,7 @@ __MINGW_USYMBOL(__logl_internal):
    movq    $0,8(%rcx)
    fstpt   (%rcx)
    ret
-#else
+#elif defined(__i386__)
    fldln2          // log(2)
    fldt    4(%esp)     // x : log(2)
    fld %st     // x : x : log(2)
@@ -63,4 +63,9 @@ __MINGW_USYMBOL(__logl_internal):
 2: fstp    %st(0)      // x : log(2)
    fyl2x           // log(x)
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  log
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/ldexpl.c b/winsup/cygwin/math/ldexpl.c
index 2438617c3..a44a3a3b1 100644
--- a/winsup/cygwin/math/ldexpl.c
+++ b/winsup/cygwin/math/ldexpl.c
@@ -12,9 +12,13 @@ long double ldexpl(long double x, int expn)
   if (!isfinite (x) || x =3D=3D 0.0L)
     return x;

+#if defined(__x86_64__) || defined(__i386__)
   __asm__ __volatile__ ("fscale"
        : "=3Dt" (res)
        : "0" (x), "u" ((long double) expn));
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D ldexp((double)x, expn);
+#endif

   if (!isfinite (res) || res =3D=3D 0.0L)
     errno =3D ERANGE;
diff --git a/winsup/cygwin/math/lgammal.c b/winsup/cygwin/math/lgammal.c
index 022a16acf..91d102d57 100644
--- a/winsup/cygwin/math/lgammal.c
+++ b/winsup/cygwin/math/lgammal.c
@@ -198,11 +198,11 @@ static uLD C[] =3D {

 /* log( sqrt( 2*pi ) ) */
 static const long double LS2PI  =3D  0.91893853320467274178L;
-#if defined(__arm__) || defined(_ARM_)
+#if __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
 #define MAXLGM 2.035093e36
 #else
 #define MAXLGM 1.04848146839019521116e+4928L
-#endif /* defined(__arm__) || defined(_ARM_) */
+#endif /* __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__ */

 /* Logarithm of gamma function */
 /* Reentrant version */
diff --git a/winsup/cygwin/math/log10l.S b/winsup/cygwin/math/log10l.S
index 33d45a3a8..3d7df34fc 100644
--- a/winsup/cygwin/math/log10l.S
+++ b/winsup/cygwin/math/log10l.S
@@ -7,9 +7,9 @@

    .file   "log10l.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 one:   .double 1.0
@@ -19,15 +19,15 @@ one:    .double 1.0
 limit: .double 0.29

    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(log10l)
    .def    __MINGW_USYMBOL(log10l);    .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(log10l):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    fldlg2          // log10(2)
    fldt    (%rdx)      // x : log10(2)
    fxam
@@ -63,7 +63,7 @@ __MINGW_USYMBOL(log10l):
    movq    $0,8(%rcx)
    fstpt   (%rcx)
    ret
-#else
+#elif defined(__i386__)
    fldlg2          // log10(2)
    fldt    4(%esp)     // x : log10(2)
    fxam
@@ -90,4 +90,9 @@ __MINGW_USYMBOL(log10l):
    fstp    %st(1)
    fstp    %st(1)
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  log10
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/log1pl.S b/winsup/cygwin/math/log1pl.S
index a56bcf4ec..3193b6092 100644
--- a/winsup/cygwin/math/log1pl.S
+++ b/winsup/cygwin/math/log1pl.S
@@ -12,18 +12,20 @@
       0.29 is a safe value.
     */

+#if defined(__x86_64__) || defined(__i386__)
    /* Only gcc understands the .tfloat type
       The series of .long below represents
       limit:   .tfloat 0.29
     */
    .align 16
+#endif
 limit:
    .long 2920577761
    .long 2491081031
    .long 16381
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
    /* Please note:  we use a double value here.  Since 1.0 has
@@ -38,7 +40,7 @@ one:  .double 1.0
 .globl __MINGW_USYMBOL(log1pl)
    .def    __MINGW_USYMBOL(log1pl);    .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(log1pl):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    fldln2
    fldt    (%rdx)
    fxam
@@ -73,7 +75,7 @@ __MINGW_USYMBOL(log1pl):
    movq    $0,8(%rcx)
    fstpt   (%rcx)
    ret
-#else
+#elif defined(__i386__)
    fldln2
    fldt    4(%esp)
    fxam
@@ -99,4 +101,9 @@ __MINGW_USYMBOL(log1pl):
    fstp    %st(1)
    fstp    %st(1)
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  log1p
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/log2l.S b/winsup/cygwin/math/log2l.S
index 771cd8ae4..337a3d62f 100644
--- a/winsup/cygwin/math/log2l.S
+++ b/winsup/cygwin/math/log2l.S
@@ -7,9 +7,9 @@

    .file   "log2l.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 one:   .double 1.0
@@ -21,7 +21,7 @@ limit:    .double 0.29
 .globl __MINGW_USYMBOL(log2l)
    .def    __MINGW_USYMBOL(log2l); .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(log2l):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    fldl    one(%rip)
    fldt    (%rdx)      // x : 1
    fxam
@@ -57,7 +57,7 @@ __MINGW_USYMBOL(log2l):
    movq    $0,8(%rcx)
    fstpt   (%rcx)
    ret
-#else
+#elif defined(__i386__)
    fldl    one
    fldt    4(%esp)     // x : 1
    fxam
@@ -84,4 +84,9 @@ __MINGW_USYMBOL(log2l):
    fstp    %st(1)
    fstp    %st(1)
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  log2
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/logbl.c b/winsup/cygwin/math/logbl.c
index 5e533c07c..1ee7e57ab 100644
--- a/winsup/cygwin/math/logbl.c
+++ b/winsup/cygwin/math/logbl.c
@@ -16,8 +16,12 @@ logbl (long double x)
 {
   long double res =3D 0.0L;

+#if defined(__x86_64__) || defined(__i386__)
   asm volatile (
        "fxtract\n\t"
        "fstp   %%st" : "=3Dt" (res) : "0" (x));
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  res =3D logb((double)x);
+#endif
   return res;
 }
diff --git a/winsup/cygwin/math/lrintl.c b/winsup/cygwin/math/lrintl.c
index 42f2d3c66..d5e3ac906 100644
--- a/winsup/cygwin/math/lrintl.c
+++ b/winsup/cygwin/math/lrintl.c
@@ -12,7 +12,7 @@ long lrintl (long double x)
   __asm__ __volatile__ ("fistpll %0"  : "=3Dm" (retval) : "t" (x) : "st");
 #elif defined(_AMD64_) || defined(__x86_64__) || defined(_X86_) || defined=
(__i386__)
   __asm__ __volatile__ ("fistpl %0"  : "=3Dm" (retval) : "t" (x) : "st");
-#elif defined(__arm__) || defined(_ARM_)
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
     retval =3D lrint(x);
 #endif
   return retval;
diff --git a/winsup/cygwin/math/nextafterl.c b/winsup/cygwin/math/nextafter=
l.c
index b1e479a95..1ac408dd4 100644
--- a/winsup/cygwin/math/nextafterl.c
+++ b/winsup/cygwin/math/nextafterl.c
@@ -16,6 +16,9 @@
 long double
 nextafterl (long double x, long double y)
 {
+#if __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__ && (LDBL_MANT_DIG =3D=
=3D DBL_MANT_DIG)
+  return (long double) nexttoward (x, y);
+# else
   union {
       long double ld;
       struct {
@@ -63,6 +66,7 @@ nextafterl (long double x, long double y)
     u.parts.mantissa |=3D  normal_bit;

   return u.ld;
+# endif /* __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__ */
 }

 /* nexttowardl is the same function with a different name.  */
diff --git a/winsup/cygwin/math/pow.def.h b/winsup/cygwin/math/pow.def.h
index 2ea825720..bf741561e 100644
--- a/winsup/cygwin/math/pow.def.h
+++ b/winsup/cygwin/math/pow.def.h
@@ -81,7 +81,7 @@ internal_modf (__FLT_TYPE value, __FLT_TYPE *iptr)
   __FLT_TYPE int_part =3D (__FLT_TYPE) 0.0;
   /* truncate */
   /* truncate */
-#ifdef __x86_64__
+#if defined(__x86_64__)
   asm volatile ("pushq %%rax\n\tsubq $8, %%rsp\n"
     "fnstcw 4(%%rsp)\n"
     "movzwl 4(%%rsp), %%eax\n"
@@ -91,7 +91,7 @@ internal_modf (__FLT_TYPE value, __FLT_TYPE *iptr)
     "frndint\n"
     "fldcw 4(%%rsp)\n"
     "addq $8, %%rsp\npopq %%rax" : "=3Dt" (int_part) : "0" (value)); /* ro=
und */
-#else
+#elif defined(__i386__)
   asm volatile ("push %%eax\n\tsubl $8, %%esp\n"
     "fnstcw 4(%%esp)\n"
     "movzwl 4(%%esp), %%eax\n"
@@ -101,6 +101,8 @@ internal_modf (__FLT_TYPE value, __FLT_TYPE *iptr)
     "frndint\n"
     "fldcw 4(%%esp)\n"
     "addl $8, %%esp\n\tpop %%eax\n" : "=3Dt" (int_part) : "0" (value)); /*=
 round */
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  int_part =3D round (value);
 #endif
   if (iptr)
     *iptr =3D int_part;
@@ -204,7 +206,11 @@ __FLT_ABI(pow) (__FLT_TYPE x, __FLT_TYPE y)
    }
       if (y =3D=3D __FLT_CST(0.5))
    {
-     asm volatile ("fsqrt" : "=3Dt" (rslt) : "0" (x));
+      #if defined(__x86_64__) || defined(__i386__)
+          asm volatile ("fsqrt" : "=3Dt" (rslt) : "0" (x));
+      #elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+          asm volatile ("fsqrt %d0, %d1" : "=3Dw" (rslt) : "w" (x));
+      #endif
      return rslt;
    }
     }
diff --git a/winsup/cygwin/math/remainder.S b/winsup/cygwin/math/remainder.S
index 5a713f904..c9d9e2e78 100644
--- a/winsup/cygwin/math/remainder.S
+++ b/winsup/cygwin/math/remainder.S
@@ -7,15 +7,15 @@

    .file   "remainder.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(remainder)
    .def    __MINGW_USYMBOL(remainder); .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(remainder):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    movsd   %xmm0,-16(%rsp)
    movsd   %xmm1,-32(%rsp)
    fldl    -32(%rsp)
@@ -28,7 +28,7 @@ __MINGW_USYMBOL(remainder):
    fstpl   -16(%rsp)
    movsd   -16(%rsp),%xmm0
    ret
-#else
+#elif defined(__i386__)
    fldl    12(%esp)
    fldl    4(%esp)
 1: fprem1
@@ -37,4 +37,8 @@ __MINGW_USYMBOL(remainder):
    jp  1b
    fstp    %st(1)
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   /* AArch64: system libm provides remainder() natively, no stub needed */
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/remainderf.S b/winsup/cygwin/math/remainder=
f.S
index c3a3a3dc5..73d0f6b7a 100644
--- a/winsup/cygwin/math/remainderf.S
+++ b/winsup/cygwin/math/remainderf.S
@@ -7,15 +7,15 @@

    .file   "remainderf.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(remainder)
    .def    __MINGW_USYMBOL(remainderf);    .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(remainderf):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    movss   %xmm1,-12(%rsp)
    flds    -12(%rsp)
    movss   %xmm0,-12(%rsp)
@@ -28,7 +28,7 @@ __MINGW_USYMBOL(remainderf):
    fstps   -12(%rsp)
    movss   -12(%rsp),%xmm0
    ret
-#else
+#elif defined(__i386__)
    flds    8(%esp)
    flds    4(%esp)
 1: fprem1
@@ -37,4 +37,8 @@ __MINGW_USYMBOL(remainderf):
    jp  1b
    fstp    %st(1)
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   /* AArch64: system libm provides remainderf() natively, no stub needed =
*/
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/remainderl.S b/winsup/cygwin/math/remainder=
l.S
index a69e38296..f05724e94 100644
--- a/winsup/cygwin/math/remainderl.S
+++ b/winsup/cygwin/math/remainderl.S
@@ -7,15 +7,15 @@

    .file   "remainderl.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(remainderl)
    .def    __MINGW_USYMBOL(remainderl);    .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(remainderl):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    fldt    (%r8)
    fldt    (%rdx)
 1: fprem1
@@ -27,7 +27,7 @@ __MINGW_USYMBOL(remainderl):
    movq    $0,8(%rcx)
    fstpt   (%rcx)
    ret
-#else
+#elif defined(__i386__)
    fldt    16(%esp)
    fldt    4(%esp)
 1: fprem1
@@ -36,4 +36,9 @@ __MINGW_USYMBOL(remainderl):
    jp  1b
    fstp    %st(1)
    ret
+#elif _defined(__aarch64__)
+   bl  remainder
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/remquol.S b/winsup/cygwin/math/remquol.S
index e16df8ad2..34041dc12 100644
--- a/winsup/cygwin/math/remquol.S
+++ b/winsup/cygwin/math/remquol.S
@@ -7,14 +7,14 @@

    .file   "remquol.S"
         .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(remquol)
 __MINGW_USYMBOL(remquol):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    pushq   %rcx
         fldt (%r8)
         fldt (%rdx)
@@ -45,7 +45,7 @@ __MINGW_USYMBOL(remquol):
    movq    $0,8(%rcx)
    fstpt   (%rcx)
         ret
-#else
+#elif defined(__i386__)
         fldt 4 +12(%esp)
         fldt 4(%esp)
 1: fprem1
@@ -72,4 +72,9 @@ __MINGW_USYMBOL(remquol):
 1: movl %eax, (%ecx)

         ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  remquo
+        ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/rintl.c b/winsup/cygwin/math/rintl.c
index 9ec159d17..f9ca15f31 100644
--- a/winsup/cygwin/math/rintl.c
+++ b/winsup/cygwin/math/rintl.c
@@ -9,7 +9,7 @@ long double rintl (long double x) {
   long double retval =3D 0.0L;
 #if defined(_AMD64_) || defined(__x86_64__) || defined(_X86_) || defined(_=
_i386__)
   __asm__ __volatile__ ("frndint;": "=3Dt" (retval) : "0" (x));
-#elif defined(__arm__) || defined(_ARM_)
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
     retval =3D rint(x);
 #endif
   return retval;
diff --git a/winsup/cygwin/math/scalbl.S b/winsup/cygwin/math/scalbl.S
index f9675ac4b..ca66c6dfa 100644
--- a/winsup/cygwin/math/scalbl.S
+++ b/winsup/cygwin/math/scalbl.S
@@ -7,15 +7,15 @@

    .file   "scalbl.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(scalbl)
    .def    __MINGW_USYMBOL(scalbl);    .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(scalbl):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    subq  $24, %rsp
    fldt    (%r8)
    fldt    (%rdx)
@@ -26,10 +26,25 @@ __MINGW_USYMBOL(scalbl):
    fstpt   (%rcx)
    addq $24, %rsp
    ret
-#else
+#elif defined(__i386__)
    fildl   16(%esp)
    fldt    4(%esp)
    fscale
    fstp    %st(1)
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+    fcvtzs x1, d1
+    fmov x0, d0
+    ubfx x2, x0, #52, #11
+    add x2, x2, x1
+    cmp x2, #0
+    csel x2, xzr, x2, lt
+    mov x3, #0x7FF
+    cmp x2, x3
+    csel x2, x2, x3, lt
+    bfi x0, x2, #52, #11
+    fmov d0, x0
+    ret
+#else
+   .error "unimplemented for this target yet"
 #endif
diff --git a/winsup/cygwin/math/scalbnl.S b/winsup/cygwin/math/scalbnl.S
index 5ff0a68f3..96e57e77c 100644
--- a/winsup/cygwin/math/scalbnl.S
+++ b/winsup/cygwin/math/scalbnl.S
@@ -7,15 +7,15 @@

    .file   "scalbnl.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(scalbnl)
    .def    __MINGW_USYMBOL(scalbnl);   .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(scalbnl):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    subq  $24, %rsp
    andl    $-1, %r8d
    movq    %r8, (%rsp)
@@ -28,14 +28,21 @@ __MINGW_USYMBOL(scalbnl):
    fstpt   (%rcx)
    addq $24, %rsp
    ret
-#else
+#elif defined(__i386__)
    fildl   16(%esp)
    fldt    4(%esp)
    fscale
    fstp    %st(1)
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   scvtf d1, w1
+   fmov d2, #2.0
+   bl pow
+   fmul d0, d0, d1
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif

 .globl __MINGW_USYMBOL(scalblnl)
    .set    __MINGW_USYMBOL(scalblnl),__MINGW_USYMBOL(scalbnl)
-
diff --git a/winsup/cygwin/math/sinl_internal.S b/winsup/cygwin/math/sinl_i=
nternal.S
index 6d766b098..9def0ac0e 100644
--- a/winsup/cygwin/math/sinl_internal.S
+++ b/winsup/cygwin/math/sinl_internal.S
@@ -7,15 +7,15 @@

    .file   "sinl_internal.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(__sinl_internal)
    .def    __MINGW_USYMBOL(__sinl_internal);   .scl    2;  .type   32; .en=
def
 __MINGW_USYMBOL(__sinl_internal):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    fldt    (%rdx)
    fsin
    fnstsw  %ax
@@ -38,7 +38,7 @@ __MINGW_USYMBOL(__sinl_internal):
    movq    $0,8(%rcx)
    fstpt   (%rcx)
    ret
-#else
+#elif defined(__i386__)
    fldt    4(%esp)
    fsin
    fnstsw  %ax
@@ -55,4 +55,9 @@ __MINGW_USYMBOL(__sinl_internal):
    fstp    %st(1)
    fsin
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  sin
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/sqrt.def.h b/winsup/cygwin/math/sqrt.def.h
index 3d1a00908..e3fbba81a 100644
--- a/winsup/cygwin/math/sqrt.def.h
+++ b/winsup/cygwin/math/sqrt.def.h
@@ -89,6 +89,8 @@ __FLT_ABI (sqrt) (__FLT_TYPE x)
   __fsqrt_internal(x);
 #elif defined(_X86_) || defined(__i386__) || defined(_AMD64_) || defined(_=
_x86_64__)
   asm volatile ("fsqrt" : "=3Dt" (res) : "0" (x));
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+  asm volatile ("fsqrt %d0, %d1" : "=3Dw"(res) : "w"(x));
 #else
 #error Not supported on your platform yet
 #endif
diff --git a/winsup/cygwin/math/tanl.S b/winsup/cygwin/math/tanl.S
index f11b53920..7b62dabad 100644
--- a/winsup/cygwin/math/tanl.S
+++ b/winsup/cygwin/math/tanl.S
@@ -7,15 +7,15 @@

    .file   "tanl.S"
    .text
-#ifdef __x86_64__
+#if defined(__x86_64__)
    .align 8
-#else
+#elif defined(__i386__)
    .align 4
 #endif
 .globl __MINGW_USYMBOL(tanl)
    .def    __MINGW_USYMBOL(tanl);  .scl    2;  .type   32; .endef
 __MINGW_USYMBOL(tanl):
-#ifdef __x86_64__
+#if defined(__x86_64__)
    fldt    (%rdx)
    fptan
    fnstsw  %ax
@@ -40,7 +40,7 @@ __MINGW_USYMBOL(tanl):
    movq    $0,8(%rcx)
    fstpt   (%rcx)
    ret
-#else
+#elif defined(__i386__)
    fldt    4(%esp)
    fptan
    fnstsw  %ax
@@ -59,4 +59,9 @@ __MINGW_USYMBOL(tanl):
    fptan
    fstp    %st(0)
    ret
+#elif __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
+   bl  tan
+   ret
+#else
+   .error "Not supported on your platform yet"
 #endif
diff --git a/winsup/cygwin/math/truncl.c b/winsup/cygwin/math/truncl.c
index 9380f9571..86e71d108 100644
--- a/winsup/cygwin/math/truncl.c
+++ b/winsup/cygwin/math/truncl.c
@@ -13,7 +13,7 @@
 long double
 truncl (long double _x)
 {
-#if defined(_ARM_) || defined(__arm__)
+#if __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__
   return trunc(_x);
 #else
   long double retval =3D 0.0L;
@@ -26,5 +26,5 @@ truncl (long double _x)
   __asm__ __volatile__ ("frndint;" : "=3Dt" (retval)  : "0" (_x)); /* roun=
d towards zero */
   __asm__ __volatile__ ("fldcw %0;" : : "m" (saved_cw) ); /* restore saved=
 control word */
   return retval;
-#endif /* defined(_ARM_) || defined(__arm__) */
+#endif /* __SIZEOF_LONG_DOUBLE__ =3D=3D __SIZEOF_DOUBLE__ */
 }
--
2.49.0.windows.1


--_000_PN0P287MB029594AE234FC6A4B7F6B23A92342PN0P287MB0295INDP_--

--_004_PN0P287MB029594AE234FC6A4B7F6B23A92342PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-Adapt-math-functions-to-use-64bit-long-double.patch"
Content-Description:
 Cygwin-Adapt-math-functions-to-use-64bit-long-double.patch
Content-Disposition: attachment;
	filename="Cygwin-Adapt-math-functions-to-use-64bit-long-double.patch";
	size=34959; creation-date="Wed, 29 Apr 2026 11:33:30 GMT";
	modification-date="Wed, 29 Apr 2026 11:33:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5M2NjZjQyM2Y1NGJjOWYxYTI0YmI1MGNkMGE2M2FlYTNmZWFhNmIy
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Q2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IFdlZCwgMjkgQXByIDIwMjYgMTU6MzQ6MjAgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBDeWd3aW46IEFkYXB0IG1hdGggZnVuY3Rpb25zIHRvIHVzZSA2NGJp
dCBsb25nIGRvdWJsZSBvbiAKIGFhcmNoNjQKCk1hbnkgbG9uZyBkb3VibGUg
bWF0aCBmdW5jdGlvbnMgY3VycmVudGx5IHJlbHkgb24geDg3LXNwZWNpZmlj
CmFzc2VtYmx5IGFuZCBhc3N1bWUgZXh0ZW5kZWQgcHJlY2lzaW9uLCB3aGlj
aCBicmVha3Mgb24gdGFyZ2V0cwp3aGVyZSBsb25nIGRvdWJsZSBpcyB0aGUg
c2FtZSBhcyBkb3VibGUgKGUuZy4gYWFyY2g2NCkuClVzZSBfX1NJWkVPRl9M
T05HX0RPVUJMRV9fID09IF9fU0laRU9GX0RPVUJMRV9fIHRvIGRldGVjdCBz
dWNoCnRhcmdldHMgYW5kIHByb3ZpZGUgZmFsbGJhY2sgaW1wbGVtZW50YXRp
b25zIHRoYXQgY2FsbCB0aGUKY29ycmVzcG9uZGluZyBkb3VibGUgZnVuY3Rp
b25zLgpBbHNvIGd1YXJkIHg4NyBhc3NlbWJseSB3aXRoIHg4Ni94ODZfNjQg
Y2hlY2tzIGFuZCBmaXggbWlzc2luZwppbmNsdWRlcy4KVGhpcyBtYWtlcyB0
aGUgbWF0aCBjb2RlIHBvcnRhYmxlIHdoaWxlIGtlZXBpbmcgZXhpc3Rpbmcg
eDg2Cm9wdGltaXphdGlvbnMgdW5jaGFuZ2VkLgoKU2lnbmVkLW9mZi1ieTog
TWFydGluIFZlamJvcmEgPG1hcnRpbi52ZWpib3JhQG1pY3Jvc29mdC5jb20+
ClNpZ25lZC1vZmYtYnk6IFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhpcnVt
YWxhaS5uYWdhbGluZ2FtQG11bHRpY29yZXdhcmVpbmMuY29tPgpTaWduZWQt
b2ZmLWJ5OiBjaGFuZHJ1LW1jdyA8Q2hhbmRydS5rdW1hcmVzYW5AbXVsdGlj
b3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9tYXRoL2Fjb3Ns
LmMgICAgICAgICB8ICA3ICsrKysrKysKIHdpbnN1cC9jeWd3aW4vbWF0aC9h
c2lubC5jICAgICAgICAgfCAgNyArKysrKysrCiB3aW5zdXAvY3lnd2luL21h
dGgvYXRhbjJsLmMgICAgICAgIHwgIDcgKysrKysrKwogd2luc3VwL2N5Z3dp
bi9tYXRoL2F0YW5sLmMgICAgICAgICB8ICA4ICsrKysrKystCiB3aW5zdXAv
Y3lnd2luL21hdGgvY2VwaGVzX21jb25mLmggIHwgIDQgKystLQogd2luc3Vw
L2N5Z3dpbi9tYXRoL2Nvc2xfaW50ZXJuYWwuUyB8ICA1ICsrKystCiB3aW5z
dXAvY3lnd2luL21hdGgvY29zc2luLmMgICAgICAgIHwgMTcgKysrKysrKysr
KysrKysrKysKIHdpbnN1cC9jeWd3aW4vbWF0aC9leHAuZGVmLmggICAgICAg
fCAgOCArKysrKysrLQogd2luc3VwL2N5Z3dpbi9tYXRoL2V4cDJsLlMgICAg
ICAgICB8ICA1ICsrKystCiB3aW5zdXAvY3lnd2luL21hdGgvZXhwbTEuZGVm
LmggICAgIHwgIDQgKysrKwogd2luc3VwL2N5Z3dpbi9tYXRoL2ZhYnNsLmMg
ICAgICAgICB8ICAyICstCiB3aW5zdXAvY3lnd2luL21hdGgvZmFzdG1hdGgu
aCAgICAgIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KIHdp
bnN1cC9jeWd3aW4vbWF0aC9mbW9kbC5jICAgICAgICAgfCAgNyArKysrKysr
CiB3aW5zdXAvY3lnd2luL21hdGgvZnJleHBsLlMgICAgICAgIHwgMTMgKysr
KysrKysrLS0tLQogd2luc3VwL2N5Z3dpbi9tYXRoL2lsb2dibC5TICAgICAg
ICB8IDEzICsrKysrKysrKy0tLS0KIHdpbnN1cC9jeWd3aW4vbWF0aC9pbnRl
cm5hbF9sb2dsLlMgfCAxMyArKysrKysrKystLS0tCiB3aW5zdXAvY3lnd2lu
L21hdGgvbGRleHBsLmMgICAgICAgIHwgIDQgKysrKwogd2luc3VwL2N5Z3dp
bi9tYXRoL2xnYW1tYWwuYyAgICAgICB8ICA0ICsrLS0KIHdpbnN1cC9jeWd3
aW4vbWF0aC9sb2cxMGwuUyAgICAgICAgfCAxNyArKysrKysrKysrKy0tLS0t
LQogd2luc3VwL2N5Z3dpbi9tYXRoL2xvZzFwbC5TICAgICAgICB8IDE1ICsr
KysrKysrKysrLS0tLQogd2luc3VwL2N5Z3dpbi9tYXRoL2xvZzJsLlMgICAg
ICAgICB8IDEzICsrKysrKysrKy0tLS0KIHdpbnN1cC9jeWd3aW4vbWF0aC9s
b2dibC5jICAgICAgICAgfCAgNCArKysrCiB3aW5zdXAvY3lnd2luL21hdGgv
bHJpbnRsLmMgICAgICAgIHwgIDIgKy0KIHdpbnN1cC9jeWd3aW4vbWF0aC9u
ZXh0YWZ0ZXJsLmMgICAgfCAgNCArKysrCiB3aW5zdXAvY3lnd2luL21hdGgv
cG93LmRlZi5oICAgICAgIHwgMTIgKysrKysrKysrLS0tCiB3aW5zdXAvY3ln
d2luL21hdGgvcmVtYWluZGVyLlMgICAgIHwgMTIgKysrKysrKystLS0tCiB3
aW5zdXAvY3lnd2luL21hdGgvcmVtYWluZGVyZi5TICAgIHwgMTIgKysrKysr
KystLS0tCiB3aW5zdXAvY3lnd2luL21hdGgvcmVtYWluZGVybC5TICAgIHwg
MTMgKysrKysrKysrLS0tLQogd2luc3VwL2N5Z3dpbi9tYXRoL3JlbXF1b2wu
UyAgICAgICB8IDEzICsrKysrKysrKy0tLS0KIHdpbnN1cC9jeWd3aW4vbWF0
aC9yaW50bC5jICAgICAgICAgfCAgMiArLQogd2luc3VwL2N5Z3dpbi9tYXRo
L3NjYWxibC5TICAgICAgICB8IDIzICsrKysrKysrKysrKysrKysrKystLS0t
CiB3aW5zdXAvY3lnd2luL21hdGgvc2NhbGJubC5TICAgICAgIHwgMTcgKysr
KysrKysrKysrLS0tLS0KIHdpbnN1cC9jeWd3aW4vbWF0aC9zaW5sX2ludGVy
bmFsLlMgfCAxMyArKysrKysrKystLS0tCiB3aW5zdXAvY3lnd2luL21hdGgv
c3FydC5kZWYuaCAgICAgIHwgIDIgKysKIHdpbnN1cC9jeWd3aW4vbWF0aC90
YW5sLlMgICAgICAgICAgfCAxMyArKysrKysrKystLS0tCiB3aW5zdXAvY3ln
d2luL21hdGgvdHJ1bmNsLmMgICAgICAgIHwgIDQgKystLQogMzYgZmlsZXMg
Y2hhbmdlZCwgMjY3IGluc2VydGlvbnMoKyksIDgxIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9hY29zbC5jIGIvd2lu
c3VwL2N5Z3dpbi9tYXRoL2Fjb3NsLmMKaW5kZXggNTUzZDA2Zjc1Li4zYzNj
ODU4MGYgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbWF0aC9hY29zbC5j
CisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9hY29zbC5jCkBAIC0zLDYgKzMs
OSBAQAogICogVGhpcyBmaWxlIGlzIHBhcnQgb2YgdGhlIG1pbmd3LXc2NCBy
dW50aW1lIHBhY2thZ2UuCiAgKiBObyB3YXJyYW50eSBpcyBnaXZlbjsgcmVm
ZXIgdG8gdGhlIGZpbGUgRElTQ0xBSU1FUi5QRCB3aXRoaW4gdGhpcyBwYWNr
YWdlLgogICovCisKKyNpbmNsdWRlIDxtYXRoLmg+CisKIGxvbmcgZG91Ymxl
IGFjb3NsIChsb25nIGRvdWJsZSB4KTsKIAogbG9uZyBkb3VibGUgYWNvc2wg
KGxvbmcgZG91YmxlIHgpCkBAIC0xMCw2ICsxMyw3IEBAIGxvbmcgZG91Ymxl
IGFjb3NsIChsb25nIGRvdWJsZSB4KQogICBsb25nIGRvdWJsZSByZXMgPSAw
LjBMOwogCiAgIC8qIGFjb3NsID0gYXRhbmwgKHNxcnRsKDEgLSB4XjIpIC8g
eCkgKi8KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAgIGFzbSB2b2xhdGls
ZSAoCiAJImZsZAklJXN0XG5cdCIKIAkiZm11bAklJXN0KDApXG5cdCIJCS8q
IHheMiAqLwpAQCAtMTksNSArMjMsOCBAQCBsb25nIGRvdWJsZSBhY29zbCAo
bG9uZyBkb3VibGUgeCkKIAkiZnhjaAklJXN0KDEpXG5cdCIKIAkiZnBhdGFu
IgogCTogIj10IiAocmVzKSA6ICIwIiAoeCkgOiAic3QoMSkiKTsKKyNlbGlm
IF9fU0laRU9GX0xPTkdfRE9VQkxFX18gPT0gX19TSVpFT0ZfRE9VQkxFX18K
KyAgcmVzID0gYXRhbmwgKHNxcnRsKDEgLSB4KngpIC8geCk7CisjZW5kaWYK
ICAgcmV0dXJuIHJlczsKIH0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
bWF0aC9hc2lubC5jIGIvd2luc3VwL2N5Z3dpbi9tYXRoL2FzaW5sLmMKaW5k
ZXggMzVkZjNiNWRkLi4zMTQzZjQwNWYgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9j
eWd3aW4vbWF0aC9hc2lubC5jCisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9h
c2lubC5jCkBAIC0xMCwxMiArMTAsMTYgQEAKICAqLwogCiAvKiBhc2luID0g
YXRhbiAoeCAvIHNxcnQoMSAtIHheMikpICovCisKKyNpbmNsdWRlIDxtYXRo
Lmg+CisKIGxvbmcgZG91YmxlIGFzaW5sIChsb25nIGRvdWJsZSB4KTsKIAog
bG9uZyBkb3VibGUgYXNpbmwgKGxvbmcgZG91YmxlIHgpCiB7CiAgIGxvbmcg
ZG91YmxlIHJlcyA9IDAuMEw7CiAKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18p
CiAgIGFzbSB2b2xhdGlsZSAoCiAJImZsZAklJXN0XG5cdCIKIAkiZm11bAkl
JXN0KDApXG5cdCIJCQkvKiB4XjIgKi8KQEAgLTI0LDUgKzI4LDggQEAgbG9u
ZyBkb3VibGUgYXNpbmwgKGxvbmcgZG91YmxlIHgpCiAJImZzcXJ0XG5cdCIJ
CQkJLyogc3FydCAoMSAtIHheMikgKi8KIAkiZnBhdGFuIgogCTogIj10IiAo
cmVzKSA6ICIwIiAoeCkgOiAic3QoMSkiKTsKKyNlbGlmIF9fU0laRU9GX0xP
TkdfRE9VQkxFX18gPT0gX19TSVpFT0ZfRE9VQkxFX18KKwlyZXMgPSAobG9u
ZyBkb3VibGUpYXNpbigoZG91YmxlKXgpOworI2VuZGlmCiAgIHJldHVybiBy
ZXM7CiB9CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL21hdGgvYXRhbjJs
LmMgYi93aW5zdXAvY3lnd2luL21hdGgvYXRhbjJsLmMKaW5kZXggYTQzMDBj
YmY0Li40NTcxNjkwYjggMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbWF0
aC9hdGFuMmwuYworKysgYi93aW5zdXAvY3lnd2luL21hdGgvYXRhbjJsLmMK
QEAgLTMsMTIgKzMsMTkgQEAKICAqIFRoaXMgZmlsZSBpcyBwYXJ0IG9mIHRo
ZSBtaW5ndy13NjQgcnVudGltZSBwYWNrYWdlLgogICogTm8gd2FycmFudHkg
aXMgZ2l2ZW47IHJlZmVyIHRvIHRoZSBmaWxlIERJU0NMQUlNRVIuUEQgd2l0
aGluIHRoaXMgcGFja2FnZS4KICAqLworCisjaW5jbHVkZSA8bWF0aC5oPgor
CiBsb25nIGRvdWJsZSBhdGFuMmwgKGxvbmcgZG91YmxlIHksIGxvbmcgZG91
YmxlIHgpOwogCiBsb25nIGRvdWJsZQogYXRhbjJsIChsb25nIGRvdWJsZSB5
LCBsb25nIGRvdWJsZSB4KQogewogICBsb25nIGRvdWJsZSByZXMgPSAwLjBM
OworI2lmIGRlZmluZWQoX194ODZfNjRfXykKICAgYXNtIHZvbGF0aWxlICgi
ZnBhdGFuIiA6ICI9dCIgKHJlcykgOiAidSIgKHkpLCAiMCIgKHgpIDogInN0
KDEpIik7CisjZWxpZiBfX1NJWkVPRl9MT05HX0RPVUJMRV9fID09IF9fU0la
RU9GX0RPVUJMRV9fCisgIHJlcyA9IChsb25nIGRvdWJsZSlhdGFuMigoZG91
YmxlKXksIChkb3VibGUpeCk7CisjZW5kaWYKICAgcmV0dXJuIHJlczsKIH0K
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9hdGFubC5jIGIvd2lu
c3VwL2N5Z3dpbi9tYXRoL2F0YW5sLmMKaW5kZXggZDI4OWVmMDhjLi5lYjBm
ZGViMjkgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbWF0aC9hdGFubC5j
CisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9hdGFubC5jCkBAIC0zLDE2ICsz
LDIyIEBACiAgKiBUaGlzIGZpbGUgaXMgcGFydCBvZiB0aGUgbWluZ3ctdzY0
IHJ1bnRpbWUgcGFja2FnZS4KICAqIE5vIHdhcnJhbnR5IGlzIGdpdmVuOyBy
ZWZlciB0byB0aGUgZmlsZSBESVNDTEFJTUVSLlBEIHdpdGhpbiB0aGlzIHBh
Y2thZ2UuCiAgKi8KKworI2luY2x1ZGUgPG1hdGguaD4KKwogbG9uZyBkb3Vi
bGUgYXRhbmwgKGxvbmcgZG91YmxlIHgpOwogCiBsb25nIGRvdWJsZQogYXRh
bmwgKGxvbmcgZG91YmxlIHgpCiB7CiAgIGxvbmcgZG91YmxlIHJlcyA9IDAu
MEw7Ci0KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAgIGFzbSB2b2xhdGls
ZSAoCiAgICAgICAgImZsZDFcblx0IgogICAgICAgICJmcGF0YW4iCiAgICAg
ICAgOiAiPXQiIChyZXMpIDogIjAiICh4KSk7CisjZWxpZiBfX1NJWkVPRl9M
T05HX0RPVUJMRV9fID09IF9fU0laRU9GX0RPVUJMRV9fCisgIHJlcyA9IChs
b25nIGRvdWJsZSlhdGFuKChkb3VibGUpeCk7CisjZW5kaWYKICAgcmV0dXJu
IHJlczsKIH0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9jZXBo
ZXNfbWNvbmYuaCBiL3dpbnN1cC9jeWd3aW4vbWF0aC9jZXBoZXNfbWNvbmYu
aAppbmRleCA4MzJmYWUwZGYuLjQ5NDFkYzY0ZiAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9tYXRoL2NlcGhlc19tY29uZi5oCisrKyBiL3dpbnN1cC9j
eWd3aW4vbWF0aC9jZXBoZXNfbWNvbmYuaApAQCAtNjYsNyArNjYsNyBAQCBl
eHRlcm4gZG91YmxlIF9fUU5BTjsKICNlbmRpZgogCiAvKmxvbmcgZG91Ymxl
Ki8KLSNpZiBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX0FSTV8pCisj
aWYgX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVf
XwogI2RlZmluZSBNQVhOVU1MCTEuNzk3NjkzMTM0ODYyMzE1OEUzMDgKICNk
ZWZpbmUgTUFYTE9HTAk3LjA5NzgyNzEyODkzMzgzOTk2ODQzRTIKICNkZWZp
bmUgTUlOTE9HTAktNy4wODM5NjQxODUzMjI2NDEwNjIyNEUyCkBAIC04NCw3
ICs4NCw3IEBAIGV4dGVybiBkb3VibGUgX19RTkFOOwogI2RlZmluZSBQSUwJ
My4xNDE1OTI2NTM1ODk3OTMyMzg0NjI2TAogI2RlZmluZSBQSU8yTAkxLjU3
MDc5NjMyNjc5NDg5NjYxOTIzMTNMCiAjZGVmaW5lIFBJTzRMCTcuODUzOTgx
NjMzOTc0NDgzMDk2MTU2NkUtMUwKLSNlbmRpZiAvKiBkZWZpbmVkKF9fYXJt
X18pIHx8IGRlZmluZWQoX0FSTV8pICovCisjZW5kaWYgLyogX19TSVpFT0Zf
TE9OR19ET1VCTEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVfXyAqLwogCiAjZGVm
aW5lIGlzZmluaXRlbCBpc2Zpbml0ZQogI2RlZmluZSBpc2luZmwgaXNpbmYK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9jb3NsX2ludGVybmFs
LlMgYi93aW5zdXAvY3lnd2luL21hdGgvY29zbF9pbnRlcm5hbC5TCmluZGV4
IDNjOGY2MGQxNC4uYjYzYzQwZTRhIDEwMDY0NAotLS0gYS93aW5zdXAvY3ln
d2luL21hdGgvY29zbF9pbnRlcm5hbC5TCisrKyBiL3dpbnN1cC9jeWd3aW4v
bWF0aC9jb3NsX2ludGVybmFsLlMKQEAgLTM0LDcgKzM0LDcgQEAgX19NSU5H
V19VU1lNQk9MKF9fY29zbF9pbnRlcm5hbCk6CiAJbW92cQkkMCw4KCVyY3gp
CiAJZnN0cHQgKCVyY3gpCiAJcmV0Ci0jZWxzZQorI2VsaWYgX19pMzg2X18K
IAlmbGR0CTQoJWVzcCkKIAlmY29zCiAJZm5zdHN3CSVheApAQCAtNTEsNSAr
NTEsOCBAQCBfX01JTkdXX1VTWU1CT0woX19jb3NsX2ludGVybmFsKToKIAlm
c3RwCSVzdCgxKQogCWZjb3MKIAlyZXQKKyNlbGlmIF9fU0laRU9GX0xPTkdf
RE9VQkxFX18gPT0gX19TSVpFT0ZfRE9VQkxFX18KKwlibAljb3MKKwlyZXQK
ICNlbmRpZgogCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL21hdGgvY29z
c2luLmMgYi93aW5zdXAvY3lnd2luL21hdGgvY29zc2luLmMKaW5kZXggMDA5
NWRhYTY2Li43MzYzYWI3ZWUgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4v
bWF0aC9jb3NzaW4uYworKysgYi93aW5zdXAvY3lnd2luL21hdGgvY29zc2lu
LmMKQEAgLTQsNiArNCw4IEBACiAgKiBObyB3YXJyYW50eSBpcyBnaXZlbjsg
cmVmZXIgdG8gdGhlIGZpbGUgRElTQ0xBSU1FUi5QRCB3aXRoaW4gdGhpcyBw
YWNrYWdlLgogICovCiAKKyAgI2luY2x1ZGUgPG1hdGguaD4KKwogdm9pZCBz
aW5jb3MgKGRvdWJsZSBfX3gsIGRvdWJsZSAqcF9zaW4sIGRvdWJsZSAqcF9j
b3MpOwogdm9pZCBzaW5jb3NsIChsb25nIGRvdWJsZSBfX3gsIGxvbmcgZG91
YmxlICpwX3NpbiwgbG9uZyBkb3VibGUgKnBfY29zKTsKIHZvaWQgc2luY29z
ZiAoZmxvYXQgX194LCBmbG9hdCAqcF9zaW4sIGZsb2F0ICpwX2Nvcyk7CkBA
IC0xMiw2ICsxNCw3IEBAIHZvaWQgc2luY29zIChkb3VibGUgX194LCBkb3Vi
bGUgKnBfc2luLCBkb3VibGUgKnBfY29zKQogewogICBsb25nIGRvdWJsZSBj
LCBzOwogCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogICBfX2FzbV9fIF9f
dm9sYXRpbGVfXyAoImZzaW5jb3Ncblx0IgogICAgICJmbnN0c3cgICAgJSVh
eFxuXHQiCiAgICAgInRlc3RsICAgICAkMHg0MDAsICUlZWF4XG5cdCIKQEAg
LTI2LDYgKzI5LDEwIEBAIHZvaWQgc2luY29zIChkb3VibGUgX194LCBkb3Vi
bGUgKnBfc2luLCBkb3VibGUgKnBfY29zKQogICAgICJmc3RwICAgICAgJSVz
dCgxKVxuXHQiCiAgICAgImZzaW5jb3Ncblx0IgogICAgICIxOiIgOiAiPXQi
IChjKSwgIj11IiAocykgOiAiMCIgKF9feCkpOworI2VsaWYgX19TSVpFT0Zf
TE9OR19ET1VCTEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVfXworICBzID0gc2lu
KF9feCk7CisgIGMgPSBjb3MoX194KTsKKyNlbmRpZgogICAqcF9zaW4gPSAo
ZG91YmxlKSBzOwogICAqcF9jb3MgPSAoZG91YmxlKSBjOwogfQpAQCAtMzQs
NiArNDEsNyBAQCB2b2lkIHNpbmNvc2YgKGZsb2F0IF9feCwgZmxvYXQgKnBf
c2luLCBmbG9hdCAqcF9jb3MpCiB7CiAgIGxvbmcgZG91YmxlIGMsIHM7CiAK
KyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAgIF9fYXNtX18gX192b2xhdGls
ZV9fICgiZnNpbmNvc1xuXHQiCiAgICAgImZuc3RzdyAgICAlJWF4XG5cdCIK
ICAgICAidGVzdGwgICAgICQweDQwMCwgJSVlYXhcblx0IgpAQCAtNDgsNiAr
NTYsMTAgQEAgdm9pZCBzaW5jb3NmIChmbG9hdCBfX3gsIGZsb2F0ICpwX3Np
biwgZmxvYXQgKnBfY29zKQogICAgICJmc3RwICAgICAgJSVzdCgxKVxuXHQi
CiAgICAgImZzaW5jb3Ncblx0IgogICAgICIxOiIgOiAiPXQiIChjKSwgIj11
IiAocykgOiAiMCIgKF9feCkpOworI2VsaWYgX19TSVpFT0ZfTE9OR19ET1VC
TEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVfXworICBzID0gc2luZihfX3gpOwor
ICBjID0gY29zZihfX3gpOworI2VuZGlmCiAgICpwX3NpbiA9IChmbG9hdCkg
czsKICAgKnBfY29zID0gKGZsb2F0KSBjOwogfQpAQCAtNTYsNiArNjgsNyBA
QCB2b2lkIHNpbmNvc2wgKGxvbmcgZG91YmxlIF9feCwgbG9uZyBkb3VibGUg
KnBfc2luLCBsb25nIGRvdWJsZSAqcF9jb3MpCiB7CiAgIGxvbmcgZG91Ymxl
IGMsIHM7CiAKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAgIF9fYXNtX18g
X192b2xhdGlsZV9fICgiZnNpbmNvc1xuXHQiCiAgICAgImZuc3RzdyAgICAl
JWF4XG5cdCIKICAgICAidGVzdGwgICAgICQweDQwMCwgJSVlYXhcblx0IgpA
QCAtNzAsNiArODMsMTAgQEAgdm9pZCBzaW5jb3NsIChsb25nIGRvdWJsZSBf
X3gsIGxvbmcgZG91YmxlICpwX3NpbiwgbG9uZyBkb3VibGUgKnBfY29zKQog
ICAgICJmc3RwICAgICAgJSVzdCgxKVxuXHQiCiAgICAgImZzaW5jb3Ncblx0
IgogICAgICIxOiIgOiAiPXQiIChjKSwgIj11IiAocykgOiAiMCIgKF9feCkp
OworI2VsaWYgX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJWkVPRl9E
T1VCTEVfXworICBzID0gc2luKChkb3VibGUpX194KTsKKyAgYyA9IGNvcygo
ZG91YmxlKV9feCk7CisjZW5kaWYKICAgKnBfc2luID0gczsKICAgKnBfY29z
ID0gYzsKIH0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9leHAu
ZGVmLmggYi93aW5zdXAvY3lnd2luL21hdGgvZXhwLmRlZi5oCmluZGV4IDMw
NjZiNzQ1ZC4uYTk5NjAxMzM4IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2lu
L21hdGgvZXhwLmRlZi5oCisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9leHAu
ZGVmLmgKQEAgLTUyLDExICs1MiwxMiBAQCBzdGF0aWMgbG9uZyBkb3VibGUK
IF9fZXhwbF9pbnRlcm5hbCAobG9uZyBkb3VibGUgeCkKIHsKICAgbG9uZyBk
b3VibGUgcmVzID0gMC4wTDsKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pIHx8
IGRlZmluZWQoX19pMzg2X18pCiAgIGFzbSB2b2xhdGlsZSAoCiAgICAgICAg
ImZsZGwyZVxuXHQiICAgICAgICAgICAgIC8qIDEgIGxvZzIoZSkgICAgICAg
ICAqLwogICAgICAgICJmbXVsICUlc3QoMSksJSVzdFxuXHQiICAvKiAxICB4
IGxvZzIoZSkgICAgICAgKi8KIAotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBk
ZWZpbmVkKF9feDg2XzY0X18pCiAgICAgInN1YnEgJDgsICUlcnNwXG4iCiAg
ICAgImZuc3RjdyA0KCUlcnNwKVxuIgogICAgICJtb3Z6d2wgNCglJXJzcCks
ICUlZWF4XG4iCkBAIC0xMDEsNiArMTAyLDExIEBAIF9fZXhwbF9pbnRlcm5h
bCAobG9uZyBkb3VibGUgeCkKICAgICAgICAiZnN0cAklJXN0KDEpXG5cdCIg
ICAgLyogMSAgKi8KICAgICAgICAiZnN0cAklJXN0KDEpXG5cdCIgICAgLyog
MCAgKi8KICAgICAgICA6ICI9dCIgKHJlcykgOiAiMCIgKHgpLCAibSIgKGMw
KSwgIm0iIChjMSkgOiAiYXgiLCAiZHgiKTsKKyNlbGlmIF9fU0laRU9GX0xP
TkdfRE9VQkxFX18gPT0gX19TSVpFT0ZfRE9VQkxFX18KKyAgKHZvaWQpYzA7
CisgICh2b2lkKWMxOworICByZXMgPSBleHAoKGRvdWJsZSl4KTsKKyNlbmRp
ZgogICByZXR1cm4gcmVzOwogfQogCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL21hdGgvZXhwMmwuUyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9leHAybC5T
CmluZGV4IGIwOGQ4ZTQwYS4uZGVlYjcwZjBiIDEwMDY0NAotLS0gYS93aW5z
dXAvY3lnd2luL21hdGgvZXhwMmwuUworKysgYi93aW5zdXAvY3lnd2luL21h
dGgvZXhwMmwuUwpAQCAtNTMsNyArNTMsNyBAQCBfX01JTkdXX1VTWU1CT0wo
ZXhwMmwpOgogCW1vdnEJJDAsOCglcmN4KQogCWZzdHB0CSglcmN4KQogCXJl
dAotI2Vsc2UKKyNlbGlmIF9faTM4Nl9fCiAJZmxkdAk0KCVlc3ApCiAvKiBJ
IGFkZGVkIHRoZSBmb2xsb3dpbmcgdWdseSBjb25zdHJ1Y3QgYmVjYXVzZSBl
eHAoKy1JbmYpIHJlc3VsdGVkCiAgICBpbiBOYU4uICBUaGUgdWdsaW5lc3Mg
cmVzdWx0cyBmcm9tIHRoZSBicmlnaHQgbWluZHMgYXQgSW50ZWwuCkBAIC04
OSw0ICs4OSw3IEBAIF9fTUlOR1dfVVNZTUJPTChleHAybCk6CiAJZnN0cAkl
c3QKIAlmbGR6CQkJCS8qIFNldCByZXN1bHQgdG8gMC4gICovCiAyOglyZXQK
KyNlbGlmIF9fU0laRU9GX0xPTkdfRE9VQkxFX18gPT0gX19TSVpFT0ZfRE9V
QkxFX18KKwlibAlleHAyCisJcmV0CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3dp
bnN1cC9jeWd3aW4vbWF0aC9leHBtMS5kZWYuaCBiL3dpbnN1cC9jeWd3aW4v
bWF0aC9leHBtMS5kZWYuaAppbmRleCAwMjgyMTFmOTEuLjBlMmNiNjcyNSAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9tYXRoL2V4cG0xLmRlZi5oCisr
KyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9leHBtMS5kZWYuaApAQCAtNjUsNyAr
NjUsMTEgQEAgX19GTFRfQUJJKGV4cG0xKSAoX19GTFRfVFlQRSB4KQogICBp
ZiAoX19GTFRfQUJJIChmYWJzKSAoeCkgPCBfX0ZMVF9MT0dFMikKICAgICB7
CiAgICAgICB4IC89IF9fRkxUX0xPR0UyOworI2lmIGRlZmluZWQoX3g4Nl82
NF9fKQogICAgICAgX19hc21fXyBfX3ZvbGF0aWxlX18gKCJmMnhtMSIgOiAi
PXQiICh4KSA6ICIwIiAoeCkpOworI2VsaWYgX19TSVpFT0ZfTE9OR19ET1VC
TEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVfXworICB4ID0gZXhwMih4KSAtIDEu
MDsKKyNlbmRpZgogICAgICAgcmV0dXJuIHg7CiAgICAgfQogICByZXR1cm4g
X19GTFRfQUJJIChleHApICh4KSAtIF9fRkxUX0NTVCAoMS4wKTsKZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9mYWJzbC5jIGIvd2luc3VwL2N5
Z3dpbi9tYXRoL2ZhYnNsLmMKaW5kZXggZjM4NjRlYTEzLi4yZjRmN2Q1YWYg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbWF0aC9mYWJzbC5jCisrKyBi
L3dpbnN1cC9jeWd3aW4vbWF0aC9mYWJzbC5jCkBAIC0xMiw3ICsxMiw3IEBA
IGZhYnNsIChsb25nIGRvdWJsZSB4KQogICBsb25nIGRvdWJsZSByZXMgPSAw
LjBMOwogICBhc20gdm9sYXRpbGUgKCJmYWJzOyIgOiAiPXQiIChyZXMpIDog
IjAiICh4KSk7CiAgIHJldHVybiByZXM7Ci0jZWxpZiBkZWZpbmVkKF9fYXJt
X18pIHx8IGRlZmluZWQoX0FSTV8pCisjZWxpZiBfX1NJWkVPRl9MT05HX0RP
VUJMRV9fID09IF9fU0laRU9GX0RPVUJMRV9fCiAgIHJldHVybiBfX2J1aWx0
aW5fZmFic2wgKHgpOwogI2VuZGlmIC8qIGRlZmluZWQoX194ODZfNjRfXykg
fHwgZGVmaW5lZChfQU1ENjRfKSB8fCBkZWZpbmVkKF9faTM4Nl9fKSB8fCBk
ZWZpbmVkKF9YODZfKSAqLwogfQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9tYXRoL2Zhc3RtYXRoLmggYi93aW5zdXAvY3lnd2luL21hdGgvZmFzdG1h
dGguaAppbmRleCBlYjE4NDZjYjMuLmY2ZDdmNzQ1MSAxMDA2NDQKLS0tIGEv
d2luc3VwL2N5Z3dpbi9tYXRoL2Zhc3RtYXRoLmgKKysrIGIvd2luc3VwL2N5
Z3dpbi9tYXRoL2Zhc3RtYXRoLmgKQEAgLTI2LDcgKzI2LDExIEBAIHN0YXRp
YyBfX2lubGluZV9fIGRvdWJsZSBfX2Zhc3Rfc3FydCAoZG91YmxlIHgpCiBz
dGF0aWMgX19pbmxpbmVfXyBsb25nIGRvdWJsZSBfX2Zhc3Rfc3FydGwgKGxv
bmcgZG91YmxlIHgpCiB7CiAgIGxvbmcgZG91YmxlIHJlczsKKyNpZiBkZWZp
bmVkKF9feDg2XzY0X18pCiAgIGFzbSBfX3ZvbGF0aWxlX18gKCJmc3FydCIg
OiAiPXQiIChyZXMpIDogIjAiICh4KSk7CisjZWxpZiBfX1NJWkVPRl9MT05H
X0RPVUJMRV9fID09IF9fU0laRU9GX0RPVUJMRV9fCisgIHJlcyA9IHNxcnQo
KGRvdWJsZSl4KTsKKyNlbmRpZgogICByZXR1cm4gcmVzOwogfQogCkBAIC00
MSwyMiArNDUsMzAgQEAgc3RhdGljIF9faW5saW5lX18gZmxvYXQgX19mYXN0
X3NxcnRmIChmbG9hdCB4KQogc3RhdGljIF9faW5saW5lX18gZG91YmxlIF9f
ZmFzdF9sb2cgKGRvdWJsZSB4KQogewogICAgZG91YmxlIHJlczsKKyNpZiBk
ZWZpbmVkKF9feDg2XzY0X18pCiAgICBhc20gX192b2xhdGlsZV9fCiAgICAg
ICgiZmxkbG4yXG5cdCIKICAgICAgICJmeGNoXG5cdCIKICAgICAgICJmeWwy
eCIKICAgICAgICA6ICI9dCIgKHJlcykgOiAiMCIgKHgpIDogInN0KDEpIik7
CisjZWxpZiBfX1NJWkVPRl9MT05HX0RPVUJMRV9fID09IF9fU0laRU9GX0RP
VUJMRV9fCisgIHJlcyA9IGxvZyh4KTsKKyNlbmRpZgogICAgcmV0dXJuIHJl
czsKIH0KIAogc3RhdGljIF9faW5saW5lX18gbG9uZyBkb3VibGUgX19mYXN0
X2xvZ2wgKGxvbmcgZG91YmxlIHgpCiB7CiAgIGxvbmcgZG91YmxlIHJlczsK
LSAgIGFzbSBfX3ZvbGF0aWxlX18KLSAgICAgKCJmbGRsbjJcblx0IgotICAg
ICAgImZ4Y2hcblx0IgotICAgICAgImZ5bDJ4IgotICAgICAgIDogIj10IiAo
cmVzKSA6ICIwIiAoeCkgOiAic3QoMSkiKTsKKyNpZiBkZWZpbmVkKF9feDg2
XzY0X18pCisgIGFzbSBfX3ZvbGF0aWxlX18KKyAgICAoImZsZGxuMlxuXHQi
CisgICAgICJmeGNoXG5cdCIKKyAgICAgImZ5bDJ4IgorICAgICAgOiAiPXQi
IChyZXMpIDogIjAiICh4KSA6ICJzdCgxKSIpOworI2VsaWYgX19TSVpFT0Zf
TE9OR19ET1VCTEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVfXworICByZXMgPSBs
b2coKGRvdWJsZSl4KTsKKyNlbmRpZgogICAgcmV0dXJuIHJlczsKIH0KIApA
QCAtOTMsMTIgKzEwNSwxNyBAQCBzdGF0aWMgX19pbmxpbmVfXyBsb25nIGRv
dWJsZSBfX2Zhc3RfbG9nMXBsIChsb25nIGRvdWJsZSB4KQogICAvKiBmeWwy
eHAxIGFjY3VyYXRlIG9ubHkgZm9yIHx4fCA8PSAxLjAgLSAwLjUgKiBzcXJ0
ICgyLjApICovCiAgIGlmIChmYWJzbCAoeCkgPj0gMS4wTCAtIDAuNUwgKiAx
LjQxNDIxMzU2MjM3MzA5NTA0ODgwTCkKICAgICByZXMgPSBfX2Zhc3RfbG9n
bCAoMS4wTCArIHgpOwotICBlbHNlCisgIGVsc2UgeworI2lmIGRlZmluZWQo
X194ODZfNjRfXykKICAgICBhc20gX192b2xhdGlsZV9fCiAgICAgICAoImZs
ZGxuMlxuXHQiCiAgICAgICAgImZ4Y2hcblx0IgogICAgICAgICJmeWwyeHAx
IgogICAgICAgIDogIj10IiAocmVzKSA6ICIwIiAoeCkgOiAic3QoMSkiKTsK
KyNlbGlmIF9fU0laRU9GX0xPTkdfRE9VQkxFX18gPT0gX19TSVpFT0ZfRE9V
QkxFX18KKyAgcmVzID0gbG9nMXAoKGRvdWJsZSl4KTsKKyNlbmRpZgorICAg
fQogICAgcmV0dXJuIHJlczsKIH0KIApkaWZmIC0tZ2l0IGEvd2luc3VwL2N5
Z3dpbi9tYXRoL2Ztb2RsLmMgYi93aW5zdXAvY3lnd2luL21hdGgvZm1vZGwu
YwppbmRleCA0NjJiNmZhNzkuLjUyY2MzY2UwNCAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9tYXRoL2Ztb2RsLmMKKysrIGIvd2luc3VwL2N5Z3dpbi9t
YXRoL2Ztb2RsLmMKQEAgLTMsNiArMyw5IEBACiAgKiBUaGlzIGZpbGUgaXMg
cGFydCBvZiB0aGUgbWluZ3ctdzY0IHJ1bnRpbWUgcGFja2FnZS4KICAqIE5v
IHdhcnJhbnR5IGlzIGdpdmVuOyByZWZlciB0byB0aGUgZmlsZSBESVNDTEFJ
TUVSLlBEIHdpdGhpbiB0aGlzIHBhY2thZ2UuCiAgKi8KKworI2luY2x1ZGUg
PG1hdGguaD4KKwogbG9uZyBkb3VibGUgZm1vZGwgKGxvbmcgZG91YmxlIHgs
IGxvbmcgZG91YmxlIHkpOwogCiBsb25nIGRvdWJsZQpAQCAtMTAsNiArMTMs
NyBAQCBmbW9kbCAobG9uZyBkb3VibGUgeCwgbG9uZyBkb3VibGUgeSkKIHsK
ICAgbG9uZyBkb3VibGUgcmVzID0gMC4wTDsKIAorI2lmIGRlZmluZWQoX194
ODZfNjRfXykKICAgYXNtIHZvbGF0aWxlICgKICAgICAgICAiMTpcdGZwcmVt
XG5cdCIKICAgICAgICAiZnN0c3cgICAlJWF4XG5cdCIKQEAgLTE3LDUgKzIx
LDggQEAgZm1vZGwgKGxvbmcgZG91YmxlIHgsIGxvbmcgZG91YmxlIHkpCiAg
ICAgICAgImpwICAgICAgMWJcblx0IgogICAgICAgICJmc3RwICAgICUlc3Qo
MSkiCiAgICAgICAgOiAiPXQiIChyZXMpIDogIjAiICh4KSwgInUiICh5KSA6
ICJheCIsICJzdCgxKSIpOworI2VsaWYgX19TSVpFT0ZfTE9OR19ET1VCTEVf
XyA9PSBfX1NJWkVPRl9ET1VCTEVfXworICByZXMgPSBmbW9kKChkb3VibGUp
eCwgKGRvdWJsZSl5KTsKKyNlbmRpZgogICByZXR1cm4gcmVzOwogfQpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tYXRoL2ZyZXhwbC5TIGIvd2luc3Vw
L2N5Z3dpbi9tYXRoL2ZyZXhwbC5TCmluZGV4IDEyNzgyYzI5ZS4uYjMxMjlk
Y2Q4IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21hdGgvZnJleHBsLlMK
KysrIGIvd2luc3VwL2N5Z3dpbi9tYXRoL2ZyZXhwbC5TCkBAIC0xMCwxNCAr
MTAsMTQgQEAKICAqIEl0IHJldHVybnMgYW4gaW50ZWdlciBwb3dlciBvZiB0
d28gdG8gZXhwbnQgYW5kIHRoZSBzaWduaWZpY2FuZAogICogYmV0d2VlbiAw
LjUgYW5kIDEgdG8geS4gIFRodXMgIHggPSB5ICogMioqZXhwbi4KICAqLwot
I2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJ
LmFsaWduIDgKLSNlbHNlCisjZWxpZiBkZWZpbmVkKF9faTM4Nl9fKQogCS5h
bGlnbiAyCiAjZW5kaWYKIC5nbG9ibCBfX01JTkdXX1VTWU1CT0woZnJleHBs
KQogX19NSU5HV19VU1lNQk9MKGZyZXhwbCk6Ci0jaWZkZWYgX194ODZfNjRf
XworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAlwdXNocSAlcmJwCiAJbW92
cSAlcnNwLCVyYnAKIAlzdWJxICQ0OCwlcnNwCkBAIC03Miw3ICs3Miw3IEBA
IEwyNDoKIAlmc3RwdAkoJXI5KQogCWxlYXZlCiAJcmV0Ci0jZWxzZQorI2Vs
aWYgZGVmaW5lZChfX2kzODZfXykKIAlwdXNobCAlZWJwCiAJbW92bCAlZXNw
LCVlYnAKIAlzdWJsICQyNCwlZXNwCkBAIC0xMjcsNCArMTI3LDkgQEAgTDI0
OgogCXBvcGwgJWVzaQogCWxlYXZlCiAJcmV0CisjZWxpZiBfX1NJWkVPRl9M
T05HX0RPVUJMRV9fID09IF9fU0laRU9GX0RPVUJMRV9fCisJYmwJZnJleHAK
KwlyZXQKKyNlbHNlCisJLmVycm9yICJOb3Qgc3VwcG9ydGVkIG9uIHlvdXIg
cGxhdGZvcm0geWV0IgogI2VuZGlmCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL21hdGgvaWxvZ2JsLlMgYi93aW5zdXAvY3lnd2luL21hdGgvaWxvZ2Js
LlMKaW5kZXggYzc1YTdkMGZkLi45YWVhNGUzYTcgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vbWF0aC9pbG9nYmwuUworKysgYi93aW5zdXAvY3lnd2lu
L21hdGgvaWxvZ2JsLlMKQEAgLTcsMTUgKzcsMTUgQEAKIAogCS5maWxlCSJp
bG9nYmwuUyIKIAkudGV4dAotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZp
bmVkKF9feDg2XzY0X18pCiAJLmFsaWduIDgKLSNlbHNlCisjZWxpZiBkZWZp
bmVkKF9faTM4Nl9fKQogCS5hbGlnbiA0CiAjZW5kaWYKIC5nbG9ibCBfX01J
TkdXX1VTWU1CT0woaWxvZ2JsKQogCS5kZWYJX19NSU5HV19VU1lNQk9MKGls
b2dibCk7CS5zY2wJMjsJLnR5cGUJMzI7CS5lbmRlZgogX19NSU5HV19VU1lN
Qk9MKGlsb2dibCk6Ci0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQo
X194ODZfNjRfXykKIAlmbGR0CSglcmN4KQogCWZ4YW0JCQkvKiBJcyBOYU4g
b3IgKy1JbmY/ICAqLwogCWZzdHN3ICAgJWF4CkBAIC00NCw3ICs0NCw3IEBA
IF9fTUlOR1dfVVNZTUJPTChpbG9nYmwpOgogMjoJZnN0cCAgICAlc3QKIAlt
b3ZsCSQweDgwMDAwMDAxLCAlZWF4CS8qIEZQX0lMT0dCMCAgKi8KIAlyZXQK
LSNlbHNlCisjZWxpZiBkZWZpbmVkKF9faTM4Nl9fKQogCWZsZHQJNCglZXNw
KQogLyogSSBhZGRlZCB0aGUgZm9sbG93aW5nIHVnbHkgY29uc3RydWN0IGJl
Y2F1c2UgaWxvZ2IoKy1JbmYpIGlzCiAgICByZXF1aXJlZCB0byByZXR1cm4g
SU5UX01BWCBpbiBJU08gQzk5LgpAQCAtNzYsNCArNzYsOSBAQCBfX01JTkdX
X1VTWU1CT0woaWxvZ2JsKToKIDI6CWZzdHAgICAgJXN0CiAJbW92bAkkMHg4
MDAwMDAwMSwgJWVheAkvKiBGUF9JTE9HQjAgICovCiAJcmV0CisjZWxpZiBf
X1NJWkVPRl9MT05HX0RPVUJMRV9fID09IF9fU0laRU9GX0RPVUJMRV9fCisJ
YmwJaWxvZ2IKKwlyZXQKKyNlbHNlCisJLmVycm9yICJOb3Qgc3VwcG9ydGVk
IG9uIHlvdXIgcGxhdGZvcm0geWV0IgogI2VuZGlmCmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL21hdGgvaW50ZXJuYWxfbG9nbC5TIGIvd2luc3VwL2N5
Z3dpbi9tYXRoL2ludGVybmFsX2xvZ2wuUwppbmRleCBmOGEwNzU3NzQuLmY1
N2YyNzMxYSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9tYXRoL2ludGVy
bmFsX2xvZ2wuUworKysgYi93aW5zdXAvY3lnd2luL21hdGgvaW50ZXJuYWxf
bG9nbC5TCkBAIC03LDkgKzcsOSBAQAogCiAJLmZpbGUJImludGVybmFsX2xv
Z2wuUyIKIAkudGV4dAotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVk
KF9feDg2XzY0X18pCiAJLmFsaWduIDgKLSNlbHNlCisjZWxpZiBkZWZpbmVk
KF9faTM4Nl9fKQogCS5hbGlnbiA0CiAjZW5kaWYKIG9uZToJLmRvdWJsZSAx
LjAKQEAgLTIxLDcgKzIxLDcgQEAgbGltaXQ6CS5kb3VibGUgMC4yOQogLmds
b2JsIF9fTUlOR1dfVVNZTUJPTChfX2xvZ2xfaW50ZXJuYWwpCiAJLmRlZglf
X01JTkdXX1VTWU1CT0woX19sb2dsX2ludGVybmFsKTsJLnNjbAkyOwkudHlw
ZQkzMjsJLmVuZGVmCiBfX01JTkdXX1VTWU1CT0woX19sb2dsX2ludGVybmFs
KToKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9f
KQogCWZsZGxuMgkJCS8vIGxvZygyKQogCWZsZHQJKCVyZHgpCQkvLyB4IDog
bG9nKDIpCiAJZmxkCSVzdAkJLy8geCA6IHggOiBsb2coMikKQEAgLTQ1LDcg
KzQ1LDcgQEAgX19NSU5HV19VU1lNQk9MKF9fbG9nbF9pbnRlcm5hbCk6CiAJ
bW92cQkkMCw4KCVyY3gpCiAJZnN0cHQJKCVyY3gpCiAJcmV0Ci0jZWxzZQor
I2VsaWYgZGVmaW5lZChfX2kzODZfXykKIAlmbGRsbjIJCQkvLyBsb2coMikK
IAlmbGR0CTQoJWVzcCkJCS8vIHggOiBsb2coMikKIAlmbGQJJXN0CQkvLyB4
IDogeCA6IGxvZygyKQpAQCAtNjMsNCArNjMsOSBAQCBfX01JTkdXX1VTWU1C
T0woX19sb2dsX2ludGVybmFsKToKIDI6CWZzdHAJJXN0KDApCQkvLyB4IDog
bG9nKDIpCiAJZnlsMngJCQkvLyBsb2coeCkKIAlyZXQKKyNlbGlmIF9fU0la
RU9GX0xPTkdfRE9VQkxFX18gPT0gX19TSVpFT0ZfRE9VQkxFX18KKwlibAls
b2cKKwlyZXQKKyNlbHNlCisJLmVycm9yICJOb3Qgc3VwcG9ydGVkIG9uIHlv
dXIgcGxhdGZvcm0geWV0IgogI2VuZGlmCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL21hdGgvbGRleHBsLmMgYi93aW5zdXAvY3lnd2luL21hdGgvbGRl
eHBsLmMKaW5kZXggMjQzODYxN2MzLi5hNDRhM2EzYjEgMTAwNjQ0Ci0tLSBh
L3dpbnN1cC9jeWd3aW4vbWF0aC9sZGV4cGwuYworKysgYi93aW5zdXAvY3ln
d2luL21hdGgvbGRleHBsLmMKQEAgLTEyLDkgKzEyLDEzIEBAIGxvbmcgZG91
YmxlIGxkZXhwbChsb25nIGRvdWJsZSB4LCBpbnQgZXhwbikKICAgaWYgKCFp
c2Zpbml0ZSAoeCkgfHwgeCA9PSAwLjBMKQogICAgIHJldHVybiB4OwogCisj
aWYgZGVmaW5lZChfX3g4Nl82NF9fKSB8fCBkZWZpbmVkKF9faTM4Nl9fKQog
ICBfX2FzbV9fIF9fdm9sYXRpbGVfXyAoImZzY2FsZSIKIAkgICAgOiAiPXQi
IChyZXMpCiAJICAgIDogIjAiICh4KSwgInUiICgobG9uZyBkb3VibGUpIGV4
cG4pKTsKKyNlbGlmIF9fU0laRU9GX0xPTkdfRE9VQkxFX18gPT0gX19TSVpF
T0ZfRE9VQkxFX18KKyAgcmVzID0gbGRleHAoKGRvdWJsZSl4LCBleHBuKTsK
KyNlbmRpZgogCiAgIGlmICghaXNmaW5pdGUgKHJlcykgfHwgcmVzID09IDAu
MEwpCiAgICAgZXJybm8gPSBFUkFOR0U7CmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL21hdGgvbGdhbW1hbC5jIGIvd2luc3VwL2N5Z3dpbi9tYXRoL2xn
YW1tYWwuYwppbmRleCAwMjJhMTZhY2YuLjkxZDEwMmQ1NyAxMDA2NDQKLS0t
IGEvd2luc3VwL2N5Z3dpbi9tYXRoL2xnYW1tYWwuYworKysgYi93aW5zdXAv
Y3lnd2luL21hdGgvbGdhbW1hbC5jCkBAIC0xOTgsMTEgKzE5OCwxMSBAQCBz
dGF0aWMgdUxEIENbXSA9IHsKIAogLyogbG9nKCBzcXJ0KCAyKnBpICkgKSAq
Lwogc3RhdGljIGNvbnN0IGxvbmcgZG91YmxlIExTMlBJICA9ICAwLjkxODkz
ODUzMzIwNDY3Mjc0MTc4TDsKLSNpZiBkZWZpbmVkKF9fYXJtX18pIHx8IGRl
ZmluZWQoX0FSTV8pCisjaWYgX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBf
X1NJWkVPRl9ET1VCTEVfXwogI2RlZmluZSBNQVhMR00gMi4wMzUwOTNlMzYK
ICNlbHNlCiAjZGVmaW5lIE1BWExHTSAxLjA0ODQ4MTQ2ODM5MDE5NTIxMTE2
ZSs0OTI4TAotI2VuZGlmIC8qIGRlZmluZWQoX19hcm1fXykgfHwgZGVmaW5l
ZChfQVJNXykgKi8KKyNlbmRpZiAvKiBfX1NJWkVPRl9MT05HX0RPVUJMRV9f
ID09IF9fU0laRU9GX0RPVUJMRV9fICovCiAKIC8qIExvZ2FyaXRobSBvZiBn
YW1tYSBmdW5jdGlvbiAqLwogLyogUmVlbnRyYW50IHZlcnNpb24gKi8KZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9sb2cxMGwuUyBiL3dpbnN1
cC9jeWd3aW4vbWF0aC9sb2cxMGwuUwppbmRleCAzM2Q0NWEzYTguLjNkN2Rm
MzRmYyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9tYXRoL2xvZzEwbC5T
CisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9sb2cxMGwuUwpAQCAtNyw5ICs3
LDkgQEAKIAogCS5maWxlCSJsb2cxMGwuUyIKIAkudGV4dAotI2lmZGVmIF9f
eDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJLmFsaWduIDgK
LSNlbHNlCisjZWxpZiBkZWZpbmVkKF9faTM4Nl9fKQogCS5hbGlnbiA0CiAj
ZW5kaWYKIG9uZToJLmRvdWJsZSAxLjAKQEAgLTE5LDE1ICsxOSwxNSBAQCBv
bmU6CS5kb3VibGUgMS4wCiBsaW1pdDoJLmRvdWJsZSAwLjI5CiAKIAkudGV4
dAotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18p
CiAJLmFsaWduIDgKLSNlbHNlCisjZWxpZiBkZWZpbmVkKF9faTM4Nl9fKQog
CS5hbGlnbiA0CiAjZW5kaWYKIC5nbG9ibCBfX01JTkdXX1VTWU1CT0wobG9n
MTBsKQogCS5kZWYJX19NSU5HV19VU1lNQk9MKGxvZzEwbCk7CS5zY2wJMjsJ
LnR5cGUJMzI7CS5lbmRlZgogX19NSU5HV19VU1lNQk9MKGxvZzEwbCk6Ci0j
aWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAlm
bGRsZzIJCQkvLyBsb2cxMCgyKQogCWZsZHQJKCVyZHgpCQkvLyB4IDogbG9n
MTAoMikKIAlmeGFtCkBAIC02Myw3ICs2Myw3IEBAIF9fTUlOR1dfVVNZTUJP
TChsb2cxMGwpOgogCW1vdnEJJDAsOCglcmN4KQogCWZzdHB0CSglcmN4KQog
CXJldAotI2Vsc2UKKyNlbGlmIGRlZmluZWQoX19pMzg2X18pCiAJZmxkbGcy
CQkJLy8gbG9nMTAoMikKIAlmbGR0CTQoJWVzcCkJCS8vIHggOiBsb2cxMCgy
KQogCWZ4YW0KQEAgLTkwLDQgKzkwLDkgQEAgX19NSU5HV19VU1lNQk9MKGxv
ZzEwbCk6CiAJZnN0cAklc3QoMSkKIAlmc3RwCSVzdCgxKQogCXJldAorI2Vs
aWYgX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVf
XworCWJsCWxvZzEwCisJcmV0CisjZWxzZQorCS5lcnJvciAiTm90IHN1cHBv
cnRlZCBvbiB5b3VyIHBsYXRmb3JtIHlldCIKICNlbmRpZgpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9tYXRoL2xvZzFwbC5TIGIvd2luc3VwL2N5Z3dp
bi9tYXRoL2xvZzFwbC5TCmluZGV4IGE1NmJjZjRlYy4uMzE5M2I2MDkyIDEw
MDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21hdGgvbG9nMXBsLlMKKysrIGIv
d2luc3VwL2N5Z3dpbi9tYXRoL2xvZzFwbC5TCkBAIC0xMiwxOCArMTIsMjAg
QEAKIAkgICAwLjI5IGlzIGEgc2FmZSB2YWx1ZS4KIAkgKi8KIAorI2lmIGRl
ZmluZWQoX194ODZfNjRfXykgfHwgZGVmaW5lZChfX2kzODZfXykKIAkvKiBP
bmx5IGdjYyB1bmRlcnN0YW5kcyB0aGUgLnRmbG9hdCB0eXBlCiAJICAgVGhl
IHNlcmllcyBvZiAubG9uZyBiZWxvdyByZXByZXNlbnRzCiAJICAgbGltaXQ6
CS50ZmxvYXQgMC4yOQogCSAqLwogCS5hbGlnbiAxNgorI2VuZGlmCiBsaW1p
dDoKIAkubG9uZyAyOTIwNTc3NzYxCiAJLmxvbmcgMjQ5MTA4MTAzMQogCS5s
b25nIDE2MzgxCi0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194
ODZfNjRfXykKIAkuYWxpZ24gOAotI2Vsc2UKKyNlbGlmIGRlZmluZWQoX19p
Mzg2X18pCiAJLmFsaWduIDQKICNlbmRpZgogCS8qIFBsZWFzZSBub3RlOgkg
d2UgdXNlIGEgZG91YmxlIHZhbHVlIGhlcmUuICBTaW5jZSAxLjAgaGFzCkBA
IC0zOCw3ICs0MCw3IEBAIG9uZToJLmRvdWJsZSAxLjAKIC5nbG9ibCBfX01J
TkdXX1VTWU1CT0wobG9nMXBsKQogCS5kZWYJX19NSU5HV19VU1lNQk9MKGxv
ZzFwbCk7CS5zY2wJMjsJLnR5cGUJMzI7CS5lbmRlZgogX19NSU5HV19VU1lN
Qk9MKGxvZzFwbCk6Ci0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQo
X194ODZfNjRfXykKIAlmbGRsbjIKIAlmbGR0CSglcmR4KQogCWZ4YW0KQEAg
LTczLDcgKzc1LDcgQEAgX19NSU5HV19VU1lNQk9MKGxvZzFwbCk6CiAJbW92
cQkkMCw4KCVyY3gpCiAJZnN0cHQJKCVyY3gpCiAJcmV0Ci0jZWxzZQorI2Vs
aWYgZGVmaW5lZChfX2kzODZfXykKIAlmbGRsbjIKIAlmbGR0CTQoJWVzcCkK
IAlmeGFtCkBAIC05OSw0ICsxMDEsOSBAQCBfX01JTkdXX1VTWU1CT0wobG9n
MXBsKToKIAlmc3RwCSVzdCgxKQogCWZzdHAJJXN0KDEpCiAJcmV0CisjZWxp
ZiBfX1NJWkVPRl9MT05HX0RPVUJMRV9fID09IF9fU0laRU9GX0RPVUJMRV9f
CisJYmwJbG9nMXAKKwlyZXQKKyNlbHNlCisJLmVycm9yICJOb3Qgc3VwcG9y
dGVkIG9uIHlvdXIgcGxhdGZvcm0geWV0IgogI2VuZGlmCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL21hdGgvbG9nMmwuUyBiL3dpbnN1cC9jeWd3aW4v
bWF0aC9sb2cybC5TCmluZGV4IDc3MWNkOGFlNC4uMzM3YTNkNjJmIDEwMDY0
NAotLS0gYS93aW5zdXAvY3lnd2luL21hdGgvbG9nMmwuUworKysgYi93aW5z
dXAvY3lnd2luL21hdGgvbG9nMmwuUwpAQCAtNyw5ICs3LDkgQEAKIAogCS5m
aWxlCSJsb2cybC5TIgogCS50ZXh0Ci0jaWZkZWYgX194ODZfNjRfXworI2lm
IGRlZmluZWQoX194ODZfNjRfXykKIAkuYWxpZ24gOAotI2Vsc2UKKyNlbGlm
IGRlZmluZWQoX19pMzg2X18pCiAJLmFsaWduIDQKICNlbmRpZgogb25lOgku
ZG91YmxlIDEuMApAQCAtMjEsNyArMjEsNyBAQCBsaW1pdDoJLmRvdWJsZSAw
LjI5CiAuZ2xvYmwgX19NSU5HV19VU1lNQk9MKGxvZzJsKQogCS5kZWYJX19N
SU5HV19VU1lNQk9MKGxvZzJsKTsJLnNjbAkyOwkudHlwZQkzMjsJLmVuZGVm
CiBfX01JTkdXX1VTWU1CT0wobG9nMmwpOgotI2lmZGVmIF9feDg2XzY0X18K
KyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJZmxkbAlvbmUoJXJpcCkKIAlm
bGR0CSglcmR4KQkJLy8geCA6IDEKIAlmeGFtCkBAIC01Nyw3ICs1Nyw3IEBA
IF9fTUlOR1dfVVNZTUJPTChsb2cybCk6CiAJbW92cQkkMCw4KCVyY3gpCiAJ
ZnN0cHQJKCVyY3gpCiAJcmV0Ci0jZWxzZQorI2VsaWYgZGVmaW5lZChfX2kz
ODZfXykKIAlmbGRsCW9uZQogCWZsZHQJNCglZXNwKQkJLy8geCA6IDEKIAlm
eGFtCkBAIC04NCw0ICs4NCw5IEBAIF9fTUlOR1dfVVNZTUJPTChsb2cybCk6
CiAJZnN0cAklc3QoMSkKIAlmc3RwCSVzdCgxKQogCXJldAorI2VsaWYgX19T
SVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVfXworCWJs
CWxvZzIKKwlyZXQKKyNlbHNlCisJLmVycm9yICJOb3Qgc3VwcG9ydGVkIG9u
IHlvdXIgcGxhdGZvcm0geWV0IgogI2VuZGlmCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL21hdGgvbG9nYmwuYyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9s
b2dibC5jCmluZGV4IDVlNTMzYzA3Yy4uMWVlN2U1N2FiIDEwMDY0NAotLS0g
YS93aW5zdXAvY3lnd2luL21hdGgvbG9nYmwuYworKysgYi93aW5zdXAvY3ln
d2luL21hdGgvbG9nYmwuYwpAQCAtMTYsOCArMTYsMTIgQEAgbG9nYmwgKGxv
bmcgZG91YmxlIHgpCiB7CiAgIGxvbmcgZG91YmxlIHJlcyA9IDAuMEw7CiAK
KyNpZiBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQoX19pMzg2X18p
CiAgIGFzbSB2b2xhdGlsZSAoCiAgICAgICAgImZ4dHJhY3Rcblx0IgogICAg
ICAgICJmc3RwCSUlc3QiIDogIj10IiAocmVzKSA6ICIwIiAoeCkpOworI2Vs
aWYgX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVf
XworICByZXMgPSBsb2diKChkb3VibGUpeCk7CisjZW5kaWYKICAgcmV0dXJu
IHJlczsKIH0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9scmlu
dGwuYyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9scmludGwuYwppbmRleCA0MmYy
ZDNjNjYuLmQ1ZTNhYzkwNiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9t
YXRoL2xyaW50bC5jCisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9scmludGwu
YwpAQCAtMTIsNyArMTIsNyBAQCBsb25nIGxyaW50bCAobG9uZyBkb3VibGUg
eCkKICAgX19hc21fXyBfX3ZvbGF0aWxlX18gKCJmaXN0cGxsICUwIiAgOiAi
PW0iIChyZXR2YWwpIDogInQiICh4KSA6ICJzdCIpOwogI2VsaWYgZGVmaW5l
ZChfQU1ENjRfKSB8fCBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQo
X1g4Nl8pIHx8IGRlZmluZWQoX19pMzg2X18pCiAgIF9fYXNtX18gX192b2xh
dGlsZV9fICgiZmlzdHBsICUwIiAgOiAiPW0iIChyZXR2YWwpIDogInQiICh4
KSA6ICJzdCIpOwotI2VsaWYgZGVmaW5lZChfX2FybV9fKSB8fCBkZWZpbmVk
KF9BUk1fKQorI2VsaWYgX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJ
WkVPRl9ET1VCTEVfXwogICAgIHJldHZhbCA9IGxyaW50KHgpOwogI2VuZGlm
CiAgIHJldHVybiByZXR2YWw7CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2lu
L21hdGgvbmV4dGFmdGVybC5jIGIvd2luc3VwL2N5Z3dpbi9tYXRoL25leHRh
ZnRlcmwuYwppbmRleCBiMWU0NzlhOTUuLjFhYzQwOGRkNCAxMDA2NDQKLS0t
IGEvd2luc3VwL2N5Z3dpbi9tYXRoL25leHRhZnRlcmwuYworKysgYi93aW5z
dXAvY3lnd2luL21hdGgvbmV4dGFmdGVybC5jCkBAIC0xNiw2ICsxNiw5IEBA
CiBsb25nIGRvdWJsZQogbmV4dGFmdGVybCAobG9uZyBkb3VibGUgeCwgbG9u
ZyBkb3VibGUgeSkKIHsKKyNpZiBfX1NJWkVPRl9MT05HX0RPVUJMRV9fID09
IF9fU0laRU9GX0RPVUJMRV9fICYmIChMREJMX01BTlRfRElHID09IERCTF9N
QU5UX0RJRykKKyAgcmV0dXJuIChsb25nIGRvdWJsZSkgbmV4dHRvd2FyZCAo
eCwgeSk7CisjIGVsc2UKICAgdW5pb24gewogICAgICAgbG9uZyBkb3VibGUg
bGQ7CiAgICAgICBzdHJ1Y3QgewpAQCAtNjMsNiArNjYsNyBAQCBuZXh0YWZ0
ZXJsIChsb25nIGRvdWJsZSB4LCBsb25nIGRvdWJsZSB5KQogICAgIHUucGFy
dHMubWFudGlzc2EgfD0gIG5vcm1hbF9iaXQ7CiAKICAgcmV0dXJuIHUubGQ7
CisjIGVuZGlmIC8qIF9fU0laRU9GX0xPTkdfRE9VQkxFX18gPT0gX19TSVpF
T0ZfRE9VQkxFX18gKi8KIH0KIAogLyogbmV4dHRvd2FyZGwgaXMgdGhlIHNh
bWUgZnVuY3Rpb24gd2l0aCBhIGRpZmZlcmVudCBuYW1lLiAgKi8KZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9wb3cuZGVmLmggYi93aW5zdXAv
Y3lnd2luL21hdGgvcG93LmRlZi5oCmluZGV4IDJlYTgyNTcyMC4uYmY3NDE1
NjFlIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21hdGgvcG93LmRlZi5o
CisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9wb3cuZGVmLmgKQEAgLTgxLDcg
KzgxLDcgQEAgaW50ZXJuYWxfbW9kZiAoX19GTFRfVFlQRSB2YWx1ZSwgX19G
TFRfVFlQRSAqaXB0cikKICAgX19GTFRfVFlQRSBpbnRfcGFydCA9IChfX0ZM
VF9UWVBFKSAwLjA7CiAgIC8qIHRydW5jYXRlICovCiAgIC8qIHRydW5jYXRl
ICovCi0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRf
XykKICAgYXNtIHZvbGF0aWxlICgicHVzaHEgJSVyYXhcblx0c3VicSAkOCwg
JSVyc3BcbiIKICAgICAiZm5zdGN3IDQoJSVyc3ApXG4iCiAgICAgIm1vdnp3
bCA0KCUlcnNwKSwgJSVlYXhcbiIKQEAgLTkxLDcgKzkxLDcgQEAgaW50ZXJu
YWxfbW9kZiAoX19GTFRfVFlQRSB2YWx1ZSwgX19GTFRfVFlQRSAqaXB0cikK
ICAgICAiZnJuZGludFxuIgogICAgICJmbGRjdyA0KCUlcnNwKVxuIgogICAg
ICJhZGRxICQ4LCAlJXJzcFxucG9wcSAlJXJheCIgOiAiPXQiIChpbnRfcGFy
dCkgOiAiMCIgKHZhbHVlKSk7IC8qIHJvdW5kICovCi0jZWxzZQorI2VsaWYg
ZGVmaW5lZChfX2kzODZfXykKICAgYXNtIHZvbGF0aWxlICgicHVzaCAlJWVh
eFxuXHRzdWJsICQ4LCAlJWVzcFxuIgogICAgICJmbnN0Y3cgNCglJWVzcClc
biIKICAgICAibW92endsIDQoJSVlc3ApLCAlJWVheFxuIgpAQCAtMTAxLDYg
KzEwMSw4IEBAIGludGVybmFsX21vZGYgKF9fRkxUX1RZUEUgdmFsdWUsIF9f
RkxUX1RZUEUgKmlwdHIpCiAgICAgImZybmRpbnRcbiIKICAgICAiZmxkY3cg
NCglJWVzcClcbiIKICAgICAiYWRkbCAkOCwgJSVlc3Bcblx0cG9wICUlZWF4
XG4iIDogIj10IiAoaW50X3BhcnQpIDogIjAiICh2YWx1ZSkpOyAvKiByb3Vu
ZCAqLworI2VsaWYgX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJWkVP
Rl9ET1VCTEVfXworICBpbnRfcGFydCA9IHJvdW5kICh2YWx1ZSk7CiAjZW5k
aWYKICAgaWYgKGlwdHIpCiAgICAgKmlwdHIgPSBpbnRfcGFydDsKQEAgLTIw
NCw3ICsyMDYsMTEgQEAgX19GTFRfQUJJKHBvdykgKF9fRkxUX1RZUEUgeCwg
X19GTFRfVFlQRSB5KQogCX0KICAgICAgIGlmICh5ID09IF9fRkxUX0NTVCgw
LjUpKQogCXsKLQkgIGFzbSB2b2xhdGlsZSAoImZzcXJ0IiA6ICI9dCIgKHJz
bHQpIDogIjAiICh4KSk7CisgICAgICAjaWYgZGVmaW5lZChfX3g4Nl82NF9f
KSB8fCBkZWZpbmVkKF9faTM4Nl9fKQorICAgICAgICAgIGFzbSB2b2xhdGls
ZSAoImZzcXJ0IiA6ICI9dCIgKHJzbHQpIDogIjAiICh4KSk7CisgICAgICAj
ZWxpZiBfX1NJWkVPRl9MT05HX0RPVUJMRV9fID09IF9fU0laRU9GX0RPVUJM
RV9fCisgICAgICAgICAgYXNtIHZvbGF0aWxlICgiZnNxcnQgJWQwLCAlZDEi
IDogIj13IiAocnNsdCkgOiAidyIgKHgpKTsKKyAgICAgICNlbmRpZgogCSAg
cmV0dXJuIHJzbHQ7CiAJfQogICAgIH0KZGlmZiAtLWdpdCBhL3dpbnN1cC9j
eWd3aW4vbWF0aC9yZW1haW5kZXIuUyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9y
ZW1haW5kZXIuUwppbmRleCA1YTcxM2Y5MDQuLmM5ZDllMmU3OCAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9tYXRoL3JlbWFpbmRlci5TCisrKyBiL3dp
bnN1cC9jeWd3aW4vbWF0aC9yZW1haW5kZXIuUwpAQCAtNywxNSArNywxNSBA
QAogCiAJLmZpbGUJInJlbWFpbmRlci5TIgogCS50ZXh0Ci0jaWZkZWYgX194
ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAkuYWxpZ24gOAot
I2Vsc2UKKyNlbGlmIGRlZmluZWQoX19pMzg2X18pCiAJLmFsaWduIDQKICNl
bmRpZgogLmdsb2JsIF9fTUlOR1dfVVNZTUJPTChyZW1haW5kZXIpCiAJLmRl
ZglfX01JTkdXX1VTWU1CT0wocmVtYWluZGVyKTsJLnNjbAkyOwkudHlwZQkz
MjsJLmVuZGVmCiBfX01JTkdXX1VTWU1CT0wocmVtYWluZGVyKToKLSNpZmRl
ZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogCW1vdnNk
CSV4bW0wLC0xNiglcnNwKQogCW1vdnNkCSV4bW0xLC0zMiglcnNwKQogCWZs
ZGwJLTMyKCVyc3ApCkBAIC0yOCw3ICsyOCw3IEBAIF9fTUlOR1dfVVNZTUJP
TChyZW1haW5kZXIpOgogCWZzdHBsCS0xNiglcnNwKQogCW1vdnNkCS0xNigl
cnNwKSwleG1tMAogCXJldAotI2Vsc2UKKyNlbGlmIGRlZmluZWQoX19pMzg2
X18pCiAJZmxkbAkxMiglZXNwKQogCWZsZGwJNCglZXNwKQogMToJZnByZW0x
CkBAIC0zNyw0ICszNyw4IEBAIF9fTUlOR1dfVVNZTUJPTChyZW1haW5kZXIp
OgogCWpwCTFiCiAJZnN0cAklc3QoMSkKIAlyZXQKKyNlbGlmIF9fU0laRU9G
X0xPTkdfRE9VQkxFX18gPT0gX19TSVpFT0ZfRE9VQkxFX18KKwkvKiBBQXJj
aDY0OiBzeXN0ZW0gbGlibSBwcm92aWRlcyByZW1haW5kZXIoKSBuYXRpdmVs
eSwgbm8gc3R1YiBuZWVkZWQgKi8KKyNlbHNlCisJLmVycm9yICJOb3Qgc3Vw
cG9ydGVkIG9uIHlvdXIgcGxhdGZvcm0geWV0IgogI2VuZGlmCmRpZmYgLS1n
aXQgYS93aW5zdXAvY3lnd2luL21hdGgvcmVtYWluZGVyZi5TIGIvd2luc3Vw
L2N5Z3dpbi9tYXRoL3JlbWFpbmRlcmYuUwppbmRleCBjM2EzYTNkYzUuLjcz
ZDBmNmI3YSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9tYXRoL3JlbWFp
bmRlcmYuUworKysgYi93aW5zdXAvY3lnd2luL21hdGgvcmVtYWluZGVyZi5T
CkBAIC03LDE1ICs3LDE1IEBACiAKIAkuZmlsZQkicmVtYWluZGVyZi5TIgog
CS50ZXh0Ci0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZf
NjRfXykKIAkuYWxpZ24gOAotI2Vsc2UKKyNlbGlmIGRlZmluZWQoX19pMzg2
X18pCiAJLmFsaWduIDQKICNlbmRpZgogLmdsb2JsIF9fTUlOR1dfVVNZTUJP
TChyZW1haW5kZXIpCiAJLmRlZglfX01JTkdXX1VTWU1CT0wocmVtYWluZGVy
Zik7CS5zY2wJMjsJLnR5cGUJMzI7CS5lbmRlZgogX19NSU5HV19VU1lNQk9M
KHJlbWFpbmRlcmYpOgotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVk
KF9feDg2XzY0X18pCiAJbW92c3MJJXhtbTEsLTEyKCVyc3ApCiAJZmxkcwkt
MTIoJXJzcCkKIAltb3ZzcwkleG1tMCwtMTIoJXJzcCkKQEAgLTI4LDcgKzI4
LDcgQEAgX19NSU5HV19VU1lNQk9MKHJlbWFpbmRlcmYpOgogCWZzdHBzCS0x
MiglcnNwKQogCW1vdnNzCS0xMiglcnNwKSwleG1tMAogCXJldAotI2Vsc2UK
KyNlbGlmIGRlZmluZWQoX19pMzg2X18pCiAJZmxkcwk4KCVlc3ApCiAJZmxk
cwk0KCVlc3ApCiAxOglmcHJlbTEKQEAgLTM3LDQgKzM3LDggQEAgX19NSU5H
V19VU1lNQk9MKHJlbWFpbmRlcmYpOgogCWpwCTFiCiAJZnN0cAklc3QoMSkK
IAlyZXQKKyNlbGlmIF9fU0laRU9GX0xPTkdfRE9VQkxFX18gPT0gX19TSVpF
T0ZfRE9VQkxFX18KKwkvKiBBQXJjaDY0OiBzeXN0ZW0gbGlibSBwcm92aWRl
cyByZW1haW5kZXJmKCkgbmF0aXZlbHksIG5vIHN0dWIgbmVlZGVkICovCisj
ZWxzZQorCS5lcnJvciAiTm90IHN1cHBvcnRlZCBvbiB5b3VyIHBsYXRmb3Jt
IHlldCIKICNlbmRpZgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tYXRo
L3JlbWFpbmRlcmwuUyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9yZW1haW5kZXJs
LlMKaW5kZXggYTY5ZTM4Mjk2Li5mMDU3MjRlOTQgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vbWF0aC9yZW1haW5kZXJsLlMKKysrIGIvd2luc3VwL2N5
Z3dpbi9tYXRoL3JlbWFpbmRlcmwuUwpAQCAtNywxNSArNywxNSBAQAogCiAJ
LmZpbGUJInJlbWFpbmRlcmwuUyIKIAkudGV4dAotI2lmZGVmIF9feDg2XzY0
X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJLmFsaWduIDgKLSNlbHNl
CisjZWxpZiBkZWZpbmVkKF9faTM4Nl9fKQogCS5hbGlnbiA0CiAjZW5kaWYK
IC5nbG9ibCBfX01JTkdXX1VTWU1CT0wocmVtYWluZGVybCkKIAkuZGVmCV9f
TUlOR1dfVVNZTUJPTChyZW1haW5kZXJsKTsJLnNjbAkyOwkudHlwZQkzMjsJ
LmVuZGVmCiBfX01JTkdXX1VTWU1CT0wocmVtYWluZGVybCk6Ci0jaWZkZWYg
X194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAlmbGR0CSgl
cjgpCiAJZmxkdAkoJXJkeCkKIDE6CWZwcmVtMQpAQCAtMjcsNyArMjcsNyBA
QCBfX01JTkdXX1VTWU1CT0wocmVtYWluZGVybCk6CiAJbW92cQkkMCw4KCVy
Y3gpCiAJZnN0cHQJKCVyY3gpCiAJcmV0Ci0jZWxzZQorI2VsaWYgZGVmaW5l
ZChfX2kzODZfXykKIAlmbGR0CTE2KCVlc3ApCiAJZmxkdAk0KCVlc3ApCiAx
OglmcHJlbTEKQEAgLTM2LDQgKzM2LDkgQEAgX19NSU5HV19VU1lNQk9MKHJl
bWFpbmRlcmwpOgogCWpwCTFiCiAJZnN0cAklc3QoMSkKIAlyZXQKKyNlbGlm
IF9kZWZpbmVkKF9fYWFyY2g2NF9fKQorCWJsCXJlbWFpbmRlcgorCXJldAor
I2Vsc2UKKwkuZXJyb3IgIk5vdCBzdXBwb3J0ZWQgb24geW91ciBwbGF0Zm9y
bSB5ZXQiCiAjZW5kaWYKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0
aC9yZW1xdW9sLlMgYi93aW5zdXAvY3lnd2luL21hdGgvcmVtcXVvbC5TCmlu
ZGV4IGUxNmRmOGFkMi4uMzQwNDFkYzEyIDEwMDY0NAotLS0gYS93aW5zdXAv
Y3lnd2luL21hdGgvcmVtcXVvbC5TCisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0
aC9yZW1xdW9sLlMKQEAgLTcsMTQgKzcsMTQgQEAKIAogCS5maWxlCSJyZW1x
dW9sLlMiCiAgICAgICAgIC50ZXh0Ci0jaWZkZWYgX194ODZfNjRfXworI2lm
IGRlZmluZWQoX194ODZfNjRfXykKIAkuYWxpZ24gOAotI2Vsc2UKKyNlbGlm
IGRlZmluZWQoX19pMzg2X18pCiAJLmFsaWduIDQKICNlbmRpZgogLmdsb2Js
IF9fTUlOR1dfVVNZTUJPTChyZW1xdW9sKQogX19NSU5HV19VU1lNQk9MKHJl
bXF1b2wpOgotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2
XzY0X18pCiAJcHVzaHEJJXJjeAogICAgICAgICBmbGR0ICglcjgpCiAgICAg
ICAgIGZsZHQgKCVyZHgpCkBAIC00NSw3ICs0NSw3IEBAIF9fTUlOR1dfVVNZ
TUJPTChyZW1xdW9sKToKIAltb3ZxCSQwLDgoJXJjeCkKIAlmc3RwdAkoJXJj
eCkKICAgICAgICAgcmV0Ci0jZWxzZQorI2VsaWYgZGVmaW5lZChfX2kzODZf
XykKICAgICAgICAgZmxkdCA0ICsxMiglZXNwKQogICAgICAgICBmbGR0IDQo
JWVzcCkKIDE6CWZwcmVtMQpAQCAtNzIsNCArNzIsOSBAQCBfX01JTkdXX1VT
WU1CT0wocmVtcXVvbCk6CiAxOgltb3ZsICVlYXgsICglZWN4KQogCiAgICAg
ICAgIHJldAorI2VsaWYgX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJ
WkVPRl9ET1VCTEVfXworCWJsICByZW1xdW8KKyAgICAgICAgcmV0CisjZWxz
ZQorCS5lcnJvciAiTm90IHN1cHBvcnRlZCBvbiB5b3VyIHBsYXRmb3JtIHll
dCIKICNlbmRpZgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tYXRoL3Jp
bnRsLmMgYi93aW5zdXAvY3lnd2luL21hdGgvcmludGwuYwppbmRleCA5ZWMx
NTlkMTcuLmY5Y2ExNWYzMSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9t
YXRoL3JpbnRsLmMKKysrIGIvd2luc3VwL2N5Z3dpbi9tYXRoL3JpbnRsLmMK
QEAgLTksNyArOSw3IEBAIGxvbmcgZG91YmxlIHJpbnRsIChsb25nIGRvdWJs
ZSB4KSB7CiAgIGxvbmcgZG91YmxlIHJldHZhbCA9IDAuMEw7CiAjaWYgZGVm
aW5lZChfQU1ENjRfKSB8fCBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmlu
ZWQoX1g4Nl8pIHx8IGRlZmluZWQoX19pMzg2X18pCiAgIF9fYXNtX18gX192
b2xhdGlsZV9fICgiZnJuZGludDsiOiAiPXQiIChyZXR2YWwpIDogIjAiICh4
KSk7Ci0jZWxpZiBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX0FSTV8p
CisjZWxpZiBfX1NJWkVPRl9MT05HX0RPVUJMRV9fID09IF9fU0laRU9GX0RP
VUJMRV9fCiAgICAgcmV0dmFsID0gcmludCh4KTsKICNlbmRpZgogICByZXR1
cm4gcmV0dmFsOwpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tYXRoL3Nj
YWxibC5TIGIvd2luc3VwL2N5Z3dpbi9tYXRoL3NjYWxibC5TCmluZGV4IGY5
Njc1YWM0Yi4uY2E2NmM2ZGZhIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2lu
L21hdGgvc2NhbGJsLlMKKysrIGIvd2luc3VwL2N5Z3dpbi9tYXRoL3NjYWxi
bC5TCkBAIC03LDE1ICs3LDE1IEBACiAKIAkuZmlsZQkic2NhbGJsLlMiCiAJ
LnRleHQKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82
NF9fKQogCS5hbGlnbiA4Ci0jZWxzZQorI2VsaWYgZGVmaW5lZChfX2kzODZf
XykKIAkuYWxpZ24gNAogI2VuZGlmCiAuZ2xvYmwgX19NSU5HV19VU1lNQk9M
KHNjYWxibCkKIAkuZGVmCV9fTUlOR1dfVVNZTUJPTChzY2FsYmwpOwkuc2Ns
CTI7CS50eXBlCTMyOwkuZW5kZWYKIF9fTUlOR1dfVVNZTUJPTChzY2FsYmwp
OgotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18p
CiAJc3VicSAgJDI0LCAlcnNwCiAJZmxkdAkoJXI4KQogCWZsZHQJKCVyZHgp
CkBAIC0yNiwxMCArMjYsMjUgQEAgX19NSU5HV19VU1lNQk9MKHNjYWxibCk6
CiAJZnN0cHQJKCVyY3gpCiAJYWRkcSAkMjQsICVyc3AKIAlyZXQKLSNlbHNl
CisjZWxpZiBkZWZpbmVkKF9faTM4Nl9fKQogCWZpbGRsCTE2KCVlc3ApCiAJ
ZmxkdAk0KCVlc3ApCiAJZnNjYWxlCiAJZnN0cAklc3QoMSkKIAlyZXQKKyNl
bGlmIF9fU0laRU9GX0xPTkdfRE9VQkxFX18gPT0gX19TSVpFT0ZfRE9VQkxF
X18KKyAgICBmY3Z0enMgeDEsIGQxCisgICAgZm1vdiB4MCwgZDAKKyAgICB1
YmZ4IHgyLCB4MCwgIzUyLCAjMTEKKyAgICBhZGQgeDIsIHgyLCB4MQorICAg
IGNtcCB4MiwgIzAKKyAgICBjc2VsIHgyLCB4enIsIHgyLCBsdAorICAgIG1v
diB4MywgIzB4N0ZGCisgICAgY21wIHgyLCB4MworICAgIGNzZWwgeDIsIHgy
LCB4MywgbHQKKyAgICBiZmkgeDAsIHgyLCAjNTIsICMxMQorICAgIGZtb3Yg
ZDAsIHgwCisgICAgcmV0CisjZWxzZQorCS5lcnJvciAidW5pbXBsZW1lbnRl
ZCBmb3IgdGhpcyB0YXJnZXQgeWV0IgogI2VuZGlmCmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL21hdGgvc2NhbGJubC5TIGIvd2luc3VwL2N5Z3dpbi9t
YXRoL3NjYWxibmwuUwppbmRleCA1ZmYwYTY4ZjMuLjk2ZTU3ZTc3YyAxMDA2
NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9tYXRoL3NjYWxibmwuUworKysgYi93
aW5zdXAvY3lnd2luL21hdGgvc2NhbGJubC5TCkBAIC03LDE1ICs3LDE1IEBA
CiAKIAkuZmlsZQkic2NhbGJubC5TIgogCS50ZXh0Ci0jaWZkZWYgX194ODZf
NjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAkuYWxpZ24gOAotI2Vs
c2UKKyNlbGlmIGRlZmluZWQoX19pMzg2X18pCiAJLmFsaWduIDQKICNlbmRp
ZgogLmdsb2JsIF9fTUlOR1dfVVNZTUJPTChzY2FsYm5sKQogCS5kZWYJX19N
SU5HV19VU1lNQk9MKHNjYWxibmwpOwkuc2NsCTI7CS50eXBlCTMyOwkuZW5k
ZWYKIF9fTUlOR1dfVVNZTUJPTChzY2FsYm5sKToKLSNpZmRlZiBfX3g4Nl82
NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogCXN1YnEgICQyNCwgJXJz
cAogCWFuZGwgICAgJC0xLCAlcjhkCiAJbW92cQklcjgsICglcnNwKQpAQCAt
MjgsMTQgKzI4LDIxIEBAIF9fTUlOR1dfVVNZTUJPTChzY2FsYm5sKToKIAlm
c3RwdAkoJXJjeCkKIAlhZGRxICQyNCwgJXJzcAogCXJldAotI2Vsc2UKKyNl
bGlmIGRlZmluZWQoX19pMzg2X18pCiAJZmlsZGwJMTYoJWVzcCkKIAlmbGR0
CTQoJWVzcCkKIAlmc2NhbGUKIAlmc3RwCSVzdCgxKQogCXJldAorI2VsaWYg
X19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVfXwor
CXNjdnRmIGQxLCB3MQorCWZtb3YgZDIsICMyLjAKKwlibCBwb3cKKwlmbXVs
IGQwLCBkMCwgZDEKKwlyZXQKKyNlbHNlCisJLmVycm9yICJOb3Qgc3VwcG9y
dGVkIG9uIHlvdXIgcGxhdGZvcm0geWV0IgogI2VuZGlmCiAKIC5nbG9ibCBf
X01JTkdXX1VTWU1CT0woc2NhbGJsbmwpCiAJLnNldAlfX01JTkdXX1VTWU1C
T0woc2NhbGJsbmwpLF9fTUlOR1dfVVNZTUJPTChzY2FsYm5sKQotCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL21hdGgvc2lubF9pbnRlcm5hbC5TIGIv
d2luc3VwL2N5Z3dpbi9tYXRoL3NpbmxfaW50ZXJuYWwuUwppbmRleCA2ZDc2
NmIwOTguLjlkZWYwYWMwZSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9t
YXRoL3NpbmxfaW50ZXJuYWwuUworKysgYi93aW5zdXAvY3lnd2luL21hdGgv
c2lubF9pbnRlcm5hbC5TCkBAIC03LDE1ICs3LDE1IEBACiAKIAkuZmlsZQki
c2lubF9pbnRlcm5hbC5TIgogCS50ZXh0Ci0jaWZkZWYgX194ODZfNjRfXwor
I2lmIGRlZmluZWQoX194ODZfNjRfXykKIAkuYWxpZ24gOAotI2Vsc2UKKyNl
bGlmIGRlZmluZWQoX19pMzg2X18pCiAJLmFsaWduIDQKICNlbmRpZgogLmds
b2JsIF9fTUlOR1dfVVNZTUJPTChfX3NpbmxfaW50ZXJuYWwpCiAJLmRlZglf
X01JTkdXX1VTWU1CT0woX19zaW5sX2ludGVybmFsKTsJLnNjbAkyOwkudHlw
ZQkzMjsJLmVuZGVmCiBfX01JTkdXX1VTWU1CT0woX19zaW5sX2ludGVybmFs
KToKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9f
KQogCWZsZHQJKCVyZHgpCiAJZnNpbgogCWZuc3RzdwklYXgKQEAgLTM4LDcg
KzM4LDcgQEAgX19NSU5HV19VU1lNQk9MKF9fc2lubF9pbnRlcm5hbCk6CiAJ
bW92cQkkMCw4KCVyY3gpCiAJZnN0cHQJKCVyY3gpCiAJcmV0Ci0jZWxzZQor
I2VsaWYgZGVmaW5lZChfX2kzODZfXykKIAlmbGR0CTQoJWVzcCkKIAlmc2lu
CiAJZm5zdHN3CSVheApAQCAtNTUsNCArNTUsOSBAQCBfX01JTkdXX1VTWU1C
T0woX19zaW5sX2ludGVybmFsKToKIAlmc3RwCSVzdCgxKQogCWZzaW4KIAly
ZXQKKyNlbGlmIF9fU0laRU9GX0xPTkdfRE9VQkxFX18gPT0gX19TSVpFT0Zf
RE9VQkxFX18KKwlibAlzaW4KKwlyZXQKKyNlbHNlCisJLmVycm9yICJOb3Qg
c3VwcG9ydGVkIG9uIHlvdXIgcGxhdGZvcm0geWV0IgogI2VuZGlmCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL21hdGgvc3FydC5kZWYuaCBiL3dpbnN1
cC9jeWd3aW4vbWF0aC9zcXJ0LmRlZi5oCmluZGV4IDNkMWEwMDkwOC4uZTNm
YmJhODFhIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21hdGgvc3FydC5k
ZWYuaAorKysgYi93aW5zdXAvY3lnd2luL21hdGgvc3FydC5kZWYuaApAQCAt
ODksNiArODksOCBAQCBfX0ZMVF9BQkkgKHNxcnQpIChfX0ZMVF9UWVBFIHgp
CiAgIF9fZnNxcnRfaW50ZXJuYWwoeCk7CiAjZWxpZiBkZWZpbmVkKF9YODZf
KSB8fCBkZWZpbmVkKF9faTM4Nl9fKSB8fCBkZWZpbmVkKF9BTUQ2NF8pIHx8
IGRlZmluZWQoX194ODZfNjRfXykKICAgYXNtIHZvbGF0aWxlICgiZnNxcnQi
IDogIj10IiAocmVzKSA6ICIwIiAoeCkpOworI2VsaWYgX19TSVpFT0ZfTE9O
R19ET1VCTEVfXyA9PSBfX1NJWkVPRl9ET1VCTEVfXworICBhc20gdm9sYXRp
bGUgKCJmc3FydCAlZDAsICVkMSIgOiAiPXciKHJlcykgOiAidyIoeCkpOwog
I2Vsc2UKICNlcnJvciBOb3Qgc3VwcG9ydGVkIG9uIHlvdXIgcGxhdGZvcm0g
eWV0CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC90
YW5sLlMgYi93aW5zdXAvY3lnd2luL21hdGgvdGFubC5TCmluZGV4IGYxMWI1
MzkyMC4uN2I2MmRhYmFkIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21h
dGgvdGFubC5TCisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC90YW5sLlMKQEAg
LTcsMTUgKzcsMTUgQEAKIAogCS5maWxlCSJ0YW5sLlMiCiAJLnRleHQKLSNp
ZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogCS5h
bGlnbiA4Ci0jZWxzZQorI2VsaWYgZGVmaW5lZChfX2kzODZfXykKIAkuYWxp
Z24gNAogI2VuZGlmCiAuZ2xvYmwgX19NSU5HV19VU1lNQk9MKHRhbmwpCiAJ
LmRlZglfX01JTkdXX1VTWU1CT0wodGFubCk7CS5zY2wJMjsJLnR5cGUJMzI7
CS5lbmRlZgogX19NSU5HV19VU1lNQk9MKHRhbmwpOgotI2lmZGVmIF9feDg2
XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJZmxkdAkoJXJkeCkK
IAlmcHRhbgogCWZuc3RzdwklYXgKQEAgLTQwLDcgKzQwLDcgQEAgX19NSU5H
V19VU1lNQk9MKHRhbmwpOgogCW1vdnEJJDAsOCglcmN4KQogCWZzdHB0CSgl
cmN4KQogCXJldAotI2Vsc2UKKyNlbGlmIGRlZmluZWQoX19pMzg2X18pCiAJ
ZmxkdAk0KCVlc3ApCiAJZnB0YW4KIAlmbnN0c3cJJWF4CkBAIC01OSw0ICs1
OSw5IEBAIF9fTUlOR1dfVVNZTUJPTCh0YW5sKToKIAlmcHRhbgogCWZzdHAJ
JXN0KDApCiAJcmV0CisjZWxpZiBfX1NJWkVPRl9MT05HX0RPVUJMRV9fID09
IF9fU0laRU9GX0RPVUJMRV9fCisJYmwJdGFuCisJcmV0CisjZWxzZQorCS5l
cnJvciAiTm90IHN1cHBvcnRlZCBvbiB5b3VyIHBsYXRmb3JtIHlldCIKICNl
bmRpZgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tYXRoL3RydW5jbC5j
IGIvd2luc3VwL2N5Z3dpbi9tYXRoL3RydW5jbC5jCmluZGV4IDkzODBmOTU3
MS4uODZlNzFkMTA4IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21hdGgv
dHJ1bmNsLmMKKysrIGIvd2luc3VwL2N5Z3dpbi9tYXRoL3RydW5jbC5jCkBA
IC0xMyw3ICsxMyw3IEBACiBsb25nIGRvdWJsZQogdHJ1bmNsIChsb25nIGRv
dWJsZSBfeCkKIHsKLSNpZiBkZWZpbmVkKF9BUk1fKSB8fCBkZWZpbmVkKF9f
YXJtX18pCisjaWYgX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJWkVP
Rl9ET1VCTEVfXwogICByZXR1cm4gdHJ1bmMoX3gpOwogI2Vsc2UKICAgbG9u
ZyBkb3VibGUgcmV0dmFsID0gMC4wTDsKQEAgLTI2LDUgKzI2LDUgQEAgdHJ1
bmNsIChsb25nIGRvdWJsZSBfeCkKICAgX19hc21fXyBfX3ZvbGF0aWxlX18g
KCJmcm5kaW50OyIgOiAiPXQiIChyZXR2YWwpICA6ICIwIiAoX3gpKTsgLyog
cm91bmQgdG93YXJkcyB6ZXJvICovCiAgIF9fYXNtX18gX192b2xhdGlsZV9f
ICgiZmxkY3cgJTA7IiA6IDogIm0iIChzYXZlZF9jdykgKTsgLyogcmVzdG9y
ZSBzYXZlZCBjb250cm9sIHdvcmQgKi8KICAgcmV0dXJuIHJldHZhbDsKLSNl
bmRpZiAvKiBkZWZpbmVkKF9BUk1fKSB8fCBkZWZpbmVkKF9fYXJtX18pICov
CisjZW5kaWYgLyogX19TSVpFT0ZfTE9OR19ET1VCTEVfXyA9PSBfX1NJWkVP
Rl9ET1VCTEVfXyAqLwogfQotLSAKMi40OS4wLndpbmRvd3MuMQoK

--_004_PN0P287MB029594AE234FC6A4B7F6B23A92342PN0P287MB0295INDP_--
