Return-Path: <SRS0=lyac=7O=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021096.outbound.protection.outlook.com [40.107.57.96])
	by sourceware.org (Postfix) with ESMTPS id 819644BA2E26;
	Fri,  9 Jan 2026 09:11:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 819644BA2E26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 819644BA2E26
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=40.107.57.96
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1767949866; cv=pass;
	b=vjrQsGh0uXysVDlTUUTmR7ErTkDfW4OKE9gUxNaF55vNXeHSJxulk1VqRDE+vakYERL8JUW4XA/0eXfgxXmRIe8J/cBPJi+/+vGLS165aFM1BO1xppYll1qlbwQVCXtdlhqZW8EyaI/xUaeu57ZUILsvg/9ipJw4SlPqMA4RFkI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767949866; c=relaxed/simple;
	bh=w2suQ+1DfIlJUrr2E3G1uSPHfNG1I33GhiOieKIGjc4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ok6IAinhzOAphhY5ZtqQfQrbIc6Ht46WHgNrHnbDDvLYsee2sC+unonxx1OwdFkqMXvdp5UZATK5PEMxewsoJN4lcUvBDZmEHS54ugyEAYIAry3vHD+n/q71VJMBETdp4Ze+zVHQlk5MlaAK52S0n4N1zv5VIoUCHLMABa9aIy0=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fk+kX4y8mPiUQAISDEJ4Go2C3uStlZRsIJ7xPoD7+/jxjmF1LJ5+t4StsbwVm0IuTkckLeK0YIn4Az9Lsw1YH5gl8u56mLMSRyuHaZWMzFwNaNrDsizOjhjF0meqZ02aGQd2oYAaXNtRDPqmSz4Of6lZnK0Fe5LkeUTWPyioL2xE9969lDMjNU94WFDneo6b9FEzCNH/F6nvvS/+G1wd2bCg19dC6td1tjO3rUQNivd+5PA18NqpriY1YmK7ImrceXhXk+ZUKXSDo/u9K1fU+IQPNoyDfA9y9EZxD0RvLAD6YvisyPHr7ktEIfsh1vx9VqdtvCNUMsBB8WTGGWkdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY3FxV/JjwpftFcl+WInwhnDLUtyXcfYk+z/1LBJ0lA=;
 b=C8Vr94rhi6iyW3l1qi5hHQEEdhcae3g4k7nEQkhAGAYjLGwreU09aEjlQIDOQdgEKdQ0G2YsUPa6vEyPplxi/+DbL0ObYH9kiUx4GLfGJ+nhihTKDhoy0QWZyZM3m4sd28tTbAZvMLxznGBIiR6ecP9346oOs23vcR0NBkzbsrvOH7cgY5ZxH9wsCllcgIuUOAEkZGbLwbue9LhrcXODH515CsU6JeXvYxM2Sc5GZQe2dApCVui4YfdDKIE44JxthFfOLDdpCeiIMkPStRIVur9Hd0c7bpbc/8LSyxrJGLWAr4xz4vYRI/rb+CGD66tHH9aywIt+jRuq3WyoIUTw8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY3FxV/JjwpftFcl+WInwhnDLUtyXcfYk+z/1LBJ0lA=;
 b=NiAlzZQmGJFPcP4ya7vUGXAtDaszpshBRMogna8epwdvASr4T7RRtgeXh1djBbfiZM7K6MJkGgbcDcLAWw6Miai6edDl8rWPNxdThYGjdQJyyGIS9oQ3ToyoRQkVLCh4ruCY/XuzBhvQ7hUIbqUNXUYy45Og+2QOgv1WJik8lNKiVNP7fcSeSs540YOdbDfLCqVGfcJea49vBJgRiZo1MoGCFxBMpAR9XL1xamoZOrK01QTwE8ri4zW2iJk3UeNPA+acccR3VeMIXjDhObb0AwqExdaoI6wP4XlCUIHc/9+/JTC8v1YEgSwWmKTFSrC2DRPwg8oDt5LHhydaSk2ggg==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN0P287MB1143.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:143::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 09:10:58 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:10:58 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "corinna-cygwin@cygwin.com" <corinna-cygwin@cygwin.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V2] Cygwin: Update _endian.h to handle unsupported arch
Thread-Topic: [PATCH V2] Cygwin: Update _endian.h to handle unsupported arch
Thread-Index: AQHcgUfeqNKynQv8CEm2gSrR0hQE4w==
Date: Fri, 9 Jan 2026 09:10:58 +0000
Message-ID:
 <MA0P287MB30825913564D694F3CE48D479F82A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB308241F2F6A8AB26A6249FB49F85A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB308241F2F6A8AB26A6249FB49F85A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN0P287MB1143:EE_
x-ms-office365-filtering-correlation-id: 8b981743-45bd-4a62-1e06-08de4f5f00c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|4053099003|8096899003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c6sg8nUiz3ugf1pUl+On5skx1HEt50C8/V21Fe9dkcNrJRPabTiSSNxzKdfm?=
 =?us-ascii?Q?fsZFRBalaFVu9UbBx2TBNzYfTo6gqW8Muu7TlPXPE6vx1I/rg90FfVPJYpaE?=
 =?us-ascii?Q?qcjm69RdV9ywCjG57GVMuNRyA9Ote9LthXaGbgMbKgNK3kN0LieTSUmEq7Jb?=
 =?us-ascii?Q?mWJSsssYpW7Ke+fqjaaoTTOpm5ffPYclhaQCCWTR6lYq/Vms/cXW4rY6O7JE?=
 =?us-ascii?Q?RqXRdYXp3ckOWHx9Igy40eKGJgrop80no/3eKwk4P+pOxibor93pGp74lCb9?=
 =?us-ascii?Q?x9LKXcWqDW+BrXN3YAGdr7kwq5zvMYGupm7VqKMFc4DRFd5mkmfvYBb+9oQW?=
 =?us-ascii?Q?BHIAllxiG6BfrjWvG0MkyLXIOEsrk/SePhAoIKmIpisEgJqysryZrW83/QA3?=
 =?us-ascii?Q?uhG8JH9I/FjJhtrnkzs2t+pYv590+zwI2wcupbA93zAex0m8T23TLEwdnBEs?=
 =?us-ascii?Q?1Uvry4nkZUXZWmaR5q3IMfzV+To3418M9o+Nk3ZIzUEpgrExZQP8+E/kAr2U?=
 =?us-ascii?Q?uMGfEVJdRykuqbQvMACWiSCEpco5u7RBRfHXqD9lSTGnXyEnLEuaMnNylx0M?=
 =?us-ascii?Q?e1UHqOgtzRv3u0Qo/IDSqFdQTQbV+gDaCu/JJNf8Jjn4sGohK/VHIUdOO0Sk?=
 =?us-ascii?Q?KbYT2RbEwdVs7PNBK++qhnZKbQM5FCgM/0Oc0oYXGnvl9SaFcpX9eT2RvN7u?=
 =?us-ascii?Q?Gs3MN7zx3UhF2Zsru5XgQj8WJJOtUdxh39XAEP/2O0nnmEEcxtaaD+D0TKtN?=
 =?us-ascii?Q?Kq2fa1mV8UqIxp6hH8hpvJSFhZdc4d64dSEDdU98Xf7lXooj49PsaLswTZRv?=
 =?us-ascii?Q?DGJH0XKSp5v3ULh5F75EAxkevn5HWYCUg8f69woTRTABT+Hl38IfYh2y9oKz?=
 =?us-ascii?Q?Fvsh2sfV6/GHUzbYxx1q99YC/0ZtbJXeljvJbsCGAihoNKkoSPe2W2mdpUtG?=
 =?us-ascii?Q?2yMCWYJlUHPvTwEh+CJtgeU0+OMesYYwnlU8RyS/TbahyvEWgyZ9dXOGhb63?=
 =?us-ascii?Q?aTHvA8a/jpGEAvUlEMhNsYIrHJ+a8d/B54oJNZXwBH3Jx7BNfEWS8aGDsvYd?=
 =?us-ascii?Q?MzSZ6tK7NnEpn66dAvQPS/GIt5oxyEescUafDHbhzVzpF5PMXCNyIpp26Ak6?=
 =?us-ascii?Q?QNdR+UvIMikdgRDJcB/PgvNCRr2aqs7RwEGYUPaft87bW6iLhGEt4932ptyg?=
 =?us-ascii?Q?chKH8xAOwStVGuMSV1ixpe33tzyPL+Qk4svq5VmhCGHRS+zHEKqqyv2Mfue3?=
 =?us-ascii?Q?h06oNvCPc6Vg7xUOGTsIFLgSozlmQb9iqfme34FzU4PNQW//VPj5EOIXW8RV?=
 =?us-ascii?Q?fkkNUvEeb9T6UY2JlZ4TKElRZwfS0gbpZAde8cXVvY1eGDWKl8mqySyxkFDJ?=
 =?us-ascii?Q?ZHNER+GLfH75ygGWRGZB+uLCVjOCSSgyY+/q6zqNp09SWxsinYTs05j1F9jN?=
 =?us-ascii?Q?SPOlio2kFhuj9IsTJzfNpAlnEiOK4bS40ebMCqQVY9zTawdaECOlnt+SjXHu?=
 =?us-ascii?Q?OKDs3VjnjkN8ky9LrMlrnUSCNpwNIwRqdQaM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(4053099003)(8096899003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?INgXkBpBc2Zcit50RHRZNAacHx0KRz1WLIuZprbhzVd7jlUXj+/NX6io1B2Z?=
 =?us-ascii?Q?pNlc+ddKZIZZ72IH+PP55qQIbLGDB0MLpwy+kbYe3qPHwHTwIIATg6IqO+JU?=
 =?us-ascii?Q?/pmjraOs834LFaN9suUfQZxVpvV8UA+k3oPpxjwQAp8ZCW0X9LxLLCol3U54?=
 =?us-ascii?Q?tvwTung3N1ZyCddlVnWcwbq7RHqllo/tNREJpqkx7CtrV3HqzqZLTx1Ycdak?=
 =?us-ascii?Q?gaJ/xi+xcE/ZGFtx/s9ks0E2vvcYxfIEfSASDI/D0cNyBFLbqyEvWG0q5F9M?=
 =?us-ascii?Q?2y78DMShQueuSNxT1D9AlcV6hZQkjFCiiNgURWdzjiI5IYasJz6bP/UDapcD?=
 =?us-ascii?Q?UMpJ17lNpI4HKqK57+9/yd/RolSWTgq6cPO5zsWVxcBlLe/2xjp4r8oOaGYT?=
 =?us-ascii?Q?hAbo8e4zhh8jq7etshM2hU1Ton/rc3tnF1wOXHbDl9gkwu0LzoEoQp+QDDgO?=
 =?us-ascii?Q?2QEApx00QRWFmK9MUuMGWUjWtqTW6mB6ZV+U5PzLUNeTk+5EYsvGUk3y5WR7?=
 =?us-ascii?Q?wXOUzcVz9K7AeP4Orz0DtMPwG1lnPTDLXI3ynua9m5ZCMBfVJ7G5865whalX?=
 =?us-ascii?Q?1pBSwd8GJ2zjskxg0j7hYXij7gyQkkjSO4HlwosQ/2OIWxjHs82Xos2OJuSp?=
 =?us-ascii?Q?sz2wEQs1oqlOHwVWPhk+pZ7KPtuwLx35p11ewFLIhLIypcq10YLfxOU6++gS?=
 =?us-ascii?Q?v75ODJLPQpVhKrimXzT9a+QCgBqW+gNxKb+YgOfKmY1FWkB2X2PKcVm9p7lD?=
 =?us-ascii?Q?5RDq+CBb9m8gwyD87d6NPyykY9rb+bUUglJqazir+rzkGfDRrfrHHUQNrQnX?=
 =?us-ascii?Q?vO0eZPmNrbj/11dAZZWYhbHdJSnE1kf9e+1wPmTEq6CuckfSv1K0M85DQKA9?=
 =?us-ascii?Q?NDbS4LPvabgLIg+l/km8MOlxCe3ugiDuhQDXsRZcIQeHsT+m6LIRDWoWzIQ6?=
 =?us-ascii?Q?/dK0F3YmR2hVp06dOyLEvHlOKsN5BalZNliObE//UiQdOVP2CXWk0ae5sscx?=
 =?us-ascii?Q?UrIzCq6nTYeBAH5gZ4y1Zp4JU5QF6W8M6/SzOAVTA0YD+yfpj8jHlG2k0FJ+?=
 =?us-ascii?Q?DaxxNurShbfTWQKqoJaNOXu3+vN5csacspzB8NP8NEX1JWmWFUYOxMiQclgN?=
 =?us-ascii?Q?Jf2Wg6jGjFG5Jh1fclRihnAQCU2ypPVQ7a4+aQ8l0XNRqp7HOko6ULb0E5jz?=
 =?us-ascii?Q?S9alT57aCeHOSKE7ZpRxmMRKY7qHBAAr9KT0JB52LpqNLqS6QEWKW7FGrapd?=
 =?us-ascii?Q?0P08hrf8XQCObWSrMU7ZV6j9sKstlwlmmZj8ooDqTlX1FQfPp62o+4JjxYoS?=
 =?us-ascii?Q?SO4T6+aWX6ihY+dbXk7rIjfjWCmlQwRbz3hYVGOiYEQNW8Ldh7qqG+vPUKQ0?=
 =?us-ascii?Q?/81MVATcEhCS5ycdXkXdlRC+kgovVAr+wSHKJpLCOUoceZrMmAn6EgCLIdjm?=
 =?us-ascii?Q?qsl/yOWMwEvo7aPAkc37ZDZjquJ5DPBNOzM48Mo45LG6JZjv5g8KijU7arqq?=
 =?us-ascii?Q?ET++kESmXUTf/vUsv+3HavLhvKMGEbvrlYkqChL/oO6YGE8VcXx3XffCwyW8?=
 =?us-ascii?Q?0d3Bl2CjGR4vgycnMLuemnCKi0ZnKcHQ29S3J/nlglZKfoRjoTzbXqSJv61v?=
 =?us-ascii?Q?6kTC+Zvp9z11cxsX/Y4NH9SSOJI4U+oosGidekr99N/rzYEGQuzbmpratrMZ?=
 =?us-ascii?Q?UInOr48GvuFULHAwV7Kc+qFICdjwecUT02WdPjGxAF9PqoviIzie7GzYUBRh?=
 =?us-ascii?Q?kPtpG/Te8w4LhaV5MsO/vCDQkIRCTISaycuW89j++4paxH2Ab/On+YnLE0dE?=
x-ms-exchange-antispam-messagedata-1:
 w21aVIxrROLMcJ596zDm0ODKYfCN4herUl7zlbNZSELRGslRCmro6yMR
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB30825913564D694F3CE48D479F82AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b981743-45bd-4a62-1e06-08de4f5f00c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 09:10:58.6422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AHzjrf3YwTlKVM3EjSVymwMhexGVkgtq+D32O/1dTaLJOcDNjXkRnKFeLHeIfEFotMtEkve3mhyJEE+0hq/u+3+VfbcYdD/W03VQDwmesR3o/wHsz51J3YWkaHvWRz6dvq/EE+qHyMos6hnNpvdFRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1143
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB30825913564D694F3CE48D479F82AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB30825913564D694F3CE48D479F82AMA0P287MB3082INDP_"

--_000_MA0P287MB30825913564D694F3CE48D479F82AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Corinna,

> can you check your patch again?  It fails to apply for me against current=
 main.

Please accept my apologies for the previous patch. I had generated it from a
diff branch in my fork, which caused it not to apply cleanly. I've now
regenerated the patch against the current main, and it should apply cleanly.

> Also, would you mind to add a Fixes: tag?

I've also added the appropriate Fixes tag & realized I forgot to include the
Signed-off-by line in the previous version, that's been corrected now.

Thanks,
Thiru

In-Lined patch:

diff --git a/winsup/cygwin/include/machine/_endian.h b/winsup/cygwin/includ=
e/machine/_endian.h
index 622d7a2e9..48ff242b5 100644
--- a/winsup/cygwin/include/machine/_endian.h
+++ b/winsup/cygwin/include/machine/_endian.h
@@ -28,8 +28,10 @@ __ntohl(__uint32_t _x)
 {
 #if defined(__x86_64__)
        __asm__("bswap %0" : "=3Dr" (_x) : "0" (_x));
-#elif defined(__aarch64__)
+#elif defined(__aarch64__) && __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
        __asm__("rev %w0, %w0" : "=3Dr" (_x) : "0" (_x));
+#else
+#error "unsupported architecture"
 #endif
        return _x;
 }
@@ -41,10 +43,12 @@ __ntohs(__uint16_t _x)
        __asm__("xchgb %b0,%h0"         /* swap bytes           */
                : "=3DQ" (_x)
                :  "0" (_x));
-#elif defined(__aarch64__)
+#elif defined(__aarch64__) && __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
        __asm__("uxth %w0, %w0\n\t"
                "rev16 %w0, %w0"
                : "+r" (_x));
+#else
+#error "unsupported architecture"
 #endif
        return _x;
 }
--

--_000_MA0P287MB30825913564D694F3CE48D479F82AMA0P287MB3082INDP_--

--_004_MA0P287MB30825913564D694F3CE48D479F82AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-Update-_endian.h-to-handle-unsupported-arch.patch"
Content-Description:
 0001-Cygwin-Update-_endian.h-to-handle-unsupported-arch.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-Update-_endian.h-to-handle-unsupported-arch.patch";
	size=1701; creation-date="Fri, 09 Jan 2026 09:06:25 GMT";
	modification-date="Fri, 09 Jan 2026 09:10:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzODc2ZDgzYThkMjQyMjIxMTI0MGFlM2UzMTg2YzcwNjQwMGQ3ZGVh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogRnJpLCA5IEphbiAyMDI2IDE0OjE5OjA1ICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBVcGRhdGUgX2VuZGlhbi5oIHRv
IGhhbmRsZSB1bnN1cHBvcnRlZCBhcmNoCgpVcGRhdGUgX2VuZGlhbi5oIHNv
IHRoYXQgaXQgZXhwbGljaXRseSB0aHJvdyBhbiBlcnJvciB3aGVuIGVuY291
bnRlcmluZwphbiB1bnN1cHBvcnRlZCBhcmNoaXRlY3R1cmUgaW5zdGVhZCBv
ZiByZXR1cm5pbmcgdGhlIHVubW9kaWZpZWQgeC4KQWxzbyB0aWdodGVuIHRo
ZSBhcmNoIGRldGVjdGlvbiBsb2dpYyBieSBhZGRpbmcgYW4gZXhwbGljaXQg
TEUgY2hlY2suCgpGaXhlczogYjE0ZTJlN2QxNWE4ZjRlZjQ4MjlkNzk3Njky
YjQyNTQxYzYxZTBlZCAoIkN5Z3dpbjogX2VuZGlhbi5oOiBBZGQgQUFyY2g2
NCBpbXBsZW1lbnRhdGlvbnMgZm9yIG50b2hsIGFuZCBudG9ocyIpCgpTaWdu
ZWQtb2ZmLWJ5OiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWku
bmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KLS0tCiB3aW5zdXAv
Y3lnd2luL2luY2x1ZGUvbWFjaGluZS9fZW5kaWFuLmggfCA4ICsrKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9tYWNo
aW5lL19lbmRpYW4uaCBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9tYWNoaW5l
L19lbmRpYW4uaAppbmRleCA2MjJkN2EyZTkuLjQ4ZmYyNDJiNSAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL21hY2hpbmUvX2VuZGlhbi5o
CisrKyBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9tYWNoaW5lL19lbmRpYW4u
aApAQCAtMjgsOCArMjgsMTAgQEAgX19udG9obChfX3VpbnQzMl90IF94KQog
ewogI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAlfX2FzbV9fKCJic3dhcCAl
MCIgOiAiPXIiIChfeCkgOiAiMCIgKF94KSk7Ci0jZWxpZiBkZWZpbmVkKF9f
YWFyY2g2NF9fKQorI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykgJiYgX19C
WVRFX09SREVSX18gPT0gX19PUkRFUl9MSVRUTEVfRU5ESUFOX18KIAlfX2Fz
bV9fKCJyZXYgJXcwLCAldzAiIDogIj1yIiAoX3gpIDogIjAiIChfeCkpOwor
I2Vsc2UKKyNlcnJvciAidW5zdXBwb3J0ZWQgYXJjaGl0ZWN0dXJlIgogI2Vu
ZGlmCiAJcmV0dXJuIF94OwogfQpAQCAtNDEsMTAgKzQzLDEyIEBAIF9fbnRv
aHMoX191aW50MTZfdCBfeCkKIAlfX2FzbV9fKCJ4Y2hnYiAlYjAsJWgwIgkJ
Lyogc3dhcCBieXRlcwkJKi8KIAkJOiAiPVEiIChfeCkKIAkJOiAgIjAiIChf
eCkpOwotI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyNlbGlmIGRlZmlu
ZWQoX19hYXJjaDY0X18pICYmIF9fQllURV9PUkRFUl9fID09IF9fT1JERVJf
TElUVExFX0VORElBTl9fCiAJX19hc21fXygidXh0aCAldzAsICV3MFxuXHQi
CiAJCSJyZXYxNiAldzAsICV3MCIKIAkJOiAiK3IiIChfeCkpOworI2Vsc2UK
KyNlcnJvciAidW5zdXBwb3J0ZWQgYXJjaGl0ZWN0dXJlIgogI2VuZGlmCiAJ
cmV0dXJuIF94OwogfQotLSAKMi41Mi4wLndpbmRvd3MuMQoK

--_004_MA0P287MB30825913564D694F3CE48D479F82AMA0P287MB3082INDP_--
