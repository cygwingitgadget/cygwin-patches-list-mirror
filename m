Return-Path: <SRS0=c1qK=7V=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 8AB984BA2E1C
	for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 17:41:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8AB984BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8AB984BA2E1C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1768585305; cv=pass;
	b=QfUOge0a82jbj0SVCQoQ4yu1v8XqzaQlYTl2NPdG9vnKi0XdZrXR2xhJGfdMhZlHwdgQpxg0QhsKqqTETvV2i3y8lvFnkdMKtXtjscsvJWC6Zz2a1cKCU9oiLOGsUwAVqAFN2fZE5NtOTkL9TzckBrUNCIblu2khxGz6eP5FnuI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768585305; c=relaxed/simple;
	bh=Ym+a+xVVIh3NccsJnMWPpVNDi9zhGmwWn+OuzSsvA7M=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=olIHnQLl4WcpjcKV0Oln9XYQo/Ggh9NbuH+bY/b1aaGB+tXt+qo/kHl/FhPIr52wLC59x74iuble6m4qaUYO0T8x9KWp54roieViA5igtXla/NwdjhNDIRIAw8aomTZa2lFHp/dltA6UdcYvhceIQRwQsp7/wR7RciIkbzGL5sQ=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8AB984BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=aQMs60SN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9vj36ZK2ME5S0hdsAXgrGSwjzZ7+6weXk1lJxRscgK/6mHm/PaQTFXceSw5rJOD2GsZ0Va827nxGg5pUCyQ58psBEiPmryhW/xT/PhCZLWwMbu1M32fYopB0fHIpJOVImVrGoQtDudHAnbGts9+u7zQyx5k3ASvK4ZZZqbb/G1wYQbem1nZL2CrX3B5xW89XKbgjjVoK2pqRMcPRRt9y0XWRPhJiV5t9v4x3pv8/Za2OliQhgedBorX6glKtQ8qMO0HOrWsIvGj8iJb7UoJpId8B2q4t6IH0CyG9gkEdQuqnkfY0WUyyJqWi2xlipJPHxyJigfb0yQasXTtQTYSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFky38hDk++0PQzSGQfqkbGFGGmNGjqkxrox46ORa/o=;
 b=MSQcvtCMyWCYknxq/JaYQ/qknDlS5FLZptTm6VBRntywckgA7cXXgyvH6zqqLsmt3ZHJm12wASopsCnTjhTECqbJuFxNDG3oYxMi6KjlFJuRcg9O6A3cw8BzNNObijLk3lMhfqTPsh3y4+S845u9r4a2IOsAUBfPf9FUQpYELsbkvWE3Tol0txeXlR0yvWI0TG3KhPROW222kfUQjzPAmVGWA6aId/UzfH+DHrcJCOQAJS+DzsVyK54KHjIzrZEpS4d5aLgxJi+l92tv4UzTINOXS7gZMu2LpKdqQ3GP5I+msGkpnUoQTdl3JyMo2g79HPh0ehSxq9IMOjgWPODiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFky38hDk++0PQzSGQfqkbGFGGmNGjqkxrox46ORa/o=;
 b=aQMs60SNgqn6DSKd/n7yRlMzKuPoKDh7ycAYrp/I6tWuAL9EjNLNOhIs12TLWJZrmAymtg8iBhfRLpBCDVxiaCuGDUC9PlaMBKjkAurmWdsrDlgBAt05rjYyaYfaFlb/6DESc0VxYEGXRZzv0U5ACweChbukdBzIv2jdV87Wqn6GRMM/39LzJ+gEtnxJ9hq9cVOJtT8qhIkjDGIbV2dJl3pAlhdfibChpYffzt5Wg3daXTeW9DhnLcmeby2vlO9VWuyq3D6cgidw3AiKmEv+hdpZrci/71RCM6CQLiKvq1ruhbUJUC5pkBtKlVL/CUWMEGmfdGXZf6mqtMQHv6aPjw==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA5P287MB5204.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.5; Fri, 16 Jan
 2026 17:41:38 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%3]) with mapi id 15.20.9542.003; Fri, 16 Jan 2026
 17:41:38 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH V2] Cygwin: gendef: Implement _sigfe function for TLS handling
 on AArch64
Thread-Topic: [PATCH V2] Cygwin: gendef: Implement _sigfe function for TLS
 handling on AArch64
Thread-Index: AQHchw9dsSsi3JsoxkeJq3lhTi6cOQ==
Date: Fri, 16 Jan 2026 17:41:38 +0000
Message-ID:
 <MA0P287MB30828B5A7845AF3B4776382B9F8DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082B91F52855CCC343FEEF99FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB3082B91F52855CCC343FEEF99FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA5P287MB5204:EE_
x-ms-office365-filtering-correlation-id: be32b642-9690-40cc-ccef-08de5526806c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|8096899003|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZT0wO3dWOzeeNQAi1TtM8EXKUdel5o0YfJqvvK3PjQj6LQfekf9wz+g78Z6y?=
 =?us-ascii?Q?OYyV1hsVus+XdYhOWj4ZZ0sM92bGz0Y/KrmNikzy0KEotSNdKO8IpiNcW0Im?=
 =?us-ascii?Q?CA9Y/UY0bSujmEQ5SjCiDFa36byk3I3Qjxs79gAzUMXzRX8cKLU1f7Klxx0L?=
 =?us-ascii?Q?oMuAy+0WtlF5Gh0r0SDsTlUcZbA/nIUCx/Uj/gvnqzqSPt87mp/7QmgDRyz9?=
 =?us-ascii?Q?O5E+CsOaBbiHm+AD/5xO+kR/PlQ7Uc7/rslZKaGJ/6UrUI/polMAFTKg8ODW?=
 =?us-ascii?Q?RG2jKDopXdaTTIFyCShvY/N44eqaN7yZYKZODTTV+uqgKma+SMypAF1R5s9F?=
 =?us-ascii?Q?+V5SgvlBjfFshUlnV5RiJExzJHu1a44wpf34zLxl/YAnpeht5JKEvGwua+4O?=
 =?us-ascii?Q?mpZwauHSXKILXITuiaYQkJUUGPhJLy1Pp+aF+1g3ONB/2IZG1kSu2/j/4ETj?=
 =?us-ascii?Q?8EfhlKYHpsZ7MitDKlGiws7lgKAQTEbRuVCPziEsFO7hcwnJaKdJfKed9SfY?=
 =?us-ascii?Q?QvWMDLhP/hQTavftLKnW0AGng30Kr0zkCkxAmlnb2Nefl2nb1uMB9h2LvtIy?=
 =?us-ascii?Q?L0mmQQB9WuMY+mXoUkDf5PJed1Dn3doTbvFNSmcnI079e3y/+Au4EfPPG6pl?=
 =?us-ascii?Q?birEX2SQXHR887WRJHEoA9pkP88w8EJRbD1uLPklQ3igtk1e02Q01Icv5UoW?=
 =?us-ascii?Q?tDMR91zriEjb2p4desiGjv7TVSiUpwASF2FaTpmOD0v1ZiPhV8xJbOvD9G7b?=
 =?us-ascii?Q?COxYSegR4u43+v6IyAduDAOqGrR+hrEf1z4VouhxK1tXVdx6MUJvIpW4D76k?=
 =?us-ascii?Q?n6lZP849UsaK5LmuNrzB5Vj2Y8Zg5/y2g0ct2MfYH416lSLahcNeZEfD0fux?=
 =?us-ascii?Q?LB+o+6g6zxHBwPztty1XBqo17RSULLzke5MIlrptgiLtr8IMA/R+wVlvZnEl?=
 =?us-ascii?Q?+9UVmdu+KgzxHPBfpabnZA94EuqvCkfIHbuzC/ot+ZreaOIa+VjemBm3RRV/?=
 =?us-ascii?Q?m8XYbuLAM7BdmhgZSGuGp0Wnw/NAMUeXcCtfHfCW72Hp+xsW5IXNqFvfPQIk?=
 =?us-ascii?Q?wINUsXvyyq+TZGiHDWWPgG65r57xycsJKN9bUieZA2zosba7v9F7gpF8ZbRE?=
 =?us-ascii?Q?XRCvn1Dji6qVarVZRWFuC09v7bbqq3p/obsaw5Dqwd9X0SCDeqyQjTheTxeq?=
 =?us-ascii?Q?DHN2MhNNG1x9+TZ/PSPUXcs66FlNDH4su9NfswYHSqC+O20Pff7ZdG1J4uiZ?=
 =?us-ascii?Q?DGnLkB3lroa6IJTmM8W7k7j2F9uzZ61Y3YG8NXNH5X1XGucDzicRoDceDpCR?=
 =?us-ascii?Q?5oiBl3z5iq8j0tnkxc3rLA2+JJZJN0qecxukzVepspWrI3JOMuWNxja1eQur?=
 =?us-ascii?Q?CbeBjEaulvWdPQlRNFY758RAAvA1OVJXBA7OINNiNoMEx+WPHqN5h+sNxuiZ?=
 =?us-ascii?Q?MZIZqZcLBI4fuL3DunYZgAWJuO7wjgzvdvLv6sDkbFFAwLL+4U5IVtE/TE5/?=
 =?us-ascii?Q?NpocxdLqaP/xkjJgwomlk8iSISm949XMkHZnVzo3/CrCZnzoAoWrNISV0VIX?=
 =?us-ascii?Q?xjCHT6k6FdZuNnPSfqqksLcJOCi3OaVqRb2pvbZvKsg+TfxXa8h2qyPlJclv?=
 =?us-ascii?Q?a0V7X2VYK73H45r5j9K/s4A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(8096899003)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UYQJbziKgQDczzTC+7PjgyvhmMoVpozHUrSyokweTg0bi65ODNZ46LjNpO5b?=
 =?us-ascii?Q?s2jKoocc++k1/nGLq98V27194WEfAx6PEz7yTxIXJ4Y0k/K8XtQcRLEHOWoa?=
 =?us-ascii?Q?ZhTZxFqfjFhhoyhKO2lGSA5CB7TyzFjspaNPPOiT8ympRHpBzPMVkp/GQ9uH?=
 =?us-ascii?Q?N+mchbIvE3aTKtllYIUmHT47TNufkq4saEME6Y0YsPdfxInSQXMiQYKLeCFG?=
 =?us-ascii?Q?+muzwhHtlSm0fq+6v4FXZq+dh73wKfAAK/C/4jImuDGb4AuJPrQQfzC9Cyay?=
 =?us-ascii?Q?0xHM/Z/xsqCpk2XizsJZ0eTrBvH9P8KbiCrjOG9TG56Rm2DvMe4qh/VJSCsy?=
 =?us-ascii?Q?gM7Nl5II7GluyEEAzrmwkokhD8iB9NGg+1gpnH3N9jKgtrviwlAS3hZjljvH?=
 =?us-ascii?Q?3BdPvelWuqA7lLuillJgIzeSfTCxR3phNIvvSKpTOvGgBLThjvsUQBTNketW?=
 =?us-ascii?Q?Kkweg9ErVdhOfrfkmNG0+oula+Q0E6NH4P3axyd1roPhnRCptQrJO9lwSH4R?=
 =?us-ascii?Q?hXoJG8DRNa2w1ZVkFFzmO9yUxsv9RmEpehbinsJ18BzbrMDVZa5/MpqKAC2c?=
 =?us-ascii?Q?FQ7PnTfJtubWOKsqYZoiTICFRhMaoF3HegCAHy71/ZUeQzh8Ho+JdQIWgSNb?=
 =?us-ascii?Q?Y8HL6mNQc/wLdZH5N7aDkwqn1o5JATBuzn7S+dNPnCrk3kCuO5BZqCRNVVyU?=
 =?us-ascii?Q?RmLo2lbwb5+HPXIlp4op2NZ0PIlhqhK37HnijABoQ6KZPDVr6EWp2Y7BtkAD?=
 =?us-ascii?Q?XaTtAgCfoc1YTpLvWNvlvPBGQ2TOXtwe8ZbLsX9fGMYyhINeIRCUzVjCI8qc?=
 =?us-ascii?Q?dnvEWPAmNOaoF4DN0zVjwKY/b+2SNMCRrGQz9GBUje9LTceO/YId+i+AopA6?=
 =?us-ascii?Q?ci5svVliDCMyJhFZH4gAeeuSLodwTotIY/K4st1QRX5K+1/8EPQqg0k4Yk/f?=
 =?us-ascii?Q?yC/evr1nzt29vwBlL2O4V9HVz8HlHNIqmhcJuqrGIRyr0dgzlbKm2AA0elav?=
 =?us-ascii?Q?S3F4r9zCQnSgfge9CLfwA813QHL/6/Cdopc6chvdO1z1nPL2Akq6sJT+dsCR?=
 =?us-ascii?Q?d254ooXSq4oOUgjaU1mlchqbpUSB9W3CmsDZvFTUME3jy4+js2a3sVpY9FXu?=
 =?us-ascii?Q?fW5ow4KqxDIQO+fzhofiUrNiujW5+obdVbRgrKAJ3V3omkcukaMBYPL6USR6?=
 =?us-ascii?Q?cURSeX7F3h+ZO7ppvulWqJ/5iWltJDZY8L3Gfhk1GqKM5abVrDJyG6yxR13Q?=
 =?us-ascii?Q?gE9WJBK87WJiHwFQnTC0Xbj3nuBVywoZwZ4qSy8nNDTtz7sGp5vV55TAW2DY?=
 =?us-ascii?Q?4s4Hvq/8mVlgaL9I78E+pxFRE5xc2yekz2OpTqJ65U266FHpNTmZAFaz3QDL?=
 =?us-ascii?Q?IwxIC43YbU3jgXUUNTQP0pG0M8LptPhZP/ufduoENQgqiCkzJ9CY1z2gaxOB?=
 =?us-ascii?Q?pBhWjwny/fKbzzayFyV5MeJRhXspKVrdmC6SWd4b4P1En2o2z1OehLHj7wl4?=
 =?us-ascii?Q?ai3crXOa6WkicbhwNog7xw55dEdQoGQwc+EuQVpTqkz6kPK/uXQylfkQRuFt?=
 =?us-ascii?Q?aJHmT8ali9MycaO8Oz5B8H050T45edn34fZw/SmBgVsCC4/xvH7YPGDyHpLM?=
 =?us-ascii?Q?c9FwUBsTELA2Wv//kmCxU3vemUiDrX97fTeum8J+QU3rJpj/+eZmsxmlXT+G?=
 =?us-ascii?Q?2Fai2wFW0+rvjXDjvKUxpHAqMWOzQcqN0WdOVVaL/m5UsTDn2s0ToEru6Sqk?=
 =?us-ascii?Q?ooRPobKIy94luCRYemxSlm7Jzc0GOfSnOHHKB4Iu4qnJtyFobNUCZ41xQKGp?=
x-ms-exchange-antispam-messagedata-1:
 xYJM1e/19Mm8st4DDAmOqw8EZlTCWTdFtMa1ULISzakI6JGlSPXosi+S
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB30828B5A7845AF3B4776382B9F8DAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: be32b642-9690-40cc-ccef-08de5526806c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 17:41:38.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksQQ46vBvN5E1Yi4WFqe5Xgua/daahfhRFWbE7I3wI9jk43hDbELKVzA3JFbRNl9gQGOwtFTSCW7Go/e7ZjcgA49wplWUEpYuxaepJoIA2pWlgoHsKD2buVcGjvlQ3HLiw3AexbMKOk2B5uXJGgACw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB5204
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB30828B5A7845AF3B4776382B9F8DAMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB30828B5A7845AF3B4776382B9F8DAMA0P287MB3082INDP_"

--_000_MA0P287MB30828B5A7845AF3B4776382B9F8DAMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

No additional changes in this version.
This V2 patch was regenerated on top of `cygwin/main` and applies cleanly a=
s-is, without any additional dependencies.

Thanks,
Thirumalai Nagalingam

In-lined Patch:

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 32ceb3578..ab57739fa 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -385,7 +385,44 @@ _sigfe_maybe:                                      # s=
tack is aligned on entry!
        ret
        .seh_endproc

+    .seh_proc _sigfe
 _sigfe:
+    .seh_endprologue
+    ldr     x10, [x18, #0x8]           // Load TLS base into x10
+    mov     w9, #1                     // constant value for lock acquisit=
ion
+0:  ldr     x11, =3D_cygtls.stacklock    // Load offset of stacklock
+    add     x12, x10, x11              // Compute final address of stacklo=
ck
+    ldaxr   w13, [x12]                 // Load current stacklock value ato=
mically
+    stlxr   w14, w9, [x12]             // Attempt to store 1 to stacklock =
atomically
+    cbnz    w14, 0b                    // Retry if atomic store failed
+    cbz     w13, 1f                    // If lock was free, proceed
+    yield
+    b       0b                         // Retry acquiring the lock
+1:
+    ldr     x11, =3D_cygtls.incyg        // Load offset of incyg
+    add     x12, x10, x11              // Compute final address of incyg
+    ldr     w9, [x12]                  // Load current incyg value
+    add     w9, w9, #1                 // Increment incyg
+    str     w9, [x12]                  // Store updated incyg value
+    mov     x9, #8                     // Set stack frame size increment (=
8 bytes)
+2:  ldr     x11, =3D_cygtls.stackptr     // Load offset of stack pointer
+    add     x12, x10, x11              // Compute final address of stack p=
ointer
+    ldaxr   x13, [x12]                 // Atomically load current stack po=
inter
+    add     x14, x13, x9               // Compute new stack pointer value
+    stlxr   w15, x14, [x12]            // Attempt to update stack pointer =
atomically
+    cbnz    w15, 2b                    // Retry if atomic update failed
+    str     x30, [x13]                 // Save LR(return address) on stack
+    adr     x11, _sigbe                // Load address of _sigbe
+    mov     x30, x11                   // Set LR =3D _sigbe
+    ldr     x11, =3D_cygtls.stacklock    // Load offset of stacklock TLS v=
ariable
+    add     x12, x10, x11              // Compute final address of stacklo=
ck
+    ldr     w9, [x12]                  // Load current stacklock value
+    sub     w9, w9, #1                 // Decrement stacklock to release l=
ock
+    stlr    w9, [x12]                  // Store stacklock value (release l=
ock)
+    ldr     x9, [sp], #16              // Pop real func address from stack
+    br      x9                         // Branch to real function
+    .seh_endproc
+
 _sigbe:
        .global sigdelayed
 sigdelayed:
--
2.52.0.windows.1

--_000_MA0P287MB30828B5A7845AF3B4776382B9F8DAMA0P287MB3082INDP_--

--_004_MA0P287MB30828B5A7845AF3B4776382B9F8DAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0003-Cygwin-gendef-Implement-_sigfe-function-for-TLS-hand.patch"
Content-Description:
 0003-Cygwin-gendef-Implement-_sigfe-function-for-TLS-hand.patch
Content-Disposition: attachment;
	filename="0003-Cygwin-gendef-Implement-_sigfe-function-for-TLS-hand.patch";
	size=2811; creation-date="Fri, 16 Jan 2026 17:40:54 GMT";
	modification-date="Fri, 16 Jan 2026 17:41:38 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MTQwMWFhZDI1ZGYxNGI4MTA4ODM4ZjYwNGE3ZjVlYWM5NWNhMGFh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE5OjE2OjIxICswNTMw
ClN1YmplY3Q6IFtQQVRDSCAzLzZdIEN5Z3dpbjogZ2VuZGVmOiBJbXBsZW1l
bnQgX3NpZ2ZlIGZ1bmN0aW9uIGZvciBUTFMKIGhhbmRsaW5nIG9uIEFBcmNo
NjQKClNpZ25lZC1vZmYtYnk6IFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhp
cnVtYWxhaS5uYWdhbGluZ2FtQG11bHRpY29yZXdhcmVpbmMuY29tPgotLS0K
IHdpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYgfCAzNyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAz
NyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9z
Y3JpcHRzL2dlbmRlZiBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYK
aW5kZXggMzJjZWIzNTc4Li5hYjU3NzM5ZmEgMTAwNzU1Ci0tLSBhL3dpbnN1
cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKKysrIGIvd2luc3VwL2N5Z3dpbi9z
Y3JpcHRzL2dlbmRlZgpAQCAtMzg1LDcgKzM4NSw0NCBAQCBfc2lnZmVfbWF5
YmU6CQkJCQkjIHN0YWNrIGlzIGFsaWduZWQgb24gZW50cnkhCiAJcmV0CiAJ
LnNlaF9lbmRwcm9jCiAKKyAgICAuc2VoX3Byb2MgX3NpZ2ZlCiBfc2lnZmU6
CisgICAgLnNlaF9lbmRwcm9sb2d1ZQorICAgIGxkciAgICAgeDEwLCBbeDE4
LCAjMHg4XQkJLy8gTG9hZCBUTFMgYmFzZSBpbnRvIHgxMAorICAgIG1vdiAg
ICAgdzksICMxCQkJLy8gY29uc3RhbnQgdmFsdWUgZm9yIGxvY2sgYWNxdWlz
aXRpb24KKzA6ICBsZHIgICAgIHgxMSwgPV9jeWd0bHMuc3RhY2tsb2NrCS8v
IExvYWQgb2Zmc2V0IG9mIHN0YWNrbG9jaworICAgIGFkZCAgICAgeDEyLCB4
MTAsIHgxMQkJLy8gQ29tcHV0ZSBmaW5hbCBhZGRyZXNzIG9mIHN0YWNrbG9j
aworICAgIGxkYXhyICAgdzEzLCBbeDEyXQkJCS8vIExvYWQgY3VycmVudCBz
dGFja2xvY2sgdmFsdWUgYXRvbWljYWxseQorICAgIHN0bHhyICAgdzE0LCB3
OSwgW3gxMl0JCS8vIEF0dGVtcHQgdG8gc3RvcmUgMSB0byBzdGFja2xvY2sg
YXRvbWljYWxseQorICAgIGNibnogICAgdzE0LCAwYgkJCS8vIFJldHJ5IGlm
IGF0b21pYyBzdG9yZSBmYWlsZWQKKyAgICBjYnogICAgIHcxMywgMWYJCQkv
LyBJZiBsb2NrIHdhcyBmcmVlLCBwcm9jZWVkCisgICAgeWllbGQKKyAgICBi
ICAgICAgIDBiCQkJCS8vIFJldHJ5IGFjcXVpcmluZyB0aGUgbG9jaworMToK
KyAgICBsZHIgICAgIHgxMSwgPV9jeWd0bHMuaW5jeWcJLy8gTG9hZCBvZmZz
ZXQgb2YgaW5jeWcKKyAgICBhZGQgICAgIHgxMiwgeDEwLCB4MTEJCS8vIENv
bXB1dGUgZmluYWwgYWRkcmVzcyBvZiBpbmN5ZworICAgIGxkciAgICAgdzks
IFt4MTJdCQkJLy8gTG9hZCBjdXJyZW50IGluY3lnIHZhbHVlCisgICAgYWRk
ICAgICB3OSwgdzksICMxCQkJLy8gSW5jcmVtZW50IGluY3lnCisgICAgc3Ry
ICAgICB3OSwgW3gxMl0JCQkvLyBTdG9yZSB1cGRhdGVkIGluY3lnIHZhbHVl
CisgICAgbW92ICAgICB4OSwgIzgJCQkvLyBTZXQgc3RhY2sgZnJhbWUgc2l6
ZSBpbmNyZW1lbnQgKDggYnl0ZXMpCisyOiAgbGRyICAgICB4MTEsID1fY3ln
dGxzLnN0YWNrcHRyCS8vIExvYWQgb2Zmc2V0IG9mIHN0YWNrIHBvaW50ZXIK
KyAgICBhZGQgICAgIHgxMiwgeDEwLCB4MTEJCS8vIENvbXB1dGUgZmluYWwg
YWRkcmVzcyBvZiBzdGFjayBwb2ludGVyCisgICAgbGRheHIgICB4MTMsIFt4
MTJdCQkJLy8gQXRvbWljYWxseSBsb2FkIGN1cnJlbnQgc3RhY2sgcG9pbnRl
cgorICAgIGFkZCAgICAgeDE0LCB4MTMsIHg5CQkvLyBDb21wdXRlIG5ldyBz
dGFjayBwb2ludGVyIHZhbHVlCisgICAgc3RseHIgICB3MTUsIHgxNCwgW3gx
Ml0JCS8vIEF0dGVtcHQgdG8gdXBkYXRlIHN0YWNrIHBvaW50ZXIgYXRvbWlj
YWxseQorICAgIGNibnogICAgdzE1LCAyYgkJCS8vIFJldHJ5IGlmIGF0b21p
YyB1cGRhdGUgZmFpbGVkCisgICAgc3RyICAgICB4MzAsIFt4MTNdICAgICAg
ICAgICAgICAgICAvLyBTYXZlIExSKHJldHVybiBhZGRyZXNzKSBvbiBzdGFj
aworICAgIGFkciAgICAgeDExLCBfc2lnYmUJCS8vIExvYWQgYWRkcmVzcyBv
ZiBfc2lnYmUKKyAgICBtb3YgICAgIHgzMCwgeDExICAgICAgICAgICAgICAg
ICAgIC8vIFNldCBMUiA9IF9zaWdiZQorICAgIGxkciAgICAgeDExLCA9X2N5
Z3Rscy5zdGFja2xvY2sJLy8gTG9hZCBvZmZzZXQgb2Ygc3RhY2tsb2NrIFRM
UyB2YXJpYWJsZQorICAgIGFkZCAgICAgeDEyLCB4MTAsIHgxMQkJLy8gQ29t
cHV0ZSBmaW5hbCBhZGRyZXNzIG9mIHN0YWNrbG9jaworICAgIGxkciAgICAg
dzksIFt4MTJdCQkJLy8gTG9hZCBjdXJyZW50IHN0YWNrbG9jayB2YWx1ZQor
ICAgIHN1YiAgICAgdzksIHc5LCAjMQkJCS8vIERlY3JlbWVudCBzdGFja2xv
Y2sgdG8gcmVsZWFzZSBsb2NrCisgICAgc3RsciAgICB3OSwgW3gxMl0JCQkv
LyBTdG9yZSBzdGFja2xvY2sgdmFsdWUgKHJlbGVhc2UgbG9jaykKKyAgICBs
ZHIgICAgIHg5LCBbc3BdLCAjMTYgICAgICAgICAgICAgIC8vIFBvcCByZWFs
IGZ1bmMgYWRkcmVzcyBmcm9tIHN0YWNrCisgICAgYnIgICAgICB4OQkJCQkv
LyBCcmFuY2ggdG8gcmVhbCBmdW5jdGlvbgorICAgIC5zZWhfZW5kcHJvYwor
CiBfc2lnYmU6CiAJLmdsb2JhbAlzaWdkZWxheWVkCiBzaWdkZWxheWVkOgot
LSAKMi41Mi4wLndpbmRvd3MuMQoK

--_004_MA0P287MB30828B5A7845AF3B4776382B9F8DAMA0P287MB3082INDP_--
