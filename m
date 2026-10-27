Return-Path: <SRS0=0VMI=IR=microsoft.com=radek.barton@sourceware.org>
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by sourceware.org (Postfix) with ESMTPS id BD33E4BA23C2
	for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2026 08:45:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BD33E4BA23C2
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BD33E4BA23C2
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1793090743; cv=pass;
	b=BGGit7pd3Hqk9nHIjYOo+7JGrWuUJGOBJu7NoOAxvMMMlV7GclgAzheCyNPLjigH0NfGdDWchNRf4gQQLUW6eqHDGu7LVcb0daW72YioLx1XoROnzC9wWloTo4X7LUelyCC+6wqb9D7E8flHCn66bj8EckHK+fqj+UmDWvcB/fk=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793090743; c=relaxed/simple;
	bh=sc07YF2OVXqEqzaTBj55UtLsR7vm+sWKaM6T4Pllses=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=agHktpM1q629h4nPbjZJ2ViHqbfbXj1bBn0W6wgREb3zs0xELiumx3FkJiDW+5IkjTfAnSJ+5pVHnqnU9JfQZjO6vC9kO5wzlq8Z+iJcc8vL7D0aqlr2VKhmFK+JARwacDCmBn/pi2AdAS6Shb7fkiL8Thv6Y6JCxD5TkvgEy+A=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=I2TLGrGa
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BD33E4BA23C2
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=I2TLGrGa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyJkFyJWdQep/hCuiXbWAdxOGzCRBpSIIpsxHIIRQtdB3/h/JLkALF6inU0UxBKjkqgTp84lZFbhrf9SAIL0ziVLkv66frkFv9U3KiCUmewOwYIO2MBu8O6MUlOkSoEPkosbW9PSvn7/a8hGYm4MLPqTXAsFEBm9y0PZ6NlhIY22g1N+p5auZExuE41lxl2uAB4QE7f2XtJXGFIloafOnMCXWghCCubuleOaAANeD8Ro2Ov29AiEa25q2pSy80vq9kfj2H6i+UxTweuoA+p6bPnno5tQMSnz1xYK4zhSJWVMIXKRGJ7xplnt+fyYD74ckTtq9isvuqy3SC/X9o0XHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Is0tKSS4Q/qInoQS1BDAYH3Ymwwqt7LYCtkTqRqZEGg=;
 b=I5Shwf3vSiO0yMY7i++PPSCFJIgxLQDy2i6/L+giaIkbSGdHwAluVmzSp26xVNlhXYrmUFUMYPiAsH+ReMh9VAHESLyHcbnCQaS26bczjKG/lTCoUM4AnWwVRO6UP/6gqOM+0g0DSgeQLFN1fCOfjsXCgd5/qIuGh5VDsB7lu1W0RqpswesX09jC8EQJK8NKQow6ynqioiwnOk1Em5KmpJEteW1wqfiPAxUAn7QLZBB8Eil7L/N2IHF25tucKizptD4jymNbi34M8nQ/6LwX3LDzjl9pXZYKVC0WAY4jp0M2DdZsgVMMWxPhOwPgnHAalRW6OggC4fJ0s64yxeCAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is0tKSS4Q/qInoQS1BDAYH3Ymwwqt7LYCtkTqRqZEGg=;
 b=I2TLGrGaIPTIHoBErzymO6nvMcMOTc0+pqWiOYW/fkiVTc3vjRxgHROzTpP9284rN5uNkg575ca6NyShT0MHr4HgypAprVuNn5LpkOe2+Bi1kBh2K2bsgRgZYWiykMNPiHV0PbmXC6T1hSOyc6Qms5dx9ztD3xzDTBwkJsSsz3M=
Received: from PA2PR83MB0684.EURPRD83.prod.outlook.com (2603:10a6:102:414::14)
 by PA1PR83MB0823.EURPRD83.prod.outlook.com (2603:10a6:102:490::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Tue, 27 Oct
 2026 08:45:37 +0000
Received: from PA2PR83MB0684.EURPRD83.prod.outlook.com
 ([fe80::7d50:f527:22ec:27a8]) by PA2PR83MB0684.EURPRD83.prod.outlook.com
 ([fe80::7d50:f527:22ec:27a8%6]) with mapi id 15.21.0569.006; Tue, 27 Oct 2026
 08:45:37 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Evgeny Karpov
	<evgeny@kmaps.co>
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Thread-Topic: [EXTERNAL] Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Thread-Index: AQHb+leJWYkHtPC/6kWAlAvdD8KvlrcEhA6AgA9ldWY=
Date: Tue, 27 Oct 2026 08:45:37 +0000
Message-ID:
 <PA2PR83MB0684F9E66CCC064AF949112892602@PA2PR83MB0684.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
 <bd64e817-ffa8-4299-a3bc-6d1ff691ca9b@dronecode.org.uk>
 <aH5CvWENvjsmKbjJ@calimero.vinschen.de>
 <aH5EsVT1Hhe_7yHV@calimero.vinschen.de>
 <GV4PR83MB09410EFD509ABD23BDA49B18925DA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <f2b1fddd-b867-4eb9-bc41-add80cce54f4@dronecode.org.uk>
In-Reply-To: <f2b1fddd-b867-4eb9-bc41-add80cce54f4@dronecode.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-10-27T08:45:36.102Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR83MB0684:EE_|PA1PR83MB0823:EE_
x-ms-office365-filtering-correlation-id: e4b68063-92ac-4426-ea59-08df3406ac3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261026121527099003|38070700021|11063799006|4143699003|56012099006|7053199004|261022105027099003|261022075727099003|261021123027099003|261009223027099003|10067099003|7146999003|22082099003|18002099003|261026140227099003|8096899003;
x-microsoft-antispam-message-info:
 uoliMYJUv6YmqKvEYtsoVYT6abcgmIDPSMLUxxAa7i7TTu+U99WN+7pyhrNsiZytbP6+lNYRljaquEGZefnbeu18J25ZXhCGcovuaefmIon+CtsievLgk9At4k1lG22u8xewp6343jH/hZoyq7khHyxlGZ0gvP4d6NhAfBEfyRHfEW5L+rTcsQ9893OR8EAohcqwN2dBAzmp/xuOmVkOwKxISK+rilsqEZ1wKHuxacq3/yUQYq8ahi03qxrW1K+F7qxNQcahu+1q7G7ifqAtua2WTBlTT2eQ4Zm3ZagnT4ImtRmXNi8M9vEOUNz6bRdynKBzX4LmHL1pe31/TNSDUsvhOqDlteRdjEN69MI2aS2VtJwU2c/OnPHm7l3k6z0xciaQL8IhgYQjSr11WkJnMzTTH8ZaWohIqrxwYBS+HedVpL4XV/mrror5kkL/C1SVBVEfGncCWVHlv3W09+mBs8CONQru0QcxOfm8y58u3GAJ34oMYEW/Y+CvgKtCZmYq7jaznZUXy3VITA91OYKHHycR5X2OiyN0ISL/149lFMSZZixxoQNlHYy2LIJNtpB67bGZTk/HfTzpmDLQWmA/ZJYo+Go7uJy46pZAtQT7xgDBbfiUvJv0ftCAuC77f7A2BoubehpEFreoIhbQXiWXD65yeN2ccwrMqhfnmfPQgaoOKlAF+N9jRKAN3X9BVriW1baDdRniz/03YffzmsPwUks0ZRDAwp59PXYOvnMaZ1M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR83MB0684.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261026121527099003)(38070700021)(11063799006)(4143699003)(56012099006)(7053199004)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(10067099003)(7146999003)(22082099003)(18002099003)(261026140227099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/4r4D2D/nXqQ1AhkGFWiFN3MWzqSPw+nJvU6V7NLybfputHjjT8ziYjm5t7/?=
 =?us-ascii?Q?8XhNd0rD8PNFnYlloAWD3tGXPTkHNCVWc244Etu6Mi1/RYrTkWZD4k/rK8Rr?=
 =?us-ascii?Q?ldJKDzsTp5f/2DkQncUZ30hIa9lZRSLPghR0iqlWB5Tk6x4sLtREa/ZYI/0K?=
 =?us-ascii?Q?nB0+Gp1HBoIEhQlCGiThZcPIfbBw1n5I6Dwnvk7m6iJCzfKXd5D77Pwx/J+9?=
 =?us-ascii?Q?u2EmSEjyajwrnsghtC4fA9lUMLBH6yHnho/7dwInONfj26wV9nuPz6GKXP3h?=
 =?us-ascii?Q?x9et59zcv3jFWLVZ31nhzv5cPJhHekeHSi5Lp47X+alVVAqvzzEs9gkvO6QA?=
 =?us-ascii?Q?8IuIfWh70/+kuYaqI/vrmLT6sGQE3g17xUPGXMNZIIrm94Zx87vTWomjz9zU?=
 =?us-ascii?Q?p54nCKdbJLDd/yY4YKqVw43pdSRvnoyWDjGy0YZwVfHPttuw1Xp8SnwpEU5q?=
 =?us-ascii?Q?wGFWcZJmhUViYGvNcTgkbsAVyZPn2xskq1gCN5swV362HtnS2ICedsn94J5x?=
 =?us-ascii?Q?v24zdNPfqWd3m5GwsqTIzIUq/sAj25zftcGI8CrYsiYB4tDcGhVhNIymj0lz?=
 =?us-ascii?Q?rbSToUrGogUNOpvPLxsXrseB/H9NimD0/0xYpU1s02UBOvyLoB1JdOQ4md+G?=
 =?us-ascii?Q?PhaflzbDCpxTLYNNWURk3nUtDC12iehbYFPXcjVZV0JKf+aP4h9oM/NYtwoV?=
 =?us-ascii?Q?hKc2rnmx8zoheTfnE7z+gZyu4eNNtHQ7TbHH5fgKdv5Qa1dCDwhz+cbKCgZJ?=
 =?us-ascii?Q?p1bu5+/Kbwh5pXhFWsrJ3HP+/pE+ll59KHGB1tOFOTxXHdclwzNUc2qcK9r4?=
 =?us-ascii?Q?TOR27nLaHhm/1vJPaUmfQ3i6Wf73H+X+RQGgSmCapWvSCyoCpopKl21dMfUX?=
 =?us-ascii?Q?LTIkQYXj0DERxZl93S81cx2dVC/+/aizkCrqQjeIpyTJ5JjOczeni1xsQulx?=
 =?us-ascii?Q?xD1setM7lWocC6ecdPgcyn4y9MV9NsbF4I7GblgpB7JFZdb2ptHzEaDYjNj/?=
 =?us-ascii?Q?+VuA9mQmLweSZXbwjZggJ03mc+7bi+txJJyXF7AIuz6Exym3PLUrroT69PtO?=
 =?us-ascii?Q?Ur5L1FOfiEJFWj1PhUgOvSId2Xib/m8baDKp+4/AAp1nby+4XX2NcRf9jyli?=
 =?us-ascii?Q?ZANjDtyQdohjpfT55Z2LXiJtW/Tw+Ie0Vl17FlDUWzs/W8xoex/bXHi1qpDY?=
 =?us-ascii?Q?wFEUz227xkEcseDVxZ45hCJ4+Mc/TYdobZC9PNGqyJVpOr+cARIeQZp61yIf?=
 =?us-ascii?Q?6fJ+8N/R4RN8V14Ff6qvgjMlGHtS17NTm1/pSM7QjyGkJ+tXMlSM0WfFPEo3?=
 =?us-ascii?Q?tPEIxsC1iBni6ySAxhtGcKwo9T+mqy6PbyzBd+CvNofWhV5oO837G9iXyjav?=
 =?us-ascii?Q?pn6kTsHlWUfr3qkpYKo19KZJB48Qwt877dGlby37G7KpZ+w3qGeMq8vlicBl?=
 =?us-ascii?Q?YsUzegk+xT4FzlrmvfT5LC3GglcuorRHBLAGWb5pdZ+kzSINlF1YPO7c93qP?=
 =?us-ascii?Q?mLNF1bIVVwtrVXGx6lnX+2xaUle2NWOr9fZ7Sr9iy4SYDwIaFChhpVQp0kmw?=
 =?us-ascii?Q?8eZM7p7LKTkU0K+lSoBSaj6pndPDPZcWyqzRjlOEG4h0R9ekGwxK7aenqoE5?=
 =?us-ascii?Q?65rQODDKe2L3PkF87A2+moZHJHSsBCiwCuqPIcETsSpeR5CDzZmBG1qzHU9y?=
 =?us-ascii?Q?3YEHJA=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PA2PR83MB0684F9E66CCC064AF949112892602PA2PR83MB0684EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR83MB0684.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b68063-92ac-4426-ea59-08df3406ac3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 08:45:37.3799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 181fZi7ZyQFwu2Z6WA8iE/zGygIk1TZYvlG+U1dMuLD/QPOVX8UVs2VV4s5I6kDwaEXnR63p0s4jC4l5lGPNMGQcgRUiF1+UGpkhNNwoe0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0823
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GB_MSAUTHSOURCE_EUROPE,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PA2PR83MB0684F9E66CCC064AF949112892602PA2PR83MB0684EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello.

The code was produced as Microsoft's contribution to Linaro initiatives and=
, AFAIK, it was public-domained by sending them to the mailing list(s).

Please let me know if you need any other form of confirmation that this cod=
e is free to be used or re-used.

Radek
________________________________
From: Jon Turney <jon.turney@dronecode.org.uk>
Sent: Saturday, October 17, 2026 3:35 PM
Cc: cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>; Radek Barton <ra=
dek.barton@microsoft.com>; Evgeny Karpov <evgeny@kmaps.co>
Subject: [EXTERNAL] Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64

On 21/07/2025 16:53, Radek Barton via Cygwin-patches wrote:
> Hello.

Sorry to re-open this long-dormant discussion, but since we've actually
reached the point where we might soon be able to start distributing
binaries derived from this code, I think clarification is necessary.

> JFYI, my original thought was that the Signed-off-by header is serving fo=
r some sort of automation that will let maintainers create commit with that=
 person as a committer. Other than that, I am not aware of the cases where =
it could be handy to have different person being a committer and different =
person being the one who is granting the authorship rights.

OK, that's fine.  It's on us to explain what we expect it to mean, and
we haven't done that.

What we do need from both you, and Evgeny Karpov, is clear statement that:

1. To the extent that it is protectable, this (and all your other) patch
submissions for Cygwin are licenced under the 2-clause BSD license.

2. If this material was produced under a "work-for-hire" contract, your
employer has authorized that licencing.


Once again, I apologize for my extremely delayed response. I hope it is
straightforward for you to provide those assurances.



--_000_PA2PR83MB0684F9E66CCC064AF949112892602PA2PR83MB0684EURP_--
