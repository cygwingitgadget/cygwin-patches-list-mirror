Return-Path: <SRS0=Rz1U=ZY=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20725.outbound.protection.outlook.com [IPv6:2a01:111:f403:260e::725])
	by sourceware.org (Postfix) with ESMTPS id B9E8F3857C6D
	for <cygwin-patches@cygwin.com>; Fri, 11 Jul 2025 13:18:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B9E8F3857C6D
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B9E8F3857C6D
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260e::725
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752239939; cv=pass;
	b=wGiHFN4BOs0lwZo2mnRNlWTxS6mApP4FsNShAqHJXr9vLJNgcFXD8ULK5ET3TDGhNWDOXLnCfcPyQo/WFgcqr5nLbt/vyLva5wkGZqmfTALvd1BplU195adCs1hBb+K51WwvV0PNOpgA2hApQdUQjbmw4BopN3iGYuu5KlYtJJw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752239939; c=relaxed/simple;
	bh=ySWsioLLlRjxjLIyIz3wgKlReJoUghZLBw2XdTZDTX4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=dwYOW7+g0DI4D6eAXjdOCtOGOpZoY5VMy06u7BWJxsihbJEvqwqockWQ+IL+oeg4k/U/WxK0r/p7AFXudY6m9C0AKYjYnyRn0E1Sxf32iPX4XbK3U7X4L34Uu1EFXNwhzMI3HC8wkVrnNpf+DsCU2Z18WBCNqC053w8vIud9t2w=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B9E8F3857C6D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=aPP0w3+V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7yuihVGyEvGTpi+a54Osj/oIDBM60vGPSec5eH9MEz8WKv7KYD7wc5G/UbMG671vrHB2NT9uwSxOD+bBmCJaBCyWwfko5ome7ADtPPMqgYPPhmKDHpjKA+MBp+DdHSGJnTyWonA7EUFwoF8ClKxCsKkLyfjlY4fiP8WgXtVnylMNf+c6Ve0oAC61wmaO5fpSXfyJAH5/nDS4pZpgPCb4Nyi19SlKpDJKOJ9r3ThBA7DhbkausZRkLpOvlS5nJ2NElGM+xhQOAUJtlBYaguxwh9bzgdn4EzULEdxaW+BVrl3SUqQZgnBondq0LTJEUtxaB5tgcBR6GxcqURpf6auwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8dYTPRktyI+NdMhi2BPNZ//B+gyyVTLLI65qYDRDWE=;
 b=wmKvFa7qGUhcwCvaezITiKpWSRM301McaMkOreY+S7NFkgtHlcKfJtwJt63HeOVtAJ1XT8EcMd4zV2no4qb6h1wdf6JKUTlyujimjHD2f8r+WtE0tWn5z10K/tQ7gtsfTBxF+CbuixE5yAMFo1WdcwuRAUO4ik2joPsFTJwdJQ8sdYpkDBBa7/k3jLwJYLf4XTeJJ4ZzfOqMikW+FY8t2x1+B1PayRjLDzd+DkIiOl3gPitCdvJ9JGnapGMIg4OcLGSSoiGe/aTabEnCX9q0GcHn9RVNAFZb73yXN6Ln5nxo70Lkbu+nk1ihEwnP8yM1Z6uCXFfBChjkh+lRk4ViPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8dYTPRktyI+NdMhi2BPNZ//B+gyyVTLLI65qYDRDWE=;
 b=aPP0w3+VCmnNp9Vr06JXA9kuFrG0AwyNpXkJNcR4Q7FIZUEVFH+qi8DUcXJIHMeuTXXsD8MHbSsRbaqIb/A4E9B1q0gRbSrU0/a6ErLy6exXLZiX6p7nTSiHY1UO6XQikolW8H/gRgDqw5vzI4gNojgoaYxKQohwnIWCmBm1UtI=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by VI0PR83MB0657.EURPRD83.prod.outlook.com (2603:10a6:800:237::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Fri, 11 Jul
 2025 13:18:54 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%4]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 13:18:52 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: signal: make context structures registers handling
 portable
Thread-Topic: [PATCH] Cygwin: signal: make context structures registers
 handling portable
Thread-Index: AQHb8mYVCrVz329od0muB8ht+nGlFA==
Date: Fri, 11 Jul 2025 13:18:52 +0000
Message-ID:
 <DB9PR83MB09236018A992CBC8F322F009924BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-11T13:18:51.522Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|VI0PR83MB0657:EE_
x-ms-office365-filtering-correlation-id: a282b6fe-d73e-4097-8d4c-08ddc07d7b0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?XFxtjaJ4ExX6eIbrjzkcPFl4/hKLe/WRFr8YkU/wDryQKgqZCwnqtspVpv?=
 =?iso-8859-2?Q?pnOwYqETc5KblGL+ZNohY9VBKqdAkALLfuBEtybYrqHLkr8fvd7SZViyuS?=
 =?iso-8859-2?Q?8KAV2jgo1wgELHiY140aL8U/Rj1hDASd0Ekd9lghanUTF5YolEYn0m9cUV?=
 =?iso-8859-2?Q?y7698okv6Crp8DsUo06qsBCwlfm0RpCzEYh7eiTCQzmiDb1JAjC70d7MwO?=
 =?iso-8859-2?Q?GlR8Oy65D0S73iwsIVV1285OBZayt8y9mAN3nch208vKfo48zL262P7j2I?=
 =?iso-8859-2?Q?9ZMfAcxZmL8PGofAN42ResZuPzOS+bhFUuHHbo0WyYEsAMNxr9KKuWFVUN?=
 =?iso-8859-2?Q?cmXOzmW6SIZyuYq0y2ZCKdWwOipOuktd5Z9iPIvmN9FmxAS17r2Ff8iKAP?=
 =?iso-8859-2?Q?LFW5ScJymntiEHIVmpft4QExyvCjHsos0IdCCuwUEc62Z5kgdZZs4rfSGG?=
 =?iso-8859-2?Q?X6NMpKyVUrozKqTzWUiCSxYOLbwwbFUlKkrYs4MBLbFAOBDhe/gHiNlDai?=
 =?iso-8859-2?Q?zTQ8Rx0hFR5VJjAbQ9qy7wEU7Nc2IVXkHM6O93pOykJRXo/VI8SjzNh4fU?=
 =?iso-8859-2?Q?WTrTZ64IJpKZthYUNrAORSVvqIZGInWLVFwmbRRf7ivwBON7JERIHcec0v?=
 =?iso-8859-2?Q?/bGwrAokDrF39LP0BehHm9LKQSR0FilHPA8HLJPyR8uMp8Zp3Uux7XjBNC?=
 =?iso-8859-2?Q?uy6Y5tckybzBiAn6bo6pxVLGLsPsASYLshSPOUsrju6t5PIcEGscnxsaEM?=
 =?iso-8859-2?Q?RdK1v+MTPYSaon4YSab3/YXsKM3sEId+szjw1XThVRx7n+WcIkimVnyVL2?=
 =?iso-8859-2?Q?eeLWqevtwCgcXJouFoj9Uv5whTvjt57xQaJ3nultB05Y//K3sTHdMK5mqO?=
 =?iso-8859-2?Q?rcoVAzK2bSTVAmh8xUpGqBm7fnow9COGyfVHSe/p4Z/Qhhhyq8xiHXZa72?=
 =?iso-8859-2?Q?RmgHhpdb7Cm+jG2qELy6XY3Kae1xJKzFlbUYxDBzSlPajiFJ7DxwjLyShE?=
 =?iso-8859-2?Q?4jUCJIvEhj77EeuMXFfq1vvmOgL3BkPotMipGLvdmmOJcEyjVyNok+w62k?=
 =?iso-8859-2?Q?WpDCS7mBfLKYxXPjlvrlDO06M1RoLdST3POpvoDzgkGTnD6TBifA/MHavj?=
 =?iso-8859-2?Q?+/kG9EdQaG9U/alG2wnurc4RLqZf0txf1yhYLoAuTjAgcKWR8BsfDn6NFH?=
 =?iso-8859-2?Q?5M1Cx2J/3okcFD3fdoTw8KodE5vS6GzxZupPgJdy6gswtNzdSGWPK95bve?=
 =?iso-8859-2?Q?ZiGgAwbVia9wG69iQE+sISLW8ssOkavPeLr1RY6fzNDvFRvlWwkmKFjlsJ?=
 =?iso-8859-2?Q?TTTcyctX1yEih0m4pKKR4Cf1SHj1yGZeZTpmosmCXk3/bIpUcbD8DE0Vjn?=
 =?iso-8859-2?Q?mBEuGQ1Nbcp36ft0HTbFyvJqyCBsoeV6/juY6pgzokyYJ/r92JF2R4ykJL?=
 =?iso-8859-2?Q?bdQqKoEaQbQVJ4LboF6vtN5yC6j6Vd2qP5aI3x8cX3b0kSxt07bxUgmYVf?=
 =?iso-8859-2?Q?C8GtxwKpBY1lo8HY6SOkahHZ4hOYAjkpMNkiehBjkaWqIT2AEaGxtgenbb?=
 =?iso-8859-2?Q?YMCE4ug=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?UXVXJLmc7jDSZ35zZwJVIhzekHHxnn6AmGV3GSKY74kBqlDnx7Uecggqmn?=
 =?iso-8859-2?Q?jU7nc/jMNkDvDq308zsdk1BpZrBBJOM5oixtSEJgLC/eSLcwrWHmWFEyna?=
 =?iso-8859-2?Q?klOFKrfKIjyUiMs52YLxc2jv6fWAn0VPuC4NmwNVdxgUdb9u7V/klMlP7S?=
 =?iso-8859-2?Q?xiZBy+ZWTwROaAcv45P9YOWHeoeQ7tCHSWY7LsqmZnPmclZ/9pIjtOd1an?=
 =?iso-8859-2?Q?OdubgzTTTtd4DSpy7QpmimOI1whwmBpNmSN4ianZ3a8aqA+6icUfE9gaLm?=
 =?iso-8859-2?Q?joruKsPqjmnS+oy25Xlq/2gkN2AmtOMfJCk7x3pe2Ib0Wxj1hSgK52VkQf?=
 =?iso-8859-2?Q?LeFNrF7hORbNi5RBjZ4vZtnqPsB8cdWVxK8xaX7QG1mMtvMP5WRYwtrnon?=
 =?iso-8859-2?Q?mBXaLKsGW/U0yRGWOsKO4BQoNdsuIrrO/nUotdGst15xNDq/MrvaqLXLah?=
 =?iso-8859-2?Q?TiwJZ0q4UhBszHV1/gj46NYCR+7j5p5V2ToN3j1A6wKKrQE/s+XcXzKyR6?=
 =?iso-8859-2?Q?Q++pvlwxA+VoxvrKV+K5EdTnn92rYDizinXs2+pYa2qthIhBiwXHoUmyYl?=
 =?iso-8859-2?Q?AEPwRjS94BynYaH1AsWLycapzhhPo3KN5EiEblitRlOgiOhtsBA3BZtWPA?=
 =?iso-8859-2?Q?OEdKtNUvdviYK4KLz2ptLhCxHof0DgZu3FQsnOQJVib5KuWV3BEyzZyWRV?=
 =?iso-8859-2?Q?Rzjxdno2JiXcCIS/629UPOXLQYwKkiwf5tYIokRsvi/ESopIMRloqTCf+S?=
 =?iso-8859-2?Q?/Vip5xG6uEbLVxnY9A/vlzi0Q8YZhoDDZhkPUQ2TBW/Uh8Pi5phiRq9Qqz?=
 =?iso-8859-2?Q?GbxtfEhm9tPorRmWeIo26L8Xy/7sKDk5avQdCMLhHOQq5kRaahAjHJc99r?=
 =?iso-8859-2?Q?RKDuKBQN7tVXzBQAjR770J9v7ZFdcNTC2iY47kt+T8zgNyPmeiAKWzqiJU?=
 =?iso-8859-2?Q?Cx6zZtORl55gI6V2LsBPgq8xE29x8JNpIGGVUaN+PimWq+RnTDJzS+JhGO?=
 =?iso-8859-2?Q?mHQ82qbH/pX/uEqz71CxPZWIo5I7UIE66RG2sMUgxZsiZtHKWnjT1Io4PY?=
 =?iso-8859-2?Q?ehWLmqxclYacJfKD1yYKQ+D9oGIQ0use+K1PBy9z+KMl+6mAipXME0JA6U?=
 =?iso-8859-2?Q?BE3tM8YRnyekID0lwbQkPCsrsZnd3iqen45gYR+A48TMRSWAzhPKcgIcxd?=
 =?iso-8859-2?Q?QJJ0DMz0SlF6xUaHJBx9CxL9fiDLhYFlAGfz+I6bEV1ZhJMAgsHHTRH0XB?=
 =?iso-8859-2?Q?ZbG8nR/bdt2qOTqzz7mA7MQp0OhAp6YGTItqdg3alK5gq0/YsW5GYSwxpj?=
 =?iso-8859-2?Q?SwNu3a8sNg4NlqufEpRCd2Gvyo3ayX7SM7DTIvbqHKcFUSuo3eTXRR8iBD?=
 =?iso-8859-2?Q?0wwEbfpip/aYLVRuUpsYP+/AEes7SiecM4rPfJ1OzGkXjQuM8dU30ILPMR?=
 =?iso-8859-2?Q?GRHimuQiXVsqbaBVR9WuCGIoxdR24ga5Q+4eRiivIBvaT3pcjGjaJWNM8+?=
 =?iso-8859-2?Q?SBA/bRVIKmYDJBxbop+85/ZcNI7ql8fDgvltnlGXICu+YKfa4Gu2c8alcg?=
 =?iso-8859-2?Q?pHy81jJSRhDNwv4tLTGw3OkZioOu?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09236018A992CBC8F322F009924BADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a282b6fe-d73e-4097-8d4c-08ddc07d7b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 13:18:52.4318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPmtPobhuNzaOSvXJ1rHitbdOyZ8O7D7jA5uwiqIZj4oPLuqxA+TAE+CiYP27NixIkEfJAznWqo/Dqc/D47JegR9Z8rQywVwui3mjrEg1rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0657
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09236018A992CBC8F322F009924BADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch extracts macros from `winsup/cygwin/exceptions.cc` serving for p=
ortable register access to context structures into a separate local header =
`winsup/cygwin/local_includes/register.h` and implements their AArch64 coun=
terparts.=0A=
=0A=
Then, it adds AArch64 declaration of `__mcontext` structure based on `mingw=
-w64-headers/include/winnt.h` header to `winsup/cygwin/include/cygwin/singa=
l.h` header.=0A=
=0A=
Then, it includes the `registers.h` header and uses the macros where applic=
able, namely at:=0A=
=A0- `winsup/cygwin/exceptions.cc`=0A=
=A0- `winsup/cygwin/profil.c`=0A=
=A0- `winsup/cygwin/tread.cc`=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 434df1dc447ecb7a8cfd08af5219ce0697877fd5 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Wed, 4 Jun 2025 14:55:34 +0200=0A=
Subject: [PATCH] Cygwin: signal: make context structures registers handling=
=0A=
 portable=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch extracts macros from winsup/cygwin/exceptions.cc serving for por=
table=0A=
register access to context structures into a separate local header=0A=
winsup/cygwin/local_includes/register.h and implements their AArch64=0A=
counterparts.=0A=
=0A=
Then, it adds AArch64 declaration of __mcontext structure based on=0A=
mingw-w64-headers/include/winnt.h header to=0A=
winsup/cygwin/include/cygwin/singal.h header.=0A=
=0A=
Then, it includes the registers.h header and uses the macros where applicab=
le,=0A=
namely at:=0A=
 - winsup/cygwin/exceptions.cc=0A=
 - winsup/cygwin/profil.c=0A=
 - winsup/cygwin/tread.cc=0A=
=0A=
The motivation is to make usage of the context structures portable without=
=0A=
unnecessary #if defined(__x86_64__) while implementations of signal handlin=
g=0A=
code will be developed later, e.g. implementation of makecontext.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/exceptions.cc             | 51 ++++++++--------=0A=
 winsup/cygwin/include/cygwin/signal.h   | 77 ++++++++++++++++++++++++-=0A=
 winsup/cygwin/local_includes/register.h | 25 ++++++++=0A=
 winsup/cygwin/profil.c                  |  7 +--=0A=
 winsup/cygwin/thread.cc                 |  3 +-=0A=
 winsup/utils/profiler.cc                |  7 +--=0A=
 6 files changed, 135 insertions(+), 35 deletions(-)=0A=
 create mode 100644 winsup/cygwin/local_includes/register.h=0A=
=0A=
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc=0A=
index f79978f73..830846431 100644=0A=
--- a/winsup/cygwin/exceptions.cc=0A=
+++ b/winsup/cygwin/exceptions.cc=0A=
@@ -28,25 +28,9 @@ details. */=0A=
 #include "ntdll.h"=0A=
 #include "exception.h"=0A=
 #include "posix_timer.h"=0A=
+#include "register.h"=0A=
 #include "gcc_seh.h"=0A=
 =0A=
-/* Define macros for CPU-agnostic register access.  The _CX_foo=0A=
-   macros are for access into CONTEXT, the _MC_foo ones for access into=0A=
-   mcontext. The idea is to access the registers in terms of their job,=0A=
-   not in terms of their name on the given target. */=0A=
-#ifdef __x86_64__=0A=
-#define _CX_instPtr	Rip=0A=
-#define _CX_stackPtr	Rsp=0A=
-#define _CX_framePtr	Rbp=0A=
-/* For special register access inside mcontext. */=0A=
-#define _MC_retReg	rax=0A=
-#define _MC_instPtr	rip=0A=
-#define _MC_stackPtr	rsp=0A=
-#define _MC_uclinkReg	rbx	/* MUST be callee-saved reg */=0A=
-#else=0A=
-#error unimplemented for this target=0A=
-#endif=0A=
-=0A=
 #define CALL_HANDLER_RETRY_OUTER 10=0A=
 #define CALL_HANDLER_RETRY_INNER 10=0A=
 #define DUMPSTACK_FRAME_LIMIT    32=0A=
@@ -230,7 +214,7 @@ cygwin_exception::dump_exception ()=0A=
 	}=0A=
     }=0A=
 =0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
   if (exception_name)=0A=
     small_printf ("Exception: %s at rip=3D%012X\r\n", exception_name, ctx-=
>Rip);=0A=
   else=0A=
@@ -250,6 +234,31 @@ cygwin_exception::dump_exception ()=0A=
   small_printf ("cs=3D%04x ds=3D%04x es=3D%04x fs=3D%04x gs=3D%04x ss=3D%0=
4x\r\n",=0A=
 		ctx->SegCs, ctx->SegDs, ctx->SegEs, ctx->SegFs,=0A=
 		ctx->SegGs, ctx->SegSs);=0A=
+#elif defined(__aarch64__)=0A=
+  if (exception_name)=0A=
+    small_printf ("Exception: %s at pc=3D%012X\r\n", exception_name, ctx->=
Pc);=0A=
+  else=0A=
+    small_printf ("Signal %d at pc=3D%012X\r\n", e->ExceptionCode, ctx->Pc=
);=0A=
+  small_printf ("x0=3D%016X x1=3D%016X x2=3D%016X x3=3D%016X\r\n",=0A=
+		ctx->X0, ctx->X1, ctx->X2, ctx->X3);=0A=
+  small_printf ("x4=3D%016X x5=3D%016X x6=3D%016X x7=3D%016X\r\n",=0A=
+		ctx->X4, ctx->X5, ctx->X6, ctx->X7);=0A=
+  small_printf ("x8=3D%016X x9=3D%016X x10=3D%016X x11=3D%016X\r\n",=0A=
+		ctx->X8, ctx->X9, ctx->X10, ctx->X11);=0A=
+  small_printf ("x12=3D%016X x13=3D%016X x14=3D%016X x15=3D%016X\r\n",=0A=
+		ctx->X12, ctx->X13, ctx->X14, ctx->X15);=0A=
+  small_printf ("x16=3D%016X x17=3D%016X x18=3D%016X x19=3D%016X\r\n",=0A=
+		ctx->X16, ctx->X17, ctx->X18, ctx->X19);=0A=
+  small_printf ("x20=3D%016X x21=3D%016X x22=3D%016X x23=3D%016X\r\n",=0A=
+		ctx->X20, ctx->X21, ctx->X22, ctx->X23);=0A=
+  small_printf ("x24=3D%016X x25=3D%016X x26=3D%016X x27=3D%016X\r\n",=0A=
+		ctx->X24, ctx->X25, ctx->X26, ctx->X27);=0A=
+  small_printf ("x28=3D%016X fp=3D%016X lr=3D%016X sp=3D%016X\r\n",=0A=
+		ctx->X28, ctx->Fp, ctx->Lr, ctx->Sp);=0A=
+  small_printf ("program=3D%W, pid %u, thread %s\r\n",=0A=
+		myself->progname, myself->pid, mythreadname ());=0A=
+  small_printf ("fpcr=3D%016X fpsr=3D%016X\r\n",=0A=
+		ctx->Fpcr, ctx->Fpsr);=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
@@ -1781,11 +1790,7 @@ _cygtls::call_signal_handler ()=0A=
 	      __unwind_single_frame ((PCONTEXT) &context1.uc_mcontext);=0A=
 	      if (stackptr > stack)=0A=
 		{=0A=
-#ifdef __x86_64__=0A=
-		  context1.uc_mcontext.rip =3D retaddr ();=0A=
-#else=0A=
-#error unimplemented for this target=0A=
-#endif=0A=
+		  context1.uc_mcontext._MC_instPtr =3D retaddr ();=0A=
 		}=0A=
 	    }=0A=
 =0A=
diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/=
cygwin/signal.h=0A=
index de728bede..4e9eafba7 100644=0A=
--- a/winsup/cygwin/include/cygwin/signal.h=0A=
+++ b/winsup/cygwin/include/cygwin/signal.h=0A=
@@ -19,7 +19,7 @@ extern "C" {=0A=
   Define a struct __mcontext, which should be identical in layout to the W=
in32=0A=
   API type CONTEXT with the addition of oldmask and cr2 fields at the end.=
=0A=
 */=0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
 =0A=
 struct _uc_fpxreg {=0A=
   __uint16_t significand[4];=0A=
@@ -98,6 +98,81 @@ struct __attribute__ ((__aligned__ (16))) __mcontext=0A=
   __uint64_t cr2;=0A=
 };=0A=
 =0A=
+#elif defined(__aarch64__)=0A=
+=0A=
+/* Based on mingw-w64-headers/include/winnt.h. */=0A=
+=0A=
+#define ARM64_MAX_BREAKPOINTS 8=0A=
+#define ARM64_MAX_WATCHPOINTS 2=0A=
+=0A=
+union _neon128=0A=
+{=0A=
+  struct=0A=
+  {=0A=
+    __uint64_t low;=0A=
+    __int64_t high;=0A=
+  };=0A=
+  double d[2];=0A=
+  float s[4];=0A=
+  __uint16_t h[8];=0A=
+  __uint8_t b[16];=0A=
+};=0A=
+=0A=
+struct __attribute__ ((__aligned__ (16))) __mcontext=0A=
+{=0A=
+  __uint32_t ctxflags;=0A=
+  __uint32_t cpsr;=0A=
+  union=0A=
+  {=0A=
+    struct=0A=
+    {=0A=
+      __uint64_t x0;=0A=
+      __uint64_t x1;=0A=
+      __uint64_t x2;=0A=
+      __uint64_t x3;=0A=
+      __uint64_t x4;=0A=
+      __uint64_t x5;=0A=
+      __uint64_t x6;=0A=
+      __uint64_t x7;=0A=
+      __uint64_t x8;=0A=
+      __uint64_t x9;=0A=
+      __uint64_t x10;=0A=
+      __uint64_t x11;=0A=
+      __uint64_t x12;=0A=
+      __uint64_t x13;=0A=
+      __uint64_t x14;=0A=
+      __uint64_t x15;=0A=
+      __uint64_t x16;=0A=
+      __uint64_t x17;=0A=
+      __uint64_t x18;=0A=
+      __uint64_t x19;=0A=
+      __uint64_t x20;=0A=
+      __uint64_t x21;=0A=
+      __uint64_t x22;=0A=
+      __uint64_t x23;=0A=
+      __uint64_t x24;=0A=
+      __uint64_t x25;=0A=
+      __uint64_t x26;=0A=
+      __uint64_t x27;=0A=
+      __uint64_t x28;=0A=
+      __uint64_t fp;=0A=
+      __uint64_t lr;=0A=
+    };=0A=
+    __uint64_t x[31];=0A=
+  };=0A=
+  __uint64_t sp;=0A=
+  __uint64_t pc;=0A=
+  union _neon128 v[32];=0A=
+  __uint32_t fpcr;=0A=
+  __uint32_t fpsr;=0A=
+  __uint32_t bcr[ARM64_MAX_BREAKPOINTS];=0A=
+  __uint64_t bvr[ARM64_MAX_BREAKPOINTS];=0A=
+  __uint32_t wcr[ARM64_MAX_WATCHPOINTS];=0A=
+  __uint64_t wvr[ARM64_MAX_WATCHPOINTS];=0A=
+  __uint64_t oldmask;=0A=
+  __uint64_t cr2;=0A=
+};=0A=
+=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
diff --git a/winsup/cygwin/local_includes/register.h b/winsup/cygwin/local_=
includes/register.h=0A=
new file mode 100644=0A=
index 000000000..1ddfe2ec0=0A=
--- /dev/null=0A=
+++ b/winsup/cygwin/local_includes/register.h=0A=
@@ -0,0 +1,25 @@=0A=
+/* Define macros for CPU-agnostic register access.  The _CX_foo=0A=
+   macros are for access into CONTEXT, the _MC_foo ones for access into=0A=
+   mcontext. The idea is to access the registers in terms of their job,=0A=
+   not in terms of their name on the given target. */=0A=
+#if defined(__x86_64__)=0A=
+#define _CX_instPtr	Rip=0A=
+#define _CX_stackPtr	Rsp=0A=
+#define _CX_framePtr	Rbp=0A=
+/* For special register access inside mcontext. */=0A=
+#define _MC_retReg	rax=0A=
+#define _MC_instPtr	rip=0A=
+#define _MC_stackPtr	rsp=0A=
+#define _MC_uclinkReg	rbx	/* MUST be callee-saved reg */=0A=
+#elif defined(__aarch64__)=0A=
+#define _CX_instPtr	Pc=0A=
+#define _CX_stackPtr	Sp=0A=
+#define _CX_framePtr	Fp=0A=
+/* For special register access inside mcontext. */=0A=
+#define _MC_retReg	x0=0A=
+#define _MC_instPtr	pc=0A=
+#define _MC_stackPtr	sp=0A=
+#define _MC_uclinkReg	x19	/* MUST be callee-saved reg */=0A=
+#else=0A=
+#error unimplemented for this target=0A=
+#endif=0A=
diff --git a/winsup/cygwin/profil.c b/winsup/cygwin/profil.c=0A=
index 30b37244a..9578ab1df 100644=0A=
--- a/winsup/cygwin/profil.c=0A=
+++ b/winsup/cygwin/profil.c=0A=
@@ -21,6 +21,7 @@=0A=
 #include <errno.h>=0A=
 #include <pthread.h>=0A=
 #include "profil.h"=0A=
+#include "register.h"=0A=
 =0A=
 #define SLEEPTIME (1000 / PROF_HZ)=0A=
 =0A=
@@ -42,11 +43,7 @@ get_thrpc (HANDLE thr)=0A=
   ctx.ContextFlags =3D CONTEXT_CONTROL | CONTEXT_INTEGER;=0A=
   pc =3D (size_t) - 1;=0A=
   if (GetThreadContext (thr, &ctx)) {=0A=
-#ifdef __x86_64__=0A=
-    pc =3D ctx.Rip;=0A=
-#else=0A=
-#error unimplemented for this target=0A=
-#endif=0A=
+    pc =3D ctx._CX_instPtr;=0A=
   }=0A=
   ResumeThread (thr);=0A=
   return pc;=0A=
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc=0A=
index 510e2be93..b462e2f9f 100644=0A=
--- a/winsup/cygwin/thread.cc=0A=
+++ b/winsup/cygwin/thread.cc=0A=
@@ -32,6 +32,7 @@ details. */=0A=
 #include "ntdll.h"=0A=
 #include "cygwait.h"=0A=
 #include "exception.h"=0A=
+#include "register.h"=0A=
 =0A=
 /* For Linux compatibility, the length of a thread name is 16 characters. =
*/=0A=
 #define THRNAMELEN 16=0A=
@@ -629,7 +630,7 @@ pthread::cancel ()=0A=
       threadlist_t *tl_entry =3D cygheap->find_tls (cygtls);=0A=
       if (!cygtls->inside_kernel (&context))=0A=
 	{=0A=
-	  context.Rip =3D (ULONG_PTR) pthread::static_cancel_self;=0A=
+	  context._CX_instPtr =3D (ULONG_PTR) pthread::static_cancel_self;=0A=
 	  SetThreadContext (win32_obj_id, &context);=0A=
 	}=0A=
       cygheap->unlock_tls (tl_entry);=0A=
diff --git a/winsup/utils/profiler.cc b/winsup/utils/profiler.cc=0A=
index 4fe900b7f..04c6b3ed3 100644=0A=
--- a/winsup/utils/profiler.cc=0A=
+++ b/winsup/utils/profiler.cc=0A=
@@ -33,6 +33,7 @@ typedef uint16_t u_int16_t; // Non-standard sized type ne=
eded by ancient gmon.h=0A=
 #define NO_GLOBALS_H=0A=
 #include "gmon.h"=0A=
 #include "path.h"=0A=
+#include "register.h"=0A=
 =0A=
 /* Undo this #define from winsup.h. */=0A=
 #ifdef ExitThread=0A=
@@ -193,11 +194,7 @@ sample (CONTEXT *context, HANDLE h)=0A=
       return 0ULL;=0A=
     }=0A=
   else=0A=
-#ifdef __x86_64__=0A=
-    return context->Rip;=0A=
-#else=0A=
-#error unimplemented for this target=0A=
-#endif=0A=
+    return context->_CX_instPtr;=0A=
 }=0A=
 =0A=
 void=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB09236018A992CBC8F322F009924BADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-signal-make-context-structures-registers-handling-portable.patch"
Content-Description:
 0001-Cygwin-signal-make-context-structures-registers-handling-portable.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-signal-make-context-structures-registers-handling-portable.patch";
	size=10016; creation-date="Fri, 11 Jul 2025 13:18:46 GMT";
	modification-date="Fri, 11 Jul 2025 13:18:46 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MzRkZjFkYzQ0N2VjYjdhOGNmZDA4YWY1MjE5Y2UwNjk3ODc3ZmQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogV2VkLCA0IEp1biAyMDI1IDE0OjU1OjM0ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzaWduYWw6IG1ha2UgY29udGV4dCBzdHJ1Y3R1
cmVzIHJlZ2lzdGVycyBoYW5kbGluZwogcG9ydGFibGUKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVu
dC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rp
bmc6IDhiaXQKClRoaXMgcGF0Y2ggZXh0cmFjdHMgbWFjcm9zIGZyb20gd2luc3VwL2N5Z3dpbi9l
eGNlcHRpb25zLmNjIHNlcnZpbmcgZm9yIHBvcnRhYmxlCnJlZ2lzdGVyIGFjY2VzcyB0byBjb250
ZXh0IHN0cnVjdHVyZXMgaW50byBhIHNlcGFyYXRlIGxvY2FsIGhlYWRlcgp3aW5zdXAvY3lnd2lu
L2xvY2FsX2luY2x1ZGVzL3JlZ2lzdGVyLmggYW5kIGltcGxlbWVudHMgdGhlaXIgQUFyY2g2NApj
b3VudGVycGFydHMuCgpUaGVuLCBpdCBhZGRzIEFBcmNoNjQgZGVjbGFyYXRpb24gb2YgX19tY29u
dGV4dCBzdHJ1Y3R1cmUgYmFzZWQgb24KbWluZ3ctdzY0LWhlYWRlcnMvaW5jbHVkZS93aW5udC5o
IGhlYWRlciB0bwp3aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3NpbmdhbC5oIGhlYWRlci4K
ClRoZW4sIGl0IGluY2x1ZGVzIHRoZSByZWdpc3RlcnMuaCBoZWFkZXIgYW5kIHVzZXMgdGhlIG1h
Y3JvcyB3aGVyZSBhcHBsaWNhYmxlLApuYW1lbHkgYXQ6CiAtIHdpbnN1cC9jeWd3aW4vZXhjZXB0
aW9ucy5jYwogLSB3aW5zdXAvY3lnd2luL3Byb2ZpbC5jCiAtIHdpbnN1cC9jeWd3aW4vdHJlYWQu
Y2MKClRoZSBtb3RpdmF0aW9uIGlzIHRvIG1ha2UgdXNhZ2Ugb2YgdGhlIGNvbnRleHQgc3RydWN0
dXJlcyBwb3J0YWJsZSB3aXRob3V0CnVubmVjZXNzYXJ5ICNpZiBkZWZpbmVkKF9feDg2XzY0X18p
IHdoaWxlIGltcGxlbWVudGF0aW9ucyBvZiBzaWduYWwgaGFuZGxpbmcKY29kZSB3aWxsIGJlIGRl
dmVsb3BlZCBsYXRlciwgZS5nLiBpbXBsZW1lbnRhdGlvbiBvZiBtYWtlY29udGV4dC4KClNpZ25l
ZC1vZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0K
IHdpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyAgICAgICAgICAgICB8IDUxICsrKysrKysrLS0t
LS0tLS0KIHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vc2lnbmFsLmggICB8IDc3ICsrKysr
KysrKysrKysrKysrKysrKysrKy0KIHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvcmVnaXN0
ZXIuaCB8IDI1ICsrKysrKysrCiB3aW5zdXAvY3lnd2luL3Byb2ZpbC5jICAgICAgICAgICAgICAg
ICAgfCAgNyArLS0KIHdpbnN1cC9jeWd3aW4vdGhyZWFkLmNjICAgICAgICAgICAgICAgICB8ICAz
ICstCiB3aW5zdXAvdXRpbHMvcHJvZmlsZXIuY2MgICAgICAgICAgICAgICAgfCAgNyArLS0KIDYg
ZmlsZXMgY2hhbmdlZCwgMTM1IGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvcmVnaXN0ZXIuaAoKZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyBiL3dpbnN1cC9jeWd3aW4vZXhj
ZXB0aW9ucy5jYwppbmRleCBmNzk5NzhmNzMuLjgzMDg0NjQzMSAxMDA2NDQKLS0tIGEvd2luc3Vw
L2N5Z3dpbi9leGNlcHRpb25zLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYwpA
QCAtMjgsMjUgKzI4LDkgQEAgZGV0YWlscy4gKi8KICNpbmNsdWRlICJudGRsbC5oIgogI2luY2x1
ZGUgImV4Y2VwdGlvbi5oIgogI2luY2x1ZGUgInBvc2l4X3RpbWVyLmgiCisjaW5jbHVkZSAicmVn
aXN0ZXIuaCIKICNpbmNsdWRlICJnY2Nfc2VoLmgiCiAKLS8qIERlZmluZSBtYWNyb3MgZm9yIENQ
VS1hZ25vc3RpYyByZWdpc3RlciBhY2Nlc3MuICBUaGUgX0NYX2ZvbwotICAgbWFjcm9zIGFyZSBm
b3IgYWNjZXNzIGludG8gQ09OVEVYVCwgdGhlIF9NQ19mb28gb25lcyBmb3IgYWNjZXNzIGludG8K
LSAgIG1jb250ZXh0LiBUaGUgaWRlYSBpcyB0byBhY2Nlc3MgdGhlIHJlZ2lzdGVycyBpbiB0ZXJt
cyBvZiB0aGVpciBqb2IsCi0gICBub3QgaW4gdGVybXMgb2YgdGhlaXIgbmFtZSBvbiB0aGUgZ2l2
ZW4gdGFyZ2V0LiAqLwotI2lmZGVmIF9feDg2XzY0X18KLSNkZWZpbmUgX0NYX2luc3RQdHIJUmlw
Ci0jZGVmaW5lIF9DWF9zdGFja1B0cglSc3AKLSNkZWZpbmUgX0NYX2ZyYW1lUHRyCVJicAotLyog
Rm9yIHNwZWNpYWwgcmVnaXN0ZXIgYWNjZXNzIGluc2lkZSBtY29udGV4dC4gKi8KLSNkZWZpbmUg
X01DX3JldFJlZwlyYXgKLSNkZWZpbmUgX01DX2luc3RQdHIJcmlwCi0jZGVmaW5lIF9NQ19zdGFj
a1B0cglyc3AKLSNkZWZpbmUgX01DX3VjbGlua1JlZwlyYngJLyogTVVTVCBiZSBjYWxsZWUtc2F2
ZWQgcmVnICovCi0jZWxzZQotI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0Ci0j
ZW5kaWYKLQogI2RlZmluZSBDQUxMX0hBTkRMRVJfUkVUUllfT1VURVIgMTAKICNkZWZpbmUgQ0FM
TF9IQU5ETEVSX1JFVFJZX0lOTkVSIDEwCiAjZGVmaW5lIERVTVBTVEFDS19GUkFNRV9MSU1JVCAg
ICAzMgpAQCAtMjMwLDcgKzIxNCw3IEBAIGN5Z3dpbl9leGNlcHRpb246OmR1bXBfZXhjZXB0aW9u
ICgpCiAJfQogICAgIH0KIAotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0
X18pCiAgIGlmIChleGNlcHRpb25fbmFtZSkKICAgICBzbWFsbF9wcmludGYgKCJFeGNlcHRpb246
ICVzIGF0IHJpcD0lMDEyWFxyXG4iLCBleGNlcHRpb25fbmFtZSwgY3R4LT5SaXApOwogICBlbHNl
CkBAIC0yNTAsNiArMjM0LDMxIEBAIGN5Z3dpbl9leGNlcHRpb246OmR1bXBfZXhjZXB0aW9uICgp
CiAgIHNtYWxsX3ByaW50ZiAoImNzPSUwNHggZHM9JTA0eCBlcz0lMDR4IGZzPSUwNHggZ3M9JTA0
eCBzcz0lMDR4XHJcbiIsCiAJCWN0eC0+U2VnQ3MsIGN0eC0+U2VnRHMsIGN0eC0+U2VnRXMsIGN0
eC0+U2VnRnMsCiAJCWN0eC0+U2VnR3MsIGN0eC0+U2VnU3MpOworI2VsaWYgZGVmaW5lZChfX2Fh
cmNoNjRfXykKKyAgaWYgKGV4Y2VwdGlvbl9uYW1lKQorICAgIHNtYWxsX3ByaW50ZiAoIkV4Y2Vw
dGlvbjogJXMgYXQgcGM9JTAxMlhcclxuIiwgZXhjZXB0aW9uX25hbWUsIGN0eC0+UGMpOworICBl
bHNlCisgICAgc21hbGxfcHJpbnRmICgiU2lnbmFsICVkIGF0IHBjPSUwMTJYXHJcbiIsIGUtPkV4
Y2VwdGlvbkNvZGUsIGN0eC0+UGMpOworICBzbWFsbF9wcmludGYgKCJ4MD0lMDE2WCB4MT0lMDE2
WCB4Mj0lMDE2WCB4Mz0lMDE2WFxyXG4iLAorCQljdHgtPlgwLCBjdHgtPlgxLCBjdHgtPlgyLCBj
dHgtPlgzKTsKKyAgc21hbGxfcHJpbnRmICgieDQ9JTAxNlggeDU9JTAxNlggeDY9JTAxNlggeDc9
JTAxNlhcclxuIiwKKwkJY3R4LT5YNCwgY3R4LT5YNSwgY3R4LT5YNiwgY3R4LT5YNyk7CisgIHNt
YWxsX3ByaW50ZiAoIng4PSUwMTZYIHg5PSUwMTZYIHgxMD0lMDE2WCB4MTE9JTAxNlhcclxuIiwK
KwkJY3R4LT5YOCwgY3R4LT5YOSwgY3R4LT5YMTAsIGN0eC0+WDExKTsKKyAgc21hbGxfcHJpbnRm
ICgieDEyPSUwMTZYIHgxMz0lMDE2WCB4MTQ9JTAxNlggeDE1PSUwMTZYXHJcbiIsCisJCWN0eC0+
WDEyLCBjdHgtPlgxMywgY3R4LT5YMTQsIGN0eC0+WDE1KTsKKyAgc21hbGxfcHJpbnRmICgieDE2
PSUwMTZYIHgxNz0lMDE2WCB4MTg9JTAxNlggeDE5PSUwMTZYXHJcbiIsCisJCWN0eC0+WDE2LCBj
dHgtPlgxNywgY3R4LT5YMTgsIGN0eC0+WDE5KTsKKyAgc21hbGxfcHJpbnRmICgieDIwPSUwMTZY
IHgyMT0lMDE2WCB4MjI9JTAxNlggeDIzPSUwMTZYXHJcbiIsCisJCWN0eC0+WDIwLCBjdHgtPlgy
MSwgY3R4LT5YMjIsIGN0eC0+WDIzKTsKKyAgc21hbGxfcHJpbnRmICgieDI0PSUwMTZYIHgyNT0l
MDE2WCB4MjY9JTAxNlggeDI3PSUwMTZYXHJcbiIsCisJCWN0eC0+WDI0LCBjdHgtPlgyNSwgY3R4
LT5YMjYsIGN0eC0+WDI3KTsKKyAgc21hbGxfcHJpbnRmICgieDI4PSUwMTZYIGZwPSUwMTZYIGxy
PSUwMTZYIHNwPSUwMTZYXHJcbiIsCisJCWN0eC0+WDI4LCBjdHgtPkZwLCBjdHgtPkxyLCBjdHgt
PlNwKTsKKyAgc21hbGxfcHJpbnRmICgicHJvZ3JhbT0lVywgcGlkICV1LCB0aHJlYWQgJXNcclxu
IiwKKwkJbXlzZWxmLT5wcm9nbmFtZSwgbXlzZWxmLT5waWQsIG15dGhyZWFkbmFtZSAoKSk7Cisg
IHNtYWxsX3ByaW50ZiAoImZwY3I9JTAxNlggZnBzcj0lMDE2WFxyXG4iLAorCQljdHgtPkZwY3Is
IGN0eC0+RnBzcik7CiAjZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0
CiAjZW5kaWYKQEAgLTE3ODEsMTEgKzE3OTAsNyBAQCBfY3lndGxzOjpjYWxsX3NpZ25hbF9oYW5k
bGVyICgpCiAJICAgICAgX191bndpbmRfc2luZ2xlX2ZyYW1lICgoUENPTlRFWFQpICZjb250ZXh0
MS51Y19tY29udGV4dCk7CiAJICAgICAgaWYgKHN0YWNrcHRyID4gc3RhY2spCiAJCXsKLSNpZmRl
ZiBfX3g4Nl82NF9fCi0JCSAgY29udGV4dDEudWNfbWNvbnRleHQucmlwID0gcmV0YWRkciAoKTsK
LSNlbHNlCi0jZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKLSNlbmRpZgorCQkg
IGNvbnRleHQxLnVjX21jb250ZXh0Ll9NQ19pbnN0UHRyID0gcmV0YWRkciAoKTsKIAkJfQogCSAg
ICB9CiAKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vc2lnbmFsLmgg
Yi93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3NpZ25hbC5oCmluZGV4IGRlNzI4YmVkZS4u
NGU5ZWFmYmE3IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3NpZ25h
bC5oCisrKyBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vc2lnbmFsLmgKQEAgLTE5LDcg
KzE5LDcgQEAgZXh0ZXJuICJDIiB7CiAgIERlZmluZSBhIHN0cnVjdCBfX21jb250ZXh0LCB3aGlj
aCBzaG91bGQgYmUgaWRlbnRpY2FsIGluIGxheW91dCB0byB0aGUgV2luMzIKICAgQVBJIHR5cGUg
Q09OVEVYVCB3aXRoIHRoZSBhZGRpdGlvbiBvZiBvbGRtYXNrIGFuZCBjcjIgZmllbGRzIGF0IHRo
ZSBlbmQuCiAqLwotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAK
IHN0cnVjdCBfdWNfZnB4cmVnIHsKICAgX191aW50MTZfdCBzaWduaWZpY2FuZFs0XTsKQEAgLTk4
LDYgKzk4LDgxIEBAIHN0cnVjdCBfX2F0dHJpYnV0ZV9fICgoX19hbGlnbmVkX18gKDE2KSkpIF9f
bWNvbnRleHQKICAgX191aW50NjRfdCBjcjI7CiB9OwogCisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2
NF9fKQorCisvKiBCYXNlZCBvbiBtaW5ndy13NjQtaGVhZGVycy9pbmNsdWRlL3dpbm50LmguICov
CisKKyNkZWZpbmUgQVJNNjRfTUFYX0JSRUFLUE9JTlRTIDgKKyNkZWZpbmUgQVJNNjRfTUFYX1dB
VENIUE9JTlRTIDIKKwordW5pb24gX25lb24xMjgKK3sKKyAgc3RydWN0CisgIHsKKyAgICBfX3Vp
bnQ2NF90IGxvdzsKKyAgICBfX2ludDY0X3QgaGlnaDsKKyAgfTsKKyAgZG91YmxlIGRbMl07Cisg
IGZsb2F0IHNbNF07CisgIF9fdWludDE2X3QgaFs4XTsKKyAgX191aW50OF90IGJbMTZdOworfTsK
Kworc3RydWN0IF9fYXR0cmlidXRlX18gKChfX2FsaWduZWRfXyAoMTYpKSkgX19tY29udGV4dAor
eworICBfX3VpbnQzMl90IGN0eGZsYWdzOworICBfX3VpbnQzMl90IGNwc3I7CisgIHVuaW9uCisg
IHsKKyAgICBzdHJ1Y3QKKyAgICB7CisgICAgICBfX3VpbnQ2NF90IHgwOworICAgICAgX191aW50
NjRfdCB4MTsKKyAgICAgIF9fdWludDY0X3QgeDI7CisgICAgICBfX3VpbnQ2NF90IHgzOworICAg
ICAgX191aW50NjRfdCB4NDsKKyAgICAgIF9fdWludDY0X3QgeDU7CisgICAgICBfX3VpbnQ2NF90
IHg2OworICAgICAgX191aW50NjRfdCB4NzsKKyAgICAgIF9fdWludDY0X3QgeDg7CisgICAgICBf
X3VpbnQ2NF90IHg5OworICAgICAgX191aW50NjRfdCB4MTA7CisgICAgICBfX3VpbnQ2NF90IHgx
MTsKKyAgICAgIF9fdWludDY0X3QgeDEyOworICAgICAgX191aW50NjRfdCB4MTM7CisgICAgICBf
X3VpbnQ2NF90IHgxNDsKKyAgICAgIF9fdWludDY0X3QgeDE1OworICAgICAgX191aW50NjRfdCB4
MTY7CisgICAgICBfX3VpbnQ2NF90IHgxNzsKKyAgICAgIF9fdWludDY0X3QgeDE4OworICAgICAg
X191aW50NjRfdCB4MTk7CisgICAgICBfX3VpbnQ2NF90IHgyMDsKKyAgICAgIF9fdWludDY0X3Qg
eDIxOworICAgICAgX191aW50NjRfdCB4MjI7CisgICAgICBfX3VpbnQ2NF90IHgyMzsKKyAgICAg
IF9fdWludDY0X3QgeDI0OworICAgICAgX191aW50NjRfdCB4MjU7CisgICAgICBfX3VpbnQ2NF90
IHgyNjsKKyAgICAgIF9fdWludDY0X3QgeDI3OworICAgICAgX191aW50NjRfdCB4Mjg7CisgICAg
ICBfX3VpbnQ2NF90IGZwOworICAgICAgX191aW50NjRfdCBscjsKKyAgICB9OworICAgIF9fdWlu
dDY0X3QgeFszMV07CisgIH07CisgIF9fdWludDY0X3Qgc3A7CisgIF9fdWludDY0X3QgcGM7Cisg
IHVuaW9uIF9uZW9uMTI4IHZbMzJdOworICBfX3VpbnQzMl90IGZwY3I7CisgIF9fdWludDMyX3Qg
ZnBzcjsKKyAgX191aW50MzJfdCBiY3JbQVJNNjRfTUFYX0JSRUFLUE9JTlRTXTsKKyAgX191aW50
NjRfdCBidnJbQVJNNjRfTUFYX0JSRUFLUE9JTlRTXTsKKyAgX191aW50MzJfdCB3Y3JbQVJNNjRf
TUFYX1dBVENIUE9JTlRTXTsKKyAgX191aW50NjRfdCB3dnJbQVJNNjRfTUFYX1dBVENIUE9JTlRT
XTsKKyAgX191aW50NjRfdCBvbGRtYXNrOworICBfX3VpbnQ2NF90IGNyMjsKK307CisKICNlbHNl
CiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9yZWdpc3Rlci5oIGIvd2luc3VwL2N5Z3dp
bi9sb2NhbF9pbmNsdWRlcy9yZWdpc3Rlci5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMC4uMWRkZmUyZWMwCi0tLSAvZGV2L251bGwKKysrIGIvd2luc3VwL2N5Z3dpbi9sb2Nh
bF9pbmNsdWRlcy9yZWdpc3Rlci5oCkBAIC0wLDAgKzEsMjUgQEAKKy8qIERlZmluZSBtYWNyb3Mg
Zm9yIENQVS1hZ25vc3RpYyByZWdpc3RlciBhY2Nlc3MuICBUaGUgX0NYX2ZvbworICAgbWFjcm9z
IGFyZSBmb3IgYWNjZXNzIGludG8gQ09OVEVYVCwgdGhlIF9NQ19mb28gb25lcyBmb3IgYWNjZXNz
IGludG8KKyAgIG1jb250ZXh0LiBUaGUgaWRlYSBpcyB0byBhY2Nlc3MgdGhlIHJlZ2lzdGVycyBp
biB0ZXJtcyBvZiB0aGVpciBqb2IsCisgICBub3QgaW4gdGVybXMgb2YgdGhlaXIgbmFtZSBvbiB0
aGUgZ2l2ZW4gdGFyZ2V0LiAqLworI2lmIGRlZmluZWQoX194ODZfNjRfXykKKyNkZWZpbmUgX0NY
X2luc3RQdHIJUmlwCisjZGVmaW5lIF9DWF9zdGFja1B0cglSc3AKKyNkZWZpbmUgX0NYX2ZyYW1l
UHRyCVJicAorLyogRm9yIHNwZWNpYWwgcmVnaXN0ZXIgYWNjZXNzIGluc2lkZSBtY29udGV4dC4g
Ki8KKyNkZWZpbmUgX01DX3JldFJlZwlyYXgKKyNkZWZpbmUgX01DX2luc3RQdHIJcmlwCisjZGVm
aW5lIF9NQ19zdGFja1B0cglyc3AKKyNkZWZpbmUgX01DX3VjbGlua1JlZwlyYngJLyogTVVTVCBi
ZSBjYWxsZWUtc2F2ZWQgcmVnICovCisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorI2RlZmlu
ZSBfQ1hfaW5zdFB0cglQYworI2RlZmluZSBfQ1hfc3RhY2tQdHIJU3AKKyNkZWZpbmUgX0NYX2Zy
YW1lUHRyCUZwCisvKiBGb3Igc3BlY2lhbCByZWdpc3RlciBhY2Nlc3MgaW5zaWRlIG1jb250ZXh0
LiAqLworI2RlZmluZSBfTUNfcmV0UmVnCXgwCisjZGVmaW5lIF9NQ19pbnN0UHRyCXBjCisjZGVm
aW5lIF9NQ19zdGFja1B0cglzcAorI2RlZmluZSBfTUNfdWNsaW5rUmVnCXgxOQkvKiBNVVNUIGJl
IGNhbGxlZS1zYXZlZCByZWcgKi8KKyNlbHNlCisjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhp
cyB0YXJnZXQKKyNlbmRpZgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9wcm9maWwuYyBiL3dp
bnN1cC9jeWd3aW4vcHJvZmlsLmMKaW5kZXggMzBiMzcyNDRhLi45NTc4YWIxZGYgMTAwNjQ0Ci0t
LSBhL3dpbnN1cC9jeWd3aW4vcHJvZmlsLmMKKysrIGIvd2luc3VwL2N5Z3dpbi9wcm9maWwuYwpA
QCAtMjEsNiArMjEsNyBAQAogI2luY2x1ZGUgPGVycm5vLmg+CiAjaW5jbHVkZSA8cHRocmVhZC5o
PgogI2luY2x1ZGUgInByb2ZpbC5oIgorI2luY2x1ZGUgInJlZ2lzdGVyLmgiCiAKICNkZWZpbmUg
U0xFRVBUSU1FICgxMDAwIC8gUFJPRl9IWikKIApAQCAtNDIsMTEgKzQzLDcgQEAgZ2V0X3RocnBj
IChIQU5ETEUgdGhyKQogICBjdHguQ29udGV4dEZsYWdzID0gQ09OVEVYVF9DT05UUk9MIHwgQ09O
VEVYVF9JTlRFR0VSOwogICBwYyA9IChzaXplX3QpIC0gMTsKICAgaWYgKEdldFRocmVhZENvbnRl
eHQgKHRociwgJmN0eCkpIHsKLSNpZmRlZiBfX3g4Nl82NF9fCi0gICAgcGMgPSBjdHguUmlwOwot
I2Vsc2UKLSNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAotI2VuZGlmCisgICAg
cGMgPSBjdHguX0NYX2luc3RQdHI7CiAgIH0KICAgUmVzdW1lVGhyZWFkICh0aHIpOwogICByZXR1
cm4gcGM7CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3RocmVhZC5jYyBiL3dpbnN1cC9jeWd3
aW4vdGhyZWFkLmNjCmluZGV4IDUxMGUyYmU5My4uYjQ2MmUyZjlmIDEwMDY0NAotLS0gYS93aW5z
dXAvY3lnd2luL3RocmVhZC5jYworKysgYi93aW5zdXAvY3lnd2luL3RocmVhZC5jYwpAQCAtMzIs
NiArMzIsNyBAQCBkZXRhaWxzLiAqLwogI2luY2x1ZGUgIm50ZGxsLmgiCiAjaW5jbHVkZSAiY3ln
d2FpdC5oIgogI2luY2x1ZGUgImV4Y2VwdGlvbi5oIgorI2luY2x1ZGUgInJlZ2lzdGVyLmgiCiAK
IC8qIEZvciBMaW51eCBjb21wYXRpYmlsaXR5LCB0aGUgbGVuZ3RoIG9mIGEgdGhyZWFkIG5hbWUg
aXMgMTYgY2hhcmFjdGVycy4gKi8KICNkZWZpbmUgVEhSTkFNRUxFTiAxNgpAQCAtNjI5LDcgKzYz
MCw3IEBAIHB0aHJlYWQ6OmNhbmNlbCAoKQogICAgICAgdGhyZWFkbGlzdF90ICp0bF9lbnRyeSA9
IGN5Z2hlYXAtPmZpbmRfdGxzIChjeWd0bHMpOwogICAgICAgaWYgKCFjeWd0bHMtPmluc2lkZV9r
ZXJuZWwgKCZjb250ZXh0KSkKIAl7Ci0JICBjb250ZXh0LlJpcCA9IChVTE9OR19QVFIpIHB0aHJl
YWQ6OnN0YXRpY19jYW5jZWxfc2VsZjsKKwkgIGNvbnRleHQuX0NYX2luc3RQdHIgPSAoVUxPTkdf
UFRSKSBwdGhyZWFkOjpzdGF0aWNfY2FuY2VsX3NlbGY7CiAJICBTZXRUaHJlYWRDb250ZXh0ICh3
aW4zMl9vYmpfaWQsICZjb250ZXh0KTsKIAl9CiAgICAgICBjeWdoZWFwLT51bmxvY2tfdGxzICh0
bF9lbnRyeSk7CmRpZmYgLS1naXQgYS93aW5zdXAvdXRpbHMvcHJvZmlsZXIuY2MgYi93aW5zdXAv
dXRpbHMvcHJvZmlsZXIuY2MKaW5kZXggNGZlOTAwYjdmLi4wNGM2YjNlZDMgMTAwNjQ0Ci0tLSBh
L3dpbnN1cC91dGlscy9wcm9maWxlci5jYworKysgYi93aW5zdXAvdXRpbHMvcHJvZmlsZXIuY2MK
QEAgLTMzLDYgKzMzLDcgQEAgdHlwZWRlZiB1aW50MTZfdCB1X2ludDE2X3Q7IC8vIE5vbi1zdGFu
ZGFyZCBzaXplZCB0eXBlIG5lZWRlZCBieSBhbmNpZW50IGdtb24uaAogI2RlZmluZSBOT19HTE9C
QUxTX0gKICNpbmNsdWRlICJnbW9uLmgiCiAjaW5jbHVkZSAicGF0aC5oIgorI2luY2x1ZGUgInJl
Z2lzdGVyLmgiCiAKIC8qIFVuZG8gdGhpcyAjZGVmaW5lIGZyb20gd2luc3VwLmguICovCiAjaWZk
ZWYgRXhpdFRocmVhZApAQCAtMTkzLDExICsxOTQsNyBAQCBzYW1wbGUgKENPTlRFWFQgKmNvbnRl
eHQsIEhBTkRMRSBoKQogICAgICAgcmV0dXJuIDBVTEw7CiAgICAgfQogICBlbHNlCi0jaWZkZWYg
X194ODZfNjRfXwotICAgIHJldHVybiBjb250ZXh0LT5SaXA7Ci0jZWxzZQotI2Vycm9yIHVuaW1w
bGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0Ci0jZW5kaWYKKyAgICByZXR1cm4gY29udGV4dC0+X0NY
X2luc3RQdHI7CiB9CiAKIHZvaWQKLS0gCjIuNTAuMS52ZnMuMC4wCgo=

--_002_DB9PR83MB09236018A992CBC8F322F009924BADB9PR83MB0923EURP_--
