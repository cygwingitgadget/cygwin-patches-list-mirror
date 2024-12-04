Return-Path: <SRS0=Mvew=S5=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20721.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::721])
	by sourceware.org (Postfix) with ESMTPS id 5EF843858D20;
	Wed,  4 Dec 2024 12:41:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5EF843858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5EF843858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2612::721
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1733316076; cv=pass;
	b=G4uWsNwaAD48BhqLNn4yU74gRn8RW6YkKJ4T0qMbRM/JF5C+2Yn81K5mZwY0dyWTCT+lupzGUe0PPxw5yoN5EsHO316OLKowN5gXtgQ/lBpuWlT3wQtXEJXdLwGf8MYF30FpHTh/KOe+MdHlNE0KC7SptYdyrjg9kqsU45FDrbM=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733316076; c=relaxed/simple;
	bh=clDYRLnTL+f9YsBQmkEwSJ/m4dLtEsmL/9ZIwogI88U=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=nyfvQ9M4GUTHzusLFdmQYV/NC2QubTvAQDCURBcAaXGSsYUp/KOPyLnExDAQ1wT7DpgrT7096Ge5py9/SgZqTwLehmEWBfJBvvUoBELUMK8q3wbinCQdo4pRXm7AYECi6EEFld4S2n2vDYySJFkQEjCT5Lv7Ix8yHBhg0JCUR+M=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5EF843858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=fzaQCzY9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnsXqF4M0ygSp0KCTkstDwE79NsWVq8Y8uU6FtLBz4dHZY0WM9EzN8a0RlSVkGm0xLtJ00eTCFc7LmHYLAkAcBmFi8qLE+rKZyR6YqE1OKWu4ENoSoNWpmQheKenZT7bfnaDgb0PzAJXBXD9Ipv6Cmpb+7WJDL/ykw3ae92ww80UM+3A3PbGrFWSgYPDbZ6GwGiWkN4wSea6hd/Kv3sk+Ph1cCE/z/WB1BqdggNe79ia/hSMcUNAoXRI3sTzKSmWzO6y6U89TwnZSkl17WcZr190Aqo16RGvxd1LZws3VYQPidXWGmdxYi4jwCBWbEZBT+jFyZ5LYb1XsNgo7Juj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCIkVKAk265DMkyHoFoeN4JWbzT+DSt1uIG0dm6rqHI=;
 b=OS9PHKdRjV6pr49WOrkCr9jr6b583aK5Jz4N5f6/mRDrTn246pEhB3CDdO/acdhT4wbv/hx1R5QOyl/3FXh9kw1C8RRbRu0QHQynPaNNgwI7VM/VVdY533O9zhZUE6hq6icHyiK90T2l+HpWU3H2npXWaZOaQ6vulM0k/LIbHJlpxrnLFll9/LicGWkjKibnf18MbjgMlesXg5Gs1vfHJmHpVeenA1d7uF2ipOFdu8zS775trlEM6kcnORGp5R1umoBCiS/WRqOxJmdbp+573cZa0IjyGNzbmWMpAwM9X5jvUZqy9oqgpC0oi6OzaqPh6MBs9RwiWC+RIm1WhKTwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCIkVKAk265DMkyHoFoeN4JWbzT+DSt1uIG0dm6rqHI=;
 b=fzaQCzY9C85LEPtkWQ2UzxwqdvHBJRdD+xHqIsGbhEsSUCuNZmUPZhdwsKZfjdmFch6Wa44slvehN2XDc62u8sXVUhK5QD+muuP4e3CzZgyNFo/NhZavzPZhQySvUOkjJxTPmR5/jjHapNsEbIMwCSxNBEUbpuPJc7ATOil0o2k=
Received: from VI0PR83MB0738.EURPRD83.prod.outlook.com (2603:10a6:800:262::19)
 by GVXPR83MB0671.EURPRD83.prod.outlook.com (2603:10a6:150:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.6; Wed, 4 Dec
 2024 12:41:13 +0000
Received: from VI0PR83MB0738.EURPRD83.prod.outlook.com
 ([fe80::3f17:4911:4562:db4c]) by VI0PR83MB0738.EURPRD83.prod.outlook.com
 ([fe80::3f17:4911:4562:db4c%4]) with mapi id 15.20.8251.005; Wed, 4 Dec 2024
 12:41:13 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "corinna-cygwin@cygwin.com" <corinna-cygwin@cygwin.com>
Subject: Re: [EXTERNAL] Re: [PATCH] Fix compatibility with GCC 15
Thread-Topic: [EXTERNAL] Re: [PATCH] Fix compatibility with GCC 15
Thread-Index: AQHbRXboqi7weZFySUa9JYBqifBWgrLUk44AgAFzPx0=
Date: Wed, 4 Dec 2024 12:41:13 +0000
Message-ID:
 <VI0PR83MB07386AD9A5877C7D003527A292372@VI0PR83MB0738.EURPRD83.prod.outlook.com>
References:
 <VI0PR83MB0738D008CBD47680FAFCA78692362@VI0PR83MB0738.EURPRD83.prod.outlook.com>
 <Z08U6riwO_OA0hmk@calimero.vinschen.de>
In-Reply-To: <Z08U6riwO_OA0hmk@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-12-04T12:41:11.989Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR83MB0738:EE_|GVXPR83MB0671:EE_
x-ms-office365-filtering-correlation-id: d6c1ab82-53b6-4816-37bf-08dd1460eff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?hCCqapsXe+O02kbGVUMo9rFLGiVFmK3Lct5cys83yelpmF0KHymTGRVQDY?=
 =?iso-8859-2?Q?FNTKjsPOng5a8GRQEdJdTIlVXMWLz8aXkKuFoz7sbpuH+QW9+JtrjpaTTo?=
 =?iso-8859-2?Q?fuTHXT9OApJeVAbLgHXv9qGyIpuBTFmpZ7VFPFE4DG39Px3zLD9BvMekfG?=
 =?iso-8859-2?Q?PiCDzONDnRdw6tLTCiGeEDnu8UT9sO7/mnAMqDYPtTW8uwocoS3vQJPAx/?=
 =?iso-8859-2?Q?IETXsxacgveMfYpIfKqQLd500I+PcyGyEJyx4QADHSs/n/+x7xjbgUtYA5?=
 =?iso-8859-2?Q?HQcXx3FE/n/MC9MaKbq7zPg+WJv2MTkHNWLADtfmFyjTm7v4+hvCRZ2exW?=
 =?iso-8859-2?Q?0QSRm2MBFwvM9ZUieUeZre0qhcxVX11wqHxERWVCBz9A1JdR+zx8Xs8QGp?=
 =?iso-8859-2?Q?D3n6LJSE+8AukgcpNdCiXhAVCgKEDdmaV8+PUuTDLTaNR2on8MYycf+F1Q?=
 =?iso-8859-2?Q?rlamX+wIPJcgqMo+tOoDkqw+IpnCjaYmDMF5ElRv3Y0GTzUajz0EGR9E4P?=
 =?iso-8859-2?Q?tezuNdYvQpjtJZZdLEjQIodsJWU9h2cxut3TGC20SFYYWNxkwSdGWMm0XP?=
 =?iso-8859-2?Q?IW3bHhV4SQ7arVKN5lXHHTU5oeYk5ISyPuwgD8O5A9962plTIMcEkZ4RPj?=
 =?iso-8859-2?Q?t08zDjS1FKPI85t9cXNOu/lMjsqz5qquvnStns6vQvpLCCytl1YWpDSvuQ?=
 =?iso-8859-2?Q?JX6KN8s2VOUIra1VAje4Zk8HLwizv9wPk1VJf43ziVR5mkkoqXH7PdVqFB?=
 =?iso-8859-2?Q?R/ANLd0EGxO+Un2fUMDBihfmOpn6T497PNW2t3SMdCeUbbmJYq7FVBis1i?=
 =?iso-8859-2?Q?IoySrLpQfbzlb6U7LwV36dhxKLpLbuGqRAfnw+jnzDs5MgqYkR4bvlr6dd?=
 =?iso-8859-2?Q?eKEm0lJvZwhzDI5UoOQ831xnT4Le80TN9SrAciCLBhQ82yND2sTI/nywBU?=
 =?iso-8859-2?Q?acqj1onm+n95Fg9MAp33gLCK0PvdSSvtkvQAwcq35dz8sqRleUfys3BGN5?=
 =?iso-8859-2?Q?/jkjsXUwcQbly0U4GtwR/u+cKkXxWZhl1kM6J6J2FFQP3rOz2iJzvqL807?=
 =?iso-8859-2?Q?PN7s/i1SBK0ng5FKjZnCWnhbdh6hRigF5B3HXBBaWjBcxt0xq+iYULt9fd?=
 =?iso-8859-2?Q?exSqZ/tE442vfqJEdJKdOfcNTEkJFWk1b5280rxV9KrLH+J943p7md9Wiz?=
 =?iso-8859-2?Q?Umk5uyglU0gnk3HjMLS4av6zxpHoO3EutQi7Rlxj73sMciSGmSUdcaAClv?=
 =?iso-8859-2?Q?YWRkQhBtz25SsS/ytAmfIl/pV+clX7tfYdzX3eVh2OL1ns2x2A6/gkIqwa?=
 =?iso-8859-2?Q?s5mwZaGUQH1VBNUERP4On5eYi559NcOCZgBMv3BM9nAQdr6aSQu5AiQ2uG?=
 =?iso-8859-2?Q?du1dB1izduNu8yEzifPWLvBuIa6ytmW3EA+BW+hE70azOdF06cLJebO8il?=
 =?iso-8859-2?Q?Sp/MpONpnN0vqHy4gvuFD+PEASlybYmvG/gE+Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR83MB0738.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?tuN/B3Vibd/ohhNLLSdNovxDZx1t+SkydIfbfCv3h9DwuGJBd0TncHms3a?=
 =?iso-8859-2?Q?krOOBcYBNagEHDb7+F1H9zE+iBfshOypF0NA0s0rzVLPaTr0xp5++bikZ6?=
 =?iso-8859-2?Q?60zmw/a1Pke6ntPAxneJ8ZcnhkQfUjuj/yf4Vn8AcsLM0PaU8wCASIo33W?=
 =?iso-8859-2?Q?9Vipu719lUZH3xAdCA0lBossnMXtzVHDO4o+v6H3gacqD79fmJSxebeWb3?=
 =?iso-8859-2?Q?g9qotEEiVdsr01LVh5jjXF9YGISStBFmfpk6Ht8LX5CmNOy4BrX9rR0w4A?=
 =?iso-8859-2?Q?xDEHglZVIsViCgfVnjEXmN22YEopDIX2TCfFZopLKZlGwXwRr/zJb+7MAe?=
 =?iso-8859-2?Q?ke3sz09WuwcbK7DawPqujoGZYaC5lBrWiMObsDixUUinWLUuxalxlb8SEh?=
 =?iso-8859-2?Q?WwSZq0Eaf8i7eWS3w9nKRsR8nH/oatDBVD+R/jE8K8/dJ0/JT9PelIdaWF?=
 =?iso-8859-2?Q?+xC9J2xhzgGanT0P6V3XSEH2lom/kZ8hn0khjZeQl3koJQY7IkiLc1SeLd?=
 =?iso-8859-2?Q?WsuHq/HwmzA6Tg1NLVrlpPv7cc9yPGBdui0Eq6mZT0qFkpTEprcdf8j8bb?=
 =?iso-8859-2?Q?gfkKSEf5KGr99wTbGSe8aXfK0m+eaoW52RHE+qEZF0rF5OYnsLPTTVUprT?=
 =?iso-8859-2?Q?xc7OuOyRyLEz6fyp24tAwDJb2zkKcNFj4LHR/vGqHPjqcKROBX5V1U36It?=
 =?iso-8859-2?Q?5IGce6FeM2F5l2WOpSb3LdtsQtTjjtTnzp5m/1StXKdUG2LNP1AnHz5vmj?=
 =?iso-8859-2?Q?AqcYTXk4EN5W4coNTVyzA2pMpUTGxsCAWFXfhUQLj1XEIiXH0LYlEML0SA?=
 =?iso-8859-2?Q?sGf8uSAjS73x6O/VddpaLFwjWUGg+kye09Wg0v34+FXJ79hw2OUHnFSnks?=
 =?iso-8859-2?Q?zGJQcI8N3m5EhSGIS/akAaVGa3ve2Euz2KU8rM+bIfDl5yC9bCiXAf4DwM?=
 =?iso-8859-2?Q?W1AZkQbnNJcXsCv/GWbaT4DIWnncbbkZGEGEeh+Sx26rT6QrlSkmWwIiY9?=
 =?iso-8859-2?Q?GeIgc9CDZRzNsq35CI2nJ1yEz0exhWzfnG/RAUQHZyDDhqt88MNjytmeLV?=
 =?iso-8859-2?Q?9uveV2gR8CJk0OFADnkE/XVFCgG9s8GKbG72hGd8kMPBJh3Uf+71b/ELWJ?=
 =?iso-8859-2?Q?8VXTu076DcjcRYNhT92/keLEK7F0av2uoMbGGJhmxfUbqNnfOlR78TaeDW?=
 =?iso-8859-2?Q?XaSY6Yivz45F13qMQv4VB7gaTYEW3izRzMb4Ye/9CgOh6STSmARlEszvw0?=
 =?iso-8859-2?Q?WgdSg3kswzKK8zall7BM8P6WhE3ifjYrcM6RMQX2TQxP6ahHM9SgTf0xJi?=
 =?iso-8859-2?Q?WtGFGIn3/Fyu8P+GbpH1vrHMSUeh3EUeqEhDWQ6ue6JIV7iTUfDUj0N157?=
 =?iso-8859-2?Q?zFSob6ON1jCPoo4O2jpEBZX6XpxycTaalCVZEk9J51BcmLnx2zUUSfIf4Y?=
 =?iso-8859-2?Q?65rKCSFPINHI5CUpOtlBAbVTdaWHMcYX8TlMIVBmam/Ke4gzuIYj8wSj0c?=
 =?iso-8859-2?Q?7gH5ifAoYxVdJeHrMvJS7Qv9+OWeAEQ/uFEbpMP0NCn08OBRMIZGycUNDe?=
 =?iso-8859-2?Q?NpAsJ76SsGQHN0IRo1wPamKGJ7a7?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR83MB0738.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c1ab82-53b6-4816-37bf-08dd1460eff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 12:41:13.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAaKdae9u+WiFbw2LkOUDmewig5/groRqNPZXxYdQsgSqYcZUS602qQyScCamByGfyvtGV/PJtcDAYCXvl84c9K0pD7YrtHqRkD303EqSCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0671
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,KAM_NUMSUBJECT,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello, Corinna.=0A=
=0A=
Unfortunately I cannot send the patch using `git send-mail` using my work a=
ddress for technical reasons. What I can do is to send a plain text message=
 with the output of `git format-patch --signoff -1 HEAD` pasted.=0A=
=0A=
Radek=0A=
---=0A=
From 350574ff2de5ffeb627d60a83120e3594abc77f7 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Wed, 4 Dec 2024 12:33:23 +0100=0A=
Subject: [PATCH] Cygwin: Fix compatibility with GCC 15=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/libc/fts.c                      |  3 +-=0A=
 winsup/cygwin/libc/inet_network.c             |  3 +-=0A=
 winsup/testsuite/libltp/include/test.h        |  2 +-=0A=
 winsup/testsuite/libltp/include/usctest.h     |  2 +-=0A=
 winsup/testsuite/libltp/include/write_log.h   |  2 +-=0A=
 winsup/testsuite/libltp/lib/dataascii.c       | 24 +++++-----=0A=
 winsup/testsuite/libltp/lib/databin.c         | 24 +++++-----=0A=
 winsup/testsuite/libltp/lib/datapid.c         | 24 +++++-----=0A=
 winsup/testsuite/libltp/lib/forker.c          | 16 +++----=0A=
 winsup/testsuite/libltp/lib/parse_opts.c      | 20 ++++----=0A=
 winsup/testsuite/libltp/lib/pattern.c         | 26 +++++-----=0A=
 winsup/testsuite/libltp/lib/search_path.c     | 11 +++--=0A=
 winsup/testsuite/libltp/lib/str_to_bytes.c    |  9 ++--=0A=
 .../testsuite/libltp/lib/string_to_tokens.c   |  2 +-=0A=
 winsup/testsuite/libltp/lib/tst_res.c         |  2 -=0A=
 winsup/testsuite/libltp/lib/tst_sig.c         |  4 +-=0A=
 winsup/testsuite/libltp/lib/write_log.c       | 48 ++++++++++---------=0A=
 17 files changed, 116 insertions(+), 106 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/libc/fts.c b/winsup/cygwin/libc/fts.c=0A=
index 1826d2213..6f060e54e 100644=0A=
--- a/winsup/cygwin/libc/fts.c=0A=
+++ b/winsup/cygwin/libc/fts.c=0A=
@@ -1111,8 +1111,7 @@ fts_padjust(FTS *sp, FTSENT *head)=0A=
 }=0A=
 =0A=
 static size_t=0A=
-fts_maxarglen(argv)=0A=
-	char * const *argv;=0A=
+fts_maxarglen(char * const *argv)=0A=
 {=0A=
 	size_t len, max;=0A=
 =0A=
diff --git a/winsup/cygwin/libc/inet_network.c b/winsup/cygwin/libc/inet_ne=
twork.c=0A=
index 43a394cf4..17b61f7aa 100644=0A=
--- a/winsup/cygwin/libc/inet_network.c=0A=
+++ b/winsup/cygwin/libc/inet_network.c=0A=
@@ -56,8 +56,7 @@ __FBSDID("$FreeBSD$");=0A=
  * network numbers.=0A=
  */=0A=
 in_addr_t=0A=
-cygwin_inet_network(cp)=0A=
-	const char *cp;=0A=
+cygwin_inet_network(const char *cp)=0A=
 {=0A=
 	in_addr_t val, base, n;=0A=
 	char c;=0A=
diff --git a/winsup/testsuite/libltp/include/test.h b/winsup/testsuite/libl=
tp/include/test.h=0A=
index 757f3b8a1..af7c3c0c8 100644=0A=
--- a/winsup/testsuite/libltp/include/test.h=0A=
+++ b/winsup/testsuite/libltp/include/test.h=0A=
@@ -225,7 +225,7 @@ extern void tt_exit();=0A=
 extern int  t_environ();=0A=
 extern void t_breakum(char *tcid, int total, int typ, char *msg, void (*fn=
c)());=0A=
 =0A=
-extern void tst_sig(int fork_flag, void (*handler)(), void (*cleanup)());=
=0A=
+extern void tst_sig(int fork_flag, void (*handler)(int), void (*cleanup)()=
);=0A=
 extern void tst_tmpdir();=0A=
 extern void tst_rmdir();=0A=
 =0A=
diff --git a/winsup/testsuite/libltp/include/usctest.h b/winsup/testsuite/l=
ibltp/include/usctest.h=0A=
index 637635a25..08db49551 100644=0A=
--- a/winsup/testsuite/libltp/include/usctest.h=0A=
+++ b/winsup/testsuite/libltp/include/usctest.h=0A=
@@ -198,7 +198,7 @@ struct tblock {=0A=
  * in the macros that follow.=0A=
  ***********************************************************************/=
=0A=
 extern struct tblock tblock;=0A=
-extern void STD_go();=0A=
+extern void STD_go(int);=0A=
 extern int (*_TMP_FUNC)(void);=0A=
 extern void STD_opts_help();=0A=
 =0A=
diff --git a/winsup/testsuite/libltp/include/write_log.h b/winsup/testsuite=
/libltp/include/write_log.h=0A=
index 784d5b3eb..505d2c08a 100644=0A=
--- a/winsup/testsuite/libltp/include/write_log.h=0A=
+++ b/winsup/testsuite/libltp/include/write_log.h=0A=
@@ -154,7 +154,7 @@ extern int	wlog_close(struct wlog_file *wfile);=0A=
 extern int	wlog_record_write(struct wlog_file *wfile,=0A=
 				  struct wlog_rec *wrec, long offset);=0A=
 extern int	wlog_scan_backward(struct wlog_file *wfile, int nrecs,=0A=
-				   int (*func)(struct wlog_rec *rec),=0A=
+				   int (*func)(struct wlog_rec *rec, long),=0A=
 				   long data);=0A=
 #else=0A=
 int	wlog_open();=0A=
diff --git a/winsup/testsuite/libltp/lib/dataascii.c b/winsup/testsuite/lib=
ltp/lib/dataascii.c=0A=
index 5bc201852..41ed440c0 100644=0A=
--- a/winsup/testsuite/libltp/lib/dataascii.c=0A=
+++ b/winsup/testsuite/libltp/lib/dataascii.c=0A=
@@ -43,11 +43,12 @@=0A=
 static char Errmsg[80];=0A=
 =0A=
 int=0A=
-dataasciigen(listofchars, buffer, bsize, offset)=0A=
-char *listofchars;	/* a null terminated list of characters */=0A=
-char *buffer;=0A=
-int bsize;=0A=
-int offset;=0A=
+dataasciigen(=0A=
+	char *listofchars,	/* a null terminated list of characters */=0A=
+	char *buffer,=0A=
+	int bsize,=0A=
+	int offset=0A=
+)=0A=
 {=0A=
    int cnt;=0A=
    int total;=0A=
@@ -78,12 +79,13 @@ int offset;=0A=
 }	/* end of dataasciigen */=0A=
 =0A=
 int=0A=
-dataasciichk(listofchars, buffer, bsize, offset, errmsg)=0A=
-char *listofchars;	/* a null terminated list of characters */=0A=
-char *buffer;=0A=
-int bsize;=0A=
-int offset;=0A=
-char **errmsg;=0A=
+dataasciichk(=0A=
+	char *listofchars,	/* a null terminated list of characters */=0A=
+	char *buffer,=0A=
+	int bsize,=0A=
+	int offset,=0A=
+	char **errmsg=0A=
+)=0A=
 {=0A=
    int cnt;=0A=
    int total;=0A=
diff --git a/winsup/testsuite/libltp/lib/databin.c b/winsup/testsuite/liblt=
p/lib/databin.c=0A=
index e43fef4e4..6cf27f77c 100644=0A=
--- a/winsup/testsuite/libltp/lib/databin.c=0A=
+++ b/winsup/testsuite/libltp/lib/databin.c=0A=
@@ -42,11 +42,12 @@=0A=
 static char Errmsg[80];=0A=
 =0A=
 void=0A=
-databingen (mode, buffer, bsize, offset)=0A=
-int mode;	/* either a, c, r, o, z or C */=0A=
-unsigned char *buffer;	/* buffer pointer */=0A=
-int bsize;	/* size of buffer */=0A=
-int offset;	/* offset into the file where buffer starts */=0A=
+databingen (=0A=
+    int mode,	/* either a, c, r, o, z or C */=0A=
+    unsigned char *buffer,	/* buffer pointer */=0A=
+    int bsize,	/* size of buffer */=0A=
+    int offset	/* offset into the file where buffer starts */=0A=
+)=0A=
 {=0A=
 int ind;=0A=
 =0A=
@@ -89,12 +90,13 @@ int ind;=0A=
  *      < 0  : no error=0A=
  ***********************************************************************/=
=0A=
 int=0A=
-databinchk(mode, buffer, bsize, offset, errmsg)=0A=
-int mode;	/* either a, c, r, z, o, or C */=0A=
-unsigned char *buffer;	/* buffer pointer */=0A=
-int bsize;	/* size of buffer */=0A=
-int offset;	/* offset into the file where buffer starts */=0A=
-char **errmsg;=0A=
+databinchk(=0A=
+    int mode,	/* either a, c, r, z, o, or C */=0A=
+    unsigned char *buffer,	/* buffer pointer */=0A=
+    int bsize,	/* size of buffer */=0A=
+    int offset,	/* offset into the file where buffer starts */=0A=
+    char **errmsg=0A=
+)=0A=
 {=0A=
     int cnt;=0A=
     unsigned char *chr;=0A=
diff --git a/winsup/testsuite/libltp/lib/datapid.c b/winsup/testsuite/liblt=
p/lib/datapid.c=0A=
index 9414eae90..ca091311b 100644=0A=
--- a/winsup/testsuite/libltp/lib/datapid.c=0A=
+++ b/winsup/testsuite/libltp/lib/datapid.c=0A=
@@ -83,11 +83,12 @@ static char Errmsg[80];=0A=
  * Thus, offset 8 is in middle of word 1=0A=
  ***********************************************************************/=
=0A=
 int=0A=
-datapidgen(pid, buffer, bsize, offset)=0A=
-int pid;=0A=
-char *buffer;=0A=
-int bsize;=0A=
-int offset;=0A=
+datapidgen(=0A=
+    int pid,=0A=
+    char *buffer,=0A=
+    int bsize,=0A=
+    int offset=0A=
+)=0A=
 {=0A=
 #if CRAY=0A=
 	=0A=
@@ -178,12 +179,13 @@ printf("partial at end\n");=0A=
  *=0A=
  ***********************************************************************/=
=0A=
 int=0A=
-datapidchk(pid, buffer, bsize, offset, errmsg)=0A=
-int pid;=0A=
-char *buffer;=0A=
-int bsize;=0A=
-int offset;=0A=
-char **errmsg;=0A=
+datapidchk(=0A=
+    int pid,=0A=
+    char *buffer,=0A=
+    int bsize,=0A=
+    int offset,=0A=
+    char **errmsg=0A=
+)=0A=
 {=0A=
 #if CRAY=0A=
 	=0A=
diff --git a/winsup/testsuite/libltp/lib/forker.c b/winsup/testsuite/libltp=
/lib/forker.c=0A=
index 99bc58550..65f1036a3 100644=0A=
--- a/winsup/testsuite/libltp/lib/forker.c=0A=
+++ b/winsup/testsuite/libltp/lib/forker.c=0A=
@@ -133,8 +133,7 @@ int Forker_npids=3D0;             /* number of entries =
in Forker_pids */=0A=
  *  !0 : if fork failed, the return value will be the errno.=0A=
  ***********************************************************************/=
=0A=
 int=0A=
-background(prefix)=0A=
-char *prefix;=0A=
+background(char *prefix)=0A=
 {=0A=
   switch (fork()) {=0A=
   case -1:=0A=
@@ -159,12 +158,13 @@ char *prefix;=0A=
  * =0A=
  ***********************************************************************/=
=0A=
 int=0A=
-forker(ncopies, mode, prefix)=0A=
-int ncopies;=0A=
-int mode;	/* 0 - all childern of parent, 1 - only 1 direct child */=0A=
-char *prefix;   /* if ! NULL, an message will be printed to stderr */=0A=
-		/* if fork fails.  The prefix (program name) will */=0A=
-	        /* preceed the message */=0A=
+forker(=0A=
+	int ncopies,=0A=
+	int mode,		/* 0 - all childern of parent, 1 - only 1 direct child */=0A=
+	char *prefix	/* if ! NULL, an message will be printed to stderr */=0A=
+					/* if fork fails.  The prefix (program name) will */=0A=
+					/* preceed the message */=0A=
+)=0A=
 {=0A=
     int cnt;=0A=
     int pid;=0A=
diff --git a/winsup/testsuite/libltp/lib/parse_opts.c b/winsup/testsuite/li=
bltp/lib/parse_opts.c=0A=
index 1f41bfdd2..0d1b80247 100644=0A=
--- a/winsup/testsuite/libltp/lib/parse_opts.c=0A=
+++ b/winsup/testsuite/libltp/lib/parse_opts.c=0A=
@@ -198,7 +198,11 @@ int STD_ERRNO_LIST[USC_MAX_ERRNO];=0A=
 #define STRLEN 2048=0A=
 =0A=
 static char Mesg2[STRLEN];	/* holds possible return string */=0A=
-static void usc_recressive_func();=0A=
+static void usc_recressive_func(=0A=
+	int cnt,=0A=
+	int max,=0A=
+	struct usc_bigstack_t **bstack=0A=
+);=0A=
 =0A=
 /*=0A=
  * Define bits for options that might have env variable default=0A=
@@ -633,7 +637,7 @@ usc_global_setup_hook()=0A=
     if ( STD_PAUSE ) {                                      =0A=
         _TMP_FUNC =3D (int (*)())signal(SIGUSR1, STD_go);   =0A=
         pause();                                          =0A=
-        signal(SIGUSR1, (void (*)())_TMP_FUNC);          =0A=
+        signal(SIGUSR1, (_sig_func_ptr)_TMP_FUNC);          =0A=
     }=0A=
 =0A=
 =0A=
@@ -693,8 +697,7 @@ get_current_time()=0A=
  * counter integer is supplied by the user program.=0A=
  ***********************************************************************/=
=0A=
 int=0A=
-usc_test_looping(counter)=0A=
-int counter;=0A=
+usc_test_looping(int counter)=0A=
 {=0A=
     static int first_time =3D 1;=0A=
     static int stop_time =3D 0;	/* stop time in rtc or usecs */=0A=
@@ -803,10 +806,11 @@ int counter;=0A=
  * This function recressively calls itself max times.=0A=
  */ =0A=
 static void=0A=
-usc_recressive_func(cnt, max, bstack)=0A=
-int cnt;=0A=
-int max;=0A=
-struct usc_bigstack_t bstack;=0A=
+usc_recressive_func(=0A=
+    int cnt,=0A=
+    int max,=0A=
+    struct usc_bigstack_t **bstack=0A=
+)=0A=
 {=0A=
     if ( cnt < max )=0A=
 	usc_recressive_func(cnt+1, max, bstack);=0A=
diff --git a/winsup/testsuite/libltp/lib/pattern.c b/winsup/testsuite/liblt=
p/lib/pattern.c=0A=
index 7f4d5873e..5a88bfd3b 100644=0A=
--- a/winsup/testsuite/libltp/lib/pattern.c=0A=
+++ b/winsup/testsuite/libltp/lib/pattern.c=0A=
@@ -38,12 +38,13 @@=0A=
  */=0A=
 =0A=
 int=0A=
-pattern_check(buf, buflen, pat, patlen, patshift)=0A=
-char	*buf;=0A=
-int	buflen;=0A=
-char	*pat;=0A=
-int	patlen;=0A=
-int	patshift;=0A=
+pattern_check(=0A=
+	char *buf,=0A=
+	int	buflen,=0A=
+	char *pat,=0A=
+	int	patlen,=0A=
+	int	patshift=0A=
+)=0A=
 {=0A=
     int		nb, ncmp, nleft;=0A=
     char	*cp;=0A=
@@ -105,12 +106,13 @@ int	patshift;=0A=
 }=0A=
 =0A=
 int=0A=
-pattern_fill(buf, buflen, pat, patlen, patshift)=0A=
-char	*buf;=0A=
-int	buflen;=0A=
-char	*pat;=0A=
-int	patlen;=0A=
-int	patshift;=0A=
+pattern_fill(=0A=
+	char *buf,=0A=
+	int	buflen,=0A=
+	char *pat,=0A=
+	int	patlen,=0A=
+	int	patshift=0A=
+)=0A=
 {=0A=
     int		trans, ncopied, nleft;=0A=
     char	*cp;=0A=
diff --git a/winsup/testsuite/libltp/lib/search_path.c b/winsup/testsuite/l=
ibltp/lib/search_path.c=0A=
index 697b4037b..f6936094a 100644=0A=
--- a/winsup/testsuite/libltp/lib/search_path.c=0A=
+++ b/winsup/testsuite/libltp/lib/search_path.c=0A=
@@ -103,11 +103,12 @@ char **argv;=0A=
 /*=0A=
  */=0A=
 int=0A=
-search_path(cmd, res_path, access_mode, fullpath)=0A=
-const char *cmd;	/* The requested filename */=0A=
-char *res_path; /* The resulting path or error mesg */=0A=
-int access_mode; /* the mode used by access(2) */=0A=
-int fullpath;	/* if set, cwd will be prepended to all non-full paths */=0A=
+search_path(=0A=
+	const char *cmd,	/* The requested filename */=0A=
+	char *res_path,		/* The resulting path or error mesg */=0A=
+	int access_mode,	/* the mode used by access(2) */=0A=
+	int fullpath		/* if set, cwd will be prepended to all non-full paths */=
=0A=
+)=0A=
 {=0A=
     char *cp;   /* used to scan PATH for directories */=0A=
     int ret;      /* return value from access */=0A=
diff --git a/winsup/testsuite/libltp/lib/str_to_bytes.c b/winsup/testsuite/=
libltp/lib/str_to_bytes.c=0A=
index beecb71b6..70157dcde 100644=0A=
--- a/winsup/testsuite/libltp/lib/str_to_bytes.c=0A=
+++ b/winsup/testsuite/libltp/lib/str_to_bytes.c=0A=
@@ -75,8 +75,7 @@=0A=
 #define T_MULT	1099511627776	/* tera or 2^40 */=0A=
 =0A=
 int=0A=
-str_to_bytes(s)=0A=
-char    *s;=0A=
+str_to_bytes(char *s)=0A=
 {=0A=
     char    mult, junk;=0A=
     int	    nconv;=0A=
@@ -110,8 +109,7 @@ char    *s;=0A=
 }=0A=
 =0A=
 long=0A=
-str_to_lbytes(s)=0A=
-char    *s;=0A=
+str_to_lbytes(char *s)=0A=
 {=0A=
     char    mult, junk;=0A=
     long    nconv;=0A=
@@ -150,8 +148,7 @@ char    *s;=0A=
  */=0A=
 =0A=
 long long=0A=
-str_to_llbytes(s)=0A=
-char    *s;=0A=
+str_to_llbytes(char *s)=0A=
 {=0A=
     char    mult, junk;=0A=
     long    nconv;=0A=
diff --git a/winsup/testsuite/libltp/lib/string_to_tokens.c b/winsup/testsu=
ite/libltp/lib/string_to_tokens.c=0A=
index 6f0d775dd..a2b3a7617 100644=0A=
--- a/winsup/testsuite/libltp/lib/string_to_tokens.c=0A=
+++ b/winsup/testsuite/libltp/lib/string_to_tokens.c=0A=
@@ -80,7 +80,7 @@ int=0A=
 string_to_tokens(char *arg_string, char *arg_array[], int array_size, char=
 *separator)=0A=
 {=0A=
    int num_toks =3D 0;  /* number of tokens found */=0A=
-   char *strtok();=0A=
+   char *strtok(char *, const char *);=0A=
 	=0A=
    if ( arg_array =3D=3D NULL || array_size <=3D 1 || separator =3D=3D NUL=
L )=0A=
 	return -1;=0A=
diff --git a/winsup/testsuite/libltp/lib/tst_res.c b/winsup/testsuite/liblt=
p/lib/tst_res.c=0A=
index 99767ec9b..731dcbc1b 100644=0A=
--- a/winsup/testsuite/libltp/lib/tst_res.c=0A=
+++ b/winsup/testsuite/libltp/lib/tst_res.c=0A=
@@ -563,8 +563,6 @@ tst_exit()=0A=
 int=0A=
 tst_environ()=0A=
 {=0A=
-   FILE *fdopen();=0A=
-=0A=
    if ( (T_out =3D fdopen(dup(fileno(stdout)), "w")) =3D=3D NULL )=0A=
       return(-1);=0A=
    else=0A=
diff --git a/winsup/testsuite/libltp/lib/tst_sig.c b/winsup/testsuite/liblt=
p/lib/tst_sig.c=0A=
index f5b64b666..976b5eecb 100644=0A=
--- a/winsup/testsuite/libltp/lib/tst_sig.c=0A=
+++ b/winsup/testsuite/libltp/lib/tst_sig.c=0A=
@@ -81,7 +81,7 @@=0A=
 void (*T_cleanup)();		/* pointer to cleanup function */=0A=
 =0A=
 extern int errno;=0A=
-static void def_handler();		/* default signal handler */=0A=
+static void def_handler(int);		/* default signal handler */=0A=
 =0A=
 /*************************************************************************=
***=0A=
  * tst_sig() : set-up to catch unexpected signals.  fork_flag is set to NO=
FORK=0A=
@@ -93,7 +93,7 @@ static void def_handler();		/* default signal handler */=
=0A=
  *************************************************************************=
**/=0A=
 =0A=
 void=0A=
-tst_sig(int fork_flag, void (*handler)(), void (*cleanup)())=0A=
+tst_sig(int fork_flag, void (*handler)(int), void (*cleanup)())=0A=
 {=0A=
 	char mesg[MAXMESG];		/* message buffer for tst_res */=0A=
 	int sig;=0A=
diff --git a/winsup/testsuite/libltp/lib/write_log.c b/winsup/testsuite/lib=
ltp/lib/write_log.c=0A=
index 8104b05ac..bfbf6adfa 100644=0A=
--- a/winsup/testsuite/libltp/lib/write_log.c=0A=
+++ b/winsup/testsuite/libltp/lib/write_log.c=0A=
@@ -115,10 +115,11 @@ static int	wlog_rec_unpack();=0A=
  */=0A=
 =0A=
 int=0A=
-wlog_open(wfile, trunc, mode)=0A=
-struct wlog_file	*wfile;=0A=
-int			trunc;=0A=
-int			mode;=0A=
+wlog_open(=0A=
+	struct wlog_file *wfile,=0A=
+	int trunc,=0A=
+	int mode=0A=
+)=0A=
 {=0A=
 	int	omask, oflags;=0A=
 =0A=
@@ -166,8 +167,7 @@ int			mode;=0A=
  */=0A=
 =0A=
 int=0A=
-wlog_close(wfile)=0A=
-struct wlog_file	*wfile;=0A=
+wlog_close(struct wlog_file *wfile)=0A=
 {=0A=
 	close(wfile->w_afd);=0A=
 	close(wfile->w_rfd);=0A=
@@ -201,10 +201,11 @@ struct wlog_file	*wfile;=0A=
  */=0A=
 =0A=
 int=0A=
-wlog_record_write(wfile, wrec, offset)=0A=
-struct wlog_file	*wfile;=0A=
-struct wlog_rec		*wrec;=0A=
-long			offset;=0A=
+wlog_record_write(=0A=
+	struct wlog_file *wfile,=0A=
+	struct wlog_rec *wrec,=0A=
+	long offset=0A=
+)=0A=
 {=0A=
     int		reclen;=0A=
     char	wbuf[WLOG_REC_MAX_SIZE + 2];=0A=
@@ -249,11 +250,12 @@ long			offset;=0A=
  */=0A=
 =0A=
 int=0A=
-wlog_scan_backward(wfile, nrecs, func, data)=0A=
-struct wlog_file	*wfile;=0A=
-int 			nrecs;=0A=
-int 			(*func)();=0A=
-long			data;=0A=
+wlog_scan_backward(=0A=
+	struct wlog_file *wfile,=0A=
+	int nrecs,=0A=
+	int (*func)(struct wlog_rec*, long),=0A=
+	long data=0A=
+)=0A=
 {=0A=
 	int		fd, leftover, nbytes, recnum, reclen, rval;=0A=
 	off_t		offset;=0A=
@@ -381,10 +383,11 @@ long			data;=0A=
  */=0A=
 =0A=
 static int=0A=
-wlog_rec_pack(wrec, buf, flag)=0A=
-struct wlog_rec	*wrec;=0A=
-char		*buf;=0A=
-int             flag;=0A=
+wlog_rec_pack(=0A=
+	struct wlog_rec	*wrec,=0A=
+	char *buf,=0A=
+	int flag=0A=
+)=0A=
 {=0A=
 	char			*file, *host, *pattern;=0A=
 	struct wlog_rec_disk	*wrecd;=0A=
@@ -430,9 +433,10 @@ int             flag;=0A=
 }=0A=
 =0A=
 static int=0A=
-wlog_rec_unpack(wrec, buf)=0A=
-struct wlog_rec	*wrec;=0A=
-char		*buf;=0A=
+wlog_rec_unpack(=0A=
+	struct wlog_rec *wrec,=0A=
+	char *buf=0A=
+)=0A=
 {=0A=
 	char			*file, *host, *pattern;=0A=
 	struct wlog_rec_disk	*wrecd;=0A=
-- =0A=
2.34.1=0A=
