Return-Path: <SRS0=Vv1d=D6=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id F014E4BA2E0A
	for <cygwin-patches@cygwin.com>; Tue,  2 Jun 2026 10:06:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F014E4BA2E0A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F014E4BA2E0A
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1780394808; cv=pass;
	b=iSgPWnZkr0Pk9misB8/VhrBKaLPQosZARn9CsgI2oUY0J8I10RwZY4bBwXxX1dBIaa6yqv/3tv9w2tRNPaRpuP/QZcIPMgLqDNXQYV1v1Pm0YAX+TqMIHfRBfcciB5o43yt1s/miZlepIuXdrwUv3YSerUlhdapup+0lwTuIYQc=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780394808; c=relaxed/simple;
	bh=MkYJhee7UYA2Vu3oZJbPsiRGAW0lSWx0w955axs2ABY=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=QBo1mslJLhUBa5aQZuu0JffwppgN3SG9KRfpEisRNMtczFp8FaymgahbnNQM0mMmzNHIzLK1CqYgBdfDeeWFQ+uRsox533oDCftXiFnGNxBTvnTRwYqxWLRpI0NrjDobw4oAGw7ZVerO6MXbBxdExc9GPLeVQyqHlelKADOQSaE=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=F3YjafuI
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F014E4BA2E0A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=F3YjafuI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hfw3cxeZn/X+W5xiHz7y5eAh1wnoPNbZ/65pkp5mnzhGvHoeADDA2qhqDxm0+bKX20tk1wviRXn7EH2TRAAj4fzEfSpPOZzXVG8ko6kZGMSDWSbbvT7vntnTFOB4TSDfWbx8wpzxtiG2emFeazt1cgbLQbQYDVhiM3URPxAmUv4ppvqkpF75r/gkp9kndZqLO+f6CJFTgbYkuIfiUyJwWqYVteOBOIuYfguB78J5OqiORZJVUA4pV14YZaXKHfzwUzEcVZNeu4ynukSkzg1eDv+MUr/nF3/lKQmmarJhZ4FncgOwd7nOFboxk2SFiLKSosIo5toM68OlNwRmXtJOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7tiPN/2nZV5hiHvDbAP7SadYHoQGytBF1+iPnxG7Kc=;
 b=SrMsMMgyRNpQi8cRcpDjiAj/sPUanu3rU3WxPds8lemVAVVSktGP82Z+OA9JWq5H5iAnPhldiKdCU4VpnuF59dqDoamG8shzNifYBNb7X7ZfmldwuxhtIG2cw+kxLRPqUYJwPhP85bjarDTFtXc8S8JReNArbpmHOhLiTHaaXVovLwI+ixT2tpYi59rn0/5sgMyaAUC+ANWR1UWfRdaQYhNgQwuOfVhYhQxm3mDxr4pplYHu5rEv+hj+O416ftPvpHBQb2pjYDjZnSNi3uZz6rNMLFRMW6gYxiJ8g+2cmy0WOozwlGNA3b+C64b0yjxaTO2COjyiq97XPd68d8MDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7tiPN/2nZV5hiHvDbAP7SadYHoQGytBF1+iPnxG7Kc=;
 b=F3YjafuIVMX/jRSf0Pc/todzJcfVzRDPhjOLrjRPUgW8fHeyp4GZgfsRhxpBA/AsoSnwsXtYE1LBfbWbuBzWnLkH5uwimyXSdUPMJyzx7oiDNU5zbg+NOEwVA92noHbSI0PBqK6g1nMrW2wZXOgl4024UgsVMpLFOzSha7pKVQjXGeSD/zm3nZf4TtpwHNNgp4voT+VtZcjwKKtySVMumoA9V+/44LhsmsydePIdkNYGZ3U//azKVFndvwwgDlh9y6RslYt6w0xL82EbsTWv7pX1ezRdo6pOHsGilu7U2lTDoGnlES9dxSji9EThaMaJR4d84KB0YCoOZWP9FCffVw==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by MA0P287MB1195.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:06:36 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 10:06:36 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: ssp: add AArch64 build stubs
Thread-Topic: [PATCH] Cygwin: ssp: add AArch64 build stubs
Thread-Index: AQHc6P2T8638N0idlkugq8RKgk6NjbYjZoKAgAex/+4=
Date: Tue, 2 Jun 2026 10:06:36 +0000
Message-ID:
 <PN0P287MB0295E9D540A342B741B82CC592122@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
References:
 <PN0P287MB02952FCE57C59FF18096B96D920E2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <34b42100-1722-4bdc-abf9-e9d159456ee0@dronecode.org.uk>
In-Reply-To: <34b42100-1722-4bdc-abf9-e9d159456ee0@dronecode.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|MA0P287MB1195:EE_
x-ms-office365-filtering-correlation-id: 6bb8f528-5cbb-495a-3fc8-08dec08ea1ad
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|39142699007|31052699007|376014|1800799024|55112099003|8096899003|38070700021|4143699003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 n+7FuwJhScSqInjkGNwW3Hs3TAkTPv4d6TCRDwLfxhGEn00IScWvexlyBbRO1hysrNkHb3fcDkHmnfax6xOabaKKJ7MA5qRogmgbH3hbvTjPP7SU2Ag8u30/2j5NUr6o8zluWFMJ4Qis7KXj2RHlYgcNqbPwEs3Op823vkaQgZQOE3y68M41eUpnEvW+ERVtWIQoI6gkX4lsKat6v8XGGPAwCKOxXSFOX7AUdijjGv9GKX52gJQI9G/NtWtQ993jzaUqjp7ZwbeuiXnAg8IyORRHjD8E/yv+Sgo98HBaYGM/XM3Bw/mbcpct+anfTBHYC32IjgJQrbtnpZ6e3ppNiS5XO9vQp43gk5Xr9Rn/yKvP6gdbRxLe2FGdt8Hr0kczz5B1cBCjkYX7pibhlby2IS520bJ9+ypk1PO8KHFOA/qt4Nuokjb5m8UnyUzfrMMCUein/frfmPwmhqpb+fqK6DupZUCGSBoaEATMukJMgOA/FHukVVPW/aPv/knw3sx5KMP0us9g95x7h8ZAHk+fgaREhAV27KOrPaGINAP/125tpoP/nQFDL1MAin6TuiO7p8JeajCK7gIJfYIq51R8l84zUBbO6kbhQ4GrexeaImxhTQ9LPXt2UBayMbEem9au2PvOW/tp4U3FnY8BSc0eiYkI/2v69oJjtaKoHWAHsNPbj1y5iqSteEuzsTyLnZUlaDGYsqpRxYLa7OvclSuJTxP4Xy8aGa6pUz33BsoRxE9c8nc6Wwjvgac6I4TU9dbV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(39142699007)(31052699007)(376014)(1800799024)(55112099003)(8096899003)(38070700021)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jyGUhG8Jjx/8aE8nk2l9axDRbuliUooWM3gNh1ybAyp1DGHB2c+a6xjkl3?=
 =?iso-8859-1?Q?XFMi4syMAM91K085rhzFRDWoUNneGo/0r4plp2vAVQEHPiYknMpYLeHnKw?=
 =?iso-8859-1?Q?oSEqfL4Uv96ZOE57R2qRAKLEn19wh5bN6uf4sHf5dvzZgUBRhzqsoSsAAs?=
 =?iso-8859-1?Q?MGGDnDQpOPUKZn7kc78EQxqLWUh4512F7oqwIwQh0Af6Y+iQadGC1aip9Q?=
 =?iso-8859-1?Q?LJfVU05NklSbIDOjS13oiGQWCSr3blDikqbaaaEZfhLEFUp1+96MTjrF9y?=
 =?iso-8859-1?Q?U+ZVGXzLzTM6epHmXrPiGfJaRqu13KNGSE0W/IpU7XiRtOUFPAV9jJwSCF?=
 =?iso-8859-1?Q?cqxpWuz/4Lvry/yt8UYWgAdnHY8oWquIWAur/IwGGxz4CO9tkx+U2dGSso?=
 =?iso-8859-1?Q?RLFoCrxAGfIE55H0Lo4PmOJFpn+TDr2GXMTziq9buVMcQKJMsK6CkYbB1H?=
 =?iso-8859-1?Q?9wxze1kp1xHtsbFt/AyyV4j0fgzpllqnSoH9pVYewpiA/JveFrc+IK56Oz?=
 =?iso-8859-1?Q?1Kg2iATgjc9rx+yHNC8LKAWgdeeyuQH9m3gMhrMBx4hBtdEdacwXrsJx+c?=
 =?iso-8859-1?Q?XkXOx96fzj3YdejLJ8yJ1hQ1LQTiy/UKwixby9EJRJHk4W6tQH0YOR61hz?=
 =?iso-8859-1?Q?h5Qe7GC3cPI8tBKh8s2l9Mp3OgjB0VElg459OXa4fyz4kDqlWRpPkQj7Xj?=
 =?iso-8859-1?Q?KxBtR77BRoOka450TwOiSDfxh0TkSky1dWCQMbNkU8djZYiVM8gXVui2f9?=
 =?iso-8859-1?Q?MKk/HMWCIihPA+2qvV9VVm4VUMQHfs3+n1zPwkYp3Gny8fqKvCuUOpH3Wy?=
 =?iso-8859-1?Q?iSI2nPVjmekTKAEnJM2Jgd1YzG8GdkbMpoj5qTXvYc/FvtzM+58d0spGGV?=
 =?iso-8859-1?Q?eQ85sKzKtRshg8vn4NTRFAUdV1HzJpiqFyOVhS8DblvgHvAONMwVmmY1HS?=
 =?iso-8859-1?Q?xNIh9WbDpBUUh/WJeNECoOd8f7CgwHeV2QPSYdBxuzyPJMrB8URPf9gL36?=
 =?iso-8859-1?Q?GvV2oRfkzyde0pDlcJL/7HKuFzTkUpYNIbiRwuhOmhq6OZfH6O1TPubpFb?=
 =?iso-8859-1?Q?MykTAUp3v7y9sAn6jgQcEUVPFGy70uwh/+Q6rzlKFP8gxwq6384poGlwQq?=
 =?iso-8859-1?Q?onWlep6PCSRJWBqaei2LRz5cLRTy9zXNf8iLvjOUTeiarsSbQpRr2Ps1PD?=
 =?iso-8859-1?Q?7VhqP5wRQj6e+3dP5AlQtjAnjyMqjoZFGOZbeDKA1z4zefRESTIYQJ83Wq?=
 =?iso-8859-1?Q?j/sznO6EYWycrqPR90VAutkAAUKWIkRZ5kHKdYLjBWKL6Mbs6dTC3Y3o57?=
 =?iso-8859-1?Q?0bPioDZEgkh1AO0X990d3OD9YDtS7V2baHhxJWjBGdTrbAgVjq64QhhxyM?=
 =?iso-8859-1?Q?mCDDHSm9B/V8vPQRlGRbCccVmZveTHwDmtghCWFZtEQxqGDKDTos7COkMq?=
 =?iso-8859-1?Q?bLvUdvI25/ASgJ3XHFRN3pS+QyKeQ6m22X2sUjQCxfx5cjZio/CNMeopBs?=
 =?iso-8859-1?Q?bwLfhzbJrxGFbcUP6ceB19+cR+I8rAvoP0bm/TV9fAnhxxeNIDRkSN+kJz?=
 =?iso-8859-1?Q?0URep7LKR3CQwV+yGk/udAeVHgeJoc6DIsU4etpGPv7A6NFtDubHCNxyDe?=
 =?iso-8859-1?Q?taRFQ0A3mojcJmS161tph3oyMcLR12YS7OlxDyMCTbwr/vSdx9F0mc2MZZ?=
 =?iso-8859-1?Q?IrcHYOQnw3oc9bNOT8q104CXT7X3i44OeZCddHDC6rjIYWvl8YErTK35WQ?=
 =?iso-8859-1?Q?fSFEkKELqGv/A6XRb0T48nCEFmEYD8jplFH+C4Y2eBMMK/nGLZ0v+D9q91?=
 =?iso-8859-1?Q?VbDdXHI97FDJsIHirJIDwzPW8qaHls0=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB0295E9D540A342B741B82CC592122PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb8f528-5cbb-495a-3fc8-08dec08ea1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 10:06:36.3167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzQ80w9jVq7id94eHCw3zfefTZgT0yr66TiUZ+DD69cr0kc6Gx75DvN2Jt6ieM9UD6zqWu1is/r/+444v1bA29tqZk8qSbbEd3JFvqdx8yh5JSEc4Elzm8qHq00PwgrQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1195
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN0P287MB0295E9D540A342B741B82CC592122PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

> About the patch title: this says "build stubs", but there doesn't seem
>to be any stubbing here.  This is looks like the right changes to me?
>
> Should it be "ssp: Add AArch64 implementation"?

Apologies, the title is misleading. It should be "ssp: Add AArch64 implemen=
tation".
I'll resend this as v2 with the corrected subject and the review comments a=
ddressed.

Thanks & regards,
K Chandru


--_000_PN0P287MB0295E9D540A342B741B82CC592122PN0P287MB0295INDP_--
