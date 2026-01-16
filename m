Return-Path: <SRS0=c1qK=7V=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 7D4174BA2E1D
	for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 18:00:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7D4174BA2E1D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7D4174BA2E1D
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1768586412; cv=pass;
	b=GpO9+1CqvItg/+AzR8MAxAJOshTn8CqMOjC4EpWyIRkfFbeUKpA9q4HUX+xKZzh8wHGBSvRCYi0GzPn5FHT7GVgsvkqPn9RiuIdE7p9mNr1eGDF3ZV94lnF+MKzQFimBCDuYaKu2eM2XA+16IFBeaAExAl1uXxpwkJulz4BhKC4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768586412; c=relaxed/simple;
	bh=hbUcdU6W6Qc723gw8mtIPBRj2scNyqf5mGilk4OgoCU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=oNJxRxMyh/c8e87utAS+8REcF4PYJ4B7Qbx8sax9hED/lURGH728Tvi0QIDh7Oqs27qLDYYalBpcOHlMXD3rvWHs1BVfMl/MWVr80evRyiUcHiTxroW8tIel63FdtvQRRbw6Gn+j8rl+iMMRR9hQbAJIVmSJeEOcM1cwZgVgczs=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7D4174BA2E1D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=3KsmnNYs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDM10W7Sc7erpKnr+2zDLyZq7ow74FA+UQYP91wifIJ16kiB+5Gk5Q9OJzSJAH5qpvWG/1EmJ5roqZFZB8LiFRDGyKzwuqPbv7+k9eyuKSPNoEys7selXyg2VHfbOIl7llHxcAihfAhaMtBB4AUGYVMRjTUxmR+5TkVWASDCO0PqwTVhtCSQsBg3ci3M6omuJHg2lx36UPYu0XX47C+09Ayl9QjRxjfT1TxlzBnpkiY1K/96GfiPW2fatEEFXBr094hIcak85PSAr4XXUs6It0c0JcJS7SML52C4UC+L3+IQHVFD/NYvFMNMyHZEvCSYnwOJ2tzFRNU7FQj/FBK8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLVVeFM93pz1hpxND9eapmYJey7EBP+/O1CB43ApUhE=;
 b=f2TTTLlR2iRsXA2BrDGBhpCvDRz5qR5KY5H6bc5ySJFkMeZs/0Un6fHEgG5bmo2t3L0C96HtYq0YCKAKOdYTXUKyIGgLuxWaWoIRb6hhx7jzL3NfZR88zNzujiTSCMerYjPFOnIMKEck0Bx+RbXHLuJ61Bi0BJ3bjV8eRBfEOfgyr5Rwg3P0AYE/x2YLgMHh9eb5vxOaqTw7tZczIHctX8+gVLy6CDee1xgMXa8KsDYyW0/NgVCKCRvQx2my+6+I71CbTPw155cLgQSt5d/rsisa4tJSGGDYlNfg/xYk3vyGkQkBYVXrv7RSKdib8RDGeY+PQtUwqTQiyJEHH4kM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLVVeFM93pz1hpxND9eapmYJey7EBP+/O1CB43ApUhE=;
 b=3KsmnNYsrz9aqwSc9cO0Spunze4MRRVo6IcyBdhHiQxQjTTpKVVEzOmYJiZnPNpfe95wom7fJSML64cXpFKnQGYm/WjE5c2Bz4n2zaXyRxxmooRBFvEwA6/yFku7iEVCyFO+WyXNkgp8vySxhemjLRzxb2FwUS3m/hYWCFjynFDC2xyA0XSdJqotgjTwXDgow0Vbc1jA7qSHFj2eubA4mFflmALN3aryDwOtf628yvoS7yw9poYu/myWFj49qFMc1FrzJNaa7Q0vtvS/OuwkQuLaA4/jC2FajWSsg8ThnSSrVLZX7GRUnHYBjZ7CeWIzWqJJjiWLy49qHHm/UQcu+g==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MAUP287MB4896.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.5; Fri, 16 Jan
 2026 18:00:08 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%3]) with mapi id 15.20.9542.003; Fri, 16 Jan 2026
 18:00:08 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH V2] Cygwin: gendef: Implement siglongjmp for AArch64
Thread-Topic: [PATCH V2] Cygwin: gendef: Implement siglongjmp for AArch64
Thread-Index: AQHchw4vjwFSz+9Np0CpAHSPBKgAkg==
Date: Fri, 16 Jan 2026 18:00:00 +0000
Message-ID:
 <MA0P287MB3082EEAE12EC340F1EE5D6269F8DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB30829116428B3B2900E4CC3C9FBEA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB30829116428B3B2900E4CC3C9FBEA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MAUP287MB4896:EE_
x-ms-office365-filtering-correlation-id: 9b26619a-c1c7-40b1-acdf-08de552915e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|4053099003|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C8yoeRqwISwHyIXMwlP2ptj+N8OGmS8yHtmKh7gOcTh9aAzGOschFKyeHduv?=
 =?us-ascii?Q?v0OG7tZa/W9x8yzw0jG+kxbWFQmzGJrh9owUzexPOdowMzucvxPgYjbYf4K3?=
 =?us-ascii?Q?x+fdVxJqNfS4dhS7t2DQ71yHYJj86KxG+pyYxtZoHiKVtKIKm5JxC4My14kb?=
 =?us-ascii?Q?JuPsgrJWthv5erEErp+Ia7MHcSQsy0tP3b4YfjfTL9xfuHzUzngI0eNPXx4W?=
 =?us-ascii?Q?2K26flcbGe4JUhDtgWbAfUwQH9jG+mq4vC8tWXhlts5jZ/uJinoMpHZJm+tf?=
 =?us-ascii?Q?25Fmjr/qgzbR+7OQPzIO8jvjrjsrbw54XxhNVPKz2BU+7wxFH8sKJ1RespFb?=
 =?us-ascii?Q?oxQ/EuMVb+bv+ASgbcCEayMSogXk4ZP1yE6y69wvyh90aKsuZ0Br3L1gk+Tv?=
 =?us-ascii?Q?3qVgz1/0KDPDkjsZE2VFCNe2CKTx/eXt9rJJlCGC1qk0twWnpzArJAMYNSp8?=
 =?us-ascii?Q?wSV9f1yblMiQTU3W16bxchEv9sHdBP3Yg+dRRAcX/Ukp1gvqPvi9alMRbV8Z?=
 =?us-ascii?Q?fJby8eGJHKx79xgtRG8NhL7g+fVCUkezAeErLXYokdKpaC+78Q/Oiz7QYc7k?=
 =?us-ascii?Q?XfkLfGrEgXCP0nmnIFS2KOhg503ohVW9HLJjpfndLO0RJ/aEJnJMQrRlJswp?=
 =?us-ascii?Q?9FSa76YpTlEFNdq2BEi2E1hbhxSOuulpKRmrZJ6BcKg1yF1STUN1+Cn0DlYl?=
 =?us-ascii?Q?MK9djBrppgwV7dYDdQg4Oh9eR6morhLklVADHNZMfBf5ra3lGLTQM5c1Hy/s?=
 =?us-ascii?Q?tW4u7UBsTPsW9rEWC6YPscb+Q7YK7DEHMzaYqM8ge1/Fve4Kx8YJBPtRFBxP?=
 =?us-ascii?Q?4lxO9jivlTW2LgV/qiEiw6ksCtNTcbpt7lDSOnAU27J1JDFQvlRoW8WE6cFI?=
 =?us-ascii?Q?2WU/ZJaqvLcjUPXWitGiZtFV3ql6m35i46YEhlxQULnRsQYm+q3K+gueT7HJ?=
 =?us-ascii?Q?k82AlAyn5wyWBF8lugdPfnLjGxrXOH6L554ZoN5+g71vonxpZyJu/lbhN7QT?=
 =?us-ascii?Q?EUP3aKvYoLVcWTSLBhyE81qRgJCHnlSrtfHp+GBB01Uu7elBLukNnr65olJA?=
 =?us-ascii?Q?CCFmem3MKzEIsMBaVrHeJIK9A50zdYZWs1qIqFYmJo+snxBA61RJ7nuxTTL9?=
 =?us-ascii?Q?esJc4hkLRarwVHkF6dNV80VpSCSjAjiWmIX6UxbkiNBvUFwqZbwvO2cqRbV+?=
 =?us-ascii?Q?FOzUCalYT1P7t1cpwEYkB0KszKv2lm5hicS6CzxMMlxnvjwappaCk8cR/5/G?=
 =?us-ascii?Q?NOzFmMg/a8rfHLFLdR7+zC4l/ounn5SpDX4+ZXsu3t6wdEE9Y38aSnLE9b2T?=
 =?us-ascii?Q?DNz86Fllg2m6hmnenqA1RSZBar63GuagRulwexcJ9o9gWDYE6NslJwvXFPms?=
 =?us-ascii?Q?0V2z4U7BDt1tM0bVkfKRbZ1OMYNQK7iU8/4zFTIeNBhDAiimXOFO/0KZ6A2N?=
 =?us-ascii?Q?DT/JDzj4d4mJvh3dWONKkVPQ5KtUIx9yVTf4vDi5UsnhjmELNzO+JkxxgtHA?=
 =?us-ascii?Q?fMsdCqybp6X30zMEcsZ62cY7L/EQOC0HeY5Jtq1jqjKpSR5Xgtsq7EINOxbd?=
 =?us-ascii?Q?JjUaUdD/WcT8wjA1dX5EBN336D1yBh+PYIOxXumccWfa1nZA9g6wN9pdm3Oe?=
 =?us-ascii?Q?z3uGJYsrdj0WINanFZGAk7c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(4053099003)(38070700021)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9mEKNNwgfBzI6vvDR/CxxbMGevPx6ZOVO9PdSducuFLvSTqalFoU/u5W484S?=
 =?us-ascii?Q?+Q97tXcvvIvcwv+pvAQkSGvw1WqeEv/kSSMcmUi2UpvYcuzJiKCB0RloxY4f?=
 =?us-ascii?Q?3SI47YAxrFq9fktv1na4hJzdOTDiaJMJDqhTyDxNva1qYGiD0roqrlLit4Z5?=
 =?us-ascii?Q?evNW5YxLLar9xI5WpYtgJgCJMePgnwsJwEOo7yfOoC9FN+30AzjCAKhY+v2V?=
 =?us-ascii?Q?lFq252Publ5/XSU8/ispgu8ROtEgdXq/7mwvwZ2iAfVOnVXAlRTlX+CiG3rL?=
 =?us-ascii?Q?Y4XLdZ/8vx2gnCb6JhyXyBFmrdus3jNoHQrdLFlaQJK2oJEsE2JUb1SH16nu?=
 =?us-ascii?Q?+0smGFYDghscQpWm9r8lR34NYTUfOEZUiYqr53+0CyA/SIT5D0+rStSlwoJB?=
 =?us-ascii?Q?2vr87wlj0krDGJQsPmD9TzZgsk3z5y/t7P/bjNg2GjtDzaYiRZdZuOHVyMDn?=
 =?us-ascii?Q?bj1Qs/YyVdmbxwWCPgoM0pFPCNVI7zcZIMchxOvHIqVY3r9qPhbpDFv38Kto?=
 =?us-ascii?Q?5vGN+rRHTeLXxU4RdoEaJCZP/owsSguFWllGLO4Uk/yRiNitA338wfIIMar5?=
 =?us-ascii?Q?5aHXsSTHd3znOrjVE2/q/i2Hy4taX2uF1A2BVgztqkOxKrofG6OIC4+GF6zn?=
 =?us-ascii?Q?gbLfndpWC2btAmpcSqA8e/JCgWd6a/iZA927Ma8tAZF8krOkPl+1iGiL609A?=
 =?us-ascii?Q?reafn81TQEahvo8P20JgEYqY6YJhxrAW4uX210qIosyH9qC/sbvd2hWj66q4?=
 =?us-ascii?Q?9KZ3RU2ysZwaT1n/sSSDFvTFrRxrykVhYP+TCpwdMdWIfcHgdEvCZalgbZqO?=
 =?us-ascii?Q?MrBbeE9/FrYwDy4+k6NY3GQhcxsnIgSfgoc5pgvznZWttFz5kL4onB7M63SY?=
 =?us-ascii?Q?WOsRnq0p+kxV5fvklM1OTvjknTZSFFbEghBbqm6ckH16zXbHwu6NBaRpHZbQ?=
 =?us-ascii?Q?gjk1TZyvGtEeiUsAW1UtbtlM5zD7Xtef0qCeXNeHJBLjP3FRX1bC0Ikc1+09?=
 =?us-ascii?Q?fB0Nhvp1mA0+ePmF4CNtjVJQmHluk4Hvc04ujXhv9uMn15+dMkQSqjWplcCa?=
 =?us-ascii?Q?GDKM/UjH4ZnOpgq44ufSIKWjtOgXJwisreoYHV96KccxvxWPS5HOuEJmcefA?=
 =?us-ascii?Q?GTwSLHTmVoHsqpSDHwWBuJoy4aEvxS1/RvOal/SD2VHVKj0UAF0xmLlCKaWH?=
 =?us-ascii?Q?h9F/zlEJywJPqDAUpWEblRpDvPPEsg2uSyVEfCBYdBXawyMWNiwxvba0tl0y?=
 =?us-ascii?Q?LZXMJp1hyT26xPjqp9brn9zvP3Uh2nygMm7sa8s/cD6DkcdqvktMqOAFbjld?=
 =?us-ascii?Q?njX5N+njwx6uHPRuZy947ntlvQRLZPy7Kbacw2PJa1GraNJRMcmwX+I5bfa9?=
 =?us-ascii?Q?CLI8ZWwkqhP9y2I9sKYIrLwSBMV/WAqwdLpKzMDdWzzqzRIjcHw4ReYZEgQF?=
 =?us-ascii?Q?UxJlseKESivCNDyo2Umm5Tj+VeNgsS/ajEjjdRhpz1ag7Q7IogEKjhXaI1BU?=
 =?us-ascii?Q?u5AgNFytBlvX5+bCZYm+xF0W9+O4Z1Wz1GP50YYy21JLdW7Vdwcv5Sek64EW?=
 =?us-ascii?Q?TXrSL+iSYoLrEh7jgY+zoeTnJu8CQwfrYHa2Bg93PDN2m0x0txx8jquh/sGZ?=
 =?us-ascii?Q?I0n9LK51rfSYUiOYMVGScXnpDG3WvyqSehxe3/8Tntic52oaSrhQozPIPxRo?=
 =?us-ascii?Q?l0uJUnRWRT3Q//4jkIn5brEEEEOSwQeBlF9QkNLGtoq4rnbDvXRJSbqu1Cle?=
 =?us-ascii?Q?P6ThBAtfpwcqoYFEbiwwNwOzEaRWEtiU8yu5WiojBUt7E8dbffXL7rw8f/v9?=
x-ms-exchange-antispam-messagedata-1:
 NJMHAZR1TwwdwRnhRjhX+ZcKILhObnFRjOQMsJidFrF/+5TqFnPP0Ilq8rz44qhdGlYz20c2puJ27Q==
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082EEAE12EC340F1EE5D6269F8DAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b26619a-c1c7-40b1-acdf-08de552915e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 18:00:07.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /y3Nvem2G2+dqmbkfrtmU1ZG0NcVzNY3Kfu8hxP9FcWQLMqqgK29IHZEC0lfH5WgjeM2yEYtia/csaQf5gDQGQVUztFfU7iK+2L2y7eGfSMQ2XlU0Tqm4Rzf/kiqNRAWTPNuRrwu6l30UMHFItCeDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUP287MB4896
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082EEAE12EC340F1EE5D6269F8DAMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082EEAE12EC340F1EE5D6269F8DAMA0P287MB3082INDP_"

--_000_MA0P287MB3082EEAE12EC340F1EE5D6269F8DAMA0P287MB3082INDP_
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
index adb3ed217..b0e4d2a3e 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -611,7 +611,33 @@ sigsetjmp:
        .globl  setjmp
 setjmp:
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
        .globl  longjmp
 longjmp:
 EOF
--
2.52.0.windows.1




--_000_MA0P287MB3082EEAE12EC340F1EE5D6269F8DAMA0P287MB3082INDP_--

--_004_MA0P287MB3082EEAE12EC340F1EE5D6269F8DAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0005-Cygwin-gendef-Implement-siglongjmp-for-AArch64.patch"
Content-Description: 0005-Cygwin-gendef-Implement-siglongjmp-for-AArch64.patch
Content-Disposition: attachment;
	filename="0005-Cygwin-gendef-Implement-siglongjmp-for-AArch64.patch";
	size=1674; creation-date="Fri, 16 Jan 2026 17:32:07 GMT";
	modification-date="Fri, 16 Jan 2026 17:33:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2M2Q4N2JmNjhhNjZmOWM1MTVlMGVlNjNiNTFlMjM5YTYxOGQ2MDll
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE4OjE0OjA4ICswNTMw
ClN1YmplY3Q6IFtQQVRDSCA1LzZdIEN5Z3dpbjogZ2VuZGVmOiBJbXBsZW1l
bnQgc2lnbG9uZ2ptcCBmb3IgQUFyY2g2NApNSU1FLVZlcnNpb246IDEuMApD
b250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVu
dC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKQ28tYXV0aG9yZWQtYnk6IFJh
ZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgoKU2ln
bmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFp
Lm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3Vw
L2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiB8IDI2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYgYi93
aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCmluZGV4IGFkYjNlZDIxNy4u
YjBlNGQyYTNlIDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMv
Z2VuZGVmCisrKyBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKQEAg
LTYxMSw3ICs2MTEsMzMgQEAgc2lnc2V0am1wOgogCS5nbG9ibCAgc2V0am1w
CiBzZXRqbXA6CiAJLmdsb2JsCXNpZ2xvbmdqbXAKKwkuc2VoX3Byb2Mgc2ln
bG9uZ2ptcAogc2lnbG9uZ2ptcDoKKwkvLyBwcm9sb2d1ZQorCXN0cAlmcCwg
bHIsIFtzcCwgIy0weDEwXSEJCS8vIHNhdmUgRlAgYW5kIExSIHJlZ2lzdGVy
cworCW1vdglmcCwgc3AJCQkJLy8gc2V0IEZQIHRvIGN1cnJlbnQgU1AKKwku
c2VoX2VuZHByb2xvZ3VlCisJbW92IHgxOSwgeDEJCQkJLy8gc2F2ZSB2YWwK
Kwltb3YgeDIwLCB4MAkJCQkvLyBzYXZlIGJ1ZgorCWxkciAgICAgdzgsIFt4
MjAsICMweDEwMF0gICAgICAgCS8vIHc4ID0gYnVmLT5zYXZlbWFzaworCWNi
eiAgICAgdzgsIDFmICAgICAgICAgICAgICAgICAgCS8vIGlmIHNhdmVtYXNr
ID09IDAsIHNraXAKKwlzdWIJc3AsIHNwLCAjMzIJCQkvLyBhbGxvY2F0ZSAz
MiBieXRlcyBvbiBzdGFjaworCW1vdiAgICAgeDAsICMwICAgICAgICAgICAg
ICAgICAgCS8vIFNJR19TRVRNQVNLCisJbW92ICAgICB4MSwgeHpyICAgICAg
ICAgICAgICAgICAJLy8gbmV3bWFzayA9IE5VTEwKKwlhZGQgICAgIHgyLCB4
MjAsICMweDEwOCAgICAgICAgIAkvLyAmYnVmLT5zaWdtYXNrCisJYmwgICAg
ICBwdGhyZWFkX3NpZ21hc2sKKworCWFkZCAgICAgc3AsIHNwLCAjMzIJCQkv
LyBjYWxsIGZyYW1lCisxOgorCW1vdgl4MCwgeDIwCQkJCS8vYnVmCisJbW92
CXgxLCB4MTkJCQkJLy92YWwKKwlibCBsb25nam1wCisKKwkvLyBlcGlsb2d1
ZQorCWxkcAlmcCwgbHIsIFtzcF0sICMweDEwCQkvLyByZXN0b3JlIHNhdmVk
IEZQIGFuZCBMUiByZWdpc3RlcnMKKwlyZXQKKwkuc2VoX2VuZHByb2MKKwog
CS5nbG9ibCAgbG9uZ2ptcAogbG9uZ2ptcDoKIEVPRgotLSAKMi41Mi4wLndp
bmRvd3MuMQoK

--_004_MA0P287MB3082EEAE12EC340F1EE5D6269F8DAMA0P287MB3082INDP_--
