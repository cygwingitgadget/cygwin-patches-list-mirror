Return-Path: <SRS0=XEoF=EW=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id 828404BA2E15
	for <cygwin-patches@cygwin.com>; Fri, 26 Jun 2026 09:03:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 828404BA2E15
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 828404BA2E15
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1782464597; cv=pass;
	b=hkQAJ+Mf/MxfFtqWiHhJTHo1wcVWFfCThj35ws6B/5kQPhruc2i/lw0X+nys6v6TgmJgQ+WKndbeg1JwuQAAT0ANqAagnQN10DROLW0vEJF8vmKq7Nt8iR40EEBHyFMhVYI+qFlzPWmQiFhaRbvgDWGLZyc+b8TTTgqOZ4BmBqE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782464597; c=relaxed/simple;
	bh=WWxV6d/y0ox8Kic1u8Lk9Lr9XKxzZdLiHF4x0NRy5pI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=gI8VYH7T9Jdp8aQzNE2UN7DSei7uZ00zgmtcAlB9uYpI0Mdg59HWwoSIwFQgXD8BFPYsX8PR0p7FzD6b8kS6t0S3sJt44CRayoDor5ocLPhZRaz9h0/BOO9SsEW6sabxIrU6QpmA2HbIDkGh+/Q4NqcEMpzFWuvCHoe39RrFX1k=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=d3dOMV9D
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 828404BA2E15
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=d3dOMV9D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juAqRJzuYZFHlLKVsaiIOeaBmmuyKjr5Ytf51Z36fC6F0IbcFrO/yFLh0kTqQM8gQ0VdixU7MBdp+ggQiRyCWlxX43t8W/XjbXnnDpegrBpaK31FTF6xVvOxtskWPVmh9Qixt+SwQxuM7z5tjF6QYth5x3IDBigvJNx859+SdaACsjDU4moJyYNWtbygh4WeFqqhCEFQmtTF7rQySWCSJ0mF+1LvoJEKc0OXPpGeZpntQ3GmBYwNF4DHduEi7XMzWOBfuVm1d8hXEINMIjKDGDDV10wYkzxtLmlJKfXUdoVLbe/MP7Gm/H9+VJP94TXMzk1J7vPGiZIwCYxajPgfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAfq2qdnHDJOEyuNaHl1vUurn5FHQl+XCM6K+U0g5CM=;
 b=gm96ZxXnr9OgekoM58aEgNCX7DRxhVr299bRscC052AEH+jjNuk7G0JQ+oseJw4+jeZaxyl59FVe2epTmR5dTPQhQRWszn80XmPltgKvGlL4QCTYgujLBVGiblS2uMRSuzFJBueh1w607xmQh9zOJkJH7worEuD9qG3g3RkrkM+aCI3AxyFzDBOi7QWKS8n5/P6OZnUudhWYmPMtuBbmUid8k5GvMCu6STsXIJx735zACCgvmX1KFOqzwUKUNEacq3j8exNKMhIAYBZUXOyLn/XEZexcjDaqbVpoBGDQYEETOUkjCggBnjFhZpjriZPgGA9rAQhIWYS92Qpe5Sd5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAfq2qdnHDJOEyuNaHl1vUurn5FHQl+XCM6K+U0g5CM=;
 b=d3dOMV9D4MwnblhCzqIbjwi3V7eyKYVGf3a8bcbutHY3SzZIKKigvSg2+PhuRXaHPU94f5G4HBjmBd2Nllkcy86ehfx0Wqw1j9y6tTq2zHw2Ph7EMJ+XpanYNY/B4c5FcZMMaaNv1ogrsCOPaE9MnvNBkFXMoCJ73dbcSWj6LrV7taESuOXqEFA+ARpqMieWRHLsGtb+mIfK7T1WLjIfMz+QmRtFvxbAJgGMWmH5xhslM+tZWD+KCRsCSeNQyjmKsEXNjToQYcVTTdO7NLBQU4qHISfKp9+Q6XdMq5U+jsg6syQSm057aCBmh/URvQq9yNs5Zk1QEck1X3dZycqCcA==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by MA0P287MB0729.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 09:03:04 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.21.0139.018; Fri, 26 Jun 2026
 09:03:04 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Topic: [PATCH v3] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Index: AQHdBUqYQOvFz8P5iEWbhjhpQHTJoA==
Date: Fri, 26 Jun 2026 09:03:03 +0000
Message-ID:
 <PN0P287MB0295EC86F97A259F0C99818F92EB2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
References:
 <PN0P287MB0295342E2109C2CB8EECCE6B92062@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <ag8IvAkqoNVM-AH2@arm.com>
 <PN0P287MB02951A11C49A1208A9BA66F392102@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <99590c72-bc88-4466-95c2-ae540a11c031@dronecode.org.uk>
In-Reply-To: <99590c72-bc88-4466-95c2-ae540a11c031@dronecode.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|MA0P287MB0729:EE_
x-ms-office365-filtering-correlation-id: 3f38783c-3628-4389-01af-08ded361bb3c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|39142699007|31052699007|6049299003|55112099003|6133799003|56012099006|8096899003|4143699003|38070700021|18002099003|22082099003|4053099003;
x-microsoft-antispam-message-info:
 +OEyIdD+Q4dWUDq+mbA78wh8KsunT80IeabOKSkx5HGw3Z8zhlQVavWSyW9SO6ZqwYsH4KGRcKHwld3p3joKADDksrIn6ile0Y+Df/brTchOOEMmOP07DdBEIFz9izkBONyGXgGuuRe11Mdsbnvkgxs6twdncLu6WTwqOn95txIcbPyZ4daY5hGVM/5gFD0D7FJquBKA8H8XTxruQYlbYECPe38PNPM0HnXA0ytFkK3JCQgsmkn8wAN/yW0VPxsB95AOxs9ZV0jPQrbNo8vSgpWfWSKI/Dj55Uwb6B0cKK8OcfMut5lssfTQH63Ydc2F2ZBLzB+7x7vSIp8rq8O5zeE+ZThIGoflLpnVHkNxA7a7AoGTEHk94+z0VLWjt83t3lLSWW8qipLkFTF6GDyP7ZwgbMfIVQBM82gWCKt3hLUIn0QUvpU/eJ+6xAb0QcOQBSA1mw189MHfC8oh2IjoHFbAlEhukGnzhSQ0TPdiuqq1LcPWaJffyTxkAdEA3+Kf1IprTTz6M2sDmufsCfMUT+MpY/4zxJ00SDQqsoMbcrULjkgPRnLaBqQuGrc4RJKS5EdMJx6LRGCvACL3juyzdVKXl/PheHtsy49ohe/yeCjwUSR49B589/wDYk99Cvb4T39jl2Taii6oAY/Y3Ye4sHn/6ubx/kKyoBSVM2z+PCQXJswyD+kq4NQUq7xsBjtFf9XjGqlIkRH6NCt3FEa5cwnf40ji+xXhDKXD7z3cQE8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(39142699007)(31052699007)(6049299003)(55112099003)(6133799003)(56012099006)(8096899003)(4143699003)(38070700021)(18002099003)(22082099003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zvV+rqqm+b9J+pgtWDgJ0yLJRJa6PI/ZCXBK1eVLB8GgdfnjNE6lIUJjAA?=
 =?iso-8859-1?Q?/0zaxUcUCMxTuvywmvXT9KUIF4DLXNtXPIfV0f6HTGvQsV/HLeviOrYpUj?=
 =?iso-8859-1?Q?JqEAg3YAU2DqZL3NiYihBc2x/KY4FtkIsgc8BNMWjSf2oLrW6ICW9hLJfa?=
 =?iso-8859-1?Q?D2SSkdlxAmu/sYeb4oVAwvd7AM4ZKRBhLYw9pjDK3Ud2LLLbSpqGNGsPzB?=
 =?iso-8859-1?Q?dYgHlMEb1NalVyXjiX+JA9xh7wtS/c2ehZlVEM+e0QUvBBkxMPWzS8ewg/?=
 =?iso-8859-1?Q?u2d/vAru4izH2xUSCTiuiK/Eqpy3jDoh8Zs8TyBzfm0CGu60S78bS4B+BH?=
 =?iso-8859-1?Q?uI+K+zIYx+IOTXqa/QcadUGUb3lWtrJ5PH8FdlUmrdvsBIbrGcO2E2MLlD?=
 =?iso-8859-1?Q?AwUk0JA98C5spOZ73nhWTVgvM/kwNZajPXibOLdJyv/dMVNFb8fvQwUpkT?=
 =?iso-8859-1?Q?CLUnjl5+1BcFDbpYhxDhpUe0HSWumWp7OHIdXq1UTHAkbIU7a/dr0mhhmX?=
 =?iso-8859-1?Q?tNvAGaRMZtiKwWcyI7OENJVnrRbWtWYQTIwq3fYLt5z7ZQs9N6z1kdhamX?=
 =?iso-8859-1?Q?dj/3ECkIUr/jAJ5jMtdIZZQaTJ4uqmwrIJUyBV3Be9eweWXUmiG7LvrzJ3?=
 =?iso-8859-1?Q?ku3j8k2l19QL3A98jzoJfHTGxjUUD/4dd0UxOlKr2iQiCWiSOp3KCqQDU8?=
 =?iso-8859-1?Q?yI2oH1j/mO/0xf83Qs3FvWzUdwRXrqPOHm/bBKBmLN1MSThZc+fraEjayr?=
 =?iso-8859-1?Q?2PG3qH+vyIK6bST0/AWx7zObsxN5mlr0+x8yGz4iNwGU1gZnkpP0Q9bm/4?=
 =?iso-8859-1?Q?iq5RB7IttYnPKVkFjfxqxIdySeJ0X2IOZKtVk9BVeNXA/X3OzpQuudxXmT?=
 =?iso-8859-1?Q?rr6u8tPQ3a4TeMfGaAd5sjswWdEmwqekM9Qmr6s6H5dNbuNgTQ4VixyNMf?=
 =?iso-8859-1?Q?E9gMCOU1tdCwbs6XuYASRNmnnLqpbQ8M4qR4xAcFjMHdta5DiW1h5oTgsU?=
 =?iso-8859-1?Q?TnSl/DZxqdJg1OkKEcNckpozJY26TK74rke4yTuBdN3DVfuRhMvpLpYimu?=
 =?iso-8859-1?Q?OcnfT7HY1gigObAyWfgrO2as/Mzkrv/btLvytCcoy9GLytHgQNrMsvtKTl?=
 =?iso-8859-1?Q?3Voh2DPTWKQ/fxY2h0RGd9Qcy0HI/YAphc0s8Fg/kmlzBAVJz387ahBckd?=
 =?iso-8859-1?Q?5l5BsVGLYc3z5+N32MHvfe2uZfUo4R0oo+VlcgKsw6rugm8Pc4GFKcNpoB?=
 =?iso-8859-1?Q?jlvmrUGRx9De+5DEUpyOrEnAa7aW1RkEeAeFmELlEPbkhRH/VuwUKquxoe?=
 =?iso-8859-1?Q?cgRSE3N/bmt9aTXm5/0NXHQk/0AEJZiR9f8YDLolycAU1XpDXacjFQcGV/?=
 =?iso-8859-1?Q?XYtTxsmlOMFnkhKg2u0lRXSZjf74a/1AwqdUsxDMxFIhGaeQuGxultJAdU?=
 =?iso-8859-1?Q?UJde/8r9/aDEJsxwv7/yfSqeypS6wr39XdB8OMIV1r2CMyJiDr/GB+5p0H?=
 =?iso-8859-1?Q?jzyiJ0eEoU7Vdmq0dNSEVgmAbnCypS/rr91xG09a5OKNfPjubmP0PrZtl2?=
 =?iso-8859-1?Q?kcpsrBjrV8VP9ARfe5WIK4xnGtJOLU7hcj+WchWgGVO7OY+wda/b2aVqsL?=
 =?iso-8859-1?Q?Tbm5KWfj8IwUAYtDGy+rgSr/X0ClNiJ8PWn9wM5rqUUWVuuKTaoVZbi466?=
 =?iso-8859-1?Q?rJNQS9fQURP3B8NMy1H1pkt5l/2AhP+EZ1hDN42E63W/maCKgmSqq2S1BP?=
 =?iso-8859-1?Q?HVyvA3Vu/0FhywqUGhtoOplSc9RGXr1+Gy5yYmPKAtZTb+67avCGQ8enXR?=
 =?iso-8859-1?Q?Mkfb3viPxp50dbVfd/hagi9cEGdPrAo=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB0295EC86F97A259F0C99818F92EB2PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f38783c-3628-4389-01af-08ded361bb3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 09:03:03.9463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVL+0c/qTiNTfKvib1YFa398rhaf85sRwHnZ4hxrdDJozN0W/QXZ+roYoGep6QRTpSrNaUAAZ/v750LTCRk4BpYDrq/Kf7shtNoUYkF/qHt8BCkaKcTvOynBsAHOKoLJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0729
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB0295EC86F97A259F0C99818F92EB2PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB0295EC86F97A259F0C99818F92EB2PN0P287MB0295INDP_"

--_000_PN0P287MB0295EC86F97A259F0C99818F92EB2PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

> I've applied this patch.

Thanks!!

>Just so I'm doing my due diligence, I'd like you confirm that you are
>submitting this under an open source license as per [1], and you and
>your colleagues at multicoreware are authorized to do so.

We have been contributing to Cygwin for about a year, all modifying
existing files rather than creating new ones. We will confirm and get
back to you shortly.


>* Looking at the git history, the comment on the problem the
>no_resolve_on_fork flag is working around has disappeared, but the
>functionality is still there.  Is it still needed?

The no_resolve_on_fork removal addresses your question about whether
that flag is still needed -- it was always 0 at every call site, so
the patch drops it entirely.

>* Since it's just data, it seems to me that the initializations of the
>various instances of struct dll_info could actually all be written in C.

The LoadLibrary elision question and the "write dll_info inits in C"
note are out of scope for this patch; happy to look at those separately.

Inline patch

---
 winsup/cygwin/autoload.cc | 84 +++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index 7054511b6..c425191b9 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -85,13 +85,13 @@ bool NO_COPY wsock_started;
    The macro WORD64 stands in for .quad/.xword, and .balign (which means
    "align to N bytes" on all targets, unlike .align) is used for
    alignment.  */
-#define LoadDLLprime(dllname, init_also, no_resolve_on_fork) __asm__ ("\n\
+#define LoadDLLprime(dllname, init_also) __asm__ ("\n\
 .ifndef " #dllname "_primed                              \n\
   .section   .data_cygwin_nocopy,\"w\"                   \n\
   .balign    8                                           \n\
 ." #dllname "_info:                                      \n\
   " WORD64 "   _std_dll_init                             \n\
-  " WORD64 "   " #no_resolve_on_fork "                   \n\
+  " WORD64 "   0                                         \n\
   .long      -1                                          \n\
   .balign    8                                           \n\
   " WORD64 "   " #init_also "                            \n\
@@ -108,12 +108,12 @@ bool NO_COPY wsock_started;
 #define LoadDLLfuncEx(name, dllname, notimp) \
   LoadDLLfuncEx2(name, dllname, notimp, 0)
 #define LoadDLLfuncEx2(name, dllname, notimp, err) \
-  LoadDLLfuncEx3(name, dllname, notimp, err, 0)
+  LoadDLLfuncEx3(name, dllname, notimp, err)

 /* Main DLL setup stuff. */
 #if defined(__x86_64__)
-#define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
-  LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) \
+#define LoadDLLfuncEx3(name, dllname, notimp, err) \
+  LoadDLLprime (dllname, dll_func_load) \
   __asm__ ("           \n\
   .section ." #dllname "_autoload_text,\"wx\"  \n\
   .global  " #name "       \n\
@@ -138,8 +138,8 @@ _win32_" #name ":         \n\
   .text              \n\
 ");
 #elif defined(__aarch64__)
-#define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
-  LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) \
+#define LoadDLLfuncEx3(name, dllname, notimp, err) \
+  LoadDLLprime (dllname, dll_func_load) \
   __asm__ ( "\n\
   .section   ." #dllname "_autoload_text,\"wx\"          \n\
   .global    " #name "                                   \n\
@@ -302,6 +302,10 @@ dll_func_load:                                        =
   \n\
   .global    dll_chain                                   \n\
 dll_chain:                                               \n\
   stp        x0, xzr, [sp, #-16]! // x0 =3D func_info* (=3D ret.high); pus=
h for dll_func_load\n\
+  mov        x30, x0          // also pass func_info in x30: a chained INI=
T_WRAPPER\n\
+                              // (e.g. _wsock_init) reads its arg from x30=
, but is\n\
+                              // reached here via 'br' which would otherwi=
se leave\n\
+                              // x30 stale.  dll_func_load ignores x30 (re=
ads [sp]).\n\
   br         x1                   // x1 =3D dll->init (=3D ret.low); tail-=
call resolver\n\
 ");
 #else
@@ -438,7 +442,7 @@ std_dll_init (struct func_info *func)
  yield ();
       }
     while (InterlockedIncrement (&dll->here));
-  else if ((uintptr_t) dll->handle <=3D 1)
+  else if (!dll->handle)
     {
       fenv_t fpuenv;
       fegetenv (&fpuenv);
@@ -461,7 +465,7 @@ std_dll_init (struct func_info *func)
    if (i < RETRY_COUNT)
      yield ();
  }
-      if ((uintptr_t) dll->handle <=3D 1)
+      if (!dll->handle)
  {
    if ((func->decoration & 1))
      dll->handle =3D INVALID_HANDLE_VALUE;
@@ -481,9 +485,29 @@ std_dll_init (struct func_info *func)

 /* Initialization function for winsock stuff. */

-#if defined(__x86_64__) || defined(__aarch64__)
+#if defined(__x86_64__)
 /* See above comment preceeding std_dll_init. */
 INIT_WRAPPER (wsock_init)
+#elif defined(__aarch64__)
+__asm__ ( "\n\
+  .text                                                  \n\
+  .p2align 2                                             \n\
+  .seh_proc _wsock_init                                  \n\
+_wsock_init:                                             \n\
+  stp        x29, x30, [sp, #-16]!  // save fp/lr, open 16-byte frame\n\
+  .seh_save_fplr_x 16                                    \n\
+  .seh_endprologue                                       \n\
+  mov        x0, x30           // x0 =3D func_info  (the wsock_init() argu=
ment)\n\
+  bl         wsock_init        // run WSAStartup; returns x0=3Dfunc_info, =
x1=3Ddll_func_load\n\
+  ldp        x29, xzr, [sp], #16  // restore fp, discard saved lr, close f=
rame\n\
+  add        sp, sp, #16       // drop the stranded dll_chain frame so the=
\n\
+                               // downstream dll_func_load sees exactly on=
e\n\
+                               // dll_chain frame above the trampoline fra=
me\n\
+  adrp       x30, dll_chain    // x30 =3D &dll_chain so the 'ret' below ta=
il-chains there\n\
+  add        x30, x30, #:lo12:dll_chain // -> dll_chain, which tail-calls =
x1 (dll_func_load)\n\
+  ret                                                   \n\
+  .seh_endproc                                          \n\
+");
 #else
 #error unimplemented for this target
 #endif
@@ -534,7 +558,7 @@ wsock_init (struct func_info *func)
   return ret.ll;
 }

-LoadDLLprime (ws2_32, _wsock_init, 0)
+LoadDLLprime (ws2_32, _wsock_init)

 LoadDLLfunc (CheckTokenMembership, advapi32)
 LoadDLLfunc (CreateProcessAsUserW, advapi32)
@@ -711,25 +735,25 @@ LoadDLLfuncEx2 (CreateProfile, userenv, 1, 1)
 LoadDLLfunc (DestroyEnvironmentBlock, userenv)
 LoadDLLfunc (LoadUserProfileW, userenv)

-LoadDLLfuncEx3 (waveInAddBuffer, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInClose, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInGetNumDevs, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInOpen, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInPrepareHeader, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInReset, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInStart, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInUnprepareHeader, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutClose, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutGetNumDevs, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutGetVolume, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutOpen, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutPrepareHeader, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutReset, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutSetVolume, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutUnprepareHeader, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutWrite, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutMessage, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutGetDevCapsA, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (waveInAddBuffer, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInClose, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInGetNumDevs, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInOpen, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInPrepareHeader, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInReset, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInStart, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInUnprepareHeader, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutClose, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutGetNumDevs, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutGetVolume, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutOpen, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutPrepareHeader, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutReset, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutSetVolume, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutUnprepareHeader, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutWrite, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutMessage, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutGetDevCapsA, winmm, 1, 0)

 LoadDLLfunc (accept, ws2_32)
 LoadDLLfunc (bind, ws2_32)
--
2.49.0.windows.1




--_000_PN0P287MB0295EC86F97A259F0C99818F92EB2PN0P287MB0295INDP_--

--_004_PN0P287MB0295EC86F97A259F0C99818F92EB2PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-autoload-fix-ws2_32-chained-init-on-AArch64.patch"
Content-Description: Cygwin-autoload-fix-ws2_32-chained-init-on-AArch64.patch
Content-Disposition: attachment;
	filename="Cygwin-autoload-fix-ws2_32-chained-init-on-AArch64.patch";
	size=9290; creation-date="Fri, 26 Jun 2026 08:59:05 GMT";
	modification-date="Fri, 26 Jun 2026 09:03:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlY2FkOWM1MGFiN2I1OWVlNTUzZWQ4Yzg1MWY1YTk4MjU2YTZiZGVh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IEZyaSwgMjYgSnVuIDIwMjYgMTE6MjE6MDIgKzA1MzAKU3ViamVjdDogW1BB
VENIIHYzXSBDeWd3aW46IGF1dG9sb2FkOiBmaXggd3MyXzMyIGNoYWluZWQg
aW5pdCBvbiBBQXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlw
ZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVy
LUVuY29kaW5nOiA4Yml0CgpPbiBBQXJjaDY0LCB0aGUgYXV0b2xvYWQgSU5J
VF9XUkFQUEVSIHBhc3NlcyBmdW5jX2luZm8qIHZpYSB4MzAgKCJtb3YKeDAs
IHgzMCIpLiAgVGhpcyB3b3JrcyBmb3IgdGhlIGZpcnN0IGluaXQgc3RhZ2Ug
KHN0ZF9kbGxfaW5pdCksIHJlYWNoZWQKYnkgdGhlIHRyYW1wb2xpbmUncyAi
YmxyIi4gIEl0IGJyZWFrcyBmb3IgYSBjaGFpbmVkIHNlY29uZCBpbml0LCBi
ZWNhdXNlCmRsbF9jaGFpbiByZWFjaGVzIGl0IHZpYSAiYnIgeDEiIHdpdGhv
dXQgdXBkYXRpbmcgeDMwLgoKd3MyXzMyIGlzIHRoZSBvbmx5IERMTCB3aXRo
IHN1Y2ggYSBjaGFpbiAoc3RkX2RsbF9pbml0IC0+IHdzb2NrX2luaXQgLT4K
ZGxsX2Z1bmNfbG9hZCkuICB3c29ja19pbml0IHJlY2VpdmVkIGdhcmJhZ2Ug
aW4geDAsIHNvIFdTQVN0YXJ0dXAgd2FzCm5ldmVyIGNhbGxlZDsgZXZlcnkg
d3MyXzMyIGNhbGwgZmFpbGVkIHdpdGggV1NBTk9USU5JVElBTElTRUQgLyBF
RkFVTFQuCgpkbGxfY2hhaW4gYWxzbyBydW5zIHR3aWNlIGZvciB3czJfMzIs
IHB1c2hpbmcgYSAxNi1ieXRlIGZyYW1lIGVhY2ggdGltZS4Kd3NvY2tfaW5p
dCBjb25zdW1lcyBpdHMgYXJnIGZyb20geDMwLCBub3QgdGhlIHN0YWNrLCBz
byB0aGUgZmlyc3QgZnJhbWUKc3RyYW5kcy4gIGRsbF9mdW5jX2xvYWQgdGhl
biByZXN0b3JlcyBjYWxsZXItc2F2ZSByZWdpc3RlcnMgZnJvbSBhCnNoaWZ0
ZWQgb2Zmc2V0LCBjb3JydXB0aW5nIHRoZSBmaXJzdCBjYWxsJ3MgYXJndW1l
bnRzLgoKRml4OiBjb3B5IGZ1bmNfaW5mbyBpbnRvIHgzMCBpbiBkbGxfY2hh
aW4gYmVmb3JlIHRoZSB0YWlsLWJyYW5jaCwgYW5kCmdpdmUgQUFyY2g2NCBh
IGRlZGljYXRlZCBfd3NvY2tfaW5pdCB3cmFwcGVyIHRoYXQgZHJvcHMgdGhl
IHN0cmFuZGVkCmZyYW1lICgiYWRkIHNwLCBzcCwgIzE2IikgYmVmb3JlIGNo
YWluaW5nIHRvIGRsbF9mdW5jX2xvYWQuCgpBbHNvIHJlbW92ZSB0aGUgbm9f
cmVzb2x2ZV9vbl9mb3JrIHBhcmFtZXRlciBmcm9tIExvYWRETExwcmltZSAv
CkxvYWRETExmdW5jRXgzICh3YXMgYWx3YXlzIDApIGFuZCBmaXggdGhlIHN0
ZF9kbGxfaW5pdCBoYW5kbGUgc2VudGluZWwKZnJvbSAiKHVpbnRwdHJfdClo
YW5kbGUgPD0gMSIgdG8gIiFoYW5kbGUiLgoKU2lnbmVkLW9mZi1ieTogUmFk
ZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+ClNpZ25l
ZC1vZmYtYnk6IFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5u
YWdhbGluZ2FtQG11bHRpY29yZXdhcmVpbmMuY29tPgpTaWduZWQtb2ZmLWJ5
OiBDaGFuZHJ1IEt1bWFyZXNhbiA8Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGlj
b3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9hdXRvbG9hZC5j
YyB8IDg0ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDMwIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vYXV0b2xvYWQu
Y2MgYi93aW5zdXAvY3lnd2luL2F1dG9sb2FkLmNjCmluZGV4IDcwNTQ1MTFi
Ni4uYzQyNTE5MWI5IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2F1dG9s
b2FkLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vYXV0b2xvYWQuY2MKQEAgLTg1
LDEzICs4NSwxMyBAQCBib29sIE5PX0NPUFkgd3NvY2tfc3RhcnRlZDsKICAg
IFRoZSBtYWNybyBXT1JENjQgc3RhbmRzIGluIGZvciAucXVhZC8ueHdvcmQs
IGFuZCAuYmFsaWduICh3aGljaCBtZWFucwogICAgImFsaWduIHRvIE4gYnl0
ZXMiIG9uIGFsbCB0YXJnZXRzLCB1bmxpa2UgLmFsaWduKSBpcyB1c2VkIGZv
cgogICAgYWxpZ25tZW50LiAgKi8KLSNkZWZpbmUgTG9hZERMTHByaW1lKGRs
bG5hbWUsIGluaXRfYWxzbywgbm9fcmVzb2x2ZV9vbl9mb3JrKSBfX2FzbV9f
ICgiXG5cCisjZGVmaW5lIExvYWRETExwcmltZShkbGxuYW1lLCBpbml0X2Fs
c28pIF9fYXNtX18gKCJcblwKIC5pZm5kZWYgIiAjZGxsbmFtZSAiX3ByaW1l
ZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAogICAuc2VjdGlv
biAgIC5kYXRhX2N5Z3dpbl9ub2NvcHksXCJ3XCIgICAgICAgICAgICAgICAg
ICAgXG5cCiAgIC5iYWxpZ24gICAgOCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcblwKIC4iICNkbGxuYW1lICJfaW5mbzog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAogICAi
IFdPUkQ2NCAiICAgX3N0ZF9kbGxfaW5pdCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXG5cCi0gICIgV09SRDY0ICIgICAiICNub19yZXNvbHZlX29u
X2ZvcmsgIiAgICAgICAgICAgICAgICAgICBcblwKKyAgIiBXT1JENjQgIiAg
IDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxu
XAogICAubG9uZyAgICAgIC0xICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXG5cCiAgIC5iYWxpZ24gICAgOCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKICAgIiBXT1JE
NjQgIiAgICIgI2luaXRfYWxzbyAiICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFxuXApAQCAtMTA4LDEyICsxMDgsMTIgQEAgYm9vbCBOT19DT1BZIHdz
b2NrX3N0YXJ0ZWQ7CiAjZGVmaW5lIExvYWRETExmdW5jRXgobmFtZSwgZGxs
bmFtZSwgbm90aW1wKSBcCiAgIExvYWRETExmdW5jRXgyKG5hbWUsIGRsbG5h
bWUsIG5vdGltcCwgMCkKICNkZWZpbmUgTG9hZERMTGZ1bmNFeDIobmFtZSwg
ZGxsbmFtZSwgbm90aW1wLCBlcnIpIFwKLSAgTG9hZERMTGZ1bmNFeDMobmFt
ZSwgZGxsbmFtZSwgbm90aW1wLCBlcnIsIDApCisgIExvYWRETExmdW5jRXgz
KG5hbWUsIGRsbG5hbWUsIG5vdGltcCwgZXJyKQogCiAvKiBNYWluIERMTCBz
ZXR1cCBzdHVmZi4gKi8KICNpZiBkZWZpbmVkKF9feDg2XzY0X18pCi0jZGVm
aW5lIExvYWRETExmdW5jRXgzKG5hbWUsIGRsbG5hbWUsIG5vdGltcCwgZXJy
LCBub19yZXNvbHZlX29uX2ZvcmspIFwKLSAgTG9hZERMTHByaW1lIChkbGxu
YW1lLCBkbGxfZnVuY19sb2FkLCBub19yZXNvbHZlX29uX2ZvcmspIFwKKyNk
ZWZpbmUgTG9hZERMTGZ1bmNFeDMobmFtZSwgZGxsbmFtZSwgbm90aW1wLCBl
cnIpIFwKKyAgTG9hZERMTHByaW1lIChkbGxuYW1lLCBkbGxfZnVuY19sb2Fk
KSBcCiAgIF9fYXNtX18gKCIJCQkJCQlcblwKICAgLnNlY3Rpb24JLiIgI2Rs
bG5hbWUgIl9hdXRvbG9hZF90ZXh0LFwid3hcIglcblwKICAgLmdsb2JhbAki
ICNuYW1lICIJCQkJXG5cCkBAIC0xMzgsOCArMTM4LDggQEAgX3dpbjMyXyIg
I25hbWUgIjoJCQkJCVxuXAogICAudGV4dAkJCQkJCQlcblwKICIpOwogI2Vs
aWYgZGVmaW5lZChfX2FhcmNoNjRfXykKLSNkZWZpbmUgTG9hZERMTGZ1bmNF
eDMobmFtZSwgZGxsbmFtZSwgbm90aW1wLCBlcnIsIG5vX3Jlc29sdmVfb25f
Zm9yaykgXAotICBMb2FkRExMcHJpbWUgKGRsbG5hbWUsIGRsbF9mdW5jX2xv
YWQsIG5vX3Jlc29sdmVfb25fZm9yaykgXAorI2RlZmluZSBMb2FkRExMZnVu
Y0V4MyhuYW1lLCBkbGxuYW1lLCBub3RpbXAsIGVycikgXAorICBMb2FkRExM
cHJpbWUgKGRsbG5hbWUsIGRsbF9mdW5jX2xvYWQpIFwKICAgX19hc21fXyAo
ICJcblwKICAgLnNlY3Rpb24gICAuIiAjZGxsbmFtZSAiX2F1dG9sb2FkX3Rl
eHQsXCJ3eFwiICAgICAgICAgIFxuXAogICAuZ2xvYmFsICAgICIgI25hbWUg
IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCkBAIC0z
MDIsNiArMzAyLDEwIEBAIGRsbF9mdW5jX2xvYWQ6ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAogICAuZ2xvYmFsICAg
IGRsbF9jaGFpbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XG5cCiBkbGxfY2hhaW46ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcblwKICAgc3RwICAgICAgICB4MCwgeHpyLCBb
c3AsICMtMTZdISAvLyB4MCA9IGZ1bmNfaW5mbyogKD0gcmV0LmhpZ2gpOyBw
dXNoIGZvciBkbGxfZnVuY19sb2FkXG5cCisgIG1vdiAgICAgICAgeDMwLCB4
MCAgICAgICAgICAvLyBhbHNvIHBhc3MgZnVuY19pbmZvIGluIHgzMDogYSBj
aGFpbmVkIElOSVRfV1JBUFBFUlxuXAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLy8gKGUuZy4gX3dzb2NrX2luaXQpIHJlYWRzIGl0cyBhcmcg
ZnJvbSB4MzAsIGJ1dCBpc1xuXAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLy8gcmVhY2hlZCBoZXJlIHZpYSAnYnInIHdoaWNoIHdvdWxkIG90
aGVyd2lzZSBsZWF2ZVxuXAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLy8geDMwIHN0YWxlLiAgZGxsX2Z1bmNfbG9hZCBpZ25vcmVzIHgzMCAo
cmVhZHMgW3NwXSkuXG5cCiAgIGJyICAgICAgICAgeDEgICAgICAgICAgICAg
ICAgICAgLy8geDEgPSBkbGwtPmluaXQgKD0gcmV0Lmxvdyk7IHRhaWwtY2Fs
bCByZXNvbHZlclxuXAogIik7CiAjZWxzZQpAQCAtNDM4LDcgKzQ0Miw3IEBA
IHN0ZF9kbGxfaW5pdCAoc3RydWN0IGZ1bmNfaW5mbyAqZnVuYykKIAl5aWVs
ZCAoKTsKICAgICAgIH0KICAgICB3aGlsZSAoSW50ZXJsb2NrZWRJbmNyZW1l
bnQgKCZkbGwtPmhlcmUpKTsKLSAgZWxzZSBpZiAoKHVpbnRwdHJfdCkgZGxs
LT5oYW5kbGUgPD0gMSkKKyAgZWxzZSBpZiAoIWRsbC0+aGFuZGxlKQogICAg
IHsKICAgICAgIGZlbnZfdCBmcHVlbnY7CiAgICAgICBmZWdldGVudiAoJmZw
dWVudik7CkBAIC00NjEsNyArNDY1LDcgQEAgc3RkX2RsbF9pbml0IChzdHJ1
Y3QgZnVuY19pbmZvICpmdW5jKQogCSAgaWYgKGkgPCBSRVRSWV9DT1VOVCkK
IAkgICAgeWllbGQgKCk7CiAJfQotICAgICAgaWYgKCh1aW50cHRyX3QpIGRs
bC0+aGFuZGxlIDw9IDEpCisgICAgICBpZiAoIWRsbC0+aGFuZGxlKQogCXsK
IAkgIGlmICgoZnVuYy0+ZGVjb3JhdGlvbiAmIDEpKQogCSAgICBkbGwtPmhh
bmRsZSA9IElOVkFMSURfSEFORExFX1ZBTFVFOwpAQCAtNDgxLDkgKzQ4NSwy
OSBAQCBzdGRfZGxsX2luaXQgKHN0cnVjdCBmdW5jX2luZm8gKmZ1bmMpCiAK
IC8qIEluaXRpYWxpemF0aW9uIGZ1bmN0aW9uIGZvciB3aW5zb2NrIHN0dWZm
LiAqLwogCi0jaWYgZGVmaW5lZChfX3g4Nl82NF9fKSB8fCBkZWZpbmVkKF9f
YWFyY2g2NF9fKQorI2lmIGRlZmluZWQoX194ODZfNjRfXykKIC8qIFNlZSBh
Ym92ZSBjb21tZW50IHByZWNlZWRpbmcgc3RkX2RsbF9pbml0LiAqLwogSU5J
VF9XUkFQUEVSICh3c29ja19pbml0KQorI2VsaWYgZGVmaW5lZChfX2FhcmNo
NjRfXykKK19fYXNtX18gKCAiXG5cCisgIC50ZXh0ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgLnAy
YWxpZ24gMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFxuXAorICAuc2VoX3Byb2MgX3dzb2NrX2luaXQgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXG5cCitfd3NvY2tfaW5pdDogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwK
KyAgc3RwICAgICAgICB4MjksIHgzMCwgW3NwLCAjLTE2XSEgIC8vIHNhdmUg
ZnAvbHIsIG9wZW4gMTYtYnl0ZSBmcmFtZVxuXAorICAuc2VoX3NhdmVfZnBs
cl94IDE2ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5c
CisgIC5zZWhfZW5kcHJvbG9ndWUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcblwKKyAgbW92ICAgICAgICB4MCwgeDMwICAgICAg
ICAgICAvLyB4MCA9IGZ1bmNfaW5mbyAgKHRoZSB3c29ja19pbml0KCkgYXJn
dW1lbnQpXG5cCisgIGJsICAgICAgICAgd3NvY2tfaW5pdCAgICAgICAgLy8g
cnVuIFdTQVN0YXJ0dXA7IHJldHVybnMgeDA9ZnVuY19pbmZvLCB4MT1kbGxf
ZnVuY19sb2FkXG5cCisgIGxkcCAgICAgICAgeDI5LCB4enIsIFtzcF0sICMx
NiAgLy8gcmVzdG9yZSBmcCwgZGlzY2FyZCBzYXZlZCBsciwgY2xvc2UgZnJh
bWVcblwKKyAgYWRkICAgICAgICBzcCwgc3AsICMxNiAgICAgICAvLyBkcm9w
IHRoZSBzdHJhbmRlZCBkbGxfY2hhaW4gZnJhbWUgc28gdGhlXG5cCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gZG93bnN0cmVhbSBkbGxf
ZnVuY19sb2FkIHNlZXMgZXhhY3RseSBvbmVcblwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAvLyBkbGxfY2hhaW4gZnJhbWUgYWJvdmUgdGhl
IHRyYW1wb2xpbmUgZnJhbWVcblwKKyAgYWRycCAgICAgICB4MzAsIGRsbF9j
aGFpbiAgICAvLyB4MzAgPSAmZGxsX2NoYWluIHNvIHRoZSAncmV0JyBiZWxv
dyB0YWlsLWNoYWlucyB0aGVyZVxuXAorICBhZGQgICAgICAgIHgzMCwgeDMw
LCAjOmxvMTI6ZGxsX2NoYWluIC8vIC0+IGRsbF9jaGFpbiwgd2hpY2ggdGFp
bC1jYWxscyB4MSAoZGxsX2Z1bmNfbG9hZClcblwKKyAgcmV0ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5c
CisgIC5zZWhfZW5kcHJvYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFxuXAorIik7CiAjZWxzZQogI2Vycm9yIHVuaW1wbGVt
ZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CiAjZW5kaWYKQEAgLTUzNCw3ICs1NTgs
NyBAQCB3c29ja19pbml0IChzdHJ1Y3QgZnVuY19pbmZvICpmdW5jKQogICBy
ZXR1cm4gcmV0LmxsOwogfQogCi1Mb2FkRExMcHJpbWUgKHdzMl8zMiwgX3dz
b2NrX2luaXQsIDApCitMb2FkRExMcHJpbWUgKHdzMl8zMiwgX3dzb2NrX2lu
aXQpCiAKIExvYWRETExmdW5jIChDaGVja1Rva2VuTWVtYmVyc2hpcCwgYWR2
YXBpMzIpCiBMb2FkRExMZnVuYyAoQ3JlYXRlUHJvY2Vzc0FzVXNlclcsIGFk
dmFwaTMyKQpAQCAtNzExLDI1ICs3MzUsMjUgQEAgTG9hZERMTGZ1bmNFeDIg
KENyZWF0ZVByb2ZpbGUsIHVzZXJlbnYsIDEsIDEpCiBMb2FkRExMZnVuYyAo
RGVzdHJveUVudmlyb25tZW50QmxvY2ssIHVzZXJlbnYpCiBMb2FkRExMZnVu
YyAoTG9hZFVzZXJQcm9maWxlVywgdXNlcmVudikKIAotTG9hZERMTGZ1bmNF
eDMgKHdhdmVJbkFkZEJ1ZmZlciwgd2lubW0sIDEsIDAsIDEpCi1Mb2FkRExM
ZnVuY0V4MyAod2F2ZUluQ2xvc2UsIHdpbm1tLCAxLCAwLCAxKQotTG9hZERM
TGZ1bmNFeDMgKHdhdmVJbkdldE51bURldnMsIHdpbm1tLCAxLCAwLCAxKQot
TG9hZERMTGZ1bmNFeDMgKHdhdmVJbk9wZW4sIHdpbm1tLCAxLCAwLCAxKQot
TG9hZERMTGZ1bmNFeDMgKHdhdmVJblByZXBhcmVIZWFkZXIsIHdpbm1tLCAx
LCAwLCAxKQotTG9hZERMTGZ1bmNFeDMgKHdhdmVJblJlc2V0LCB3aW5tbSwg
MSwgMCwgMSkKLUxvYWRETExmdW5jRXgzICh3YXZlSW5TdGFydCwgd2lubW0s
IDEsIDAsIDEpCi1Mb2FkRExMZnVuY0V4MyAod2F2ZUluVW5wcmVwYXJlSGVh
ZGVyLCB3aW5tbSwgMSwgMCwgMSkKLUxvYWRETExmdW5jRXgzICh3YXZlT3V0
Q2xvc2UsIHdpbm1tLCAxLCAwLCAxKQotTG9hZERMTGZ1bmNFeDMgKHdhdmVP
dXRHZXROdW1EZXZzLCB3aW5tbSwgMSwgMCwgMSkKLUxvYWRETExmdW5jRXgz
ICh3YXZlT3V0R2V0Vm9sdW1lLCB3aW5tbSwgMSwgMCwgMSkKLUxvYWRETExm
dW5jRXgzICh3YXZlT3V0T3Blbiwgd2lubW0sIDEsIDAsIDEpCi1Mb2FkRExM
ZnVuY0V4MyAod2F2ZU91dFByZXBhcmVIZWFkZXIsIHdpbm1tLCAxLCAwLCAx
KQotTG9hZERMTGZ1bmNFeDMgKHdhdmVPdXRSZXNldCwgd2lubW0sIDEsIDAs
IDEpCi1Mb2FkRExMZnVuY0V4MyAod2F2ZU91dFNldFZvbHVtZSwgd2lubW0s
IDEsIDAsIDEpCi1Mb2FkRExMZnVuY0V4MyAod2F2ZU91dFVucHJlcGFyZUhl
YWRlciwgd2lubW0sIDEsIDAsIDEpCi1Mb2FkRExMZnVuY0V4MyAod2F2ZU91
dFdyaXRlLCB3aW5tbSwgMSwgMCwgMSkKLUxvYWRETExmdW5jRXgzICh3YXZl
T3V0TWVzc2FnZSwgd2lubW0sIDEsIDAsIDEpCi1Mb2FkRExMZnVuY0V4MyAo
d2F2ZU91dEdldERldkNhcHNBLCB3aW5tbSwgMSwgMCwgMSkKK0xvYWRETExm
dW5jRXgzICh3YXZlSW5BZGRCdWZmZXIsIHdpbm1tLCAxLCAwKQorTG9hZERM
TGZ1bmNFeDMgKHdhdmVJbkNsb3NlLCB3aW5tbSwgMSwgMCkKK0xvYWRETExm
dW5jRXgzICh3YXZlSW5HZXROdW1EZXZzLCB3aW5tbSwgMSwgMCkKK0xvYWRE
TExmdW5jRXgzICh3YXZlSW5PcGVuLCB3aW5tbSwgMSwgMCkKK0xvYWRETExm
dW5jRXgzICh3YXZlSW5QcmVwYXJlSGVhZGVyLCB3aW5tbSwgMSwgMCkKK0xv
YWRETExmdW5jRXgzICh3YXZlSW5SZXNldCwgd2lubW0sIDEsIDApCitMb2Fk
RExMZnVuY0V4MyAod2F2ZUluU3RhcnQsIHdpbm1tLCAxLCAwKQorTG9hZERM
TGZ1bmNFeDMgKHdhdmVJblVucHJlcGFyZUhlYWRlciwgd2lubW0sIDEsIDAp
CitMb2FkRExMZnVuY0V4MyAod2F2ZU91dENsb3NlLCB3aW5tbSwgMSwgMCkK
K0xvYWRETExmdW5jRXgzICh3YXZlT3V0R2V0TnVtRGV2cywgd2lubW0sIDEs
IDApCitMb2FkRExMZnVuY0V4MyAod2F2ZU91dEdldFZvbHVtZSwgd2lubW0s
IDEsIDApCitMb2FkRExMZnVuY0V4MyAod2F2ZU91dE9wZW4sIHdpbm1tLCAx
LCAwKQorTG9hZERMTGZ1bmNFeDMgKHdhdmVPdXRQcmVwYXJlSGVhZGVyLCB3
aW5tbSwgMSwgMCkKK0xvYWRETExmdW5jRXgzICh3YXZlT3V0UmVzZXQsIHdp
bm1tLCAxLCAwKQorTG9hZERMTGZ1bmNFeDMgKHdhdmVPdXRTZXRWb2x1bWUs
IHdpbm1tLCAxLCAwKQorTG9hZERMTGZ1bmNFeDMgKHdhdmVPdXRVbnByZXBh
cmVIZWFkZXIsIHdpbm1tLCAxLCAwKQorTG9hZERMTGZ1bmNFeDMgKHdhdmVP
dXRXcml0ZSwgd2lubW0sIDEsIDApCitMb2FkRExMZnVuY0V4MyAod2F2ZU91
dE1lc3NhZ2UsIHdpbm1tLCAxLCAwKQorTG9hZERMTGZ1bmNFeDMgKHdhdmVP
dXRHZXREZXZDYXBzQSwgd2lubW0sIDEsIDApCiAKIExvYWRETExmdW5jIChh
Y2NlcHQsIHdzMl8zMikKIExvYWRETExmdW5jIChiaW5kLCB3czJfMzIpCi0t
IAoyLjQ5LjAud2luZG93cy4xCgo=

--_004_PN0P287MB0295EC86F97A259F0C99818F92EB2PN0P287MB0295INDP_--
