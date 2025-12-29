Return-Path: <SRS0=h79E=7D=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020077.outbound.protection.outlook.com [52.101.225.77])
	by sourceware.org (Postfix) with ESMTPS id E77544BA2E04
	for <cygwin-patches@cygwin.com>; Mon, 29 Dec 2025 05:30:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E77544BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E77544BA2E04
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=52.101.225.77
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1766986217; cv=pass;
	b=Nl2rFZJGcXeTkCicr7exim8z/b7lF4yF6m4nHawqFRD7SM98wKUaVppS+kub1x0lFFF0qlJnTUF9oEsMTOAdhLMSwrraMLNBUbLKRJwcfyAm8L0qdn45PqIQXH53YaNDbFSwnDXjysetl4zsRqcSePhoMWSzwDgYZ3tB1FWRT+M=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766986217; c=relaxed/simple;
	bh=V7HTDoxV4pqijHAYZ31TNt68AcvcgbPQnWVr6n3Srh4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=fPEMkJeMdEVWYu+VWhTVRr/r8rDTmxtobcuNufU4Eb0LH8zP2l+kKVTGFvmTbrgIoE1k9ll1R0vnuOpbV6c7w9QZTsMQbT1j4vhtYSetFs3sZ8/62hV+6CpMD6iO2Go3yGM7lPXxvkKrmK580c+gW4aYwhRhxgJ/RVz4Luxx10Y=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E77544BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=2FDP/BXm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpFY7wluiCgheGgmNE+1mPBs2rDNAm7xQUZ9Sbqm78hZwdOXA2XBsigBinl5NlGRAT5T2WTELgPEBTpdo3p8OFxZjc6qam+71DJanOS5nIxmqKAHc75tH7vNpgGtY3y4Umwa358Ejw4XCKkxAkPN0dmJqiYAJ5uzCqaYoYiGYQb9i7BhZ/I+PXd3hSj3W7L5mpbPSJAfDXvCcaiM2ceSe8zOs4KnGudGaN1cFMfOFfhYI5xOA3/KFO9OyJyKKXeXD8MIki5ZohIoAxjmznL5Uc863LgP/J7qmNeOFEMeF11cWxVECNQxtAmkN+yIpdLbBfm8UELHD2StGhRSF1Bwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQqB2QnZoVB01/LaVvgs5PQ5+p1oxI+R8W2TKUJhGs8=;
 b=fCDtC3mPDZMsq48lu2vx7t6zGKmuGiDwqgotY3v5r+9As1P/RSbWeBJ9hZNm2B9jsIoJmVtDwY5/kzIJ7rCaYjTZAd8rE8tLr4ysU9sfjcxJIs5w/LjGyXyo1NA5bPbDWmUpmMZK4o/LL8ZCTpJ+U+j9SCPP5i9mqUr4N3siBP3myHWuq+xkkw7ev7mrrxNAW8RBW3C08S7fLhK1BYB+MX1S+lq8/0zB4B0N64a6EpaeuKRzZAQUfzh7yHt3pCv1Q++USuZiQEBPFA3Uk5tmEKBXwEsTQZgl6xWtuNAmjVd24k88KLssZ+viKwDQ5dmiuwggyD8j6SCAAkh+ALZdqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQqB2QnZoVB01/LaVvgs5PQ5+p1oxI+R8W2TKUJhGs8=;
 b=2FDP/BXm1XW5ifGlOg4HjmG59VFtjrPapb0P6ZrEWbqi7oiG7Wbmrv6megELuO6lbZNalpxfkKDys/IHulatssHnQaoLttlV/qOxJEdbrIXCgcFTunlTLkgw7oy7O4MFGbE2PVprqiWCy2y63wwm275edplShi23BvzG0bArWSIRSccE2uXTmUepvqJQKrdogutns7xBoHyawTeTl9sPOIDFlbpNassB7bCGHJCpT9P8Ixyf6B/mms9JEZnSLK+DrZtx5hOuWi3ejGe1CgS0q9iKGk0u/mWr3m8d8DWD1XflVT7vbrGM9NJTxlJugY1owBHCNu+lsgLYxZUxSNbLtg==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA5P287MB5222.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 05:30:10 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 05:30:10 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH] Cygwin: gendef: Implement siglongjmp for AArch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement siglongjmp for AArch64
Thread-Index: Adx4AVgHpgVh9qDRSFKudGgRBMlJsQ==
Date: Mon, 29 Dec 2025 05:30:00 +0000
Message-ID:
 <MA0P287MB30829116428B3B2900E4CC3C9FBEA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA5P287MB5222:EE_
x-ms-office365-filtering-correlation-id: 0d66f68a-2c90-46ea-dba5-08de469b5593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|4053099003|8096899003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7qGoBIZ/IyRfOMNuBoL5DtYk9GOnPGdAyx8tu0piCdQFE8+gY0fMM5iqxeb4?=
 =?us-ascii?Q?SL4vGHypHUmmls+RL8G4Jpq+4zjqUXONdSaSqaR2ERgSabyWDDAR1ndSs4YF?=
 =?us-ascii?Q?XyOj8Ykr9SRmuRyn8xPwNDhTxbEhQ4kO/ZfqL0I/+fqxjlSwnUSFyzaxvrp4?=
 =?us-ascii?Q?u57YO51Y+NZLihZU7A0/cTO9ePIfJvsp8/LQw1YOxHcMxW0FbNK+xG2unqFm?=
 =?us-ascii?Q?c8cbgy+FLrV7X+oHMeluYNVUKqZYMDebaSQ/AXmUW+WX7Fku0+hrk2FvMQbU?=
 =?us-ascii?Q?CPE8BIoDxMBXh/CXsAbSBvrUsJSId+wBDVmHlFObDPFln/YzRrC/ZVxBKTiJ?=
 =?us-ascii?Q?0fcE2mkc0tAbJTW9M66fOEgcCFMuUUyP7ZcG3fiVeoQ20NYZZYlQxZVr8XqK?=
 =?us-ascii?Q?nRk35H/n/Lkvj91OLxlHaDm+wFjevHxXKQud4OpDdd61g3xexNijcZtglPQo?=
 =?us-ascii?Q?J0WxE841YRJjkFv1C0Ygvol2VJ1lR2hdg9xSSY9grkQRjo1uDTbijLpUJP3n?=
 =?us-ascii?Q?Y5I5hwZ15DFfzvuTMN6L1kP9XVdfrFK8g02AWMoTRKG4UN1XUvu0o/Sx+xcL?=
 =?us-ascii?Q?eEXAq6HM8DWFuQpbYtfrZkfCMAWw93sQtSMmCyFLK9J4zwiAxZnpVucearoN?=
 =?us-ascii?Q?jqz2kUkjW71XVdGH+gjYdoXon3NWv6BSq70LUHfSPZR/CI3IBwlVe3Rflkr/?=
 =?us-ascii?Q?0C/PDk+FyUVe8Xe8z4K/qt6SRlF9Mj9nONRj4KVPObiMiag8Vrc6LiMJUxm1?=
 =?us-ascii?Q?+GK12lflkA7o3XXIsc9gsjAXj+eLYF+7kEHrnCWAYMa/1rVTg9EnLITausg8?=
 =?us-ascii?Q?WeuMwh+4s4VTTZ2gN5m9lXRnUZ4DCF/jcjUAHKLAQ1mO1N1jiPiYqmR1fTjY?=
 =?us-ascii?Q?GDb0/74/ms2H5kWMj7qU4FWCppQJzTQMERU4RfyMI2UH7uAzEfLHYfP5SdoH?=
 =?us-ascii?Q?kLWg+gsEp2KxAFCRW4DWT7g6LVBx7IYeDqHqwyJv39DQa5VfVJwlXOIqXM+/?=
 =?us-ascii?Q?vB/Fb1Nsm4qZ4ZBJQzo20RGQWTYtk4v77eSY+6OwaQZP8d1CsGBLtyjKW9HP?=
 =?us-ascii?Q?pBEqkCs9SZKm/vwaRAipW4oOTEsKudsLiGsLSZ5CydEB88FlTUOlwpgc4j6F?=
 =?us-ascii?Q?WNEAxFdJmHmMHmXB7pe3gl3Sdc7VOEsQ/JzvJzgwu3OOfGxcJTXHkjfzUQgH?=
 =?us-ascii?Q?Z4RCFXSlzvCpktUITLIDv8Sp/+ydGyM3fNA4ya3UieUe4j4clMdJwNzxGCxP?=
 =?us-ascii?Q?DGe/OpfVPKlhW2A03H5Av90WZa+JkFhjEV2NyI4wHLcG46ne61EEbTI/wdzM?=
 =?us-ascii?Q?8D823mlnlKpbYt54nmVdo0c92LxbO2kb4j6PyTD/xqAoeBVx6T9XFraR/Ylj?=
 =?us-ascii?Q?1VsloDdFNv9pIMk/YCoY4YC1LKZkimgOM+3BsG73sSrdlsURW3ZNOeM6c/rj?=
 =?us-ascii?Q?AyjV+uk0LdKEnSXgXZ7JBLmtfz9C4HPkDZpAF535ubQiavblSlk3GKFZfdH0?=
 =?us-ascii?Q?fCvleGIE73eP3wJUsQpl5GJecEyEDyx249Wa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(4053099003)(8096899003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wI3JQoxUUT9b3zQjncrOgkaHZ6FrpOkAiRObA5UHd8uzgUetkcuucdcnDJL5?=
 =?us-ascii?Q?HgTuNSRhbpf0F34AI15ieF603UEYRy8G0JudJzADpT57MetmTgYkq8SkPY5o?=
 =?us-ascii?Q?UYos/9eg3BsK2QoNoukbL/d4oY1zscNS87sVErT0bxEiWbw5nD+kosO9/9zq?=
 =?us-ascii?Q?v/tLK05KKvHxm/fieWZjfrxY/d1chKfqZlreIEvp0UdNyJ4jLfDK5j0Z12kp?=
 =?us-ascii?Q?Nbsr8SeWJqsr+U6FuMPuQ5+RwB1DSabxwB+0y+S7M7zlfJWkD6JB5D3lnIvz?=
 =?us-ascii?Q?z7PiMp1AbxtPa9nIwkOCxHY0n+MKIpv4EIY2QynEUapuTnpsH9guM4OizRrR?=
 =?us-ascii?Q?sJpHgyF++k65KMnM1x7/cwaQLoGnZgHVwik3aaAFQ58swKtRmeayhNEUP12D?=
 =?us-ascii?Q?GkE5/lqwKk9BQqHalrw9Lle/brij816XdceSeewi1D9ZOzPUGgXlpl51n8Rz?=
 =?us-ascii?Q?R6ulCXtAprxj1VKmez34FexQ/9+XxoUv3Br2vIHdIBiKMFulIF4K0Gq3+tIM?=
 =?us-ascii?Q?tC/3bPiGReRhKTDSLz5Rwuqbc8FUmzghcP8tSm2BIFgWnhQzvq3htvKKyAN9?=
 =?us-ascii?Q?FrA+v7fWflW+58oZnzQ0PfQKQ82xCCwJtrdiQu6jSMoMB1YrfCc3Os1yQ48c?=
 =?us-ascii?Q?zystzgA3pkMB78ZaUS9SXuNeN2o/jT4WeKHwqgaP68/xZb8CNRHoJKXx06ey?=
 =?us-ascii?Q?Uzgb6CGvpjJD46fad3+htXSXAtcEkaf4BHo9WSyKKQWKEEeNqcEHzq5lS7jP?=
 =?us-ascii?Q?evvFCQEsx7lpHYplglGvM+urIWRdu9Q/2rrI5d6ImfExDf8qenX2Hr3X5+dx?=
 =?us-ascii?Q?nwLfyYeII+g98hIZYn5U3/zcuzTfh6VlZwFNCCvXwCOwfKnkbjQdZxcXY+Df?=
 =?us-ascii?Q?mTX6k4tINuYdr3ATwqSwAmi1elJldunro95J0fc18mKuPHkY4hcL6Wm9Cmua?=
 =?us-ascii?Q?rl81gQmx9HVe5aM/zWcR3xDtaV6Rwt/7n7m4RFw1eqTC44uKqtb4ESmmih5W?=
 =?us-ascii?Q?Z6VChasZiq1DmFC92w2TiHEzUVNZFCuQ8FFt3XyAJTXAAojtBKWSGPCt8zV/?=
 =?us-ascii?Q?QER+3C2GYYAbNEMghD4wFomcabznaMI9GIw0NBQGrfHXN8tLFAmVn8JxUnFC?=
 =?us-ascii?Q?buNEZjGqxqv0VG7knpafKeUx+BkWh4eav/8riomHgLDYsPxfAuV2szIF9k1F?=
 =?us-ascii?Q?SuBUlqabIFbPO6syJSYWGRrz3a7a3J5PbLiGWQN/d6xkiMceSzjmx2IenC+S?=
 =?us-ascii?Q?QgFTvJWWXBLWsIdwxIz/kSAOUD0eSlOr+p9wmzr7377kwEBlivD3X389WtXG?=
 =?us-ascii?Q?8SQNGlVPVVJFIYj2DPwViumkUAOG2XI04ZkLRxuQfsW0M9MqghOSYU4IRKCn?=
 =?us-ascii?Q?dDVUFrSY6Df7d0kOX7LHKNuGM7yclwgAYZO8+g3gp7JYjhh+lkosILZ0rHMk?=
 =?us-ascii?Q?oJswPI/1A3TfNo4DgTKqZqFnTX2iibKgF+aT4gsGExN3AEWwBOnDdh6x8LHE?=
 =?us-ascii?Q?M856mN9ZAf3Uv746tQbdx1tG/3FS6uGq2YVziEthsreq8bOfVY/xNWuch4qs?=
 =?us-ascii?Q?EzyQCX/NrWSwN/vWEWo4ltGwD3kxKqEmCK47YNIwcL/HkRlE3akBoHA/fP/Y?=
 =?us-ascii?Q?f6/TWwX2/qTghd/UR9Ev1WNTVkeMNXA2uD4mgAxxPqiJvMyedpKYZr69WtYh?=
 =?us-ascii?Q?J3pR3GxHFooDtPw1BZ0H5fgOPNf7U53xqR7l/vD45wELdXejaoy1hoE0wLUo?=
 =?us-ascii?Q?QxZPtKKx8ZhKjX6eTD3k7px7cjyZtoLt8zmoqXI0D9lfC8mPxZyZqQz8UWvt?=
x-ms-exchange-antispam-messagedata-1:
 ueWuTMM6NXGSzbeaYHMltLv6hmXLKJdrNXv0CRhTpwhF/OtchVzFhgSIN7XMfv5ZuUS/H46Lf2sdsw==
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB30829116428B3B2900E4CC3C9FBEAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d66f68a-2c90-46ea-dba5-08de469b5593
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 05:30:10.2381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZgY1Km8ZC/UcBn9XMO1LcaAbHjs3Nq4vSpR7BHEAaUy0SADi6u3tos7JW1hj5Bn2yGvvBtiLBwsc7FhrQr7BDpHAA/2p3/0bHOPdP/yzlLSm6Bfu7oCS1KeqAcYskJQ2/ZtHnD5IGF+FuA2LeBq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB5222
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB30829116428B3B2900E4CC3C9FBEAMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB30829116428B3B2900E4CC3C9FBEAMA0P287MB3082INDP_"

--_000_MA0P287MB30829116428B3B2900E4CC3C9FBEAMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Please find the attached patch which adds an ARM64 stub for the `siglongjmp=
 ` routine
in the gendef script.

Any feedback or nits are very welcome. The changes are documented with inli=
ne
comments intended to be self-explanatory. please let me know if any part
of this patch should be adjusted.

Thanks for your time and review.

Thanks & regards
Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>

In-lined patch:

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index f85c8cf74..40f473bb6 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -690,7 +690,33 @@ setjmp:
        .seh_endproc

        .globl  siglongjmp
+       .seh_proc siglongjmp
 siglongjmp:
+       // prologue
+       stp     fp, lr, [sp, #-0x10]!           // save FP and LR registers
+       mov     fp, sp                          // set FP to current SP
+       .seh_endprologue
+       mov x19, x1                             // save val
+       mov x20, x0                             // save buf
+       ldr     w8, [x20, #0x100]               // w8 =3D buf->savemask
+       cbz     w8, 1f                          // if savemask =3D=3D 0, sk=
ip
+       sub     sp, sp, #32                     // allocate 32 bytes on sta=
ck
+       mov     x0, #0                          // SIG_SETMASK
+       mov     x1, xzr                         // newmask =3D NULL
+       add     x2, x20, #0x108                 // &buf->sigmask
+       bl      pthread_sigmask
+
+       add     sp, sp, #32                     // call frame
+1:
+       mov     x0, x20                         //buf
+       mov     x1, x19                         //val
+       bl longjmp
+
+       // epilogue
+       ldp     fp, lr, [sp], #0x10             // restore saved FP and LR =
registers
+       ret
+       .seh_endproc
+



--_000_MA0P287MB30829116428B3B2900E4CC3C9FBEAMA0P287MB3082INDP_--

--_004_MA0P287MB30829116428B3B2900E4CC3C9FBEAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="Cygwin-gendef-Implement-siglongjmp-for-AArch64.patch"
Content-Description: Cygwin-gendef-Implement-siglongjmp-for-AArch64.patch
Content-Disposition: attachment;
	filename="Cygwin-gendef-Implement-siglongjmp-for-AArch64.patch"; size=1671;
	creation-date="Fri, 19 Dec 2025 16:33:32 GMT";
	modification-date="Sun, 28 Dec 2025 13:56:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhZWNkYzUwY2YwYTFmZmU1YzhiMDJmNjA1YWNiZjcxNzA0ZDNhZGZk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE4OjE0OjA4ICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW5kZWY6IEltcGxlbWVudCBz
aWdsb25nam1wIGZvciBBQXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRl
bnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRy
YW5zZmVyLUVuY29kaW5nOiA4Yml0CgpDby1hdXRob3JlZC1ieTogUmFkZWsg
QmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+CgpTaWduZWQt
b2ZmLWJ5OiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KLS0tCiB3aW5zdXAvY3ln
d2luL3NjcmlwdHMvZ2VuZGVmIHwgMjYgKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiBiL3dpbnN1
cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKaW5kZXggZjg1YzhjZjc0Li40MGY0
NzNiYjYgMTAwNzU1Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5k
ZWYKKysrIGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZgpAQCAtNjkw
LDcgKzY5MCwzMyBAQCBzZXRqbXA6CiAJLnNlaF9lbmRwcm9jCgogCS5nbG9i
bAlzaWdsb25nam1wCisJLnNlaF9wcm9jIHNpZ2xvbmdqbXAKIHNpZ2xvbmdq
bXA6CisJLy8gcHJvbG9ndWUKKwlzdHAJZnAsIGxyLCBbc3AsICMtMHgxMF0h
CQkvLyBzYXZlIEZQIGFuZCBMUiByZWdpc3RlcnMKKwltb3YJZnAsIHNwCQkJ
CS8vIHNldCBGUCB0byBjdXJyZW50IFNQCisJLnNlaF9lbmRwcm9sb2d1ZQor
CW1vdiB4MTksIHgxCQkJCS8vIHNhdmUgdmFsCisJbW92IHgyMCwgeDAJCQkJ
Ly8gc2F2ZSBidWYKKwlsZHIgICAgIHc4LCBbeDIwLCAjMHgxMDBdICAgICAg
IAkvLyB3OCA9IGJ1Zi0+c2F2ZW1hc2sKKwljYnogICAgIHc4LCAxZiAgICAg
ICAgICAgICAgICAgIAkvLyBpZiBzYXZlbWFzayA9PSAwLCBza2lwCisJc3Vi
CXNwLCBzcCwgIzMyCQkJLy8gYWxsb2NhdGUgMzIgYnl0ZXMgb24gc3RhY2sK
Kwltb3YgICAgIHgwLCAjMCAgICAgICAgICAgICAgICAgIAkvLyBTSUdfU0VU
TUFTSworCW1vdiAgICAgeDEsIHh6ciAgICAgICAgICAgICAgICAgCS8vIG5l
d21hc2sgPSBOVUxMCisJYWRkICAgICB4MiwgeDIwLCAjMHgxMDggICAgICAg
ICAJLy8gJmJ1Zi0+c2lnbWFzaworCWJsICAgICAgcHRocmVhZF9zaWdtYXNr
CisKKwlhZGQgICAgIHNwLCBzcCwgIzMyCQkJLy8gY2FsbCBmcmFtZQorMToK
Kwltb3YJeDAsIHgyMAkJCQkvL2J1ZgorCW1vdgl4MSwgeDE5CQkJCS8vdmFs
CisJYmwgbG9uZ2ptcAorCisJLy8gZXBpbG9ndWUKKwlsZHAJZnAsIGxyLCBb
c3BdLCAjMHgxMAkJLy8gcmVzdG9yZSBzYXZlZCBGUCBhbmQgTFIgcmVnaXN0
ZXJzCisJcmV0CisJLnNlaF9lbmRwcm9jCisKIAkuZ2xvYmwgIGxvbmdqbXAK
IAkuc2VoX3Byb2MgbG9uZ2ptcAogbG9uZ2ptcDoKLS0KMi41Mi4wLndpbmRv
d3MuMQoK

--_004_MA0P287MB30829116428B3B2900E4CC3C9FBEAMA0P287MB3082INDP_--
