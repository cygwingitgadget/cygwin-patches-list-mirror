Return-Path: <SRS0=z0xh=CP=outlook.com=barbro.redin@sourceware.org>
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn190110000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d101::])
	by sourceware.org (Postfix) with ESMTPS id 2307D4BA5439;
	Thu, 16 Apr 2026 10:38:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2307D4BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=outlook.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2307D4BA5439
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d101::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1776335893; cv=pass;
	b=v4DtZsETg1RkpLD5iNgB+bSLuhIDyJbE0FBvsxOV5wCUTXbJbxSydqrHikzBgjfhr2oTcgA3Zk4Wp7SJ2Z4khWujQfCndsEaF+nExSI6C2AbQCAh/eFtoACNzYsj160hiDpP8ndXcWDHlerhA8nAODJuNc6XEAvcxpmci3xHaAE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776335893; c=relaxed/simple;
	bh=DkA6jAzoCOj6FSQ9pT2abuT38qkQW6fHCfDON783UGU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Uj3e9oeSgDVfEoGy6TWbphBsw5Zdn3Xh60g0qCDkRavcfQrRXQHRpVcGfdjy71XRodnbWTmJkA21WPJypjMLyO1n00BP/qAc8SD4kx9wj7MXbQNE3PYqNA2rpnWjLMr6rIWMPvAvuX13HNixrVtJSD357WJYEpZjEXgPvi3Jpfk=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2307D4BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=i2XohTbR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfVCqWO8b4l2v9VsTe7Elvm8n9OA08i+OREALRze3vk0w9wTPM3PxRWngFKolY4NE07gb4/6x/c3xGxZh/UYwmOP35LxU4gE6EVN+UjWZmilKYaOBylrUW+6/6BF6bP6wSXHmOkQgPsVmvrcait3QtngsR/AT/cMMq9k7sOhMhoiN/eMR3FXITUgKHyu4bfCvcqij+NGGlBb2oGm0B1G1a19ec4qvEFw93SUpU9Q6//s9MnL1wP8cvMdfhmrr/vgrsBgH4chC6w5EFZlBCOro0MWeU3zPvFgdPJTrGIN6F9D9CCEv7jpeqE+jQLSXtO2VizGIhad1SC/RXANbIYc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkA6jAzoCOj6FSQ9pT2abuT38qkQW6fHCfDON783UGU=;
 b=Zl6LbrVjJ/bc2UBHpHQrlzV9A0gvzMBHY+MIVE/UTLfaiHInvqpcGPhOwlNZYPu8AIX/TrL88j8ZUtd6gJNo9d32Az6Lw5Go8iKUIHk2rxsI5lALEKWD/PAVX5qX1NhHfrUVhza8SruRe7EpB0vMEypuxxxFYT/VsIEQoS0rILJbRyISb/3eX+lMh6QP8fUa0NHVJGci2ZGvO8NjGhVWp1x/+tUDMVEUHFGUFH+S3LSMcIs8/v6offMU9bNwUQk0x3mkje6JPFRmpGiWqGAHvbq4NYjQYYXt3chxJw2BQVCw3VIYbbPn4jajZCKf+Og3Peggv90PuhdsyPZXfblG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkA6jAzoCOj6FSQ9pT2abuT38qkQW6fHCfDON783UGU=;
 b=i2XohTbRO+ZrNdAhaCsMHQisPIjaDwgjuecf3SRxt68nLAYVugLElHnBXZYhoDbqtDupGXwkgNi54J3Zz2InWUIddv9IXjTHyDq5BXgGmwYbbZ/jXj5Lm6ETbhjnPEu093v0MvFT5SjMr9UIPNAbv7pn2Q3Qhb6UwCCungU0PzLRmo+/OsZ4FP/9+o2BV0wqS8lffecm51QuDoG751NWtRVAEcKxYaDpsWbF0DU1lgopGEwkjuz66yZjQn3kzx0EO/yvjE11qXU+Ffkt7/trrgsoIY3RTKjhklVwDD+vmegc2kp1RUJ0ZNDNeAiuAlQnP529Ha2S3d4GOgNKOnrUEQ==
Received: from SA1PR05MB7998.namprd05.prod.outlook.com (2603:10b6:806:18b::19)
 by BY3PR05MB8449.namprd05.prod.outlook.com (2603:10b6:a03:3c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 10:37:59 +0000
Received: from SA1PR05MB7998.namprd05.prod.outlook.com
 ([fe80::ec10:4480:1eb4:7749]) by SA1PR05MB7998.namprd05.prod.outlook.com
 ([fe80::ec10:4480:1eb4:7749%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 10:37:59 +0000
From: Barbro Redin <Barbro.redin@outlook.com>
To: Barbro Redin <barbro.redin@outlook.com>
Subject: Reply,
Thread-Topic: Reply,
Thread-Index: AQHczYv7P9qelxTjr0CROpGs1uoElw==
Date: Thu, 16 Apr 2026 10:37:59 +0000
Message-ID:
 <SA1PR05MB7998F4EB4357DDDDF706EFD288232@SA1PR05MB7998.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR05MB7998:EE_|BY3PR05MB8449:EE_
x-ms-office365-filtering-correlation-id: 590cedb8-bfc1-496f-3511-08de9ba43a8a
x-ms-exchange-slblob-mailprops:
 zZTkHIKWWP8EXRfSHz/+bmvhnEayH3FsCH8PrtMf7w0toC1e27KQ0vZjbe0jMZ5/kFBuEK+NweR0DM0XSqAsBozqUPROaS7qlqNZ11+cOxaPjthh/9ruT+gPK9aoHQMBChiAVuB8o/ekDPcJ59a1ncrDK8IxAyIgVpu2BmhBtQCOgDt/nNeved/IF1ox0AJS7g/GUntOyqgCSxQwb5k+x21qCtoveEUeplO33hZvjmS2uBLf2n/Fl6p3hryGwTqTsay6a0FbZdkS/JmnJ7yMhr/qQbu/9QUe5RhLKEo1sWXKz+uI/CDMGNSyvcanB6WpfjIh3TiU7c4ecIoh08Xoi4ZrobJmu2wuNz6PD/xqWiCNnm1+f7Twnw+DhZTPxuyasVd2UcLmlV5m/tASc0ds2MuNJI2HOdG/cQVwKGQltJS7Y8s5sR0xhWv7xFaeDOY+qenHTGpdP2OZqilnaKGu31TF7ecA+qFgNWi6k0u8eX+LlPbow+4b/dLIjq6JZiH/s/EmLkPEDe7ebLdAkM2DY9T8sneQhZ9gWdOl1UbGEXFORrNpCqzBEbyeqTie+0qIKaVtP2downi+bi1DixurhYgCmDXHskjkxgFC5Aq9FRdX8pjkyZmDK7tQVLKS8NNtdLnRipt8XcmyoKzvF7Of6G/MEU8VNx91MUYh4eWwiZBDnylrITLJbQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999003|461199028|37011999003|7071999006|15030799006|19110799012|31061999003|8060799015|39105399006|15080799012|8062599012|20031999006|3430499032|39145399003|41105399003|40105399003|102099032|3412199025|440099028|19111999003|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?IEOpRbZqaKQd6rSXAxSFvTxcAvCSFK3cf183U+xa3g7GyVy3JmYC2sdiMt?=
 =?iso-8859-1?Q?xXgCMr8PrIiMZmuFrHI6+s5Ra8CVwMc0qStp/eXmHqWObHztuLmK4wLbQw?=
 =?iso-8859-1?Q?ajsfl0OkH1n4z1KMdelAGQY/M3u6GtSh6DCsJ3IUjoE5IKVOzE02BAQyME?=
 =?iso-8859-1?Q?JMp37R3CnJE69dyibStpeRGkmZyUZucspsKj0c9mrTxBiAw4lNIGpByuSs?=
 =?iso-8859-1?Q?i+u8fG2Ke0J9KS5RONjdGqD9wsw+t0yH4RG3fnyohCwY07hgJeVm6yuTmD?=
 =?iso-8859-1?Q?BNtOfBzjZyOut4vEeo36zDJ51h3+wvO3ZezEsE3guAK63I/AaSkFH+nbpB?=
 =?iso-8859-1?Q?9cgWoCoDtWLLEMK1nnW6Gs9eLykXpWxSmiCDZTjeSZB879V7S2r2kWhAxi?=
 =?iso-8859-1?Q?vtK68+K6sf8Ot8+lPhoNREwfsX4Y0TZ//AwAtr3hkxnqIsNLZpdrbIjn01?=
 =?iso-8859-1?Q?zTA8BLde2KmTsrMwKqYWNMccuLmxBa6cQ8SKldDDd3ik56qV7kmOMWRSwT?=
 =?iso-8859-1?Q?Y0wRCmh2BH0yXRjII0YwT1sW6MOzCbAA2UuxrTb33bRrR3BzxlWln91+n9?=
 =?iso-8859-1?Q?d0YRZf1o0qE5x4gyPDJwW+Q80Cr+TQouz5tXW7dHl8sagePfK4Cns58FXq?=
 =?iso-8859-1?Q?1nCNQFmq6APOJSRQx80oOIyCjgfu0LXZCK47b9bmEfMnHJyY+h7dQki9dd?=
 =?iso-8859-1?Q?Hy1Vrf7+/Q4R0IpQN0XvW8cdnVyHt635PcuYwPcWU+Qns4ze3SWNyAMUYN?=
 =?iso-8859-1?Q?+H8g2eCxVG0L1O9nDgFZJ2XPicKLe9ayUEFjGgPczE8AUlPlSbRo26U7ft?=
 =?iso-8859-1?Q?OGOca0ozFfLXkyqRgTNfOBld8mDySCClxF+W6IgtLPZAC3HigbirTcixgx?=
 =?iso-8859-1?Q?C8dPZEmzBEdd9Fs2ArdtC1/RBKfzsLgYr9bUcLV24fievPr6/WKqo/7zod?=
 =?iso-8859-1?Q?Cp11+GtQ89FjSGvtgWr5dUd2t/pRM8yeBpi55IhcH7X8YIfd4H2T93BpHP?=
 =?iso-8859-1?Q?yK/h45jz6IhdZLDB9b204jG78NzkR3/yLZMa9AAgnxZMVzWSs/BR6W1KaN?=
 =?iso-8859-1?Q?dnURwvFPr+R6tp8tJiAAZ4nYEpdgvOGD7tnEOeUmiHnjr8riSsmlMoP16e?=
 =?iso-8859-1?Q?sPmIVHN/UyIgXq7CPN6qt+Og3Bv+ryl+10s+MnTbA/ByyXG58KrWh7Pr6y?=
 =?iso-8859-1?Q?f/cGTaTb9bbX4kcjg4A8nNOgjnef9hrEAI9sD4EQ2TvO+0e19kFHc90K?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YaZIiUB2H3+92D52UUyGfHjFjlkMcylUTMTr6UcvZJdjQMAVi3d0iMFxVD?=
 =?iso-8859-1?Q?BxSL6nOHa8AFdJ3aOzMFxW+8fSF4rXfAX263d2URoFmUMZLF9M78AH+Qla?=
 =?iso-8859-1?Q?kB7I0Nw4RnTx70qZURqUg0jk1oD76RWO2tuP9hU+m/ZY6cSI+DPS+SmNse?=
 =?iso-8859-1?Q?XZNWXKHkqNXtVacJ6aSbVM1HpciIBfdrSXJRxHWYz0BX89cdE9Exv58zS+?=
 =?iso-8859-1?Q?R13qalJ5LVWVGM+u+0bNT/SI8qkIKskUMuh/EKA+QzrNsAwGw3/4q/GN/h?=
 =?iso-8859-1?Q?Dxj6Xck818/kfH2L5c43T4HPQje6A10rSkba3dUKyQgy6fK1SccZkyF9Yr?=
 =?iso-8859-1?Q?b9flUt/CRrtYBTzKJKQklUt43Bn0nnGKB9f92Lc1Z3DoJ1wYPZkrSsYcTw?=
 =?iso-8859-1?Q?0pFQV/HCab+An4sqlWqDMiX4SpM6OFYwSTz0h+VyF1uXCfeBAWduA+caFB?=
 =?iso-8859-1?Q?nalLPYi1Ub7KJjx5uDT8JBpc+/f0oWvpTEL5pW67eOJ48j5pdHA0JeZpiL?=
 =?iso-8859-1?Q?QMUfUZhfCjV0BaR4YkqCkx2KXpC2QeC0Nr9TTcXOKSN1u+0DaOG3kv5njX?=
 =?iso-8859-1?Q?bLGgiCbXhQNlbyODrANjf8KfRkCcKFntDCF1cbuAAOxapQBuHqt6CA4PIk?=
 =?iso-8859-1?Q?3Zo1dqDZLkzdgOD+16DQwFUWS4oobVkC8ughwv7FZumfrWABe0NLDTmTE/?=
 =?iso-8859-1?Q?yKohwVpfPJyLQIGBHJtXH69dnxka25eSselXO+VFZMualhdRI+0O0B7Fft?=
 =?iso-8859-1?Q?JEmMFUR2R50qT47KqsbvDd45rCEYdBcYjjZWHZzKnLpgFwbKTG/bb6aZ2j?=
 =?iso-8859-1?Q?GGgxf5kF6MOmXaBysK6sn+oTEgejS9Lfq8ygrwn5kbIOhNXADMP2mV7ttm?=
 =?iso-8859-1?Q?e5dceurMQbOgwVENdTxr0BTGje2uwCX3yrppclGL1Yt4mukEvkrJy+PFLf?=
 =?iso-8859-1?Q?b9BcesX4WSh8zTsvj4ULxb3Sqnk24QZdGwplr/9dtZnJJn9tOhcNs7WPut?=
 =?iso-8859-1?Q?8drDl2GvpCfLewh20lrJSfdTBpVKHp4JZDuay2lPYWESqrgwOvqwQgBhkq?=
 =?iso-8859-1?Q?2tpRHvykSId1fOeFPnGiBvQd8tGuIIVffxTJOiP64sgo43v/JYEaTeq4AE?=
 =?iso-8859-1?Q?8gaMb7RKcjGyb7RqZC5qVxnrwpwhwPkWNpbosuwqnxcLr6tsaR3HHeXq8o?=
 =?iso-8859-1?Q?ZcKAzFBNJg5xPJv26X2B4xvV5ucsnTlx9sXAL8m5o4b1BtG+8PTCrHTsRz?=
 =?iso-8859-1?Q?2zUCTd1NAtt1GKNmOti3fCJz24qTz/yOy31U8g4vOefrPdJ9VlrwK+fGx0?=
 =?iso-8859-1?Q?PIDIJSpGLxtjjGvDXIGfJRQds/jW6hVeua/qgG/suvYLg6/zSe3kTqTDtB?=
 =?iso-8859-1?Q?PkOjnFNUEY1F+5qNX1xM/7EaLynETc3c5zEiZ2cfyxjDqAisCuMEDT5+lz?=
 =?iso-8859-1?Q?OocUn7YdSRqHCY0j?=
Content-Type: multipart/alternative;
	boundary="_000_SA1PR05MB7998F4EB4357DDDDF706EFD288232SA1PR05MB7998namp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB7998.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 590cedb8-bfc1-496f-3511-08de9ba43a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 10:37:59.1451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8449
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,LIKELY_SPAM_BODY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_SA1PR05MB7998F4EB4357DDDDF706EFD288232SA1PR05MB7998namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I hope this email finds you well. My name is Barbro from Malmo Sweden. I go=
t your email while I was researching about jobs and living conditions in yo=
ur Country, and I decided to try my luck by trying to reach you in hopes th=
at we could become mutual friends. If you are open to the idea, I would lov=
e to exchange letters and get to know you better. We could talk about anyth=
ing and everything, from our daily lives to our interests and hobbies. I be=
lieve that this could be a truly enriching experience for both of us, and I=
 look forward to hearing back from you.

Please reply to this email at your earliest convenience,

Thank you for your time and consideration.

Best Regards,

Babs

--_000_SA1PR05MB7998F4EB4357DDDDF706EFD288232SA1PR05MB7998namp_--
