Return-Path: <SRS0=Jkqo=EA=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id 7911C4BAD17D
	for <cygwin-patches@cygwin.com>; Thu,  4 Jun 2026 07:35:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7911C4BAD17D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7911C4BAD17D
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1780558516; cv=pass;
	b=jwI+0ASTtRugfEh4u5MSPJ9dQ2N/FZpxYCxBCyYTTpMftcRDPXoujUqsXAQP1oI2Csps+uOoziyXogdRkGz4C7iuHVdEX+43Ip6MwFkXkTpwAESZ77Tbzcc9InR7Fl+3k3X0BSM2gqNo1i+kr9LsRrHtJ/8ZXUxEp/He6Cukztw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780558516; c=relaxed/simple;
	bh=y+UeyPGbaiq7+yu6epym0XJ4FfBkf9UkKMB0d1D0Hj0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=gWGF0FjwjbcWS9L8SqP3sOlYaHPdMlXjBlH/lAZ1W//Hu3QqomzDaAdG9XCUj1lkbZcO7l4373uEEDssQnRcqzCr1pSTjA/no3rbdXUQ5H4IjlgGxxo4sTdS+6JWwXz9r3YQ+Cpctl61t4cKXXktQuIZrTpAByQR/gI9BMzhFzY=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=hhuSP47x
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7911C4BAD17D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=hhuSP47x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5yaDKpSWobCddY1LXnioI4D3HkYiPRzRtihMfEXjkhNJ/01Iw7KQstcdm+oz5pkQHlQN45G0DnplADuyoOBS4iDQQayu66c6/fBGIcQFxOTmaF/1+YN/ysjw3mjaJVZYiwQfgVtbQFr44JhbQ5y3XeJCjjYjk/a3LJikG1XaeGpW1ISTHg//yvsoO0Ry8cOuqatYY32w6iWMUlwXt7S5ZEeDBHkybWLlf6URNAsyOioQIXbzIJO2JW8VPqj5cZnYY2mGWP7PWcMFsDrqr2lA3zgcArpH5HYEq4u3DvU3qY+LcHRKSrQ27YCJx2k5Hxnl6lsotUWU/zmVItmsfYxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKkjBgOcVitMmSscZclus1GewubMSfdP/vUMjRmyoX8=;
 b=OGE4/kPuolxYcm7rc6Mdm1T0FRo7X26r1jSaoQ8PZtMMnHTUCMjwCgzTAXrYJcCy0hv2jOpXoL0cSxDbHA/IOtgdL6xak1BdHlwazckdlVhtNHwFsJbH/3jHlPv/dfR3gPeQdI0nUS1YjMfZ8CMsbNxs+teZOjrueJgxDywtqh+vMByy3t349IXa216/IhbL9+pvWPzTwBi9rAmtPgpzbQztpfz/ys51L07gHKilajEz0xrfDPliHTE3tv2Fm/3cpeCQyreLG83uQynaepUfH7GgXPhQCr9/XatOMlaHI5FsuDywFfpPGR5k5M1uxIwimDwj3Jtld4ptEFckzel3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKkjBgOcVitMmSscZclus1GewubMSfdP/vUMjRmyoX8=;
 b=hhuSP47xVw4QgWiUnlVHtwFO0W2o09ZuNlaLfftnAmp3TpJVFQTms4++NTj21Djr0aDqWdLibEaErNNBADQncfIw+uYhCZhLRhR8MMTm6Cy9qLSrEy+TB5LeTKvrIZMBvGP9GWoBNSy0T3WVr3s5ORpGHUFd3EMpp6GwKNg0fk4u1IuVGtL/BPdW+t0P8qawCbU15+C0R790f8/AynjPAqb+KD9FtZAZnxsyYWrIQED+UElLqBhIWXfrot4Q05CgMcIX0mFUY54TD5wqgFajwr1z+UDqAwRXD+kECblkUz+bai1l6dpi9es/6dmd9WlbXlcHeUyEP9D1jVJJykpyYA==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by MA5P287MB4096.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:162::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 07:35:11 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 07:35:10 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: Evgeny Karpov <evgeny.karpov@arm.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, "nd@arm.com"
	<nd@arm.com>
Subject: [PATCH v2] Cygwin: autoload: Add AArch64 implementation 
Thread-Topic: [PATCH v2] Cygwin: autoload: Add AArch64 implementation 
Thread-Index: AQHc8/SsnMX1Rd4aAUGZG7QvfHp6MQ==
Date: Thu, 4 Jun 2026 07:35:10 +0000
Message-ID:
 <PN0P287MB02951A11C49A1208A9BA66F392102@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
References:
 <PN0P287MB0295342E2109C2CB8EECCE6B92062@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <ag8IvAkqoNVM-AH2@arm.com>
In-Reply-To: <ag8IvAkqoNVM-AH2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|MA5P287MB4096:EE_
x-ms-office365-filtering-correlation-id: 2f871b4f-d7c7-4ebd-c154-08dec20bcf26
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|6049299003|376014|39142699007|1800799024|366016|31052699007|38070700021|4053099003|8096899003|55112099003|6133799003|56012099006|4143699003|5023799004|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info:
 eh4SVmofkgn8xEhfGVNmtkwXN9Cl1mAOsvGSj0fHAd9irFsiZqe34nnXB23Red8ZYfT11Fu3me3GFFzkig19pG6j1zY6GdW12mbBDJDf0ORHIaM3LR2D+l9NHdwdzMvtvgjMo6u//Q6pCScPbXs+u7wJV73MNq+/qXjxcWpv5ATFNvhImmcudKuUKbc+1jRAMulyeLoXszX0JBx5YhPju1ys7/tSQH0LpSmN8aifTV8cRG5tsIAMivdGnglf9SqA/QGI5eYD04JTAe2ZIKkvBS04MuRII+07OVaFchfvOJdZlOx2C5uqwlqAfOKq9jMNphDP3kh73/l80oqFMHCprHBILrAnxh8O6ll0PbYNOeBQQPxhGL/OyRsSdOLG3equTGWIQ9z7ENR7KZYegeuZ6uQ6wwoQ5swnTCdLrVTRxnVyFSkSZAqMgkY9b+xCwoyp7lg/weJqCxDEMgYSGxlkV2TW6umUXF1XWDsficXYI6OW99m/a/Pr7upOQelhyI+ITnctZmDNxPPjGL3wPZIzUM9tqbdKiqIvM9lRr+f8oYbKzHtHMYVZDCbfPqL+BDMxUWvOzCGqwU/AArm3wmHY24roW8UfhjvkgVzYFFcNWFElwh3ba2GsGuJhB/rAreyK9bhtWbNkxzzcHBAuqclcJQGa/mkFpG2ZGFod937z+PumLimXNoswOmP+tDFrAQNWznYcAQswRcev0G+GO2IALOEz9Kq8jTXS3uCf7ABW2/67psFeVN6V+knSOX728h3L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(6049299003)(376014)(39142699007)(1800799024)(366016)(31052699007)(38070700021)(4053099003)(8096899003)(55112099003)(6133799003)(56012099006)(4143699003)(5023799004)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nO5vSuFu5qlax7AtQwYM2jXtlmZvmvOTxNqQuFem4VdtB9yeoN0zIonyr/?=
 =?iso-8859-1?Q?B+LU1O+Q6j+8SRK+Eqqk2NTo13EWJQzXQu+aY4png+juSJ3/8MN0IzUzV3?=
 =?iso-8859-1?Q?rd7Sy8+kALwNGTcgQNdlnvHriZYLcUzmbEE3Jt2j5ShB7adI4iwUQQq5oW?=
 =?iso-8859-1?Q?Z6IUQ3M/p1j2iz5Iz0RuOJPIMMIP+ltKTRahcrnhI/alaxvoHjV9PF5nWf?=
 =?iso-8859-1?Q?uaMSSe/ykroGiifDpqY8KnGhk1KC3QNMg31rsrM/aSs3kjnGaHez+c9Mcn?=
 =?iso-8859-1?Q?BaETx5+XHo2xPr2vm+/MIrijIhqHZQnozW7NGTSW1SPgRbci/E+csGJjUs?=
 =?iso-8859-1?Q?cz3hMsKji3HZSUFj9YPyY9+ZW3sjPEKtk1qCiMlW8qtOwX/t5GdFOBHGv/?=
 =?iso-8859-1?Q?OsdYYRciq/MPdzO7lD2eeQyeCEmmpJ/HybvfblASx+yluKJv9CRyxOMsDH?=
 =?iso-8859-1?Q?PktmGu+hEW91QrI8peR9uWKhXSjASgiQg54ItRZEtGly1X3Spi5RG1fGSX?=
 =?iso-8859-1?Q?AOn+9ITcAcZcqoC1taDUzA6XXrhGK2HxMRImbUgjWjI+Fq/ai+1y76oKoI?=
 =?iso-8859-1?Q?1cxI2ASvOKDSgHZhs2f+UX6ULFwTiUlEch5kLSo77P3k+Q1rSusfhQPSXl?=
 =?iso-8859-1?Q?hPBps74rVCTuzkydsa0N2/MF4EVLV4XztfCk6x3kx5gzLDJR+EF5jNjymR?=
 =?iso-8859-1?Q?DgBjvqAKvY2Ldh70RwzHp5xXqmOpJSsHkO12weL+F1pCpjdy6XnvyI2LLk?=
 =?iso-8859-1?Q?97FAQYWbpLK+T1SrcckaEylNDs+ACh/lhPygpZr/KgZVcYS86RG12Se4MB?=
 =?iso-8859-1?Q?vgJl7hx0/31lC/0r4RewYm/+4B1ZNrE2MDX1oS7jlAlIbfkoDx8uMXrJPa?=
 =?iso-8859-1?Q?dc+wmNUNzzkbl+3Ermy/0bKBBr5otLOOvICvin9UZNSMDyotfD6gUbKcV8?=
 =?iso-8859-1?Q?HRG0wMYme1+CeTmIzq3YqCeUsYBYGEvV2RSb2OhmAOnPo5VFTEGfUq29rS?=
 =?iso-8859-1?Q?Mbdr3bkFChx/ieDGT1cg/zSpj2lXPGJWAo9cqE5FHGNMub2Hzj4X0B5lDC?=
 =?iso-8859-1?Q?Mq8lJs9/xcwEww8u+ajiOp+yEQ1OSOXUOTDeQReQPmKJheIAi15aPzqCqT?=
 =?iso-8859-1?Q?gbv2DU8orZqvtjHpkgZmm5QHFn9MVXLMPWgTWs/rNDt9KlOjqqQpBR+cX0?=
 =?iso-8859-1?Q?l/0HU+G/BJicBr/hQpG6xc5ElTgZ0fS0QBWdMwzxxJolBgI8XMz4k34uZM?=
 =?iso-8859-1?Q?P0xtOydvo6QVAplMjXKb+jcMGdOODt+TL+5hrY8tXNSbhqbC32n8DWrUaw?=
 =?iso-8859-1?Q?7Tr0UPvx6A1If23mUpzy7UZLZUFtCtneMLldKzRu+a6tW94Mn+Fp6Nphhe?=
 =?iso-8859-1?Q?7VetDYX+TWu6INIGyAzLaxfnVH7vaEz3WwWad47J8YY+24hnv3EeOvPg5i?=
 =?iso-8859-1?Q?QfX6igTzIzKR6HbRVjMQaLXpPAajJlHQbOHi1cbzhlNYdop/Zp5xS75Blz?=
 =?iso-8859-1?Q?LMtPPoyS1Kd8jqoc0SSoDDZnIwtmcQZm1Kfp89T8O3XmB5HTux9PZXuf04?=
 =?iso-8859-1?Q?/ZiCPQdiaq0Qfdfw64Pe+zUM9keHDFaTGtt0K7KltrCC5VpiaxGA6srqSh?=
 =?iso-8859-1?Q?03wJPDnJ2eRt+b74AfAS9BvG1GIwliQteqzKTDgecTmu9xVoqyHM+girtk?=
 =?iso-8859-1?Q?QLwkj9b4364Hg0RoGtQddvOHi44X5Ad0raTPcW/Ro+5ox4dDUjHWRaZaZ8?=
 =?iso-8859-1?Q?HWs3povHAakRSRZobZgd/AORWieAKbIAgDHloeYwuv9ni8TbfGF2Rx2MAA?=
 =?iso-8859-1?Q?koxJOh2zHnPfiP+MhOBFps7VQkhelLpb6RvpyXHSzScrvWNgEIQxmvjZmh?=
 =?iso-8859-1?Q?YG?=
x-ms-exchange-antispam-messagedata-1:
 D0l+R647CMndlYILy34Nrr+OHQyuXvPdnkZadTS9UFqt4YQDaIwgxLta
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB02951A11C49A1208A9BA66F392102PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f871b4f-d7c7-4ebd-c154-08dec20bcf26
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 07:35:10.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFmrMk8iFPCkN3aHtAu/0zazA29JywNQ34RlLWAoctnwOqd0s+q4IwvS/AZgSjkB/b21pwcS0mflcyi4xT3q7aDM2oZlF/DeMxbpsQQDqQkkzUmBgT3gOEuRgttU0n7m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB4096
X-Spam-Status: No, score=-12.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB02951A11C49A1208A9BA66F392102PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB02951A11C49A1208A9BA66F392102PN0P287MB0295INDP_"

--_000_PN0P287MB02951A11C49A1208A9BA66F392102PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Evgeny,

>LoadDLLprime contains only data. It might make sense to keep only
>one version for x86_64 and aarch64, and use WORD64 for .quad/.xword.

In v2, we introduced a WORD64 macro:

#if defined(__x86_64__)
# define WORD64 ".quad"
#elif defined(__aarch64__)
# define WORD64 ".xword"
#else
# error unimplemented for this target
#endif

And unified LoadDLLprime into a single shared definition using WORD64,
removing the duplicate x86_64/aarch64 versions.
Also added inline comments throughout AArch64 assembly blocks
documenting execution flow.

Please let me know if anything needs further clarification.

Inline patch:

---
 winsup/cygwin/autoload.cc | 161 ++++++++++++++++++++++++++++++++------
 1 file changed, 138 insertions(+), 23 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index a038997b3..b93fdf3dc 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -64,28 +64,34 @@ bool NO_COPY wsock_started;
  *  DLL name (n bytes)  asciz string containing the name of the DLL.
  */

+#if defined(__x86_64__)
+# define WORD64 ".quad"
+#elif defined(__aarch64__)
+# define WORD64 ".xword"
+#else
+# error unimplemented for this target
+#endif
+
 /* LoadDLLprime is used to prime the DLL info information, providing an
    additional initialization routine to call prior to calling the first
-   function.  */
-#ifdef __x86_64__
-#define LoadDLLprime(dllname, init_also, no_resolve_on_fork) __asm__ ("   =
\n\
-.ifndef " #dllname "_primed           \n\
-  .section .data_cygwin_nocopy,\"w\"     \n\
-  .align   8              \n\
-."#dllname "_info:              \n\
-  .quad    _std_dll_init           \n\
-  .quad    " #no_resolve_on_fork "       \n\
-  .long    -1             \n\
-  .align   8              \n\
-  .quad    " #init_also "          \n\
-  .string16   \"" #dllname ".dll\"       \n\
-  .text                   \n\
-  .set     " #dllname "_primed, 1        \n\
-.endif                    \n\
+   function. WORD64 stands in for .quad/.xword, and .balign (which means
+   "align to N bytes" on both targets - "x64" and "arm64) is used for
+   alignment.  */
+#define LoadDLLprime(dllname, init_also, no_resolve_on_fork) __asm__ ("\n\
+.ifndef " #dllname "_primed                              \n\
+  .section   .data_cygwin_nocopy,\"w\"                   \n\
+  .balign    8                                           \n\
+." #dllname "_info:                                      \n\
+  " WORD64 "   _std_dll_init                             \n\
+  " WORD64 "   " #no_resolve_on_fork "                   \n\
+  .long      -1                                          \n\
+  .balign    8                                           \n\
+  " WORD64 "   " #init_also "                            \n\
+  .string16  \"" #dllname ".dll\"                        \n\
+  .text                                                  \n\
+  .set       " #dllname "_primed, 1                      \n\
+.endif                                                   \n\
 ");
-#else
-#error unimplemented for this target
-#endif

 /* Standard DLL load macro.  May invoke a fatal error if the function isn't
    found. */
@@ -97,7 +103,7 @@ bool NO_COPY wsock_started;
   LoadDLLfuncEx3(name, dllname, notimp, err, 0)

 /* Main DLL setup stuff. */
-#ifdef __x86_64__
+#if defined(__x86_64__)
 #define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
   LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) \
   __asm__ ("                 \n\
@@ -123,10 +129,44 @@ _win32_" #name ":               \n\
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
+  adr        x16, 3f          // x16 =3D &func_addr slot (label 3 =3D=3D f=
unc_info+12)\n\
+  ldr        x16, [x16]       // x16 =3D *(&func_addr) =3D 1b first time, =
real addr later\n\
+  br         x16              // fast-path branch into the resolved DLL fu=
nc\n\
+1:                                                      \n\
+  sub        sp, sp, #80      // reserve 80B frame for caller's arg regs +=
 LR\n\
+  stp        x0, x1, [sp, #0]                            \n\
+  stp        x2, x3, [sp, #16]                           \n\
+  stp        x4, x5, [sp, #32]                           \n\
+  stp        x6, x7, [sp, #48]                           \n\
+  stp        x8, x30, [sp, #64] // x30 here =3D=3D label 2 =3D=3D &func_in=
fo\n\
+  adr        x16, 2f          // x16 =3D &func_info\n\
+  ldr        x17, [x16]       // x17 =3D func_info->dll (=3D dll_info*)\n\
+  ldr        x17, [x17]       // x17 =3D dll_info->load_state (e.g. _std_d=
ll_init)\n\
+  blr        x17              // call thunk; LR =3D label 2 =3D arg to std=
_dll_init\n\
+2:                                                      \n\
+  .xword     ." #dllname "_info // +0  func_info.dll\n\
+  .hword     " #notimp "         // +8  func_info.decoration[lo]\n\
+  .hword     ((" #err ") & 0xffff) // +10 func_info.decoration[hi]\n\
+3:                                                       \n\
+  .xword     1b                // +12 func_info.func_addr (patched by dll_=
func_load)\n\
+  .asciz     \"" #name "\"      // +20 func_info.name (asciz)\n\
+  .text                                                  \n\
+");
 #else
 #error unimplemented for this target
 #endif

+
 /* DLL loader helper functions used during initialization. */

 /* The function which finds the address, given the name and overwrites
@@ -141,7 +181,7 @@ extern "C" void dll_chain () __asm__ ("dll_chain");

 extern "C" {

-#ifdef __x86_64__
+#if defined(__x86_64__)
 __asm__ ("                      \n\
    .section .rdata,\"r\"                    \n\
 msg1:                           \n\
@@ -203,10 +243,65 @@ dll_chain:                      \n\
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
+ noload:                                                 \n\
+  ldr        x2, [sp]          // x2 =3D func_info* (pushed by dll_chain)\=
n\
+  ldr        w3, [x2, #8]      // w3 =3D func_info.decoration\n\
+  tbz        w3, #0, 1f        // notimp bit clear -> fatal\n\
+  asr        w4, w3, #16       // w4 =3D err (sign-extend high half)\n\
+  str        w4, [sp, #8]      // spill into dll_chain's xzr slot\n\
+  mov        w0, #127          // ERROR_PROC_NOT_FOUND\n\
+  bl         SetLastError                                \n\
+  ldr        w0, [sp, #8]      // reload err as return value\n\
+  ldr        x30, [sp, #88]    // restore caller LR (16 + 72)\n\
+  add        sp, sp, #96       // drop dll_chain (16) + trampoline (80) fr=
ames\n\
+  ret                                                    \n\
+1:                                                       \n\
+  add        x1, x2, #20       // x1 =3D &func_info.name\n\
+  ldr        x3, [x2]          // x3 =3D dll_info*\n\
+  ldr        x2, [x3, #8]      // x2 =3D dll_info->handle\n\
+  adrp       x0, msg1                                    \n\
+  add        x0, x0, #:lo12:msg1\n\
+  bl         api_fatal         // never returns          \n\
+                                                         \n\
+  .globl     dll_func_load                               \n\
+dll_func_load:                                           \n\
+  ldr        x2, [sp]          // x2 =3D func_info* (pushed by dll_chain)\=
n\
+  ldr        x3, [x2]          // x3 =3D dll_info*\n\
+  ldr        x0, [x3, #8]      // x0 =3D dll handle (arg1 to GetProcAddres=
s)\n\
+  add        x1, x2, #20       // x1 =3D &func_info.name (arg2)\n\
+  bl         GetProcAddress                              \n\
+  cbz        x0, noload        // 0 -> not found, jump to error path\n\
+  ldr        x2, [sp]          // reload func_info*\n\
+  str        x0, [x2, #12]     // patch func_addr slot (label 3)\n\
+  sub        x16, x2, #52      // x16 =3D trampoline entry; '#52' =3D 12B =
prologue\n\
+                               // + 40B slow path; sync with LoadDLLfuncEx=
3\n\
+  add        sp, sp, #16       // drop dll_chain frame\n\
+  ldp        x0, x1, [sp, #0]  // restore caller's arg regs\n\
+  ldp        x2, x3, [sp, #16]                           \n\
+  ldp        x4, x5, [sp, #32]                           \n\
+  ldp        x6, x7, [sp, #48]                           \n\
+  ldp        x8, x30, [sp, #64]\n\
+  add        sp, sp, #80       // drop trampoline frame\n\
+  br         x16               // re-enter trampoline; fast path now hits =
real func\n\
+                                                         \n\
+  .global    dll_chain                                   \n\
+dll_chain:                                              \n\
+  stp        x0, xzr, [sp, #-16]! // x0 =3D func_info* (=3D ret.high); pus=
h for dll_func_load\n\
+  br         x1                   // x1 =3D dll->init (=3D ret.low); tail-=
call resolver\n\
+");
 #else
 #error unimplemented for this target
 #endif

+
 /* C representations of the two info blocks described above.
    FIXME: These structures confuse gdb for some reason.  GDB can print
    the whole structure but has problems with the name field? */
@@ -260,7 +355,7 @@ dll_load (HANDLE& handle, PWCHAR name)
 #define RETRY_COUNT 10

 /* The standard DLL initialization routine. */
-#ifdef __x86_64__
+#if defined(__x86_64__)

 /* On x86_64, we need assembler wrappers for std_dll_init and wsock_init.
    In the x86_64 ABI it's no safe bet that frame[1] (aka 8(%rbp)) contains
@@ -300,6 +395,26 @@ _" #func ":                      \n\

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
@@ -360,7 +475,7 @@ std_dll_init (struct func_info *func)

 /* Initialization function for winsock stuff. */

-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__aarch64__)
 /* See above comment preceeding std_dll_init. */
 INIT_WRAPPER (wsock_init)
 #else
--
2.49.0.windows.1




--_000_PN0P287MB02951A11C49A1208A9BA66F392102PN0P287MB0295INDP_--

--_004_PN0P287MB02951A11C49A1208A9BA66F392102PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-autoload-Add-AArch64-implementation.patch"
Content-Description: Cygwin-autoload-Add-AArch64-implementation.patch
Content-Disposition: attachment;
	filename="Cygwin-autoload-Add-AArch64-implementation.patch"; size=11653;
	creation-date="Thu, 04 Jun 2026 07:33:43 GMT";
	modification-date="Thu, 04 Jun 2026 07:35:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0NjRhMmMwNWJhMzIxZjAxNDQxMWY3YzBhOWFmMWNiMzY2Y2VlY2I4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IFdlZCwgMTMgTWF5IDIwMjYgMTY6MjE6NTYgKzA1MzAKU3ViamVjdDogW1BB
VENIIHYyXSBDeWd3aW46IGF1dG9sb2FkOiBBZGQgQUFyY2g2NCBpbXBsZW1l
bnRhdGlvbgpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQv
cGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGlu
ZzogOGJpdAoKQWRkIEFBcmNoNjQgYXNzZW1ibHkgaW1wbGVtZW50YXRpb25z
IG9mIExvYWRETExwcmltZSwgTG9hZERMTGZ1bmNFeDMsCmRsbF9mdW5jX2xv
YWQsIGRsbF9jaGFpbiwgYW5kIElOSVRfV1JBUFBFUiwgbWlycm9yaW5nIHRo
ZSBleGlzdGluZwp4ODZfNjQgbGF6eS1sb2FkaW5nIG1lY2hhbmlzbS4gQWxz
byBjb252ZXJ0ICNpZmRlZiBndWFyZHMgdG8KICNpZiBkZWZpbmVkKCkgZm9y
IGNvbnNpc3RlbmN5LgoKU2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8
cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+ClNpZ25lZC1vZmYtYnk6IFRo
aXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5uYWdhbGluZ2FtQG11
bHRpY29yZXdhcmVpbmMuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaGFuZHJ1IEt1
bWFyZXNhbiA8Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5j
b20+Ci0tLQogd2luc3VwL2N5Z3dpbi9hdXRvbG9hZC5jYyB8IDE2MSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDEzOCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2F1dG9sb2FkLmNjIGIvd2luc3Vw
L2N5Z3dpbi9hdXRvbG9hZC5jYwppbmRleCBhMDM4OTk3YjMuLmI5M2ZkZjNk
YyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9hdXRvbG9hZC5jYworKysg
Yi93aW5zdXAvY3lnd2luL2F1dG9sb2FkLmNjCkBAIC02NCwyOCArNjQsMzQg
QEAgYm9vbCBOT19DT1BZIHdzb2NrX3N0YXJ0ZWQ7CiAgKiAgRExMIG5hbWUg
KG4gYnl0ZXMpCSBhc2NpeiBzdHJpbmcgY29udGFpbmluZyB0aGUgbmFtZSBv
ZiB0aGUgRExMLgogICovCiAKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCisj
IGRlZmluZSBXT1JENjQgIi5xdWFkIgorI2VsaWYgZGVmaW5lZChfX2FhcmNo
NjRfXykKKyMgZGVmaW5lIFdPUkQ2NCAiLnh3b3JkIgorI2Vsc2UKKyMgZXJy
b3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKKyNlbmRpZgorCiAv
KiBMb2FkRExMcHJpbWUgaXMgdXNlZCB0byBwcmltZSB0aGUgRExMIGluZm8g
aW5mb3JtYXRpb24sIHByb3ZpZGluZyBhbgogICAgYWRkaXRpb25hbCBpbml0
aWFsaXphdGlvbiByb3V0aW5lIHRvIGNhbGwgcHJpb3IgdG8gY2FsbGluZyB0
aGUgZmlyc3QKLSAgIGZ1bmN0aW9uLiAgKi8KLSNpZmRlZiBfX3g4Nl82NF9f
Ci0jZGVmaW5lIExvYWRETExwcmltZShkbGxuYW1lLCBpbml0X2Fsc28sIG5v
X3Jlc29sdmVfb25fZm9yaykgX19hc21fXyAoIglcblwKLS5pZm5kZWYgIiAj
ZGxsbmFtZSAiX3ByaW1lZAkJCQlcblwKLSAgLnNlY3Rpb24JLmRhdGFfY3ln
d2luX25vY29weSxcIndcIgkJXG5cCi0gIC5hbGlnbgk4CQkJCQlcblwKLS4i
I2RsbG5hbWUgIl9pbmZvOgkJCQkJXG5cCi0gIC5xdWFkCQlfc3RkX2RsbF9p
bml0CQkJCVxuXAotICAucXVhZAkJIiAjbm9fcmVzb2x2ZV9vbl9mb3JrICIJ
CQlcblwKLSAgLmxvbmcJCS0xCQkJCQlcblwKLSAgLmFsaWduCTgJCQkJCVxu
XAotICAucXVhZAkJIiAjaW5pdF9hbHNvICIJCQkJXG5cCi0gIC5zdHJpbmcx
NglcIiIgI2RsbG5hbWUgIi5kbGxcIgkJCVxuXAotICAudGV4dAkJCQkJCQlc
blwKLSAgLnNldAkJIiAjZGxsbmFtZSAiX3ByaW1lZCwgMQkJCVxuXAotLmVu
ZGlmCQkJCQkJCVxuXAorICAgZnVuY3Rpb24uIFdPUkQ2NCBzdGFuZHMgaW4g
Zm9yIC5xdWFkLy54d29yZCwgYW5kIC5iYWxpZ24gKHdoaWNoIG1lYW5zCisg
ICAiYWxpZ24gdG8gTiBieXRlcyIgb24gYm90aCB0YXJnZXRzIC0gIng2NCIg
YW5kICJhcm02NCkgaXMgdXNlZCBmb3IKKyAgIGFsaWdubWVudC4gICovCisj
ZGVmaW5lIExvYWRETExwcmltZShkbGxuYW1lLCBpbml0X2Fsc28sIG5vX3Jl
c29sdmVfb25fZm9yaykgX19hc21fXyAoIlxuXAorLmlmbmRlZiAiICNkbGxu
YW1lICJfcHJpbWVkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5c
CisgIC5zZWN0aW9uICAgLmRhdGFfY3lnd2luX25vY29weSxcIndcIiAgICAg
ICAgICAgICAgICAgICBcblwKKyAgLmJhbGlnbiAgICA4ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorLiIgI2RsbG5h
bWUgIl9pbmZvOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXG5cCisgICIgV09SRDY0ICIgICBfc3RkX2RsbF9pbml0ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcblwKKyAgIiBXT1JENjQgIiAgICIgI25v
X3Jlc29sdmVfb25fZm9yayAiICAgICAgICAgICAgICAgICAgIFxuXAorICAu
bG9uZyAgICAgIC0xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXG5cCisgIC5iYWxpZ24gICAgOCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgIiBXT1JENjQgIiAg
ICIgI2luaXRfYWxzbyAiICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxu
XAorICAuc3RyaW5nMTYgIFwiIiAjZGxsbmFtZSAiLmRsbFwiICAgICAgICAg
ICAgICAgICAgICAgICAgXG5cCisgIC50ZXh0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgLnNldCAg
ICAgICAiICNkbGxuYW1lICJfcHJpbWVkLCAxICAgICAgICAgICAgICAgICAg
ICAgIFxuXAorLmVuZGlmICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXG5cCiAiKTsKLSNlbHNlCi0jZXJyb3Ig
dW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKLSNlbmRpZgogCiAvKiBT
dGFuZGFyZCBETEwgbG9hZCBtYWNyby4gIE1heSBpbnZva2UgYSBmYXRhbCBl
cnJvciBpZiB0aGUgZnVuY3Rpb24gaXNuJ3QKICAgIGZvdW5kLiAqLwpAQCAt
OTcsNyArMTAzLDcgQEAgYm9vbCBOT19DT1BZIHdzb2NrX3N0YXJ0ZWQ7CiAg
IExvYWRETExmdW5jRXgzKG5hbWUsIGRsbG5hbWUsIG5vdGltcCwgZXJyLCAw
KQogCiAvKiBNYWluIERMTCBzZXR1cCBzdHVmZi4gKi8KLSNpZmRlZiBfX3g4
Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogI2RlZmluZSBMb2Fk
RExMZnVuY0V4MyhuYW1lLCBkbGxuYW1lLCBub3RpbXAsIGVyciwgbm9fcmVz
b2x2ZV9vbl9mb3JrKSBcCiAgIExvYWRETExwcmltZSAoZGxsbmFtZSwgZGxs
X2Z1bmNfbG9hZCwgbm9fcmVzb2x2ZV9vbl9mb3JrKSBcCiAgIF9fYXNtX18g
KCIJCQkJCQlcblwKQEAgLTEyMywxMCArMTI5LDQ0IEBAIF93aW4zMl8iICNu
YW1lICI6CQkJCQlcblwKICAgLmFzY2l6CVwiIiAjbmFtZSAiXCIJCQkJXG5c
CiAgIC50ZXh0CQkJCQkJCVxuXAogIik7CisjZWxpZiBkZWZpbmVkKF9fYWFy
Y2g2NF9fKQorI2RlZmluZSBMb2FkRExMZnVuY0V4MyhuYW1lLCBkbGxuYW1l
LCBub3RpbXAsIGVyciwgbm9fcmVzb2x2ZV9vbl9mb3JrKSBcCisgIExvYWRE
TExwcmltZSAoZGxsbmFtZSwgZGxsX2Z1bmNfbG9hZCwgbm9fcmVzb2x2ZV9v
bl9mb3JrKSBcCisgIF9fYXNtX18gKCAiXG5cCisgIC5zZWN0aW9uICAgLiIg
I2RsbG5hbWUgIl9hdXRvbG9hZF90ZXh0LFwid3hcIiAgICAgICAgICBcblwK
KyAgLmdsb2JhbCAgICAiICNuYW1lICIgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFxuXAorICAuZ2xvYmFsICAgIF93aW4zMl8iICNuYW1l
ICIgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIC5wMmFsaWdu
ICAgNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcblwKKyIgI25hbWUgIjogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFxuXAorX3dpbjMyXyIgI25hbWUgIjogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgYWRy
ICAgICAgICB4MTYsIDNmICAgICAgICAgIC8vIHgxNiA9ICZmdW5jX2FkZHIg
c2xvdCAobGFiZWwgMyA9PSBmdW5jX2luZm8rMTIpXG5cCisgIGxkciAgICAg
ICAgeDE2LCBbeDE2XSAgICAgICAvLyB4MTYgPSAqKCZmdW5jX2FkZHIpID0g
MWIgZmlyc3QgdGltZSwgcmVhbCBhZGRyIGxhdGVyXG5cCisgIGJyICAgICAg
ICAgeDE2ICAgICAgICAgICAgICAvLyBmYXN0LXBhdGggYnJhbmNoIGludG8g
dGhlIHJlc29sdmVkIERMTCBmdW5jXG5cCisxOiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBz
dWIgICAgICAgIHNwLCBzcCwgIzgwICAgICAgLy8gcmVzZXJ2ZSA4MEIgZnJh
bWUgZm9yIGNhbGxlcidzIGFyZyByZWdzICsgTFJcblwKKyAgc3RwICAgICAg
ICB4MCwgeDEsIFtzcCwgIzBdICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFxuXAorICBzdHAgICAgICAgIHgyLCB4MywgW3NwLCAjMTZdICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXG5cCisgIHN0cCAgICAgICAgeDQsIHg1LCBb
c3AsICMzMl0gICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgc3Rw
ICAgICAgICB4NiwgeDcsIFtzcCwgIzQ4XSAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFxuXAorICBzdHAgICAgICAgIHg4LCB4MzAsIFtzcCwgIzY0XSAv
LyB4MzAgaGVyZSA9PSBsYWJlbCAyID09ICZmdW5jX2luZm9cblwKKyAgYWRy
ICAgICAgICB4MTYsIDJmICAgICAgICAgIC8vIHgxNiA9ICZmdW5jX2luZm9c
blwKKyAgbGRyICAgICAgICB4MTcsIFt4MTZdICAgICAgIC8vIHgxNyA9IGZ1
bmNfaW5mby0+ZGxsICg9IGRsbF9pbmZvKilcblwKKyAgbGRyICAgICAgICB4
MTcsIFt4MTddICAgICAgIC8vIHgxNyA9IGRsbF9pbmZvLT5sb2FkX3N0YXRl
IChlLmcuIF9zdGRfZGxsX2luaXQpXG5cCisgIGJsciAgICAgICAgeDE3ICAg
ICAgICAgICAgICAvLyBjYWxsIHRodW5rOyBMUiA9IGxhYmVsIDIgPSBhcmcg
dG8gc3RkX2RsbF9pbml0XG5cCisyOiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICAueHdvcmQg
ICAgIC4iICNkbGxuYW1lICJfaW5mbyAvLyArMCAgZnVuY19pbmZvLmRsbFxu
XAorICAuaHdvcmQgICAgICIgI25vdGltcCAiICAgICAgICAgLy8gKzggIGZ1
bmNfaW5mby5kZWNvcmF0aW9uW2xvXVxuXAorICAuaHdvcmQgICAgICgoIiAj
ZXJyICIpICYgMHhmZmZmKSAvLyArMTAgZnVuY19pbmZvLmRlY29yYXRpb25b
aGldXG5cCiszOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcblwKKyAgLnh3b3JkICAgICAxYiAgICAg
ICAgICAgICAgICAvLyArMTIgZnVuY19pbmZvLmZ1bmNfYWRkciAocGF0Y2hl
ZCBieSBkbGxfZnVuY19sb2FkKVxuXAorICAuYXNjaXogICAgIFwiIiAjbmFt
ZSAiXCIgICAgICAvLyArMjAgZnVuY19pbmZvLm5hbWUgKGFzY2l6KVxuXAor
ICAudGV4dCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXG5cCisiKTsKICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1l
bnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgogCisKIC8qIERMTCBsb2Fk
ZXIgaGVscGVyIGZ1bmN0aW9ucyB1c2VkIGR1cmluZyBpbml0aWFsaXphdGlv
bi4gKi8KIAogLyogVGhlIGZ1bmN0aW9uIHdoaWNoIGZpbmRzIHRoZSBhZGRy
ZXNzLCBnaXZlbiB0aGUgbmFtZSBhbmQgb3ZlcndyaXRlcwpAQCAtMTQxLDcg
KzE4MSw3IEBAIGV4dGVybiAiQyIgdm9pZCBkbGxfY2hhaW4gKCkgX19hc21f
XyAoImRsbF9jaGFpbiIpOwogCiBleHRlcm4gIkMiIHsKIAotI2lmZGVmIF9f
eDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiBfX2FzbV9fICgi
CQkJCQkJCQlcblwKIAkgLnNlY3Rpb24gLnJkYXRhLFwiclwiCQkJCQkJCVxu
XAogbXNnMToJCQkJCQkJCQlcblwKQEAgLTIwMywxMCArMjQzLDY1IEBAIGRs
bF9jaGFpbjoJCQkJCQkJCVxuXAogCXB1c2gJJXJheAkJIyBSZXN0b3JlICdy
ZXR1cm4gYWRkcmVzcycJCVxuXAogCWptcAkqJXJkeAkJIyBKdW1wIHRvIG5l
eHQgaW5pdCBmdW5jdGlvbgkJXG5cCiAiKTsKKyNlbGlmIGRlZmluZWQoX19h
YXJjaDY0X18pCitfX2FzbV9fICggIlxuXAorICAuc2VjdGlvbiAucmRhdGEs
XCJyXCIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCitt
c2cxOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcblwKKyAgLmFzY2lpIFwiY291bGRuJ3QgZHluYW1pY2Fs
bHkgZGV0ZXJtaW5lIGxvYWQgYWRkcmVzcyBmb3IgJyVzJyAoaGFuZGxlICVw
KSwgJUVcXDBcIiBcblwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICAudGV4dCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XG5cCisgIC5wMmFsaWduIDIgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcblwKKyBub2xvYWQ6ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBsZHIg
ICAgICAgIHgyLCBbc3BdICAgICAgICAgIC8vIHgyID0gZnVuY19pbmZvKiAo
cHVzaGVkIGJ5IGRsbF9jaGFpbilcblwKKyAgbGRyICAgICAgICB3MywgW3gy
LCAjOF0gICAgICAvLyB3MyA9IGZ1bmNfaW5mby5kZWNvcmF0aW9uXG5cCisg
IHRieiAgICAgICAgdzMsICMwLCAxZiAgICAgICAgLy8gbm90aW1wIGJpdCBj
bGVhciAtPiBmYXRhbFxuXAorICBhc3IgICAgICAgIHc0LCB3MywgIzE2ICAg
ICAgIC8vIHc0ID0gZXJyIChzaWduLWV4dGVuZCBoaWdoIGhhbGYpXG5cCisg
IHN0ciAgICAgICAgdzQsIFtzcCwgIzhdICAgICAgLy8gc3BpbGwgaW50byBk
bGxfY2hhaW4ncyB4enIgc2xvdFxuXAorICBtb3YgICAgICAgIHcwLCAjMTI3
ICAgICAgICAgIC8vIEVSUk9SX1BST0NfTk9UX0ZPVU5EXG5cCisgIGJsICAg
ICAgICAgU2V0TGFzdEVycm9yICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcblwKKyAgbGRyICAgICAgICB3MCwgW3NwLCAjOF0gICAgICAvLyBy
ZWxvYWQgZXJyIGFzIHJldHVybiB2YWx1ZVxuXAorICBsZHIgICAgICAgIHgz
MCwgW3NwLCAjODhdICAgIC8vIHJlc3RvcmUgY2FsbGVyIExSICgxNiArIDcy
KVxuXAorICBhZGQgICAgICAgIHNwLCBzcCwgIzk2ICAgICAgIC8vIGRyb3Ag
ZGxsX2NoYWluICgxNikgKyB0cmFtcG9saW5lICg4MCkgZnJhbWVzXG5cCisg
IHJldCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcblwKKzE6ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBhZGQgICAgICAg
IHgxLCB4MiwgIzIwICAgICAgIC8vIHgxID0gJmZ1bmNfaW5mby5uYW1lXG5c
CisgIGxkciAgICAgICAgeDMsIFt4Ml0gICAgICAgICAgLy8geDMgPSBkbGxf
aW5mbypcblwKKyAgbGRyICAgICAgICB4MiwgW3gzLCAjOF0gICAgICAvLyB4
MiA9IGRsbF9pbmZvLT5oYW5kbGVcblwKKyAgYWRycCAgICAgICB4MCwgbXNn
MSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBh
ZGQgICAgICAgIHgwLCB4MCwgIzpsbzEyOm1zZzFcblwKKyAgYmwgICAgICAg
ICBhcGlfZmF0YWwgICAgICAgICAvLyBuZXZlciByZXR1cm5zICAgICAgICAg
IFxuXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXG5cCisgIC5nbG9ibCAgICAgZGxsX2Z1bmNf
bG9hZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKK2RsbF9m
dW5jX2xvYWQ6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFxuXAorICBsZHIgICAgICAgIHgyLCBbc3BdICAgICAgICAgIC8v
IHgyID0gZnVuY19pbmZvKiAocHVzaGVkIGJ5IGRsbF9jaGFpbilcblwKKyAg
bGRyICAgICAgICB4MywgW3gyXSAgICAgICAgICAvLyB4MyA9IGRsbF9pbmZv
KlxuXAorICBsZHIgICAgICAgIHgwLCBbeDMsICM4XSAgICAgIC8vIHgwID0g
ZGxsIGhhbmRsZSAoYXJnMSB0byBHZXRQcm9jQWRkcmVzcylcblwKKyAgYWRk
ICAgICAgICB4MSwgeDIsICMyMCAgICAgICAvLyB4MSA9ICZmdW5jX2luZm8u
bmFtZSAoYXJnMilcblwKKyAgYmwgICAgICAgICBHZXRQcm9jQWRkcmVzcyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBjYnogICAgICAg
IHgwLCBub2xvYWQgICAgICAgIC8vIDAgLT4gbm90IGZvdW5kLCBqdW1wIHRv
IGVycm9yIHBhdGhcblwKKyAgbGRyICAgICAgICB4MiwgW3NwXSAgICAgICAg
ICAvLyByZWxvYWQgZnVuY19pbmZvKlxuXAorICBzdHIgICAgICAgIHgwLCBb
eDIsICMxMl0gICAgIC8vIHBhdGNoIGZ1bmNfYWRkciBzbG90IChsYWJlbCAz
KVxuXAorICBzdWIgICAgICAgIHgxNiwgeDIsICM1MiAgICAgIC8vIHgxNiA9
IHRyYW1wb2xpbmUgZW50cnk7ICcjNTInID0gMTJCIHByb2xvZ3VlXG5cCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gKyA0MEIgc2xvdyBw
YXRoOyBzeW5jIHdpdGggTG9hZERMTGZ1bmNFeDNcblwKKyAgYWRkICAgICAg
ICBzcCwgc3AsICMxNiAgICAgICAvLyBkcm9wIGRsbF9jaGFpbiBmcmFtZVxu
XAorICBsZHAgICAgICAgIHgwLCB4MSwgW3NwLCAjMF0gIC8vIHJlc3RvcmUg
Y2FsbGVyJ3MgYXJnIHJlZ3NcblwKKyAgbGRwICAgICAgICB4MiwgeDMsIFtz
cCwgIzE2XSAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBsZHAg
ICAgICAgIHg0LCB4NSwgW3NwLCAjMzJdICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXG5cCisgIGxkcCAgICAgICAgeDYsIHg3LCBbc3AsICM0OF0gICAg
ICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgbGRwICAgICAgICB4OCwg
eDMwLCBbc3AsICM2NF1cblwKKyAgYWRkICAgICAgICBzcCwgc3AsICM4MCAg
ICAgICAvLyBkcm9wIHRyYW1wb2xpbmUgZnJhbWVcblwKKyAgYnIgICAgICAg
ICB4MTYgICAgICAgICAgICAgICAvLyByZS1lbnRlciB0cmFtcG9saW5lOyBm
YXN0IHBhdGggbm93IGhpdHMgcmVhbCBmdW5jXG5cCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
blwKKyAgLmdsb2JhbCAgICBkbGxfY2hhaW4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFxuXAorZGxsX2NoYWluOiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAgc3RwICAg
ICAgICB4MCwgeHpyLCBbc3AsICMtMTZdISAvLyB4MCA9IGZ1bmNfaW5mbyog
KD0gcmV0LmhpZ2gpOyBwdXNoIGZvciBkbGxfZnVuY19sb2FkXG5cCisgIGJy
ICAgICAgICAgeDEgICAgICAgICAgICAgICAgICAgLy8geDEgPSBkbGwtPmlu
aXQgKD0gcmV0Lmxvdyk7IHRhaWwtY2FsbCByZXNvbHZlclxuXAorIik7CiAj
ZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CiAj
ZW5kaWYKIAorCiAvKiBDIHJlcHJlc2VudGF0aW9ucyBvZiB0aGUgdHdvIGlu
Zm8gYmxvY2tzIGRlc2NyaWJlZCBhYm92ZS4KICAgIEZJWE1FOiBUaGVzZSBz
dHJ1Y3R1cmVzIGNvbmZ1c2UgZ2RiIGZvciBzb21lIHJlYXNvbi4gIEdEQiBj
YW4gcHJpbnQKICAgIHRoZSB3aG9sZSBzdHJ1Y3R1cmUgYnV0IGhhcyBwcm9i
bGVtcyB3aXRoIHRoZSBuYW1lIGZpZWxkPyAqLwpAQCAtMjYwLDcgKzM1NSw3
IEBAIGRsbF9sb2FkIChIQU5ETEUmIGhhbmRsZSwgUFdDSEFSIG5hbWUpCiAj
ZGVmaW5lIFJFVFJZX0NPVU5UIDEwCiAKIC8qIFRoZSBzdGFuZGFyZCBETEwg
aW5pdGlhbGl6YXRpb24gcm91dGluZS4gKi8KLSNpZmRlZiBfX3g4Nl82NF9f
CisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogCiAvKiBPbiB4ODZfNjQsIHdl
IG5lZWQgYXNzZW1ibGVyIHdyYXBwZXJzIGZvciBzdGRfZGxsX2luaXQgYW5k
IHdzb2NrX2luaXQuCiAgICBJbiB0aGUgeDg2XzY0IEFCSSBpdCdzIG5vIHNh
ZmUgYmV0IHRoYXQgZnJhbWVbMV0gKGFrYSA4KCVyYnApKSBjb250YWlucwpA
QCAtMzAwLDYgKzM5NSwyNiBAQCBfIiAjZnVuYyAiOgkJCQkJCQkJXG5cCiAK
IElOSVRfV1JBUFBFUiAoc3RkX2RsbF9pbml0KQogCisjZWxpZiBkZWZpbmVk
KF9fYWFyY2g2NF9fKQorI2RlZmluZSBJTklUX1dSQVBQRVIoZnVuYykgX19h
c21fXyAoICJcblwKKyAgLnRleHQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICAucDJhbGlnbiAyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5c
CisgIC5zZWhfcHJvYyBfIiAjZnVuYyAiICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcblwKK18iICNmdW5jICI6ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICBzdHAgICAg
ICAgIHgyOSwgeDMwLCBbc3AsICMtMTZdISAgICAgICAgICAgICAgICAgICAg
ICAgIFxuXAorICAuc2VoX3NhdmVfZnBscl94IDE2ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXG5cCisgIC5zZWhfZW5kcHJvbG9ndWUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKKyAg
bW92ICAgICAgICB4MCwgeDMwICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFxuXAorICBibCAgICAgICAgICIgI2Z1bmMgIiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIGxkcCAgICAgICAg
eDI5LCB4enIsIFtzcF0sICMxNiAgICAgICAgICAgICAgICAgICAgICAgICAg
XG5cCisgIGFkcnAgICAgICAgeDMwLCBkbGxfY2hhaW4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcblwKKyAgYWRkICAgICAgICB4MzAsIHgzMCwg
IzpsbzEyOmRsbF9jaGFpbiAgICAgICAgICAgICAgICAgIFxuXAorICByZXQg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcblwKKyAgLnNlaF9lbmRwcm9jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFxuXAorIik7CisKK0lOSVRfV1JBUFBF
UiAoc3RkX2RsbF9pbml0KQorCiAjZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50
ZWQgZm9yIHRoaXMgdGFyZ2V0CiAjZW5kaWYKQEAgLTM2MCw3ICs0NzUsNyBA
QCBzdGRfZGxsX2luaXQgKHN0cnVjdCBmdW5jX2luZm8gKmZ1bmMpCiAKIC8q
IEluaXRpYWxpemF0aW9uIGZ1bmN0aW9uIGZvciB3aW5zb2NrIHN0dWZmLiAq
LwogCi0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRf
XykgfHwgZGVmaW5lZChfX2FhcmNoNjRfXykKIC8qIFNlZSBhYm92ZSBjb21t
ZW50IHByZWNlZWRpbmcgc3RkX2RsbF9pbml0LiAqLwogSU5JVF9XUkFQUEVS
ICh3c29ja19pbml0KQogI2Vsc2UKLS0gCjIuNDkuMC53aW5kb3dzLjEKCg==

--_004_PN0P287MB02951A11C49A1208A9BA66F392102PN0P287MB0295INDP_--
