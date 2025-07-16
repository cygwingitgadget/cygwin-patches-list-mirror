Return-Path: <SRS0=n9zG=Z5=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20721.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::721])
	by sourceware.org (Postfix) with ESMTPS id 3C499385771D
	for <cygwin-patches@cygwin.com>; Wed, 16 Jul 2025 19:37:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3C499385771D
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3C499385771D
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::721
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752694668; cv=pass;
	b=kH2CjpnGaMCWtMJMsaFtmth4r7zUBdudHVo54ELmZpzAsuOuhBxdeYl/YPFA3H4dFG9HqenS5rTf8s+xXhtpCcjlP5c6oPUfuupeLjrF8DxJo5Y5hofbFS7eqLgXOnt4imx6YuM0/bsHmNJuXSxJcM52gw6oYT1dCv4An61B9mw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752694668; c=relaxed/simple;
	bh=s5v2PedvTuyS0BtQI97v6I3rw7rEZAEKCYeJLqWvm5c=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=MDDNPRU9cjzlqfhd/XFOFSws+8iHQ3y3exoCyG6nV/6TxgP1Kfg/MAoallkNoX3T+JzYLHmrxp4FsvziqGt/SY+fAUqzyqiHtYSHs7IHYjJKpPLvnuwiCez97QR6D7IF9KtqnViMmYcq5k1rm348SMpMO3mUwU1KudHONnlTe88=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3C499385771D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=LmPpVNLU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCF3cS2ZVdTTNq4YxeH8qAfckC8n89Ha40fz/hsstcTgM7r7gH0xi/33KzTzt53RghkYHFKZ4jEDr8/manh2RNrDEhB+Zlmibb/VNz5uKBHYGQVLQuo3pNUhxhkRGLIErVXyFG/9buRG2x8RNOm9BSLNsTI1TFyDxnK4QkrrhhU4E9AXjicVbi9l0dWFZsdVaWNG6HDNCfx75F7KA9PzNOP/aZcXlnGYdtGCQb1zXSVFzD8NufCl3FNYIrcvW5L+nPsyPvZbidKrCOIfbevk6TqqwQ8IhlBSkquLiWkz5ERWlFoIiuWyUAfaZNUFdURQ98fc56Fv2N2n3N5lCqtB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XY+qFRyLjORV5+QRlh2SDlR5zdo28YaXb1q0GrJHl7U=;
 b=ThomLdiWg55bTU0H8X9/g8QwImZywbuS6zE1daGwRZnvzUBpa+wX73QVZ22ZlffaNGfIu5/apQIHLLD+udCVDDX6bzlfuHpldJRl/vpa/8cUQTwN3FdblEqCCKwKTNeF45PpfNx3OmBeBk15dybYXcJO+G/x7/dzpLxBMPs4sVfk77Y0DYqzI/ZTcRM+JNnOf0I+umNSoty9ihQwe+kWgcx+g8fZYdq0qH1AYKcjbq0bPQdPQ3NVkLHbrQVd6LYnWxk9D1JCXF8tieBxlgfN7iKc2QvsxO6h1SqRI+BF+D+wr/g5mNjW1a50qpLEnlv0W3F5l7uuj/sHsUoF5PGjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XY+qFRyLjORV5+QRlh2SDlR5zdo28YaXb1q0GrJHl7U=;
 b=LmPpVNLUe2Qm4wzl54+9MSFGgPM6iY5YECIeJKiNPZEWDq0qlBkOJ9arfzm7y7nEFP272zPuu4riokUM+F/FEhP68awDI2LUsZ2dgwP/j4yNmLpWOkhvn6ApWbW3w4pi2yG3YAVncPzQ+ninRneDBA/E4wvgkJsbIt2cWqYyF1U=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GVXPR83MB0735.EURPRD83.prod.outlook.com (2603:10a6:150:21c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.2; Wed, 16 Jul
 2025 19:37:31 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8964.010; Wed, 16 Jul 2025
 19:37:30 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3] Cygwin: configure: add possibility to skip build of
 cygserver and utils
Thread-Topic: [PATCH v3] Cygwin: configure: add possibility to skip build of
 cygserver and utils
Thread-Index: AQHb9okRyJiTAclXMEmCh8eqXRXU7Q==
Date: Wed, 16 Jul 2025 19:37:30 +0000
Message-ID:
 <DB9PR83MB09237AD6BA4BFE16B03AEBD99256A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB09232A0A1E4EC3D43BBAFA089242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923C35FB2253C8C2A21927C9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <52fd7877-6abc-4e01-8f3c-405cf075b1ff@dronecode.org.uk>
In-Reply-To: <52fd7877-6abc-4e01-8f3c-405cf075b1ff@dronecode.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-16T19:37:26.208Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GVXPR83MB0735:EE_
x-ms-office365-filtering-correlation-id: 96505c69-bc2a-4f26-5775-08ddc4a0341f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?4uObcAfw3D6WiSHroSU5myzejoHCRPh6+Dp/t20dIuF6xwwnqKmjtUjb34?=
 =?iso-8859-2?Q?er7zisFsFgeeQuVK8ZNqOJy8JKJrSZTBDiz4rU21DiAaC1QC/54BRjYAtO?=
 =?iso-8859-2?Q?jNevoTwFzLqaRnfyS23c15SWKEQdTFZz/RISKNflEvLjDTTEi1O4qiy0LC?=
 =?iso-8859-2?Q?oM3FNoHt7mU0MENhR5d9u/ZdCI8KAB55uYVS6hS+kSFIV7CYnWKxZhPiUS?=
 =?iso-8859-2?Q?JajmvDLGWeyDf/aK3Bo5g0PfHzMhC2groIBHi20rBPPmXS6UKWOz5ds2YA?=
 =?iso-8859-2?Q?fcC1/e6DBUoUT7zg9Ek1GVqZwk7OPiqwxWd9n8tLSUhXq20icHo10o3LyD?=
 =?iso-8859-2?Q?2CsvrRaLLQYrvYcNJ/vvPW+ZHEPoAPeonOKnMte1u84DaiTEonTCb8NIcG?=
 =?iso-8859-2?Q?eyGERl+ihgwEy10nxms53N0w9aC8aKs33TERf6oITaz32A+j2vNetaKQvb?=
 =?iso-8859-2?Q?tWrEpo91vfRrmb1QaerY+rzVBvImVq3SNlsovUbL2H3VlJPooPEGm80/GR?=
 =?iso-8859-2?Q?72LlCpH+ZV2uVTSCWY7mxvA9gpYHJwbM3HFR1P7zDuh1ehoxQqsy2tQVXF?=
 =?iso-8859-2?Q?GseKEYgfHejUAzmNHIFtJBvTmCc8me+dnkL57Q4JA+BdpLTSM+PNgWEFo2?=
 =?iso-8859-2?Q?4fKeNZu/Ch6XTdffLndu59e57mHp2yQJCXW7BAvAVEetDVJJuxzYWO01Es?=
 =?iso-8859-2?Q?3wDVfMRJl1gG8rFLZLlaHAJiiqyuzk2ey5pMwGDb2+zqEUDzIG+8IB+plR?=
 =?iso-8859-2?Q?qaThTiQAWN/Oo+FlFeQ2l/w5s/KiG5MOUGYGlGtGBwYoqx1ufM21JgYRIc?=
 =?iso-8859-2?Q?xv3Fr/0sJXY9yvmLXxSgmWPQ7qqluFT/VHJTxvgf10FRlBoVwvnYXxzsQW?=
 =?iso-8859-2?Q?lKyg5dTShNYqpv4LQTKfVC2wczqrgZTvVXY49feWNTHZRfa42A1rZYszZs?=
 =?iso-8859-2?Q?Se5sZL7+YPFZQAOW3G1JA3xFjOt1/AgVMGrFSQ9vGCvV3YAEFaFafLdRQz?=
 =?iso-8859-2?Q?eYWlZReq0UxzmL0Xt4/7CCAICE3tz5zcjh8clOjQdplNujn9kCyqGbQmL0?=
 =?iso-8859-2?Q?LQvWgsG6XfXanjPb4qK9bg/oXm29hsXH6XqN9xeRJrxalQpq0qGmAKyT9Z?=
 =?iso-8859-2?Q?PZ6JAy6FEkxnT38FL6vVUMucG2AlFUZ+j7Dl+01eQuMTLaV+oI3/mV7tyH?=
 =?iso-8859-2?Q?m6XhR63SvUPuGo/5Pr9yoIOPKGT/0kmTRl9VwkX04czYWLl9ENKg+kQFLQ?=
 =?iso-8859-2?Q?5Cmz6dr+dAFicfMH+sG8F7IZVGycCiGvePLDjRv9VYUatfM3hod0x7Nmpp?=
 =?iso-8859-2?Q?s7CsQFQtpk7pDILN3Lip2ijSLrL/nfTDwUeXsfhrHogmv0ZGFSicnEEPC7?=
 =?iso-8859-2?Q?vEgJFIZ2pu4MXTY1Ue0DyWSt1/+Ii2Lee9zKM69MXXh/thf7cSbX0SZ/ze?=
 =?iso-8859-2?Q?NSbBsuakEqoQYhXUqpa9SHDoTWiH+PghJP1MIXRU6JQ2lEB7BmlE6k+4GT?=
 =?iso-8859-2?Q?grBMuXEVgMYAWOWMM9/aE/MtmdpjeZs4KdDzZ87YS3qmWz2RHBHwSLw9lg?=
 =?iso-8859-2?Q?3Nb4fm0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?AuaJYylOeP183SwsJWQaWDmv+f7zVXT+W/bbg7IdYolSUMbJR0CtuQNYok?=
 =?iso-8859-2?Q?hQtDWleZIsYJI8tfcfqlS9ZgMByvZhxWm20skLminLN3z1c+8srEQ/iRnx?=
 =?iso-8859-2?Q?9YrYc7uMxusiy8OEAB9eGYFB6VYEBdayZCYfTbYcc4Z1qi3wbCJvEEIS7m?=
 =?iso-8859-2?Q?YEECCSGxWVPJ+sTMvu/gJhfsJUipSaPbOnFt5tf8Wcxs1KfImkTZnH1OHd?=
 =?iso-8859-2?Q?0hAQQkxEzXm2qDx2nInRjpH91I7BA/EeT2sXSHvF7QLJm3KO3SOFPIJjiI?=
 =?iso-8859-2?Q?6erzVurwdl0rqYLOjYpZmUXGcW85N4bYav7PBvs/Txh7O5EdttcRTL4/YX?=
 =?iso-8859-2?Q?Q+Vetwo5nAcPIAjZTtEcoJZYmqtUrTvyiXkV0PZ+sA6D/VFjFnj9T0Rkp9?=
 =?iso-8859-2?Q?Mj29bYcb0pQEJVHlO0bcN0kWba5Pb8TmQvWdX74RMwtkK/o6qIL8N37knd?=
 =?iso-8859-2?Q?r47yeQSpm3vvE2Y5shHYLDjLTGKtW8oYnqnYEbTFnc4iDaYmC+lkGzZYlI?=
 =?iso-8859-2?Q?4eyOfiS16Lo84UpkBg+vQoB6vML20H07mgzLe/ZVw2MkOBJc2Ld0C4aB5F?=
 =?iso-8859-2?Q?/BpZO2LjlfahE/rtiAwFF4lCAC75pb6MhCqeRLR++z5NHJZEAV+od3NN8I?=
 =?iso-8859-2?Q?KGHrGnWQNDXGmwMyLz/PUumxHNCpLeyAVN25e92UW3MAVeend9fVSkyeVF?=
 =?iso-8859-2?Q?tsMEbNXKjHwvBrd5ufacw+lyMW2c+po4CqvjmGrdWtyMtwspsm4015h12+?=
 =?iso-8859-2?Q?1jEAl3BklSgSYx0NsnJAf9cDd/H3i5icPFsvbNUzMXhOqetpf/UibAhXiR?=
 =?iso-8859-2?Q?fKoJf9vLdwd04T7lj9E3FByGNp0wcnEuNEsuIC3Hw4HgPNF48fZ4hZH4x4?=
 =?iso-8859-2?Q?1su7PmyV4lGHKJNioVl8d9eGoOPSnjPUiDKKAUegivG/6C8lI/SJd0wfag?=
 =?iso-8859-2?Q?xU7bT9h8IRxB29mPFaS+F1Gvg2wmBMjRtbp0hHAoXCcuQtnezr/QbGD5GS?=
 =?iso-8859-2?Q?swTeU0H9RCVMz9Jvf92VVtJRnxteBU1silEnoLvArQ9STl2Ks0N5UktVXT?=
 =?iso-8859-2?Q?80K4PIHLXSpPno7hjRsv5ecakcn28kqiCxFxpQv7ltnL7u6scU0ufY/Lie?=
 =?iso-8859-2?Q?GUU8lF7X3qqaFclaeJPdLLYxlIa9xINlelAwabM+rblemqwLg6ysVqm5Ky?=
 =?iso-8859-2?Q?ERgaO7qC0PApChWhs4oX+mBw4fNMvy/+R2STPEEvvHbuqOC4K7lDuOaF49?=
 =?iso-8859-2?Q?nKzhKhiP7/sZ1LqAdyr8RTaSIzeP5aZu4qt5rxpX2GgHW7Tfy0JkTkWPb4?=
 =?iso-8859-2?Q?GANtXgLt+hTcJc02b7JPbboHj5TTO49ku6CU4PWm2aUTQy4Y0k7Im8Fux+?=
 =?iso-8859-2?Q?s8KJZp3AIxcx47yc8kay2czkDEb8e2maqhnXfIw36Lz3aLrdu9/FRRwjdL?=
 =?iso-8859-2?Q?mlok5X+cbZ/aGGFukD9UVHkXodDS+0c6msD9cAXqG/DqXeRKIwgCMbtIhu?=
 =?iso-8859-2?Q?3CJsNdiFj4GiVvBgqH/zLt5xZgY09A7u4Z+LwKz6U3R8gyMmnx1FLjWy7R?=
 =?iso-8859-2?Q?6Go9Vwy+JYyq1FjLdGjgbEIMhkwp?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09237AD6BA4BFE16B03AEBD99256ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96505c69-bc2a-4f26-5775-08ddc4a0341f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 19:37:30.4550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HW37RsALGmc3KFknILwOQm9zjiJDSFMUG1oW9RWrayoVJOLUfrIFo4KqJIlSYhIcJz7GrvPvY8RawNsezgs0A/EHxgf3Rar/HPBiokKaRoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0735
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09237AD6BA4BFE16B03AEBD99256ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
I was going to submit `--disable-utils` as a separate patch but in the cont=
ext adding the FAQ, it makes sense to include it to a single patch together=
.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From f0240097f681335c6b2373f4a04685ee687bdeef Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 21 Jun 2025 22:56:58 +0200=0A=
Subject: [PATCH v3] Cygwin: configure: add possibility to skip build of=0A=
 cygserver and utils=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch adds configure options allowing to disable build of cygserver=0A=
and Cygwin utilities. This is useful when one needs to build only=0A=
cygwin1.dll and crt0.o with stage1 compiler that is not yet capable of=0A=
linking executables as it is missing cygwin1.dll and crt0.o.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/Makefile.am             | 20 ++++++++++++++++++--=0A=
 winsup/configure.ac            | 12 ++++++++++++=0A=
 winsup/cygserver/Makefile.am   |  2 ++=0A=
 winsup/doc/faq-programming.xml | 14 +++++++++++++-=0A=
 4 files changed, 45 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/winsup/Makefile.am b/winsup/Makefile.am=0A=
index 9efdd4cb1..877c4e6b9 100644=0A=
--- a/winsup/Makefile.am=0A=
+++ b/winsup/Makefile.am=0A=
@@ -14,10 +14,26 @@ cygdoc_DATA =3D \=0A=
 	CYGWIN_LICENSE \=0A=
 	COPYING=0A=
 =0A=
-SUBDIRS =3D cygwin cygserver utils testsuite=0A=
+SUBDIRS =3D cygwin testsuite=0A=
+=0A=
+if BUILD_CYGSERVER=0A=
+SUBDIRS +=3D cygserver=0A=
+endif=0A=
+=0A=
+if BUILD_UTILS=0A=
+SUBDIRS +=3D utils=0A=
+endif=0A=
 =0A=
 if BUILD_DOC=0A=
 SUBDIRS +=3D doc=0A=
 endif=0A=
 =0A=
-cygserver utils testsuite: cygwin=0A=
+testsuite: cygwin=0A=
+=0A=
+if BUILD_CYGSERVER=0A=
+cygserver: cygwin=0A=
+endif=0A=
+=0A=
+if BUILD_UTILS=0A=
+utils: cygwin=0A=
+endif=0A=
diff --git a/winsup/configure.ac b/winsup/configure.ac=0A=
index 18adf3d97..e7ac814b1 100644=0A=
--- a/winsup/configure.ac=0A=
+++ b/winsup/configure.ac=0A=
@@ -83,6 +83,18 @@ AC_ARG_ENABLE(doc,=0A=
 	      enable_doc=3Dyes)=0A=
 AM_CONDITIONAL(BUILD_DOC, [test $enable_doc !=3D "no"])=0A=
 =0A=
+# Disabling build of cygserver and utils is needed for zero-bootstrap buil=
d of=0A=
+# stage 1 Cygwin toolchain where the linker is not able to produce executa=
bles=0A=
+# yet.=0A=
+AC_ARG_ENABLE(cygserver,=0A=
+	      [AS_HELP_STRING([--disable-cygserver], [do not build cygserver])],,=
=0A=
+	      enable_cygserver=3Dyes)=0A=
+AM_CONDITIONAL(BUILD_CYGSERVER, [test $enable_cygserver !=3D "no"])=0A=
+AC_ARG_ENABLE(utils,=0A=
+	      [AS_HELP_STRING([--disable-utils], [do not build utils])],,=0A=
+	      enable_utils=3Dyes)=0A=
+AM_CONDITIONAL(BUILD_UTILS, [test $enable_utils !=3D "no"])=0A=
+=0A=
 AC_CHECK_PROGS([DOCBOOK2XTEXI], [docbook2x-texi db2x_docbook2texi])=0A=
 if test -z "$DOCBOOK2XTEXI" ; then=0A=
     if test "x$enable_doc" !=3D "xno"; then=0A=
diff --git a/winsup/cygserver/Makefile.am b/winsup/cygserver/Makefile.am=0A=
index ec7a62240..efb578e53 100644=0A=
--- a/winsup/cygserver/Makefile.am=0A=
+++ b/winsup/cygserver/Makefile.am=0A=
@@ -12,7 +12,9 @@ cygserver_flags=3D$(cxxflags_common) -Wimplicit-fallthrou=
gh=3D5 -Werror -DSYSCONFDIR=0A=
 AM_CXXFLAGS =3D $(CFLAGS)=0A=
 =0A=
 noinst_LIBRARIES =3D libcygserver.a=0A=
+if BUILD_CYGSERVER=0A=
 sbin_PROGRAMS =3D cygserver=0A=
+endif=0A=
 bin_SCRIPTS =3D cygserver-config=0A=
 =0A=
 cygserver_SOURCES =3D \=0A=
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0A=
index 39610b916..1090c5507 100644=0A=
--- a/winsup/doc/faq-programming.xml=0A=
+++ b/winsup/doc/faq-programming.xml=0A=
@@ -698,8 +698,20 @@ Building these programs can be disabled with the <lite=
ral>--without-cross-bootst=0A=
 option to <literal>configure</literal>.=0A=
 </para>=0A=
 =0A=
+<para>=0A=
+Build of <literal>cygserver</literal> can be skipped with=0A=
+<literal>--disable-cygserver</literal> and build of other Cygwin utilities=
 with=0A=
+<literal>--disable-utils</literal>. This is particularly useful (together=
=0A=
+with <literal>--without-cross-bootstrap</literal> and=0A=
+<literal>--disable-dumper</literal> options) when only=0A=
+<literal>cygwin1.dll</literal> and <literal>crt0.o</literal> are needed fo=
r=0A=
+stage2 compiler when being built with stage1 compiler which does not suppo=
rt=0A=
+linking executables yet (because of missing <literal>cygwin1.dll</literal>=
 and=0A=
+<literal>crt0.o</literal>).=0A=
+</para>=0A=
+=0A=
 <!-- If you want to run the tests <literal>busybox</literal> and=0A=
-     <literal>cygutils-extra<literal> are also required. -->=0A=
+     <literal>cygutils-extra</literal> are also required. -->=0A=
 =0A=
 <para>=0A=
 Building the documentation also requires the <literal>dblatex</literal>,=
=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB09237AD6BA4BFE16B03AEBD99256ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v3-0001-Cygwin-configure-add-possibility-to-skip-build-of-cygserver-and-utils.patch"
Content-Description:
 v3-0001-Cygwin-configure-add-possibility-to-skip-build-of-cygserver-and-utils.patch
Content-Disposition: attachment;
	filename="v3-0001-Cygwin-configure-add-possibility-to-skip-build-of-cygserver-and-utils.patch";
	size=4143; creation-date="Wed, 16 Jul 2025 19:37:02 GMT";
	modification-date="Wed, 16 Jul 2025 19:37:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmMDI0MDA5N2Y2ODEzMzVjNmIyMzczZjRhMDQ2ODVlZTY4N2JkZWVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAyMSBKdW4gMjAyNSAyMjo1Njo1OCAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjNdIEN5Z3dpbjogY29uZmlndXJlOiBhZGQgcG9zc2liaWxp
dHkgdG8gc2tpcCBidWlsZCBvZgogY3lnc2VydmVyIGFuZCB1dGlscwpNSU1FLVZlcnNpb246IDEu
MApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zl
ci1FbmNvZGluZzogOGJpdAoKVGhpcyBwYXRjaCBhZGRzIGNvbmZpZ3VyZSBvcHRpb25zIGFsbG93
aW5nIHRvIGRpc2FibGUgYnVpbGQgb2YgY3lnc2VydmVyCmFuZCBDeWd3aW4gdXRpbGl0aWVzLiBU
aGlzIGlzIHVzZWZ1bCB3aGVuIG9uZSBuZWVkcyB0byBidWlsZCBvbmx5CmN5Z3dpbjEuZGxsIGFu
ZCBjcnQwLm8gd2l0aCBzdGFnZTEgY29tcGlsZXIgdGhhdCBpcyBub3QgeWV0IGNhcGFibGUgb2YK
bGlua2luZyBleGVjdXRhYmxlcyBhcyBpdCBpcyBtaXNzaW5nIGN5Z3dpbjEuZGxsIGFuZCBjcnQw
Lm8uCgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0
LmNvbT4KLS0tCiB3aW5zdXAvTWFrZWZpbGUuYW0gICAgICAgICAgICAgfCAyMCArKysrKysrKysr
KysrKysrKystLQogd2luc3VwL2NvbmZpZ3VyZS5hYyAgICAgICAgICAgIHwgMTIgKysrKysrKysr
KysrCiB3aW5zdXAvY3lnc2VydmVyL01ha2VmaWxlLmFtICAgfCAgMiArKwogd2luc3VwL2RvYy9m
YXEtcHJvZ3JhbW1pbmcueG1sIHwgMTQgKysrKysrKysrKysrKy0KIDQgZmlsZXMgY2hhbmdlZCwg
NDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvTWFr
ZWZpbGUuYW0gYi93aW5zdXAvTWFrZWZpbGUuYW0KaW5kZXggOWVmZGQ0Y2IxLi44NzdjNGU2Yjkg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9NYWtlZmlsZS5hbQorKysgYi93aW5zdXAvTWFrZWZpbGUuYW0K
QEAgLTE0LDEwICsxNCwyNiBAQCBjeWdkb2NfREFUQSA9IFwKIAlDWUdXSU5fTElDRU5TRSBcCiAJ
Q09QWUlORwogCi1TVUJESVJTID0gY3lnd2luIGN5Z3NlcnZlciB1dGlscyB0ZXN0c3VpdGUKK1NV
QkRJUlMgPSBjeWd3aW4gdGVzdHN1aXRlCisKK2lmIEJVSUxEX0NZR1NFUlZFUgorU1VCRElSUyAr
PSBjeWdzZXJ2ZXIKK2VuZGlmCisKK2lmIEJVSUxEX1VUSUxTCitTVUJESVJTICs9IHV0aWxzCitl
bmRpZgogCiBpZiBCVUlMRF9ET0MKIFNVQkRJUlMgKz0gZG9jCiBlbmRpZgogCi1jeWdzZXJ2ZXIg
dXRpbHMgdGVzdHN1aXRlOiBjeWd3aW4KK3Rlc3RzdWl0ZTogY3lnd2luCisKK2lmIEJVSUxEX0NZ
R1NFUlZFUgorY3lnc2VydmVyOiBjeWd3aW4KK2VuZGlmCisKK2lmIEJVSUxEX1VUSUxTCit1dGls
czogY3lnd2luCitlbmRpZgpkaWZmIC0tZ2l0IGEvd2luc3VwL2NvbmZpZ3VyZS5hYyBiL3dpbnN1
cC9jb25maWd1cmUuYWMKaW5kZXggMThhZGYzZDk3Li5lN2FjODE0YjEgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jb25maWd1cmUuYWMKKysrIGIvd2luc3VwL2NvbmZpZ3VyZS5hYwpAQCAtODMsNiArODMs
MTggQEAgQUNfQVJHX0VOQUJMRShkb2MsCiAJICAgICAgZW5hYmxlX2RvYz15ZXMpCiBBTV9DT05E
SVRJT05BTChCVUlMRF9ET0MsIFt0ZXN0ICRlbmFibGVfZG9jICE9ICJubyJdKQogCisjIERpc2Fi
bGluZyBidWlsZCBvZiBjeWdzZXJ2ZXIgYW5kIHV0aWxzIGlzIG5lZWRlZCBmb3IgemVyby1ib290
c3RyYXAgYnVpbGQgb2YKKyMgc3RhZ2UgMSBDeWd3aW4gdG9vbGNoYWluIHdoZXJlIHRoZSBsaW5r
ZXIgaXMgbm90IGFibGUgdG8gcHJvZHVjZSBleGVjdXRhYmxlcworIyB5ZXQuCitBQ19BUkdfRU5B
QkxFKGN5Z3NlcnZlciwKKwkgICAgICBbQVNfSEVMUF9TVFJJTkcoWy0tZGlzYWJsZS1jeWdzZXJ2
ZXJdLCBbZG8gbm90IGJ1aWxkIGN5Z3NlcnZlcl0pXSwsCisJICAgICAgZW5hYmxlX2N5Z3NlcnZl
cj15ZXMpCitBTV9DT05ESVRJT05BTChCVUlMRF9DWUdTRVJWRVIsIFt0ZXN0ICRlbmFibGVfY3ln
c2VydmVyICE9ICJubyJdKQorQUNfQVJHX0VOQUJMRSh1dGlscywKKwkgICAgICBbQVNfSEVMUF9T
VFJJTkcoWy0tZGlzYWJsZS11dGlsc10sIFtkbyBub3QgYnVpbGQgdXRpbHNdKV0sLAorCSAgICAg
IGVuYWJsZV91dGlscz15ZXMpCitBTV9DT05ESVRJT05BTChCVUlMRF9VVElMUywgW3Rlc3QgJGVu
YWJsZV91dGlscyAhPSAibm8iXSkKKwogQUNfQ0hFQ0tfUFJPR1MoW0RPQ0JPT0syWFRFWEldLCBb
ZG9jYm9vazJ4LXRleGkgZGIyeF9kb2Nib29rMnRleGldKQogaWYgdGVzdCAteiAiJERPQ0JPT0sy
WFRFWEkiIDsgdGhlbgogICAgIGlmIHRlc3QgIngkZW5hYmxlX2RvYyIgIT0gInhubyI7IHRoZW4K
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWdzZXJ2ZXIvTWFrZWZpbGUuYW0gYi93aW5zdXAvY3lnc2Vy
dmVyL01ha2VmaWxlLmFtCmluZGV4IGVjN2E2MjI0MC4uZWZiNTc4ZTUzIDEwMDY0NAotLS0gYS93
aW5zdXAvY3lnc2VydmVyL01ha2VmaWxlLmFtCisrKyBiL3dpbnN1cC9jeWdzZXJ2ZXIvTWFrZWZp
bGUuYW0KQEAgLTEyLDcgKzEyLDkgQEAgY3lnc2VydmVyX2ZsYWdzPSQoY3h4ZmxhZ3NfY29tbW9u
KSAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTUgLVdlcnJvciAtRFNZU0NPTkZESVIKIEFNX0NYWEZM
QUdTID0gJChDRkxBR1MpCiAKIG5vaW5zdF9MSUJSQVJJRVMgPSBsaWJjeWdzZXJ2ZXIuYQoraWYg
QlVJTERfQ1lHU0VSVkVSCiBzYmluX1BST0dSQU1TID0gY3lnc2VydmVyCitlbmRpZgogYmluX1ND
UklQVFMgPSBjeWdzZXJ2ZXItY29uZmlnCiAKIGN5Z3NlcnZlcl9TT1VSQ0VTID0gXApkaWZmIC0t
Z2l0IGEvd2luc3VwL2RvYy9mYXEtcHJvZ3JhbW1pbmcueG1sIGIvd2luc3VwL2RvYy9mYXEtcHJv
Z3JhbW1pbmcueG1sCmluZGV4IDM5NjEwYjkxNi4uMTA5MGM1NTA3IDEwMDY0NAotLS0gYS93aW5z
dXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWwKKysrIGIvd2luc3VwL2RvYy9mYXEtcHJvZ3JhbW1p
bmcueG1sCkBAIC02OTgsOCArNjk4LDIwIEBAIEJ1aWxkaW5nIHRoZXNlIHByb2dyYW1zIGNhbiBi
ZSBkaXNhYmxlZCB3aXRoIHRoZSA8bGl0ZXJhbD4tLXdpdGhvdXQtY3Jvc3MtYm9vdHN0CiBvcHRp
b24gdG8gPGxpdGVyYWw+Y29uZmlndXJlPC9saXRlcmFsPi4KIDwvcGFyYT4KIAorPHBhcmE+CitC
dWlsZCBvZiA8bGl0ZXJhbD5jeWdzZXJ2ZXI8L2xpdGVyYWw+IGNhbiBiZSBza2lwcGVkIHdpdGgK
KzxsaXRlcmFsPi0tZGlzYWJsZS1jeWdzZXJ2ZXI8L2xpdGVyYWw+IGFuZCBidWlsZCBvZiBvdGhl
ciBDeWd3aW4gdXRpbGl0aWVzIHdpdGgKKzxsaXRlcmFsPi0tZGlzYWJsZS11dGlsczwvbGl0ZXJh
bD4uIFRoaXMgaXMgcGFydGljdWxhcmx5IHVzZWZ1bCAodG9nZXRoZXIKK3dpdGggPGxpdGVyYWw+
LS13aXRob3V0LWNyb3NzLWJvb3RzdHJhcDwvbGl0ZXJhbD4gYW5kCis8bGl0ZXJhbD4tLWRpc2Fi
bGUtZHVtcGVyPC9saXRlcmFsPiBvcHRpb25zKSB3aGVuIG9ubHkKKzxsaXRlcmFsPmN5Z3dpbjEu
ZGxsPC9saXRlcmFsPiBhbmQgPGxpdGVyYWw+Y3J0MC5vPC9saXRlcmFsPiBhcmUgbmVlZGVkIGZv
cgorc3RhZ2UyIGNvbXBpbGVyIHdoZW4gYmVpbmcgYnVpbHQgd2l0aCBzdGFnZTEgY29tcGlsZXIg
d2hpY2ggZG9lcyBub3Qgc3VwcG9ydAorbGlua2luZyBleGVjdXRhYmxlcyB5ZXQgKGJlY2F1c2Ug
b2YgbWlzc2luZyA8bGl0ZXJhbD5jeWd3aW4xLmRsbDwvbGl0ZXJhbD4gYW5kCis8bGl0ZXJhbD5j
cnQwLm88L2xpdGVyYWw+KS4KKzwvcGFyYT4KKwogPCEtLSBJZiB5b3Ugd2FudCB0byBydW4gdGhl
IHRlc3RzIDxsaXRlcmFsPmJ1c3lib3g8L2xpdGVyYWw+IGFuZAotICAgICA8bGl0ZXJhbD5jeWd1
dGlscy1leHRyYTxsaXRlcmFsPiBhcmUgYWxzbyByZXF1aXJlZC4gLS0+CisgICAgIDxsaXRlcmFs
PmN5Z3V0aWxzLWV4dHJhPC9saXRlcmFsPiBhcmUgYWxzbyByZXF1aXJlZC4gLS0+CiAKIDxwYXJh
PgogQnVpbGRpbmcgdGhlIGRvY3VtZW50YXRpb24gYWxzbyByZXF1aXJlcyB0aGUgPGxpdGVyYWw+
ZGJsYXRleDwvbGl0ZXJhbD4sCi0tIAoyLjUwLjEudmZzLjAuMAoK

--_002_DB9PR83MB09237AD6BA4BFE16B03AEBD99256ADB9PR83MB0923EURP_--
