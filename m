Return-Path: <SRS0=QmHi=IL=multicorewareinc.com=aswin.kalies@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id B17D84BA2E06
	for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2026 10:22:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B17D84BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B17D84BA2E06
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792578138; cv=pass;
	b=kgvuSKCfiyt88oOFjz8NinKDrfHWn790M2woB3S0Z2w3VCHaOf9J16ScCxuxYiJf7tiY/pgBQb4bN6RapwJjSR026LSi6nCu9WBtHP568uola++UFjEkTUdFbu9yK6hfpAswEOOwBLjKtFYrynHosIKJfUdLwGihdofDTIVHVZw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792578138; c=relaxed/simple;
	bh=7k8TPYdnQ1Tw3H+xA3qj4aKUf+iPzdc1dg/Qr1QCSdg=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Zo4Nkufr+iTN4kYRFJiV4X2UYiw1jn6J3PjYtcj/3XjwHqE1DepD0qr8iB3Qsp75eAGq0Tn7NUBxYMtpzKhic4wUOwVD8D9z3B3DnJUJYKHMcg3eA1yygky5vo8aNmdU8/6159WfSZLEl14cQPS9LUbv0bRfPItCGg3kn8wMgq0=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=pEjC1CUC
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B17D84BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=pEjC1CUC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzR5dJDfWbOCXAgDe03rPTW2sX+RJOTwtoENB4D1Xxw3unKkyx+N1N2i+AHuiRS5YnkyfjggSZjBzVkpQN88vNETeUWwhB83yfxGO26A/xSCl2mkgUwFkFru8gLELAaOuslXFSNaYxtWVwg3bqDStfq1eZpk3nKsVaZeErxcEQL+rkySrFlFLDRaR/sVT0oEH2afTn4fKmzIYIT8WTQgfPrPafxAlN4E8yl4PgEJkP8E1l3mkfvlktOWfcz8TT7En52AlbPcJXu5TXXTdoqkDZgXAUzCarjWfGr+APj0Eu2lP/is+C2h1UWr2nt93NqEDxuEMAeqSKH+bQYRcB3iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB2z7ZrIE7GAbejE2iFgI8ZbQJnSA7UMcJVDcJVUdmQ=;
 b=pMRdCkk3XZQSxrGaM73/Ez0OGZ3soUo2impPqQApKcShjaIfJBB76DjAMG7H7Zkzf0yhazLj8Wun5tWAhMjpcKktF2i8dl5rhSzcYY049pXgiZENHX+XoDjvtzqzG6FiNzB4HEc/AGP/xBJaRnAkdkKf9yc1UCgMe6GC3z57Tyzx97dLUPBJMbyO71gIbMvyPaC0l4iSkF8vx8GYUH/R9mOD5mXRGgo60oGQRQn2sjbwt+RTYOibj7AhjOflY5h+WY5P2YCHk47b7rEQj+MdDQiNVzvIvW/925rZI840MDcLpiQop8HGs/liX4ez5IzxTk4SIEnXjczB1GplZktqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB2z7ZrIE7GAbejE2iFgI8ZbQJnSA7UMcJVDcJVUdmQ=;
 b=pEjC1CUCdQLg0RK+5IIByOMqEiDPLTISnQIgeNh+APtt6K/mRPlQS7i07Flopk2Nz5LOwWsGhJAL1/pkZcQHy7JJIsL7v+M/W/o13KCFJsKBTKOGyoZyrPXF9NchxgJUVuTDg0L1sZpT7bN5UZ69PBC0ltiqtWZU3Nmgacc+YwxwoxK5EsHGXcKUIseWhxy/5LBM5Z61gnmrQ5VRwW/7ds6hQXEBDL8NxuPn/17xzZKdl1Y+X4JRMQImQWF5Z47WXBbmbKvXiE2CUgK1ANEpiALGjJmG+2fKqqOhvB8Oq1ji03rE6pSdFnpYS9DTXOW28WX32zJlLIvE9kNucHnWUw==
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:193::14)
 by PN2P287MB0755.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 10:22:12 +0000
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b]) by PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:22:12 +0000
From: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: autoload: drop the unused no_resolve_on_fork
 parameter
Thread-Topic: [PATCH] Cygwin: autoload: drop the unused no_resolve_on_fork
 parameter
Thread-Index: AQHdLust/7rWN5NIIkiSa2YonW37abcILMlM
Date: Wed, 21 Oct 2026 10:22:12 +0000
Message-ID:
 <PN3P287MB1320B28B0848F2F91E752442F7662@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
References:
 <PN3P287MB13209A14DE960126F3311558F7A62@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3P287MB13209A14DE960126F3311558F7A62@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1320:EE_|PN2P287MB0755:EE_
x-ms-office365-filtering-correlation-id: 2ea9c829-cd86-434b-ec7f-08df2f5d2bd6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|39142699007|31052699007|366016|38070700021|56012099006|261009223027099003|22082099003|10067099003|18002099003|55112099003|8096899003;
x-microsoft-antispam-message-info:
 f70WIM1FLN6Fu97kZJzKzYKIV1wWF7yzNEdvHYGl92DWUUSEFA7/lI4RCCB9+wvOokETaaZyetKtNoY6rrLGvoe4XllpAK0NO7I/JSjss66j18/r+Co9ssPhvC6vfoUPuSSv/1Tg+7nMkIuLGBbWJeDKKCG8d1UWG8upz4ywPSrWW4igN4ZNbhghttkJR2inK95Te1Q7JYTIdv0h7AOQdVElFW9/bLRxoCx+NzidEl3tMlwGcWGQRfddiCnMh6oszL+3xrN3EgBOYavCIG33JX1ptYKb1YIk2Hr1ahtyVXllrMb/IPIVPy081Si5ysZi80RqJF8C4+2WoEmVwQJYWDH9YtvitiRwvozJRPAO9iDNGa7rbMRW0JaMfJilEj/neMO1BWFKy8GwAr/zNwV0zSvjoNMvWCkqkyUgVk538aA4rvOaF9kpx1W0uOFO1v8e7cbvfjbqLeLH+7mWUj6VMfPok94nPP8OYbyOShUfWHaqpxfZMYHPRaSTyVoifaP9dyXgHnLrsVrBFq6BcWryg9NqMuhLrj6aRWKpK2IsOISwz/p6mEh600g3t+Uvj3fpNBVpbKiNiWXGePFOPYRGxkLQNWxSUYLBuYSogKUoJKr/5UAeJ4hmUlPDKTr7ARDjf2S+LjUiq5vbx00XVGkve4ewGmzwHuhZ01MjecUZJAuN8G+IhIeHVcpZBSG0OiFerFS2NIcNipd0p/xMFk8Oig==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1320.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(39142699007)(31052699007)(366016)(38070700021)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003)(55112099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tHLBlOLQ8RcfoULZlVx4Bv8+l9wckm1tKsyqeMdqRaV95ECtHN/NPcSvbf?=
 =?iso-8859-1?Q?MwnGhQAgVxeIL+pkqT0tGtN0bgQ2+7vWo+DV7T1w+RziV46Y3Vtr16GrAk?=
 =?iso-8859-1?Q?zwtukuRx/ZkuZPxCo6XbmbGN6ZVaBXJ0iFesnd/KpMAu7qwZaGdV1Bj4pC?=
 =?iso-8859-1?Q?ctDtG11HU2UARDuKcSFDdbZhFWpeNPyLautWoh3d+U7VPM1IuxRSdyMFWi?=
 =?iso-8859-1?Q?5mjHOQDyifW84DNs2/RhgSQNdZJgPa0I0swQrp/sFA9hRfGnOuGa/EjvSb?=
 =?iso-8859-1?Q?F/ZzLtpBwgR3gjYYIZgHDHmlWoXjX6S2e993HQNYboqcaq9SSps0iOuJQC?=
 =?iso-8859-1?Q?nv8ipmdQZi9m8LeKr0zxsBMc5/tYeileRCgpytu+hs0LQBnvs2VrS/OndN?=
 =?iso-8859-1?Q?ubhfgxwsmy0g3SmveEJ4sPmGZUxHPAystMSKX7OA7pvwqYInVdQtsDmVdd?=
 =?iso-8859-1?Q?WrLfoseDrZ4sqxjiM+KXqu7gBPk1vRMBxheUOxMEOzvYuFvdlArKoxp3Hj?=
 =?iso-8859-1?Q?8uPtkCS7YejfUWBOAWsMq7+FjTo7K92bLBYTK9OtMtZSjT+flVty0nxYro?=
 =?iso-8859-1?Q?SQz+EFLaKvzhnhC3xZFeBMuw9SQBTP9MmD9h8i8qqALuOA8Nn3ihcFWPZe?=
 =?iso-8859-1?Q?lovMjXc/jxBdDZ/TcFUm11MXkswfCU+4QZi+bNVTVSUv2hZSKEr0wwNMKw?=
 =?iso-8859-1?Q?E1DSDvEu9Ce7eJMrcW0p+oZ88hXKcezjAfhurcPlgWnQR0i0c/1GSyJJFF?=
 =?iso-8859-1?Q?KOeW5LjKiOx5/Qj7iEGp4Z3K8df6haUYsTi0s+yo7xYHbiH5sQMNf/Ubso?=
 =?iso-8859-1?Q?9q/+7d+uIwdLtLMsABaPYGuOSCry7SoBux1E6m7Riw1v+dqQXVrz36zKI2?=
 =?iso-8859-1?Q?elextXQDhWfKylfhfUR9EQ6lbSFxUOHLXZSxcDciklcCGggdykI1Kch0Ex?=
 =?iso-8859-1?Q?19LY5w2mfqik6hvgqGTYpPzJ7gUhYaOUdDtRMbxkCn5URqoK0g3GQSyiUa?=
 =?iso-8859-1?Q?BUXnXtWVxTkzBCI1x44dawsyBtr7gG6nFTdxfIaEdDoQzsRfnwVZsmtGgf?=
 =?iso-8859-1?Q?FcYynznurerbnTUFkVZ91Lh1NJJWzVCfPIoGZwkngKrmUVkdbVe6vC1cDA?=
 =?iso-8859-1?Q?thY+Hs6XMYtxpQ8yPldQLdcmpsH7OcIQuGHNBzWDHmCO+RZIk/Delff8oM?=
 =?iso-8859-1?Q?fkvPM8Gfp4Wt5aX+2OiMDXYQYVL7nnGaed2srUgsRJ6YfRS0DQPUlc4XHJ?=
 =?iso-8859-1?Q?MtS+uokZ5ZPvciiJIpJjqkTD+MSgfIlsUE5FwlO24IGSEjV5E0e00T80UV?=
 =?iso-8859-1?Q?Hzu9AT/piPO9uGMx0g4A/SA2FJM0/JOag80BCU5clCGNIXqV/Y+TPrBxav?=
 =?iso-8859-1?Q?wAbrD7ps+/vxuxb8l+jDN8ELnSU/6RvscAJdvZPc+72o/v9uSfMA43pxEs?=
 =?iso-8859-1?Q?vFY2DyssElp7kJ4wZaiaQunVO8V1Ud4kZwGRc8iJsLeapDFwyESNmssEC2?=
 =?iso-8859-1?Q?ct3nPqMmo7Rovx0bRW1c+/Pz03w+iKHdiA+l6wcyhkk49EEnHdhAa6vVny?=
 =?iso-8859-1?Q?BQ9C+3/5jDumvqhlbTPt+aANmdZ//1nOiWLhX/bgBT9HTXiCOIlcL81pzy?=
 =?iso-8859-1?Q?q14Kqo7nzR5B0azY1jShrdU05+ugn7bCxibaaZulKKki79R2q5oyvhmxKp?=
 =?iso-8859-1?Q?Mz9IjGxLFvrDFvZN6Bo+L3p9dnoITEmNlm+ES/F4aHGCuFGJCqLxx1Za7s?=
 =?iso-8859-1?Q?YR1qzJWh0LoeTm50Ixy/TkYBuY2pH1AJe5p8DFcDsjzwbQ9PeqS/4uf7h/?=
 =?iso-8859-1?Q?9h9paQcSwMYMhFDt12O+HGu9YOLVTK0=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB1320B28B0848F2F91E752442F7662PN3P287MB1320INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea9c829-cd86-434b-ec7f-08df2f5d2bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 10:22:12.3325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGlxUjT/bQvDUOk1C4tiyesbNW6z2Azg1dkazK2joS9Kh0ZKIGSLlN2IzJZCryA9TJ/t6fYCsEE4E1d+iOVHgf0o+6suG9kzQp+tHCWe1dv8mG7ZhKuFoxPIXKuaTqqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0755
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_MSAUTHSOURCE_INDIA,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN3P287MB1320B28B0848F2F91E752442F7662PN3P287MB1320INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Gentle ping on this one.

One note: Outlook mangled the inline copy in the mail body, so it does not
apply as quoted.  The attached cygwin-autoload-drop-no_resolve_on_fork.patch
is intact and still applies cleanly to current main.

Thanks,
Aswin

--_000_PN3P287MB1320B28B0848F2F91E752442F7662PN3P287MB1320INDP_--
