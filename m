Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20719.outbound.protection.outlook.com [IPv6:2a01:111:f403:260e::719])
	by sourceware.org (Postfix) with ESMTPS id CC916385701A
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 13:30:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CC916385701A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CC916385701A
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260e::719
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752154209; cv=pass;
	b=wT+zu2g6AOnufYX7gwSSdRKtF4mn7F9hIp6pO1PUmpt+jhkgYGMzTTSM+0ruxXpMBaOWorRQhDZZWVtEx/bnUe0UpFRGK0NaBLbUE3K2Y6pr9yDcC7tehe2Kw3/KBvq+haMLvBm/1Rrm0wcKTwezEw8bhSpmE73XM8YRlj1x4qU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752154209; c=relaxed/simple;
	bh=i4KIVmIzB4wK0YK7Ult6kPgqpHozReNctfbwsGhrznU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=sAUyAczvRU3B0iXZYdDR/27MHT4FNB2qPSyEEUbR9pHLSbv/S+fALe9lSKNyCBUIFlKgl4D4bPN3g8nwU95t+v8MnKHBmRX3amAh5MqNnVkoMTM9xODYMDDbdWWakO4GZwyb/vA5TvnvBkLNOXlaCZvRFX7jgWs+Upg6uqxNJ2o=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CC916385701A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=KKoqNNTb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7xRUaT5SX+RbSof9nGtjNQvUGahHCBjZ5OfoWRwaFiuClCtzT6mUtaBvU8o7yLz22O7ql/WEN1eQMRGG9C1CfFK3GPTJCW9Odlu20KI1ewEj3gHBoch+Bi5LjUhlNLHmQL2uzcaaeJs3Zp8o+Au/Oa2hWgfnAlWdNtFBAxmG1sqUsTZqCyr5Yjn454MrKl/89ZTwbx+vYxUG/XE/u7f1jZgmKLC21xDvV4tmhiLT9rssdzlkwcEGIe2Alzpq3qNjz37dH6busNyXKitUYJMRwvkZzFALChYVxyEDXDRQGbQJMlLVOAJT4jIOvnLBJSBna3smNt6ZxzdlpDlI/OScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSf3x9+3EdMAv0Zp7F/aj7JgOj5JVG4ooJnBBPxtAFE=;
 b=AaVQoYAsJWDnD9lAk1L20c57hL0NjOIcDRWsHJGgFlx9xjSOG/uT8gVf8TQaxxewPROHl6phsTYZCITmCKRNG6VMiFueyoQp3CFHp3a//dW4GYUmU8vrDsSIug1udPhYvDRIcAhIm41o6Ayqn1sFLoScAxBgIHpmjQ0nCluSRqkFXKTTtnStEERcAUsnnkg8D2jpBTtUYNpA/dby0Dpr4yYMXeVDGv6neCnw7oa3wzzde6p7vLXfEGxL9GUAxzvlIe09uf53jccBJupJ8bgzgux5Yrx0PksvJm9hMRGDvxW6BDPVkmjDDfuSPsPQs4X8UjWczHYxQoKRSHwUM8sVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSf3x9+3EdMAv0Zp7F/aj7JgOj5JVG4ooJnBBPxtAFE=;
 b=KKoqNNTbR/k/z5KgdmQ8FStkmSDnzXVF7tUWwSPZlSze/g8NmAYl84JPKWQr9K5egTw4uQRh35SUcpZgF5vX7wglLDNdqPWqZ+TOyNa48mRpL2FCulWTlSCM6AZXRZ9KZZs0OwL45L/akMdnzht9lI1S4EMpSMU4d6WOQDcnw9g=
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com (2603:10a6:150:27e::22)
 by GV1PR83MB0732.EURPRD83.prod.outlook.com (2603:10a6:150:203::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.4; Thu, 10 Jul
 2025 13:30:05 +0000
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a]) by GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a%4]) with mapi id 15.20.8922.011; Thu, 10 Jul 2025
 13:30:05 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: add dummy declaration of _fe_nomask_env
Thread-Topic: [PATCH] Cygwin: add dummy declaration of _fe_nomask_env
Thread-Index: AQHb8ZtU+XNtUTQ0R0a7bNNYq/rXJ7QrWgWd
Date: Thu, 10 Jul 2025 13:30:04 +0000
Message-ID:
 <GV4PR83MB094163676BEC4904FE8345889248A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
References:
 <GV4PR83MB0941FE057826A88BE430A9409248A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
In-Reply-To:
 <GV4PR83MB0941FE057826A88BE430A9409248A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T13:30:02.206Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV4PR83MB0941:EE_|GV1PR83MB0732:EE_
x-ms-office365-filtering-correlation-id: d56f0725-4972-43fb-5815-08ddbfb5e150
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?R+RDZ8Ffx5/oXFt3G5wlJTttGJC6in2/bIdKiGAP6YhYyjO5yS7NFecfQd?=
 =?iso-8859-1?Q?HVzCWFsq94MLt5oGXn7aUwZTeTicGPXJrmHml3TpJp2Rdf8tn/YUvO7MU2?=
 =?iso-8859-1?Q?f78HMVNzTe4KLR9/OJmDhkM5x9ra9PB1W3QHPkP1xyqvGHw+i0wx3iIDyj?=
 =?iso-8859-1?Q?oH2JIIxJkQCuUkg47TamqswPgCCm/bw/NXp4f8O1IGFruddJvB0ceCmUvw?=
 =?iso-8859-1?Q?xIvmwdxbV55y4/EVKZjnKkOidaAv+tUvAa+nvZ8YrVLJ4LrsmZ30baDYkT?=
 =?iso-8859-1?Q?0OYlO7jfa83wR2okxFodqyTbqFLRS6Ipdt+nErXd5A10dUH5H3E2PFp2Ft?=
 =?iso-8859-1?Q?4o+G/YEVvgKZfF22CnnmSS+RtO1EUNOMVWCOmPN3/uta+J6yDoJAJj3g9T?=
 =?iso-8859-1?Q?mybF7o7EvOTIj/qQPaIs03RH5cXj0kRsSOr8ZcnaE/8QiVF1AqcTIVIIFJ?=
 =?iso-8859-1?Q?UECpQqxeCss3fIHUdkK5Pkhtq2T2BA/qyIjlTrsZV7iDuV/YAeAeFWy5xv?=
 =?iso-8859-1?Q?HS1yB6vH1g2m9oBi3gw783Y6H/NdvmRmRU+qssR9v3CMKDtQrHrNGTEXN5?=
 =?iso-8859-1?Q?HvvCibeASzueoT3zFPGUCPyu83wD4yOJeI6Vs5AAUfoVtvRgrLlcuFtc9G?=
 =?iso-8859-1?Q?xkAo6vP3Rik5bB5dLQj6a6XRaWmWK8Rav84X/nsRcAz/m56ZcDpIOepPDR?=
 =?iso-8859-1?Q?HvMSx2/i13nTycMWb63FdntFLjbM4p6znFuJWZl8IaEJIjOKSVR3hUBQN6?=
 =?iso-8859-1?Q?ow6aRlucrYiDa4BeTwajrl1eByxo7QXXtiwLRlFl/5qRiQZuSiUi1UTO08?=
 =?iso-8859-1?Q?IN9EVBf5yYyhy7UKZAoZLqdJdy6oyKTbyV+1obVgru3GYDaRIoXQlE5nT5?=
 =?iso-8859-1?Q?RBU6EBfphwkWmnjxRIM3mvf2reCay6sK+OJSGM7l9wfblq/rlDPzllCOXT?=
 =?iso-8859-1?Q?PLd4850yzCG8Ir/GskvGsnRDfWOwxflS131wqPdfezpaH9Pxuj7KYQEzuQ?=
 =?iso-8859-1?Q?ta193IcJ5ovrCo7sjIDMuybNzSQpTRyJjfwoFNq0Qi3ayWA29WInxc+NG0?=
 =?iso-8859-1?Q?iZz7WvakdQz6LtbvC/bXnhOQ+VRm0uUUgHraUbo0Ijuf6fjF/9hYzCPMlt?=
 =?iso-8859-1?Q?ZwDa1LwyVMu37U5tU4VTxWmOBxke9xQRaiK/b6BjS70ugqP+IktChREDsX?=
 =?iso-8859-1?Q?PQ+xd9Z3lt+GFXTik7t/szt+D+IHPDx8zWCabyXY57+xojIRdpClISQDja?=
 =?iso-8859-1?Q?H/o3z50XZ6g7ACRhEHBVGl6sjZLTSpQm4XIsgzCFRpf4FuG1jb3eVZvK1n?=
 =?iso-8859-1?Q?LeroD6GiWLjWTURISCf5bfIzKYk8Ym0YEANXdvwGCL7LVNnGOXXCmTkE4U?=
 =?iso-8859-1?Q?B5LST7gOM6WUVM6E/nQMLklk58hVWizEgPZvLKcsKrOE+1FObcZb9eJmXq?=
 =?iso-8859-1?Q?pmUcy2rEDja+tVjXE+OtyQPfFlhFK49d0d81IDDQgL96pKT4Rrhfa+JFBY?=
 =?iso-8859-1?Q?g9Avoax4u1SZZYHB3nG8NgKNy3oFyL3JzlnkSaapQ71A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV4PR83MB0941.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?A9uRUTzmzgG0YDHFBmQRukMk+6ZCgWl4ZVdQL8By/aIvS0Gc4WG6R1Fuep?=
 =?iso-8859-1?Q?mLhVfevS20BATpbo5+ENmiztZP5ET6ozSXi6q1puIMRj5WN8RpHg6iLV2s?=
 =?iso-8859-1?Q?WjxwEVt9kiTs6X0T3fwZnCNZVHplZ2N+zxhBQb1UHr/fuXnHmBm1sVaK+2?=
 =?iso-8859-1?Q?F86WcuyvuByVeeJj81FvRobIiNJv53urOwOkY6QT+yvsMKXevae7a6oLuS?=
 =?iso-8859-1?Q?M6Rpj3NCMWEifR4qBkApCzPt2Rl7XU8wjJFF2ux60i6TeqNiPBUobcTv3D?=
 =?iso-8859-1?Q?k4EMpXVvrejNxpLgOVUpZSAwgbTFE83kUlQwYRlMraD47b2H/+YNfTdL4H?=
 =?iso-8859-1?Q?bj7+3/toOo55745ehjp/BIgfNvDdYwe+EMzu8RzB1kbVGMZR8DVI/lQYfz?=
 =?iso-8859-1?Q?qAoZhQaH+ltJiNtsuNh7Ugp91YFJTgdkUBtuceEIOByqtRqiXzd5yfmVDN?=
 =?iso-8859-1?Q?k8Zqnnmr0S+we+imKvNPiyuM5HLGThCXpK3W9IR4lOgIxHZDu5KQ5JAbXG?=
 =?iso-8859-1?Q?ye+4mHRQmhvgrNmC+m/gJ8hYj13EdQUjmvh/g5Usk2IfgHxdCjtNdH9R7F?=
 =?iso-8859-1?Q?3oECknvLen8A5i8Cw2P8x76NZ9sJ4x6LgK9VZuqTj4A5a2Yn3GmLWt8ISF?=
 =?iso-8859-1?Q?BDgTNrNYqcnA5u/JPTPwExZ4gJ5a2R1JWcchmGEbEghP3AXpNRCOBPLxUs?=
 =?iso-8859-1?Q?ryiiLe1ef/o0oAGzrAW8YM4kBxWOv9uO4H5Qz+ZAKTqszhC9ySbn2wujWZ?=
 =?iso-8859-1?Q?EF5ufO2VHoEdzcWvV7yo3JKfDVDishywDDfULANj25Y0iPlboTP35F3imc?=
 =?iso-8859-1?Q?+Xvn9waAxg8TeNlsMe6pNtLKD0Sfh2Ci65xypqiZFnVZ8jY5AGclRThtxx?=
 =?iso-8859-1?Q?uVMsmFHGmNCR0QCVPCq9CBKTS83ZdzrpWVPVQntSMqvd85p3rWsLXhlPxU?=
 =?iso-8859-1?Q?70SviXStazXTof+rTqCyg5P3rQBdyPtZKN8GXYgR0SkZqgvo3X9MTx4koF?=
 =?iso-8859-1?Q?+Nnnz927pzub/K1rlr3PfFx3Ysb8iBmxJrK7yHYuqSN+x+9pBhqobl1gfH?=
 =?iso-8859-1?Q?8IdqaeF7v/nsJojaWucZ80lm0biA8Zub0Yx3+hdaBjejw/vFsjo55qLAs/?=
 =?iso-8859-1?Q?H4jy3eLmCKNzMZFlTQwszOuEQO/P9wzZXY2G4ZfcmgLciFZGuE5JoYdPTm?=
 =?iso-8859-1?Q?DL/M+ACvdIoPcamfG6QaA9momP7oN72SJx3AdEa5jrXQjiFI/WGXEcVf21?=
 =?iso-8859-1?Q?k95A7ft8XxKg0rQ/oU0ocsrGQqM5ZD3XSICe1/x5jypfoRNLw2XKS1elYf?=
 =?iso-8859-1?Q?YB2zxXH10uuwScukNUr9UgCZI7wNR+bxQ9cH7mik81KE1DjDudWa5ksrqU?=
 =?iso-8859-1?Q?YquPXUpXpjd++FmfQPKtMIJnM5SI+bIf55O5k3JyICeumX0VclofF2LOtf?=
 =?iso-8859-1?Q?tBztb1Di1zaQVbYdtD8Rj6BvSZlb9tRGyPVg+LeK6SuQSngFdglXzBomei?=
 =?iso-8859-1?Q?eUfhE/Nw0RmgAvDFuWtvAxYqgDRAQGqq0B1umhIodZPLBqLxd0AJnKEdaf?=
 =?iso-8859-1?Q?By/VGySMJGT7J/IvlIaj62juiRSr?=
Content-Type: multipart/mixed;
	boundary="_002_GV4PR83MB094163676BEC4904FE8345889248AGV4PR83MB0941EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV4PR83MB0941.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56f0725-4972-43fb-5815-08ddbfb5e150
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 13:30:04.6232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ZVil2hOEV5HxD2veiF0XsoGdvqb8k5fNFu1HcxWpEpbzAiE/IHvl0fvowZ/ndqOZnxF/uQKR3ojpiCDD77VTzWgEjmfBsMCq1+uTD/JKsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0732
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_GV4PR83MB094163676BEC4904FE8345889248AGV4PR83MB0941EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Forgot attachment, sorry.=0A=

--_002_GV4PR83MB094163676BEC4904FE8345889248AGV4PR83MB0941EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-add-dummy-implementation-of-_fe_nomask_env.patch"
Content-Description:
 0001-Cygwin-add-dummy-implementation-of-_fe_nomask_env.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-add-dummy-implementation-of-_fe_nomask_env.patch";
	size=1027; creation-date="Thu, 10 Jul 2025 13:29:59 GMT";
	modification-date="Thu, 10 Jul 2025 13:29:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5NTgwM2RmZjJiYTUzMWRiMTIzNDJjNjFmMjM4ZDdkMmVlMGM3ZDgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCAzIEp1bCAyMDI1IDEyOjAwOjUyICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBhZGQgZHVtbXkgaW1wbGVtZW50YXRpb24gb2Yg
X2ZlX25vbWFza19lbnYKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWlu
OyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKCl9mZV9ub21h
c2tfZW52IGlzIGV4cG9ydGVkIGJ5IGN5Z3dpbi5kaW4gYnV0IG5vdCB1c2VkIGF0IGFsbCBmb3Ig
QUFyY2g2NC4KClNpZ25lZC1vZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNy
b3NvZnQuY29tPgotLS0KIHdpbnN1cC9jeWd3aW4vZmVudi5jIHwgMTAgKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2lu
L2ZlbnYuYyBiL3dpbnN1cC9jeWd3aW4vZmVudi5jCmluZGV4IDgwZjdjYzUyYy4uMTU1OGY3NmMy
IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ZlbnYuYworKysgYi93aW5zdXAvY3lnd2luL2Zl
bnYuYwpAQCAtMywzICszLDEzIEBACiAgICBiZWluZyBjYWxsZWQgZnJvbSBtYWluQ1JUU3RhcnR1
cCBpbiBjcnQwLm8uICovCiB2b2lkIF9mZWluaXRpYWxpc2UgKHZvaWQpCiB7fQorCisjaWYgZGVm
aW5lZChfX2FhcmNoNjRfXykKKworI2luY2x1ZGUgPGZlbnYuaD4KKyNpbmNsdWRlIDxzdGRkZWYu
aD4KKworLyogX2ZlX25vbWFza19lbnYgaXMgZXhwb3J0ZWQgYnkgY3lnd2luLmRpbiBidXQgbm90
IHVzZWQgYXQgYWxsIGZvciBBQXJjaDY0LiAqLworY29uc3QgZmVudl90ICpfZmVfbm9tYXNrX2Vu
diA9IE5VTEw7CisKKyNlbmRpZiAvKiBfX2FhcmNoNjRfXyAqLwotLSAKMi41MC4xLnZmcy4wLjAK
Cg==

--_002_GV4PR83MB094163676BEC4904FE8345889248AGV4PR83MB0941EURP_--
