Return-Path: <SRS0=UBKG=AM=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id 00A27484AA46
	for <cygwin-patches@cygwin.com>; Sun,  8 Feb 2026 19:30:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 00A27484AA46
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 00A27484AA46
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1770579015; cv=pass;
	b=w7m19JAPfE4RgCGfPJ+GoZfEqVIdIKVSWSeq1vGQ9pw4UNoH8xdNr4vp8EJn+JGjlbXbpqOHXEoilVspU4GSRj7fTnflC5iGqH/7+ZURDa3+kQx0zFZb13teQyJlz5CuI5lwBdhe/9KQuDfDbAjTeIwcO8y70jyZRZlbPv99D/Q=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770579015; c=relaxed/simple;
	bh=Hcw4dBOLpXuQN4p2WOywhve7DB0nZHN8a6aRkCHIpA8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=TvdExK1hl0wp4GzS0P+SOrfrzpmjuaWkIvnewTnH2TX4o6v2mmRuCO0qs1NrdZ7+LxaBcvQ+Q6Gfvlvnt5nNskVLQgigIAppwkQ1ZciuoHaXmMV/iAEMfjnDvJoTXpZIJK6PmJsPFijgV0zY6FYneB6TeQRq1l0ft/hjd1ZAFM4=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 00A27484AA46
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=FuO2Qfqh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmLz7mMj5aKh/HG2PcYO6WrF5hPfgGdYnRtj5nbAUs9VEK9bW9elyHc57sCVWreib4Vwoq47CB3bKI8m9RMiYyeEs5HrBiR2y1xKjyayl8xX+eEAO0SPfvyuXkyJ/gEpjmKBK5QDWE/Rzi0/nPnJvIf9CHJuXEjW1EAIwKkM6ZppP9xlU5jPffayt7DXjhZCOQgOBj1zMNYuIBPLewlq3GGb4/8PnI8FcG4L16ZkQogS9f37KOiaDxjUa3gYTP91/gyO8GwEM1Sm6639WeAZVZD92h9MhY6E/XOWp4SxV6CCuXdGW4VeH4b1s7OZGJV4S66v14yJEZzRSUoQI8ofJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG0lj1Adzl+uQM5VdY3IFbt2PMnWqTTDxg1ka6JTt84=;
 b=Hh5o45MSKjSS18kteXLyKmkxyv3mVHX4iol8jY3dOxISHDd/mZ9LCwijSRSFfF6O0/GWx7d7j+0t3O5BioZomxZqc0Kecdn9JI/yE61nV60fIYjob9oXQShNOVGvQt1HGmNQUsk1fnug9R/WBU0HfpxqEnzxh10bxvdO3cg9lUkVPyDM/A2ZTsYdx7S7/ZeszWs05/M3mEiP11dRUse0e3bUpH4I/nhSu5ZEAnrUND5vYQRFTij2WRPD3N1jZ6fLjRk4Ljy2Wftou682/u5GoZkI2Uv/NBMN5YnCOASRUaFgSBN1OjGzG9i1sU3N8yIwx38Gu8dRtGOcO4joxJF8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG0lj1Adzl+uQM5VdY3IFbt2PMnWqTTDxg1ka6JTt84=;
 b=FuO2QfqhcKbw1xJxDEAaGC1w//b5NH0hCUo7fUUuLWiR2htrYBLDzXHD2MLW9bv5rq6smNU4poXZhdJSVKyOxTuWDNlKU0I+bcvFc1wiLqkSi+wRsCHi1cLToSEZP/pEVykB/6xnHvn2WeWY602PaF5I/fs8qUAY1bmrbKR4SwRInHa5UNZgWSaZto0jvIm0wHpqDarSMp7zwVWZP4+hilxlvdCLd05gR3oqWjMbmwDcAXe8ycbNEEi3pTcfRcUrjh+WhBjZLH5Sk+WIwzp9cXuBG3qsMY/Maf26EtPfsLQ7VniYTYNAZcGOIAD7f0o+BISMdC01uJYEYAxLJOnMqw==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN1P287MB3822.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:256::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.6; Sun, 8 Feb
 2026 19:30:02 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9611.005; Sun, 8 Feb 2026
 19:30:02 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: autoload: add AArch64 build stubs
Thread-Topic: [PATCH] Cygwin: autoload: add AArch64 build stubs
Thread-Index: AQHcmSsQJsh8Aqq+c02bzBFQRQyIVQ==
Date: Sun, 8 Feb 2026 19:30:00 +0000
Message-ID:
 <MA0P287MB308279638B643DD1456BEFEC9F64A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
undefined: 4243805
drawingcanvaselements: []
composetype: newMail
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN1P287MB3822:EE_
x-ms-office365-filtering-correlation-id: 851b5554-437e-4488-9a0a-08de67487488
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|6049299003|1800799024|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mN/XPGjXTyuixkE0Rn4aJxDGbG9T7Zdjf9HAtjrk/1uaQxGFFlvtmvfGqh?=
 =?iso-8859-1?Q?hdLCS2h1eLAsRwU9pQWvwA9mXv8z+8RQ9imp0gmCMrRIksnW76fKiX+DTA?=
 =?iso-8859-1?Q?JiNAFYCMthntZy/FRlrQMa4xB7gfYRltgltbVQMjQ9wyzgY2/JKS/FQZpN?=
 =?iso-8859-1?Q?G+zRCU6fdP6E4OAwS400YcrrvUeYvfNe0SKMtM9ikhp23+WZY41IZ9fX5+?=
 =?iso-8859-1?Q?5thFE8NfQTDmESs+fbKeBu4j75kZT1py1IXLMoQ5yQ8EnUXnqBjTKMszgq?=
 =?iso-8859-1?Q?o+0+vtJGR0F01GoR2L/0/eIZgc6PfCtGmV6I9ifLqMzeJo+VOhdzjuFhFM?=
 =?iso-8859-1?Q?h1p3HLTBHnCyd3UwSkmTJ+jTBEM0ggUY01KC6LF3aBQ2X6uEL62XpRUgvx?=
 =?iso-8859-1?Q?2WW8KZ5dCrDKIqWK7bazwDWtK/6wn12T4vQ2unUZmnL097LrHe5F65Goth?=
 =?iso-8859-1?Q?/cEnviVzaZQlEionu7dSKmVB5ILPFJp9nQgXgKNBdyqlPC6wFCb3rasf3i?=
 =?iso-8859-1?Q?cRi+8tnvE3E6pJde8Dd+gah4IA+JV8eHVTCKvex5iSaeL7ux21uKCOUC9v?=
 =?iso-8859-1?Q?sWuu120VXEEQU1Sg3aRshRM6ZSbp6i//BhkAOHJJg68H6ejQffwtJxI0cI?=
 =?iso-8859-1?Q?GVpHZw5GiYsSxdeU9IkXJW3e9Azt4RJ7Yi0C3QfgFcZV8XmC/5uOyburZu?=
 =?iso-8859-1?Q?EdoPm6xJVZoTQATpGvdPIto63Om5pjFDO+nR4nzudG1/+v4cIv+UkzWUSv?=
 =?iso-8859-1?Q?MoyMd1yT9rIPSLMwAR5MS2nQhZSEN0cyAWD5hnopfMHzR+a8M+bfIHkpM6?=
 =?iso-8859-1?Q?Dg7BjzSBv8x12+yKmjy2el3DB7yGriHwySHxNspk/0+QQ+pSpDP7SJJ8Ll?=
 =?iso-8859-1?Q?0rb+4RhYjn+ZS+acb6qIeCDlHTcF97B9W+NhGmzK9HIrvWeJRSWYPbg45G?=
 =?iso-8859-1?Q?qiv+nsAH/1sS5+nYE0Nn5TKxBPNUs5iJ+2jDJNOts4u9Qe4Cx4PgBGIDNm?=
 =?iso-8859-1?Q?FqW5Eq85M5zRt3QW1xZUh31evr4GhUvuR1++mGRLqD/HqTLSyBgsvTetBJ?=
 =?iso-8859-1?Q?ZxpmFzUJG/GpgNfj0JTzBlTGJMUYu9S3PqEgMqgJl8T2jyFPtTcUK0tteO?=
 =?iso-8859-1?Q?vmPFLGzR1O/P/h2Vn7zd0Fyk/WIUpUcA1XDBzYDF3492vhzj/2lruaCWCr?=
 =?iso-8859-1?Q?07hFcTmx1R5U+TWoV3jflqb5tNJ8LW3sEQW+DDzYJ15/39VwBRBT8g8I0T?=
 =?iso-8859-1?Q?D2Q35FPzElawCgfHT/qzxkNOg0gsbR385d5tMugje9rhPN0jdgjmsCl7Gh?=
 =?iso-8859-1?Q?AGUyT+BetMU8vQDZWPwD+w4QUw6tweTA/S91h6+i+/NFVJ7P0F43ZRURFM?=
 =?iso-8859-1?Q?K0gSYIwfiNgmmA8tvQwhFpyGhEIgrOWNkUPz5L31iKHO/ILewGwFyHalIK?=
 =?iso-8859-1?Q?nS2XNZ4uZI+Ob0qyVXbZUl+7ScqrpNWgrnXy0oKVM9pIRw12kx+7eIRJF7?=
 =?iso-8859-1?Q?JQOPd3cxFieFKY5polFj/ao2SFLu2MJ2gPA4nYNLY+osRHOVeOHTQjtgQq?=
 =?iso-8859-1?Q?OuP+y71gPT3xy7mxwMhshYPZbThJ/bWiSQSbjJyukC85MmH/P+Otyq9hKH?=
 =?iso-8859-1?Q?80CiH7bO0Rc2XxDWsu0nczqf1l107Xg5jIiKyfDZwf3QoZ8wvH1GRC3250?=
 =?iso-8859-1?Q?p8XBAVs212EYHdaGmek=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(6049299003)(1800799024)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pDbO3FJh+QfIf7ySE1QeNL91LUk3OBqlEhEQ1RNg6UCqDZz/jsF0kpeSRW?=
 =?iso-8859-1?Q?ImKeLLUl0faCrYdnx9VeDJ2alsYbgr+BRTu7z7BtX2k73JqvAWa2A+egjT?=
 =?iso-8859-1?Q?pdmD7W3Z9WFWgb/X9hE8NnhTwUPsAkupM7eMTewqpEiFyrnnu73zRw2TF1?=
 =?iso-8859-1?Q?qi2QBexxUI3lkqYrALx7cpYJ8r1IWUSxMAJIxfuWvXn/o6Vc4+YMkWubw3?=
 =?iso-8859-1?Q?yUwcBYsXkiiG2E9sNBOspZZRwgjKfQrq4s72SpCGnh06Xtxo1IodtqwQ/b?=
 =?iso-8859-1?Q?gWY9GQXOGbd9oWb4VwPrbw77exgkg0YNnLHf1D5LDgOFNnnd1pLAgz4GjC?=
 =?iso-8859-1?Q?MizEgogBb3RujsYjccPsP2kEXX2eiuqcU8QF1waDkebvQmMNHH61HJIMkc?=
 =?iso-8859-1?Q?bYPh9Si3JLdTh2sb/yW3pQkzaMBNo6rT2a72XyJBwAxmEJ8KkGF6ezO8d9?=
 =?iso-8859-1?Q?CP7DLmbnYBcdyerJsVdNemRwTYwNgj/bXmQ7dgqe6OIWDXO+UFpRZ0rPXt?=
 =?iso-8859-1?Q?xadazCFsuzWgzLlAXR2aqb+og6rd7+NMxM6RRSoFE1F40NyD3G3CLq+taZ?=
 =?iso-8859-1?Q?Z+N/5Z3WZBujXgW9NewXIedvUkSHw9N8hTiem2Qyps+5pXP0/SOC2EQNw0?=
 =?iso-8859-1?Q?fOCf31Xxbaa0qArnCol5bXRjUyxCiriof4wR/Kgr9az/3Zyzj0+mpVa7Bn?=
 =?iso-8859-1?Q?4H14CmVz3rdgUbswANkeyU+69rXM5J03pq2tgW6b6GkR3O39RLJxiH7TcD?=
 =?iso-8859-1?Q?AsIbqJ593cJo1lp/uI4WTCekN0sYOiwIQaUSmBBfja/MRl2sOjXyeuxX43?=
 =?iso-8859-1?Q?bOGBp47TgjCAxmTt0FMupUW2zjYNIq3ojiTZmdUv3F8twJvFa7MAKNdMXG?=
 =?iso-8859-1?Q?MOgRPKmXmcPi5W0ZqrJ8ihpN5EmI7YaJAIeOksqs45M0Og0jOP67XTNrFw?=
 =?iso-8859-1?Q?44M3ChueviGt8P3VB/gcnWe1PkCUHS8FdtuWxFITkTzb7u7xTB8SSQlyoD?=
 =?iso-8859-1?Q?/hRr4EXJxHUxpdbFAwBYDZD2Y4QRQQ0xfz4L9qGt19/qbE6RJ01MaEeogu?=
 =?iso-8859-1?Q?tLi/clKnRSDdjmTQfjy1bMEOHUGKdJmdHn/w9UznF2D1wne8gjL0F9AoSX?=
 =?iso-8859-1?Q?hvu4nlb83/IpcfrYwX46rFfWyJFtPOcVQnle/k2T9LRN0LB11Y3ExKiQEI?=
 =?iso-8859-1?Q?byawuFyaJexiyb5u30hxCefkVVf1TVq4aOzK9hFWIO4YFr2vWWMlgihpDA?=
 =?iso-8859-1?Q?BkrhsG3LyOYKoeqoDTd8tu43TVF2Bj0fkLzc8AGhpmfEsQtv0Wkq2DqXuh?=
 =?iso-8859-1?Q?3doRjr4wgK92p8L9BPfAoTTmMN4MlxROb9WGn//FcQtuCNKNfcfzwhRhRx?=
 =?iso-8859-1?Q?6xiMMUI/XbBL2zlz6flTt6E2vpEmhwmHKqxXUcNJj1YyqEnh/epu1TIxih?=
 =?iso-8859-1?Q?1LGkGl+2qgLSahJAjpT89Df+AFOfvurN5251NrOZnFX2R+BPdElwVhIgg6?=
 =?iso-8859-1?Q?IwscrrvgKgehq1cq1jpom4KgeJhchVT5i+mSxqv6zJXVDqKnTagtLt8g7e?=
 =?iso-8859-1?Q?Vy+KiONc3imAkEt3hhecqyXyzefq9a1Yuzz05TUXhVS+ohjNaL0tvWL7uN?=
 =?iso-8859-1?Q?3L4aLEHv9cA0/Y/U3tUlNoiOIfh2kGyjpDxwUHICNg93MS4DWcvLWAQmxN?=
 =?iso-8859-1?Q?CnFlRpXEXF/Qt5IW5RVTy4Oi05uWwxMfgoBnlZUI8/d8vcekS2u3N+wcow?=
 =?iso-8859-1?Q?XZvHcofpmN5CfePl7FNU9DkUIurhMPXpFqcoQU4Cp8OcXRD+QzVa8pKO7C?=
 =?iso-8859-1?Q?NI5NsrOoC+9kiMXhgvLppa3BPfCYPJIVjliIUWt2Bw0nG4wHrQXmOOvy4W?=
 =?iso-8859-1?Q?tq?=
x-ms-exchange-antispam-messagedata-1:
 eerVu9pudjEBDlkgmZJE/5zC3ZtjooHTNL6wIXY4Dh5TLTcyG+h3F7MKZLiI+LHFuXyA4yYP6/l+0A==
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB308279638B643DD1456BEFEC9F64AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 851b5554-437e-4488-9a0a-08de67487488
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2026 19:30:02.2987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aO4R7bUzAAyuNKvgGl7BYLjGSUCoIlHqNK8yuKeaTW+xiwofDyRVxEi3KcuAxeezFylK9N0N8qoslUnMy2isWjlBatgoGZ62xqoHkwhdwaXqc//oAXUkWt9ltmqlMYZ1sOsf3e/P+zbqnvelxRe5tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3822
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB308279638B643DD1456BEFEC9F64AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB308279638B643DD1456BEFEC9F64AMA0P287MB3082INDP_"

--_000_MA0P287MB308279638B643DD1456BEFEC9F64AMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
This patch adds minimal AArch64 stubs to winsup/cygwin/autoload.cc to
allow the file to compile as part of the ongoing Cygwin AArch64 port.

  *
Conditional handling for aarch64 is introduced alongside
existing x86_64 code paths.
  *
Empty inline assembly placeholders are provided for LoadDLLprime,
LoadDLLfuncEx3, dll_chain, and INIT_WRAPPER.
  *
No functional implementation is provided.
  *
These stubs are intended solely to unblock the AArch64 build and
will need to be replaced with proper AArch64 asm implementations
in a future follow-up change.

Thanks & regards
Thirumalai Nagalingam
In-Lined patch:
diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index a038997b3..c8b0c2584 100644
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
 .ifndef " #dllname "_primed                            \n\
   .section     .data_cygwin_nocopy,\"w\"               \n\
@@ -83,6 +83,9 @@ bool NO_COPY wsock_started;
   .set         " #dllname "_primed, 1                  \n\
 .endif                                                 \n\
 ");
+#elif defined(__aarch64__)
+// TODO
+#define LoadDLLprime(dllname, init_also, no_resolve_on_fork) __asm__ ("");
 #else
 #error unimplemented for this target
 #endif
@@ -97,7 +100,7 @@ bool NO_COPY wsock_started;
   LoadDLLfuncEx3(name, dllname, notimp, err, 0)

 /* Main DLL setup stuff. */
-#ifdef __x86_64__
+#if defined(__x86_64__)
 #define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
   LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) \
   __asm__ ("                                           \n\
@@ -123,6 +126,10 @@ _win32_" #name ":                                  \n\
   .asciz       \"" #name "\"                           \n\
   .text                                                        \n\
 ");
+#elif defined(__aarch64__)
+#define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
+  // TODO
+  LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) __asm__ ("");
 #else
 #error unimplemented for this target
 #endif
@@ -141,7 +148,7 @@ extern "C" void dll_chain () __asm__ ("dll_chain");

 extern "C" {

-#ifdef __x86_64__
+#if defined(__x86_64__)
 __asm__ ("                                                             \n\
         .section .rdata,\"r\"                                             =
     \n\
 msg1:                                                                  \n\
@@ -203,6 +210,8 @@ dll_chain:                                             =
             \n\
        push    %rax            # Restore 'return address'              \n\
        jmp     *%rdx           # Jump to next init function            \n\
 ");
+#elif defined(__aarch64__)
+  // TODO
 #else
 #error unimplemented for this target
 #endif
@@ -260,7 +269,7 @@ dll_load (HANDLE& handle, PWCHAR name)
 #define RETRY_COUNT 10

 /* The standard DLL initialization routine. */
-#ifdef __x86_64__
+#if defined(__x86_64__)

 /* On x86_64, we need assembler wrappers for std_dll_init and wsock_init.
    In the x86_64 ABI it's no safe bet that frame[1] (aka 8(%rbp)) contains
@@ -300,6 +309,12 @@ _" #func ":                                           =
                     \n\

 INIT_WRAPPER (std_dll_init)

+#elif defined(__aarch64__)
+// TODO
+#define INIT_WRAPPER(func) __asm__ ("");
+
+INIT_WRAPPER (std_dll_init)
+
 #else
 #error unimplemented for this target
 #endif
@@ -360,7 +375,7 @@ std_dll_init (struct func_info *func)

 /* Initialization function for winsock stuff. */

-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__aarch64__)
 /* See above comment preceeding std_dll_init. */
 INIT_WRAPPER (wsock_init)
 #else
--



--_000_MA0P287MB308279638B643DD1456BEFEC9F64AMA0P287MB3082INDP_--

--_004_MA0P287MB308279638B643DD1456BEFEC9F64AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="Cygwin-autoload-add-AArch64-build-stubs.patch"
Content-Description: Cygwin-autoload-add-AArch64-build-stubs.patch
Content-Disposition: attachment;
	filename="Cygwin-autoload-add-AArch64-build-stubs.patch"; size=3858;
	creation-date="Sun, 08 Feb 2026 19:04:00 GMT";
	modification-date="Sun, 08 Feb 2026 19:04:07 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0NDUxNDcwNDg0ZDEzYzUwMDM1MDE0MGVlNjYyNzM0OTJkNWNhYzEx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU3VuLCA4IEZlYiAyMDI2IDE2OjQ5OjU4ICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBhdXRvbG9hZDogYWRkIEFBcmNo
NjQgYnVpbGQgc3R1YnMKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBl
OiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXIt
RW5jb2Rpbmc6IDhiaXQKClRoaXMgcGF0Y2ggYWRkcyBBQXJjaDY0IHN0dWJz
IHRvIGB3aW5zdXAvY3lnd2luL2F1dG9sb2FkLmNjYAp0byBhbGxvdyB0aGUg
ZmlsZSB0byBjb21waWxlIGFzIHBhcnQgb2YgdGhlIEN5Z3dpbiBBQXJjaDY0
IHBvcnQuCgpJdCBpbnRyb2R1Y2VzIGNvbmRpdGlvbmFsIGhhbmRsaW5nIGZv
ciBfX2FhcmNoNjRfXyBhbG9uZ3NpZGUgZXhpc3RpbmcKeDg2XzY0IGNvZGUg
cGF0aHMsIHByb3ZpZGluZyBlbXB0eSBpbmxpbmUgYXNzZW1ibHkgcGxhY2Vo
b2xkZXJzIGZvcgpMb2FkRExMcHJpbWUsIExvYWRETExmdW5jRXgzLCBkbGxf
Y2hhaW4sIGFuZCBJTklUX1dSQVBQRVIuCk5vIGZ1bmN0aW9uYWwgaW1wbGVt
ZW50YXRpb24gaXMgcHJvdmlkZWQsIHRoZXNlIHN0dWJzIHdpbGwgbmVlZCB0
byBiZQpyZXBsYWNlZCB3aXRoIHByb3BlciBhc3NlbWJsZXIgaW1wbGVtZW50
YXRpb25zIGluIGEgZnV0dXJlIGNoYW5nZS4KClNpZ25lZC1vZmYtYnk6IFJh
ZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWku
bmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KLS0tCiB3aW5zdXAv
Y3lnd2luL2F1dG9sb2FkLmNjIHwgMjUgKysrKysrKysrKysrKysrKysrKyst
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9hdXRvbG9h
ZC5jYyBiL3dpbnN1cC9jeWd3aW4vYXV0b2xvYWQuY2MKaW5kZXggYTAzODk5
N2IzLi5jOGIwYzI1ODQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vYXV0
b2xvYWQuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9hdXRvbG9hZC5jYwpAQCAt
NjcsNyArNjcsNyBAQCBib29sIE5PX0NPUFkgd3NvY2tfc3RhcnRlZDsKIC8q
IExvYWRETExwcmltZSBpcyB1c2VkIHRvIHByaW1lIHRoZSBETEwgaW5mbyBp
bmZvcm1hdGlvbiwgcHJvdmlkaW5nIGFuCiAgICBhZGRpdGlvbmFsIGluaXRp
YWxpemF0aW9uIHJvdXRpbmUgdG8gY2FsbCBwcmlvciB0byBjYWxsaW5nIHRo
ZSBmaXJzdAogICAgZnVuY3Rpb24uICAqLwotI2lmZGVmIF9feDg2XzY0X18K
KyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAjZGVmaW5lIExvYWRETExwcmlt
ZShkbGxuYW1lLCBpbml0X2Fsc28sIG5vX3Jlc29sdmVfb25fZm9yaykgX19h
c21fXyAoIglcblwKIC5pZm5kZWYgIiAjZGxsbmFtZSAiX3ByaW1lZAkJCQlc
blwKICAgLnNlY3Rpb24JLmRhdGFfY3lnd2luX25vY29weSxcIndcIgkJXG5c
CkBAIC04Myw2ICs4Myw5IEBAIGJvb2wgTk9fQ09QWSB3c29ja19zdGFydGVk
OwogICAuc2V0CQkiICNkbGxuYW1lICJfcHJpbWVkLCAxCQkJXG5cCiAuZW5k
aWYJCQkJCQkJXG5cCiAiKTsKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18p
CisvLyBUT0RPCisjZGVmaW5lIExvYWRETExwcmltZShkbGxuYW1lLCBpbml0
X2Fsc28sIG5vX3Jlc29sdmVfb25fZm9yaykgX19hc21fXyAoIiIpOwogI2Vs
c2UKICNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2Vu
ZGlmCkBAIC05Nyw3ICsxMDAsNyBAQCBib29sIE5PX0NPUFkgd3NvY2tfc3Rh
cnRlZDsKICAgTG9hZERMTGZ1bmNFeDMobmFtZSwgZGxsbmFtZSwgbm90aW1w
LCBlcnIsIDApCgogLyogTWFpbiBETEwgc2V0dXAgc3R1ZmYuICovCi0jaWZk
ZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKICNkZWZp
bmUgTG9hZERMTGZ1bmNFeDMobmFtZSwgZGxsbmFtZSwgbm90aW1wLCBlcnIs
IG5vX3Jlc29sdmVfb25fZm9yaykgXAogICBMb2FkRExMcHJpbWUgKGRsbG5h
bWUsIGRsbF9mdW5jX2xvYWQsIG5vX3Jlc29sdmVfb25fZm9yaykgXAogICBf
X2FzbV9fICgiCQkJCQkJXG5cCkBAIC0xMjMsNiArMTI2LDEwIEBAIF93aW4z
Ml8iICNuYW1lICI6CQkJCQlcblwKICAgLmFzY2l6CVwiIiAjbmFtZSAiXCIJ
CQkJXG5cCiAgIC50ZXh0CQkJCQkJCVxuXAogIik7CisjZWxpZiBkZWZpbmVk
KF9fYWFyY2g2NF9fKQorI2RlZmluZSBMb2FkRExMZnVuY0V4MyhuYW1lLCBk
bGxuYW1lLCBub3RpbXAsIGVyciwgbm9fcmVzb2x2ZV9vbl9mb3JrKSBcCisg
IC8vIFRPRE8KKyAgTG9hZERMTHByaW1lIChkbGxuYW1lLCBkbGxfZnVuY19s
b2FkLCBub19yZXNvbHZlX29uX2ZvcmspIF9fYXNtX18gKCIiKTsKICNlbHNl
CiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRp
ZgpAQCAtMTQxLDcgKzE0OCw3IEBAIGV4dGVybiAiQyIgdm9pZCBkbGxfY2hh
aW4gKCkgX19hc21fXyAoImRsbF9jaGFpbiIpOwoKIGV4dGVybiAiQyIgewoK
LSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQog
X19hc21fXyAoIgkJCQkJCQkJXG5cCiAJIC5zZWN0aW9uIC5yZGF0YSxcInJc
IgkJCQkJCQlcblwKIG1zZzE6CQkJCQkJCQkJXG5cCkBAIC0yMDMsNiArMjEw
LDggQEAgZGxsX2NoYWluOgkJCQkJCQkJXG5cCiAJcHVzaAklcmF4CQkjIFJl
c3RvcmUgJ3JldHVybiBhZGRyZXNzJwkJXG5cCiAJam1wCSolcmR4CQkjIEp1
bXAgdG8gbmV4dCBpbml0IGZ1bmN0aW9uCQlcblwKICIpOworI2VsaWYgZGVm
aW5lZChfX2FhcmNoNjRfXykKKyAgLy8gVE9ETwogI2Vsc2UKICNlcnJvciB1
bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCkBAIC0yNjAs
NyArMjY5LDcgQEAgZGxsX2xvYWQgKEhBTkRMRSYgaGFuZGxlLCBQV0NIQVIg
bmFtZSkKICNkZWZpbmUgUkVUUllfQ09VTlQgMTAKCiAvKiBUaGUgc3RhbmRh
cmQgRExMIGluaXRpYWxpemF0aW9uIHJvdXRpbmUuICovCi0jaWZkZWYgX194
ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKCiAvKiBPbiB4ODZf
NjQsIHdlIG5lZWQgYXNzZW1ibGVyIHdyYXBwZXJzIGZvciBzdGRfZGxsX2lu
aXQgYW5kIHdzb2NrX2luaXQuCiAgICBJbiB0aGUgeDg2XzY0IEFCSSBpdCdz
IG5vIHNhZmUgYmV0IHRoYXQgZnJhbWVbMV0gKGFrYSA4KCVyYnApKSBjb250
YWlucwpAQCAtMzAwLDYgKzMwOSwxMiBAQCBfIiAjZnVuYyAiOgkJCQkJCQkJ
XG5cCgogSU5JVF9XUkFQUEVSIChzdGRfZGxsX2luaXQpCgorI2VsaWYgZGVm
aW5lZChfX2FhcmNoNjRfXykKKy8vIFRPRE8KKyNkZWZpbmUgSU5JVF9XUkFQ
UEVSKGZ1bmMpIF9fYXNtX18gKCIiKTsKKworSU5JVF9XUkFQUEVSIChzdGRf
ZGxsX2luaXQpCisKICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3Ig
dGhpcyB0YXJnZXQKICNlbmRpZgpAQCAtMzYwLDcgKzM3NSw3IEBAIHN0ZF9k
bGxfaW5pdCAoc3RydWN0IGZ1bmNfaW5mbyAqZnVuYykKCiAvKiBJbml0aWFs
aXphdGlvbiBmdW5jdGlvbiBmb3Igd2luc29jayBzdHVmZi4gKi8KCi0jaWZk
ZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykgfHwgZGVm
aW5lZChfX2FhcmNoNjRfXykKIC8qIFNlZSBhYm92ZSBjb21tZW50IHByZWNl
ZWRpbmcgc3RkX2RsbF9pbml0LiAqLwogSU5JVF9XUkFQUEVSICh3c29ja19p
bml0KQogI2Vsc2UKLS0KMi41My4wLndpbmRvd3MuMQoK

--_004_MA0P287MB308279638B643DD1456BEFEC9F64AMA0P287MB3082INDP_--
