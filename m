Return-Path: <SRS0=sm4o=YY=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072d.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::72d])
	by sourceware.org (Postfix) with ESMTPS id 7A7C13858D38
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 18:38:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7A7C13858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7A7C13858D38
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::72d
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1749494303; cv=pass;
	b=UvUGVCX3ftYX8CAG3QGG4z8j3q7YE4bBuEFnaGiqS+TMkGqyggliacB3USYoHh20cQ4JgESWnkNikGf32gFQFfLP9Rek4TFhLbcQ2vuoBnBuHh5moIh7NRcYTsVhXy2IfTUgc6ENUwCbmks1frrpwF5A+6mUHfhWS0pVYU30vcs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749494303; c=relaxed/simple;
	bh=S5g2P+vvxILknGSX+CXCaKeSi7qrV93eFvD3tPtG+IQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=jQtpUBG/TO9cKzaTkeMHTL652cKYAiFoCFWOPMUtc+aWKLecjNDR0AuYIoom6RJPj6RkcIAg2pyjOndS0bvFpUpWwtX4h1af9Z7L04v+qwqlXzfB/AENOX813OROdioR9uyk1QHWyTsmWU+wj8wvvsDHdnsqAD67hyzmkQqWqIQ=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyK3kC+bt1Tz5qVK20lc4RCbvuf6XMdpoBIsp7GmaKPHpsW9n1PDaL1qI275vJUHU+7A+3Hf4QTkbq0XYbiwmOgcjnUrQp6g84hfN1P73bYwey4uePSwEug4j4K4OT2+Fn5SW7qg2WIIIXpuPEckkwtEbCKBlwR5tCuk9GDrL/PBiovjo3xCyZwAuOX0ON9dn4oymmMgezBK4aKLx2qI57gmLp4PUBiXI9UXFvWU6zu3DBU3gpqE7Ko9TyrCtyA2N1UAX4XZMunAgPNuW0UsOawuSAv5Rd5N+Cig04bHRiqTH8H3Jv/XXT8oQ2YyImMPDmdxTlb8FdB3ha4QhcWxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7uNYgTd4VzUjrKS8owTmjATm7Nfowj9ayBB9Nd92g4=;
 b=zBg5VqS26JEOx/fvG5uEr0XAXXj8m1gVtGLytEfRKpPxUvoMt6ULG4ufBsObkLcoISqgGfS7GfFAcOJP5iWbedPYPSvoo99efJChI2hq9O/q3DiVd7aECJWnUdsAPX3ODiz6T/ebxzFxyoVduk8PryhqV+9fz5EaqJtT59OvnZYo974Rg6M3U/NzstCJWuztIz1/CMl72LIph1THIQhVA0uGpe2mEKG4I4qB0daBaroElWby3aBtjtZX/Xd0gkYo805G8p9OqcpSGvw0RLWjyIujO5cRF9IjvMonphg2yrxKFbHF/Ep8om8fRQ2BC2bmYunrcw6cZwbQrCg+1KKB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7uNYgTd4VzUjrKS8owTmjATm7Nfowj9ayBB9Nd92g4=;
 b=F6rzZJr5beXzkg249dkTSVylHpFxn5PqdQEWPAcb0EXmCO2Oz8hFQDyJuxwSw6inQ7nAIl96ftnw5zJ3l07VcNQdzk5KWF7dQRmTJKVYU4PFb8cYwkL3Q7T+3HCgttrJToNv4vZtDahHQhi9BCWnMteqea+NMu/88xdEPUJzjqk=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0674.EURPRD83.prod.outlook.com (2603:10a6:150:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.6; Mon, 9 Jun
 2025 18:37:48 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8835.018; Mon, 9 Jun 2025
 18:37:48 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Fix compatibility with MinGW v13 headers
Thread-Topic: [PATCH] Fix compatibility with MinGW v13 headers
Thread-Index: AQHb2WzxOLg2iAucI06lRder20X6qQ==
Date: Mon, 9 Jun 2025 18:37:48 +0000
Message-ID:
 <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-09T18:37:46.145Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0674:EE_
x-ms-office365-filtering-correlation-id: 8663e737-ece2-44ca-6771-08dda784bba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?tzKxMuZM2RdZRKRXHmyBYQn7pBmXpvCkUnPxkEQ+kaFUsAxB8hqMaQRHJ6?=
 =?iso-8859-1?Q?hxEoNcjKc825E6jxeNuqUmQyVmOOJpW9SsYTHMKZtLT40KvpvXG6tnFzU9?=
 =?iso-8859-1?Q?pl2ydJpyvk6YMTwMvsR8DOq/11DsA3quPDMiCPO5+iAN3g3znMpGf4EsY8?=
 =?iso-8859-1?Q?peqPhopaCjgmCmQUeXeu/BEiwt3nk4NzxQGdlUcY/kNRIn8FE7xTYhPjf1?=
 =?iso-8859-1?Q?7yqeBYYHb9G+azn5z+j+VCg8oxTxEqAtghlCk0tscjxeGDtNUh/rJ7EAx6?=
 =?iso-8859-1?Q?Z+KgRirQXmYUxwYIt5j5o6FVVnB2Lzalqe/zUpxldn7u0Qwk2dsWK5MSqv?=
 =?iso-8859-1?Q?La/WlBccFzikPEcNqGqGfhKWQet4kheZsvPGYmatK54Pfg+BPZ4liIOYpQ?=
 =?iso-8859-1?Q?OzNDNNeiXKBZp2oxEeuyqmn37A6cfblkN1TFWW+5R7oqDS+ohtNgaB9Q9N?=
 =?iso-8859-1?Q?J0o6WFOxYcCTLJNExB76R9G0ZqLFw8BOOpNDpUR3M+AvOYln3NmnC2YC+j?=
 =?iso-8859-1?Q?vo6rRln9EbHj9Rm/GPm498YuQDMsjDgX8uS+DsK10qKoRU+QrYsTLVPS+/?=
 =?iso-8859-1?Q?4gcBeYz2g7Mhd3L63C+vbmVZidf+xrEQjDrKLY7wpUaOzUVKPEa7hGA9t7?=
 =?iso-8859-1?Q?VlVV1q/w6RIrnGa6pkHGGUSJig3YxZlpMEwR20v0McN3/2ZwTC+vzpHtBD?=
 =?iso-8859-1?Q?fAV5Rt9t/sgYPSWnFJXNSJeD6ESoRUtTUhyS7b7VZuyEX6SIBmwkr6xYVK?=
 =?iso-8859-1?Q?oqvz1hAIk4YJQCEdQ/zYF02eLhDDwgMvcvEZHdg5yMQ1sgHLRa6VZeI2+P?=
 =?iso-8859-1?Q?mIvluFW1eWahqvYsgGzB9OeaXzJGtbyCuGpdZ6nRgU+Kq4coy67PBAIuxT?=
 =?iso-8859-1?Q?u9GWj8Uvy0p8wmjBa2LTL7p7E75lZ7MgWme93RGUsQGEBVsTwFnSq6l1Qr?=
 =?iso-8859-1?Q?SCQD5LTsky783mMWgCU4eU/O2SMUJHWEtU19JICsoAYmoF9JLb6+3luJl7?=
 =?iso-8859-1?Q?a+ycruURSCsJYKQhzKsl2Y5LD/UuTVgSLfZMyEDL7rdLrgI87UFMHNDA09?=
 =?iso-8859-1?Q?nqAq5fSvMZcaQSBYYw7ed8YKgS3uMq8elXe80P0kfLZNgspuWE/AKb3BZK?=
 =?iso-8859-1?Q?NOU38bhvssu7/2cIBJmaMyZJx2rdZGhIOyv3sO0RLvuGKEm/o0a7mpG9C9?=
 =?iso-8859-1?Q?mtHkUEmvDlU/l0WYrOnusG6x2dfBAeDvmSrkkL2DhsOdUYH8lSOJ/HwWU3?=
 =?iso-8859-1?Q?zNQU3wIQtm6BKVUibMfSoE/jgJEFjRjUA/SjQVLmCVfx3NTlSMFguuLTeq?=
 =?iso-8859-1?Q?UdC3IALR5cx1tbY3iaxjQB0ONbNBzuH60/MKKPg2XD7/iNlEITcIQJET4A?=
 =?iso-8859-1?Q?b3YzyPxOC1S+Sf5s5rplWSslTzUXctM+pezcrEzb/5wxC3T7tpVGMVW0qq?=
 =?iso-8859-1?Q?/g0jD7HFRyS9gZmf5BmrgO3wPRDxbXJslV0gAVl7ekaMEp6aTpJaTMhOXT?=
 =?iso-8859-1?Q?KfRvHcPuuReLUJgij3nqzol1W/U1epZbMd8Htk+9KHik3eZmHMVsUb5bVA?=
 =?iso-8859-1?Q?gyRdL1Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CS/+qejMdFik485ydPqU87W2pAWTX4gYJ5VorWHXS7Oemae/wGhQlDepAB?=
 =?iso-8859-1?Q?+i/p3HEn1dmH8DMYeOdHWOT6Ntdq68tI/6Ycl9Cb1VsTZE8QAlQHf3Lofw?=
 =?iso-8859-1?Q?TyCVWOuWr5c66fcii795TkqfNPa/bGyIEcMeG9BH/nxmIq6AQpeaj7/ou+?=
 =?iso-8859-1?Q?GwOvWg9jUQ1NXjaruvrT0QmIXspZc+JhRa0fRshKFoaBaA55gXHz3graWH?=
 =?iso-8859-1?Q?rYHVPBi3avvHtMhhzN9zRJGP5wvC/wBm7n0qLBN8JQnILclR2H3BKWaSOM?=
 =?iso-8859-1?Q?fB0ETzTwxZtPjTr4sUf1nmWlCch5xDIxlAZuoEDzT0ysMdYODtJnhPdNHh?=
 =?iso-8859-1?Q?y2qXok2efF2iwptITATYxR7W6mfb7l8dEm6g2fR82eaMRxs15/E66nDL7Q?=
 =?iso-8859-1?Q?7t6QxssW0X0wCr7mSmCNRL01uFZ3pVOy8G0oj3kSxjxyjcQmsWMIieIIhe?=
 =?iso-8859-1?Q?p+vxi/LAXzcHw8vgiokalrsO1VNedhhPYazQydnDGFdwrBy9TLG3jtcdXb?=
 =?iso-8859-1?Q?K08sq3UyzO47SA2NSOENCLhiNUvNJHTZEjJjMHHpo2C0fXl+aNqmDU+1gj?=
 =?iso-8859-1?Q?7DVrDloRLcjE9kpe6FxZaelOflcptuSaxHC95pPzFncfGqbkLKJJSmHpkX?=
 =?iso-8859-1?Q?bJ2gi4J8A81/d9/PtmbbEujOfUiCOKKefoc4StnuGLNy/5XPpDp0Tkou2N?=
 =?iso-8859-1?Q?rEZSqqCBfdDyy+6zEKqUY4LP27C9ve6cqzvkIeBvLD2EG/XkYbgR0yqpbU?=
 =?iso-8859-1?Q?8FYbEAOQmhaK243KPqSGWNDULOmJaWa7oFljcIVaNKCa8BVmMcQT5M96JK?=
 =?iso-8859-1?Q?DMs3lF4Yt9LprEA0UofXylX14fAHGJAAxNCvmtH5mk+LJfo1ZK8V+3Ypmh?=
 =?iso-8859-1?Q?CPbxfpixewxbrxmheY280aOACBTPIacMoKiR/Gk0rIabReE8VPJW0etIfI?=
 =?iso-8859-1?Q?/E0yIB4B9snTYjfJZlgp5Ev3tKzsbjyncm+NCZKWX1dUCWKPTWw6JnVEMv?=
 =?iso-8859-1?Q?11l4ql72//ogsLxlC8RzM1PRRM69Xkhv/fBGB7e9kpFQ6ak5ywq2RLnVdb?=
 =?iso-8859-1?Q?Os3nAhxugWpcEcscmIQdNg3mvubdxr8Mo5Mbg7b9E0uU1B3SHNXZFnDH+m?=
 =?iso-8859-1?Q?5kTnGtJutZpWYZjj9/YR/Sw2848ZJdmK0FRBXmexL2w78D0RVYRgekm0tZ?=
 =?iso-8859-1?Q?rnCF/B86n20zjXkE/eD9cKn68fnfJVBnooTgIRDMB7E3PijI4Ls2ejRjgS?=
 =?iso-8859-1?Q?KFE2C1sbZt/btNnB9+zhYksU+J9NqBfKS+U4kL1C7Z6bOPQ9L82TSXCnf/?=
 =?iso-8859-1?Q?TtUOp8nGFiE84qXb82I+i1iI8oy3QB/RoHrgEH4n+ou+XkjyY5ffLDDsmq?=
 =?iso-8859-1?Q?h6zOAu7Jyb82/bACmbxPXC7I0zaksQlsU1nm2ShiX6zPP+R2fWY8uC7rys?=
 =?iso-8859-1?Q?FoAlZnxgpajHIjtNUK/S3pgQW/VBOs+HieAns84umWR+jgx9/OBeiHxAtg?=
 =?iso-8859-1?Q?znnXB0UuqIv698CpPnqVdWKRfTKr5wUtbo9FQae/hzPcubJE4njycXNm6i?=
 =?iso-8859-1?Q?SoI8Tqcfcq0wujRqAsbrJASanPZ3?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09238924363B70583AA08BA5926BADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8663e737-ece2-44ca-6771-08dda784bba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 18:37:48.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EUNfJGmqvjxDxiPFiCpbHMveMZjBmQxZZFdQNfzeajl5mxiqhaSwOU9ws3Lk2lckBtvqmRwfSEE3uXnQlPISFJQNoAO5/glRIiNEUlcxv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0674
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09238924363B70583AA08BA5926BADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello=0A=
=0A=
Since today, https://github.com/cygwin/cygwin/actions/runs/15537033468=A0wo=
rkflow=A0started to fail as it seems that `cygwin/cygwin-install-action@mas=
ter` action started to use newer MinGW headers.=0A=
=0A=
The attached patch fixes compatibility with v13 MinGW headers while preserv=
ing compatibility with v12.=0A=
=0A=
Radek=0A=

--_002_DB9PR83MB09238924363B70583AA08BA5926BADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Fix-compatibility-with-MinGW-v13-headers.patch"
Content-Description: 0001-Fix-compatibility-with-MinGW-v13-headers.patch
Content-Disposition: attachment;
	filename="0001-Fix-compatibility-with-MinGW-v13-headers.patch"; size=1774;
	creation-date="Mon, 09 Jun 2025 18:33:39 GMT";
	modification-date="Mon, 09 Jun 2025 18:34:05 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiZmFhYmYyYTZkMjgxMDRjODZiM2YyMWZlNDc4NmE2NjVmOTI2NTkyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCA5IEp1biAyMDI1IDE4OjE0OjE0ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGNvbXBhdGliaWxpdHkgd2l0aCBNaW5HVyB2MTMgaGVh
ZGVycwoKLS0tCiB3aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3NvY2tldC5oIHwgNCArKysr
CiB3aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL250ZGxsLmggIHwgNCArKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vaW5j
bHVkZS9jeWd3aW4vc29ja2V0LmggYi93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3NvY2tl
dC5oCmluZGV4IGRjNTZjYjBmNS4uM2E1MDRkMjIzIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2lu
L2luY2x1ZGUvY3lnd2luL3NvY2tldC5oCisrKyBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3
aW4vc29ja2V0LmgKQEAgLTY1LDYgKzY1LDggQEAgc3RydWN0IG1zZ2hkcgogICBpbnQJCQltc2df
ZmxhZ3M7CS8qIFJlY2VpdmVkIGZsYWdzIG9uIHJlY3Ztc2cJKi8KIH07CiAKKyNpZiBfX01JTkdX
NjRfVkVSU0lPTl9NQUpPUiA8IDEzCisKIHN0cnVjdCBjbXNnaGRyCiB7CiAgIC8qIEFtYXppbmcg
YnV0IHRydWU6IFRoZSB0eXBlIG9mIGNtc2dfbGVuIHNob3VsZCBiZSBzb2NrbGVuX3QgYnV0LCBq
dXN0CkBAIC03NSw2ICs3Nyw4IEBAIHN0cnVjdCBjbXNnaGRyCiAgIGludAkJCWNtc2dfdHlwZTsJ
LyogUHJvdG9jb2wgdHlwZQkJKi8KIH07CiAKKyNlbmRpZgorCiAjZGVmaW5lIENNU0dfQUxJR04o
bGVuKSBcCiAJKCgobGVuKSArIF9fYWxpZ25vZl9fIChzdHJ1Y3QgY21zZ2hkcikgLSAxKSBcCiAJ
ICYgfihfX2FsaWdub2ZfXyAoc3RydWN0IGNtc2doZHIpIC0gMSkpCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL250ZGxsLmggYi93aW5zdXAvY3lnd2luL2xvY2FsX2lu
Y2x1ZGVzL250ZGxsLmgKaW5kZXggOTdhODNkMWUzLi5mYzJhYjdhMmUgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvbnRkbGwuaAorKysgYi93aW5zdXAvY3lnd2luL2xv
Y2FsX2luY2x1ZGVzL250ZGxsLmgKQEAgLTQ5MCw2ICs0OTAsOCBAQCB0eXBlZGVmIHN0cnVjdCBf
RklMRV9ESVNQT1NJVElPTl9JTkZPUk1BVElPTl9FWAkvLyA2NAogICBVTE9ORyBGbGFnczsKIH0g
RklMRV9ESVNQT1NJVElPTl9JTkZPUk1BVElPTl9FWCwgKlBGSUxFX0RJU1BPU0lUSU9OX0lORk9S
TUFUSU9OX0VYOwogCisjaWYgX19NSU5HVzY0X1ZFUlNJT05fTUFKT1IgPCAxMworCiB0eXBlZGVm
IHN0cnVjdCBfRklMRV9TVEFUX0lORk9STUFUSU9OCQkvLyA2OAogewogICBMQVJHRV9JTlRFR0VS
IEZpbGVJZDsKQEAgLTUxMCw2ICs1MTIsOCBAQCB0eXBlZGVmIHN0cnVjdCBfRklMRV9DQVNFX1NF
TlNJVElWRV9JTkZPUk1BVElPTgkvLyA3MQogICBVTE9ORyBGbGFnczsKIH0gRklMRV9DQVNFX1NF
TlNJVElWRV9JTkZPUk1BVElPTiwgKlBGSUxFX0NBU0VfU0VOU0lUSVZFX0lORk9STUFUSU9OOwog
CisjZW5kaWYKKwogZW51bSB7CiAgIEZJTEVfTElOS19SRVBMQUNFX0lGX0VYSVNUUwkJCQk9IDB4
MDEsCiAgIEZJTEVfTElOS19QT1NJWF9TRU1BTlRJQ1MJCQkJPSAweDAyLAotLSAKMi40OS4wLnZm
cy4wLjMKCg==

--_002_DB9PR83MB09238924363B70583AA08BA5926BADB9PR83MB0923EURP_--
