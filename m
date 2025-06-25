Return-Path: <SRS0=F5Ug=ZI=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id 2CD7C385AC31
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 18:12:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2CD7C385AC31
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2CD7C385AC31
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750875127; cv=pass;
	b=uyYcpg5Q3Dh1u1thO/we6cIFdSinTYKylx5ms4ZuwS9CUnRMOTmZwsyGTugMsFbApd9WCZ6/jEc3CkIZIfLcvVgOF8epR3WLVkf8VrZjEOuM0ME8NkIdYvuk7L6VdAxNc9rS9UCw/M97yjAuku42ga7Y0Hz5lRwaayVSDSMNnDI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750875127; c=relaxed/simple;
	bh=n4C/i/a+NXW6P1xkLqfWkb5uhNev6+rqLyXMaPeyiSs=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=AgBvdT38g/cCW/htUqrnrLqnomPpTa9c/XobgiEVzlNjExFsqpX+UnPkCcdUpuADhwFzLFyU8iWPiERKLh+N4UN6O11yc4PfVRoGuKBMzBOTcHApBzFB9aRI3whAs7TGHXLqta8VVtPEog+JEpkZDK3175LHMRTfAHZjfzYseY0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2CD7C385AC31
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=C06OQFrp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaD5AOgyrKtnYu7to43w3JV6AfhL6JxixE6LtOBoCNbZqnRnIbZuwKcmwmlM1wpaBrM9+s+2oNziou2bp1hiqKZsBBTOXF/wUwr1Y1U14kYBLNSt43PVOX5U2nYN97EiSuu7CFZkM+hWhNJEgpYgEhQpPn9h9bk9dCRuNtSS+2MJ7BIy5XUTPmthLrEq6iKQoujqyfxvgnI3Ub8/mYm9BY0CbOV64ELoe7tQRBAW4K1De1TP88GAgJvzczD/+3X5LHn5tLGVE3dX5PDcrDLCEamNujvyo5cTTARWTAmoZ3lWRNIh7/Kf2TGSyGDTsaHyvZsPDDElM7A/3dHrvwLwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq2u48yxPU4GFQXTfQDP9wyf0iaSaSGsiiGwv5Puq80=;
 b=bo3GddCdkfZonDWg0UCfp4w50/ri3WxTTpv/8hQwrppBvJdDZxZf9MusyFoeoxnj5sKFsnxdUYdPLVny0jkHVIFfLN5O1NEnySEvrNayNr8bCrcLyYB5vc6mA+61iljGgJBgKPtlJ4NMJAdyDpgsHKhewjeNk8W5YIevzYy0EcntkLSUwrKPbfrdc0tq++AGh3ErnJlWzDnAg5NxL2xSd5HNCmiRC2AInefP1sMhzkv3zwR7Qdj29olJZ8ugU9wCOfFaNdpLqEWUx7cp/J/izmCwJsutBdWip4I9caQgEnMyHJuXakiDItUK7M9WbtFFWnR/H450Oxhui5Z3gpYrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq2u48yxPU4GFQXTfQDP9wyf0iaSaSGsiiGwv5Puq80=;
 b=C06OQFrpAVC7Pbsk00d70Fg9a5W6aHrlFhkIIBch2yoNpu1x1a23TZGpTJXm0rHy5/t2G9valn1aoiWrKc7EKpAziQ05Mca0L03LZMR7FzdzE+VBd9IXmH5a+c6e0s+2EVIdahCXL/7iLGkD84A/aovVfRFU730xyodpktU9cVHHaMZtXcYhHymjf2V+AasslGnYxa04WLVfNjV9cofeVkdZLTZCEnsWCh0a2/OAXPBHkevhYkT/MgChVD70FaphWJX0DD+gquUUBz/BDUBE+xSEv5AsZR936zle6yQzzkgZ2fxQAjNLvlcI7/A1BN0QdFEjmnx+eBiF4ORF5fDVAA==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA5P287MB4078.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 18:12:02 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 18:12:02 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Aarch64: Fix register load order in `ldp` in commit f4ba145
Thread-Topic: [PATCH] Aarch64: Fix register load order in `ldp` in commit
 f4ba145
Thread-Index: Advl/GwKeLwEPPBoQJa3fUrayNfVSQ==
Date: Wed, 25 Jun 2025 18:12:02 +0000
Message-ID:
 <MA0P287MB3082CD4D85400059F59A3A449F7BA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA5P287MB4078:EE_
x-ms-office365-filtering-correlation-id: 1c8236a6-8f1b-4e4b-646a-08ddb413c8f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|13003099007|38070700018|8096899003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OG99nD8lIm/Tgun8s6+Juc0IKlDX5Fr6u6mMIumL4HdrVJPqZJRRDHdQBGRa?=
 =?us-ascii?Q?zDzf1ZjU0k3sWCeiPDgZxGlssIIAwQUJ2B59JzuZb7MIJAAZJrFVErhY9EJT?=
 =?us-ascii?Q?rAiW/tUJCsS4t/HpCV/xeKsn2hbrLmh1jzToIGYE0GLTJEw77Aqun0X/X9eV?=
 =?us-ascii?Q?gtJC79jecrqSGSaoIMt/ah396mKL2ljChMmlqXGEfi8BeAO0WhQVAA1u06R3?=
 =?us-ascii?Q?Ws3o1sGI6gYxy9g80wPDC0hzbselNOzznWIdoXIqsmBaK7FXHWytlqbW6vCF?=
 =?us-ascii?Q?PwxwtQhkXmYMttjCKAKQcIXYE0rirm4TlNBCYTTz3A7PvtlE6RS6FgKXzKHm?=
 =?us-ascii?Q?bm/gnjeU+mV6sol7COpA3FxNxSPh0n5PQMe9tEMQJPq2XEwvt+kqewBE4gjd?=
 =?us-ascii?Q?1BKSCRYie1Vukfr27ODnPmVBQVJdiLxxqL7rHrlnQW4bXzkatT9tN+izOhE4?=
 =?us-ascii?Q?2taut/fm+pqEcmsvYuVybsc+uHqB0A2/4+jVRZCBa7dQlk7AWTCAgbbUGWHp?=
 =?us-ascii?Q?HW4JHa7A2zRsqk663yZej6NUbsZAKZ00e7jTW3m7sGTNLq1u8b1VvhOVqocw?=
 =?us-ascii?Q?jwLILN/GildeKlrP2NGyxOGcHFglimjvPFaUj9cclZkTaXoRukkJdDTxsxk3?=
 =?us-ascii?Q?4oa6J2sruU3REGQwKI+mXB98zY+2/SYHWld78YvYMISxX4MuM+yZJ4fLM1uK?=
 =?us-ascii?Q?OZDSD0Nw6BxZ7t6ovRhIbcnwDuCqBur4tzYPGVofLgT87L8+gtwFguIxG4Qk?=
 =?us-ascii?Q?Pbq8XGSs4hc3+VSLnH/36Hp8LwV2zYWeh+4/BhqII82jLBcxFgBBlxynL2UA?=
 =?us-ascii?Q?LuJ5J6V1oljg9YSJRYwMlwVVJ2LP1/VpWSQbgKRk/1h+lZM3qh7AY7l1hCeH?=
 =?us-ascii?Q?qyByIlYwuMFb65fjESbFpJNevyl2ypfMa6ma1M5Kmc22iWVO8JEnp9YKWdi0?=
 =?us-ascii?Q?1KOhYN6Lc4MQnUVALHNKzMzgUs9S9w8eFsia0RKBgpBg1QeYsN/nUVa1gsHr?=
 =?us-ascii?Q?uiNpSu2sUy24J1PHPd/VQzutRNArgFOR+kQPU6u4vV17T4tnDFliJTbX6Rav?=
 =?us-ascii?Q?vyWY5fQvr3a9p/S8dkK2WxInDSmKjtPJXbMhzB1tELJsUj9ID1DRWG63wM3Q?=
 =?us-ascii?Q?5HahIHUCATJtiGzcHjmHQiuzBMaqzDeOHtJUWYPWLuCbhSIglgXsfShFa6wm?=
 =?us-ascii?Q?wJDhKE3AywgX1Rg6doFv/GfbGf2FiOIwXtjooivgPAH1wUNJJK6/0xz7B+Qa?=
 =?us-ascii?Q?jHEY0KnsnivCArvHQnRjNisPHEg2t77d/ZDfYe4nBuoL7t67IaHUV78oC0bc?=
 =?us-ascii?Q?G79yZ+aYuFBCSr09D7hsmmT07LhXNjeIW8Mz+3nXah6NuvGT0+0uB3Lf9g0L?=
 =?us-ascii?Q?AvBHNS8wD1hMYor2IJ075J+rMKGMZ69yXTPLO/O1F79f6cZT/vv0QKpUEjrU?=
 =?us-ascii?Q?XGuzUbzfi9E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(13003099007)(38070700018)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D2WCa0ySHBibMgYl6QJX2HKPyFBdytJRJF0UQkuD9XPv6sd+f6WaivwgLnB6?=
 =?us-ascii?Q?mJjWF99jC6yCBxH2LpCD3NCr7A+9VjTN4sTx1o2p/AWAq+R5EqPi9ppK0e2Z?=
 =?us-ascii?Q?poXrR3OkgykKw+nB/ioSEh6xJRJawDyOA3N8oMgg/G2ywID5yTwvNXQT1qf7?=
 =?us-ascii?Q?ofmxCsv3jeGEele14hZE9lORhlZ9W7qaJHGrN7A4Medn9zs2ofAbGjzcNUhG?=
 =?us-ascii?Q?y1IKvGpBpqDdEW8qJwZR1cDdLYUzj4bJj5+CGvEEAmo7szH7R+46bsOfVxKG?=
 =?us-ascii?Q?jTqoKwbP/zcvIxn8QZamOQxRR68jTgncaA+sBqU1PfBdLlm+7CzqTE/sebmg?=
 =?us-ascii?Q?sNOSglwrtbIi6AQZ55bF7FtrWTk+tI2VNxjdV22emKHrT5bphtqRTAWfTUyf?=
 =?us-ascii?Q?0ntBCBW045itg6w+cUxQedEM3hCcqN6q3lE6fKwnm+oR98jW2Sg0ol7kxMfw?=
 =?us-ascii?Q?eY5ECRhyfMWXQRGSJcww9rc+jQ9nzbDTR+1UCQfVjzkpx2nvmMze2aJ5KRXo?=
 =?us-ascii?Q?LtZAUbTyQfyCJUyQItXtfOXI5zz7+3NhiZsUxeKTDvi4kCrOLrF3AFJGtinO?=
 =?us-ascii?Q?XYSh9mqRTaSZ+B6QGx4lmyPehKNS2/YzzKsm2pXf0RPjAX7JLG7ZXgXcjXmE?=
 =?us-ascii?Q?527sZ0xol1WR9oCOwwTx85bd01iNzxU7YD+DSdzaTWS7e9shaKgEgPPNm9ib?=
 =?us-ascii?Q?t3vsc2Ci2RIoa82PKECKxgWu7Rge8wEAbOdWIWo5xu4ZsA5WN/XRBE/KOvm7?=
 =?us-ascii?Q?bV+LenrqWVaF/BOTgxMhX64s6LTBrirMt/vLJRZQXNq98KHsfQPO/TPjk4Y7?=
 =?us-ascii?Q?DYksWYASlOT8l095/wdZaNelJJ5PaYvsUhxPy29BeJ8FZEnd0rpzUDr6/eTW?=
 =?us-ascii?Q?V4k4CJ6Hxo+/WJJp64nGLnJuaXG30eUgTXJr6/aoDpap86u9Nm6DQoFULiyu?=
 =?us-ascii?Q?emUcWVDFzeA4tcrlU9vA6kGDqlPKLDq2Ss8AqfBOMH3oeDfw+6nkK4HKQna8?=
 =?us-ascii?Q?jyMFUJCHho0+U1ytiRERKgvEB4z9Rw+AFm+aoc8aSuW5Tnz8pAPA77et/WfQ?=
 =?us-ascii?Q?WRqqldRkMtPJ14hlPWf1RC9wip/wJLnye/oMgBuBI/oZsGCWqKJtdZXXIY+q?=
 =?us-ascii?Q?huF47JvnguDtylqK5NC8l4ZUQ3yIyQuEfWuF5bMvsiulUf+wTFH2xbiKzMUY?=
 =?us-ascii?Q?f0J+4nyvPpF+tDjz1pE4OMOIgDVfSPphan5WYPNV4BlY9ekMJOGZICDXhVsK?=
 =?us-ascii?Q?YHlfB4xqvTKgjW6AGBjad2ZfvxxH41gxRtkxbmtUBvzoZml9wLpyChKnO8xX?=
 =?us-ascii?Q?gfh6gAWRG2PUe9o+4GfX6Yt+nLU1yAM8NmiPK5WACzJGfw8x0jMFrT1qjPsn?=
 =?us-ascii?Q?emiVF5xupnB4S0nFao9MsxP/jv4soVd/UuAnNYm7zZ3NVmvWKsyO+aPnXEt9?=
 =?us-ascii?Q?c5JQw+wj6RFx6EgLFSziSuuBFLG4Lzv4ba5SPwHw+IIewjRW53Yh9mO4ekMV?=
 =?us-ascii?Q?zCPS20UT6b8GfkdZyDa753fXn/0qEH4dHsdWcqW0fNyNEvLEhwmvsIpOJQQH?=
 =?us-ascii?Q?FEOSSjEi6I7IMJLccPSZswGEhO36zboXdaw8nKe6rAbRvsl94kXOK9rUkm0E?=
 =?us-ascii?Q?vHEeM3y0duQEUXbDi56tqJw=3D?=
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082CD4D85400059F59A3A449F7BAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8236a6-8f1b-4e4b-646a-08ddb413c8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 18:12:02.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fr+2OdTnY6MrrEsyrvljVUKknH5G8KD3UGL7xrywZgslhDHKCzWi/zgPAY/lLXcf12SiHp5QLg4BT+z3SdNnYYNLBDFqJFpIBJNbPW5+EhA7mppmMUM7ZYjAeg/wjXH93XEiaPh7clEOV0NFfxSSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB4078
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,KAM_LOTSOFHASH,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TRACKER_ID,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082CD4D85400059F59A3A449F7BAMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082CD4D85400059F59A3A449F7BAMA0P287MB3082INDP_"

--_000_MA0P287MB3082CD4D85400059F59A3A449F7BAMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Apologies for this minor mistake in the implementation of final `ldp` instr=
uction [https://cygwin.com/pipermail/cygwin-patches/2025q2/013833.html].
It caused a regression in pthread-related tests on our testing environment.
This patch corrects the register load order and aligns it with the descendi=
ng stack growth convention in AArch64.

In-lined Patch:

=46rom fc0d02ef009e02d520d934beb9429e64d9b522b4 Mon Sep 17 00:00:00 2001
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Date: Wed, 25 Jun 2025 22:23:13 +0530
Subject: [PATCH] Aarch64: Fix register load order in `ldp` in commit
 f4ba145056dbe99adf4dbe632bec035e006539f8

Adjust register load order in `ldp` instruction from commit f4ba145056dbe99=
adf4dbe632bec035e006539f8 to reflect descending stack growth.

Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewarein=
c.com>
---
 winsup/cygwin/create_posix_thread.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_po=
six_thread.cc
index 592aaf1a5..845740f2c 100644
--- a/winsup/cygwin/create_posix_thread.cc
+++ b/winsup/cygwin/create_posix_thread.cc
@@ -104,7 +104,7 @@ pthread_wrapper (PVOID arg)
    * and calls the thread function with its arg using AArch64 ABI. */
   __asm__ __volatile__ ("\n\
       mov     x19, %[WRAPPER_ARG]  // x19 =3D &wrapper_arg              \n\
-      ldp     x0, x10, [x19, #16]  // x0 =3D stackaddr, x10 =3D stackbase =
\n\
+      ldp     x10, x0, [x19, #24]  // x0 =3D stackaddr, x10 =3D stackbase =
\n\
       sub     sp, x10, %[CYGTLS]   // sp =3D stackbase - (CYGTLS)       \n\
       mov     fp, xzr              // clear frame pointer (x29)       \n\
       mov     x1, xzr              // x1 =3D 0 (dwSize)                 \n\
--
2.49.0.windows.1

Thanks,
Thirumalai Nagalingam


--_000_MA0P287MB3082CD4D85400059F59A3A449F7BAMA0P287MB3082INDP_--

--_004_MA0P287MB3082CD4D85400059F59A3A449F7BAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Aarch64-Fix-register-load-order-in-ldp-in-commit-f4b.patch"
Content-Description:
 0001-Aarch64-Fix-register-load-order-in-ldp-in-commit-f4b.patch
Content-Disposition: attachment;
	filename="0001-Aarch64-Fix-register-load-order-in-ldp-in-commit-f4b.patch";
	size=1429; creation-date="Wed, 25 Jun 2025 17:45:52 GMT";
	modification-date="Wed, 25 Jun 2025 18:12:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmYzBkMDJlZjAwOWUwMmQ1MjBkOTM0YmViOTQyOWU2NGQ5YjUyMmI0
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogV2VkLCAyNSBKdW4gMjAyNSAyMjoyMzoxMyArMDUz
MApTdWJqZWN0OiBbUEFUQ0hdIEFhcmNoNjQ6IEZpeCByZWdpc3RlciBsb2Fk
IG9yZGVyIGluIGBsZHBgIGluIGNvbW1pdAogZjRiYTE0NTA1NmRiZTk5YWRm
NGRiZTYzMmJlYzAzNWUwMDY1MzlmOAoKQWRqdXN0IHJlZ2lzdGVyIGxvYWQg
b3JkZXIgaW4gYGxkcGAgaW5zdHJ1Y3Rpb24gZnJvbSBjb21taXQgZjRiYTE0
NTA1NmRiZTk5YWRmNGRiZTYzMmJlYzAzNWUwMDY1MzlmOCB0byByZWZsZWN0
IGRlc2NlbmRpbmcgc3RhY2sgZ3Jvd3RoLgoKU2lnbmVkLW9mZi1ieTogVGhp
cnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVs
dGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9jcmVhdGVf
cG9zaXhfdGhyZWFkLmNjIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjIGIvd2luc3VwL2N5Z3dp
bi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjCmluZGV4IDU5MmFhZjFhNS4uODQ1
NzQwZjJjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3Np
eF90aHJlYWQuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9jcmVhdGVfcG9zaXhf
dGhyZWFkLmNjCkBAIC0xMDQsNyArMTA0LDcgQEAgcHRocmVhZF93cmFwcGVy
IChQVk9JRCBhcmcpCiAgICAqIGFuZCBjYWxscyB0aGUgdGhyZWFkIGZ1bmN0
aW9uIHdpdGggaXRzIGFyZyB1c2luZyBBQXJjaDY0IEFCSS4gKi8KICAgX19h
c21fXyBfX3ZvbGF0aWxlX18gKCJcblwKIAkgICBtb3YgICAgIHgxOSwgJVtX
UkFQUEVSX0FSR10gIC8vIHgxOSA9ICZ3cmFwcGVyX2FyZyAgICAgICAgICAg
ICAgXG5cCi0JICAgbGRwICAgICB4MCwgeDEwLCBbeDE5LCAjMTZdICAvLyB4
MCA9IHN0YWNrYWRkciwgeDEwID0gc3RhY2tiYXNlIFxuXAorCSAgIGxkcCAg
ICAgeDEwLCB4MCwgW3gxOSwgIzI0XSAgLy8geDAgPSBzdGFja2FkZHIsIHgx
MCA9IHN0YWNrYmFzZSBcblwKIAkgICBzdWIgICAgIHNwLCB4MTAsICVbQ1lH
VExTXSAgIC8vIHNwID0gc3RhY2tiYXNlIC0gKENZR1RMUykgICAgICAgXG5c
CiAJICAgbW92ICAgICBmcCwgeHpyICAgICAgICAgICAgICAvLyBjbGVhciBm
cmFtZSBwb2ludGVyICh4MjkpICAgICAgIFxuXAogCSAgIG1vdiAgICAgeDEs
IHh6ciAgICAgICAgICAgICAgLy8geDEgPSAwIChkd1NpemUpICAgICAgICAg
ICAgICAgICBcblwKLS0gCjIuNDkuMC53aW5kb3dzLjEKCg==

--_004_MA0P287MB3082CD4D85400059F59A3A449F7BAMA0P287MB3082INDP_--
