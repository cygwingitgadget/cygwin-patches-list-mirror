Return-Path: <SRS0=y5KD=46=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id 5785F3858D20
	for <cygwin-patches@cygwin.com>; Tue, 21 Oct 2025 19:16:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5785F3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5785F3858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1761074187; cv=pass;
	b=AfPlxfGeGUKgvLeioZlvqNRMtmdl/9NENNIKeMUdIBnbzPaTeE1mLCGx7TJisHyFS+EysCMEXAh2gvdXQEZMSvz9e6fRWxqO54mYRONmrwdrI2lj1KxXY3ymgjwjznEtAhfHP6hZolWbqbt/mH65EUsO6K7rzepZXM9OsZdQ+nQ=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761074187; c=relaxed/simple;
	bh=oNp4jkFmK2ZB3Jvqzkn0gqNTTpuKqUzoc+9d4nZm0s4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Hg/hAtKDkRBLcXgKXZlg0aeBsPZg+mfcyUAfw6n5IGnkHNYJSVKI37q3+Im27LQRq1RLpS63gMmF+wfgDO5JrZ+rU2EJE2zkXWEYkPPf3QrH+oh0zp0q4OnHvyhvQ+Szu53LFRh7BowSPaxJuXQuLgc0cJ77ORi1S0In9Wzqw2g=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5785F3858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=fTDaPimC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL2N/+4eZu0bEZOMmcTDhmut7o9gNRa0FIirnTzX2G+XLXpwTjUZI6x7NgZX/Y14D4u4r4ZWtGeU8stUdUFNFzLid0vT07TWZ9iK6wqD2GPPtpz5D+TwUBodwZdFn3/E+s7cFxlRi0DOAltQFyh4/f+HeaoDm50Kk6HvsrLqKOr5IYIiZM7G+P0vanE1kOFO2LRnXZiG0Ls6zN/iez/ISuekHLv1s3U+i6MbwQ8O9xByFLVuSr0xFcoIpegh6MtqseXD0aDgRZVhF1kqUi31Hxk6WGAW2xGqNFvTpwVI08X97CNX1fZSQcGupLFLsw7hYPFR7EEurFnfZJq6R0B7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHW7Zdlj469Rjy4Voz6/UZpX14+DKf/btm+EAzQFx0I=;
 b=kExu7gCia2vXlpP49JybmK8HU1bmHgcQtYxNsj0uKeCt0iRrkNTk6QBsqNZls/50aUZ1ngt6y0eq4B8eMTFoOO3P6M7jNe00kAT74YkhKG6FzA0CZ1xIFfc3yNjNtB1+dKfUzDZtfkgIcO5JLp1bze52Z1UvkIBq7EazbLFp1IvWKArfg53Bez/9fiUk/BlKixCsP1u5jf90AuYGoHqGdQ53IlGsDNSHAMq4pFH7T6ZIRt7KI+r0iymBQt3FGFaJCE6hHsxjL2QJO9vL9K/kjzQOjXCinzoJqGLGYsd1030WX2kmbTnvUIHiOIAPceS6TElu2QzCwaC8/RUTeKnOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHW7Zdlj469Rjy4Voz6/UZpX14+DKf/btm+EAzQFx0I=;
 b=fTDaPimCVG2CPoLaVw3htXeMJdise6DkaAjiZPIo61wuwgDbcmZrWsD9myQzPTNDUA2UWgd//QIBpV0lxhVClupmoWaNgbDi4N2l/N+HZX20R/5A8jJEvM91VxWgiRd88jP+DnJsW5v6/i1Dz/1prIhrvZjbiGvm3qh5roExvnhR4rPKNzWUsdGTgfjE/AxvV8gONeSaXzgT51/ElqW4/B7n19wIKgmGkJihC5pRFm8D5OCliHEh9jDi5Cqkcql1QKir+PBqF1k0yw0Utd59g5iA/1RwF9ZubQzY66RikhNtAXr0ck9n/0JaInWsAy/3yKoNMEY/gwBlUMKMyFAC7w==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN1P287MB3899.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:255::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 19:16:21 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 19:16:21 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH] Cygwin: update cygbench call to use getprogname()
Thread-Topic: [PATCH] Cygwin: update cygbench call to use getprogname()
Thread-Index: AdxCvNetzpPmQCyNT26gXM1lO+PvTA==
Date: Tue, 21 Oct 2025 19:16:21 +0000
Message-ID:
 <MA0P287MB30823105B0A67CBEC9EA8D679FF2A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN1P287MB3899:EE_
x-ms-office365-filtering-correlation-id: 95985ba8-2501-4656-42c3-08de10d65193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|4053099003|8096899003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5y9HA9j/E4VCtuMvAOR6nZGvC2OJBL380+bK9z1F0EnmwlcmQic04gLIRAEG?=
 =?us-ascii?Q?eqU44s+VasFqT/c90MWZFv6jzxT+YWmm1NE6YcBYjwR7LTs9oaoAYsx/VgB6?=
 =?us-ascii?Q?pxQMkzwB4lvFNTerl8pbETRQWLljNJSSegJ0p+wSuP+4BfMYivE/8nfke70f?=
 =?us-ascii?Q?fX8bFPkd2cEPal4HpiayBX1RrK6Cx0F1+psztxN4IKxFjAGotSYSBJybHp5K?=
 =?us-ascii?Q?A7AJAFodDpuJ7DlNRy/6CbzmM312CnfT/f7ApWkdnDkQkh7jyO0cbym3AG2Y?=
 =?us-ascii?Q?wDu7X4fHituS234KoI0tqwFvmh1eyqHAY/IPEKB0i7oz4rfFH8uiurRfaMlz?=
 =?us-ascii?Q?9KsBloX2q0/SEBYitQciGzJE1+8hhq3A5cXW58GLe3GKVflVNG6Bep+elGnZ?=
 =?us-ascii?Q?LA0Gp5NUO3aW+xk48sXDfDFGxchr7vd8OwED5UwKRW+BKVLjOgCsira2Gmpr?=
 =?us-ascii?Q?EkKGP71V462jKxP7gmDhFi/5asNgcrbAF+76SCbrDHEI0nM84awsbcvowKV3?=
 =?us-ascii?Q?ZgfvLi4ouIIyqAXhBCeZq2WfIAuP5ZWut5qR1R9WdqLqUSMU6c1G5lvO9eUA?=
 =?us-ascii?Q?BppPBWx2j+hcHde8Khl3PEY8f5Rn/a5N4T5yI6FUTH8YmnH7hzotyDNe5ILC?=
 =?us-ascii?Q?S2Zj9FaAXl318Vbo4Z+NG3828l9sFSXbVIkSGIx1JOgNdlxdm+HOWIqqaYkt?=
 =?us-ascii?Q?DMXlcw486Prdtiqy2rrXBiLXh29YaDEH8Fx1Z1e1fX743AB3Ho90Lk2cUqU8?=
 =?us-ascii?Q?yoJXzYWtvSN5uyNASj1ZJMhf5/PtWIaf/Vim3Edepr6ZWD1rNHfsTr6DikNb?=
 =?us-ascii?Q?d4P0QN+sUK7lRkvSMEcraWzCyS1WJx6FXiLN/S5qYT77djny6zkhd8Mxd+b0?=
 =?us-ascii?Q?YE0Z5VGfqdWw3fgFe30mL5oJgEhITJ8eamEliSFXMslejkgtFz0dGt8gTdHA?=
 =?us-ascii?Q?0nXmE6ho5qckZgQZTsXGglm0T8wfP/qF4n1wkNHfl7tlwbxc4h1XPTmQlVqV?=
 =?us-ascii?Q?y3O4Lg1ZIzKFZXjFyFsydxa43hqiRBwAiFSt+33B/oEMFOXSjNaUqXX/qo0y?=
 =?us-ascii?Q?sr3Oy0QmNW94S0Cbnl4uMsreS8S5c0ny6sdH6xdRmsSU3aFPSEljeQ4hALxr?=
 =?us-ascii?Q?tR6AjbOXY9VFsV5sAXjrnKZM8wMd9+S8hUMNPpSHr3xIr8NWYL2a8yftDYk0?=
 =?us-ascii?Q?HHpF1GkqL/3EHgqR3jlSbSedvq2cCQJUTg79/NmvHVLRydNz0NEAa734hTCR?=
 =?us-ascii?Q?5Us/n4Y07qjXLbRHvxzofryVx0W5L2Rk9pk7fLg87KL8LgOVpSCVJABpL30C?=
 =?us-ascii?Q?ofkP3NdZl6d62ZgwziMHs+otNyMe6al4l6OMoPE3X8+AoJMTLHl+2T2jMIdX?=
 =?us-ascii?Q?Xi6OmLU9K//peVJdJvoijFoM6UwI2uat2M92ChhoEY5YAe+2m7kp2SvwDoSr?=
 =?us-ascii?Q?9t73wnyxMelcQoTOkNdfWMixQf1LAi9dtGATeVtFxREPJVxGbyDwhmbd4lMY?=
 =?us-ascii?Q?vi8m/TcKEvsl7d5B6nWXBVef6J3klN6PxV3c?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(4053099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iNIOBFy1+k6WZrEH1U4fRABnkTsm/Pmmh+bknayqGbT/N99tAeJed6GFK4z6?=
 =?us-ascii?Q?iUuRwV60+bACHKYbSXe1N1IczTaOVzm96MkHxS8/FAlKfFXfQlZJh1E+HQrc?=
 =?us-ascii?Q?EbQsl1KNQt6IIbINLJ7gd6UlDHFtOxAqChF5H/3bj+R2938eL8Rd+I9yiovX?=
 =?us-ascii?Q?GZZPhknig9ZkvQ9LG2jSm3aYHihfK80VFLyxLrxrnaRxCE5ZhnDFlqNSmbqq?=
 =?us-ascii?Q?YXhsThyHuHF38vMXQ00suTXAyK34fXrpGEIDcNy+6yn7MxyH3uZa1Fl42NtZ?=
 =?us-ascii?Q?7lJbmhPgdZNiAa4nfrXLJV4Y4DNHg41Tf5dH7WvecoDTU9/Bs1nQ+eitfBSJ?=
 =?us-ascii?Q?kFPXb+PIh20Nfb2w+DknTDw7kN2SP1MsMHbcrnUgM+E3i3gnlVtFZhx7Virb?=
 =?us-ascii?Q?T5E+0xKCoej/8yLBmQZnpzl8WUwzg+ACYLyiQkQFoCveRjLVf/RjJYGPLDnL?=
 =?us-ascii?Q?X7Mt7HdZe36bDxhzjBUUEfXs2VrLAwknP+GtWSkwVfvVd2mHQhYOq48xAEML?=
 =?us-ascii?Q?5PHgZN+RijCp6IT0zuoezG6GzMak1cUy8u8yPQue33uzFQ9zeZNprcfFhJ7v?=
 =?us-ascii?Q?hexuP/VjW1+gZd8WZ/96Abyu42zthInRykZSg2do8aaEII4WzRP79/Vdaiq5?=
 =?us-ascii?Q?3jrWY8GriZjT6jhN82FQ/lk82qA1G8lH135PXsSfAw8emhw57n7PGCLDolrH?=
 =?us-ascii?Q?35SBwSBXCnvOkkgqlasr9yJfWCxJ2kegC8g2zqLmx1VaXbEEeXVs81yMszqf?=
 =?us-ascii?Q?VjVxHamFsSvVNvrS5vVu8BDhf5n8nHOaHqinx1bD9YD36/HAkoPs3wtDjjnW?=
 =?us-ascii?Q?KRk62ct8lp65frFUXkMCkZ6MkFd0ArzWJgj6Swp7r+K0l9rt0OlntrIOpx8k?=
 =?us-ascii?Q?HAVYq0CY1kIbO+aZNAsiDhTYot0udAjQBMHFn+x+pHFVZqPCMdZiWlT7gLx+?=
 =?us-ascii?Q?CgxYeqC/KagUZr6/OmzAZUoUuECGMEZtaz2qsyq+zsMJ0In1Qr1KnN7KYI32?=
 =?us-ascii?Q?+SAwyVT9CT9iPl3erJCY9Pon0Na1oWdvueIMsgDgqMS9Fx2lAbT+4iKN5Fy4?=
 =?us-ascii?Q?wCYsIPxyFpqxKlaeOhDGmMVxYIFRWz7xzLpwsuJQsrKKSsBw6TM+buICJVeL?=
 =?us-ascii?Q?OWbGfOHKpF0P0VLyG9g5/CB2X86FBFyhLGKf1FYK7CY3COJlD1V5hxvdTbAY?=
 =?us-ascii?Q?aHGqfEw/ORza8+i0wloSeQxX0pAYxg0I0tSf+ECcnUOJqGvZaTFD/RFaCwWV?=
 =?us-ascii?Q?0u3HF+5p5broiiMZK8YvlfRwZWZaBLUrjBfv0oX8HIv3+f9w3VdRNGLNRroB?=
 =?us-ascii?Q?e+NuMto+OFXRaVEVc+AOZdaMGAzZGyUhlX7doHTYohKZDYD8mDrT7gPMfrhf?=
 =?us-ascii?Q?9EgLntu2Ou1PAF48b+BEQC17N84hCQDwLDL5OfZznGTOi1KdCQqats4di3r5?=
 =?us-ascii?Q?NXVhdv69Tfpu/UjsM95Km+qFQCbqHWN816/lnoF+6gqLL8+r+e7tZb9hJliD?=
 =?us-ascii?Q?5N5hnSbUpuVRiMel31XSTNXivJH4MUy4yCn1MnCoKCn9VzOEk7apISGD1Cym?=
 =?us-ascii?Q?37zUtVd7O9+L5z1K1E8URep6XbgMIcyTucfrSHucZGgvuor+Z3ZGbT0yLqmk?=
 =?us-ascii?Q?Nmb7x4W3oyMkoYqhDZuvA9ZKIow3A2wblsOZsk4kv9ol4nqnPu1uU1oD60ms?=
 =?us-ascii?Q?eLmjEL+awaPk4coSJSNllEbb0fSnjwxiooiXMvla8lv0oYFP?=
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB30823105B0A67CBEC9EA8D679FF2AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95985ba8-2501-4656-42c3-08de10d65193
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 19:16:21.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMMwkTFzYnflCPEUAqsQZcziIDnuSqCBLJC3e78Am3XYqi4LZLhlaIROrUncVyBt9uqKhAlxNG37djbxgDXkv/udnW8SAMsfg0sAkPDuATNuafnQ3QMRC2fjI5yYwcHoyz1IOy2NoZ59QsDUnMYENA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3899
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB30823105B0A67CBEC9EA8D679FF2AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB30823105B0A67CBEC9EA8D679FF2AMA0P287MB3082INDP_"

--_000_MA0P287MB30823105B0A67CBEC9EA8D679FF2AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Please find below small patch that replaces __progname with getprogname() i=
n winsup/cygwin/dcrt0.cc.

  *   On AArch64 local builds of Cygwin, __progname is not defined in the s=
tartup objects which causes a build failure.
  *   This symbol is legacy to be replaced with getprogname() API, which is=
 implemented in "winsup/cygwin/libc/bsdlib.cc" and exported across all supp=
orted targets.
  *   Using getprogname() aligns Cygwin's startup code with the current lib=
c conventions, avoids reliance on globals, and ensures consistent builds on=
 aarch64 platforms.


Thanks & regards
Thirumalai N

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
In-lined patch:

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 69c233c24..0758ec735 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -964,7 +964,7 @@ dll_crt0_1 (void *)
   /* Disable case-insensitive globbing */
   ignore_case_with_glob =3D false;

-  cygbench (__progname);
+  cygbench (getprogname());

   ld_preload ();
   /* Per POSIX set the default application locale back to "C". */
--


--_000_MA0P287MB30823105B0A67CBEC9EA8D679FF2AMA0P287MB3082INDP_--

--_004_MA0P287MB30823105B0A67CBEC9EA8D679FF2AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-update-cygbench-call-to-use-getprogname.patch"
Content-Description: 0001-Cygwin-update-cygbench-call-to-use-getprogname.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-update-cygbench-call-to-use-getprogname.patch";
	size=961; creation-date="Tue, 21 Oct 2025 19:03:22 GMT";
	modification-date="Tue, 21 Oct 2025 19:16:20 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4MWRiMGFhYzMwODI4OGNmMmNmNTY4OTA2NTlkYWU1YzFhNzk3NjUx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogV2VkLCAyMiBPY3QgMjAyNSAwMDowODowNiArMDUz
MApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogdXBkYXRlIGN5Z2JlbmNoIGNh
bGwgdG8gdXNlIGdldHByb2duYW1lKCkKCl9fcHJvZ25hbWUgaXMgbm90IGRl
ZmluZWQgb24gYWFyY2g2NCB3aGVuIGJ1aWxkaW5nIEN5Z3dpbiBsb2NhbGx5
LgpSZXBsYWNlIHdpdGggcG9ydGFibGUgZ2V0cHJvZ25hbWUoKSBjYWxsLgoK
U2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1h
bGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2lu
c3VwL2N5Z3dpbi9kY3J0MC5jYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3dp
bnN1cC9jeWd3aW4vZGNydDAuY2MgYi93aW5zdXAvY3lnd2luL2RjcnQwLmNj
CmluZGV4IDY5YzIzM2MyNC4uMDc1OGVjNzM1IDEwMDY0NAotLS0gYS93aW5z
dXAvY3lnd2luL2RjcnQwLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZGNydDAu
Y2MKQEAgLTk2NCw3ICs5NjQsNyBAQCBkbGxfY3J0MF8xICh2b2lkICopCiAg
IC8qIERpc2FibGUgY2FzZS1pbnNlbnNpdGl2ZSBnbG9iYmluZyAqLwogICBp
Z25vcmVfY2FzZV93aXRoX2dsb2IgPSBmYWxzZTsKIAotICBjeWdiZW5jaCAo
X19wcm9nbmFtZSk7CisgIGN5Z2JlbmNoIChnZXRwcm9nbmFtZSgpKTsKIAog
ICBsZF9wcmVsb2FkICgpOwogICAvKiBQZXIgUE9TSVggc2V0IHRoZSBkZWZh
dWx0IGFwcGxpY2F0aW9uIGxvY2FsZSBiYWNrIHRvICJDIi4gKi8KLS0gCjIu
NTAuMS53aW5kb3dzLjEKCg==

--_004_MA0P287MB30823105B0A67CBEC9EA8D679FF2AMA0P287MB3082INDP_--
