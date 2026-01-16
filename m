Return-Path: <SRS0=c1qK=7V=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 2921C4BA2E25
	for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 18:00:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2921C4BA2E25
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2921C4BA2E25
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1768586414; cv=pass;
	b=s2B10/ruOHR/8az7ya0iwYLHhs41khKFAZLK8EeccSMVTDV7oHMjv1Il7z3raLzjABJcZEVX+tmHrgqgg7LF/k8PqADmez0oFa+CrNzNo5f4dcxikHYD8zrEtMyJ+s99uFQJKpevZ/FWXucgTJccu41MN8w4RELV+zoCoUO0G2U=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768586414; c=relaxed/simple;
	bh=ARb65Nh1ePHKgqiY3CESLvfieEXDUx+6M5s33CpTQe8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=gBWlv2C9219+N5GYbskqE1IWSUCGzEbaoWJvhfL1AIYr/JER6s8JsUgehjo6m+nvHAsh8CJIFZjmbkOOp8dD3iI1cd/CgwXfYjhA5L11UvFiQAFMKEdhT1tuOyr7u0oWzRNHGQ4RnFvDk8vJjdE05zTWY0ZZWtu+KtPRAau8bbA=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2921C4BA2E25
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=k6NG3+sB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JX5IqpzoaGs/xyGUdtuuvtB2+B8/gC06m0cz5sNTWae6V5oe5MeztnUB33URX3FGcsktTYkXtClPNrLWEy9nJvelPrQ+up8l305zLUbZjUhbwjobfBo9YCw3wib698FaOZnAa7JHY348GEP+DvA4pDyPldWfP6baHpG0f1elEksgZkAcoKPqjG5PnSDbXEUUPaIkvnQGy6qL+AiXljPzyWc+jb3msIQkQ4ZBMOFp7gh7U14UutDNP23LHLzMV9ABQirej5tFOZZpO+ZTW+rOUoJFTIBp59t/fsOwbxb67ANxws+JxC7IuNPCIpzU1RrkHYfyP5N8JSpbYtEUecAIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTJ97Kclyv+WtFqgsTqN/ipQkEgM6v4Z2kU0t4pdL1Q=;
 b=M2CkKo5wi24FGO8O718H6DGk62c/eMDsTzQNutJEiYRYFeDcwrlM3Hbfv1Dhc43eHmEH63HfIrhPUr5x3PQZcxmZblHwmJ/MNxL1DgQWd+GfU2KNvqCf4Qc1J6uqxVRPyT4viJVdA5yn/ahX7yJIdSoj9dPujKWr6Zn7sIxmzJig4E4w63CAvbRtVtv3Mc/rWg+WR7wZ/xmmTYfQ0mbCIDXw/s4ZS2ULclfOM1CcCIB2C1uLMRE1t670JsqcwR0BHiHPG9UCVAkT//gRtqacX9mc8zV0y7NaHWpnwFsAxmcdzibC/6j6sfh0HSj/r8fYODT1T8em/7X/EaIUSnscFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTJ97Kclyv+WtFqgsTqN/ipQkEgM6v4Z2kU0t4pdL1Q=;
 b=k6NG3+sBurc631U0whI5AZ5KbjxB/t/L7c3za/6d6g0EyAKbvhLTVhWCO4i6B/jhWu8hih6uGIF3oXoP8wn+4elRG9wlHp0cl/a+66tLLpEWGUpWKbLR8O9RcCg7NMIgy1Dn4f/IyGmPXmdfyWfjL9TWMa1e5QigLm8TNtJbJCFwQRe7rK5J+ThCA3TnpWWZpYJ1c0eMROLTcyHvAhgXFxsEy7xI21Of0eh6xxuQ80GwesFQED78xrdxf9TOb+DzMIs5bRkZM9EF8EV5g1OQmHX9eFYuHJhwbayFbzpeigee3/+cIOzB+jiTPxbKp0HBD3NYsMU8NRpNDyQc+Fih5w==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MAUP287MB4896.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.5; Fri, 16 Jan
 2026 18:00:07 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%3]) with mapi id 15.20.9542.003; Fri, 16 Jan 2026
 18:00:07 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH V2] Cygwin: gendef: Implement _sigbe function for TLS stack
 management on AArch64
Thread-Topic: [PATCH V2] Cygwin: gendef: Implement _sigbe function for TLS
 stack management on AArch64
Thread-Index: AQHchw3h0HmEqSZiG0+ANTxVoSykAA==
Date: Fri, 16 Jan 2026 18:00:00 +0000
Message-ID:
 <MA0P287MB3082EC66F6E990DA42AC2A9D9F8DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB308261C0D8BCD6FD5842A5039FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB308261C0D8BCD6FD5842A5039FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MAUP287MB4896:EE_
x-ms-office365-filtering-correlation-id: eca9a617-570b-42da-b6e7-08de5529158a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|4053099003|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rAggSqh6BfiMYzKUg+umuAICFPjRBpcf5ja3mraBnIIye3qYLPPHzd2EPumZ?=
 =?us-ascii?Q?Vjv7YxG++qM2CBZ5kO0Nh7Wj9sBnvKwWL3ys9NwLtHzr336D6p1OK24ypK6T?=
 =?us-ascii?Q?ZFhgl+mKG/acPKCt+FeO4A14LOTpV+6OIXO4h6nsNDfmH3TufK4qFPE0Jmwf?=
 =?us-ascii?Q?myaJ2XCbMBLNguUr0rqN0jclzCGXLekG8kKqyt1M6WXTKOEMdIBYUDxU6jrZ?=
 =?us-ascii?Q?kzSC1qoeXYZ599ZzTq/jpJTBI9m8LaNjNGjiCg8UY6CILoZ3Rs78r50R+DwO?=
 =?us-ascii?Q?GPa19gTJr60qnf6WzWqd1qF4IVPRMTd6DHrZdlHWr2++8jfPxNhsqRiF0SMt?=
 =?us-ascii?Q?9/c840mGl1Po/ecwuMN/3/wfiHfRtHK4nu3TZs2zk/ZLprl8lC4tVfVWOmug?=
 =?us-ascii?Q?xiS54525bQW+hFyBw0/pKj91xiG1kBEgmr/dUGN2q7g2Nyv0i4K6fWi0IxAa?=
 =?us-ascii?Q?ukJWzMMbCNIXRDMCfSmyCVUhsAomxKy6dHyrZ3eKWk3g/eURKmnJYeMOdNbg?=
 =?us-ascii?Q?vF13XqRlPkYJ1vB7PLEfK2iVC5BjND410Sifu2cXPWKp+o+qdRE2zMDYoVp8?=
 =?us-ascii?Q?8Y0gUVmEjtDlNINRtLgX4tSnnXXRkEeC593ScfmdifUqQ+HhPYbcjv8T8Zmv?=
 =?us-ascii?Q?kwV4Lit4KWZx2Kj9a3idKW+k0p4hFRbIGVlGgYjzd9NUDeE/udnu8NZ0rfDn?=
 =?us-ascii?Q?9Eg+vAuTM64MFJI6/5T7gEuwnfctWEukXGRb/6ubm9wurjo7nSlb94qUlG25?=
 =?us-ascii?Q?cNPWE6EPcCsvT98tNkYxLcIE7uE98kU2PMLSAB+4lyOG3PqAa9/VGkL+C95c?=
 =?us-ascii?Q?asyVA0WvN6FiS1wCm+o/7O5tEypgq9YaQGYOJG4JHOHHfsr99ZRzrG58KY9x?=
 =?us-ascii?Q?UjM2/iYHWrmcJ2JEMgYRP2Nv2yfbDOSjmTbnNvQhvvc/eFzCT8jvQYRJ7zTQ?=
 =?us-ascii?Q?2FC1ZfoBGLT7x6dtqwNzr7TydEpXIFqyLyeeld6WJc7Ss6QlGE83AFiKorb4?=
 =?us-ascii?Q?0PPd2+ER47WfMcvPmUhOIaC58LvrvQRJKkeeHWZGaCyNboWjBahN6KXo4Ytl?=
 =?us-ascii?Q?r5VxJg9do5sP8dNXCkvT/OOHn2yqHRjfqB100GRJU4s7SC6nGTgNFIdCOpSG?=
 =?us-ascii?Q?zlcy7tycpCKWGk2ohYu53BjFG/PT8zy6ASmIpC9Ht12kDipnN9J7Xecfdn6M?=
 =?us-ascii?Q?jDLlfvB8lVMh1qHj4H+mH4ENvUm7J33jOdYlG7elxYBP2/E7TJraJOD4cBN7?=
 =?us-ascii?Q?OIdvzGzYeQe7Iw6BdpOp1f6jHNvolWYTiVkEcEV4/Na3eBCP0Wjj7gbBWVfa?=
 =?us-ascii?Q?cAqm0Ase6MTd4ngK2b62/M4B5SFmE4v1g64E5K8wuTTAY2Db948xTkIVzZEf?=
 =?us-ascii?Q?upSL/vAoz2ok9+VhZDtKgIp9J2W1lgZXPJ79H0SXQQRu6lppZeBrv0NEQu/0?=
 =?us-ascii?Q?SQe5LjJu/Aa69Vu2hUYgrhuQyE+vV2pzwDuoZt59cWHex/NjWS+NQM270gDL?=
 =?us-ascii?Q?oaUAMjvwk7KBorbaVIGLIUFiL7AomKgZZnp3B768xbD4r1HU6TP6DIXDz/+L?=
 =?us-ascii?Q?VYozN6EsnjLxU6EI+fAd1Wf2UwVFUxDRtPQ94vJ1yh1KvEledH3xZA6Nmkjb?=
 =?us-ascii?Q?mXF2pFGqfDI3VAsjX038vn8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(4053099003)(38070700021)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KjcHqFrPny8V7sAgvrBvImeJEIfgb9d7UFX6dm+VW6pbktFCNATg3jOrdnx3?=
 =?us-ascii?Q?KgXaGYjSi9NaTj7PTmUTyhWWQMPZ8FA/jAgeNydZbYSbdY9kmtgIrT4CXpg9?=
 =?us-ascii?Q?jlJPmPeXXxjZSNVNbzGhw/cbfkwHhBJLUPhq3Su/NbFock9/Md0AAn7zNSC/?=
 =?us-ascii?Q?5caM/Xpe0Wk2UfFfI+uVymIMpmeJQBnv+XqQCZjs8I6wDbMd2IHcE+kbM7yN?=
 =?us-ascii?Q?LjbVvzLysSiITvETHHAWmf3bb474bj5o0yUr7LynYNFvrORe8ZZ70FHDBK+P?=
 =?us-ascii?Q?IlGq3v4vSiq/+pE1forEumVEGmlnBfCPr//nXHCXwzcqinzKV8bYB2vHakdl?=
 =?us-ascii?Q?2hjk4N4Y6mI5dmBmS/SNWfSVDSbD6V/ipJZsNqtKaUIBUFNWmfabZEjpqhzF?=
 =?us-ascii?Q?TMyZJTn8xJCLVxnA06JrJfgNaQ8z9iD2uugjNB0heoBApfNRZqfHOrI30EKl?=
 =?us-ascii?Q?nusBo5UARBZSeQwPTcaYnt9G3m2rSy3vm9JXt/4Dh547WC4p5bgd2ylhq3li?=
 =?us-ascii?Q?QTJP5sF7cispJPP+XgI3ijw/DTbIqop1Nfh+Mt594ibYra9sO6KYSlb8SLmO?=
 =?us-ascii?Q?EIcBshHr73MJUUFGqU6A960HZSpPxZgqvFkzMEc+1NM/g96Z2p4txG3vLPy9?=
 =?us-ascii?Q?iYnCPs+R26mBU5zEuzTZ2LO7OWmqDp/LO2axVya5xzJuJIr3AezjBS8XnAB7?=
 =?us-ascii?Q?sN76BaYBL4iQpgnqr1EVKOngFkLSSwZ4eQcjpuhTzde4Lcu1foULK6oSAEgv?=
 =?us-ascii?Q?QtDa2NB3OEf+VvYGGmbw9bDgTYsV7UNHqR5QWmdEZSCvsQeArK1NtvNfTSAD?=
 =?us-ascii?Q?6/+8CSQeIzTt5x+nc68GyOvVgqrJUygI65+k0if2t7L6HQeaVI64Sc/OfJ9r?=
 =?us-ascii?Q?p57XCc4rN8Im3II5EbICvVMR72B187eIG2nO5FPG9GoK+rjiRUhAkGRViiIX?=
 =?us-ascii?Q?aVFpKpRsXwHGm4FLFrmj94OCOIkUSZT5WhIhLUywoqGZmb5J3/gBGhdsbCuK?=
 =?us-ascii?Q?38YLF+KWhAA2mlIK4IPQaHlJdHHsaHzrYPpQ5P50AHi5xDC7JDNWYITa1DC0?=
 =?us-ascii?Q?zIfetytGB3yJVlB2D4/7XAVDgSMyzIxIGsmD6MhPehDxa/Jde8rvighMa/aI?=
 =?us-ascii?Q?aWEZlhrq2wJBvthSUMCiRVWY60FIpr6jnjkV/zO1YIpsndJ5MlgGVwujKVjt?=
 =?us-ascii?Q?d0iZR78FePSOrCNEqyaB3NtR9y2vukXEZ6HtoZ9JplZjCbSdvRKRKqZGO3Fq?=
 =?us-ascii?Q?2Ub2m5jrUhWtMZ2nqzOt8YVs+tfg4+b9x4nWvhCUIsKUz8fVPQwcfhKboeKF?=
 =?us-ascii?Q?wH0Sr2NYy7aSV08MOtbHsuCTsSddVTz6oLoa+iZNnU1GTp6tDP/LIJocX9WZ?=
 =?us-ascii?Q?LqrSysM1BYV5BCkq/RJuXYtFc7mKsmIkbVH3T3eAsIQ7j2U611nwv9jv3HaM?=
 =?us-ascii?Q?PT4qvwdCPLLQTIW00NjT16NhVOex3nHy0Y1v9UxRKXeB1vr+W+FQNVmqDPv/?=
 =?us-ascii?Q?fCdL0stbX2TBV+Pr/+QCSu2lPslkpWLIqbyvk5WC4wFTCX170RkRr5CfuiDs?=
 =?us-ascii?Q?b9kwQzvj7PMp18D1mrIkkcMNiWHxXg/VExXJQC2SAI6gzY34+8eurlR/oyx+?=
 =?us-ascii?Q?ZTa+cXYlGqqSx26DSutrAS1OQwg74zR+fx3nyxlfvjcElV5+MuZ0XDhno7oy?=
 =?us-ascii?Q?Jk9LEa2P5p4bS0hGNfdHFYRT1NHpZ2v5j0Fl5KZ81f9/x/EOvm+xAIGSUsgj?=
 =?us-ascii?Q?XZrl6bVmZAHrGMAixZFdroPC+OmY9TzcJeYqTDDFMzDAQOvPwKef0uDZJTso?=
x-ms-exchange-antispam-messagedata-1:
 wzfscxSsWnctg1xvT5CfgvxrsNWLquZTgPiUHi8PcIXxPQFJ07nUAolSBm3WTDBrQ5zsP2/gQFnQKw==
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082EC66F6E990DA42AC2A9D9F8DAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eca9a617-570b-42da-b6e7-08de5529158a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 18:00:07.6560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tE3IN5n+FLiJ2AZ5rw2ZWHcg6p7e6s7RIPi/00RqmJICDZg6Ys2bo0xHSZwcYS2GcNP8+8T7CjS2c3tGyXXEbRgRVYovI+SyTlNW/21QD/4xG0tmQenzG5pknpz2/k4MBul5SPH9QJOVxbnxP7+L2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUP287MB4896
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082EC66F6E990DA42AC2A9D9F8DAMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082EC66F6E990DA42AC2A9D9F8DAMA0P287MB3082INDP_"

--_000_MA0P287MB3082EC66F6E990DA42AC2A9D9F8DAMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

No additional changes in this version.
This V2 patch was regenerated on top of `cygwin/main` and applies cleanly a=
s-is, without any additional dependencies.

Thanks,
Thirumalai Nagalingam

In-lined patch:

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index ab57739fa..adb3ed217 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -423,7 +423,43 @@ _sigfe:
     br      x9                                                          //=
 Branch to real function
     .seh_endproc
+    .global _sigbe
+    .seh_proc _sigbe
_sigbe:
+    .seh_endprologue
+    ldr     x10, [x18, #0x8]                         // Load TLS base into=
 x10
+    mov     w9, #1                                          // Constant va=
lue 1 for lock acquisition
+3:  ldr     x11, =3D_cygtls.stacklock      // Load offset of stacklock
+    add     x12, x10, x11                             // Compute final add=
ress of stacklock
+    ldaxr   w13, [x12]                                  // Load current st=
acklock value atomically
+    stlxr   w14, w9, [x12]                          // Attempt to set stac=
klock atomically
+    cbnz    w14, 3b                                       // Retry if fail=
ed
+    cbz     w13, 4f                                          // If lock wa=
s free, continue
+    yield
+    b       3b                                                        // R=
etry acquiring the lock
+4:
+    mov     x9, #-8                                          // Set stack =
pointer decrement value
+5:  ldr     x11, =3D_cygtls.stackptr         // Load offset of stack point=
er
+    add     x12, x10, x11                             // Compute final add=
ress of stack pointer
+    ldaxr   x13, [x12]                                    // Load current =
stack pointer atomically
+    add     x14, x13, x9                                // Compute new sta=
ck pointer value
+    stlxr   w15, x14, [x12]                         // Attempt to update s=
tack pointer atomically
+    cbnz    w15, 5b                                       // Retry if atom=
ic update failed
+    sub     x13, x13, #8               // Compute address where LR was sav=
ed
+    ldr     x30, [x13]                 // Restore saved LR
+    ldr     x11, =3D_cygtls.incyg  // Load offset of incyg
+    add     x12, x10, x11                             // Compute final add=
ress of incyg
+    ldr     w9, [x12]                                        // Load curre=
nt incyg value
+    sub     w9, w9, #1                                  // Decrement incyg
+    str     w9, [x12]                                        // Store upda=
ted incyg value
+    ldr     x11, =3D_cygtls.stacklock        // Load offset of stacklock
+    add     x12, x10, x11                             // Compute final add=
ress of stacklock
+    ldr     w9, [x12]                                        // Load curre=
nt stacklock value
+    sub     w9, w9, #1                                  // Decrement stack=
lock (release lock)
+    stlr    w9, [x12]                                        // Store stac=
klock
+    ret                                                   // Return to cal=
ler using restored LR
+    .seh_endproc
+
               .global sigdelayed
sigdelayed:
_sigdelayed_end:
--
2.52.0.windows.1


--_000_MA0P287MB3082EC66F6E990DA42AC2A9D9F8DAMA0P287MB3082INDP_--

--_004_MA0P287MB3082EC66F6E990DA42AC2A9D9F8DAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0004-Cygwin-gendef-Implement-_sigbe-function-for-TLS-stac.patch"
Content-Description:
 0004-Cygwin-gendef-Implement-_sigbe-function-for-TLS-stac.patch
Content-Disposition: attachment;
	filename="0004-Cygwin-gendef-Implement-_sigbe-function-for-TLS-stac.patch";
	size=2673; creation-date="Fri, 16 Jan 2026 17:28:34 GMT";
	modification-date="Fri, 16 Jan 2026 17:30:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyMDY1MjgxYjhlMDZlOWJmZTgwMmRlYTM5N2Q4NzdiYzNlNWY5YjRj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE5OjE3OjMxICswNTMw
ClN1YmplY3Q6IFtQQVRDSCA0LzZdIEN5Z3dpbjogZ2VuZGVmOiBJbXBsZW1l
bnQgX3NpZ2JlIGZ1bmN0aW9uIGZvciBUTFMgc3RhY2sKIG1hbmFnZW1lbnQg
b24gQUFyY2g2NAoKU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGlu
Z2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5j
b20+Ci0tLQogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiB8IDM2ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDM2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL3NjcmlwdHMvZ2VuZGVmIGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRz
L2dlbmRlZgppbmRleCBhYjU3NzM5ZmEuLmFkYjNlZDIxNyAxMDA3NTUKLS0t
IGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZgorKysgYi93aW5zdXAv
Y3lnd2luL3NjcmlwdHMvZ2VuZGVmCkBAIC00MjMsNyArNDIzLDQzIEBAIF9z
aWdmZToKICAgICBiciAgICAgIHg5CQkJCS8vIEJyYW5jaCB0byByZWFsIGZ1
bmN0aW9uCiAgICAgLnNlaF9lbmRwcm9jCiAKKyAgICAuZ2xvYmFsIF9zaWdi
ZQorICAgIC5zZWhfcHJvYyBfc2lnYmUKIF9zaWdiZToKKyAgICAuc2VoX2Vu
ZHByb2xvZ3VlCisgICAgbGRyICAgICB4MTAsIFt4MTgsICMweDhdCQkvLyBM
b2FkIFRMUyBiYXNlIGludG8geDEwCisgICAgbW92ICAgICB3OSwgIzEJCQkv
LyBDb25zdGFudCB2YWx1ZSAxIGZvciBsb2NrIGFjcXVpc2l0aW9uCiszOiAg
bGRyICAgICB4MTEsID1fY3lndGxzLnN0YWNrbG9jawkvLyBMb2FkIG9mZnNl
dCBvZiBzdGFja2xvY2sKKyAgICBhZGQgICAgIHgxMiwgeDEwLCB4MTEJCS8v
IENvbXB1dGUgZmluYWwgYWRkcmVzcyBvZiBzdGFja2xvY2sKKyAgICBsZGF4
ciAgIHcxMywgW3gxMl0JCQkvLyBMb2FkIGN1cnJlbnQgc3RhY2tsb2NrIHZh
bHVlIGF0b21pY2FsbHkKKyAgICBzdGx4ciAgIHcxNCwgdzksIFt4MTJdCQkv
LyBBdHRlbXB0IHRvIHNldCBzdGFja2xvY2sgYXRvbWljYWxseQorICAgIGNi
bnogICAgdzE0LCAzYgkJCS8vIFJldHJ5IGlmIGZhaWxlZAorICAgIGNieiAg
ICAgdzEzLCA0ZgkJCS8vIElmIGxvY2sgd2FzIGZyZWUsIGNvbnRpbnVlCisg
ICAgeWllbGQKKyAgICBiICAgICAgIDNiCQkJCS8vIFJldHJ5IGFjcXVpcmlu
ZyB0aGUgbG9jaworNDoKKyAgICBtb3YgICAgIHg5LCAjLTgJCQkvLyBTZXQg
c3RhY2sgcG9pbnRlciBkZWNyZW1lbnQgdmFsdWUKKzU6ICBsZHIgICAgIHgx
MSwgPV9jeWd0bHMuc3RhY2twdHIJLy8gTG9hZCBvZmZzZXQgb2Ygc3RhY2sg
cG9pbnRlcgorICAgIGFkZCAgICAgeDEyLCB4MTAsIHgxMQkJLy8gQ29tcHV0
ZSBmaW5hbCBhZGRyZXNzIG9mIHN0YWNrIHBvaW50ZXIKKyAgICBsZGF4ciAg
IHgxMywgW3gxMl0JCQkvLyBMb2FkIGN1cnJlbnQgc3RhY2sgcG9pbnRlciBh
dG9taWNhbGx5CisgICAgYWRkICAgICB4MTQsIHgxMywgeDkJCS8vIENvbXB1
dGUgbmV3IHN0YWNrIHBvaW50ZXIgdmFsdWUKKyAgICBzdGx4ciAgIHcxNSwg
eDE0LCBbeDEyXQkJLy8gQXR0ZW1wdCB0byB1cGRhdGUgc3RhY2sgcG9pbnRl
ciBhdG9taWNhbGx5CisgICAgY2JueiAgICB3MTUsIDViCQkJLy8gUmV0cnkg
aWYgYXRvbWljIHVwZGF0ZSBmYWlsZWQKKyAgICBzdWIgICAgIHgxMywgeDEz
LCAjOCAgICAgICAgICAgICAgIC8vIENvbXB1dGUgYWRkcmVzcyB3aGVyZSBM
UiB3YXMgc2F2ZWQKKyAgICBsZHIgICAgIHgzMCwgW3gxM10gICAgICAgICAg
ICAgICAgIC8vIFJlc3RvcmUgc2F2ZWQgTFIKKyAgICBsZHIgICAgIHgxMSwg
PV9jeWd0bHMuaW5jeWcJLy8gTG9hZCBvZmZzZXQgb2YgaW5jeWcKKyAgICBh
ZGQgICAgIHgxMiwgeDEwLCB4MTEJCS8vIENvbXB1dGUgZmluYWwgYWRkcmVz
cyBvZiBpbmN5ZworICAgIGxkciAgICAgdzksIFt4MTJdCQkJLy8gTG9hZCBj
dXJyZW50IGluY3lnIHZhbHVlCisgICAgc3ViICAgICB3OSwgdzksICMxCQkJ
Ly8gRGVjcmVtZW50IGluY3lnCisgICAgc3RyICAgICB3OSwgW3gxMl0JCQkv
LyBTdG9yZSB1cGRhdGVkIGluY3lnIHZhbHVlCisgICAgbGRyICAgICB4MTEs
ID1fY3lndGxzLnN0YWNrbG9jawkvLyBMb2FkIG9mZnNldCBvZiBzdGFja2xv
Y2sKKyAgICBhZGQgICAgIHgxMiwgeDEwLCB4MTEJCS8vIENvbXB1dGUgZmlu
YWwgYWRkcmVzcyBvZiBzdGFja2xvY2sKKyAgICBsZHIgICAgIHc5LCBbeDEy
XQkJCS8vIExvYWQgY3VycmVudCBzdGFja2xvY2sgdmFsdWUKKyAgICBzdWIg
ICAgIHc5LCB3OSwgIzEJCQkvLyBEZWNyZW1lbnQgc3RhY2tsb2NrIChyZWxl
YXNlIGxvY2spCisgICAgc3RsciAgICB3OSwgW3gxMl0JCQkvLyBTdG9yZSBz
dGFja2xvY2sKKyAgICByZXQJCQkJLy8gUmV0dXJuIHRvIGNhbGxlciB1c2lu
ZyByZXN0b3JlZCBMUgorICAgIC5zZWhfZW5kcHJvYworCiAJLmdsb2JhbAlz
aWdkZWxheWVkCiBzaWdkZWxheWVkOgogX3NpZ2RlbGF5ZWRfZW5kOgotLSAK
Mi41Mi4wLndpbmRvd3MuMQoK

--_004_MA0P287MB3082EC66F6E990DA42AC2A9D9F8DAMA0P287MB3082INDP_--
