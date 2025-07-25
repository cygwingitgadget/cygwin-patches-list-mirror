Return-Path: <SRS0=+QaW=2G=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on20729.outbound.protection.outlook.com [IPv6:2a01:111:f403:260c::729])
	by sourceware.org (Postfix) with ESMTPS id D15033858D33
	for <cygwin-patches@cygwin.com>; Fri, 25 Jul 2025 21:40:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D15033858D33
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D15033858D33
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260c::729
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753479648; cv=pass;
	b=IW9j1ZPcYj5dPegPaO+UI9Y8ZIiuweAqC3D5Q25UkkeFoc8ZsuM9cKyslUytn7m5roe8x7FXH1C0qIbIJrhEZlm90X5zxxMhY9b8HOhGZmDKE32UuxnY1iDZ64FTeRyJ/sPf58UTlX+qC+WniHxZq7u5KesqSXHwQv/8zPCn8tQ=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753479648; c=relaxed/simple;
	bh=qja46GR2wdULIFS1Rr/smg+bvnlbD/Jivo36O3cdAkY=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=KyNgFWcHSSGT3rgGjwOZ4vCBGOMqM9o/L+0pOFk7VhZfJXjxfHvxMeQTwEv60lLH4E7wFd4aZEXjT9fiB3OyZiFWM0JiA1RKUI+NnchsW2rvFA2h0mw81dcrjgPXTM24n5cHeRw3H2SjavVIiTrhCdUpD5MNI0SlhWvjLAKK1vE=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D15033858D33
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=HpyU/L1J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRj9F/bSwLQ304CuRDGNrwkzk+YNN3pUgwyFxHOEv7pPNwE/maWbllIBI3X859vsOtlSxrNoVF1gYQazthzUvHt4OBjQVPaslT59YJcxsAMGzy8sWzKFiAUfku/yBBB6XERlHycy72A3xdQqW86RyZ1/firhs829MII9EkAH+BH6RVWYSWYHK1lGSEhWMMQmfJ9GA+TnafMYXjpxfES7vl/pkDXU9akL2rKYCllaOoX33Djl/PeGQPBqhQyZtWVHX57+jqU1C2Czb8jt1xsxeXwgpatIOeqO5ubj0bvZ5bU04rvsIGjBDHkCfPqr+1kCyztoIJGaiOjE5d3XMIMgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqp2ZbH+UF16zQdy7pHPeOIDr5r6+osdUX0qRkqAYeo=;
 b=VQrynubfrnKyGYmnx9ytd72UXoVNFuxj60JmgPTaVaC8GdYRDwBy6gp8gYC5AyfVoh0f+4CTNrYfIiMudPAx3rz0PoiB1LtmBDW5E6eBetx824AVQgUvuMkUS5Mm+Vx/g7PXo1K52+GTfMYGAHqJhJsggivf5jwrzR7ZI7+PdhBnAK1VFx79nofXQ78JWDbfwdIvmKmAN3mar6002mnAwalLicN8+lERXMqFxlJX2A9w8h9GtXphk50BxKzVAdQ/nitXQHEq0zF27r+DwBJuMto0GlfMvgw0L/cIOXDnI3RuYIGJ1NYoVMeQZX8zqtitxAUtMYsY8YGK8ZlSARONag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqp2ZbH+UF16zQdy7pHPeOIDr5r6+osdUX0qRkqAYeo=;
 b=HpyU/L1JdHxTIfT00Z66/3aYoTefUQ1lydeMgvSL+NPxgkSyWbJNDrJX0fLA4L/OdK54dOQ6g7MWM/UY0yX2A0VxcyuMBFfj92qZ+m7bxypXRLGmnACQbmWVtVgFd6lOFoRZfMZ5ypT/vPUXadbroUMuZcudeOFuZssVNhyqVqE=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by VI2PR83MB0765.EURPRD83.prod.outlook.com (2603:10a6:800:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.4; Fri, 25 Jul
 2025 21:40:42 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e%4]) with mapi id 15.20.8989.006; Fri, 25 Jul 2025
 21:40:40 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "jon.turney@dronecode.org.uk" <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: configure: allow zero-level bootstrapping cross-build
 with --without-cross-bootstrap (and cross-testing without)
Thread-Topic: [PATCH] Cygwin: configure: allow zero-level bootstrapping
 cross-build with --without-cross-bootstrap (and cross-testing without)
Thread-Index: AQHb/arggd0ZEeWkrUWYhSoP7pjQJg==
Date: Fri, 25 Jul 2025 21:40:40 +0000
Message-ID:
 <DB9PR83MB0923F85A909F2724ED5328239259A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-25T21:40:39.549Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|VI2PR83MB0765:EE_
x-ms-office365-filtering-correlation-id: 6ef8fd77-caab-4b37-e33a-08ddcbc3e6d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|13003099007|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?42zW8UkCK8yMYUvJq/T9kL/dLIEWwBzYbLkjeZ3qLBFOPuTO08ss0l0e3N?=
 =?iso-8859-2?Q?3j94syaGqViKFkiL7YRijVD/GIwLgUoP8AJE3cjk/+lGuX+3aNBPteqRuZ?=
 =?iso-8859-2?Q?EdWIjtrZW62/XZ3QtAZ2MkAz84HQbUjeRqKbx5MC9lwjRFu+8H7tZ/oHN7?=
 =?iso-8859-2?Q?5iU9h0TC+6GXMwo+Y2X6BLngqsAp8rwPsL60M2+j4JVd8suvz70X2d8QaG?=
 =?iso-8859-2?Q?6y5+42bc7cPQJtwKEgLJr5MRxgcDhiH8Kjk8vBQqpvmc1WLDwN5oc9gF2p?=
 =?iso-8859-2?Q?TRs3q4dWQ4tSNRS2ZIouow58U977Q0IOtJUrRBMd96CToqbx8qvmeaeWWZ?=
 =?iso-8859-2?Q?/YMdSwOBI+cVVvzQnoc/LA4ZifJ2LdbpNH5yUAYAz/Jx+iqQ0v3PI8yIcg?=
 =?iso-8859-2?Q?WNBZpDo2gIEAWkuxXmSQBVgLsrdYSrHhmdEbjd4fng4TemFCUDEzSDHXoS?=
 =?iso-8859-2?Q?YBAzdzrCF7+PRFtCFLvbeSQVYUGjoO2uv3PQu1tqh/G4cyvt9EVgJYN8Ww?=
 =?iso-8859-2?Q?/BxkxkSGqEsWQbYPBO9rslQWP94rWAQn/XoSMU12XNG6xap8ioIh9nuo/l?=
 =?iso-8859-2?Q?cC1qhyW6Nve+N91CQHwV68qKc9p6d+GfegGkjmF7cm21glPvwmTMZnumJM?=
 =?iso-8859-2?Q?s1SrbiX/TUjG705ssYnMsF2JP3XW/sF8FleflRLKKbA/+Wq99pC4KgEQ9U?=
 =?iso-8859-2?Q?0wcTtHQ89CzNiXIuOzKJtBXfWFbrwJVmD1OOEcL91Pfd1gQKDuvALGcaps?=
 =?iso-8859-2?Q?UAgGwRo4jMWjpGzEQAzFb/pF89A5ivwj+K7QrOBCE/TOLKPbCtn8qp2DDR?=
 =?iso-8859-2?Q?Sd6uZaHuecCVAJOV64Ji9E+dQVu7Se+lWP5le25IIUr1FqN1FoAQku1bNa?=
 =?iso-8859-2?Q?jvqEyOwBd6UY6OGd0hbu522+95STALLZ6NVWKzmDi09k70SuITghPddYU5?=
 =?iso-8859-2?Q?HypUW02sPKO16qhial8JK3QRSRA5QI6EZh+VHYngJbPQb+jhqAtd38ls7x?=
 =?iso-8859-2?Q?vb5kCQorVemCU6s8DlBDdCQyeM9/3ON6ficfRbjJErtPxhIBCZhGHFk6lY?=
 =?iso-8859-2?Q?dDhCwTU9AERkFtEkeyy8RM97B2xROyIR/yFCh4REs5MD/yuY1l6sHxLY29?=
 =?iso-8859-2?Q?NXnQtr669dn7yYa/YpeuXRKhD1EQJK14ijIoeyaeCOZD33Dvfyk8npasTC?=
 =?iso-8859-2?Q?o9PkoT+6qFwNe2+8QvrYklwgUi/3bJxFSCR53Mv7C4OxyU98+jTiipdkuq?=
 =?iso-8859-2?Q?Okyw9hiXROjKhWQ+rkrv/EgwOqs5EnAulrY9C2yyJU5QNYRejVLlD2yTuE?=
 =?iso-8859-2?Q?X7BIRlEwKQuFCrOdyxJuKKLStQvsPeIfHY8Kn0vBaxbJJGwagAtSlCMpAP?=
 =?iso-8859-2?Q?FiTaGxqIib6q3xx+8mdFzoOIYGRAWl83W52N481XqXij0CG7o5BEwOfy1y?=
 =?iso-8859-2?Q?0H2+Reu2gm7GuYm56fdpfnDatXseyVkC3PfmpY3NjcosA86/aVVSfigHWR?=
 =?iso-8859-2?Q?M0g0LqLl9BHtDPybj32GYcSr5yCvmB/ZYR1NM7D07EqOYsTD/zmr5BsUP+?=
 =?iso-8859-2?Q?klMb0l8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?d/rhR0rDdxsgXSR3AiSnUMXSJ9EqvjcDM2ZxK2kxv8wVhzvTP/1W/0FXPS?=
 =?iso-8859-2?Q?7xVnFV4b1/3clAUBAZ+gLiPpnpyo6+b7vOwEgK8pSMrxPAZHG3dCmz8kzB?=
 =?iso-8859-2?Q?Y7X73JSZrlChbIxbcQuoJnuq2t2MLbneszQmVKnE7EOMLzMQs0vNdyTGIf?=
 =?iso-8859-2?Q?vqDBdA5YVBie9NZ+Yze1FoXaWXu62B0UzvwIz3IY9UDCvvP4MWwBO7TfCr?=
 =?iso-8859-2?Q?OvA33D1y8Iu72NJdTkHo6NFfzP4qN2pZKnEwzEZ6Js6q7OUnM1gkn250uD?=
 =?iso-8859-2?Q?y0MY4hfOTqUNQIU1ue0Xfz+Pccfz5NJP1NxT8lj0Mz23screxGUzp1Konf?=
 =?iso-8859-2?Q?IhFtiUPoG5O21gRwvmT8QIrkB12PgfBjmmf/e+VZ9wzPnP6qWor2pbvYkX?=
 =?iso-8859-2?Q?qa2fe98nOm4KX6luplN8/HonHHg/pXXCs8BfDWTcuL/iRtcS2d/TAxRUax?=
 =?iso-8859-2?Q?Rt49ikSic9Lih4ezvNB2th56qZlSW+kWHAUnRkkpwEUtIfDQDPlhLJdZ53?=
 =?iso-8859-2?Q?7bTh9YGEJHT7WhXYt74N82dq6JfieX+OoRJaC92BJ575Tq2jcOpnvrapqH?=
 =?iso-8859-2?Q?De7kSWw7KeL2HJi8O4WOys1VBkMRzVAWjwQ7QxRefhQ8rmgdGBJ1sx9dHz?=
 =?iso-8859-2?Q?kiSaR0PkiWzlg9hC1Weg836a4cM+1p7y6oLx6OVPKwdq0m73wKicZuJT4s?=
 =?iso-8859-2?Q?zrpUICa2vYwLUl5bi+/lS7+//myKC1UuVj7gge4axX0lCE0WRNS7vLRRuE?=
 =?iso-8859-2?Q?ZXq5Tc1v0gdcNFlI6WuAjoh+TGMjivxr2XexKBxgDGB3+3d7kizV9ujd0H?=
 =?iso-8859-2?Q?DYmKcNyTWewr0ZKHghRLnpZ2orx0leuMYgLMX/jTjfUWW9hIo6hObs8Eyy?=
 =?iso-8859-2?Q?wrAgozQGnmPRLjqmASSKrJ0Q/h0iAs3YgEyqTgcIZY+BUOmQhrpXaNBl4g?=
 =?iso-8859-2?Q?XYhWN4e/6FTcYHFwtqmsRFihmrsBA/nS+5cRozN1dZfaPs38NfqDEZ4fHV?=
 =?iso-8859-2?Q?xfseo+/JfZSh0yfzvhKX3u7Q5b5fBumhk7UCBfP68gOBAGDNdKYBTFTwof?=
 =?iso-8859-2?Q?JBhpfSwmuOYJEXQ878VqYtZlAJP5n0I0PbsHziHSI5smfRLEIhp/H64QzF?=
 =?iso-8859-2?Q?1m/wXlKNYO13o/w7p2oXYFeJPA7BN/k1U2HZvBUj5aOJvz3bgoTb5uBmgX?=
 =?iso-8859-2?Q?q339c2ocjowH4ULRD43iJc7ONWETxyKogVvzOBEH2bor78b3oneb9CHm0x?=
 =?iso-8859-2?Q?VA7gzAJ9thO1dgbLjbiYnOBveEC3AK/N2r6gUv5+NUY/REHLdf8VJHYVno?=
 =?iso-8859-2?Q?HFM7s9R/11RkH/RlNtPNf19QWj9fH/7bpNcB5ISW9PeeW0legHOXknpk71?=
 =?iso-8859-2?Q?j0Blcl2ArnS0Gkt/CPr45JAILqIAJ/Ir6bM1E/hYrNtRlhMXIhJLTmp93/?=
 =?iso-8859-2?Q?ppXKWAbVG8U4MFm36W5IBNZhWYER/P0/eTQDiiGiu/7gXh6zK/w+A6PyHC?=
 =?iso-8859-2?Q?ZrTWVyob6OcXP9aWUG0Ck55z0oGLSGK/0cse4XIffk92A9BPnxRrnOJ3cE?=
 =?iso-8859-2?Q?AYkMphpE9JySrhDVJfhaGLTa8PlZ?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923F85A909F2724ED5328239259ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef8fd77-caab-4b37-e33a-08ddcbc3e6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 21:40:40.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eo0MGfziL7LFxUyoMmb6C+hxyFnQxpW2o7yxrJXAGCN293G668B0r2tzGu8fLH+eo5XoMHYs3T9aE98DHIi3MNX1guy2g2BHzcr/syYbrO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR83MB0765
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923F85A909F2724ED5328239259ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending the follow up of https://sourceware.org/pipermail/cygwin-patches/20=
25q3/014175.html=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From b00a23402a77aae19a1d42a8d06d6c4d371b066b Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Mon, 21 Jul 2025 10:03:52 +0200=0A=
Subject: [PATCH] Cygwin: configure: allow zero-level bootstrapping cross-bu=
ild=0A=
 with --without-cross-bootstrap (and cross-testing without)=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch introduces additional changes, on top of the previous changes fr=
om=0A=
437d2d6862b47c6cf10c989706eddf55e5f41efd commit, for building Cygwin with=
=0A=
a stage1 compiler that does not support linking executables yet, e.g., when=
=0A=
building a cross-compiler for Cygwin. It allows building just the Cygwin DL=
L=0A=
and crt0.o, which is sufficient for a stage2 compiler.=0A=
=0A=
Furthermore, it allows cross-testing of the Cygwin DLL in cross-compilation=
=0A=
environments that are capable of executing native Cygwin executables,=0A=
e.g. in WSL, if --without-cross-bootstrap is not specified and MinGW toolch=
ain is=0A=
available (because cygrun needs to be built).=0A=
=0A=
Furthermore, it fixes behavior of --with(out)-cross-bootstrap flag to make =
it=0A=
semantically compliant with its documentation as discussed at=0A=
https://sourceware.org/pipermail/cygwin-patches/2025q3/014175.html. It defa=
ults=0A=
to --with-cross-bootstrap now which enables MinGW toolchain detection and M=
inGW=0A=
tools building (and testing).=0A=
=0A=
ChangeLog:=0A=
=0A=
        * newlib/libc/include/stdlib.h (abort): Remove (void) parameter=0A=
        to fix x64 compilation with GCC 15 cross-compiler.=0A=
        * winsup/configure.ac: Fix --with-cross-bootstrap flag semantics,=
=0A=
        change target_cpu to build_cpu for MinGW toolchain detection,=0A=
        and conditionally check BFD libraries only when not bootstrapping=
=0A=
        to avoid "configure: error: link tests are not allowed after=0A=
        AC_NO_EXECUTABLES" error.=0A=
        * winsup/doc/faq-programming.xml: Fix spacing in documentation=0A=
        for --without-cross-bootstrap flag.=0A=
        * winsup/testsuite/Makefile.am: Make mingw/cygload test conditional=
=0A=
        on CROSS_BOOTSTRAP, use EXEEXT variable for Unix based cross-compil=
ation=0A=
        environments that are not adding the extension automatically, use=
=0A=
        dynamic busybox path detection instead of hardcoded paths.=0A=
        * winsup/testsuite/cygrun.sh: Add .exe extension to executable=0A=
        references for proper cross-platform compatibility. This still have=
 two=0A=
        caveats, it assumes cygdrop and cygpath to be present in the=0A=
        environment. This is becase cygdrop is not part of the newlib-cygwi=
n=0A=
        repository and using cygpath built from the repository is failing w=
ith=0A=
        "Warning!  Stack base is 0x600000.  padding ends at 0x5ff7c8.=0A=
        Delta is 2104.  Stack variables could be overwritten!" even for nat=
ive=0A=
        x64 environments.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 newlib/libc/include/stdlib.h   |  2 +-=0A=
 winsup/configure.ac            | 22 +++++++++++++---------=0A=
 winsup/doc/faq-programming.xml |  2 +-=0A=
 winsup/testsuite/Makefile.am   | 16 +++++++++++-----=0A=
 winsup/testsuite/cygrun.sh     |  8 ++++----=0A=
 5 files changed, 30 insertions(+), 20 deletions(-)=0A=
=0A=
diff --git a/newlib/libc/include/stdlib.h b/newlib/libc/include/stdlib.h=0A=
index 55b20fac9..34a43c786 100644=0A=
--- a/newlib/libc/include/stdlib.h=0A=
+++ b/newlib/libc/include/stdlib.h=0A=
@@ -66,7 +66,7 @@ int	__locale_mb_cur_max (void);=0A=
 =0A=
 #define MB_CUR_MAX __locale_mb_cur_max()=0A=
 =0A=
-void	abort (void) _ATTRIBUTE ((__noreturn__));=0A=
+void	abort () _ATTRIBUTE ((__noreturn__));=0A=
 int	abs (int);=0A=
 #if __BSD_VISIBLE=0A=
 __uint32_t arc4random (void);=0A=
diff --git a/winsup/configure.ac b/winsup/configure.ac=0A=
index e7ac814b1..57191fa7f 100644=0A=
--- a/winsup/configure.ac=0A=
+++ b/winsup/configure.ac=0A=
@@ -40,7 +40,9 @@ AM_PROG_AS=0A=
 AC_LANG(C)=0A=
 AC_LANG(C++)=0A=
 =0A=
-AC_ARG_WITH([cross-bootstrap],[AS_HELP_STRING([--with-cross-bootstrap],[do=
 not build programs using the MinGW toolchain or check for MinGW libraries =
(useful for bootstrapping a cross-compiler)])],[],[with_cross_bootstrap=3Dn=
o])=0A=
+AC_ARG_WITH([cross_bootstrap],=0A=
+    [AS_HELP_STRING([--without-cross-bootstrap],=0A=
+		    [do not build programs using the MinGW toolchain or check for MinGW =
libraries (useful for bootstrapping a cross-compiler)])])=0A=
 =0A=
 AC_CYGWIN_INCLUDES=0A=
 =0A=
@@ -115,13 +117,13 @@ if test -z "$XMLTO"; then=0A=
     fi=0A=
 fi=0A=
 =0A=
-if test "x$with_cross_bootstrap" !=3D "xyes"; then=0A=
-    AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++)=0A=
+if test "x$with_cross_bootstrap" !=3D "xno"; then=0A=
+    AC_CHECK_PROGS(MINGW_CXX, ${build_cpu}-w64-mingw32-g++)=0A=
     test -n "$MINGW_CXX" || AC_MSG_ERROR([no acceptable MinGW g++ found in=
 \$PATH])=0A=
-    AC_CHECK_PROGS(MINGW_CC, ${target_cpu}-w64-mingw32-gcc)=0A=
+    AC_CHECK_PROGS(MINGW_CC, ${build_cpu}-w64-mingw32-gcc)=0A=
     test -n "$MINGW_CC" || AC_MSG_ERROR([no acceptable MinGW gcc found in =
\$PATH])=0A=
 fi=0A=
-AM_CONDITIONAL(CROSS_BOOTSTRAP, [test "x$with_cross_bootstrap" !=3D "xyes"=
])=0A=
+AM_CONDITIONAL(CROSS_BOOTSTRAP, [test "x$with_cross_bootstrap" !=3D "xno"]=
)=0A=
 =0A=
 AC_EXEEXT=0A=
 =0A=
@@ -134,10 +136,12 @@ AM_CONDITIONAL(BUILD_DUMPER, [test "x$build_dumper" =
=3D "xyes"])=0A=
 =0A=
 # libbfd.a doesn't have a pkgconfig file, so we guess what it's dependenci=
es=0A=
 # are, based on what's present in the build environment=0A=
-BFD_LIBS=3D"-lintl -liconv -liberty -lz"=0A=
-AC_CHECK_LIB([sframe], [sframe_decode], [BFD_LIBS=3D"${BFD_LIBS} -lsframe"=
])=0A=
-AC_CHECK_LIB([zstd], [ZSTD_isError], [BFD_LIBS=3D"${BFD_LIBS} -lzstd"])=0A=
-AC_SUBST([BFD_LIBS])=0A=
+if test "x$with_cross_bootstrap" !=3D "xno"; then=0A=
+    BFD_LIBS=3D"-lintl -liconv -liberty -lz"=0A=
+    AC_CHECK_LIB([sframe], [sframe_decode], [BFD_LIBS=3D"${BFD_LIBS} -lsfr=
ame"])=0A=
+    AC_CHECK_LIB([zstd], [ZSTD_isError], [BFD_LIBS=3D"${BFD_LIBS} -lzstd"]=
)=0A=
+    AC_SUBST([BFD_LIBS])=0A=
+fi=0A=
 =0A=
 AC_CONFIG_FILES([=0A=
     Makefile=0A=
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0A=
index ae9bdb8dc..696a6462b 100644=0A=
--- a/winsup/doc/faq-programming.xml=0A=
+++ b/winsup/doc/faq-programming.xml=0A=
@@ -707,7 +707,7 @@ Build of <literal>cygserver</literal> can be skipped wi=
th=0A=
 <para>=0A=
 In combination, <literal>--disable-cygserver</literal>,=0A=
 <literal>--disable-dumper</literal>, <literal>--disable-utils</literal>=0A=
-and  <literal>--without-cross-bootstrap</literal> allow building of just=
=0A=
+and <literal>--without-cross-bootstrap</literal> allow building of just=0A=
 <literal>cygwin1.dll</literal> and <literal>crt0.o</literal> for a stage2=
=0A=
 compiler, when being built with stage1 compiler which does not support lin=
king=0A=
 executables yet (because those files are missing).=0A=
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am=0A=
index 20e06b9c5..7e304db2a 100644=0A=
--- a/winsup/testsuite/Makefile.am=0A=
+++ b/winsup/testsuite/Makefile.am=0A=
@@ -335,8 +335,11 @@ LDADD =3D $(builddir)/libltp.a $(builddir)/../cygwin/b=
inmode.o $(LDADD_FOR_TESTDLL=0A=
 winsup_api_devdsp_LDADD =3D -lwinmm $(LDADD)=0A=
 =0A=
 # all tests=0A=
-TESTS =3D $(check_PROGRAMS) \=0A=
-	mingw/cygload=0A=
+TESTS =3D $(check_PROGRAMS)=0A=
+=0A=
+if CROSS_BOOTSTRAP=0A=
+TESTS +=3D mingw/cygload$(EXEEXT)=0A=
+endif=0A=
 =0A=
 # expected fail tests=0A=
 XFAIL_TESTS =3D \=0A=
@@ -351,6 +354,7 @@ LOG_COMPILER =3D $(srcdir)/cygrun.sh=0A=
 =0A=
 export runtime_root=3D$(abs_builddir)/testinst/bin=0A=
 export mingwtestdir=3D$(builddir)/mingw=0A=
+export utilsdir=3D$(builddir)/../utils=0A=
 =0A=
 # Set up things in the Cygwin 'installation' at testsuite/testinst/ to pro=
vide=0A=
 # things which tests need to work=0A=
@@ -369,11 +373,13 @@ export mingwtestdir=3D$(builddir)/mingw=0A=
 # dependencies other than cygwin1.dll.=0A=
 #=0A=
 =0A=
+BUSYBOX :=3D $(shell which busybox)=0A=
+=0A=
 check-local:=0A=
 	$(MKDIR_P) ${builddir}/testinst/tmp=0A=
-	cd ${builddir}/testinst/bin && cp /usr/libexec/busybox/bin/busybox.exe sh=
.exe=0A=
-	cd ${builddir}/testinst/bin && cp /usr/libexec/busybox/bin/busybox.exe sl=
eep.exe=0A=
-	cd ${builddir}/testinst/bin && cp /usr/libexec/busybox/bin/busybox.exe ls=
.exe=0A=
+	cd ${builddir}/testinst/bin && cp $(BUSYBOX) sh.exe=0A=
+	cd ${builddir}/testinst/bin && cp $(BUSYBOX) sleep.exe=0A=
+	cd ${builddir}/testinst/bin && cp $(BUSYBOX) ls.exe=0A=
 =0A=
 # target to build all the programs needed by check, without running check=
=0A=
 check_programs: $(check_PROGRAMS)=0A=
diff --git a/winsup/testsuite/cygrun.sh b/winsup/testsuite/cygrun.sh=0A=
index f1673e4db..6dcbb4ea1 100755=0A=
--- a/winsup/testsuite/cygrun.sh=0A=
+++ b/winsup/testsuite/cygrun.sh=0A=
@@ -8,10 +8,10 @@ exe=3D$1=0A=
 =0A=
 export PATH=3D"$runtime_root:${PATH}"=0A=
 =0A=
-if [ "$1" =3D "./mingw/cygload" ]=0A=
+if [ "$1" =3D "./mingw/cygload.exe" ]=0A=
 then=0A=
-    windows_runtime_root=3D$(cygpath -m $runtime_root)=0A=
-    $mingwtestdir/cygrun "$exe -v -cygwin $windows_runtime_root/cygwin1.dl=
l"=0A=
+    windows_runtime_root=3D$($utilsdir/cygpath.exe -m $runtime_root)=0A=
+    $mingwtestdir/cygrun.exe "$exe -v -cygwin $windows_runtime_root/cygwin=
1.dll"=0A=
 else=0A=
-    cygdrop $mingwtestdir/cygrun $exe=0A=
+    cygdrop.exe $mingwtestdir/cygrun.exe $exe=0A=
 fi=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB0923F85A909F2724ED5328239259ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-configure-allow-zero-level-bootstrapping-cross-build-with-without-cross-bootstrap-and-cross-testing-without.patch"
Content-Description:
 0001-Cygwin-configure-allow-zero-level-bootstrapping-cross-build-with-without-cross-bootstrap-and-cross-testing-without.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-configure-allow-zero-level-bootstrapping-cross-build-with-without-cross-bootstrap-and-cross-testing-without.patch";
	size=8733; creation-date="Fri, 25 Jul 2025 21:38:59 GMT";
	modification-date="Fri, 25 Jul 2025 21:38:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMDBhMjM0MDJhNzdhYWUxOWExZDQyYThkMDZkNmM0ZDM3MWIwNjZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCAyMSBKdWwgMjAyNSAxMDowMzo1MiAr
MDIwMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogY29uZmlndXJlOiBhbGxvdyB6ZXJvLWxldmVs
IGJvb3RzdHJhcHBpbmcgY3Jvc3MtYnVpbGQKIHdpdGggLS13aXRob3V0LWNyb3NzLWJvb3RzdHJh
cCAoYW5kIGNyb3NzLXRlc3Rpbmcgd2l0aG91dCkKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1U
eXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6
IDhiaXQKClRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhZGRpdGlvbmFsIGNoYW5nZXMsIG9uIHRvcCBv
ZiB0aGUgcHJldmlvdXMgY2hhbmdlcyBmcm9tCjQzN2QyZDY4NjJiNDdjNmNmMTBjOTg5NzA2ZWRk
ZjU1ZTVmNDFlZmQgY29tbWl0LCBmb3IgYnVpbGRpbmcgQ3lnd2luIHdpdGgKYSBzdGFnZTEgY29t
cGlsZXIgdGhhdCBkb2VzIG5vdCBzdXBwb3J0IGxpbmtpbmcgZXhlY3V0YWJsZXMgeWV0LCBlLmcu
LCB3aGVuCmJ1aWxkaW5nIGEgY3Jvc3MtY29tcGlsZXIgZm9yIEN5Z3dpbi4gSXQgYWxsb3dzIGJ1
aWxkaW5nIGp1c3QgdGhlIEN5Z3dpbiBETEwKYW5kIGNydDAubywgd2hpY2ggaXMgc3VmZmljaWVu
dCBmb3IgYSBzdGFnZTIgY29tcGlsZXIuCgpGdXJ0aGVybW9yZSwgaXQgYWxsb3dzIGNyb3NzLXRl
c3Rpbmcgb2YgdGhlIEN5Z3dpbiBETEwgaW4gY3Jvc3MtY29tcGlsYXRpb24KZW52aXJvbm1lbnRz
IHRoYXQgYXJlIGNhcGFibGUgb2YgZXhlY3V0aW5nIG5hdGl2ZSBDeWd3aW4gZXhlY3V0YWJsZXMs
CmUuZy4gaW4gV1NMLCBpZiAtLXdpdGhvdXQtY3Jvc3MtYm9vdHN0cmFwIGlzIG5vdCBzcGVjaWZp
ZWQgYW5kIE1pbkdXIHRvb2xjaGFpbiBpcwphdmFpbGFibGUgKGJlY2F1c2UgY3lncnVuIG5lZWRz
IHRvIGJlIGJ1aWx0KS4KCkZ1cnRoZXJtb3JlLCBpdCBmaXhlcyBiZWhhdmlvciBvZiAtLXdpdGgo
b3V0KS1jcm9zcy1ib290c3RyYXAgZmxhZyB0byBtYWtlIGl0CnNlbWFudGljYWxseSBjb21wbGlh
bnQgd2l0aCBpdHMgZG9jdW1lbnRhdGlvbiBhcyBkaXNjdXNzZWQgYXQKaHR0cHM6Ly9zb3VyY2V3
YXJlLm9yZy9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMvMjAyNXEzLzAxNDE3NS5odG1sLiBJdCBk
ZWZhdWx0cwp0byAtLXdpdGgtY3Jvc3MtYm9vdHN0cmFwIG5vdyB3aGljaCBlbmFibGVzIE1pbkdX
IHRvb2xjaGFpbiBkZXRlY3Rpb24gYW5kIE1pbkdXCnRvb2xzIGJ1aWxkaW5nIChhbmQgdGVzdGlu
ZykuCgpDaGFuZ2VMb2c6CgogICAgICAgICogbmV3bGliL2xpYmMvaW5jbHVkZS9zdGRsaWIuaCAo
YWJvcnQpOiBSZW1vdmUgKHZvaWQpIHBhcmFtZXRlcgogICAgICAgIHRvIGZpeCB4NjQgY29tcGls
YXRpb24gd2l0aCBHQ0MgMTUgY3Jvc3MtY29tcGlsZXIuCiAgICAgICAgKiB3aW5zdXAvY29uZmln
dXJlLmFjOiBGaXggLS13aXRoLWNyb3NzLWJvb3RzdHJhcCBmbGFnIHNlbWFudGljcywKICAgICAg
ICBjaGFuZ2UgdGFyZ2V0X2NwdSB0byBidWlsZF9jcHUgZm9yIE1pbkdXIHRvb2xjaGFpbiBkZXRl
Y3Rpb24sCiAgICAgICAgYW5kIGNvbmRpdGlvbmFsbHkgY2hlY2sgQkZEIGxpYnJhcmllcyBvbmx5
IHdoZW4gbm90IGJvb3RzdHJhcHBpbmcKICAgICAgICB0byBhdm9pZCAiY29uZmlndXJlOiBlcnJv
cjogbGluayB0ZXN0cyBhcmUgbm90IGFsbG93ZWQgYWZ0ZXIKICAgICAgICBBQ19OT19FWEVDVVRB
QkxFUyIgZXJyb3IuCiAgICAgICAgKiB3aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWw6IEZp
eCBzcGFjaW5nIGluIGRvY3VtZW50YXRpb24KICAgICAgICBmb3IgLS13aXRob3V0LWNyb3NzLWJv
b3RzdHJhcCBmbGFnLgogICAgICAgICogd2luc3VwL3Rlc3RzdWl0ZS9NYWtlZmlsZS5hbTogTWFr
ZSBtaW5ndy9jeWdsb2FkIHRlc3QgY29uZGl0aW9uYWwKICAgICAgICBvbiBDUk9TU19CT09UU1RS
QVAsIHVzZSBFWEVFWFQgdmFyaWFibGUgZm9yIFVuaXggYmFzZWQgY3Jvc3MtY29tcGlsYXRpb24K
ICAgICAgICBlbnZpcm9ubWVudHMgdGhhdCBhcmUgbm90IGFkZGluZyB0aGUgZXh0ZW5zaW9uIGF1
dG9tYXRpY2FsbHksIHVzZQogICAgICAgIGR5bmFtaWMgYnVzeWJveCBwYXRoIGRldGVjdGlvbiBp
bnN0ZWFkIG9mIGhhcmRjb2RlZCBwYXRocy4KICAgICAgICAqIHdpbnN1cC90ZXN0c3VpdGUvY3ln
cnVuLnNoOiBBZGQgLmV4ZSBleHRlbnNpb24gdG8gZXhlY3V0YWJsZQogICAgICAgIHJlZmVyZW5j
ZXMgZm9yIHByb3BlciBjcm9zcy1wbGF0Zm9ybSBjb21wYXRpYmlsaXR5LiBUaGlzIHN0aWxsIGhh
dmUgdHdvCiAgICAgICAgY2F2ZWF0cywgaXQgYXNzdW1lcyBjeWdkcm9wIGFuZCBjeWdwYXRoIHRv
IGJlIHByZXNlbnQgaW4gdGhlCiAgICAgICAgZW52aXJvbm1lbnQuIFRoaXMgaXMgYmVjYXNlIGN5
Z2Ryb3AgaXMgbm90IHBhcnQgb2YgdGhlIG5ld2xpYi1jeWd3aW4KICAgICAgICByZXBvc2l0b3J5
IGFuZCB1c2luZyBjeWdwYXRoIGJ1aWx0IGZyb20gdGhlIHJlcG9zaXRvcnkgaXMgZmFpbGluZyB3
aXRoCiAgICAgICAgIldhcm5pbmchICBTdGFjayBiYXNlIGlzIDB4NjAwMDAwLiAgcGFkZGluZyBl
bmRzIGF0IDB4NWZmN2M4LgogICAgICAgIERlbHRhIGlzIDIxMDQuICBTdGFjayB2YXJpYWJsZXMg
Y291bGQgYmUgb3ZlcndyaXR0ZW4hIiBldmVuIGZvciBuYXRpdmUKICAgICAgICB4NjQgZW52aXJv
bm1lbnRzLgoKU2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jv
c29mdC5jb20+Ci0tLQogbmV3bGliL2xpYmMvaW5jbHVkZS9zdGRsaWIuaCAgIHwgIDIgKy0KIHdp
bnN1cC9jb25maWd1cmUuYWMgICAgICAgICAgICB8IDIyICsrKysrKysrKysrKystLS0tLS0tLS0K
IHdpbnN1cC9kb2MvZmFxLXByb2dyYW1taW5nLnhtbCB8ICAyICstCiB3aW5zdXAvdGVzdHN1aXRl
L01ha2VmaWxlLmFtICAgfCAxNiArKysrKysrKysrKy0tLS0tCiB3aW5zdXAvdGVzdHN1aXRlL2N5
Z3J1bi5zaCAgICAgfCAgOCArKysrLS0tLQogNSBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25z
KCspLCAyMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXdsaWIvbGliYy9pbmNsdWRlL3N0
ZGxpYi5oIGIvbmV3bGliL2xpYmMvaW5jbHVkZS9zdGRsaWIuaAppbmRleCA1NWIyMGZhYzkuLjM0
YTQzYzc4NiAxMDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvaW5jbHVkZS9zdGRsaWIuaAorKysgYi9u
ZXdsaWIvbGliYy9pbmNsdWRlL3N0ZGxpYi5oCkBAIC02Niw3ICs2Niw3IEBAIGludAlfX2xvY2Fs
ZV9tYl9jdXJfbWF4ICh2b2lkKTsKIAogI2RlZmluZSBNQl9DVVJfTUFYIF9fbG9jYWxlX21iX2N1
cl9tYXgoKQogCi12b2lkCWFib3J0ICh2b2lkKSBfQVRUUklCVVRFICgoX19ub3JldHVybl9fKSk7
Cit2b2lkCWFib3J0ICgpIF9BVFRSSUJVVEUgKChfX25vcmV0dXJuX18pKTsKIGludAlhYnMgKGlu
dCk7CiAjaWYgX19CU0RfVklTSUJMRQogX191aW50MzJfdCBhcmM0cmFuZG9tICh2b2lkKTsKZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jb25maWd1cmUuYWMgYi93aW5zdXAvY29uZmlndXJlLmFjCmluZGV4
IGU3YWM4MTRiMS4uNTcxOTFmYTdmIDEwMDY0NAotLS0gYS93aW5zdXAvY29uZmlndXJlLmFjCisr
KyBiL3dpbnN1cC9jb25maWd1cmUuYWMKQEAgLTQwLDcgKzQwLDkgQEAgQU1fUFJPR19BUwogQUNf
TEFORyhDKQogQUNfTEFORyhDKyspCiAKLUFDX0FSR19XSVRIKFtjcm9zcy1ib290c3RyYXBdLFtB
U19IRUxQX1NUUklORyhbLS13aXRoLWNyb3NzLWJvb3RzdHJhcF0sW2RvIG5vdCBidWlsZCBwcm9n
cmFtcyB1c2luZyB0aGUgTWluR1cgdG9vbGNoYWluIG9yIGNoZWNrIGZvciBNaW5HVyBsaWJyYXJp
ZXMgKHVzZWZ1bCBmb3IgYm9vdHN0cmFwcGluZyBhIGNyb3NzLWNvbXBpbGVyKV0pXSxbXSxbd2l0
aF9jcm9zc19ib290c3RyYXA9bm9dKQorQUNfQVJHX1dJVEgoW2Nyb3NzX2Jvb3RzdHJhcF0sCisg
ICAgW0FTX0hFTFBfU1RSSU5HKFstLXdpdGhvdXQtY3Jvc3MtYm9vdHN0cmFwXSwKKwkJICAgIFtk
byBub3QgYnVpbGQgcHJvZ3JhbXMgdXNpbmcgdGhlIE1pbkdXIHRvb2xjaGFpbiBvciBjaGVjayBm
b3IgTWluR1cgbGlicmFyaWVzICh1c2VmdWwgZm9yIGJvb3RzdHJhcHBpbmcgYSBjcm9zcy1jb21w
aWxlcildKV0pCiAKIEFDX0NZR1dJTl9JTkNMVURFUwogCkBAIC0xMTUsMTMgKzExNywxMyBAQCBp
ZiB0ZXN0IC16ICIkWE1MVE8iOyB0aGVuCiAgICAgZmkKIGZpCiAKLWlmIHRlc3QgIngkd2l0aF9j
cm9zc19ib290c3RyYXAiICE9ICJ4eWVzIjsgdGhlbgotICAgIEFDX0NIRUNLX1BST0dTKE1JTkdX
X0NYWCwgJHt0YXJnZXRfY3B1fS13NjQtbWluZ3czMi1nKyspCitpZiB0ZXN0ICJ4JHdpdGhfY3Jv
c3NfYm9vdHN0cmFwIiAhPSAieG5vIjsgdGhlbgorICAgIEFDX0NIRUNLX1BST0dTKE1JTkdXX0NY
WCwgJHtidWlsZF9jcHV9LXc2NC1taW5ndzMyLWcrKykKICAgICB0ZXN0IC1uICIkTUlOR1dfQ1hY
IiB8fCBBQ19NU0dfRVJST1IoW25vIGFjY2VwdGFibGUgTWluR1cgZysrIGZvdW5kIGluIFwkUEFU
SF0pCi0gICAgQUNfQ0hFQ0tfUFJPR1MoTUlOR1dfQ0MsICR7dGFyZ2V0X2NwdX0tdzY0LW1pbmd3
MzItZ2NjKQorICAgIEFDX0NIRUNLX1BST0dTKE1JTkdXX0NDLCAke2J1aWxkX2NwdX0tdzY0LW1p
bmd3MzItZ2NjKQogICAgIHRlc3QgLW4gIiRNSU5HV19DQyIgfHwgQUNfTVNHX0VSUk9SKFtubyBh
Y2NlcHRhYmxlIE1pbkdXIGdjYyBmb3VuZCBpbiBcJFBBVEhdKQogZmkKLUFNX0NPTkRJVElPTkFM
KENST1NTX0JPT1RTVFJBUCwgW3Rlc3QgIngkd2l0aF9jcm9zc19ib290c3RyYXAiICE9ICJ4eWVz
Il0pCitBTV9DT05ESVRJT05BTChDUk9TU19CT09UU1RSQVAsIFt0ZXN0ICJ4JHdpdGhfY3Jvc3Nf
Ym9vdHN0cmFwIiAhPSAieG5vIl0pCiAKIEFDX0VYRUVYVAogCkBAIC0xMzQsMTAgKzEzNiwxMiBA
QCBBTV9DT05ESVRJT05BTChCVUlMRF9EVU1QRVIsIFt0ZXN0ICJ4JGJ1aWxkX2R1bXBlciIgPSAi
eHllcyJdKQogCiAjIGxpYmJmZC5hIGRvZXNuJ3QgaGF2ZSBhIHBrZ2NvbmZpZyBmaWxlLCBzbyB3
ZSBndWVzcyB3aGF0IGl0J3MgZGVwZW5kZW5jaWVzCiAjIGFyZSwgYmFzZWQgb24gd2hhdCdzIHBy
ZXNlbnQgaW4gdGhlIGJ1aWxkIGVudmlyb25tZW50Ci1CRkRfTElCUz0iLWxpbnRsIC1saWNvbnYg
LWxpYmVydHkgLWx6IgotQUNfQ0hFQ0tfTElCKFtzZnJhbWVdLCBbc2ZyYW1lX2RlY29kZV0sIFtC
RkRfTElCUz0iJHtCRkRfTElCU30gLWxzZnJhbWUiXSkKLUFDX0NIRUNLX0xJQihbenN0ZF0sIFta
U1REX2lzRXJyb3JdLCBbQkZEX0xJQlM9IiR7QkZEX0xJQlN9IC1senN0ZCJdKQotQUNfU1VCU1Qo
W0JGRF9MSUJTXSkKK2lmIHRlc3QgIngkd2l0aF9jcm9zc19ib290c3RyYXAiICE9ICJ4bm8iOyB0
aGVuCisgICAgQkZEX0xJQlM9Ii1saW50bCAtbGljb252IC1saWJlcnR5IC1seiIKKyAgICBBQ19D
SEVDS19MSUIoW3NmcmFtZV0sIFtzZnJhbWVfZGVjb2RlXSwgW0JGRF9MSUJTPSIke0JGRF9MSUJT
fSAtbHNmcmFtZSJdKQorICAgIEFDX0NIRUNLX0xJQihbenN0ZF0sIFtaU1REX2lzRXJyb3JdLCBb
QkZEX0xJQlM9IiR7QkZEX0xJQlN9IC1senN0ZCJdKQorICAgIEFDX1NVQlNUKFtCRkRfTElCU10p
CitmaQogCiBBQ19DT05GSUdfRklMRVMoWwogICAgIE1ha2VmaWxlCmRpZmYgLS1naXQgYS93aW5z
dXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWwgYi93aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54
bWwKaW5kZXggYWU5YmRiOGRjLi42OTZhNjQ2MmIgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9kb2MvZmFx
LXByb2dyYW1taW5nLnhtbAorKysgYi93aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWwKQEAg
LTcwNyw3ICs3MDcsNyBAQCBCdWlsZCBvZiA8bGl0ZXJhbD5jeWdzZXJ2ZXI8L2xpdGVyYWw+IGNh
biBiZSBza2lwcGVkIHdpdGgKIDxwYXJhPgogSW4gY29tYmluYXRpb24sIDxsaXRlcmFsPi0tZGlz
YWJsZS1jeWdzZXJ2ZXI8L2xpdGVyYWw+LAogPGxpdGVyYWw+LS1kaXNhYmxlLWR1bXBlcjwvbGl0
ZXJhbD4sIDxsaXRlcmFsPi0tZGlzYWJsZS11dGlsczwvbGl0ZXJhbD4KLWFuZCAgPGxpdGVyYWw+
LS13aXRob3V0LWNyb3NzLWJvb3RzdHJhcDwvbGl0ZXJhbD4gYWxsb3cgYnVpbGRpbmcgb2YganVz
dAorYW5kIDxsaXRlcmFsPi0td2l0aG91dC1jcm9zcy1ib290c3RyYXA8L2xpdGVyYWw+IGFsbG93
IGJ1aWxkaW5nIG9mIGp1c3QKIDxsaXRlcmFsPmN5Z3dpbjEuZGxsPC9saXRlcmFsPiBhbmQgPGxp
dGVyYWw+Y3J0MC5vPC9saXRlcmFsPiBmb3IgYSBzdGFnZTIKIGNvbXBpbGVyLCB3aGVuIGJlaW5n
IGJ1aWx0IHdpdGggc3RhZ2UxIGNvbXBpbGVyIHdoaWNoIGRvZXMgbm90IHN1cHBvcnQgbGlua2lu
ZwogZXhlY3V0YWJsZXMgeWV0IChiZWNhdXNlIHRob3NlIGZpbGVzIGFyZSBtaXNzaW5nKS4KZGlm
ZiAtLWdpdCBhL3dpbnN1cC90ZXN0c3VpdGUvTWFrZWZpbGUuYW0gYi93aW5zdXAvdGVzdHN1aXRl
L01ha2VmaWxlLmFtCmluZGV4IDIwZTA2YjljNS4uN2UzMDRkYjJhIDEwMDY0NAotLS0gYS93aW5z
dXAvdGVzdHN1aXRlL01ha2VmaWxlLmFtCisrKyBiL3dpbnN1cC90ZXN0c3VpdGUvTWFrZWZpbGUu
YW0KQEAgLTMzNSw4ICszMzUsMTEgQEAgTERBREQgPSAkKGJ1aWxkZGlyKS9saWJsdHAuYSAkKGJ1
aWxkZGlyKS8uLi9jeWd3aW4vYmlubW9kZS5vICQoTERBRERfRk9SX1RFU1RETEwKIHdpbnN1cF9h
cGlfZGV2ZHNwX0xEQUREID0gLWx3aW5tbSAkKExEQUREKQogCiAjIGFsbCB0ZXN0cwotVEVTVFMg
PSAkKGNoZWNrX1BST0dSQU1TKSBcCi0JbWluZ3cvY3lnbG9hZAorVEVTVFMgPSAkKGNoZWNrX1BS
T0dSQU1TKQorCitpZiBDUk9TU19CT09UU1RSQVAKK1RFU1RTICs9IG1pbmd3L2N5Z2xvYWQkKEVY
RUVYVCkKK2VuZGlmCiAKICMgZXhwZWN0ZWQgZmFpbCB0ZXN0cwogWEZBSUxfVEVTVFMgPSBcCkBA
IC0zNTEsNiArMzU0LDcgQEAgTE9HX0NPTVBJTEVSID0gJChzcmNkaXIpL2N5Z3J1bi5zaAogCiBl
eHBvcnQgcnVudGltZV9yb290PSQoYWJzX2J1aWxkZGlyKS90ZXN0aW5zdC9iaW4KIGV4cG9ydCBt
aW5nd3Rlc3RkaXI9JChidWlsZGRpcikvbWluZ3cKK2V4cG9ydCB1dGlsc2Rpcj0kKGJ1aWxkZGly
KS8uLi91dGlscwogCiAjIFNldCB1cCB0aGluZ3MgaW4gdGhlIEN5Z3dpbiAnaW5zdGFsbGF0aW9u
JyBhdCB0ZXN0c3VpdGUvdGVzdGluc3QvIHRvIHByb3ZpZGUKICMgdGhpbmdzIHdoaWNoIHRlc3Rz
IG5lZWQgdG8gd29yawpAQCAtMzY5LDExICszNzMsMTMgQEAgZXhwb3J0IG1pbmd3dGVzdGRpcj0k
KGJ1aWxkZGlyKS9taW5ndwogIyBkZXBlbmRlbmNpZXMgb3RoZXIgdGhhbiBjeWd3aW4xLmRsbC4K
ICMKIAorQlVTWUJPWCA6PSAkKHNoZWxsIHdoaWNoIGJ1c3lib3gpCisKIGNoZWNrLWxvY2FsOgog
CSQoTUtESVJfUCkgJHtidWlsZGRpcn0vdGVzdGluc3QvdG1wCi0JY2QgJHtidWlsZGRpcn0vdGVz
dGluc3QvYmluICYmIGNwIC91c3IvbGliZXhlYy9idXN5Ym94L2Jpbi9idXN5Ym94LmV4ZSBzaC5l
eGUKLQljZCAke2J1aWxkZGlyfS90ZXN0aW5zdC9iaW4gJiYgY3AgL3Vzci9saWJleGVjL2J1c3li
b3gvYmluL2J1c3lib3guZXhlIHNsZWVwLmV4ZQotCWNkICR7YnVpbGRkaXJ9L3Rlc3RpbnN0L2Jp
biAmJiBjcCAvdXNyL2xpYmV4ZWMvYnVzeWJveC9iaW4vYnVzeWJveC5leGUgbHMuZXhlCisJY2Qg
JHtidWlsZGRpcn0vdGVzdGluc3QvYmluICYmIGNwICQoQlVTWUJPWCkgc2guZXhlCisJY2QgJHti
dWlsZGRpcn0vdGVzdGluc3QvYmluICYmIGNwICQoQlVTWUJPWCkgc2xlZXAuZXhlCisJY2QgJHti
dWlsZGRpcn0vdGVzdGluc3QvYmluICYmIGNwICQoQlVTWUJPWCkgbHMuZXhlCiAKICMgdGFyZ2V0
IHRvIGJ1aWxkIGFsbCB0aGUgcHJvZ3JhbXMgbmVlZGVkIGJ5IGNoZWNrLCB3aXRob3V0IHJ1bm5p
bmcgY2hlY2sKIGNoZWNrX3Byb2dyYW1zOiAkKGNoZWNrX1BST0dSQU1TKQpkaWZmIC0tZ2l0IGEv
d2luc3VwL3Rlc3RzdWl0ZS9jeWdydW4uc2ggYi93aW5zdXAvdGVzdHN1aXRlL2N5Z3J1bi5zaApp
bmRleCBmMTY3M2U0ZGIuLjZkY2JiNGVhMSAxMDA3NTUKLS0tIGEvd2luc3VwL3Rlc3RzdWl0ZS9j
eWdydW4uc2gKKysrIGIvd2luc3VwL3Rlc3RzdWl0ZS9jeWdydW4uc2gKQEAgLTgsMTAgKzgsMTAg
QEAgZXhlPSQxCiAKIGV4cG9ydCBQQVRIPSIkcnVudGltZV9yb290OiR7UEFUSH0iCiAKLWlmIFsg
IiQxIiA9ICIuL21pbmd3L2N5Z2xvYWQiIF0KK2lmIFsgIiQxIiA9ICIuL21pbmd3L2N5Z2xvYWQu
ZXhlIiBdCiB0aGVuCi0gICAgd2luZG93c19ydW50aW1lX3Jvb3Q9JChjeWdwYXRoIC1tICRydW50
aW1lX3Jvb3QpCi0gICAgJG1pbmd3dGVzdGRpci9jeWdydW4gIiRleGUgLXYgLWN5Z3dpbiAkd2lu
ZG93c19ydW50aW1lX3Jvb3QvY3lnd2luMS5kbGwiCisgICAgd2luZG93c19ydW50aW1lX3Jvb3Q9
JCgkdXRpbHNkaXIvY3lncGF0aC5leGUgLW0gJHJ1bnRpbWVfcm9vdCkKKyAgICAkbWluZ3d0ZXN0
ZGlyL2N5Z3J1bi5leGUgIiRleGUgLXYgLWN5Z3dpbiAkd2luZG93c19ydW50aW1lX3Jvb3QvY3ln
d2luMS5kbGwiCiBlbHNlCi0gICAgY3lnZHJvcCAkbWluZ3d0ZXN0ZGlyL2N5Z3J1biAkZXhlCisg
ICAgY3lnZHJvcC5leGUgJG1pbmd3dGVzdGRpci9jeWdydW4uZXhlICRleGUKIGZpCi0tIAoyLjUw
LjEudmZzLjAuMAoK

--_002_DB9PR83MB0923F85A909F2724ED5328239259ADB9PR83MB0923EURP_--
