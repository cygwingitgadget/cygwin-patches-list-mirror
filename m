Return-Path: <SRS0=h79E=7D=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020114.outbound.protection.outlook.com [52.101.225.114])
	by sourceware.org (Postfix) with ESMTPS id 0505C4BA2E04
	for <cygwin-patches@cygwin.com>; Mon, 29 Dec 2025 06:00:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0505C4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0505C4BA2E04
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=52.101.225.114
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1766988019; cv=pass;
	b=b3iEIIy+rvUZaWOD0dsCSic0IUxRof5PnnmrZ9Zu6cpOhqGuQ6VBuq/GrU6wmWSbqhCIpP0EZTuv7bxDNtTCgW618RPFNNecax3ha8iNZgn4nQKkldm1TuVckJptfgoaN6VqsQaWKKzfHXIEZYT2GlGnfmIVUCgL8H34slBKcLM=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766988019; c=relaxed/simple;
	bh=u8XYnJDM9/OZ1IbS2vTZlk7A3UQ/kdEA2DShVbayUyA=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=INI1kCtcAylrwkjCd91+5N8b0q5nH/ZFQ8XGQ2dF3gpfxAsCugVehhv8UaD0AdLXDIZiXfmichy2C0Ee1UIzal0/rQdcscW/OuP0RK63tXu7puKaXIJMBpFkYvulro13SJjvGKdkDGvG/Scrs7GMHDMNZJtGe8xArMvYIRoY5iw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0505C4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=S1wz4GtM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm18tcd7yE9a3R/IY1cT0xq8TkX75+Jxhm3KfsJy9/TyKfoDxlUJ0/xQbXume0TjW9JJHs0gKM2LYLlDytRw6h8CIUa8TaDoRfRh9edpt87e9hOZ/Bnfv6/1RO4SGZsS1W5PkXh4fAox6lcYYWdUui4QP+XMpcZSsYlunm3hDEU4pHQsgYbuo3zb3irjq4tjgrD43SWsSmiQkAUscDBoL1RI3RFj6x8USPvpe6ieWMl+IBQX6BOueWnkqYnL8wD+vwF8jO0MdEXHz1KwjwNYS8SXoPg/qA6H7D4WCCYHWU2odnhv6bu9CqG8xlytKSZfaedImkJtAswdcriyb8tqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsPk43A3Js0XXe4zTUlGLxhBS1tP7LjGMTawBtWAGDA=;
 b=mpSjFLxO4jInH9RNcQMlvy7zHu2vAP5gfl3jSa6dG6Ak01xTAHG/CJvLES7Vscq+cXQFrvwEzDJ2N3LDEKr8Orqciv2BIRV4DVN/8Hyr1eMsp9c5NOkenHtNLYYii0IblXOF6dpHSDv4CzKMCDd3kFp+j0fDz4ALvQEEubAfaLUHZI4YWBuKZuYZ3fzWIw9dRz3+8ka0hmjTeUUiu3HWFLvIWbw0IamrFhin8wmh08nLZhiNMn2TlSK1n09kZN9cuI7WcN0P/osC7gB2Esa4vi3wIppRQ5Mqln8IjxACPsc6us8OkIHWpGnwfycO+z2vSTWRww718/feItQow+8uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsPk43A3Js0XXe4zTUlGLxhBS1tP7LjGMTawBtWAGDA=;
 b=S1wz4GtMTbcAU8Jt8UcywbKET1goNExaptxp/25WAW9AeYvQXmL1m6Q/BlooYEMF0Z2J6qoudePElm2PToK9rCF/PfiIf5YkzaZ5EvBGBKzb+AvFqiyrJaLwOUP/cyGJmxLSbV+vr7c19RGw5xYRrMoWW7VvDoXGNk+a/73EFc25TL/iJPIPJ83bKs6XtaBFQhU6gwa0sKT0Tv83p1aQMBKZJqXEUw8cl1EMcFVwnqpCndjiAzyEidNPqfYubxyb+hO0zMPorhKeiwB1ILJzdXO6NYon71igurx8kx5OhWYLfQMop//gqbmtxzI8lcTT8/I4tWvruRKGylLQHb2/uQ==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN4P287MB4653.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 06:00:10 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 06:00:10 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH] Cygwin: gendef: Implement sigsetjmp for AArch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement sigsetjmp for AArch64
Thread-Index: Adx4AhSsQeoIegm1Teyk0DHjCyFCNQ==
Date: Mon, 29 Dec 2025 06:00:00 +0000
Message-ID:
 <MA0P287MB3082C7171807D783172246109FBEA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN4P287MB4653:EE_
x-ms-office365-filtering-correlation-id: db32488d-f53b-43a3-5dcd-08de469f868d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R1t8Ob1s3ZIxkD2sz5M1ZQOrDDzXpsMDuLHC6bwwukrdE8QDDSRGcEJM/gbz?=
 =?us-ascii?Q?YXDKXhLFUVIrwpPeYFhrs7Ax0IEhz2LVUxc+1WhaK7Qrg2/iDOD0w1fCzgby?=
 =?us-ascii?Q?OUQjXmSNRVpBs6AinO/z8ihG9omXfKz40pvwp4mnNb6IZyWEEs7yDZy7g2xJ?=
 =?us-ascii?Q?qrhlJKJld/ohBmbD18Kjh1X2vOUw1sQOVxsJJf+8/zetlh/J2mCa1et3GSep?=
 =?us-ascii?Q?T+QSPiF4V4yGjGLAi5jt1nhqnj6zcxe9497aX6U1DWo6DtOytorCQPoYGM+b?=
 =?us-ascii?Q?ZDZFuGRvEqzo6w6cANuhTpKjXFcDLmlmzINKyCLRSpYvIv+JHQSBPwVPpekt?=
 =?us-ascii?Q?TbbZGQyDlJVcOOqnoTa7bOo88hreGHMgbj+3F3nVwYl4cyQcqMDOxUT6Dg1h?=
 =?us-ascii?Q?hq54NiyCC7rPdM+a0Rd3DBQ8pb2AmzQbS1jjcTn5YpZxJjwRye3aUMDaon0W?=
 =?us-ascii?Q?gm6m/OoNzTX4TJ0JxeRcSPY2RbF8RXPXhIBpvKvzzUkkfPd+/RzKao55PnWR?=
 =?us-ascii?Q?8tfb8/DMEg4cQ2s/spu+3UrXppqdUw7lz0xE22eZNQWGWiMpUDpHBT4QZbJT?=
 =?us-ascii?Q?gD9RwjKyMi59R9KvZzf4MvnRvMAHriJGuSdKkRtfgzjuqL2EpxsvOyGOVugi?=
 =?us-ascii?Q?gMxpH0+IxVwUyfMHKpnfg1BKtZ4qV0TwwvV1KQgOdN5/bf23rDrCZIkh9Bjj?=
 =?us-ascii?Q?ceA543sxI1tSN6MytBwXnwQJpC4pJSAIqr8RLo0t+cg66XuWZ2h/9DpTCIig?=
 =?us-ascii?Q?iJKqPj7VpKllUISbM70WSC5beg5+FNc0s6IP/gBfmac4BpXGURinpEm5R/gW?=
 =?us-ascii?Q?PoYOHU+N9wb3sQg5YzOR9IbtUaU3+8Sn+INALRiyxJGzYMO6HGeMQ/ZUyuCO?=
 =?us-ascii?Q?i/zDxr6vMPH5sWoQIZQ4CeOa5GglPXoO8negUnT9DRQzBBdanLzy3DxHki2g?=
 =?us-ascii?Q?4q62p8YI3aBEXGOKvsPbt/cNkCSQ6F79Urf4oK1/50hvRjABSG4Ev2kXF29i?=
 =?us-ascii?Q?F5of241APqgbNgoM3OgFhbfSL2/zj+GQaARb3nGQ8c7RRjwv5wDxUXQdDZak?=
 =?us-ascii?Q?IJvH5JoHvUP0MmEVwfVxFLbJKnns6KzwIe41Q5BPn4/ke6jRr+3707dQz0Qm?=
 =?us-ascii?Q?SP+F5oz+WISNszjsOhbXYGfslcaoaRl+shRgCfxcrY/G2DYunyW7zYjHN0/2?=
 =?us-ascii?Q?0+FcgOP6HnugoBjzTS+aSbcssSoE6aQ2359FumjC5+E6Ei75mfBLbn8c3ukD?=
 =?us-ascii?Q?5qYwr/DELlCHCwfhJxKVqlyOE2+TbB8iCoE2K+TJye4ijG/EYyu696YkTeEn?=
 =?us-ascii?Q?LsxX+ECiqWzdQdAmWDwlvTCfdR6hLzlCXvkRmWIYyHXHTc6E9JLAu0O9KbEG?=
 =?us-ascii?Q?RmaGllPTgWbzNhCkfHBmSs8zwhwwgGe85v67gVcwovNl5H/lmXM4drKPJuB8?=
 =?us-ascii?Q?PNot44C6WXBCQDzlQ132wZu/qFgh5xpAs28riwmiluyPivVETEcbzB4Wm+Ki?=
 =?us-ascii?Q?dJEU0GsACIcCQPfq4gSmrmtWQDADmwE7YN6x?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bCmXuTHpPVOSgtrpxzz9kDJFBkDz+LbeOkKScO48TLsasrDu2JFywVoVo4ym?=
 =?us-ascii?Q?Vli/wbEb6+bvHquy4Gt9u9GPXYVDrfATsYE8K4mMvUBOdEQXlXtbTS93snn/?=
 =?us-ascii?Q?E2icABjdNKysHx5JoKeA/HxQJQB6OhiBK24Eu6mhITzRLp9BL+RWN0PJvgMw?=
 =?us-ascii?Q?u7G0Q2GimIfy089LaUYa7A9mDeMb2DsH7MCieKpWUQ3qzqPm1bSI93XTBtlB?=
 =?us-ascii?Q?QPHPz7TzqM8PnISV2vdrRzVLVV868nIx0NixRpftXHTU+gt/+/ASD8Lw5a8n?=
 =?us-ascii?Q?pq+pMIYzHne0STtDXcx/fxaesTk1I5LcB5eW2AwkyE+wahEYpeKHVc2lmbHV?=
 =?us-ascii?Q?lTYx86CicUXAImiki3wQmZwMsvj/9EUqbQb2JgHxTfrxeUO+aTHQ+cONZHPn?=
 =?us-ascii?Q?Wr7ZAiA0uxj6rFIE3WedTlwI9PAXWxFX/d+A6akjMHMRfGhlUMRtgHlO+EBJ?=
 =?us-ascii?Q?/6eMfvm77b6RLUHDWx10sOIstWeqYQRSMMu5b2kcwBuf9k2SaPcuTSkkNbad?=
 =?us-ascii?Q?f6cry0Ih1tzxLsP4XeRwcn/2k2ECq4ciuERUNI+ldRVklo/KcI38p9m7IIv+?=
 =?us-ascii?Q?eByebO5TuvIIiWQv6HArxwCvhWkqyGzGLFWum2fZNdKG+nidR7rKFKNiuepX?=
 =?us-ascii?Q?gaabKitviJUzY5R55Rb4sNALQE4gXovvrpIlcHsZYHpeYjlNWkjeFWWj+tt6?=
 =?us-ascii?Q?zgAqhLnGpbJB04vJVAzkNIjfIZHwALNXFVvqLs2PWXdMtqtL6ZGutvtOu746?=
 =?us-ascii?Q?EbtZlRS9U7Bekb3eOYLSzj1pXGMgjHdxBLN5d6S63ry9EIGpN2ram29lPbJe?=
 =?us-ascii?Q?XAotBwpcML6wDjMmkPmh7e8w0oY/HWBkhMBi41VOLBmoKfvlDB6muYonEcRo?=
 =?us-ascii?Q?dT8XfM/7zBd5YL5oBzaZ5OVI8sC4kRg2eULnyC5Ik6QmnnTNP7vY4FM8PgGp?=
 =?us-ascii?Q?HvUXawQ6iBhp05F6qYmalNJihlF/Jxv8IodlermlqoeWZbmsjn62YhMie5kr?=
 =?us-ascii?Q?L8yWK6h64jJ+fUgxAAZdFWHwvPPbvCK7MiLxvVxS1KvfXbWOCRWV1j+5gu6j?=
 =?us-ascii?Q?p6n2KXPUenz6NnKcuAqPpBmTouBH6v/VAA3NJT6pPNZxAw/glLR0q8YWjD72?=
 =?us-ascii?Q?ydLSPIEIvtmiOO0XvVWdcTA16mi/od5qFPjsxb33qdxeEWNlpXIIJY3QQwEn?=
 =?us-ascii?Q?LkKatax+svIa84UxXkn79i6Xm8BuzQ+T2heSuDXSAoqjRoNPJeWbm7F6K1QY?=
 =?us-ascii?Q?P9jb7rODYWB9wLbCarG5QsNzw4KbNx1ugtbdwTp4NiplQCLkQMaKFxxKw00w?=
 =?us-ascii?Q?SutxyErfjUQApQNv/EpQaNN8zcr8epOZn61Z5xg4qhux+WaopYJl+QvEX9sq?=
 =?us-ascii?Q?srdB+c4OOrKxpBYElvbyJY5LpsRJIs7+RBsoRQrfQN+fKOa0nJBCx0r9a5ef?=
 =?us-ascii?Q?p9NUxQPJM9CN826BIa2mybNnrnGOE9wjokRzAt2mOl3o+3JXKZw9yViZ0pZu?=
 =?us-ascii?Q?85SbHeNKJ5P5o6UR9lhWzpaN76occq9FMfk4vN0HscyNK0CuRP15cifoV1AH?=
 =?us-ascii?Q?ExyU/72ZFFGKzPpO37uD2AxS3/ogAtZuWZHZsUi3vMIxKSkr2GD8lBqNlBVe?=
 =?us-ascii?Q?zLIqe4W8bIM3ovM+bSyHeDBGAk4tSX7hRf3ANQz3s3I0vDXroUp5OyEjBVs0?=
 =?us-ascii?Q?1bM9J/jhZTEcs8mBHeMNWgbyBg5LxEGmqVj1wtOqyU5GnkvC29KuzpHXKZ6R?=
 =?us-ascii?Q?FkvkJ3wr5n2K4CSkWrzfJUda8U1mjhaVAatp68MiYNZ6RRy387oAASZGDOxM?=
x-ms-exchange-antispam-messagedata-1:
 5F2qcqzZ3y4esmawAy0u6LK6VXi2dtCxC7O9OOKAaVky1MFj0RYO72DJOUfqMp5e7llzAwaQeqrOUQ==
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082C7171807D783172246109FBEAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: db32488d-f53b-43a3-5dcd-08de469f868d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 06:00:10.3739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAFe+U4uegzGFLRccj3JUhqEyu73F5L/Q+kRZkbZYNe047uc/zY6X1vSA/pliG/nkM4vzJYDMtx2YECpyHTgVZz4+j7WQBSF/w1NPd/Pbh2AqyWPPoxyIhZtZbVnbw/S4li3ggPe4jvuxy73r+OtAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4P287MB4653
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082C7171807D783172246109FBEAMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082C7171807D783172246109FBEAMA0P287MB3082INDP_"

--_000_MA0P287MB3082C7171807D783172246109FBEAMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Please find the attached patch which adds an ARM64 stub for the `sigsetjmp =
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
index fdb970f6f..f85c8cf74 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -611,7 +611,28 @@ EOF
        # TODO: These are only stubs, they need to be implemented properly =
for AArch64.
        return <<EOF;
        .globl  sigsetjmp
+       .seh_proc sigsetjmp
 sigsetjmp:
+       // prologue
+       stp             fp, lr, [sp, #-0x10]!   // save FP and LR registers
+       mov             fp, sp                  // set FP to current SP
+       .seh_endprologue
+       str     w1, [x0, #0x100]                // buf->savemask =3D savema=
sk
+       cbz     w1, 1f                          // If savemask =3D=3D 0, sk=
ip fetching sigmask
+       mov     x3, x0                          // save buf in x3
+       sub     sp, sp, #32                     // Allocate 32 bytes on sta=
ck call
+       mov     x0, #0                          // SIG_SETMASK
+       mov     x1, xzr                         // newmask =3D NULL
+       add     x2, x3, #0x108                  // &buf->sigmask
+       bl      pthread_sigmask
+       add     sp, sp, #32
+1:
+       bl      setjmp
+       // epilogue
+       ldp     fp, lr, [sp], #0x10             // restore saved FP and LR =
registers
+       ret
+       .seh_endproc
+


--_000_MA0P287MB3082C7171807D783172246109FBEAMA0P287MB3082INDP_--

--_004_MA0P287MB3082C7171807D783172246109FBEAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="Cygwin-gendef-Implement-sigsetjmp-for-AArch64.patch"
Content-Description: Cygwin-gendef-Implement-sigsetjmp-for-AArch64.patch
Content-Disposition: attachment;
	filename="Cygwin-gendef-Implement-sigsetjmp-for-AArch64.patch"; size=1698;
	creation-date="Fri, 19 Dec 2025 16:33:32 GMT";
	modification-date="Sun, 28 Dec 2025 14:00:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiZWNmMDgxNmVkZjgxODIxMzAxZWZlZGE1YTIxZGVjNDg4NjIzNWIy
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE4OjEyOjQzICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW5kZWY6IEltcGxlbWVudCBz
aWdzZXRqbXAgZm9yIEFBcmNoNjQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVu
dC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJh
bnNmZXItRW5jb2Rpbmc6IDhiaXQKCkNvLWF1dGhvcmVkLWJ5OiBSYWRlayBC
YXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KClNpZ25lZC1v
ZmYtYnk6IFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5uYWdh
bGluZ2FtQG11bHRpY29yZXdhcmVpbmMuY29tPgotLS0KIHdpbnN1cC9jeWd3
aW4vc2NyaXB0cy9nZW5kZWYgfCAyMSArKysrKysrKysrKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiBiL3dpbnN1cC9jeWd3
aW4vc2NyaXB0cy9nZW5kZWYKaW5kZXggZmRiOTcwZjZmLi5mODVjOGNmNzQg
MTAwNzU1Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKKysr
IGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZgpAQCAtNjExLDcgKzYx
MSwyOCBAQCBFT0YKIAkjIFRPRE86IFRoZXNlIGFyZSBvbmx5IHN0dWJzLCB0
aGV5IG5lZWQgdG8gYmUgaW1wbGVtZW50ZWQgcHJvcGVybHkgZm9yIEFBcmNo
NjQuCiAJcmV0dXJuIDw8RU9GOwogCS5nbG9ibAlzaWdzZXRqbXAKKwkuc2Vo
X3Byb2Mgc2lnc2V0am1wCiBzaWdzZXRqbXA6CisJLy8gcHJvbG9ndWUKKwlz
dHAJCWZwLCBsciwgW3NwLCAjLTB4MTBdIQkvLyBzYXZlIEZQIGFuZCBMUiBy
ZWdpc3RlcnMKKwltb3YJCWZwLCBzcAkJCS8vIHNldCBGUCB0byBjdXJyZW50
IFNQCisJLnNlaF9lbmRwcm9sb2d1ZQorCXN0cgl3MSwgW3gwLCAjMHgxMDBd
CQkvLyBidWYtPnNhdmVtYXNrID0gc2F2ZW1hc2sKKwljYnogICAgIHcxLCAx
ZgkJCQkvLyBJZiBzYXZlbWFzayA9PSAwLCBza2lwIGZldGNoaW5nIHNpZ21h
c2sKKwltb3YgICAgIHgzLCB4MCAgICAgICAgICAgICAgICAgICAgICAgIAkv
LyBzYXZlIGJ1ZiBpbiB4MworCXN1YiAgICAgc3AsIHNwLCAjMzIJCQkvLyBB
bGxvY2F0ZSAzMiBieXRlcyBvbiBzdGFjayBjYWxsCisJbW92ICAgICB4MCwg
IzAgICAgICAgICAgICAgICAgICAgICAgICAgCS8vIFNJR19TRVRNQVNLCisJ
bW92ICAgICB4MSwgeHpyICAgICAgICAgICAgICAgICAgICAgICAgCS8vIG5l
d21hc2sgPSBOVUxMCisJYWRkICAgICB4MiwgeDMsICMweDEwOCAgICAgICAg
ICAgICAgICAgCS8vICZidWYtPnNpZ21hc2sKKwlibCAgICAgIHB0aHJlYWRf
c2lnbWFzaworCWFkZCAgICAgc3AsIHNwLCAjMzIKKzE6CisJYmwJc2V0am1w
CisJLy8gZXBpbG9ndWUKKwlsZHAJZnAsIGxyLCBbc3BdLCAjMHgxMAkJLy8g
cmVzdG9yZSBzYXZlZCBGUCBhbmQgTFIgcmVnaXN0ZXJzCisJcmV0CisJLnNl
aF9lbmRwcm9jCisKIAkuZ2xvYmwgIHNldGptcAogCS5zZWhfcHJvYyBzZXRq
bXAKIHNldGptcDoKLS0KMi41Mi4wLndpbmRvd3MuMQoK

--_004_MA0P287MB3082C7171807D783172246109FBEAMA0P287MB3082INDP_--
