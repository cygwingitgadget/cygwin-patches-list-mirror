Return-Path: <SRS0=UBKG=AM=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id 7D0D848EE9FC
	for <cygwin-patches@cygwin.com>; Sun,  8 Feb 2026 19:30:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7D0D848EE9FC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7D0D848EE9FC
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1770579013; cv=pass;
	b=gyYcZsir4yWcQudsbNsnGrf6XKhLGezn/MZI4WUz5VgIc6tIFj9mgTklSfm7s1tujduex0IdKBS4wcP+4Yegi6X7iq4BiywR/Y0ywtSB5SWgqRdPkRJZSnmbhuYn1aYI3FGRkcTHTp8B7PR2BuxX0m4PqfbJY+aGCCGF52K0R/Q=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770579013; c=relaxed/simple;
	bh=T+GSyIV3Grf0CqDl/Wh3XaOgB+EqSXdxkf4QFzgfO0M=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=rARRU5bwu50tjeutqg5c4+B0SaNozub3IiwvbzJjrim9fhMrQZ5/DKHhMlZ/lraDuHENMRvxTmqO9aVY11ZrMMpqJ8r61sbxn4qAUFvQFfieejXgmb+zbbPS0IMXbSZ4MVnvFLDmm/AI/F9nU9LgLwv50nrJfN+yYCKhHLmPuvQ=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7D0D848EE9FC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=a9Z62DuX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIU+E4Jlt8zXt0Df7h0hMhyzUM+fTHAX5B40foithBTFH1vbrSAVxKIu19LVZHS9JWZA26Dbuw/Glz3kJspyVnJtabVJ0jpAVKi4WAftwTHJSA7U/ghwp1VDCDxQ1+SuOpdGeUJwbSinXc5iIGgH4eWiu9EV0JciishMgRkfYO5J0YSO0WiFurIGtMkeaX4jt+9D5gYa6Z4LVf/RxSydZAgMZi0j80gTZnhprHZJwGk8oBAalnKO3615zF0IcVOqfYsSN8qRsWEzMkVJMno1iXItgEgXbXBJuS8qS1rL8g2w6bi+j45XjwAWXkpnk9irQfA6Yv1FsJQ1HARswtx6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h69u7wgq8qlF5gZkMgXTldUmJqfmZ5zC32ppCU+EyGg=;
 b=AEtrgkT/faDcddxhqAooDFTyfxov+yoAc3h26FP+AxasWn1XAb36nsw2Qx41QxlJI15M9kp58IYQvq/wcvE17HbYPCaHgQsDJBR96K+D41DDl266D1aCwhE1QreGp5u1+JsZPXma2K9dCkWq8fRQV2c6r4GTf9csyU7O1f6Oq76w6hMjTZQJHjHOeKmYvWonYYvQ3QD7sK4E9KThqoQ8hQPZJFEq1yW70kfYnj4lmYZmjWKMXylDPvspX61M4pOM34JYerV1q4gqJTg59JIuBwJlkPR4CD278HDYrOXEXg5xSxSqazk8wsprI/6O+2kbfmSd72MeLRD1XUrPUfSXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h69u7wgq8qlF5gZkMgXTldUmJqfmZ5zC32ppCU+EyGg=;
 b=a9Z62DuXAm0+xo/BWtZ77LrPpH0qXZTWugkZdhoCnQOeliJsgLCTrq7MCirqoaXH1Esc6WmuqSSm8meELb7GZ/KwyiR/KQZKGNURdG5Fz79YmJIzhULX8ChC1MeygV2uqJ+AyNB+mQteypoVXuuByAjzn54JVO1kssTAO/C/tB+GsoNC6WRA4Wjot1eW+Mkoxhc0qnzXIFVABYZa8EzFB6XyVQseSWG+oy9XwaKx3pE6HIA5XO+syer1MUh6bG9jDPQajMelBxunfHFOr7TZjO7etBgH/PybhBW70ueTW8SYGFYlJcLX4IXm/gS4IPoc/mPNO6AXmD9ujm1fHtt8iA==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN1P287MB3822.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:256::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.6; Sun, 8 Feb
 2026 19:30:03 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9611.005; Sun, 8 Feb 2026
 19:30:03 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: cpuid: add AArch64 build stubs
Thread-Topic: [PATCH] Cygwin: cpuid: add AArch64 build stubs
Thread-Index: AQHcmSwNzCN1h0nfgEK5iX3LfS3CtA==
Date: Sun, 8 Feb 2026 19:30:00 +0000
Message-ID:
 <MA0P287MB30827D0112702D609C0D688A9F64A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
undefined: 4243807
drawingcanvaselements: []
composetype: newMail
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN1P287MB3822:EE_
x-ms-office365-filtering-correlation-id: 07fa6139-7801-45f6-d2a7-08de6748752f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|6049299003|1800799024|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lAPJMRhKcDKmlZPiIzf6tXa4mGxSk9OQFoOWDId8FWbYQDcTkDxgaNZYNW?=
 =?iso-8859-1?Q?pUlTctLabJAQ7ojT4Sk7p9hQiXvAtvutTUHeTvcUK2ku1+a9Sx12AJCFOf?=
 =?iso-8859-1?Q?u7u4ozNhCv7QQx5QGsmVRbm80WWrrM995HJdPKE8e985GEO8ZtfPvXsvPQ?=
 =?iso-8859-1?Q?td/dsbOJvQFMx3VO6CqKr32HCJk4vEi95xUC7RKDNP93Ny1BYjJ7WOLQuo?=
 =?iso-8859-1?Q?NgblgeKpiPZtiVZHretWBKBxD+r0od6bMQKGABebcEGbbTMAIaR5k6M/ys?=
 =?iso-8859-1?Q?T5shznGENknaqJ+HVE6UuSAGEUax5haO40fcvmprjU2oENxO43ZIHwGf0+?=
 =?iso-8859-1?Q?56p5XyTMYlIm/D5mm+lPtfB0oJpmSxNvV5Sl+YcoZgy0+jW8RQHALyMVnY?=
 =?iso-8859-1?Q?upqw/usmmvNnVAKIrxrgpyPk2ur7QnccKrWIYwiW7elRnagB//xKpRCoSg?=
 =?iso-8859-1?Q?op0jcEhnM2eZYEU3MJPlcy0dO9VQwae1ezHkFhrjfgDKm6kYIR8RaGwFr2?=
 =?iso-8859-1?Q?bRSKqd5QXvIYSbAIINkBrOpvog12mZwdC4lfIY5WAJtrAkKf5y686anQUN?=
 =?iso-8859-1?Q?gPcsC6tey2nDtKpohsaxxqmLT9XrW5gIz/x1uhfZjgovAGffuCFor/IKMZ?=
 =?iso-8859-1?Q?jAZr4NvIOr66WcLhE52uzpW74QtL+UaQEY5ZqLMhJ6Z7gU1KzuXz71k5dA?=
 =?iso-8859-1?Q?VxKn3GM1ZU4JSiKwhFT2Bk99sQ+3G48TRKti69nBP9BLNLiNjL8KXqe95H?=
 =?iso-8859-1?Q?UE3c5Tf1LOh5nsX8ujOpXvAI8TsQFvN+V7czq2PUQ99Yyw7aSnbShqsq3z?=
 =?iso-8859-1?Q?OsqVfPUwga1jqJ9jvkFwadaaNUC97ORNqqAfQXIckV1MGnQoo9a04xhhxC?=
 =?iso-8859-1?Q?qCMhMoVG82ekxIPnCDWXk+4tIOypN2w4yMRaA37tsf0xHTRmnGuFfGhcps?=
 =?iso-8859-1?Q?EBIPugIOS6E2FNbcoh/bB+9U5iiNpylW1QVEdFPuZfo6KdIbHK7Dz/IQyU?=
 =?iso-8859-1?Q?k30paAMYf/Z4/irndv8X7ygCwdG2YuxRAzmymmZWSikzk/ddcr8LPpPp5S?=
 =?iso-8859-1?Q?cpFPVjBfG8uRdwgsPCeDx1xyBSdwE4R6/gswaDxnztu2zpgfzb8hJBEYM/?=
 =?iso-8859-1?Q?1AZF+2xpzO45pVEGY/DPXSG2y++cFhXM7BO3l1wl/2WfMIZuckXlzSPYkp?=
 =?iso-8859-1?Q?1d2m0KfUmjpMJjcOxEXvA3+qHp1deVW8fP9pVeQ3/osr6qeNc8Ra72LrKg?=
 =?iso-8859-1?Q?hFeN12yvObwBiwZANVR1/sARdYdIgoPwa5AzcqH6u9+vHmUpFJHC3awEkk?=
 =?iso-8859-1?Q?elVfXMnil0rBIEk9cAvHoDAPsVpC6TU0Sz7jD07IJuauhgvmsNm8ufws4l?=
 =?iso-8859-1?Q?YaqqHaHEbNZtaelCk0uwGHhij4RYCXN4+M25uSkKp1LsQpzt4B4UzWG5+C?=
 =?iso-8859-1?Q?Nx4RS8lOpa5+rxHOKbBAUqQzLLC2lRQt51ZqoURxGJrnYd1XsSIszGp3BG?=
 =?iso-8859-1?Q?9n+z+LDeirHpRDs5xz5fDL8lMhRXZrPfXJSdBlOY4mkaGUiZAO4KlYILXG?=
 =?iso-8859-1?Q?h51GX/dovxos2Ahh3W9ozKxmJYmKo++U36fOoQaYHXzsUt3ssvaxozkAQ4?=
 =?iso-8859-1?Q?t/PHmpe83SiDWa75QvGOJdRfOd5zumlmz+zCZ966L67umN3sQP8PtJvPum?=
 =?iso-8859-1?Q?7nt3evlWS6McEK7tqOE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(6049299003)(1800799024)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4Mcw72gtdd6hw06tskVJUct/YBU2yraPCMNBCZYEh4ylsn3XLeUjWEy0+W?=
 =?iso-8859-1?Q?Yi/gNB48grtdfIPw1mu3q0UwHsF2+9K8jETbAcx69g3izuESv9+0y3rmdr?=
 =?iso-8859-1?Q?x3mb65W/a3MrNSIFdIBiCUEyz9ZuWjYEssCIrlSWQacRA4J3usWZHhpAvv?=
 =?iso-8859-1?Q?BuZlIsznhFgCmbRBLIJgNsV7f8TXxgW0668tyLxQvDv0yUhEWBGbHhi4kt?=
 =?iso-8859-1?Q?rqkWTlHGdmbIkphVypQ9JOzfrqHTe83XPRIPKLsnxNyco1eHVuQjJWCw6m?=
 =?iso-8859-1?Q?WiehqbRcBsV6h2pZ6imWMpoBLZU6iuFbJlwFMRLDhUvOuOVuU7BpzU8l8A?=
 =?iso-8859-1?Q?UicMMlf0s4Q0x1u3e2GBc2Y++17Yipdsl2Z8CFnhfDJD1aE7gsLw5G8PsU?=
 =?iso-8859-1?Q?hcU6DByQbSj8P/yORcLnt+t9bSTKkEM3oSngYSIDiGyFik77m2kcGUpZcK?=
 =?iso-8859-1?Q?eZMo2m/pYV3god5MOLXsLP69tMqcv4wn5kWfLbFBOX9pDC78oLA2m3LVdv?=
 =?iso-8859-1?Q?fk1c9urrCCNo55HVKr7eO8C9Y/w4ocb5OYGoRka2IBaseQRCUff4MjIL1A?=
 =?iso-8859-1?Q?taVLtBmlYc4B/4skCUXEaK7AuS2bL4EFAECztR46qdZ1NZu1cYYMyLMFaZ?=
 =?iso-8859-1?Q?3YzgKR+my8xJVFUb5RlBIG6rBtTSDGlGRwT4OMokd4toro0QNORmUdw+i9?=
 =?iso-8859-1?Q?6JcI6yjz55ZY3ZQaDCWNatWrnOyJwLLi9yngtqBJDe3gXG+0TjML3mKpV9?=
 =?iso-8859-1?Q?emVBN7QlNeLS1bOZ5TCwtWzm4ITxiErTUWTrhri9tCrLVA4elr/7lWbD/Z?=
 =?iso-8859-1?Q?slRgxIrg0sK/rhtnQr1bnY43YsGLRHwbbRDiS5tCnkG0+MSMRpUilrgtEg?=
 =?iso-8859-1?Q?JTPPv8r0iNH9E9UOQre38LPetNWQYILcGIX0DDh2khHmqAEmeF/NyiXOZu?=
 =?iso-8859-1?Q?8MsD1PFO8Dnu/1sVUniDdFDMXiDglP071a/Xx0RTOZ/ADCS/Xd2cHqLTHF?=
 =?iso-8859-1?Q?cEMxjVrcLru+IsrJmY9MR1Y2DXG+Nlad892z0k+J/Af7bE8t+mPL2anmgJ?=
 =?iso-8859-1?Q?ciGG/JnFUSy0sqim9/2KCMCP9ntaFmtZG7VC/UnhpRyKv7EC+9jpnaIW1M?=
 =?iso-8859-1?Q?OijO1C3W7icor1u8JJQ8J/EGPAl8FtUqlt4XT68EKN6bScTRpL3nEPfCdI?=
 =?iso-8859-1?Q?OXkDJbztCfEt1kW75VMsCXet/GyrefisKrRlltaFjfZUN1zF1ox+wN3WdM?=
 =?iso-8859-1?Q?/vjdvrkyYltUlQBGEXRBVFqMG22PZcQJFTTLoj/zPCc0P+fur2FzfcKQdQ?=
 =?iso-8859-1?Q?n6tzXMur2YVjSSTnXjUsWyPPOl6tHxknH+pwUBK0Rm98Y2ZNRfgntFHZny?=
 =?iso-8859-1?Q?I3eIb6kWgZo/87KMst7hUVGVS1ufpe3NStjSIU3BoKeZMrGcNMDOYBEtmm?=
 =?iso-8859-1?Q?QfTKJC/mro4imp5vtYdSIUYs+FjSAhMAV+5fGNJhy/MFLzlEowWUuv/ujV?=
 =?iso-8859-1?Q?ACABt0aFVX1X5uLmWPQEXhk33ylU/qvvP3U0wv+Z0v1O7k4hDRONQ9fN8Q?=
 =?iso-8859-1?Q?cFWJZktC31eXIUe0VLEMlc9Pi10nQTxob6zewf/nWvvWzAUh3Y0J7RbbRT?=
 =?iso-8859-1?Q?J9fP1Lx1100+XyORSSPBVbr0Zyws3NJ33ehSxvviPvUw6+Uen0Ll4fGRcX?=
 =?iso-8859-1?Q?WHcAK5ETMUKOpp5EV5okcB9ishgDywgFwg7imisoWJLyHXIf2GMb/AqhNw?=
 =?iso-8859-1?Q?+kWfksWN2mjHDG8umwgkTYJLapnWA/+etGoWGn8TXR4Yg2AeqDbRrRnDu0?=
 =?iso-8859-1?Q?jTYq38Qng/d4UaC0deWxvQYnIFjOHgjtw7oLDpkAm4YuTB4MzJJ7HSfoGk?=
 =?iso-8859-1?Q?RP?=
x-ms-exchange-antispam-messagedata-1:
 wGsKNnU2s3xs/XFJQQojzEjqcejGbLB02VBURSLfssPddi78MjjbfOd+6nR/4Vk+bKp/h1EeJOTp4w==
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB30827D0112702D609C0D688A9F64AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fa6139-7801-45f6-d2a7-08de6748752f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2026 19:30:02.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DOATvkesosxhbO0s2I3bPruHooy/vNn0NGTMnXmPaltaSmBxRQfppOZwpDzATUG1DL2C8fDfNKk08jjW5CSYwbJxfpb0wCQ0Ur7yWLxI+hq6DinHBCXZbKN8lBnaAimjejlx21skqk37zXxND2ieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3822
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB30827D0112702D609C0D688A9F64AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB30827D0112702D609C0D688A9F64AMA0P287MB3082INDP_"

--_000_MA0P287MB30827D0112702D609C0D688A9F64AMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch adds minimal AArch64 stubs to winsup/cygwin/local_includes/cpuid=
.h
to allow the header to compile for the Cygwin AArch64 target.


  *
Conditional handling for aarch64 is added alongside the existing x86_64 cod=
e.
  *
The cpuid() helper returns zeroed values, and can_set_flag()
is stubbed out for AArch64.
  *
No functional CPU feature detection is implemented.
  *
The change is intended solely to unblock the AArch64 build and will require
proper architecture-specific implementations in a follow-up patch.

Thanks & regards
Thirumalai Nagalingam

In-lined patch:

diff --git a/winsup/cygwin/local_includes/cpuid.h b/winsup/cygwin/local_inc=
ludes/cpuid.h
index 6dbb1bddf..238c88777 100644
--- a/winsup/cygwin/local_includes/cpuid.h
+++ b/winsup/cygwin/local_includes/cpuid.h
@@ -13,17 +13,23 @@ static inline void __attribute ((always_inline))
 cpuid (uint32_t *a, uint32_t *b, uint32_t *c, uint32_t *d, uint32_t ain,
        uint32_t cin =3D 0)
 {
+#if defined(__x86_64__)
   asm volatile ("cpuid"
                : "=3Da" (*a), "=3Db" (*b), "=3Dc" (*c), "=3Dd" (*d)
                : "a" (ain), "c" (cin));
+#elif defined(__aarch64__)
+  // TODO
+  *a =3D *b =3D *c =3D *d =3D 0;
+#endif
 }

-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__aarch64__)
 static inline bool __attribute ((always_inline))
 can_set_flag (uint32_t long flag)
 {
   uint32_t long r1, r2;

+#if defined(__x86_64__)
   asm volatile ("pushfq\n"
                "popq %0\n"
                "movq %0, %1\n"
@@ -37,6 +43,9 @@ can_set_flag (uint32_t long flag)
                : "=3D&r" (r1), "=3D&r" (r2)
                : "ir" (flag)
   );
+#elif defined(__aarch64__)
+  // TODO
+#endif
   return ((r1 ^ r2) & flag) !=3D 0;
 }
 #else
--


--_000_MA0P287MB30827D0112702D609C0D688A9F64AMA0P287MB3082INDP_--

--_004_MA0P287MB30827D0112702D609C0D688A9F64AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="Cygwin-cpuid-add-AArch64-build-stubs.patch"
Content-Description: Cygwin-cpuid-add-AArch64-build-stubs.patch
Content-Disposition: attachment;
	filename="Cygwin-cpuid-add-AArch64-build-stubs.patch"; size=2064;
	creation-date="Sun, 08 Feb 2026 19:11:47 GMT";
	modification-date="Sun, 08 Feb 2026 19:11:56 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMjNjYTNlMjBmY2UzMmVjNTExZTJkYjNmM2FmM2Q0Y2FmOWNlNjcx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU3VuLCA4IEZlYiAyMDI2IDE2OjU0OjQ5ICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBjcHVpZDogYWRkIEFBcmNoNjQg
YnVpbGQgc3R1YnMKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0
ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5j
b2Rpbmc6IDhiaXQKClRoaXMgcGF0Y2ggYWRkcyBtaW5pbWFsIEFBcmNoNjQg
c3R1YnMgdG8gd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jcHVpZC5o
CnRvIGFsbG93IHRoZSBoZWFkZXIgdG8gY29tcGlsZSBhcyBwYXJ0IG9mIHRo
ZSBDeWd3aW4gQUFyY2g2NCBwb3J0LgoKVGhlIGNwdWlkKCkgaGVscGVyIGZv
ciBhYXJjaDY0IHJldHVybnMgemVyb2VkIHZhbHVlcywgYW5kIGNhbl9zZXRf
ZmxhZygpIGlzCnN0dWJiZWQgb3V0LiBObyBmdW5jdGlvbmFsIENQVSBmZWF0
dXJlIGRldGVjdGlvbiBpcyBpbXBsZW1lbnRlZC4KVGhlc2Ugc3R1YnMgYXJl
IGludGVuZGVkIHNvbGVseSB0byB1bmJsb2NrIHRoZSBidWlsZCBhbmQgd2ls
bCBuZWVkIHRvIGJlCnJlcGxhY2VkIHdpdGggcHJvcGVyIGltcGxlbWVudGF0
aW9ucyBpbiBhIGZ1dHVyZSBjaGFuZ2UuCgpTaWduZWQtb2ZmLWJ5OiBSYWRl
ayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KU2lnbmVk
LW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5h
Z2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5
Z3dpbi9sb2NhbF9pbmNsdWRlcy9jcHVpZC5oIHwgMTEgKysrKysrKysrKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRl
cy9jcHVpZC5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jcHVp
ZC5oCmluZGV4IDZkYmIxYmRkZi4uMjM4Yzg4Nzc3IDEwMDY0NAotLS0gYS93
aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2NwdWlkLmgKKysrIGIvd2lu
c3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jcHVpZC5oCkBAIC0xMywxNyAr
MTMsMjMgQEAgc3RhdGljIGlubGluZSB2b2lkIF9fYXR0cmlidXRlICgoYWx3
YXlzX2lubGluZSkpCiBjcHVpZCAodWludDMyX3QgKmEsIHVpbnQzMl90ICpi
LCB1aW50MzJfdCAqYywgdWludDMyX3QgKmQsIHVpbnQzMl90IGFpbiwKICAg
ICAgICB1aW50MzJfdCBjaW4gPSAwKQogeworI2lmIGRlZmluZWQoX194ODZf
NjRfXykKICAgYXNtIHZvbGF0aWxlICgiY3B1aWQiCiAJCTogIj1hIiAoKmEp
LCAiPWIiICgqYiksICI9YyIgKCpjKSwgIj1kIiAoKmQpCiAJCTogImEiIChh
aW4pLCAiYyIgKGNpbikpOworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykK
KyAgLy8gVE9ETworICAqYSA9ICpiID0gKmMgPSAqZCA9IDA7CisjZW5kaWYK
IH0KCi0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRf
XykgfHwgZGVmaW5lZChfX2FhcmNoNjRfXykKIHN0YXRpYyBpbmxpbmUgYm9v
bCBfX2F0dHJpYnV0ZSAoKGFsd2F5c19pbmxpbmUpKQogY2FuX3NldF9mbGFn
ICh1aW50MzJfdCBsb25nIGZsYWcpCiB7CiAgIHVpbnQzMl90IGxvbmcgcjEs
IHIyOwoKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAgIGFzbSB2b2xhdGls
ZSAoInB1c2hmcVxuIgogCQkicG9wcSAlMFxuIgogCQkibW92cSAlMCwgJTFc
biIKQEAgLTM3LDYgKzQzLDkgQEAgY2FuX3NldF9mbGFnICh1aW50MzJfdCBs
b25nIGZsYWcpCiAJCTogIj0mciIgKHIxKSwgIj0mciIgKHIyKQogCQk6ICJp
ciIgKGZsYWcpCiAgICk7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQor
ICAvLyBUT0RPCisjZW5kaWYKICAgcmV0dXJuICgocjEgXiByMikgJiBmbGFn
KSAhPSAwOwogfQogI2Vsc2UKLS0KMi41My4wLndpbmRvd3MuMQoK

--_004_MA0P287MB30827D0112702D609C0D688A9F64AMA0P287MB3082INDP_--
