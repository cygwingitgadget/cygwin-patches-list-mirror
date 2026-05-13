Return-Path: <SRS0=xUGt=DK=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id 51B2B4BB592D
	for <cygwin-patches@cygwin.com>; Wed, 13 May 2026 11:40:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 51B2B4BB592D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 51B2B4BB592D
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1778672414; cv=pass;
	b=EihFXDMqgSocxFrqPaVxCXPOD2OC7TdvNgzs4y+JQlfVfWBimGFEI2N3/kilcIcFkjBoJ6GBqLU16+znwelx/iNQnWMKNpt6xosv8oHYuYDo0DuFWZkQM+IqCACbqVad0j9OOtdR8K4XCGaqm3EsIWCJvaKVheCHrDHrMgUSfhA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778672414; c=relaxed/simple;
	bh=abSa5YVvrCkmTo3xS12ocMDmgorBpBc8ejqi9RKJNl8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=b12gB8npL/Zc/XjbU9o8vFmfOb0USeuBG0LB1HQaEzkvWOZbhCfFkaffVHWqZNMbbg5N464VVc9XPIR+GoEN54hfJssKBvukNO4hqbhltFYiZWeusrzvAg2KmCuKkmMG0tm2dBLoLI1vSRtd5DdAI6VLlQbGmavlJdVShfZ+fE4=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=WHE9qYVt
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 51B2B4BB592D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=WHE9qYVt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5GLY7OCeqhk0z+u+TrqhIsgR2wMh/xdpfKZkjNgAbYO226+WZdCu57jiu7PyxSJyM7puiDLK83Isgz58uGxUEfJFxHKLDFnKKFmViFc7qBHPY7iwC6fhldU4m+QZkI4wWdQNIwFE+tvh/T855hdbkrKOyrWegCFm2cQmILLi021JYBIGtWM/xO/1J7Uxq2D0h+H/x19fGKBY3j1AcIPdNvv4TzFga/INAbCBB0gnYqa4xUg2mkhxsjnzJYlxKvfIppMohrmqO5sXy3zI24KNg6nWHuRN19J+lMEb7IZzDRwJCguhQsJ1YCo3nnoK0AurFEPVXYu7WTAzOFB1uP1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AoShSdWO0I92pphGWyyR8FCe3hRXIsuZ0Htxd1EePw=;
 b=NxonzZZ4qQx6U0nbWEZGb4MgLw+Y1hTNvRz5J5vHdU1VVeFIJDgMALU61YdDX4JuZhYyKEg1GKo5wf7rvkBKnVkIe/r35zsP6BW7lzyN6Pcefj5sszXJStKRnhz85erc+UQK91gFuMNbC1kAOvMd5CEW+t9B8Qh2ptoyoNrcnzcwtT10f9YH99qkmum2LjRBfWTO/ePYsYij3SH/N7ZLBZOTz6UD/Qr0egwOgL95IHA40iAQHacHatX7UriTBCGJaMjhWRvcHEUMU5vBYsYRGzXBoYrH61mK3kUwL/09HeMbe0bFUDYlAH6qalJNCE/MSRKs7UW4fBUa+6ad5O9zMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AoShSdWO0I92pphGWyyR8FCe3hRXIsuZ0Htxd1EePw=;
 b=WHE9qYVt59ARt/hQgFw93oFLKkI16XHuObcXtHyQakTR1VBenKaHvPBrtwMlmpWD2Spr+3Sr6K4DWSA6CRjzLkkecp/eaZKYo5W16i7X6Vn68sF6lBiALGuN7qjWcWXQ3djYBhmC/cNRfVY5r/7wLCUo2lxj33xaIWCerip2WFA2pjCcmndzsLyE35AK5djCKONlifaRMHWgDC3WnHHo+wTSWSwP6nKBK6zc/KzmK/pw++0MP1o0p+F6PPfEDaXaOX0FSXahnzXS7QMz2XPI5LlJp/2zZGSISp0poj++DjZTvASucOY5cSqLYrKFMaH1nF0y3YP/Cw29Rf1XT/Jx6g==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by PNXP287MB4130.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:290::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:40:02 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:40:02 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: autoload: add AArch64 build stubs
Thread-Topic: [PATCH] Cygwin: autoload: add AArch64 build stubs
Thread-Index: AQHc4swDj7lY6fbKrUC8uaEsC47V1A==
Date: Wed, 13 May 2026 11:40:02 +0000
Message-ID:
 <PN0P287MB0295342E2109C2CB8EECCE6B92062@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|PNXP287MB4130:EE_
x-ms-office365-filtering-correlation-id: 83a95934-466e-45fe-d055-08deb0e45ec8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|6049299003|376014|39142699007|31052699007|366016|4053099003|18002099003|56012099003|55112099003|38070700021|8096899003;
x-microsoft-antispam-message-info:
 nBwbxRBTBwqpPzHeqKaWmuzDEfxATvQCeW8jjVxRwchPaYyaDWeVEwR36bTbEiD7gmkUrfG8DKeAIj2hwA7VAWQjTP21nfyJPFmC+Tw2yrpUqpP7wYgloNr9FOILMxkMP2rgI60g7D/jg6lUcPZQlF7cpbfwiNhTWG5Oi5+MOIbCZZd8MNbxeQqhMN1nfJaDEUyBTk1dZZDFnhwQa/Rvbr5fHs9uxuDdlOPqIwU9B6+3rTVNBXl6gc7gP1HWWqohz9BvLH3y1TtwIpnwwo+SftOzWnkYUr0wr9jwc67E6omLhJ2dnhyEHa0BHVFm76IRPNPBbdZn+VghSJ9Qhi06a24KrOTxvvZ2GPzJ1KOYTl6JRE1CY0QIX1VO7WBpsF0yHSFahWBKfpT6wpBd2tCfhwXrAX5T273TeXTRgyVIsTwBQfbjuM+Am2ea7gdhEGLMfkyE/cjgrbRHvKqYSBlCT1ALg+AaaLgQA9DUSpSPVygUOERE2lrzGHhrZrPnrHAIBlQ/qIWJt7S+IVF5XGKKe2XpNBzWi0kKGZbDirZ9/ofx7pcz9BdUUnYeo4x/zDKjOoCUWWqTe+t/UYd0IMTpy0EJ86iOojQyeQSbUDQROY7Ejzy0KRwIWDgzJpeztdXifyq+38mqGnLv5b87dJ0ZiSLo5H2mCfPeeOdG8HehDyMI40VTsRHiYlVWkXp/wjLZ5kh+zENIo6o0aZDNuEXRwZd0yP25xoclvT++9V6BzEjYZ1JeW6Jr2DeVu45VC+Y+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(6049299003)(376014)(39142699007)(31052699007)(366016)(4053099003)(18002099003)(56012099003)(55112099003)(38070700021)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pUeTYRlIdJBWOcGAnAXfxdxAr19l4BLrJUHgJwJwyfMkywQapdjC4qPFbV?=
 =?iso-8859-1?Q?OgYEAkC4pia3FGz7VhRruJF50DNt9b/irCe3ZtJhLWafjXWexzLN9loIUx?=
 =?iso-8859-1?Q?3+SPMlUnpEGEpN0u7JRmJ6PadK3AHcL1MzIcQVgPXtbi+0WuyjTJbfsucb?=
 =?iso-8859-1?Q?YFg7uITtz3teIRYd++El6YGzKeSr9q1bn/RASHQFx6kFIGMRHCDlfVoRmm?=
 =?iso-8859-1?Q?djs3JI0WmFhpuWtgMeVtFbNs4qdzZu2kofDxmDXS1LThu7Y67UlXri2g7Y?=
 =?iso-8859-1?Q?2UW4XA1oJQVYayY0sAeMIaiM/enWy+uexA/dGLhdf3QpJadAJZqbzG1blN?=
 =?iso-8859-1?Q?KNWuLm0Ljz1gi3xrXAEN5vem+nRfypgZqJFlqugLiH5sB9zUu0t8vgSz/P?=
 =?iso-8859-1?Q?nBx5vtnSQ0Nl2ynrluCjRHwE1Xq9EQl/0pMKjCZKLfOVqnR8AOHmV6PZ07?=
 =?iso-8859-1?Q?8DGKKlu/MNBDsWSG3WDeKBcZOeo9HZCSbNzKfOAjWDHR3+IV93t8/vG8/h?=
 =?iso-8859-1?Q?6A0nFzU9y8WOLWHKWvMTLUlswM81Bs+ZVWje53JQtAMhyvSwaGaIaREMLC?=
 =?iso-8859-1?Q?3bENSfk/iZFuNeZ0Xzfq7rnVU2EypzuUzKrtDS8UuQaoWpaLVOxZ8ZFMuP?=
 =?iso-8859-1?Q?HcOm2Pntg+6s1hZ4/5MA2VsqDJpPgWAWdo58o+s8ctzC/pNgdFXsPf7yZs?=
 =?iso-8859-1?Q?j36RCOJ8vBiB41VkmYs5IrdYD0/jQLne15Vq6pmWUG+4WiHuN2GoI/tfIF?=
 =?iso-8859-1?Q?jaINXHiTLDpkCpcB9u0MFE9SHWS6BzoPcpM1XY++vPeDeBby0ISbeZssbg?=
 =?iso-8859-1?Q?DCpVlBMGbabdPGEOYfLqXKZO7WBugxThLZMQ8Cpu/CLNqRA69HqmHzbXZw?=
 =?iso-8859-1?Q?l9ACxKdwwgdldk4AWHQigEX8Q3qzYddmVIJtuFOqTk14JNQWfzlqqUr8jr?=
 =?iso-8859-1?Q?XUFW00ltaUI6Ga2uexnFXejmgZ8rRzumuW9Cgx7jDspvCcoWQ2iOCo0OnW?=
 =?iso-8859-1?Q?BuFiOBZ2Jt3ai3Sbov2XC2qGc5D0KRdqCjPikn3mnIaqs63LcfV4azi8BI?=
 =?iso-8859-1?Q?mTHeWhJ8Upe6dOUBvJKdBPfJFqVfYdUjY4AxD+nYqkyd5B9KN6rFzdwUvF?=
 =?iso-8859-1?Q?hv+NlpmHSJw/aKSc15mnHNdxLuYwyelzkfgUJviAoe1Pbl+4dn7VuJaLRo?=
 =?iso-8859-1?Q?IcksweO1Ts7syKMxIiAulAA7feVIQj1h9r9pYsNZ/sb2FTrqvfjOAFqd1u?=
 =?iso-8859-1?Q?QgcuDJr+XlNCrJ0yNtMMqaNk218X2LVOiDN8//DFTDwQE24s2LhQwLXzo7?=
 =?iso-8859-1?Q?OfIqvX4t8YrkJClZgiSebHEHep5A/vt940rsgOneogehHc6A5SaWA1TOuP?=
 =?iso-8859-1?Q?dEiJrU5YWcBDQhztjgOLgSJds8XFhFSA8rYVmaSf1mBHSh2KggJE5QlJCu?=
 =?iso-8859-1?Q?6OZXxC0ygzfqRKngit3ig/O+V6JyfOVUHV9xTIK1xnR6LKzAr4EC1YejMx?=
 =?iso-8859-1?Q?FqWKmGbDyOhIIKi2B395ThSN+Y3Es8XJDZSnXvAsfCv+bXLUggDF3p1mD+?=
 =?iso-8859-1?Q?drl7NANz22r4f98sk29POBOqChahjP31VgvgnUjxu7xlCvYHnf3cOh98t9?=
 =?iso-8859-1?Q?kb7R5K57D4Te13HX7Q152Rk58kTQ9euBaSbC8xsbNQIfgcHhw9q6Z8tFry?=
 =?iso-8859-1?Q?R0C/J+fJX640b7t4UO3XxamKCaKT9XymwVilyuMs6mABjIlApC7oZShjyr?=
 =?iso-8859-1?Q?8Vk/PtvKOlOQ4kgrNU0h6Ws6Aclb/LQZHIB5TsU1f/hO7G7RhGVN8rtBux?=
 =?iso-8859-1?Q?lI+h/cLNySTtW+QghB1VLDscrnPPFfuScfA5ZSZt+9fwW3/bgjYSa5Hmo6?=
 =?iso-8859-1?Q?J9?=
x-ms-exchange-antispam-messagedata-1: LJgrbOBDMQY5vj/AIuBmK1Eu4m/E2+O3988=
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB0295342E2109C2CB8EECCE6B92062PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a95934-466e-45fe-d055-08deb0e45ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 11:40:02.0840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTbaHQ7UEuZqhgC0r+Fjx42ZdifXFwMi4h7HUR0QehJkPiyqvLZGxyqF0Zl717/c2euSYO7U/mdGSU7tjUlVaKl+t5G5hhM8bHXMxV117twdFz42XV9w3YsCC2ghNUsW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXP287MB4130
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SCC_10_SHORT_WORD_LINES,SCC_5_SHORT_WORD_LINES,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB0295342E2109C2CB8EECCE6B92062PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB0295342E2109C2CB8EECCE6B92062PN0P287MB0295INDP_"

--_000_PN0P287MB0295342E2109C2CB8EECCE6B92062PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Corinna,

This patch extends Cygwin's DLL lazy-loading mechanism in autoload.cc to su=
pport AArch64 (ARM64), mirroring the existing x86_64 implementation.
Thanks & regards,
K Chandru

Inline patch

---
 winsup/cygwin/autoload.cc | 139 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index a038997b3..8f6204b09 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -67,7 +67,7 @@ bool NO_COPY wsock_started;
 /* LoadDLLprime is used to prime the DLL info information, providing an
    additional initialization routine to call prior to calling the first
    function.  */
-#ifdef __x86_64__
+#if defined(__x86_64__)
 #define LoadDLLprime(dllname, init_also, no_resolve_on_fork) __asm__ ("   =
\n\
 .ifndef " #dllname "_primed           \n\
   .section .data_cygwin_nocopy,\"w\"     \n\
@@ -83,6 +83,22 @@ bool NO_COPY wsock_started;
   .set     " #dllname "_primed, 1        \n\
 .endif                    \n\
 ");
+#elif defined(__aarch64__)
+#define LoadDLLprime(dllname, init_also, no_resolve_on_fork) __asm__ ( "\n\
+.ifndef " #dllname "_primed                              \n\
+  .section   .data_cygwin_nocopy,\"w\"                   \n\
+  .balign    8                                          \n\
+." #dllname "_info:                                     \n\
+  .xword     _std_dll_init                               \n\
+  .xword     " #no_resolve_on_fork "                     \n\
+  .long      -1                                         \n\
+  .balign    8                                          \n\
+  .xword     " #init_also "                              \n\
+  .string16  \"" #dllname ".dll\"                        \n\
+  .text                                                \n\
+  .set       " #dllname "_primed, 1                      \n\
+.endif                                                  \n\
+");
 #else
 #error unimplemented for this target
 #endif
@@ -97,7 +113,7 @@ bool NO_COPY wsock_started;
   LoadDLLfuncEx3(name, dllname, notimp, err, 0)

 /* Main DLL setup stuff. */
-#ifdef __x86_64__
+#if defined(__x86_64__)
 #define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
   LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) \
   __asm__ ("                 \n\
@@ -123,10 +139,44 @@ _win32_" #name ":               \n\
   .asciz   \"" #name "\"           \n\
   .text                   \n\
 ");
+#elif defined(__aarch64__)
+#define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
+  LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) \
+  __asm__ ( "\n\
+  .section   ." #dllname "_autoload_text,\"wx\"          \n\
+  .global    " #name "                                   \n\
+  .global    _win32_" #name "                            \n\
+  .p2align   4                                           \n\
+" #name ":                                               \n\
+_win32_" #name ":                                       \n\
+  adr        x16, 3f                                     \n\
+  ldr        x16, [x16]                                  \n\
+  br         x16                                         \n\
+1:                                                      \n\
+  sub        sp, sp, #80                                 \n\
+  stp        x0, x1, [sp, #0]                            \n\
+  stp        x2, x3, [sp, #16]                           \n\
+  stp        x4, x5, [sp, #32]                           \n\
+  stp        x6, x7, [sp, #48]                           \n\
+  stp        x8, x30, [sp, #64]                          \n\
+  adr        x16, 2f                                     \n\
+  ldur       x17, [x16]                                  \n\
+  ldr        x17, [x17]                                  \n\
+  blr        x17                                         \n\
+2:                                                      \n\
+  .xword     ." #dllname "_info                          \n\
+  .hword     " #notimp "                                 \n\
+  .hword     ((" #err ") & 0xffff)                       \n\
+3:                                                      \n\
+  .xword     1b                                          \n\
+  .asciz     \"" #name "\"                               \n\
+  .text                                                \n\
+");
 #else
 #error unimplemented for this target
 #endif

+
 /* DLL loader helper functions used during initialization. */

 /* The function which finds the address, given the name and overwrites
@@ -141,7 +191,7 @@ extern "C" void dll_chain () __asm__ ("dll_chain");

 extern "C" {

-#ifdef __x86_64__
+#if defined(__x86_64__)
 __asm__ ("                      \n\
    .section .rdata,\"r\"                    \n\
 msg1:                           \n\
@@ -203,10 +253,69 @@ dll_chain:                      \n\
   push  %rax     # Restore 'return address'    \n\
   jmp   *%rdx    # Jump to next init function     \n\
 ");
+#elif defined(__aarch64__)
+__asm__ ( "\n\
+  .section .rdata,\"r\"                                  \n\
+msg1:                                                    \n\
+  .ascii \"couldn't dynamically determine load address for '%s' (handle %p=
), %E\\0\" \n\
+                                                         \n\
+  .text                                                  \n\
+  .p2align 2                                             \n\
+noload:                                                  \n\
+  ldr        x2, [sp]            // func_info*           \n\
+  ldr        w3, [x2, #8]        // decoration           \n\
+  tbz        w3, #0, 1f                                  \n\
+                                                         \n\
+  asr        w4, w3, #16                                 \n\
+  str        w4, [sp, #8]                                \n\
+  mov        w0, #127            // ERROR_PROC_NOT_FOUND \n\
+  bl         SetLastError                                \n\
+  ldr        w0, [sp, #8]                                \n\
+  ldr        x30, [sp, #88]                              \n\
+  add        sp, sp, #96                                 \n\
+  ret                                                   \n\
+1:                                                      \n\
+  add        x1, x2, #20                                 \n\
+  ldur       x3, [x2]                                    \n\
+  ldr        x2, [x3, #8]                                \n\
+  adrp       x0, msg1                                   \n\
+  add        x0, x0, #:lo12:msg1                         \n\
+  bl         api_fatal                                  \n\
+                                                         \n\
+  .globl     dll_func_load                               \n\
+dll_func_load:                                          \n\
+  ldr        x2, [sp]                                    \n\
+  ldur       x3, [x2]                                    \n\
+  ldr        x0, [x3, #8]                                \n\
+  add        x1, x2, #20                                 \n\
+  bl         GetProcAddress                              \n\
+  cbz        x0, noload                                  \n\
+                                                         \n\
+  ldr        x2, [sp]                                    \n\
+  add        x3, x2, #12                                 \n\
+  str        x0, [x3]                                    \n\
+                                                         \n\
+  sub        x16, x2, #52                                 \n\
+                                                         \n\
+  add        sp, sp, #16                                 \n\
+  ldp        x0, x1, [sp, #0]                            \n\
+  ldp        x2, x3, [sp, #16]                           \n\
+  ldp        x4, x5, [sp, #32]                           \n\
+  ldp        x6, x7, [sp, #48]                           \n\
+  ldp        x8, x30, [sp, #64]                          \n\
+  add        sp, sp, #80                                 \n\
+  br         x16                                         \n\
+                                                         \n\
+  .global    dll_chain                                   \n\
+dll_chain:                                              \n\
+  stp        x0, xzr, [sp, #-16]!                        \n\
+  br         x1                                         \n\
+");
 #else
 #error unimplemented for this target
 #endif

+
 /* C representations of the two info blocks described above.
    FIXME: These structures confuse gdb for some reason.  GDB can print
    the whole structure but has problems with the name field? */
@@ -260,7 +369,7 @@ dll_load (HANDLE& handle, PWCHAR name)
 #define RETRY_COUNT 10

 /* The standard DLL initialization routine. */
-#ifdef __x86_64__
+#if defined(__x86_64__)

 /* On x86_64, we need assembler wrappers for std_dll_init and wsock_init.
    In the x86_64 ABI it's no safe bet that frame[1] (aka 8(%rbp)) contains
@@ -300,6 +409,26 @@ _" #func ":                      \n\

 INIT_WRAPPER (std_dll_init)

+#elif defined(__aarch64__)
+#define INIT_WRAPPER(func) __asm__ ( "\n\
+  .text                                                  \n\
+  .p2align 2                                             \n\
+  .seh_proc _" #func "                                   \n\
+_" #func ":                                              \n\
+  stp        x29, x30, [sp, #-16]!                        \n\
+  .seh_save_fplr_x 16                                    \n\
+  .seh_endprologue                                       \n\
+  mov        x0, x30                                     \n\
+  bl         " #func "                                   \n\
+  ldp        x29, xzr, [sp], #16                          \n\
+  adrp       x30, dll_chain                              \n\
+  add        x30, x30, #:lo12:dll_chain                  \n\
+  ret                                                   \n\
+  .seh_endproc                                           \n\
+");
+
+INIT_WRAPPER (std_dll_init)
+
 #else
 #error unimplemented for this target
 #endif
@@ -360,7 +489,7 @@ std_dll_init (struct func_info *func)

 /* Initialization function for winsock stuff. */

-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__aarch64__)
 /* See above comment preceeding std_dll_init. */
 INIT_WRAPPER (wsock_init)
 #else
--
2.49.0.windows.1




--_000_PN0P287MB0295342E2109C2CB8EECCE6B92062PN0P287MB0295INDP_--

--_004_PN0P287MB0295342E2109C2CB8EECCE6B92062PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-autoload-add-AArch64-build-stubs.patch"
Content-Description: Cygwin-autoload-add-AArch64-build-stubs.patch
Content-Disposition: attachment;
	filename="Cygwin-autoload-add-AArch64-build-stubs.patch"; size=10895;
	creation-date="Wed, 13 May 2026 11:34:40 GMT";
	modification-date="Wed, 13 May 2026 11:40:01 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwMTFiZTYwYzVlZGYyOWIxMmFkY2JkNzUyNjM5NTkwMDBhMzVjYzky
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IFdlZCwgMTMgTWF5IDIwMjYgMTY6MjE6NTYgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBDeWd3aW46IGF1dG9sb2FkOiBhZGQgQUFyY2g2NCBidWlsZCBzdHVi
cwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47
IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJp
dAoKQWRkIEFBcmNoNjQgYXNzZW1ibHkgaW1wbGVtZW50YXRpb25zIG9mIExv
YWRETExwcmltZSwgTG9hZERMTGZ1bmNFeDMsCmRsbF9mdW5jX2xvYWQsIGRs
bF9jaGFpbiwgYW5kIElOSVRfV1JBUFBFUiwgbWlycm9yaW5nIHRoZSBleGlz
dGluZwp4ODZfNjQgbGF6eS1sb2FkaW5nIG1lY2hhbmlzbS4gQWxzbyBjb252
ZXJ0ICNpZmRlZiBndWFyZHMgdG8KICNpZiBkZWZpbmVkKCkgZm9yIGNvbnNp
c3RlbmN5LgoKU2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsu
YmFydG9uQG1pY3Jvc29mdC5jb20+ClNpZ25lZC1vZmYtYnk6IFRoaXJ1bWFs
YWkgTmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5uYWdhbGluZ2FtQG11bHRpY29y
ZXdhcmVpbmMuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaGFuZHJ1IEt1bWFyZXNh
biA8Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0t
LQogd2luc3VwL2N5Z3dpbi9hdXRvbG9hZC5jYyB8IDEzOSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQs
IDEzNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3dpbnN1cC9jeWd3aW4vYXV0b2xvYWQuY2MgYi93aW5zdXAvY3lnd2lu
L2F1dG9sb2FkLmNjCmluZGV4IGEwMzg5OTdiMy4uOGY2MjA0YjA5IDEwMDY0
NAotLS0gYS93aW5zdXAvY3lnd2luL2F1dG9sb2FkLmNjCisrKyBiL3dpbnN1
cC9jeWd3aW4vYXV0b2xvYWQuY2MKQEAgLTY3LDcgKzY3LDcgQEAgYm9vbCBO
T19DT1BZIHdzb2NrX3N0YXJ0ZWQ7CiAvKiBMb2FkRExMcHJpbWUgaXMgdXNl
ZCB0byBwcmltZSB0aGUgRExMIGluZm8gaW5mb3JtYXRpb24sIHByb3ZpZGlu
ZyBhbgogICAgYWRkaXRpb25hbCBpbml0aWFsaXphdGlvbiByb3V0aW5lIHRv
IGNhbGwgcHJpb3IgdG8gY2FsbGluZyB0aGUgZmlyc3QKICAgIGZ1bmN0aW9u
LiAgKi8KLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82
NF9fKQogI2RlZmluZSBMb2FkRExMcHJpbWUoZGxsbmFtZSwgaW5pdF9hbHNv
LCBub19yZXNvbHZlX29uX2ZvcmspIF9fYXNtX18gKCIJXG5cCiAuaWZuZGVm
ICIgI2RsbG5hbWUgIl9wcmltZWQJCQkJXG5cCiAgIC5zZWN0aW9uCS5kYXRh
X2N5Z3dpbl9ub2NvcHksXCJ3XCIJCVxuXApAQCAtODMsNiArODMsMjIgQEAg
Ym9vbCBOT19DT1BZIHdzb2NrX3N0YXJ0ZWQ7CiAgIC5zZXQJCSIgI2RsbG5h
bWUgIl9wcmltZWQsIDEJCQlcblwKIC5lbmRpZgkJCQkJCQlcblwKICIpOwor
I2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyNkZWZpbmUgTG9hZERMTHBy
aW1lKGRsbG5hbWUsIGluaXRfYWxzbywgbm9fcmVzb2x2ZV9vbl9mb3JrKSBf
X2FzbV9fICggIlxuXAorLmlmbmRlZiAiICNkbGxuYW1lICJfcHJpbWVkICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIC5zZWN0aW9uICAg
LmRhdGFfY3lnd2luX25vY29weSxcIndcIiAgICAgICAgICAgICAgICAgICBc
blwKKyAgLmJhbGlnbiAgICA4ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXG5cCisuIiAjZGxsbmFtZSAiX2luZm86ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICAueHdvcmQg
ICAgIF9zdGRfZGxsX2luaXQgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXG5cCisgIC54d29yZCAgICAgIiAjbm9fcmVzb2x2ZV9vbl9mb3JrICIg
ICAgICAgICAgICAgICAgICAgICBcblwKKyAgLmxvbmcgICAgICAtMSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIC5i
YWxpZ24gICAgOCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFxuXAorICAueHdvcmQgICAgICIgI2luaXRfYWxzbyAiICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIC5zdHJpbmcxNiAgXCIi
ICNkbGxuYW1lICIuZGxsXCIgICAgICAgICAgICAgICAgICAgICAgICBcblwK
KyAgLnRleHQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcblwKKyAgLnNldCAgICAgICAiICNkbGxuYW1lICJfcHJp
bWVkLCAxICAgICAgICAgICAgICAgICAgICAgIFxuXAorLmVuZGlmICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
blwKKyIpOwogI2Vsc2UKICNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlz
IHRhcmdldAogI2VuZGlmCkBAIC05Nyw3ICsxMTMsNyBAQCBib29sIE5PX0NP
UFkgd3NvY2tfc3RhcnRlZDsKICAgTG9hZERMTGZ1bmNFeDMobmFtZSwgZGxs
bmFtZSwgbm90aW1wLCBlcnIsIDApCiAKIC8qIE1haW4gRExMIHNldHVwIHN0
dWZmLiAqLwotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2
XzY0X18pCiAjZGVmaW5lIExvYWRETExmdW5jRXgzKG5hbWUsIGRsbG5hbWUs
IG5vdGltcCwgZXJyLCBub19yZXNvbHZlX29uX2ZvcmspIFwKICAgTG9hZERM
THByaW1lIChkbGxuYW1lLCBkbGxfZnVuY19sb2FkLCBub19yZXNvbHZlX29u
X2ZvcmspIFwKICAgX19hc21fXyAoIgkJCQkJCVxuXApAQCAtMTIzLDEwICsx
MzksNDQgQEAgX3dpbjMyXyIgI25hbWUgIjoJCQkJCVxuXAogICAuYXNjaXoJ
XCIiICNuYW1lICJcIgkJCQlcblwKICAgLnRleHQJCQkJCQkJXG5cCiAiKTsK
KyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisjZGVmaW5lIExvYWRETExm
dW5jRXgzKG5hbWUsIGRsbG5hbWUsIG5vdGltcCwgZXJyLCBub19yZXNvbHZl
X29uX2ZvcmspIFwKKyAgTG9hZERMTHByaW1lIChkbGxuYW1lLCBkbGxfZnVu
Y19sb2FkLCBub19yZXNvbHZlX29uX2ZvcmspIFwKKyAgX19hc21fXyAoICJc
blwKKyAgLnNlY3Rpb24gICAuIiAjZGxsbmFtZSAiX2F1dG9sb2FkX3RleHQs
XCJ3eFwiICAgICAgICAgIFxuXAorICAuZ2xvYmFsICAgICIgI25hbWUgIiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIC5nbG9i
YWwgICAgX3dpbjMyXyIgI25hbWUgIiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcblwKKyAgLnAyYWxpZ24gICA0ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFxuXAorIiAjbmFtZSAiOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCitf
d2luMzJfIiAjbmFtZSAiOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFxuXAorICBhZHIgICAgICAgIHgxNiwgM2YgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIGxkciAgICAgICAg
eDE2LCBbeDE2XSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
blwKKyAgYnIgICAgICAgICB4MTYgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFxuXAorMTogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgc3ViICAg
ICAgICBzcCwgc3AsICM4MCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFxuXAorICBzdHAgICAgICAgIHgwLCB4MSwgW3NwLCAjMF0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXG5cCisgIHN0cCAgICAgICAgeDIsIHgz
LCBbc3AsICMxNl0gICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAg
c3RwICAgICAgICB4NCwgeDUsIFtzcCwgIzMyXSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFxuXAorICBzdHAgICAgICAgIHg2LCB4NywgW3NwLCAjNDhd
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIHN0cCAgICAgICAg
eDgsIHgzMCwgW3NwLCAjNjRdICAgICAgICAgICAgICAgICAgICAgICAgICBc
blwKKyAgYWRyICAgICAgICB4MTYsIDJmICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFxuXAorICBsZHVyICAgICAgIHgxNywgW3gxNl0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIGxkciAg
ICAgICAgeDE3LCBbeDE3XSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcblwKKyAgYmxyICAgICAgICB4MTcgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFxuXAorMjogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAg
Lnh3b3JkICAgICAuIiAjZGxsbmFtZSAiX2luZm8gICAgICAgICAgICAgICAg
ICAgICAgICAgIFxuXAorICAuaHdvcmQgICAgICIgI25vdGltcCAiICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIC5od29yZCAgICAg
KCgiICNlcnIgIikgJiAweGZmZmYpICAgICAgICAgICAgICAgICAgICAgICBc
blwKKzM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXG5cCisgIC54d29yZCAgICAgMWIgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgLmFzY2l6
ICAgICBcIiIgI25hbWUgIlwiICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFxuXAorICAudGV4dCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFxuXAorIik7CiAjZWxzZQogI2Vycm9yIHVu
aW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CiAjZW5kaWYKIAorCiAvKiBE
TEwgbG9hZGVyIGhlbHBlciBmdW5jdGlvbnMgdXNlZCBkdXJpbmcgaW5pdGlh
bGl6YXRpb24uICovCiAKIC8qIFRoZSBmdW5jdGlvbiB3aGljaCBmaW5kcyB0
aGUgYWRkcmVzcywgZ2l2ZW4gdGhlIG5hbWUgYW5kIG92ZXJ3cml0ZXMKQEAg
LTE0MSw3ICsxOTEsNyBAQCBleHRlcm4gIkMiIHZvaWQgZGxsX2NoYWluICgp
IF9fYXNtX18gKCJkbGxfY2hhaW4iKTsKIAogZXh0ZXJuICJDIiB7CiAKLSNp
ZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogX19h
c21fXyAoIgkJCQkJCQkJXG5cCiAJIC5zZWN0aW9uIC5yZGF0YSxcInJcIgkJ
CQkJCQlcblwKIG1zZzE6CQkJCQkJCQkJXG5cCkBAIC0yMDMsMTAgKzI1Myw2
OSBAQCBkbGxfY2hhaW46CQkJCQkJCQlcblwKIAlwdXNoCSVyYXgJCSMgUmVz
dG9yZSAncmV0dXJuIGFkZHJlc3MnCQlcblwKIAlqbXAJKiVyZHgJCSMgSnVt
cCB0byBuZXh0IGluaXQgZnVuY3Rpb24JCVxuXAogIik7CisjZWxpZiBkZWZp
bmVkKF9fYWFyY2g2NF9fKQorX19hc21fXyAoICJcblwKKyAgLnNlY3Rpb24g
LnJkYXRhLFwiclwiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFxuXAorbXNnMTogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXG5cCisgIC5hc2NpaSBcImNvdWxkbid0IGR5
bmFtaWNhbGx5IGRldGVybWluZSBsb2FkIGFkZHJlc3MgZm9yICclcycgKGhh
bmRsZSAlcCksICVFXFwwXCIgXG5cCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgLnRl
eHQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFxuXAorICAucDJhbGlnbiAyICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXG5cCitub2xvYWQ6ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwK
KyAgbGRyICAgICAgICB4MiwgW3NwXSAgICAgICAgICAgIC8vIGZ1bmNfaW5m
byogICAgICAgICAgIFxuXAorICBsZHIgICAgICAgIHczLCBbeDIsICM4XSAg
ICAgICAgLy8gZGVjb3JhdGlvbiAgICAgICAgICAgXG5cCisgIHRieiAgICAg
ICAgdzMsICMwLCAxZiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcblwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFxuXAorICBhc3IgICAgICAgIHc0LCB3Mywg
IzE2ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIHN0
ciAgICAgICAgdzQsIFtzcCwgIzhdICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcblwKKyAgbW92ICAgICAgICB3MCwgIzEyNyAgICAgICAgICAg
IC8vIEVSUk9SX1BST0NfTk9UX0ZPVU5EIFxuXAorICBibCAgICAgICAgIFNl
dExhc3RFcnJvciAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5c
CisgIGxkciAgICAgICAgdzAsIFtzcCwgIzhdICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcblwKKyAgbGRyICAgICAgICB4MzAsIFtzcCwgIzg4
XSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBhZGQgICAg
ICAgIHNwLCBzcCwgIzk2ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXG5cCisgIHJldCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFxuXAorMTogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgYWRk
ICAgICAgICB4MSwgeDIsICMyMCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFxuXAorICBsZHVyICAgICAgIHgzLCBbeDJdICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIGxkciAgICAgICAgeDIs
IFt4MywgIzhdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwK
KyAgYWRycCAgICAgICB4MCwgbXNnMSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXG5cCisgIGFkZCAgICAgICAgeDAsIHgwLCAjOmxvMTI6
bXNnMSAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgYmwgICAgICAg
ICBhcGlfZmF0YWwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XG5cCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcblwKKyAgLmdsb2JsICAgICBkbGxfZnVuY19s
b2FkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorZGxsX2Z1
bmNfbG9hZDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcblwKKyAgbGRyICAgICAgICB4MiwgW3NwXSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBsZHVyICAgICAgIHgzLCBb
eDJdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisg
IGxkciAgICAgICAgeDAsIFt4MywgIzhdICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcblwKKyAgYWRkICAgICAgICB4MSwgeDIsICMyMCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBibCAgICAgICAg
IEdldFByb2NBZGRyZXNzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XG5cCisgIGNieiAgICAgICAgeDAsIG5vbG9hZCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcblwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBsZHIg
ICAgICAgIHgyLCBbc3BdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXG5cCisgIGFkZCAgICAgICAgeDMsIHgyLCAjMTIgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgc3RyICAgICAgICB4MCwg
W3gzXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXG5cCisgIHN1YiAgICAgICAgeDE2LCB4MiwgIzUyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcblwKKyAgYWRkICAgICAgICBzcCwgc3AsICMxNiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFxuXAorICBsZHAgICAgICAgIHgwLCB4MSwg
W3NwLCAjMF0gICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIGxk
cCAgICAgICAgeDIsIHgzLCBbc3AsICMxNl0gICAgICAgICAgICAgICAgICAg
ICAgICAgICBcblwKKyAgbGRwICAgICAgICB4NCwgeDUsIFtzcCwgIzMyXSAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBsZHAgICAgICAgIHg2
LCB4NywgW3NwLCAjNDhdICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5c
CisgIGxkcCAgICAgICAgeDgsIHgzMCwgW3NwLCAjNjRdICAgICAgICAgICAg
ICAgICAgICAgICAgICBcblwKKyAgYWRkICAgICAgICBzcCwgc3AsICM4MCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBiciAgICAg
ICAgIHgxNiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXG5cCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcblwKKyAgLmdsb2JhbCAgICBkbGxfY2hh
aW4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorZGxs
X2NoYWluOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcblwKKyAgc3RwICAgICAgICB4MCwgeHpyLCBbc3AsICMtMTZd
ISAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBiciAgICAgICAgIHgx
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwK
KyIpOwogI2Vsc2UKICNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRh
cmdldAogI2VuZGlmCiAKKwogLyogQyByZXByZXNlbnRhdGlvbnMgb2YgdGhl
IHR3byBpbmZvIGJsb2NrcyBkZXNjcmliZWQgYWJvdmUuCiAgICBGSVhNRTog
VGhlc2Ugc3RydWN0dXJlcyBjb25mdXNlIGdkYiBmb3Igc29tZSByZWFzb24u
ICBHREIgY2FuIHByaW50CiAgICB0aGUgd2hvbGUgc3RydWN0dXJlIGJ1dCBo
YXMgcHJvYmxlbXMgd2l0aCB0aGUgbmFtZSBmaWVsZD8gKi8KQEAgLTI2MCw3
ICszNjksNyBAQCBkbGxfbG9hZCAoSEFORExFJiBoYW5kbGUsIFBXQ0hBUiBu
YW1lKQogI2RlZmluZSBSRVRSWV9DT1VOVCAxMAogCiAvKiBUaGUgc3RhbmRh
cmQgRExMIGluaXRpYWxpemF0aW9uIHJvdXRpbmUuICovCi0jaWZkZWYgX194
ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAogLyogT24geDg2
XzY0LCB3ZSBuZWVkIGFzc2VtYmxlciB3cmFwcGVycyBmb3Igc3RkX2RsbF9p
bml0IGFuZCB3c29ja19pbml0LgogICAgSW4gdGhlIHg4Nl82NCBBQkkgaXQn
cyBubyBzYWZlIGJldCB0aGF0IGZyYW1lWzFdIChha2EgOCglcmJwKSkgY29u
dGFpbnMKQEAgLTMwMCw2ICs0MDksMjYgQEAgXyIgI2Z1bmMgIjoJCQkJCQkJ
CVxuXAogCiBJTklUX1dSQVBQRVIgKHN0ZF9kbGxfaW5pdCkKIAorI2VsaWYg
ZGVmaW5lZChfX2FhcmNoNjRfXykKKyNkZWZpbmUgSU5JVF9XUkFQUEVSKGZ1
bmMpIF9fYXNtX18gKCAiXG5cCisgIC50ZXh0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgLnAyYWxp
Z24gMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFxuXAorICAuc2VoX3Byb2MgXyIgI2Z1bmMgIiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXG5cCitfIiAjZnVuYyAiOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAg
c3RwICAgICAgICB4MjksIHgzMCwgW3NwLCAjLTE2XSEgICAgICAgICAgICAg
ICAgICAgICAgICBcblwKKyAgLnNlaF9zYXZlX2ZwbHJfeCAxNiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICAuc2VoX2VuZHBy
b2xvZ3VlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XG5cCisgIG1vdiAgICAgICAgeDAsIHgzMCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcblwKKyAgYmwgICAgICAgICAiICNmdW5jICIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBsZHAg
ICAgICAgIHgyOSwgeHpyLCBbc3BdLCAjMTYgICAgICAgICAgICAgICAgICAg
ICAgICAgIFxuXAorICBhZHJwICAgICAgIHgzMCwgZGxsX2NoYWluICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIGFkZCAgICAgICAgeDMw
LCB4MzAsICM6bG8xMjpkbGxfY2hhaW4gICAgICAgICAgICAgICAgICBcblwK
KyAgcmV0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXG5cCisgIC5zZWhfZW5kcHJvYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyIpOworCitJTklU
X1dSQVBQRVIgKHN0ZF9kbGxfaW5pdCkKKwogI2Vsc2UKICNlcnJvciB1bmlt
cGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCkBAIC0zNjAsNyAr
NDg5LDcgQEAgc3RkX2RsbF9pbml0IChzdHJ1Y3QgZnVuY19pbmZvICpmdW5j
KQogCiAvKiBJbml0aWFsaXphdGlvbiBmdW5jdGlvbiBmb3Igd2luc29jayBz
dHVmZi4gKi8KIAotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9f
eDg2XzY0X18pIHx8IGRlZmluZWQoX19hYXJjaDY0X18pCiAvKiBTZWUgYWJv
dmUgY29tbWVudCBwcmVjZWVkaW5nIHN0ZF9kbGxfaW5pdC4gKi8KIElOSVRf
V1JBUFBFUiAod3NvY2tfaW5pdCkKICNlbHNlCi0tIAoyLjQ5LjAud2luZG93
cy4xCgo=

--_004_PN0P287MB0295342E2109C2CB8EECCE6B92062PN0P287MB0295INDP_--
