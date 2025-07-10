Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20721.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::721])
	by sourceware.org (Postfix) with ESMTPS id 88DCA3858CD9
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 13:09:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 88DCA3858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 88DCA3858CD9
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::721
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752152963; cv=pass;
	b=bEYVDbHiKryE2fq8Gp0WoWhNt51jLkdKvFY+9V1QNyc6NKWDfzrxpSP97EQam/Q7WMK2xh2XDFwgua4WBi3a/pwgRslnWU/nGsBFQ7bwieuGgsc5etgHddQWD2meKjc0hX5g8j0y4syoK/6NSRetaU+mquQbSdbfJ4lkxMJNVKk=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752152963; c=relaxed/simple;
	bh=Dbm5L4QudbIesSGQDpAKaIx4rQBTNo/wMSpTmISYP60=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=tuHb7EEfmt8j19N7dIXvOhghmEAqZ9+1O7sNx2oktopbC5ph/T1VuJUmlGufB50l3dzkI96XyctSlHH+yvVoy/qQkxqx1Ug/HFGin6f4FOiUMALhwiYuGZR3LLWi6NfLvxxY201FyzVwMGtxspwpFyFDmWmdKezBMVukNkbhZpw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 88DCA3858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=ibMcQjtu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egndD0CCoZ5+5vGhzlVLmt0hDX9Y6GQmxfV92JjCFBrlMtUbuZYyZb8JjkH9H1jFpDMQLks+q5uIPfkhkxrKLVmGHpe09YOMu3MPYQlFDBzSFztITd+DpT8Whk+8Gvge2WtWneXVm6/dDaBmWdon8owK+Uw4J3xmXz5wzLOmcQj7wP292vu3apxvKaAB34aK+4QRvBlnUdi4tOcXO3YQCXcv3EsRvnV3dmo4GIWidWKQ9lM/0PPLR8bU5FZgG/iba8HBAZDeJ6FQtRSpH6oepiru843VeyrDTdnbkHTV2hoIS0BU2CyJe7/phWuizz0HafYjfSrZwhT5PLl+QInMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NUisrAdR1RFJgj9PsOu/syF2PAJutSVXa2WhjccghE=;
 b=WO7JXscOI5FYaWXVHJD43qQFiwVd9+p5zuiVshSqE66sF0Md79NgJC6kc0Her8+SylyiXG7V/WrWMty1/CjmGlArxwQgNxnEXwdos9HYuTb74vBNwVH1iiirq5YOyAb0lq8kR68rPQVnksT01X919QGqIzoakI/VWQacMbFyPE5ydwdR4i9fdpJwTuUD9Qa1GP1dKmgkHXpIlbNhwLhTMfVyzJsQCuuYfqjVLtXGenEtbrVIdcN/tZKXT1BW9CP6OcfO5UjpTfHM1MDMRW7ZpAHrmEhlPbWDzFgu5wudPwcFvBHLVEOxQ+15lZ4elG4r9qLUGIA8LffgqZ/hgqJXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NUisrAdR1RFJgj9PsOu/syF2PAJutSVXa2WhjccghE=;
 b=ibMcQjtud83JFPydHLj6Sl8XcmqR8ign3mrKr9uOJpAvv+g/Be4QlvT2EXCw9b3Fy1BJ3D+Vs2aKvWmSBo+DgYKH7Vu/Pv0iQaBNO87XtbPPmGfD255lV0VFpNL98vGId5X1nhAM73G8F0lXdOnXPA+2OKzJODZIjws1pxwQHak=
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com (2603:10a6:150:27e::22)
 by GV2PR83MB0860.EURPRD83.prod.outlook.com (2603:10a6:150:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Thu, 10 Jul
 2025 13:09:19 +0000
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a]) by GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a%4]) with mapi id 15.20.8922.011; Thu, 10 Jul 2025
 13:09:19 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: add dummy declaration of _fe_nomask_env
Thread-Topic: [PATCH] Cygwin: add dummy declaration of _fe_nomask_env
Thread-Index: AQHb8ZtU+XNtUTQ0R0a7bNNYq/rXJw==
Date: Thu, 10 Jul 2025 13:09:18 +0000
Message-ID:
 <GV4PR83MB0941FE057826A88BE430A9409248A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T13:09:16.282Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV4PR83MB0941:EE_|GV2PR83MB0860:EE_
x-ms-office365-filtering-correlation-id: fd0c1221-220d-41de-26f7-08ddbfb2faaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?SVNqYKbQg7X72ja+EGVOvR+1u7S1Dfcer73TiL+Ln2TyZnhWAvQMMD1cr+?=
 =?iso-8859-2?Q?bFzVpmBEyTK2jtpb/R5lLnXcTHff7vXDgkDawJzxyj0u48Ms8AxDaM9H6W?=
 =?iso-8859-2?Q?+44gOHzsssnuis4m/b2iM9NIjMtx46E4XE0kVGzC3T97JG7E3EZzGLpERz?=
 =?iso-8859-2?Q?vuDvNpC4nNh2468VvRIyLOvtmbj8w/3ri7XQlBFfmrtdHzOKngiwijM06j?=
 =?iso-8859-2?Q?0g91PKnUZc6ipsRASKTAYJvizbHhnQLgipBOgvDVr62IRum3S5ofgmV5J3?=
 =?iso-8859-2?Q?xnzwdt7vZ4fWEsM8tcFQJIPHPOigIhpt4JAQBmud8aPQGaYg4BnXlXEU3I?=
 =?iso-8859-2?Q?R604BdpTLt9rK670BYLmo0OARFSFFbyx5TkTJVtoDiYUz60iM+Jcv3Owvm?=
 =?iso-8859-2?Q?JTOuQCWBHKd0ZlhUlR1tTadyILumLjsVRaGrmbe+AjfMdO0s8Yf97bG/y1?=
 =?iso-8859-2?Q?zC2g2q/DwGsxph0nazi1DyYqmMLVMV5iBl+HeEZE8Bnouqjw3Q/58zAecv?=
 =?iso-8859-2?Q?ziX4Hpi9b2Qh/OWydlOk/ibvI6cVyhBbqAdRDZq0JOMy5LXznYHH8ILVF4?=
 =?iso-8859-2?Q?mHN2l3jt8ThXgR4t41I7vOsRV407xYJH++hpojA9rN9RaKd3Wyd5FDWTK2?=
 =?iso-8859-2?Q?O9aUH3nI+uNGt/RoJJjHHH19ia5IjDThJayhUH4vnQ++eKwwnu+vE8IjMi?=
 =?iso-8859-2?Q?qnl0Dk+HCEOjfL84cQmrCnPlb0ov12pjtJh1zxEE+pv8R7mruwTvdPZOCs?=
 =?iso-8859-2?Q?MjccyryT3xqvEXCpnhCtq8uK/M+Szqp5bpmuEIdvizkQBTKKig/XrsO5Wk?=
 =?iso-8859-2?Q?1eM8J7RufAcexzsZd6GVXZmzvuXfjOn4SCN7Xwk+Ihr2qprO4jwGBhp0zF?=
 =?iso-8859-2?Q?QEAb+M7iBDPlvlprlWThL4DRKyi/ilwW75WT8hhZ+iuD0fyAxVaX01HrnZ?=
 =?iso-8859-2?Q?ZbQaBLMLi2Frp45ZYLHIhsC5dT8AkY9XK/EchfAAGmAuwIfo1OHmeqGcR7?=
 =?iso-8859-2?Q?jH6Cb0AXJokXM7UbEyFl+z45Vzst+iUR3w8od3PMjtJ2nIukBHMTp1wvjo?=
 =?iso-8859-2?Q?2ZQz5/sCelyqlcjtX7JGUPq7kBR2/wboWNfHE2lpHD0dEUNfIHLXfc1wyw?=
 =?iso-8859-2?Q?0oJ2yfg89ccQckyVdiusO1p9CmY3IOYb0ugGVivB+0IgVsZgNrLW6dJfLn?=
 =?iso-8859-2?Q?bnvyDU+v3ckskmxsNxO2N8FpZQbXt03Tbc1NNPiO6JSit8MENt77dVQnZw?=
 =?iso-8859-2?Q?kj6KshuzbdLX+SPULPjkkZqaXLgB82vah7EPiAOFEkx2zcVw8FMz86pvEW?=
 =?iso-8859-2?Q?yCeFxShtriUo7pFQKrvcIsMqGKz8nBpqcRG7tBi16WiOwsBZpfji9llcWk?=
 =?iso-8859-2?Q?HYzf0OPfgn0BLX7mN3OypoMm3YOpCQKRMsdf/gI0KMXpUjZx4L5+u2zt65?=
 =?iso-8859-2?Q?WFTAZjAtfIyQe5DdBIpkf0YKSkRkSbCq2Vlv44ghqBKw2DO0hFbp1eOSBg?=
 =?iso-8859-2?Q?cMAE5nX27FRCR4vMaOolE0glYLBoBpXPww9qMiAfeKwA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV4PR83MB0941.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?vEcA7eOaunEoaiKLzxVeQDt6cbGsAiQymQ1FNPasQDmzWYOa9y54R1Hwqm?=
 =?iso-8859-2?Q?C3u3iXGl7Fnz2YZ7MFtA+Kdl7D05BHWU0STZN4K15Lt8R44aGat5syuqVv?=
 =?iso-8859-2?Q?E/scJJu2n33PPtdiRfuuRPLS9O4y1XQhpj5EqUiZBWCnOkEVm15+u8HAZ7?=
 =?iso-8859-2?Q?khon9FgeI8qxaNdS0Ma07ECOg18EqDovEp77bfc38kS0vChkD7z3BQCZbv?=
 =?iso-8859-2?Q?qXlDtWPQ/w2hov/XO13/vzxRzub0DfBhbFu1/TAZCwpkCOKcR4+uDm4RXY?=
 =?iso-8859-2?Q?Kn+bD6O4KgwvcI2KzMzUNx45Q+HPDfhB0YZ9UnVPtFPvoFaK+iZiizYkfP?=
 =?iso-8859-2?Q?y1hgSapobeE0i9xnL8K7yednpW5PRwFOv0IbeOL0LWVpDdH1LxpRLCOmVI?=
 =?iso-8859-2?Q?1+HGgrFSV/AcC6XW8D5sCjsM+ahEGcZYHyjhXvhcVjfJeQb6mmlikzX5Q4?=
 =?iso-8859-2?Q?uwt8mWHCnr8Vf74Hx5qxUBagL1UuChA+wNqyLN+adG0Vo77aUhn2oLskV5?=
 =?iso-8859-2?Q?NZECXFbc4dKxIds1opP+CkBzh55jx5W+xHmr4AN1xOF/QxhCACIaiPpXhv?=
 =?iso-8859-2?Q?2u8dWicqy5/6NJmNlrCMCidEuT6IrCdUz4acCR5ebkhV+KXvbLm9A04XlZ?=
 =?iso-8859-2?Q?kpJRUDTZFttFgo+lp20OENUUJdwrYP0L49weor4e/Biy+5XRP4NNBLMRPF?=
 =?iso-8859-2?Q?U9uu76Ndw2motYGEyzbK+shRq0dY1CxhCS3hqIwvzdG/zuesTfltpfpZcM?=
 =?iso-8859-2?Q?Cr0+bgyQBudVSUHduN2xQunVmwgehQobRWHK8QIkVnJ5eLbTBhJ337TRqe?=
 =?iso-8859-2?Q?+bntnmSN/2gNF2nJKUI+z0XQnoaQZBNe+FkEqp8RlZ0fD9DBRJxYhTOWVo?=
 =?iso-8859-2?Q?ooUsKpxWKaaEVsMUKEG0gRjYNcbAGX/IPYXBDO2elbNLZmwHbGSgZ0wGIp?=
 =?iso-8859-2?Q?mYPdb7fZ+XgRnceWqAfF/rXXtfhq5n9170JluGdqOFe7/JGvkdaByiPgc/?=
 =?iso-8859-2?Q?qQuD1erbNUaksWuKC2dkFqendJrB/GdIacB6GfSEkXLxnmuCNxaDUf2xFo?=
 =?iso-8859-2?Q?d1uohHx5TT/VM5iHyuvq1cYrjnHbnTHc1uLC7VP/1VYY/ivRI1lxZJpuLy?=
 =?iso-8859-2?Q?bcVPQcqwV+uHAq2QLsuCba+IsFun3ouazNS4oup/qGG6CbVm4RDJDeZ0zs?=
 =?iso-8859-2?Q?Toia5tBc6gyXPx2fWkKss5q2xjooU3Hj9wfwPsI2oLgn49h1hXsLBj7jn1?=
 =?iso-8859-2?Q?XfzUL8V7Sz/S1aFfdUfOj9/h/7+Cf6N8WjwivgsMWsdm4FJb/FaWBZ2wxG?=
 =?iso-8859-2?Q?fUWf0eiHCrq04QcG422IdRiWnChKaEur3/I43c9Q8Z9v4TkVETR2eWQFTD?=
 =?iso-8859-2?Q?PCeaeiIGfci3rVBWlITchksPR4Gwj6dFQxJLnajdfRM96az+9OoOzW28ks?=
 =?iso-8859-2?Q?/CMmoZQB9qrgU8ufbeK5rWFkZVuIzkic9YnZCubI7iwq/H5XO+tr7+it6L?=
 =?iso-8859-2?Q?Y6IklvHH2jQiDc+i+aLMo+6NMGpa0surkBhZah79IDr3RiLUwSOvj6x7HN?=
 =?iso-8859-2?Q?4ehmsT5oyzIf/AjRePk858/72f5q?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV4PR83MB0941.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0c1221-220d-41de-26f7-08ddbfb2faaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 13:09:18.6640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elHe9UTip5e8c+UYwQbyw1lFrt530yDuL1aalZRShtgBQDHRpDTNhnNPRHU1jtfp/c1YJoBxpiVqPP6pzHfigKmZCS/O9VNegjtJk0BUGME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR83MB0860
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello=0A=
=0A=
This patch adds dummy declaration of `_fe_nomask_env` which is exported by =
`cygwin.din` but not used for AArch64 at all.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 95803dff2ba531db12342c61f238d7d2ee0c7d80 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 3 Jul 2025 12:00:52 +0200=0A=
Subject: [PATCH] Cygwin: add dummy declaration of _fe_nomask_env=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
_fe_nomask_env is exported by cygwin.din but not used for AArch64 at all.=
=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/fenv.c | 10 ++++++++++=0A=
 1 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/winsup/cygwin/fenv.c b/winsup/cygwin/fenv.c=0A=
index 80f7cc52c..1558f76c2 100644=0A=
--- a/winsup/cygwin/fenv.c=0A=
+++ b/winsup/cygwin/fenv.c=0A=
@@ -3,3 +3,13 @@=0A=
    being called from mainCRTStartup in crt0.o. */=0A=
 void _feinitialise (void)=0A=
 {}=0A=
+=0A=
+#if defined(__aarch64__)=0A=
+=0A=
+#include <fenv.h>=0A=
+#include <stddef.h>=0A=
+=0A=
+/* _fe_nomask_env is exported by cygwin.din but not used at all for AArch6=
4. */=0A=
+const fenv_t *_fe_nomask_env =3D NULL;=0A=
+=0A=
+#endif /* __aarch64__ */=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
     =
