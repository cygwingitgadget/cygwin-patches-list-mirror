Return-Path: <SRS0=0OBO=ZC=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id 483093857C7A
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 20:21:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 483093857C7A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 483093857C7A
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750364504; cv=pass;
	b=FpE6x1hX0RlQF2Bh2b1mvIC3N39eWeVt2mf8gCiT0ds7KmyJM3ZIPjT7QTcj30HOHE11sQ/bGW74fGlXjGjPhna/6VQy5ExRatqOakexmqO1wLMnaOqWvrdbaIItyEw9lEx5qtJSz6ZJS+Xnu3+yN3Dl9KSOxVsi/LRkBjS2jvI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750364504; c=relaxed/simple;
	bh=gVYcDLit0VOs3uGu2SWV75L0hhgxzmeIE2kXjKiJMqo=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=maYifYrz1v+QB1vQo6IlO+qid/X6gcpmYNQBhIaEPljhuou2A4Lu5K3hkxZsrZUWzpbys1p8ruy0D1MwkihEDQMXt6kUEJXt8zEdVLCXEzo/FkY2oLv6n9SfiXTNA1Oufx75Wn4stw/r4Yr2KYw52FKzxmVLfoEm7IFhxgwxa2k=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 483093857C7A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=jBJBIUfG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6UaAzncj5FpRnZSzxAxSGhx0efi95GnO9XvoVLrEecVj4T0bGI4BYRTn9nLWkKl7IrhOEpXBCE0KMm0l4s+puoXDGFusytPFsWxK7g0fyYipZ871ju3BU9ZRRXYOLTLkl9qZGxnPLihgRNAb1fmL4KANT+qOQAiY1k5ID9bgX2lFmlBaPZ9Z5d8cAb7GF87DJ3BMfDZez3Cf7NB2szGR+UFXEC4oleC/sEDVG7jKCAMrZm9wbQNhUu1JLuBgEwIi82+auRvMg1Cso1zyZKEElXN562ac3haPzgCHWNTJDaZAd0i9+LYckNrbcqBMjaTPPxthJsR5BktW29edt6k6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14ugz17rXowLPnUuZplgEzcDjzvqYZ8repq/6ol4xe4=;
 b=KiOpI/viey284MplF7EcMY9pim56aVmCae9lzN5iT3IFcQ4N+22XLX5bTN9lZO2EL2zKW9D/Cggg4v02iebNzbUFSmDw3zb+1kiNVabPM1T2LZIsFxsiaJfQ0eCt4jLZ8fdW4zaXM0HASg56pqsXKDOSnLeepA/0EZR6s9jyYIM21HyVFeS4Y7DHL3gibEMYB3dUYUXTAwm6jTYjSuHWGAGWPZ+W5w0fYy/i4uhH/BGh6jt2/jnki7HSwWZ82u8XHrYcXYojNbynHC+P8desjHw4jeHXCIFaGaoiyL1o2bIfX8qWAQg3UAxlXZ3LTpOD3mtxVe2pjPlosiJI4FTZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14ugz17rXowLPnUuZplgEzcDjzvqYZ8repq/6ol4xe4=;
 b=jBJBIUfG81wx4cOpGVMI/dOwh3CEb73aD7K07gXalAxclBedGc6lxUfz6yOv88KqSpi8WMcJlMZAMWtvKGMAqyitkOmgqYl9SS1/tX06wAhL3a7G/Q63tUXCt6UQk5ebfTIx3BmpTDvIjo0o0H7iMeOQ/afYOBuCGHnrJiISNI3m22UFdltUmVY5hH7RCRdT6Yz7hfANC5ZTiIyvKOgbQCZLo0ODX327thy5UhjB+MscrwtVJ5h/cTLkrGUsNok4BNTUSVlwYMVC3Uk405gON2s1tjCZ1qBVd58sambUAqEz9/kzv45NkERJH87xlAmHZDaW7dPqaJefxjZ5N21jeA==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN0P287MB0654.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:161::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 20:21:40 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%3]) with mapi id 15.20.8857.022; Thu, 19 Jun 2025
 20:21:39 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V3] Cygwin: Aarch64: Add inline assembly pthread wrapper
Thread-Topic: [PATCH V3] Cygwin: Aarch64: Add inline assembly pthread wrapper
Thread-Index: AQHb4VfDiBk+x+msBkC6vphmPJZ+DA==
Date: Thu, 19 Jun 2025 20:21:39 +0000
Message-ID:
 <MA0P287MB3082E27CFAF3DA9D90A59F939F7DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM>
 <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
In-Reply-To: <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN0P287MB0654:EE_
x-ms-office365-filtering-correlation-id: 54f73d36-db83-4b4c-f362-08ddaf6ee62f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kz+sWAFM5Vp7mg0y9FgMx9rKve7eUW4RbcuM4DLQGGOBuZ8cnujFvR3trKfH?=
 =?us-ascii?Q?tkhZ5SL2afuQeBsCwjjcW7A/Cjy6EPVyULrOF4Nwjt/RCL2IHV2rKE34nrcS?=
 =?us-ascii?Q?+uq1nQehJUx0PRMEvl+iOfBT4YWRr+Yjltfj65krYyXkRBWUDe5mAJ3u3ZDu?=
 =?us-ascii?Q?k5eI/amnzX9BM+KaFLiA+0j8LuVcisrt3EQ+Em0/wgPxmI16Xpd7WFZYEoB6?=
 =?us-ascii?Q?QHFZvSXlkj3/R1XbNoRbXlDVqy3XN9jo4yqFHkmSiLHnJUrZ7dQMsDIRx23K?=
 =?us-ascii?Q?0EgMe7iXLtH1fv+cgYhGp3erHGpPP+q9julKjn6OTBq0F7tixem2bDDGARK+?=
 =?us-ascii?Q?+QG8NOiV+AIjKmqbl/PuL3ESnLq4BPqvXc1H4Z+i3xX2SD5wl1NvWZlA1SSy?=
 =?us-ascii?Q?Yl0J/UyQR8a3AP31wtk1PWtDSvVFDp7Y7Ze4bbdV76oKhWze60XaTs4c4mWU?=
 =?us-ascii?Q?N9Qr5U9KJ9y98ZZPrcVEF3yhbcf6H8zBCs/IpWV5ldbAhaXR+t+x7U/hOGzF?=
 =?us-ascii?Q?siAORcaYkT8VHPvWnEHCEIujD/dhLMZF/CR0nB1ceqm87PpQlbiEjHxFWzOb?=
 =?us-ascii?Q?AvZzhxMh8E2TDI9dWZBX1Q2gxTgLXGSPVlX5XVf3l9Y46y9O+2XynH3PNVcK?=
 =?us-ascii?Q?Hy3MTFJPeWZ9NIKR5G4NS5zAmqY2QWZGC4IIZ6JB6taVOV8XmhsyzcrHVwuZ?=
 =?us-ascii?Q?3rs1kJsRO6Y5sGazoTzyzThtn6E7MhVsTVlEeF3b850Y55Hlyh7Ffu+62J3w?=
 =?us-ascii?Q?w6OX/OzObZ4pynECCQtkldZXy1+Nbwiw8ryHFah+SNigcD/O6EHl3aPL3yOX?=
 =?us-ascii?Q?sk66Bko9xaCrPPuzqpa7WZD25c0QQfJ8wYXMypliT2s+1hRakxK3gcOA89Qo?=
 =?us-ascii?Q?19Rt5LwyYH9dLJsE2dlgt+WR563umNabZyRF2EBFvDQzjVOdm9X4qse9DN2h?=
 =?us-ascii?Q?vQkiMy+lcKVIRdrJPSgoj1nECZ29cAM+ICXStZeI0+JGppGLtm0gmMb5Mvku?=
 =?us-ascii?Q?ccNX1TV7H2DXii5GDilKVnW7pRh68rUv+i26VYax97Ck8S+1Rtl+e8CSTYYY?=
 =?us-ascii?Q?KcMljPFiwcuar69iKyEFrC7X0mMCTpIv/41IGv0/RsOpAT4cZ8OIq0iwoL9A?=
 =?us-ascii?Q?VfU7elak2Co9PGTU6XaO8A+TvGspYSiTk/gFa7ZOU9DBpJH3QW7aCC9R+gU/?=
 =?us-ascii?Q?2AiOVZisKFYKAFtY+XOo5/7hQW17zppaXyRMKfX/+RbCX/sCh1+QYW0h4ucE?=
 =?us-ascii?Q?S9hHkgOOagoP00IU3FRdebyNEvXk8+cBjha/O+vplFvcipKson4vFU/qepLL?=
 =?us-ascii?Q?YtK3CH3cv2KxbLO3pOuYiE4IdRpfhj/yRgkCvGGHaK6KP1D5IJWlr3Itjulx?=
 =?us-ascii?Q?evIalrpdo/Vg9BNGvWFmap4NOnT5ZmgkesyKQbdER2avnJIvzhmGDqAERWYJ?=
 =?us-ascii?Q?knohdq9Squ13NizogHEZaBg7arEzcezM1gYi807NknH6A6uCnMcxaGkxMtk+?=
 =?us-ascii?Q?k4zcNtK8Jou78VI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kFhrqi2+oZIpaa7aBpPIKuP7xvB/5tT2zRlgfgHKnR2NlwDTwaqROTXeX3Hg?=
 =?us-ascii?Q?Efedt7etQzECviFRN7yY4CDXFBcVY5Ujnlq1gc+cC6CZ7V6KbiZrZ0SI2XAy?=
 =?us-ascii?Q?GCQQSsXV6utTZ5v/pbDMXgpD6iNpw2ItCisM2g4C/WAcGs9EKnHCQgkSt2GZ?=
 =?us-ascii?Q?H93Oxm4bcchh/WtT5y4V3VsJQBohzF0ZiZfW8FUQliBj8HfNevP4U/LoIGVV?=
 =?us-ascii?Q?Qkr5JuZ80ra1hGeUpnQ6NutSlR+i1uOfGV5nf0TfmYYBa31rkPk6JrIRKSyK?=
 =?us-ascii?Q?MOzBFyfD0GD0vYo+fiYg0FQjMZEAA1h3iZKMu133QVKzyqY/S9ekqUuKd5dn?=
 =?us-ascii?Q?fvYZB603Y/59E3fcQ4VhjnM4d93JuQl6/KRQ+kHE+FyrPi13sALTbXGHAXgc?=
 =?us-ascii?Q?yJl4FNVmb2L4ytoVGwL1+lDOnZ3FpIKiOKe93U65Y8/MDekbwdWNlyS+X2LP?=
 =?us-ascii?Q?YrmHYPZ4MUCKCng6Hv0HwhY1jaSGjsu3lrDTM0iJptQmhlwef8F09QClFr6W?=
 =?us-ascii?Q?tnnti5JMduQT5T9NyfcDlsVVazMXMJWO8l3GHsKfj7ra9OuzpbGZPGFLltYG?=
 =?us-ascii?Q?V16hJ/bR8yLB6QL6Shr+5Y1JOk3D/+MXDCEsRnZDVgf4Aqk6QnqB6TwwYt2g?=
 =?us-ascii?Q?vHQqYGQJp8xyPe3Lv6ntxeyKZw7cBW8mkq1DbGhb/je0fCBevkJNUx0vfwSK?=
 =?us-ascii?Q?AiFIFAMBpWYQChjuZvSM2dNaXQjsOuD74VgIM4AgCEM/p8hIOEOklgw1F6OA?=
 =?us-ascii?Q?qwsCYJgUF9Y0C2A76Lv+KCNZAN/gNXTaUCBpk5enMFcz01IzWvDpREiYnMO6?=
 =?us-ascii?Q?xVGMMw/jHA1wc50PiBKiaoa0OoyVdePVEruiH5GDk+2L9W7J0afgVk/Ve2x9?=
 =?us-ascii?Q?SrvJ7Xb3eh8+4TgVujf+Gc7+U+eCEHKV/ftCLB6CTDkWdrzk/Z/2hNyNExYC?=
 =?us-ascii?Q?ixpDsbFu/C8ageacewNiYaZrViKf5BPQD9DQTCjlgfDnPwu3u2J8EN5n4B3w?=
 =?us-ascii?Q?3qOArABMhwvoGmH1VjQZ0zkfNHlChOYUxlgxi15H4IDzpBgrbzwgK3GawBfh?=
 =?us-ascii?Q?nwSb3cQOiBkZr/Ha7LKfFvK77kDqYpUF1x0BAc2XdigzSmV40UYS40SWDFH7?=
 =?us-ascii?Q?RhqT1ssoo36z4DxyV1onu7oLkWhliNoXf4soV4ArTfdTOUIjDvk7+HAwiOsS?=
 =?us-ascii?Q?9H5nkkGZmDUKSMI8tAekyYnaIrVTlLx+3APXEZ7GNzqhjlS7SFaOQXchu8TN?=
 =?us-ascii?Q?OsEADHZALJhDeFJ3/FpPjSTOPn3x7zq3WFC8gV1aXZIyQnvoxplLnXfR9kMp?=
 =?us-ascii?Q?RB8/i2alG0ZtqrhTWQQvJaGeTwyIYkk6i1JOYHmmT4Y8y5e5y/ajwPLsXH2V?=
 =?us-ascii?Q?8Z8FMCC9HCbYjwsqe2ugq7lN/6gb4ZkeLKyWAd5hiZmrvfK0Yr2dzxUtmJ/p?=
 =?us-ascii?Q?1TYALs2m0plaEcprfC2dygRA8d4ckn4Cdkftkfr/moJSJG4oo4NlVK62YsZC?=
 =?us-ascii?Q?r1BaWVtsCuWT6IgcR+DSVH+y+AwNkbzt1TJh8vEyVcQIu+H6dOaQCmzpH62h?=
 =?us-ascii?Q?s+AjGXfvhXzlJIKdzehxZm7GJgV4xvWSge6hmKHOgr8Gvq91KSJG15uCXn/H?=
 =?us-ascii?Q?WXq3cIPFFxR+XSbzIzNFmnHnf6otMasB7FLvS7igRIPR?=
Content-Type: multipart/mixed;
	boundary="_002_MA0P287MB3082E27CFAF3DA9D90A59F939F7DAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f73d36-db83-4b4c-f362-08ddaf6ee62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 20:21:39.9064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTFMVC/YV4X0m3Q/4ph7WnDPSAYlzpn26y3wt0e1+qKh5/iK3IJ10tARZtreFTA9G9ZneAKA/INFKfdMTl3iTUoeq4nGco3xewOXzZJ32L29EIO8/LIzzBuw0MJf170WWGrMjwnw2mzW9FMIFUmEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0654
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_MA0P287MB3082E27CFAF3DA9D90A59F939F7DAMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Resending as v3 - no code changes from v2.
Just updated the commit message to remove the outdated note about shadow sp=
ace.

Patch is included below (inline) and attached for convenience.

From 84ee99298f1a18d05cf4ef8bb9ae5314cbb78241 Mon Sep 17 00:00:00 2001
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Date: Fri, 20 Jun 2025 01:45:56 +0530
Subject: [PATCH] Aarch64: Add inline assembly pthread wrapper

This patch adds AArch64-specific inline assembly block for the pthread
wrapper used to bootstrap new threads. It sets up the thread stack,
adjusts for __CYGTLS_PADSIZE__, releases the original stack via
VirtualFree, and invokes the target thread function.
---
 winsup/cygwin/create_posix_thread.cc | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_po=
six_thread.cc
index 3fcd61707..d0d3096b2 100644
--- a/winsup/cygwin/create_posix_thread.cc
+++ b/winsup/cygwin/create_posix_thread.cc
@@ -75,7 +75,7 @@ pthread_wrapper (PVOID arg)
   /* Initialize new _cygtls. */
   _my_tls.init_thread (wrapper_arg.stackbase - __CYGTLS_PADSIZE__,
 		       (DWORD (*)(void*, void*)) wrapper_arg.func);
-#ifdef __x86_64__
+#if defined(__x86_64__)
   __asm__ ("\n\
 	   leaq  %[WRAPPER_ARG], %%rbx	# Load &wrapper_arg into rbx	\n\
 	   movq  (%%rbx), %%r12		# Load thread func into r12	\n\
@@ -99,6 +99,23 @@ pthread_wrapper (PVOID arg)
 	   call  *%%r12			# Call thread func		\n"
 	   : : [WRAPPER_ARG] "o" (wrapper_arg),
 	       [CYGTLS] "i" (__CYGTLS_PADSIZE__));
+#elif defined(__aarch64__)
+  /* Sets up a new thread stack, frees the original OS stack,
+   * and calls the thread function with its arg using AArch64 ABI. */
+  __asm__ __volatile__ ("\n\
+	   mov     x19, %[WRAPPER_ARG]           // x19 =3D &wrapper_arg         =
 \n\
+	   ldr     x10, [x19, #24]               // x10 =3D wrapper_arg.stackbase=
 \n\
+	   sub     sp, x10, %[CYGTLS]            // sp =3D stackbase - (CYGTLS)  =
 \n\
+	   mov     fp, xzr                       // clear frame pointer (x29)   \=
n\
+	   mov     x0, [x19, #16]                // x0 =3D wrapper_arg.stackaddr =
 \n\
+	   mov     x1, xzr                       // x1 =3D 0 (dwSize)            =
 \n\
+	   mov     x2, #0x8000                   // x2 =3D MEM_RELEASE           =
 \n\
+	   bl      VirtualFree                   // free original stack         \=
n\
+	   ldp     x19, x0, [x19]                // x19 =3D func, x0 =3D arg     =
   \n\
+	   blr     x19                           // call thread function        \=
n"
+	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
+	       [CYGTLS] "r" (__CYGTLS_PADSIZE__)
+	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
 #else
 #error unimplemented for this target
 #endif
--=20
2.49.0.windows.1


Thanks,
Thirumalai Nagalingam

-----Original Message-----
From: Jeremy Drake <cygwin@jdrake.com>=20
Sent: 18 June 2025 23:22
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Aarch64: Add inline assembly pthread wrapper

On Thu, 5 Jun 2025, Thirumalai Nagalingam wrote:

> Hello,
>
> Please find my patch attached for review.

Please either send patches via something like git send-email that puts the =
patch in the body, or if you can't send patches in that way without some ma=
il software mangling them, please include the patch in the body of the emai=
l in addition to attaching it, for easier review.

>
> This patch adds AArch64-specific inline assembly block for the pthread=20
> wrapper used to bootstrap new threads. It sets up the thread stack,=20
> adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original=20
> stack via VirtualFree, and invokes the target thread function.
>
> Thanks & regards
> Thirumalai Nagalingam
>


> From c897d7361356c73b5837afa466f78a58520c1e9e Mon Sep 17 00:00:00 2001
> From: Thirumalai Nagalingam=20
> <thirumalai.nagalingam@multicorewareinc.com>
> Date: Thu, 5 Jun 2025 00:30:48 -0700
> Subject: [PATCH] Aarch64: Add inline assembly pthread wrapper
>
> This patch adds AArch64-specific inline assembly block for the pthread=20
> wrapper used to bootstrap new threads. It sets up the thread stack,=20
> adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original=20
> stack via VirtualFree, and invokes the target thread function.
> ---
>  winsup/cygwin/create_posix_thread.cc | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/create_posix_thread.cc=20
> b/winsup/cygwin/create_posix_thread.cc
> index 8e06099e4..b1d0cbb43 100644
> --- a/winsup/cygwin/create_posix_thread.cc
> +++ b/winsup/cygwin/create_posix_thread.cc
> @@ -75,7 +75,7 @@ pthread_wrapper (PVOID arg)
>    /* Initialize new _cygtls. */
>    _my_tls.init_thread (wrapper_arg.stackbase - __CYGTLS_PADSIZE__,
>  		       (DWORD (*)(void*, void*)) wrapper_arg.func); -#ifdef=20
> __x86_64__
> +#if defined(__x86_64__)
>    __asm__ ("\n\
>  	   leaq  %[WRAPPER_ARG], %%rbx	# Load &wrapper_arg into rbx	\n\
>  	   movq  (%%rbx), %%r12		# Load thread func into r12	\n\
> @@ -99,6 +99,23 @@ pthread_wrapper (PVOID arg)
>  	   call  *%%r12			# Call thread func		\n"
>  	   : : [WRAPPER_ARG] "o" (wrapper_arg),
>  	       [CYGTLS] "i" (__CYGTLS_PADSIZE__));
> +#elif defined(__aarch64__)
> +  /* Sets up a new thread stack, frees the original OS stack,
> +   * and calls the thread function with its arg using AArch64 ABI. */
> +  __asm__ __volatile__ ("\n\
> +	   mov     x19, %[WRAPPER_ARG]           // x19 =3D &wrapper_arg       =
     \n\
> +	   ldr     x10, [x19, #24]               // x10 =3D wrapper_arg.stackba=
se   \n\
> +	   sub     sp, x10, %[CYGTLS]            // sp =3D stackbase - (CYGTLS =
+ 32)\n\
> +	   mov     fp, xzr                       // clear frame pointer (x29)  =
   \n\
> +	   mov     x0, sp                        // x0 =3D new stack pointer   =
     \n\

This seems wrong.  Shouldn't it be
           mov     x0, [x19, #16]                // x0 =3D wrapper_arg.stac=
kaddr

> +	   mov     x1, xzr                       // x1 =3D 0 (dwSize)          =
     \n\
> +	   mov     x2, #0x8000                   // x2 =3D MEM_RELEASE         =
     \n\
> +	   bl      VirtualFree                   // free original stack        =
   \n\
> +	   ldp     x19, x0, [x19]                // x19 =3D func, x0 =3D arg   =
       \n\
> +	   blr     x19                           // call thread function       =
   \n"
> +	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
> +	       [CYGTLS] "r" (__CYGTLS_PADSIZE__ + 32) // add 32 bytes shadow=20
> +space

I asked this on another patch, but is the 32-byte shadow area actually part=
 of the aarch64 calling convention, or is this just following what x64 was =
doing (where it is part of the calling convention)

> +	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
>  #else
>  #error unimplemented for this target
>  #endif
> --
> 2.34.1
>

--_002_MA0P287MB3082E27CFAF3DA9D90A59F939F7DAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch"
Content-Description: 0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch
Content-Disposition: attachment;
	filename="0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch"; size=2583;
	creation-date="Thu, 19 Jun 2025 19:52:54 GMT";
	modification-date="Thu, 19 Jun 2025 20:21:39 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NGVlOTkyOThmMWExOGQwNWNmNGVmOGJiOWFlNTMxNGNiYjc4MjQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogRnJpLCAyMCBKdW4gMjAyNSAwMTo0
NTo1NiArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEFhcmNoNjQ6IEFkZCBpbmxpbmUgYXNzZW1ibHkg
cHRocmVhZCB3cmFwcGVyCgpUaGlzIHBhdGNoIGFkZHMgQUFyY2g2NC1zcGVjaWZpYyBpbmxpbmUg
YXNzZW1ibHkgYmxvY2sgZm9yIHRoZSBwdGhyZWFkCndyYXBwZXIgdXNlZCB0byBib290c3RyYXAg
bmV3IHRocmVhZHMuIEl0IHNldHMgdXAgdGhlIHRocmVhZCBzdGFjaywKYWRqdXN0cyBmb3IgX19D
WUdUTFNfUEFEU0laRV9fLCByZWxlYXNlcyB0aGUgb3JpZ2luYWwgc3RhY2sgdmlhClZpcnR1YWxG
cmVlLCBhbmQgaW52b2tlcyB0aGUgdGFyZ2V0IHRocmVhZCBmdW5jdGlvbi4KLS0tCiB3aW5zdXAv
Y3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQuY2MgfCAxOSArKysrKysrKysrKysrKysrKystCiAx
IGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL3dpbnN1cC9jeWd3aW4vY3JlYXRlX3Bvc2l4X3RocmVhZC5jYyBiL3dpbnN1cC9jeWd3aW4v
Y3JlYXRlX3Bvc2l4X3RocmVhZC5jYwppbmRleCAzZmNkNjE3MDcuLmQwZDMwOTZiMiAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjCisrKyBiL3dpbnN1cC9j
eWd3aW4vY3JlYXRlX3Bvc2l4X3RocmVhZC5jYwpAQCAtNzUsNyArNzUsNyBAQCBwdGhyZWFkX3dy
YXBwZXIgKFBWT0lEIGFyZykKICAgLyogSW5pdGlhbGl6ZSBuZXcgX2N5Z3Rscy4gKi8KICAgX215
X3Rscy5pbml0X3RocmVhZCAod3JhcHBlcl9hcmcuc3RhY2tiYXNlIC0gX19DWUdUTFNfUEFEU0la
RV9fLAogCQkgICAgICAgKERXT1JEICgqKSh2b2lkKiwgdm9pZCopKSB3cmFwcGVyX2FyZy5mdW5j
KTsKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogICBfX2FzbV9f
ICgiXG5cCiAJICAgbGVhcSAgJVtXUkFQUEVSX0FSR10sICUlcmJ4CSMgTG9hZCAmd3JhcHBlcl9h
cmcgaW50byByYngJXG5cCiAJICAgbW92cSAgKCUlcmJ4KSwgJSVyMTIJCSMgTG9hZCB0aHJlYWQg
ZnVuYyBpbnRvIHIxMglcblwKQEAgLTk5LDYgKzk5LDIzIEBAIHB0aHJlYWRfd3JhcHBlciAoUFZP
SUQgYXJnKQogCSAgIGNhbGwgIColJXIxMgkJCSMgQ2FsbCB0aHJlYWQgZnVuYwkJXG4iCiAJICAg
OiA6IFtXUkFQUEVSX0FSR10gIm8iICh3cmFwcGVyX2FyZyksCiAJICAgICAgIFtDWUdUTFNdICJp
IiAoX19DWUdUTFNfUEFEU0laRV9fKSk7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorICAv
KiBTZXRzIHVwIGEgbmV3IHRocmVhZCBzdGFjaywgZnJlZXMgdGhlIG9yaWdpbmFsIE9TIHN0YWNr
LAorICAgKiBhbmQgY2FsbHMgdGhlIHRocmVhZCBmdW5jdGlvbiB3aXRoIGl0cyBhcmcgdXNpbmcg
QUFyY2g2NCBBQkkuICovCisgIF9fYXNtX18gX192b2xhdGlsZV9fICgiXG5cCisJICAgbW92ICAg
ICB4MTksICVbV1JBUFBFUl9BUkddICAgICAgICAgICAvLyB4MTkgPSAmd3JhcHBlcl9hcmcgICAg
ICAgICAgXG5cCisJICAgbGRyICAgICB4MTAsIFt4MTksICMyNF0gICAgICAgICAgICAgICAvLyB4
MTAgPSB3cmFwcGVyX2FyZy5zdGFja2Jhc2UgXG5cCisJICAgc3ViICAgICBzcCwgeDEwLCAlW0NZ
R1RMU10gICAgICAgICAgICAvLyBzcCA9IHN0YWNrYmFzZSAtIChDWUdUTFMpICAgXG5cCisJICAg
bW92ICAgICBmcCwgeHpyICAgICAgICAgICAgICAgICAgICAgICAvLyBjbGVhciBmcmFtZSBwb2lu
dGVyICh4MjkpICAgXG5cCisJICAgbW92ICAgICB4MCwgW3gxOSwgIzE2XSAgICAgICAgICAgICAg
ICAvLyB4MCA9IHdyYXBwZXJfYXJnLnN0YWNrYWRkciAgXG5cCisJICAgbW92ICAgICB4MSwgeHpy
ICAgICAgICAgICAgICAgICAgICAgICAvLyB4MSA9IDAgKGR3U2l6ZSkgICAgICAgICAgICAgXG5c
CisJICAgbW92ICAgICB4MiwgIzB4ODAwMCAgICAgICAgICAgICAgICAgICAvLyB4MiA9IE1FTV9S
RUxFQVNFICAgICAgICAgICAgXG5cCisJICAgYmwgICAgICBWaXJ0dWFsRnJlZSAgICAgICAgICAg
ICAgICAgICAvLyBmcmVlIG9yaWdpbmFsIHN0YWNrICAgICAgICAgXG5cCisJICAgbGRwICAgICB4
MTksIHgwLCBbeDE5XSAgICAgICAgICAgICAgICAvLyB4MTkgPSBmdW5jLCB4MCA9IGFyZyAgICAg
ICAgXG5cCisJICAgYmxyICAgICB4MTkgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyBjYWxs
IHRocmVhZCBmdW5jdGlvbiAgICAgICAgXG4iCisJICAgOiA6IFtXUkFQUEVSX0FSR10gInIiICgm
d3JhcHBlcl9hcmcpLAorCSAgICAgICBbQ1lHVExTXSAiciIgKF9fQ1lHVExTX1BBRFNJWkVfXykK
KwkgICA6ICJ4MCIsICJ4MSIsICJ4MiIsICJ4MTAiLCAieDE5IiwgIngyOSIsICJtZW1vcnkiKTsK
ICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgotLSAK
Mi40OS4wLndpbmRvd3MuMQoK

--_002_MA0P287MB3082E27CFAF3DA9D90A59F939F7DAMA0P287MB3082INDP_--
