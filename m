Return-Path: <SRS0=QmHi=IL=multicorewareinc.com=aswin.kalies@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id BCEE64BA798F
	for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2026 11:31:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BCEE64BA798F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BCEE64BA798F
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792582293; cv=pass;
	b=UGQyOfVR7vHjGRjsIdFuxpkR98WI19X0zIca+xuWnQhQ1IZ+tbh6+IAGPLw5U5Be9rzOqC3xKtuc1G6Mgjvgj+6gVUt9YMwTVTUTzGDs3FI2j5oF/gmgQp+QyNqxBbY2pPwQYKa1TYCeSlztthqxSBnnA6YyMpZ5V175cTbbUDs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792582293; c=relaxed/simple;
	bh=I4EywmdQx0Ufbdd0r6jG2vJoMxhlpWykKsHBTydxXTQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=MVxyO9eXl619QkDb4ghu7t9mH1uytOieP6sYI44ajMltFhiCNqfYhNSWOCLYLPiTH7dBd7aL/XZDLgzWmsO+9WgasQrhzg8AQDnZ21gtwC8giFN2tujvP8s7OoRvOjDaV9A1pat8mHhMk10/YUZlfPBvshYIEl3BNyzdZloFHyY=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=ggVZvrss
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BCEE64BA798F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=ggVZvrss
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlVMPp+ZjU77wvFnV9Xp7Qj/Usk6SEThI3nKbCD8lX1unvH0hAFvFsBa9Q5G1MZ3crfzacFRk2YpIhhN6Ky9hJE8nG6ljqF1RbeSNWdNdxSCrjE3nd1nYxwhZehYo3pGgrP5AD8QFVbNZQqiWn/25qsw3XIckXz96V3wPOMg9Zi7Yvo+L3bw+DEye0tzcomIJPsyz68BZyLnxbxjNx9BetOTrRT9p3RXAih0ambxqIS/JiIMt3yDrXuZdW/khpcgg0/9LDiNJ+B3KWPH42PKz60iVXsVvvJc9I60T/IChyLEKxYr5+4Hc2i9c7qM9FhtzbrLanHzNiXJBLtwNaGUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e+/SEUHm31tJE72rUjsRo/8X+fXmHPBJCHdYOAljZo=;
 b=jnoIHhmJGgMcrSDdCUQ03ZjWcXi7Ncg6A0DLAFRIu7RxJqkobcBqwSgOa4N/mRkzCfX5XrfYLhSG4vM68kmAVvOcvbEKuGXB1lLP7F0vEa5LdQ2/X2MlSGO0ZrUyh6QtvC7e91TJuwV3/Q1/d1fYZnqRyMn/WRxYZDapNavvNdQZdAsPO5psQPoZEEgDZJwMhyOqG4wVyz/exUOhytSMZFfFVkoKHR5sPYmi0QFXmaNBNVJKKFl1O8r6Q62GzLxugLT4WftdVji//3X9B7fHclxh4tPR7h0H1dz6f7Ef1XqCYRsnDwQ4lXNan+qU3dXEp4R34MWEyz2A5LJBNZ9MSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e+/SEUHm31tJE72rUjsRo/8X+fXmHPBJCHdYOAljZo=;
 b=ggVZvrss7N6Qy0H+WquqjcesEttgwbcunwDApCO7nzJsX/3hvAN3obebYShjYTtQ2BrXljBMS4HaxDvGX8nnr342izTlYRhpkvIxVWnNOSTI8A4g45LpBRS8Rue0I3YhGP7vr6+E8phsGvmlJ/rmhCJU9Qsp5MJ9p95gdQkaeha8sSwA/NY9HL8eYBmGuewEpjVX13ucWVIq5oGUeffjiY/gKseHITltyA1Hk2c5MRsVk9bXebmsrpgKwjP9IVyWh5fH5vt+rUQNVMkRhGMaNUl3c3gGK6Hd+tmofKcZInnPEJCN+sNH+BCuJogZglvBpg85IH0z8NOeVk11Dl5ung==
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:193::14)
 by MA5P287MB4096.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:162::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 11:31:19 +0000
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b]) by PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:31:18 +0000
From: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Topic: [PATCH] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Index: AQHdYU9QGEvlYcMFQ06bxQqCyIEWFA==
Date: Wed, 21 Oct 2026 11:31:18 +0000
Message-ID:
 <PN3P287MB1320D9A7F2A14C9F0533B63BF7662@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1320:EE_|MA5P287MB4096:EE_
x-ms-office365-filtering-correlation-id: 263385a0-477b-4a33-5091-08df2f66d340
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|39142699007|31052699007|23010399003|376014|13003099007|38070700021|56012099006|261009223027099003|10067099003|55112099003|18002099003|8096899003;
x-microsoft-antispam-message-info:
 bamW6hOjv5GCdVZwjguT44Dbv3ySe9RY+QVY9EoJcTUzhfx7hx/G10s4UCW8zMb82W6TEmddsY+zuwRqdZCczZn10wr/oEPJgWKSElC6wn274UCn49w8szstyBeOpcDC7eN+eKOXGL0vhfXqtNGefLfitUERlVOYytx7e3mHRor1S6oM0+b+dRJngRx8HOhrMnIo1YxQnvdgaVp7UYV+PpHq5NZclugK4T11jEgV3As8W9fkPLyIUBceHAJCMcXnwVqK7nEfQe+VS+9fMdADYFpD9xapn6odFlF8S4wWhxX3pRP+ZKh2XTa/4ecwFXk34wJdxYZvNk1xUKnRpHKSNRTX58U4E2dJ+ynAAjXMMiCsUe9TFnFYForVvG/9l7JpTH32B67VbNj7F8Z+f5XiJosMCYjHg0hPzJAXkU1lLkNoO/9pfRZN6RmSEaAt3L/VgQj4rwtGNrQiIW427aJWCA7LQuGsUUgxw/1O0oQoCSl94Vi5LgueuZICqr2ONi5WloZDjSL9dre2WWvCGAth/V4wXaDWIkxsP/fJ52Y78jhvmKJi0YnkvO+hzx/v/5xqHLDUlwR9FHJj+SMFd0Vn83a7mfAnYXKKxN/BJuLgQwvInDloY60jCAwuxUGvrxX36AFb3H7t5HR3astQ5rc8JioeaMye1L7joLGSaTT8guY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1320.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(39142699007)(31052699007)(23010399003)(376014)(13003099007)(38070700021)(56012099006)(261009223027099003)(10067099003)(55112099003)(18002099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/haQGQV3B4TzL27OxoNgKh+5iehsEfuiZtE1Afjf+r/4lTHLCRh6WIedq9?=
 =?iso-8859-1?Q?L9a+I/iRV82mYem/yd90oXF/kAzN9l/N9SnzpGDIAnQMRjG7gQPZ5/hjwA?=
 =?iso-8859-1?Q?8XSUlZd+9cYn2ax0XTEzoruPQ1K7uEI3Gs9uiL/8BRCupO/J6AXS1vgvKh?=
 =?iso-8859-1?Q?2OeB0Z0MV08iyZ50JlGr9GoSiUzniuywj8RKqjyfpH0hR6nEoXeptJkXNI?=
 =?iso-8859-1?Q?lp7BuwUTPBNkMoBPuU9Z9yVEl4IKP68OL75BzJ+hrL712vHRv5Uuvm0fSE?=
 =?iso-8859-1?Q?FtLDdGn1cBGloklpZ/tc8VQOq+FNprVIyHq9xeLVH0E8tkS77m8XDbXAjw?=
 =?iso-8859-1?Q?FgOfnNptQkvzY+AzJUg/Im+SBwrD6oFUG0jiqFjt1sXfKRfCKU1fxU6KvH?=
 =?iso-8859-1?Q?GQep9M7SIvjYAqh7XcuhnzPhvg6PQ6CXfsFkJFlgDjXCQx8gQ3AHDX08YX?=
 =?iso-8859-1?Q?71MU+SoLf/szPPaRp6ESU3iI49n05avn4mEESN2H+N1pbvm5fzDzw1hXxz?=
 =?iso-8859-1?Q?NYnpEJugAN+icWKOdqB7XRzc8/EvcFIb+Tzu32onPIKPsflyqLUvllVE3Y?=
 =?iso-8859-1?Q?3IMZG9JWi7SQmffaWbEUwiheclT/83aN7PleFjFI4VAFsO8oHomfvpdmeY?=
 =?iso-8859-1?Q?MHNo2BRvgsWnyMjXwPtVa8aBsWxPKk/EdDgF0uOrvSlQUF3qKCBI0FiAsh?=
 =?iso-8859-1?Q?1uVLvjXOlmrqdQ49Ost1lxWRuaEKQ6ZycqniS5eqvTUUeNZCuRJb27qNj5?=
 =?iso-8859-1?Q?XhNCcARPwSPwPi4GZryVgoE5vs7DoKaYm6gkkYnYsc9z2n/2N1dwdLVoot?=
 =?iso-8859-1?Q?0Krg0gn2a9cFR+HcduMJq3i3N7IOf1Y2kLhnNIvdLAsjlBnk1g9mSyd7FP?=
 =?iso-8859-1?Q?NGZPUuHjwCvX8+ZM2D2e5a9Seai8ghsQKnMZWsl/VumXLDtWOHFkIRZ49T?=
 =?iso-8859-1?Q?vF8O6LL1diLjKSGHbaYkyrnXWNGDWjIcVQ9w4ZF4QB3JvkECQr+wqxzajg?=
 =?iso-8859-1?Q?+xGD+gaWXzx9jlbc/b/0drdFsw8j8ckZLD+C7YZ4goZLcMhQg1eA1oLoK2?=
 =?iso-8859-1?Q?uskl0KWT7V/izzy/fwvJJWeO9IlzSFJf4doBzit2BMG+qw4+pJWOZzm1Lz?=
 =?iso-8859-1?Q?L2s4DxJUty9biKxYzZuM2qpIA8lGY8rMKVHEHN7BDAEGXPG01DsXOsSQDe?=
 =?iso-8859-1?Q?qF9oamx0o72/4ov3d+p1q77WrFe7DQak5qsAircJD9zixu2mWNZWLMLM4w?=
 =?iso-8859-1?Q?JqKkxQVdibqUWp3sodRzs7He/IZMwhtdJmIZTGTKQKdzpSsp5eD5bEzTDG?=
 =?iso-8859-1?Q?pGxuP6rUhyTfOy6Zq+i6JAqDgmYwHoJybiv4fGSpp0cHetl/L+yxzxJF+I?=
 =?iso-8859-1?Q?a5IwmDNaIPbcIE6IXpoPoRS6SMFUwd2y81h1SPmVU5b7ohMQ0rMh24AcQc?=
 =?iso-8859-1?Q?ujR4Z0CDN83tAVbDypZyyq74/IqRkf6TBBQn5VpVywe6y5ZOm62BFHJgzi?=
 =?iso-8859-1?Q?LF8kdQ6T2xzrW8Jcv2IcIdt/nENjja4PvQ0PhnrfoCtIjX7kpO9i4HvJOc?=
 =?iso-8859-1?Q?mkoV+LG4jfCVQanO3hBrs8WuHbRNy+tEdaMnmjv5smFd/BGzsRmDESusHd?=
 =?iso-8859-1?Q?zmbUZwpk9s51vClO7LgJZpbYnrqBKVqNO5PToAjLFwNGi8Cv3fhcyBaB87?=
 =?iso-8859-1?Q?cZc83Kg7csefY9cCWC84Qq578saRXGmaITc8KmPgHLSPK5vX2WC5l2qW9A?=
 =?iso-8859-1?Q?K5EZjltMzDWGIDR2eff6YC030sbo9u0EM9fkZsgddfUDjZvw8OygfwJB8r?=
 =?iso-8859-1?Q?awTwQXTou3AIdrpLKMQl6nhgwMmktZ0=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB1320D9A7F2A14C9F0533B63BF7662PN3P287MB1320INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 263385a0-477b-4a33-5091-08df2f66d340
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 11:31:18.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAyrVd4VtVdAiEcrsyo3tH3Il7yiGWQx/qdo3kYpWNoQloV331wueM9boY/NUdQQ15sSc4QV4/us+DSVfwt970osRIIytdu+Oi31CiYwWQj4dH8eMa9PNHz1Choy5Z69
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB4096
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_MSAUTHSOURCE_INDIA,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN3P287MB1320D9A7F2A14C9F0533B63BF7662PN3P287MB1320INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Sorry for the long silence on this one; replying on Chandru's behalf to
your review of 6 Sep:

https://cygwin.com/pipermail/cygwin-patches/2026q3/015304.html

> It seems like there must be a generic way to write this for aarch64,
> but maybe it looks so different from the existing implementation it's
> not worth the effort of finding it...

Thanks for the suggestion.  We think a generic version should be
possible, without the ws2_32-specific wrapper from v3.  We'll work on it
and follow up once we've tried it.

Thanks,
Aswin

--_000_PN3P287MB1320D9A7F2A14C9F0533B63BF7662PN3P287MB1320INDP_--
