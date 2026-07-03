Return-Path: <SRS0=+QPO=E5=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id B87544BA2E13
	for <cygwin-patches@cygwin.com>; Fri,  3 Jul 2026 12:12:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B87544BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B87544BA2E13
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1783080776; cv=pass;
	b=HlLdpwaDje5MmM8o76IJh8wbr4BCcL9Zi1+jVfk9UGLJ6uQUEkiF8X1NXEPGITiMrGJVO+P+gUy1nkvkRGL4PdsWTfkNf9Mi3nF7yXsCRgddTYZAJ8WOUBLD+v9fB7DLOb/Vs5U9J2N5wSPBjYiMivOecyR7pRFigqGlaj7Nh/M=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783080776; c=relaxed/simple;
	bh=XXRw3JgmmOv+eF8HvOIa7cKyGVSWHb+8iGNCRvJC+nc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ZYi5kE5MzLIVbgoKgZMbRZCeSD0n/Wsku9iMtvto8riyF+fF+r8Gdj5zOJ22FB2tcTBV5/dnMNqkTyau0aRYPU7aymgLNKUK3kok6k5Lz+n4phAKg+Pz12Pitt7pDxeXbMSr2/bUjp8P5gSxE72pHYUMLye+4U/l3TYDr1Gt+5M=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=rq2bZ7q/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B87544BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=rq2bZ7q/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7KkcQfuCqVGVPt1OTL4Cu0jKX4IezF8wtexAoYuCarwMoWh3rOR6XHH9EFL95SowrrUGa8humfqZVXgRuDTFvBE/4aXSUNSG/edYkpS/JgLh2IJZMDvy3iN4xvVXNaRIsSjB+Hpe4+UdIL1wn/G8vP9+Bpq+Hu0ecLoj4W13yW11BH1eTk6VOeSx1xIv6wTgVP8EJKK2Do9BJwt3JbE6yfsOWyfTBc1BvJRj2A5ltcj0me7tw5uSDTdecHOhcmy7G/0UpnLB3SCwRjY5tDf8ryja5C8VzXqgRMriI/UHVO8yQULPpmVNAHJJJRa2YlHs7UpZ8eIi4vFJ/4V7ODFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/bBbJJxlO7a0iKGRhJUHZu+68avpEKB9SictgvNbbg=;
 b=w/Wx2LBJuIMltnHtF3nZU2mS0+jUK8ljFiG0JDyd08ugEWpsjlzFzPmsxWK34BLRBAu9ZFWDfmaPzF+vyywFsHJa0ennmjUV7lB/kMM3m7EUiOe2U3tk6JkJ7I+yUKdcBowden+akloE0CHH3h0fBOl/2lOXP8YmAoiNMn9T4eQWUchsEWvHFcag4QxuttnxFMf82mhHYxs9SvfJjg0M8t3cM/X33r/3F7VUqKU7suHJO9wC/62YgL8UcxNmC8ehNd3O+lOOFOcwEFQYC30dSKKm9ediEevyhld7ASkMJqIo0L+cEUjvix4+G6qz12o4N1a/deeIDNcMonFijoCkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/bBbJJxlO7a0iKGRhJUHZu+68avpEKB9SictgvNbbg=;
 b=rq2bZ7q/4tFEUrBLBkxv1p1qCTjWycs7SHavwmaHo82EIWpk+FMqGgwovckWpKgXts2W0rJy8Blk2AioCd3YfHkenMR4jmgjq3bRZ1uY3siS9mwH3ylYnaf/AE+7aQTXkViHmPu5+2HWzcQ/pf5yr9JX5FOjLNnV5gAwjZBSmKuLrnyzWe5X6w8LZhodHV090iPp/9U4jc9EwE4k5wZ0ClsTbF5rO9qZwjgR5z6+nOtQYJpSMJpEa12aC9HewktKuwcuG0D9UtkjjD4ddXJoHJb4c5MlN/iHDUDw+SaPfj7v1gJn5l+Pl2VDvvq+B1/9Rj8+PX/FjOGUq3y5Ihvdmg==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by PN0P287MB1305.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 12:12:45 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.21.0139.018; Fri, 3 Jul 2026
 12:12:45 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Topic: [PATCH v3] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Index: AQHdBUqYQOvFz8P5iEWbhjhpQHTJoLZYpgOAgAL/MIs=
Date: Fri, 3 Jul 2026 12:12:44 +0000
Message-ID:
 <PN0P287MB02951D01A967275601A56B3092F42@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
References:
 <PN0P287MB0295342E2109C2CB8EECCE6B92062@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <ag8IvAkqoNVM-AH2@arm.com>
 <PN0P287MB02951A11C49A1208A9BA66F392102@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <99590c72-bc88-4466-95c2-ae540a11c031@dronecode.org.uk>
 <PN0P287MB0295EC86F97A259F0C99818F92EB2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <259c44dc-9e05-4549-9768-e91c7fc8ca3f@dronecode.org.uk>
In-Reply-To: <259c44dc-9e05-4549-9768-e91c7fc8ca3f@dronecode.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|PN0P287MB1305:EE_
x-ms-office365-filtering-correlation-id: fb1fcf5c-351c-4097-e196-08ded8fc63bb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|39142699007|31052699007|366016|38070700021|22082099003|18002099003|4143699003|56012099006|8096899003|55112099003;
x-microsoft-antispam-message-info:
 2kMkpxcfa8aoG3TmDEPMa1nuO6XqJbzWuXohjYdRmkbXym5TxgVfzRQekzqYkTWfZ+LYirLscHxthATnrhfGGt91mA60Nx0Tz1yem9rXh+9yy2IuMGkJPFcZJI1p0KlFkQAsbhds94pIAV6I7WVrvBUdAETEzl7n8EkkCL1d0vKo3rK7Q99qrRhK1iTni+CtQwyxwSGBPjmzOEYAk4EW7sDbcKTsiiuYitlcA/QvYpW5PRywFpGdxvQ3ElDEmHvzvhOGvePLDmpqcO5mQKiJatCuuCRKkvc/14ivfY+Rd+93VisVH6fm6rOqgqyUtNI36kHDd6/SXPgSiDHSLlkak1M2scE7t4JzIQwdgUFLqSblcQVoTXLtDUDb0NbgY/oLuKc6GMwQCIQfM6MZ32LMIKdW+5KgQz0RzRM9G7X03/E5AlQ2QmbNkM5/DVos7YgtKRrvZRGZVr1q13QtGFAkg8XENUuSKJR/uIo81knRIDND6Wuxvmz0Dc5WUczLar5EaVpNqC+pIi7yrAf2594rilqGQ8a4VAhwW8tziCwuz6vHhnSS1rA80BxRO8npi3DH75ZrfoZPrzzI2uPI5FGyXJ9bwyH42StDiIB5KJrfaddfQoz+oyc50RkeXfhCLc+Uob4khFqCtp5DjYbVmkNK4KQkjNhktniFy49Mjteh1zrEz1PNf44W76h3+4Zzd6f2SWM35aTxGOINrlqKv+6DOw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(39142699007)(31052699007)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(8096899003)(55112099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?P8YWzFMxypQ92YcstgjvWesR5Mv3W76hywbL8SV6WLDd6kwyV4qjC8wk3d?=
 =?iso-8859-1?Q?EJVpLAYuLsuldXNsq4FgarZvS8ifzH9ECQJSydJuhZhHXW7HqgAtImATdU?=
 =?iso-8859-1?Q?vNPi1gwdWEv42Hymw5IkVCa70C2BrVure66HOwZ+2CcQPv57HujFtClUn+?=
 =?iso-8859-1?Q?Y4pvybZbxdoIpy7649rFKHVceYD7aoEz5R+KoXmDbdslAuJUr1RtkhdnOp?=
 =?iso-8859-1?Q?c/AkOgLmp7W2QsfDNhevG2xpFGvD+FMELQqw5Xjv8xOqE4+9iO9UcBtK1R?=
 =?iso-8859-1?Q?XWctrGcwyy96OEKpmEh9xdDOjExiwIheBHavLgGZKe5Y8vx8Xdr8J0NGCH?=
 =?iso-8859-1?Q?UBsVTd8F4hDQF9XBaPiTGGaM7IPcz8WvKDgmlMDnJkYkE7HC5j2wfcSbOG?=
 =?iso-8859-1?Q?SFdDqS6q6LSKZ75A80521jmB7w5xB3LTT8Ozcbv+/o2ho9Mcn/Lg79lN30?=
 =?iso-8859-1?Q?u7lyAi4jkHa+A4wmYVX8MDag34PRb9sRek/FJMXSuGl+Tqd0yZ7Zrx4oUx?=
 =?iso-8859-1?Q?f0bV5gw3D5mDr9tf8ZaZzEP27Hwk+XleusbMtdTXnOn9HrbA5t0K/AbXXA?=
 =?iso-8859-1?Q?LfAHv3GabfZ5pPrha6fT7G8/gg8ZN3cCVTo/01WDJfi0O1hENS9nkckJKj?=
 =?iso-8859-1?Q?FpvTYpGzm5OJEy+Vm+n5YeaQ8jellc83lsvZhjv2M8wnz47COUEKwPA/Pl?=
 =?iso-8859-1?Q?sjKdwKFkYtz3JVr+hORnrEbECl7K/RwCK1xlUN/QXcPwU6r/KVke1NU8gC?=
 =?iso-8859-1?Q?mPGE8ENQcOD9vJJZ94/cdfc4X1Q8Ea2H2Gar392XyhP9DzI1UFquVJBflq?=
 =?iso-8859-1?Q?J5GMr08+iQVAy8DzjRvi6q7diVk06OL0nrIggU4bfB3HKN1gXHn8WNiSxg?=
 =?iso-8859-1?Q?y7tlMn7Ugk3TlgMP2hKltr/3Fg+FY5VkF3qVn9fanwm8CAEP/Vfch0gfDe?=
 =?iso-8859-1?Q?NSby86pBGsDH+AMB/YbwisADuxpbAC+RO9Fh/QCOB7//ueftLX4WC8CiKt?=
 =?iso-8859-1?Q?pHVSCI/VIzqCjfgfJId6L0PklG9NRSDhehcNSdtXjCVcm2I8QaoZuyGSut?=
 =?iso-8859-1?Q?C65fpSBOjVLavLNDvt3QvgeQvfRsLNmnKWpnLcOSqNOsBeVMibz4i7dBXb?=
 =?iso-8859-1?Q?2tiyKtPYK/AgptKWPsOWX1bY2Hr+1NcGtQQsmt4gVwU3hiJnqE12qPH4mX?=
 =?iso-8859-1?Q?u1qZGm+fgLzR0vnxQcpM4+qcSO3FJgltN32UdImGXLmou27ku9N3DwiM9E?=
 =?iso-8859-1?Q?iKsA/DZoch1Zns5PCsPkpJxAzKMyiO7oL9El+LPf+l7PYq3UtpXP0UsmLE?=
 =?iso-8859-1?Q?wB8wQNa9W9+iRLhQuRfAXDNcMEepHrXJP+LR4vjcp8p7r7zerlKqVw0HYB?=
 =?iso-8859-1?Q?PqsH8WF3RJfHuBz2n30DpteZyCytlx7t5cqz/zMqgok1IHGM1eOUt5PJbW?=
 =?iso-8859-1?Q?uOZn7DMbitOeAT01PVyR1iLC+SmUZ+edfES2X4LTqQIF787Jwmr0BJaq9E?=
 =?iso-8859-1?Q?rB9sLk4JzWPBYFdxFcEVLh2k0JgPW8SgnaeD0sWr1MSkWc8BWjAyUOgppE?=
 =?iso-8859-1?Q?V/Dac/CpjKkcCmZCAASvoqgLfLAfcUxbmC38nd+jNuUei8DmRrYGeAdyV2?=
 =?iso-8859-1?Q?Qdtgd5dtb5ySzWy2SXLP2SxQUO8fuLLwMzrFgNuaHOHBCzs3RqEg4UXFo8?=
 =?iso-8859-1?Q?tFZOl9EbQgx4HUEIm3cLd+HFZGUz7K9QnbMx+konJ5QueGlUWc2F4Egcqh?=
 =?iso-8859-1?Q?tdQP8fHqT+gI7jYf5UsxzH4mTx7Q56VZDqOUg349QZuIz4GBOFjkKstnUy?=
 =?iso-8859-1?Q?6Pde4EyW/aUtIgFxQG871Jx0cjr55YI=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB02951D01A967275601A56B3092F42PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1fcf5c-351c-4097-e196-08ded8fc63bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 12:12:44.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypoNCvCFYdJnNV38qyu3ytIGti0r1Y7EjOqg1jSDjDIPHf5b57g+m6ILiTBZ4nXL8pERPWOiYi7LYLhxD59Vabth58HJCw+GwgNCzMIX0uv0aQDLlZS4qerDKvtAiMMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1305
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN0P287MB02951D01A967275601A56B3092F42PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

>Hmmm. Are you sure? It looks to me like it's non-zero in all the
>existing winmm uses.

You're right, I misstated that. winmm does pass 1 (all 20 waveIn/waveOut en=
tries).
The correct argument for removal isn't that it's always 0, but that the val=
ue
is never read anywhere, whether 0 or 1. The flag was only ever consumed
by the DONT_RESOLVE_DLL_REFERENCES reload branch in dll_load()
(added in a16b0549d for winmm's FreeLibrary-in-DllMain problem). Corinna
removed that branch in 105f79b48 ("Drop use_dont_resolve_hack flag", 2016).
Since then the value seeded into the handle slot is inert: std_dll_init's
(uintptr_t) dll->handle <=3D 1 check treats both 0 and 1 as "not loaded," so
winmm's 1 and everyone else's 0 follow the identical load path. Removing the
 plumbing and simplifying  =3D 1 to !handle is therefore behavior-preservin=
g.
This is why the comment explaining the flag disappeared (in 2016) while the
plumbing lingered - the functionality it described was already gone.

>Anyhow, the "fix ws2_32 chained init on AArch64" part of this looks
>reasonable and doesn't seem to be connected. Can you submit that as a
>separate patch?

Sure, I will submit a separate patch for  no_resolve_on_fork and ws2_32.

Thanks ,
K Chandru


--_000_PN0P287MB02951D01A967275601A56B3092F42PN0P287MB0295INDP_--
