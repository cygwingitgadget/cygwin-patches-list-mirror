Return-Path: <SRS0=mZdz=3G=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id 2AF78385482F
	for <cygwin-patches@cygwin.com>; Tue, 26 Aug 2025 20:17:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2AF78385482F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2AF78385482F
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1756239434; cv=pass;
	b=XyhKPL1+2e6wTryVDjDCQ+315SHm8v/x2of9HgUze1HpRSW8IKjBiF85PF60eGSO6WEWw1+Td0Uwx5HffuxeJIIA41CQu1LkV1o7BpoqjejpwazwG+tEu0k2fM1My3oSqJoFUMfFRgOcHjDhNELSC68j4jfLj5goJIlS2VrGiug=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1756239434; c=relaxed/simple;
	bh=5gGbueOVA9AOj1zZK1WAT51MnTt4EXwJ+eH90yw/A+M=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Zzk8i+lpU9XpBS8mpzUcWZtEPKdBVVxnHy0mwLh1wX6hVfleIJ5xnzxWWbiaTVQf0a9ba3LHHiPyt+Yh+z6QWRHbe78LrJ4ClYolR7KzI4VY6JoYC2A4INFsZf5jCtAyCgC8UYY8d1OVQTqr0NP/p/WSWOJ6EI8pZPUn2NBZd8I=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2AF78385482F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=oeqPPPWt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixCHjmmn4e0pAK4iZ2ehJFPE4VEiY4tsXJ+u6+aSeyAxH2NuVQmHA12eYeuc5XTFtSp+4v2z3pXtVxlzbCqAw2vrL2zXqivfEjilqf0hVhnNsbFr/AZJ35wB1RNHkql2zeuuheQQiZwY/sQj2+2DRci14Psl3yBo7fmtyuBO7y2+xb4F/cHHZk0Jf1xEHp+qw0FSP5NOgGJWYkwQyc5LgfX4d5jb96HtJYEpnOH/rXOs5tLiYBuaNcjt6uSSKWNkV7IOdc2kVj3oj8xqPFZMfks5jS371+hWKp02Myy7zZzKgPrH3sEC4T5Ge9IVh34pINV7U0IIIA0IDMSKezA8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jxFatB1J5VyDytJQbDSUKfCPZpLlqvZ4yWGLF4xGYg=;
 b=ApwL6UG9Z2vjCxRW/5xgQcyEC/J8Kt5boAjiKUyecbFR+MCpURV6PCXEXjh34g1PG1SImd1rzKRKGEG0rHWN/13Jnwn6aePXqIQKuxMg7ZL44xM7o+OjeE7e5nFJuaqCw5F5OczPOPiuuITmgNMxtNxfG8YPwjcCs6KLsGIJ+s93ArZ6L+jnjcBd3ld/Sw1oMjQSCMxKdpo6UmImHVW0exURsKRvr5RcVeZ+tX5p+Imu1VbyXV002NEktRkmRXouqbilTbnFYjRtnBkUJAdQNeEJkN8K9Po2RoazHcfo2ikPis6648p3g+U9viTMR/FXYO4f1bo9atDp7kt/muoRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jxFatB1J5VyDytJQbDSUKfCPZpLlqvZ4yWGLF4xGYg=;
 b=oeqPPPWtQX/NChNnPkxBSY6Goq+i/gYioaCgCXZupgCQtdmQV5X0jIsQiGMa80+FFZcETXv922dEZ34V4QITpLHmORSXvRRCuUg8/1fHWgwcrEH9tQuLrLg/yjIRCDAu47MYTm7wOJBO+oCZlxib1s2HpkxjyAZMWXOCOxuIcsDyZkCnQjY2Sr9MAZAYPZSiZUWiL/esLPakOvSifDb8VIEyganJhp7ORi5yHnxwblQxOz4iQiMxbDnOAuAK9EKFyyH2RX3nH0buMY2ObLH1lgpI61HpaZdILaz4HMdVaY+ET3wlstvLmKnPuj7fKeJI3WH6oMtGRQ10W48PPhVY7g==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA0P287MB1806.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Tue, 26 Aug
 2025 20:17:04 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%7]) with mapi id 15.20.9073.014; Tue, 26 Aug 2025
 20:17:04 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V2 2/3] Cygwin: math: Add AArch64 support for sqrt()
Thread-Topic: [PATCH V2 2/3] Cygwin: math: Add AArch64 support for sqrt()
Thread-Index: AQHcFsZjvNQXLjFwYky434aVlws9sg==
Date: Tue, 26 Aug 2025 20:17:04 +0000
Message-ID:
 <MA0P287MB30827811C92DDACCD71F5B839F39A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
 <MA0P287MB30824DEB5F7F550A558C30109F3EA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB30824DEB5F7F550A558C30109F3EA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA0P287MB1806:EE_
x-ms-office365-filtering-correlation-id: 5b48c2b7-278c-4215-64d4-08dde4dd8617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZYvNQORvFRreBxUrbP0OJiQNbFvWHPn4t0SXJk0bLkLzaFYDrvefTe47Qo?=
 =?iso-8859-1?Q?iUE7Bku5CbT+Kd1v304akBQCeGtFK6fKUoOtr8+Wr84Cqp5toRQ5Lr9DII?=
 =?iso-8859-1?Q?IkpogTLUmWjgvZJM2gf1mVDtpXhK10NsFIen/zKj9G9thTEH0IaTVPUI89?=
 =?iso-8859-1?Q?EJorg5g5Wc9KfjHCMRjgzQPMbOweogiYgtT6mg0Zdh/OvsHHj/LwZXkVCi?=
 =?iso-8859-1?Q?12TStxxstqCfIP9F1Vs4UIWKJLNz+fACQM33i+SYrF569nYLEA1m5PlfVq?=
 =?iso-8859-1?Q?GeIu6cQy5ROOme+TPlMXbZ5HTFSC6p6gttttPgBWKMRQM5sPdap2cZbka+?=
 =?iso-8859-1?Q?5oCosO2rs4gJEZTJJAHixWukfwJSj878NjKSbJrwZ6joi5VEEYH026b81s?=
 =?iso-8859-1?Q?e+G492iz7uJDnWEtHNqDysTuYQYB0cDBKpb383h8T50ZfPbBqAPGa/Utdw?=
 =?iso-8859-1?Q?imyRKkMZKLMcYHY94ckHcVtvuI+QmKh2u8j/ZtAU0xwDae54XfAyMnqEtY?=
 =?iso-8859-1?Q?LvNkff/w4+U2c4/WDKrOVwE90sGN7zU/Fv0iaF06tFS3jH4M9H6Hvz3E9X?=
 =?iso-8859-1?Q?QW6MLtvbtICVP+rGJEkRSNJrh+SQOar2dvV3UgmaylObTu/6QdmFQ1lwqY?=
 =?iso-8859-1?Q?np9L08ojY26EHr9yykvXymNjy7fbt6PIaPX4Du1bKdjDsn6v3j9rVcO+mh?=
 =?iso-8859-1?Q?He8Eoz1NUK52j14KLlIDFDAWybbUYrIRyppTv7TI5OOc1kc+iFu8no5PoS?=
 =?iso-8859-1?Q?Vp64mSq+fOub9XpClbSJ3BTQ8w6I97W9mlZ2XpyPTEmSbir/O6ttcs15rI?=
 =?iso-8859-1?Q?ca030aiQ4E40gFk5zKdCYqLWmMxozs5tuAR1PkoSqxyMF2SVyimZB72ev3?=
 =?iso-8859-1?Q?JYEkTe1S3QSrZ+MUkgGOm4Qo+KypJa0JEo49R4d5AJZPvXzry5d6NTXl4+?=
 =?iso-8859-1?Q?KwgfcHUA+Mry0p0oUTc9+Goa5Sq7cpbxIkkjh9QXUkvKapZnYKzkmaspYy?=
 =?iso-8859-1?Q?vKLMgWNfZpHLHFdZTyWA/TQ0hxJzD2R8yBWmFMw1/UhDVMUKXdSAL+MuUp?=
 =?iso-8859-1?Q?3O0zUVn0QuZUCfCrlohVJ2GaZfP8o0eSveONOWaj+SU8fAML/hl5NNvUQE?=
 =?iso-8859-1?Q?Ua6RFau8Gyfogx5aaERh4C5wFQk2Gz/u0NvCPcVixVVewmaPoUh4gfA3l+?=
 =?iso-8859-1?Q?W4yyC/DdzGXBeXUGuT6JIbobhdiT58eA2CYS3i1RaoBwzI9p6P0Xsc6swz?=
 =?iso-8859-1?Q?eWqOcEtoIgnHbWpw2lRiyw5QChkPVHegCOh6IdHf9OJnW31cTQepqAbHXY?=
 =?iso-8859-1?Q?Gx0h12hPNxIxierK6Ki+omino8uiLf26ZGl/9S6mbsiay17nLvOhxlY+wY?=
 =?iso-8859-1?Q?5+B0SK3+pQyWp6PaftFAj9Szfj/MWzmv0yVMg5jatwDNSlxOcue4U1YOxe?=
 =?iso-8859-1?Q?O/YULcNhtgAxbNWPfwTxeinMtoC1HgHQKMBnh3hOei41xZoZWNURVu+wz5?=
 =?iso-8859-1?Q?MSf3OA5sKkgfxKi+humTy8AaR1uyg6cXrUB/H/j3fX0+kYulAUgJuJ3S6U?=
 =?iso-8859-1?Q?aiFXhUw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kRGYsix9xj1uwvuOgzMrey2ff9rxDprQQP9VcxsNBGQXXhgYG7DfQwFsv1?=
 =?iso-8859-1?Q?d0FFvahyzjMnphLeQ/s6Th7aa6yZOqYrpuL8RZ1foDt/936jcdSOMx1ml7?=
 =?iso-8859-1?Q?rOuekli0z7suGzK/lK2o+oHZPJmlBEcA91ApsS5+LSi2lNLBQoUGqoQh+A?=
 =?iso-8859-1?Q?LgNwcOV1RS0MQrQtbroLJFPOzP33kn8KH3AUubTKOfBbodRMfs3A3DKNA5?=
 =?iso-8859-1?Q?raV4QVIbJLQDyf3v/gbrIk2gEc4iqJloz2h8pVNniW5EMkOELhjRGdBB7l?=
 =?iso-8859-1?Q?ZL/EcQRJ3uryWUtkN7fUogwukvRh5UtHp0jFObTYfODMaJBPoACv8h/9T1?=
 =?iso-8859-1?Q?fgiA4vFoNtQURUcSp1gNocJScICQ1doqRwBMx773iYSoNtxeetYPdQZ1i5?=
 =?iso-8859-1?Q?j2KkBM10EecM/4WOqO1+jkZzqpJOx2X+/egJfTbZPYORI+ynENmwSdDbjE?=
 =?iso-8859-1?Q?j10a4yLjRdW3mvjLGg/2RabD6wrbURhfn5mssD+Ka+NX6vX58JyFBvCAnY?=
 =?iso-8859-1?Q?yZjJdpnkbPvq+uWioqR02gOjwOGtcefINjYHsaoXS6q27atlCXOq7xgmj2?=
 =?iso-8859-1?Q?/ozWMKU37VtrxhOhdQQJxRCn/n0SXmrtHDgG0tIWccThAVOH9RBJlT0Nry?=
 =?iso-8859-1?Q?hxyB2HP5JpDloWVS2LN8AfsBYf/PVdPhtLt+kF+vwv9IWPcXK6D58I59rR?=
 =?iso-8859-1?Q?moHCjuAjwRPeCG451Oeeqxb5Eoc7c6QkjQEyucwhAsI6uiBOMZaJsIchui?=
 =?iso-8859-1?Q?YG+bbwXs+HRi3FgpiIxqtQJL8RWu7MdOBR436s5QQgSA42pw4179vyA/cQ?=
 =?iso-8859-1?Q?qQzMMoNBBYrNuZ4fc2fvYM5Zkn4kJLkMLzqsKhr3BXCjrRppnpK2E1qmSb?=
 =?iso-8859-1?Q?T6jzbsE1ufd7M16+4oAnj7oonj59RSwYTXfG4b1d7YIEv6aI52QchiSKeX?=
 =?iso-8859-1?Q?gqbU3WpHJlkRgSWWIozbYi9OoHki5jZ3F/4NdT5YDCMLQxar5aDg9jCSZT?=
 =?iso-8859-1?Q?tlwBlpawKfNV4Rt/Hw3uUmEswqHiq1blJe86AOlY0amnycGe9owbOKn/5B?=
 =?iso-8859-1?Q?jf8iKFAUaJpqP4I7EtxeGIdEgO06yZykwMh21PnprRDhesAH15olzuJbUN?=
 =?iso-8859-1?Q?jnoRQ0j5KzWrt8vCdBFqbzU0hqGOGfpCI25w8ii/wODmdd5IbJ/K5wMjYi?=
 =?iso-8859-1?Q?EvKFdCw9N0PE6CbLRnOJc6S1pFbMBnk06b1PtOT4MdyrC/fsRTc+W/ubMj?=
 =?iso-8859-1?Q?6wJCN7/asq2XoDCveM4PEMTmUN/a01olwwAPGjm3wdpTwbYk2y/E6ZIIUd?=
 =?iso-8859-1?Q?BwLen6twySy4PavUvaeNreMwTSOLz8Zn0dL87gGdidOlbOYuLrep7Q5yA3?=
 =?iso-8859-1?Q?X4ZsmxEKFYPmm9jt/ZDjYwkGSVkJwieyrzXOY3/j+xQ/z2v1CbhJuzSpGz?=
 =?iso-8859-1?Q?poKEECpFNSjMxJ335uyBAx7zJLRzfsjQc4mDMXV4Kt4IUiazAbCM7ZP7vp?=
 =?iso-8859-1?Q?nueq1KWLmcAonREGZD1zjdVmsBPqGOwu74eJBYotm7p+gNMI8eK5OwiQwS?=
 =?iso-8859-1?Q?2hq4oKW9am4KmUux/0V3Ig6HRifKzp3NY6ajBhR3Ay/j9Smsmk5ceN7CeF?=
 =?iso-8859-1?Q?uO3LlSraPrGjA6rG/oKkAfXs85fHisNh2Zq4gYNnulDEczawJYw8v69pbt?=
 =?iso-8859-1?Q?JvFQ7Ds4M0rG1LTSRgX+31q07ACToU4/qLsiIB3R?=
Content-Type: multipart/mixed;
	boundary="_002_MA0P287MB30827811C92DDACCD71F5B839F39AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b48c2b7-278c-4215-64d4-08dde4dd8617
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 20:17:04.4984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eui5L50NvCBDIAuG93y1ZgjmbxO8kmXnC1sU3AeTxT8lsxgVXiKPt4fUjl3Mwgz2V06BtHfnONNmzaxHacCGZgXacbhLPJK/nVTuhv6WCZJ07cnVCBpnmx+JE1xTHmwBsg7CwZdbRy3QB7Vq9MAW5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1806
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_MA0P287MB30827811C92DDACCD71F5B839F39AMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
Pls find the 2nd patch of the series: - [PATCH V2 2/3] - Cygwin: math: spli=
t math sources into 2 groups

In-Lined patch 2/3:=20

From 9bdf88e17c7b47675eff455bf35cce9ac0a33b4c Mon Sep 17 00:00:00 2001
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Date: Wed, 27 Aug 2025 01:28:05 +0530
Subject: [PATCH 2/3] Cygwin: math: split math sources into 2 groups

Refactor `Makefile.am` to separate math sources into two groups:
- `COMMON_MATH_FILES`: sources always built on all architectures.
- `LONG_DOUBLE_MATH_FILES`: sources only needed when `long double`
  is distinct from `double`.

`MATH_FILES` is now selected based on the target architecture:
- On AArch64: only common files are built.
- On other architectures: both common and long double files are built.

This avoids duplicating nearly identical file lists and prepares for
excluding redundant long double implementations on AArch64.

Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewarein=
c.com>
---
 winsup/cygwin/Makefile.am | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 90a7332a8..ade1f19a9 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -153,7 +153,7 @@ LIBC_FILES=3D \
 	libc/tss.c \
 	libc/xsique.cc
=20
-MATH_FILES=3D \
+COMMON_MATH_FILES =3D \
 	math/acoshl.c \
 	math/acosl.c \
 	math/asinhl.c \
@@ -243,12 +243,31 @@ MATH_FILES=3D \
 	math/sinhl.c \
 	math/sinl.c \
 	math/sinl_internal.S \
-	math/sqrtl.c \
 	math/tanhl.c \
 	math/tanl.S \
 	math/tgammal.c \
 	math/truncl.c
=20
+#
+# The below MATH_FILES are excluded on AArch64 platform, as long double =
=3D=3D double
+# So aliasing via cygwin.din them instead of duplicating it in cygwin/math
+#
+
+LONG_DOUBLE_MATH_FILES =3D \
+	math/sqrtl.c=20
+
+#
+# Select the math sources depending on the target architecture.
+# On AArch64: only common files are built.
+# On other architectures: build common files + long double math files.
+#
+
+if TARGET_AARCH64
+MATH_FILES =3D $(COMMON_MATH_FILES)=20
+else
+MATH_FILES =3D $(COMMON_MATH_FILES) $(LONG_DOUBLE_MATH_FILES)
+endif
+
 MM_FILES =3D \
 	mm/cygheap.cc \
 	mm/heap.cc \
--=20
2.50.1.windows.1

Thanks & regards=A0
Thirumalai N

--_002_MA0P287MB30827811C92DDACCD71F5B839F39AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0002-Cygwin-math-split-math-sources-into-2-groups.patch"
Content-Description: 0002-Cygwin-math-split-math-sources-into-2-groups.patch
Content-Disposition: attachment;
	filename="0002-Cygwin-math-split-math-sources-into-2-groups.patch";
	size=2087; creation-date="Tue, 26 Aug 2025 20:01:04 GMT";
	modification-date="Tue, 26 Aug 2025 20:17:04 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YmRmODhlMTdjN2I0NzY3NWVmZjQ1NWJmMzVjY2U5YWMwYTMzYjRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogV2VkLCAyNyBBdWcgMjAyNSAwMToy
ODowNSArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMi8zXSBDeWd3aW46IG1hdGg6IHNwbGl0IG1hdGgg
c291cmNlcyBpbnRvIDIgZ3JvdXBzCgpSZWZhY3RvciBgTWFrZWZpbGUuYW1gIHRvIHNlcGFyYXRl
IG1hdGggc291cmNlcyBpbnRvIHR3byBncm91cHM6Ci0gYENPTU1PTl9NQVRIX0ZJTEVTYDogc291
cmNlcyBhbHdheXMgYnVpbHQgb24gYWxsIGFyY2hpdGVjdHVyZXMuCi0gYExPTkdfRE9VQkxFX01B
VEhfRklMRVNgOiBzb3VyY2VzIG9ubHkgbmVlZGVkIHdoZW4gYGxvbmcgZG91YmxlYAogIGlzIGRp
c3RpbmN0IGZyb20gYGRvdWJsZWAuCgpgTUFUSF9GSUxFU2AgaXMgbm93IHNlbGVjdGVkIGJhc2Vk
IG9uIHRoZSB0YXJnZXQgYXJjaGl0ZWN0dXJlOgotIE9uIEFBcmNoNjQ6IG9ubHkgY29tbW9uIGZp
bGVzIGFyZSBidWlsdC4KLSBPbiBvdGhlciBhcmNoaXRlY3R1cmVzOiBib3RoIGNvbW1vbiBhbmQg
bG9uZyBkb3VibGUgZmlsZXMgYXJlIGJ1aWx0LgoKVGhpcyBhdm9pZHMgZHVwbGljYXRpbmcgbmVh
cmx5IGlkZW50aWNhbCBmaWxlIGxpc3RzIGFuZCBwcmVwYXJlcyBmb3IKZXhjbHVkaW5nIHJlZHVu
ZGFudCBsb25nIGRvdWJsZSBpbXBsZW1lbnRhdGlvbnMgb24gQUFyY2g2NC4KClNpZ25lZC1vZmYt
Ynk6IFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5uYWdhbGluZ2FtQG11bHRpY29y
ZXdhcmVpbmMuY29tPgotLS0KIHdpbnN1cC9jeWd3aW4vTWFrZWZpbGUuYW0gfCAyMyArKysrKysr
KysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5hbSBiL3dpbnN1
cC9jeWd3aW4vTWFrZWZpbGUuYW0KaW5kZXggOTBhNzMzMmE4Li5hZGUxZjE5YTkgMTAwNjQ0Ci0t
LSBhL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuYW0KKysrIGIvd2luc3VwL2N5Z3dpbi9NYWtlZmls
ZS5hbQpAQCAtMTUzLDcgKzE1Myw3IEBAIExJQkNfRklMRVM9IFwKIAlsaWJjL3Rzcy5jIFwKIAls
aWJjL3hzaXF1ZS5jYwogCi1NQVRIX0ZJTEVTPSBcCitDT01NT05fTUFUSF9GSUxFUyA9IFwKIAlt
YXRoL2Fjb3NobC5jIFwKIAltYXRoL2Fjb3NsLmMgXAogCW1hdGgvYXNpbmhsLmMgXApAQCAtMjQz
LDEyICsyNDMsMzEgQEAgTUFUSF9GSUxFUz0gXAogCW1hdGgvc2luaGwuYyBcCiAJbWF0aC9zaW5s
LmMgXAogCW1hdGgvc2lubF9pbnRlcm5hbC5TIFwKLQltYXRoL3NxcnRsLmMgXAogCW1hdGgvdGFu
aGwuYyBcCiAJbWF0aC90YW5sLlMgXAogCW1hdGgvdGdhbW1hbC5jIFwKIAltYXRoL3RydW5jbC5j
CiAKKyMKKyMgVGhlIGJlbG93IE1BVEhfRklMRVMgYXJlIGV4Y2x1ZGVkIG9uIEFBcmNoNjQgcGxh
dGZvcm0sIGFzIGxvbmcgZG91YmxlID09IGRvdWJsZQorIyBTbyBhbGlhc2luZyB2aWEgY3lnd2lu
LmRpbiB0aGVtIGluc3RlYWQgb2YgZHVwbGljYXRpbmcgaXQgaW4gY3lnd2luL21hdGgKKyMKKwor
TE9OR19ET1VCTEVfTUFUSF9GSUxFUyA9IFwKKwltYXRoL3NxcnRsLmMgCisKKyMKKyMgU2VsZWN0
IHRoZSBtYXRoIHNvdXJjZXMgZGVwZW5kaW5nIG9uIHRoZSB0YXJnZXQgYXJjaGl0ZWN0dXJlLgor
IyBPbiBBQXJjaDY0OiBvbmx5IGNvbW1vbiBmaWxlcyBhcmUgYnVpbHQuCisjIE9uIG90aGVyIGFy
Y2hpdGVjdHVyZXM6IGJ1aWxkIGNvbW1vbiBmaWxlcyArIGxvbmcgZG91YmxlIG1hdGggZmlsZXMu
CisjCisKK2lmIFRBUkdFVF9BQVJDSDY0CitNQVRIX0ZJTEVTID0gJChDT01NT05fTUFUSF9GSUxF
UykgCitlbHNlCitNQVRIX0ZJTEVTID0gJChDT01NT05fTUFUSF9GSUxFUykgJChMT05HX0RPVUJM
RV9NQVRIX0ZJTEVTKQorZW5kaWYKKwogTU1fRklMRVMgPSBcCiAJbW0vY3lnaGVhcC5jYyBcCiAJ
bW0vaGVhcC5jYyBcCi0tIAoyLjUwLjEud2luZG93cy4xCgo=

--_002_MA0P287MB30827811C92DDACCD71F5B839F39AMA0P287MB3082INDP_--
