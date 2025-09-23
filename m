Return-Path: <SRS0=Tj9x=4C=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id A767B385843F
	for <cygwin-patches@cygwin.com>; Tue, 23 Sep 2025 14:52:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A767B385843F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A767B385843F
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1758639156; cv=pass;
	b=GI7pbGKOon65obWV/Sv5SToT+xVNeDSBindOjdyQOL5rHlV5uI72ghTMAWYSsZCOgzRZJbIviWqVb6fziw/oNfiNiHmMScDdYTnTes4+xLbRZS16rluUmMcVCAoTREtrRRYBcTibS0whsCnrhkRA9h7YS5X6ppwoFCdTQTQ0qxs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758639156; c=relaxed/simple;
	bh=CuP9ApTDnCGY0+sTmb67d9rLTeu/drLa65gdn08ZHds=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=jC9S82FbvztmcpLpx++PH32xEFGeT1ExBxn/KaALeNzv9M+FcMvBukemDIJkQaCUh/KC13VKNRQLwe4juOd+b92VkMjzFPwGPialtPPh3Bk7+JshPh5LfEP1URb0nXX7Urr6415ORwSmDPHo0cNaTSKE31Z5eD5aVwHBtjQYkVo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A767B385843F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=MHRjbxBq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXzAz456zLHE6vTYt2avdOzZScL04KsqDytkBdapfRrgl6Oi6lPgE56rGFvyyAcJWEHHdk9Tz1iRvTygLZQKZ+/xqrTpOfpjAjx6OqgD+mHj3l1zWrdIH69blViKM/IaJJBxk4nQHY6wO/pKeM0U3M26TJ6MN8lvSHIz+j/hq5+3hETsIWW1PEMiSne41wpn859jVDl3tIEOzif+9W0Ko5mgRcexVoEX+uafLdqalRUS9etrVtpWFLU23nQDR7PDZHf2ZR3TeroGzZC/TQfLUENP43j88oqxxj0Y90Y9/KdnpYDxjVq1u5zKOwLfyEWAOTjohaCG5EWrtay374BZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV/+IGQJ4mWamQdL7oqyEmqk3lARsJZihUof3X5HXFA=;
 b=pc3HaYhpYo6wIrB6F1OiyvnaeOHCSWfPKn3KSuZ5Ng7oYxku18XIr3WvzcNdvF6Tliw/JnPOcN0j5u8T1N3Bva+dz4Oy5JoTi4FFBazI4Y9tmzgoUNcnM7dxFcbnKlFJVGICeIgfEwrcvThYIxwAbiR0naikC9VJxPMQayCYfSUL3kFpiXppKLWtUMkht4a04RHpZ4rYykvSMrIE76rbmgDrbRRrcZ2kR5rD6NaAw2c/irqUimULZ6fWzC9uvEbTBi4RKQnAcna6N9FINMIySIyAk5iZMS0HSH8C85flRNZ8Nxw2jK5yyBmskzTFVD3FX2+SJoG69Am46yQOt85kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV/+IGQJ4mWamQdL7oqyEmqk3lARsJZihUof3X5HXFA=;
 b=MHRjbxBq+8mqbNZ0pfph+aJl0OC+WmP0CPUNS6n+azV4IrDKJkiafyOe8C6DmIY5slZ76ToGRjYZnF7gXQmyZVlajfxdIraBZ1UlVfZCEfcUq2sDquaOqM4UEh21kowaPMfEhWDMh+PEpXUWcYGWPUg9ezDsSGjnUeG3+1o47SBgvYN6NtMnDWtQfa66jHj9GUzybP4wC4PK6MxxxXXpz8mljGqXZMtvW7W3LqW+bptQFcVvcRWLBf1qXRtXvUHmVQbU0Fxdk4QfTjhPvUstJXqEYnh/z6ErI8kPHsOxp718pNNrvfQBTMuGYyvdqFdWvxBorGFWNkf+kPl0k6aeMQ==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN2P287MB0397.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 14:52:30 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 14:52:29 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "jon.turney@dronecode.org.uk" <jon.turney@dronecode.org.uk>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
Thread-Topic: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
Thread-Index: AdwGO9GU5J7yKW8lTTmp+dxkBwCoIAGPKIOAB3R704AABI/OAACCWmFg
Date: Tue, 23 Sep 2025 14:52:29 +0000
Message-ID:
 <MA0P287MB30821DA084D178513CE302D59F1DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
 <040f4e8d-3fd8-4c61-b0bc-8a8d3683785f@dronecode.org.uk>
 <8fd38ef1-c4f2-9892-8a4f-8a797cf6f633@jdrake.com>
In-Reply-To: <8fd38ef1-c4f2-9892-8a4f-8a797cf6f633@jdrake.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN2P287MB0397:EE_
x-ms-office365-filtering-correlation-id: a9a191be-6399-4ecc-bc45-08ddfab0d19a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cZHHjlSYn/WldY2ElKp+oQZYrT3Ab/AcSt0+A8Rnr54l6VJ6+kQpbImbQ0?=
 =?iso-8859-1?Q?/TSuridReNqFlGtEhRUJaUJLCbwiNbBqxV5xNJW1BXNBuxwRwPRybvB43T?=
 =?iso-8859-1?Q?ZImnvpdJifZaPdZZcDaxDBuDW2JPS+/K2LTpLMDXhlrEIcvy4tHjvqFmaX?=
 =?iso-8859-1?Q?3bKI5DtZVC3zmnF6t6Xsbo0AlRrgpXEWtlARtRih0zNAHu1u4tVzx44RYE?=
 =?iso-8859-1?Q?+MZjbhiD+qeTFBAmcpMFHcvQLnLIco8sDA/DOYyxTDDzoKrCXX8gLxbU1B?=
 =?iso-8859-1?Q?NEWjoqWEF6K8R4LYWZVyBq+sHsXcEiojvD99W2KiBPYJ2S4iWovFCr7aWN?=
 =?iso-8859-1?Q?KGIkcFarb7BwBBm2/MpngP7ZwTy7VSehKvycHXe/mTo1GBeo/bxBV0aAZn?=
 =?iso-8859-1?Q?vG43dAyshjmfx7AuLlS2n5svpL255Mp3jE7BdJfA0Xb0V/sYCL2kn0j3Rf?=
 =?iso-8859-1?Q?F65FLmfajDeTqgvvyfe4nF1WkIgUeZEjmEyeg+wH0cQPT6WzIehq+8gi9K?=
 =?iso-8859-1?Q?szaVHFvSCgz0z1epGr3vt364gYdX0JjN+FwZ6+dwuYUKbIa2q1wH+GeyX0?=
 =?iso-8859-1?Q?du35IUwOxCVRbbbqLiY4CQeaOJJ0M7ZVWLW+s10qVN7l3fbKc8+G2Q6QhN?=
 =?iso-8859-1?Q?xr5NV5uFPl0lg80qyrSipPPdq1kE+IW0sg4uVqyCF2GDd/0DYj6F+7zutd?=
 =?iso-8859-1?Q?Bh+f6Rcr+/0XOXP3zYGAfLdIWlvz7k7xAXO10dqqB+S9kUfPRpOxCoFrP1?=
 =?iso-8859-1?Q?wjIWyYqHyiSkIfRpT3wUj1RiiLOknDIjmDHs4wpuIf2mqJFnVd+jnCwwl0?=
 =?iso-8859-1?Q?aFF4t6Ri2LM1IVsVSGW715g8mACpUR9QWD8e85xr64sB56zIg46hyT0yyx?=
 =?iso-8859-1?Q?q8O26XL5ioNocPa3GVhdJNFlTfMUjYDTMTkxjbNB/5GBn3G7AJcX7MVzOQ?=
 =?iso-8859-1?Q?Ttg7W+Q4qsjyPCRfvzlR1Q9yjeQJQ5foecNXdojif7czvKzd0JF/m+23ij?=
 =?iso-8859-1?Q?McHpFmzNwx/ID2J8sRuY3CJ16X4y/Wox6FUhSmXzxs3++3xPE7P7K+cQwx?=
 =?iso-8859-1?Q?CWjbr3WgTuKD4CMmlDroe0GxNarpBj0ecfzMO4pK/zQCKr4cxFxwQ282+F?=
 =?iso-8859-1?Q?lDkBnGjK8qzhFQsRLKZa0wm5zoL5DOUuAEISbJ2nC9P4gf3bPkVeKy/poa?=
 =?iso-8859-1?Q?pNIx8yjrRjbIeR1oHX+HF7PCkHz7LMbnxQvRX2Elh3u7kPd9e9JIu06ivI?=
 =?iso-8859-1?Q?i2fYCwchPH/2y6RSUB59SVa9rfgWs/qGIsCApsNaDvNwfLaTSqxCGlgah4?=
 =?iso-8859-1?Q?YND44I+SCD3HoZZlIaHUp1bMtGNCDRBLwGeeNwzxAJcbO1EFon5Y/14h62?=
 =?iso-8859-1?Q?Al4n9wkAID/VBRbwBZPODQI3kA5Lhs1vFBJBfhoVLaOLl83peWUcUxn14z?=
 =?iso-8859-1?Q?cNQLgWR57Rr1cfAXuE726A6k6OlalaGIMsW5w2ak4RFrnTBSgLeon41JZt?=
 =?iso-8859-1?Q?Su8Wi+m22sppgVral+K+QttZOvA6YSvsEzZirG0janlvQvE2qbjCIypJa5?=
 =?iso-8859-1?Q?sdsI4tI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?A2T9EHgGGKNGc2hTvRgv0H3OAKjJsLoB1+v2fa3NFrJZOX5kQ7f9vsw2+V?=
 =?iso-8859-1?Q?uH+Km/E4pdwbSICMjmedEv6DHaIxuYvekNdeGRC5lDhUsANqz5y+qFtRWo?=
 =?iso-8859-1?Q?f64Iit/GuA/VMKXbAARCTZqi0BLAmzQYCNnnH6B+v7nuZh4q7Qtqenl1dX?=
 =?iso-8859-1?Q?Q0zugBz1f+zHn/j98J7vvcIAlXcGkivggGcICN8/A0s4kqnzAg+1ocaOIO?=
 =?iso-8859-1?Q?T6g7VBkKh2QZhjVxSlmBthDrwPvSgKIG/PJKcSx81XYhN4B6/xrHAV8Tpz?=
 =?iso-8859-1?Q?Wsgc/EHHGgMizPQgDGn78reT0uWAv2vJKx1DHznSbMlAuL9eKVcIDtbZnz?=
 =?iso-8859-1?Q?HJ/wXT+iMvSbTu5JPpNnmPsHuNlolqvlxZ/rUXRIPqi/8zZGgNwn7kdMXc?=
 =?iso-8859-1?Q?IIkOHzfvVtW4MsEbLmvBx+uDlpeDXlioj+EWzxW8/cGjdPQ0tdT0Fr4Izz?=
 =?iso-8859-1?Q?WhPvaA8tf/LWcGEB8iFW+i+dN7l71nO/qmzmP9IGQ3lBFeBcxWt2+PXDCq?=
 =?iso-8859-1?Q?Uzbd5INOkqLgagHMNaXzhnVZbar9pyAIFMrtxrnS1w/6s+ySIL8Q72/NOd?=
 =?iso-8859-1?Q?ZZuKhlM06pBh2Zpug/P9a4rJOv3qI2TTDKflB5t00nq11GwQCdOnEHbFim?=
 =?iso-8859-1?Q?M8O48mmt6HBcfHppZVYLWSc+6GospoNMgp6wfZTXcxKw3UAWxu2KZVucPe?=
 =?iso-8859-1?Q?XoBNtI7eyHcnTbMFiIzVPbtV2dy+3klLo+gaR6HNIIKbH7alQJFqqAE0p8?=
 =?iso-8859-1?Q?FqGcp+8gAjfOT0wHjQPbtbKpSL9vOs2SyMtEcSiMECedDgWMf74FaPWPUc?=
 =?iso-8859-1?Q?nHmTk1t1LtH7KoiojSTpoLlH4OWknneMhDRg1rt13wFSBh4sXUZmtHLPob?=
 =?iso-8859-1?Q?XkYnJmbQPxTraM/psXoJDzdxXWZ59chdJHpQTz6tl7dvJmu+YD0TAIngpE?=
 =?iso-8859-1?Q?sstVIW73mqeJRPSFNMONLWvryTsW+H2aOXoTLbydLDXPeviVrpUwvDdszX?=
 =?iso-8859-1?Q?vzsvckzXOBiS137/5lfI4TJiMdpubquXXNa2Wk4bNbkVDSJcKDL+idGM6N?=
 =?iso-8859-1?Q?3HG/bY9GoYvf6qgLkGFaE8L6fWjFyXxYL/9xEIng1LCL4oYNtwLMaww33j?=
 =?iso-8859-1?Q?i4IxqZa3O5sz7ccJqX4CEeAMLR7FIpjtCDNe0hPZEyCeoZY9X/8kixdB8v?=
 =?iso-8859-1?Q?2lsKniT0vqcX9gx5t0ZUO5qEyEK5tQ/KeGlJdBDr33QTVyOMrvLKJIpPPI?=
 =?iso-8859-1?Q?vZP1ODIgy59+SeyQgPBlDCve3iA4tSprY2+LwLt1sfhdqPzPJK2z4cRSVB?=
 =?iso-8859-1?Q?Jg2kpDVm+AuQXsf4ZNMy5MA72b/Wr0eK3HQ1SYhVNKiWwcH/G0gC3Dan0m?=
 =?iso-8859-1?Q?/rBGHlPRc1t3NCaFUg6Air/C/4bPIZBNVFZWtAMmZrFlMw5rMF95D/7K0p?=
 =?iso-8859-1?Q?5aPL0S63gu6Tab9nd1oUPTOWOFXLUarPCb55iglFklwsHTdR8yK967Ob6n?=
 =?iso-8859-1?Q?9raxsGu5C7vpCz4ILdrnQm0CWsU4XebsfDmMaTzNf+hfqihC8kUc/qPlg+?=
 =?iso-8859-1?Q?nr9RSTKesjRmAazRkBunMSPZjRons81R42FF6L06A8a0NN5+XU3wlRQ1WU?=
 =?iso-8859-1?Q?19yBkMlnIphpTg4iXa4IUyZtdH711uufLb1CzFP3MxNoKPe++fUKr1gD/s?=
 =?iso-8859-1?Q?Kbq4gR47f0XNCN5qmB3SH12HXNyYClZm2uMNHC4L?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a191be-6399-4ecc-bc45-08ddfab0d19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 14:52:29.4142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vYHiJkndLSgWieWesTQ9dL++AmMboYfLf8/4Fobs221jWUndjVD55gtDGBWKAUZZGIKgxdqnoKjTJ3L22OD5qCgQK0hSOL2FjpzcavtDoA4NGg4hcVWUfHcz1F63V4O8636/7w3hhErkPx8fl4+P4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0397
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi,

Thank you for the reviews and clarifications.
The current [arch] support in gendef solves the immediate problem, but I ag=
ree it diverges from how mingw-w64 handles this. In mingw-w64 the .def.in f=
iles are pre-processed with cpp, and macros like F_LD64(...) are used to ex=
press the long double =3D=3D double aliasing in a portable, centralized way=
.=20

If the consensus is to keep Cygwin. Din aligned with mingw-w64, I'm happy t=
o rework the patch in that direction.=20
To break it down: instead of adding [arch] handling, I should extend gendef=
 to recognize the F_LD64 macro and expand it appropriately (aliasing long d=
ouble to double where required). This should unblock the patch, but please =
let me know if I'm misunderstanding.=20
As a reference point, mingw-w64 recently did the same for _chgsignl: https:=
//github.com/mingw-w64/mingw-w64/commit/fc3304f00802dcfa9ab85828ff6ceccd0df=
62efc

My intent with the sqrtl change was just to provide a minimal exemplar to v=
alidate the approach. Once we agree on the right direction, I'll extend the=
 same change across all the other long double functions in winsup/cygwin/ma=
th directory.

Thanks again for the guidance.

Thanks & regards=A0
Thirumalai N

> Sorry about the long delay looking into this.
>
> So, I was about to apply Thiru's v2 patch, since that all seems=20
> reasonable to me. But now I'm not so sure...
>
> I think that a good goal is to keep this file aligned with the=20
> mingw-w64 version, if possible.
>
> If I'm understanding correctly, if we do that, this problem goes away,=20
> but at the cost that fsqrtd and fsqrtl are potentially different=20
> (although surely since it all boils down to a single instruction,=20
> that's never going to happen
> :) )?

Right.  Also, I expect whatever is done will need to be done with all the r=
est of the long double functions in winsup/cygwin/math also.  I don't know =
if sqrt was intended as an exemplar before moving forward with the others, =
or if they really just had issues with this one.
