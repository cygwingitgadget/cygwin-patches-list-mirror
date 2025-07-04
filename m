Return-Path: <SRS0=s6lY=ZR=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20713.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::713])
	by sourceware.org (Postfix) with ESMTPS id 5995D38515F3
	for <cygwin-patches@cygwin.com>; Fri,  4 Jul 2025 08:11:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5995D38515F3
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5995D38515F3
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::713
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751616697; cv=pass;
	b=t/snnymC9QSlNI54vkNmuFsjHR43l8emzjYrVK60KwiyGSixhrHqUXOaqIoyAT+MaiylBY7FmnPm793zyYZibyiic3qn/mGWPUmbMeHUlaFqtE6vrF4PdSoggXfZxBk5NdTo07MEor/Ooi4i+oAjo+mIbl3urQf3VRz0Jo3ORDk=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751616697; c=relaxed/simple;
	bh=y7WPhQO9MjxlL3T3sv13aA2+G9sGrN+HbkkjzQtIVa8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=DZTJ0+GCcrEqmhLqb60Vn9eJbu+t3Qw10fmOp5et5xWc+8oFbqyCKJ1HErPoJ4S+ROK1uJd6o5L9KTNZCKzwy1qYxt4IZ/DskUqR4ZXkhwt81F/APj5P+hMgAhGcE8SsLSu5omVgtuvObYUtZ3jvbQnWhOvKde5jxuyJ0pf63VM=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5995D38515F3
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=LVkZUu2C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pq9w50Ku38+v5G+MW0XChMausM0hatIlU8Ss9af77VAhy4Va42wMUWWc06vx4yImQa33ZGm9hMTcIV5LaNQ1Zki7gWaOZo4BwELltx7Fifx9TiBTubIb1t43P3+gkh6mYd0RrpP/6yCO0F2YlkoD1n6EsTVhqbxpOSQOc5UlbLGzMSqTKzlb1WAIxgLRtndxooqkTe0iDsIQ7Qw8QWKSPO62BXtXjt7b5UM1Y3ZjE8dwx1iJ9GdcXJ6mZDei4bLHr15Exhb9xk5FLQWezvnU9nH/sNzsD36tTnQ7M7eRfPuxouvRZx5WC1Dbbc/RY6nQndCSwThWx2M6ZhjcWw0EiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoB5tcU6N4T3dfUUMSqhjhmDXggsaadRMm01SRPp7/M=;
 b=tepMMiUHUhnAdwoZWOWFH9eN7fDVU20hAuXXKNxQJm29UcgSAdfH2rEAzTichEEGBTa+rRB8RrVoPtRzW+exHoFQntgCTPW50ZqyRom+/E/rg5LKj/D7X5TwGkCfSEC1iTZsNKzt+H+15SUGDILXUPRQICkJ0nFw3Y3bUHpQ5/GaLv1bFt95Y99nKdP589LchaR+tjtcVmkhI//T6HUecJn5HVlBSBjejwKnIX5DEPA88UTk1kzCV61/4b2Hqj5UdYcAVDS6bs81D0KPJUNE4FaVUp/VMXiPjedaU1LZda/Hkf0vX2sUWImtCDt/sfRCo2nuQK8FdZ/VidnOkx/Kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoB5tcU6N4T3dfUUMSqhjhmDXggsaadRMm01SRPp7/M=;
 b=LVkZUu2CQLDCW+NncpB4NZPnLXfktgcnD8UP/2S9n8/aiLwADmzouqTHmUd7BFQQhXOL/IEO015hCTuFEXTaD+LF8pNxZN17pH4UlqnaYXR60wu9FT+roTiNUv21QVGuBCLbPUfjcj6FufgnwHAD8FoT37UsFNUaJLeKFGNrTtY=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0794.EURPRD83.prod.outlook.com (2603:10a6:10:588::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.13; Fri, 4 Jul
 2025 08:11:33 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Fri, 4 Jul 2025
 08:11:33 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: dumper: port to AArch64
Thread-Topic: [PATCH] Cygwin: dumper: port to AArch64
Thread-Index: AQHb7LsG4TwOOw35M0uMZGdaONCnjA==
Date: Fri, 4 Jul 2025 08:11:32 +0000
Message-ID:
 <DB9PR83MB0923715C769A4815ECC3D81A9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-04T08:11:32.143Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0794:EE_
x-ms-office365-filtering-correlation-id: e96a2a38-8e8f-4469-1b6d-08ddbad26356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|4053099003|8096899003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?eGt6QnTL0RlnlgsJq6hLTycykEJWAg9v2su7w9EB5rHyq8mzQHOMue87G/?=
 =?iso-8859-2?Q?z3jDclw9uzPkB3t0If8IU8xjxV8O6E0RoTNZ3ExVZQcJguOWLjksPBZpgb?=
 =?iso-8859-2?Q?zMM7PUW30pKrSh0eVF6kicj2VYOQidUSsLc9wlwam1N+ejfuC1v4rBg4E4?=
 =?iso-8859-2?Q?Svx1BQapXOXrM+cHF4waMT9yWGHW36cYvrlWLBTk5pCnNWWrufFdn5snWg?=
 =?iso-8859-2?Q?efjxQv9YVl8D1t6DC6/ma6y/lYifByQn/MLtSMCKIqvuWWk2QW8y4UGCod?=
 =?iso-8859-2?Q?De/DHGT9Fjc2YyY3VKyTMy8rHmKXJn7AcDH0u+auGilNVzMKGGMcRzO73A?=
 =?iso-8859-2?Q?m2mY1JmuB4EvhIhSr9fi9o7nlt/DyyU5ZVM3123evpdrBGT2fLygmJIen8?=
 =?iso-8859-2?Q?LljXCcrBVxL//XKf55GYZ4HLOy7kWTaNDb5i67lAHnhptvNoJvgbm2XxED?=
 =?iso-8859-2?Q?C2B2BOaMZ4XL/0CP4CTOKLbtUI11cqhx6VRTNCxuGPeMpkiTP6zEDALS3f?=
 =?iso-8859-2?Q?JICt3HzGZJgWj/FDpiAW486AMwohzeW4463mKU156oIv0iO5zP/qe11FxK?=
 =?iso-8859-2?Q?ivhwNQuk0zyPdDSSicBHa0qyinBhEo1vlLZy7uyPVOPb+xxEZ8aWd2a6Nb?=
 =?iso-8859-2?Q?1OYAOgBmef62pwkkH5f8cIQhnkZwV/r+VrV7JRVEoOWC870bocRtnDWn8s?=
 =?iso-8859-2?Q?tFpRhKcnf07dmR8e5X4umsDu2iyeCHpfuUxPbRODP/aAD1OfJn+QIw9q8M?=
 =?iso-8859-2?Q?wvlwbApcOeqK4P0DScqRBJva8JsTnaaMVaMirRKkSm5Hc4IC+aXVqD4StH?=
 =?iso-8859-2?Q?kEsbbWlymMRW1Kyl+WbBXvjn4d0QtnQzJgmovmRIVVLykmSxjDI/xLRSPh?=
 =?iso-8859-2?Q?2rAcdeUAiqI8ddxgyfgUvcXFvyV8glYjYH0yIeHHJT9+ffg+isotbcOUfd?=
 =?iso-8859-2?Q?TyalY4yLzWfSB2favlXn3e8HHIaRPj/pqPmpRgWXcHpdQOddxt4pPKhJrI?=
 =?iso-8859-2?Q?MyYeI2aXTA3ZTG5W7JxegzvYUbPWLTJLexIv4CiBBHibpNDslGnvIo4Ggy?=
 =?iso-8859-2?Q?nICKD0SK6KvxP0V77o/2RHsHg4kQ5DBDnSuyDvFN0qBWGK0mE7BtAPwNJJ?=
 =?iso-8859-2?Q?0yisvycse2l7P0PRopkjQ2SGmoQoSUCull0W0aAGBTL5Kbfs7+3vHddFzx?=
 =?iso-8859-2?Q?2v+l/hz+wk/s8lPo+ncL4bDyUas2/CFiaLlT5oqaa3XtS7rvLJ/z2uuUPu?=
 =?iso-8859-2?Q?XbwiaZMh42yi21SVzcQUqD6Vvux76vvEr+Bq5Y3fvyiTgDFM+Klhv9vmKX?=
 =?iso-8859-2?Q?p9NNeFQymNrx1cbkZFHVWZ1HVbRUsaRQdtSA1BXyXSt5kz7CEJUAly3+os?=
 =?iso-8859-2?Q?bejT8OSvMZsiI/Wzn8tEidFAYb9X9zP+O3t5lg9RnZkZdLFhDAqkeGjNTh?=
 =?iso-8859-2?Q?3Av65S3XDNRRHQrWX7rkXQiYArIm9c+25PnLrFTPv6jwEpcvqsrkn6QPcd?=
 =?iso-8859-2?Q?/pIx2k4PcObrWMSzmi392vVARxuvBrAFkkoWzJICm5e7ZsXJTblbzSjPHT?=
 =?iso-8859-2?Q?gfDl7pk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(4053099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Amuxmxdx1oB9zAfGq8/eZ2yRWVxlCfqEH4iycsUqAGxWG5fkOLF2w5ozLF?=
 =?iso-8859-2?Q?+FNKidLU3YoXuOLiLus1h9AeH9FmsZIsFmizBx7R8J58OFsRQQUF77AIqT?=
 =?iso-8859-2?Q?ay2fQUjXwhuuy0W7jbGW+ChDI+jruXUxwCGzOc4nutfBOZbp1T349IhFuO?=
 =?iso-8859-2?Q?o3rp7Gp+M36hzvxL6SHZN+92W+86NborM6NbIXx+hHqfuofVejK/XfzBHs?=
 =?iso-8859-2?Q?+vwI5vB1+tHWlE2vDf7+6jeeeRUDQWhH4Gi1H5Nrb579M9wdGxyQ/a1VGC?=
 =?iso-8859-2?Q?7ev26y5SQzHXoe9u3IyHngkMvLbmEW04XPPHaJ4S14YS2seAgkYb6NvYr4?=
 =?iso-8859-2?Q?znyJItlYZMIlfGdjE1/Kn2NVV/UqGdpwL/ATjIGV7LFW/y3iOffRp75hn8?=
 =?iso-8859-2?Q?sshaWExBpMqBR4/CShc4S49GFVEFmrqtIAJmFnr4hFTIt9AjwCR/YmbvCh?=
 =?iso-8859-2?Q?S05BC61kr2VQNQ+f18/WFiCVOy+2IZdGZhzhnz/pGWeebXWDWT8aYiZDVY?=
 =?iso-8859-2?Q?5it4zAB/QxYmEnMSgixhs1rPyGW4lGOpMQitjt8SV9jQfKT8ABAIEPKz3i?=
 =?iso-8859-2?Q?11AAtG9SDqYkqFdHtJCV9Xt5qbeZiT8FhhyDr2ecC4EimFhY5K8hyuqlm/?=
 =?iso-8859-2?Q?H1eYYt2WT+RqBdMi0gL5zrQ8J0r9g6SDOx6rEOO1vLD11tdhpZrgZ7NiR1?=
 =?iso-8859-2?Q?vf/p4tBpFQELm9hJjnlhSWqhWGjqc8dqP99dLNJ7YAWuMdvccDt9R/rlQD?=
 =?iso-8859-2?Q?pHEgWp862BWcmL9e2gCW7wSnC7Xk+p4Svdlkd1g8GudDNnbxost7RUR4sR?=
 =?iso-8859-2?Q?zmA1uu7DFneRrHYwHJDMn7cSTRUcJIsvy8QDmkgc+j+diIx7i5rXi8NgSq?=
 =?iso-8859-2?Q?DX3D46KQlD7g6WZG4Nz1WUIZAInDghI0cLUzu6K6ffbA7EVms8gxd9kpeq?=
 =?iso-8859-2?Q?BTSxIsYoTCcG8QeLXXCIG6w3GkvkPlehaKeJ9f5wXAJ7wnKOggS+YPIYuK?=
 =?iso-8859-2?Q?k+4HvDz3zKNW1JaaCSszSA4jSL8OxSFWwqLjSGo2DhR4BFKcyEoSbIHfqC?=
 =?iso-8859-2?Q?UadZw/to1Xj08jL57vsKGB3GVkt1YQXUu3/eYWws//7fG3Fk9hQTALoVyP?=
 =?iso-8859-2?Q?DE1QYhnA05OQwjXbO8qtdPJkVW8pqYJFVxebdIpS6Xj0n6SOtUeO+7B44B?=
 =?iso-8859-2?Q?q9ZAxiq4co4FJiVcc5D/0Ut4bJy65H0O5D8V20HWn791KU2i0S5slsthGJ?=
 =?iso-8859-2?Q?f1QIujZ9b0FrBhvgLwWQiZbcbBDejG1yd0jzfWc17Qyc48vhMCZBad/4Lv?=
 =?iso-8859-2?Q?6xmrXVozWICtt17g/f4a/kSZcYbbFVSutIf1gd6WLJcCmuMZRSOdczkWZ5?=
 =?iso-8859-2?Q?v/H0ylJP48N/5ly2kiO/nLTbBYkdVw1tAi6q5D/WRgccwtQVxjNH/VHnMy?=
 =?iso-8859-2?Q?H9SNi+BUmVPcahI+MObthIl0q7o7BJM9T33uCKXDunLJD7zxs82vxu2NUq?=
 =?iso-8859-2?Q?8nDmOnqZNZPoaeW9G8DqVfSvGuDKMcjgBYsX3JdzubFcg0NziQH3UDP+Ku?=
 =?iso-8859-2?Q?0t3lUw3QyY0E9hNDHzG8z6Bv6NcC?=
Content-Type: multipart/mixed;
	boundary="_004_DB9PR83MB0923715C769A4815ECC3D81A9242ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96a2a38-8e8f-4469-1b6d-08ddbad26356
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 08:11:32.8462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6HyYBCQiWW3KF25ZV1cSwwKAzBMjwgGTsgCfYoXJ8v+w2tYxaRHuxHxbIWjIWATqlodiQes/z5sJLJq1Xor8yhSzRksuFghdi231ANAb70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0794
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_MIME_MALF autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_DB9PR83MB0923715C769A4815ECC3D81A9242ADB9PR83MB0923EURP_
Content-Type: multipart/alternative;
	boundary="_000_DB9PR83MB0923715C769A4815ECC3D81A9242ADB9PR83MB0923EURP_"

--_000_DB9PR83MB0923715C769A4815ECC3D81A9242ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.

This patch allows to build winsup/utils/dumper.cc for AArch64.

Radek

---
=46rom 133c0eb7812c7b054e957f5706729fe38a99f066 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com>
Date: Wed, 11 Jun 2025 23:07:21 +0200
Subject: [PATCH] Cygwin: dumper: port to AArch64
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>
---
 winsup/utils/dumper.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 994f9b683..b3151e66d 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -700,8 +700,10 @@ dumper::init_core_dump ()
 {
   bfd_init ();

-#ifdef __x86_64__
+#if defined(__x86_64__)
   const char *target =3D "elf64-x86-64";
+#elif defined(__aarch64__)
+  const char *target =3D "elf64-aarch64";
 #else
 #error unimplemented for this target
 #endif
--
2.49.0.vfs.0.4


--_000_DB9PR83MB0923715C769A4815ECC3D81A9242ADB9PR83MB0923EURP_--

--_004_DB9PR83MB0923715C769A4815ECC3D81A9242ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-dumper-port-to-AArch64.patch"
Content-Description: 0001-Cygwin-dumper-port-to-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-dumper-port-to-AArch64.patch"; size=907;
	creation-date="Fri, 04 Jul 2025 08:11:10 GMT";
	modification-date="Fri, 04 Jul 2025 08:11:32 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxMzNjMGViNzgxMmM3YjA1NGU5NTdmNTcwNjcyOWZlMzhhOTlmMDY2
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFk
ZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNv
bT4KRGF0ZTogV2VkLCAxMSBKdW4gMjAyNSAyMzowNzoyMSArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIEN5Z3dpbjogZHVtcGVyOiBwb3J0IHRvIEFBcmNoNjQK
TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBj
aGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQK
ClNpZ25lZC1vZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBt
aWNyb3NvZnQuY29tPgotLS0KIHdpbnN1cC91dGlscy9kdW1wZXIuY2MgfCA0
ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvdXRpbHMvZHVtcGVyLmNj
IGIvd2luc3VwL3V0aWxzL2R1bXBlci5jYwppbmRleCA5OTRmOWI2ODMuLmIz
MTUxZTY2ZCAxMDA2NDQKLS0tIGEvd2luc3VwL3V0aWxzL2R1bXBlci5jYwor
KysgYi93aW5zdXAvdXRpbHMvZHVtcGVyLmNjCkBAIC03MDAsOCArNzAwLDEw
IEBAIGR1bXBlcjo6aW5pdF9jb3JlX2R1bXAgKCkKIHsKICAgYmZkX2luaXQg
KCk7CiAKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82
NF9fKQogICBjb25zdCBjaGFyICp0YXJnZXQgPSAiZWxmNjQteDg2LTY0IjsK
KyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisgIGNvbnN0IGNoYXIgKnRh
cmdldCA9ICJlbGY2NC1hYXJjaDY0IjsKICNlbHNlCiAjZXJyb3IgdW5pbXBs
ZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgotLSAKMi40OS4wLnZm
cy4wLjQKCg==

--_004_DB9PR83MB0923715C769A4815ECC3D81A9242ADB9PR83MB0923EURP_--
