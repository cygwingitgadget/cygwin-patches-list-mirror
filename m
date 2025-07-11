Return-Path: <SRS0=Rz1U=ZY=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::700])
	by sourceware.org (Postfix) with ESMTPS id 690F93857358
	for <cygwin-patches@cygwin.com>; Fri, 11 Jul 2025 09:20:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 690F93857358
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 690F93857358
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::700
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752225626; cv=pass;
	b=Il8yZ/cdNKQC9fG744nAfAVtjuqIwPekDDEC6VscK8d/wL+q3Clu9v/008trec2ZED91xen1Iey4j7d0p0Tq5pq/kakjl27oMfBK+WqmBeYpAxvsxKQk5o6UahXQhPkEL4tV0TlhnyEqJ+LiIbqFXK6V7CxekVFJFBmesGBVST0=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752225626; c=relaxed/simple;
	bh=BKGwCzHHseUN7/o9T108GMEZrYCWcemLgxAuxJqN+MQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=U3VeN4a1GN1XM59eyRNnddCerDw+t/yM61Qs47IiQFWAbC8y4RE5+l5sOeNJsNcG0nql/wCgmqOSVSUX4Mo1q0JuDNRwnzjxArxnqmcrkqVkJB8h/adtypf1IUkMPWWCQpvvksR1hfeLKPvvOSz0iaX/9FXus/RgAMMxcb1HPFw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 690F93857358
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=WpWIFA/j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDHcNTNUbrQmYApa5UVsHKgTvXfIhzWrkWjCjWczkcGMSEeMZrJoH4TQDPuuVu4RuXJjKg+VDwbfaLeD3DIVO/h+2lv2kcPIMID/9c6ZYkGNyg6nfCw+mwAXvRiZYJ271Gy0q7aWm+YXAjNP0TEQO2FFIEjtGCTVDTv47y14jGS9p5+ZB0dUpdyyHHHliGxxnKi0QJOFKQUCJsI1fGVoUAvWDlFnuN6or58PrVVXInmfgu3rUxrk+shdKPJp3ZNajKPaYnZj2sixfbnp3WIq3+Bc7ZrBWcJjaWewbvUhX+R2tD72amoFpi27Xcj1DoFrVKMQNi12jrx0yPuUeurvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsXCM5LecG0KUJ3zHxWSan2Fe5Whv7ChtfDfxdsgYUg=;
 b=DT+0VBesl8PzsL8bR31hJcWzdahCrW3eSDdGYMT/WQyy9Iy5BUS0LJDyA9UYZ15MhtuRmdWkUgUjk0H/gTZ47wnCI5e6frCLKCS8Mw84NxN0DpzrvXyPPLxrvvdYbFM7ZfTaZm63H7FlBxiusPDO8ILs4MblQOQxKmvaBgg759hulFdJO1gnD5pmSBA/r3WHM9NjYHHkprtAjqlsH2+GTGcZMANxxbSH6Pr+OMaTj3zdh7szhndYb+VtbrND49jjxrv+JsgOzv40r2+RtszacaeX/7ztihTSuSdR0j27hwcxRTvaVHDWWOaN4urhV2pJ61pF1Yt+dJVnTZgjr9HLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsXCM5LecG0KUJ3zHxWSan2Fe5Whv7ChtfDfxdsgYUg=;
 b=WpWIFA/jlEVyoaTiTSMLeIOx5JPycdtwuTTWplPOg9LOhL/EKMJOG8qJQ9tSkmGO3thdm/q6G6o25IUYrBKSs0blDhRD70B6oROA+XB++bw7Aq/DkPw9vGmAganAm7P3RsVaUzzuPU/irmc2/EAWwEEyKbQVyz7Fs7EJg1OhPKc=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0676.EURPRD83.prod.outlook.com (2603:10a6:150:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.22; Fri, 11 Jul
 2025 09:20:22 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%4]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 09:20:21 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: winchild: fix missing stdlib.h
Thread-Topic: [PATCH] Cygwin: winchild: fix missing stdlib.h
Thread-Index: AQHb8kS5ATwjlxDlukumffy4mQofcQ==
Date: Fri, 11 Jul 2025 09:20:21 +0000
Message-ID:
 <DB9PR83MB0923E35BD3BF01AA01217A45924BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-11T09:20:20.463Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0676:EE_
x-ms-office365-filtering-correlation-id: c2a88d79-1048-4f7e-9075-08ddc05c28ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?b6K3qZDBa5aTgwSoYsKL99rzwzDtfV6rJSIe4y9aXZuVjWZLmxeRfEzqCI?=
 =?iso-8859-2?Q?GrUAZE+8L0MVYdA9JcgJz8/jqwjCK28rwth0N1dS8n5Etxig3OmL6Gq3Ek?=
 =?iso-8859-2?Q?IRqMiwnM+pc/iHfZgUvHESFnqiTdRrzvHPJoxdLylILq+y1N4Mv1R7tZqs?=
 =?iso-8859-2?Q?FzQbCWvInt504lVU2J/NGjfsfCfO3s5dSqbvTQ0JeTQZPFLw3sKIG3ouvD?=
 =?iso-8859-2?Q?Wj6kBHvPBj3ALT7n6yLcUwQvpxSSKWfWDTHaPGMFNXDhsLSrVO4Em5Nx9j?=
 =?iso-8859-2?Q?TI1K0uUqXGwOb3PxrZlQvBpn7mpkiEP0NT43iX+cZVbZOs832AsV4maF7m?=
 =?iso-8859-2?Q?P5TiOFXKuM1n6mvdPYunYBtjz7w0ctlBKj35NwEFXnjtm/hH1FYmbI+GTI?=
 =?iso-8859-2?Q?MnIJclOIxhGYVedo8OwZNrp/aDfSdr8ptE+r1IL4WqZeQ8PbUGXtBtNbYB?=
 =?iso-8859-2?Q?K1CHgef1gIRaZGKUbqn7Jk3Zxfb0Y8Vci0+k5OXK8jdbCqoRCHPHHs2Nrh?=
 =?iso-8859-2?Q?75tnGj09yPE+uGp/lGE7ynHSxJxePBu5kOxNHoQSmSpb55xuC2z+5PyPUY?=
 =?iso-8859-2?Q?cFLc4He5wnb4Z3OX858GXocxgrUr6+9//DmJwtHKF7pX8DFcJr2yDFuHgJ?=
 =?iso-8859-2?Q?eEQ5GKK4g4ZGfninSSbv2Ugt27lNfeI6IxjAcDRsApK/vi4gTXAVtA8DbZ?=
 =?iso-8859-2?Q?9SHzPCHJ41CZhDDf4Ikr9uWrMb2tjwJ9FZ9b4AuwaSVCUVACpdLoMerjz3?=
 =?iso-8859-2?Q?4PxcOw4HcOSifN9nzOhu66nom9Azgk2a2Iahl4s97ExNTIb8veowEEOCTg?=
 =?iso-8859-2?Q?7ufKH6IOptHBOU5ke6JbvzUVAyNVm/P0AnCIZAJsZOOteM3nP5Oph1cuoU?=
 =?iso-8859-2?Q?N5TAJ9dv1bbn6uInXf/jpRcDeBi7lnMP5+wqD15hTQhtqXE9sgqb+CdOQ2?=
 =?iso-8859-2?Q?ni5Nux8s797MnBw82H57WeZbu3Qn2fWWOLx8t/wvJRZimX2lu1MoL90BiU?=
 =?iso-8859-2?Q?uusYtQZuFVjtPQmlQ5flWKUmqWkWc0tllmKmI0T6CRl71RbiT1p/SR4cVm?=
 =?iso-8859-2?Q?8mtFlYrTYkYw2c+mmhNHAQW1CqNOe5SE/tQz7Xk+Eh/tO+v6dSzalofm/d?=
 =?iso-8859-2?Q?yaoZzNU72L390Ewa7lki9Z2LTK92R7DNjYwCw8qjzDukpMuO3Tp8KW0DC8?=
 =?iso-8859-2?Q?YmfT/3p5XRnpLyVuRF9N4g3rzYu/a4nohix/cThBvk5Q7y9P1ZU9qce6rB?=
 =?iso-8859-2?Q?e67PXshQ/VgZrPcWjCHoUfjfSXiL7iRGTBfnTOn1VCI5t55vfq/tXJVguk?=
 =?iso-8859-2?Q?vDUrea2/yclgJYAF7BWRtY3bnVRQ7G+ox406VmNtn55uHgFN3hHEddKdEk?=
 =?iso-8859-2?Q?TZrPaCPaj6w8YfH8vULGhDqRxk7Ii9a5CtKzuAE3w73W3btaj9/avONyc2?=
 =?iso-8859-2?Q?rn4R3yIsdKAuMXlIZdlLBRcaTnKvRtxbPsEI9ghgnUe0HN1thiTGHSTq0q?=
 =?iso-8859-2?Q?y70If2uNaDIKUoJrw3fvJO/rnvGtQxrZbZ6y+qsz7nNQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?oWsx5P9rXXeOrj+HQuWD9lpzymFV0QybkQTgCz1XoMc8PLrTVR/zFEOP91?=
 =?iso-8859-2?Q?MtPQ/Kkg+yAcGIETuOhpVEeKmKzWwfCbZ8WwS4U0r4xIsCkMBrB1CDKVFX?=
 =?iso-8859-2?Q?sQV5eTKRpFjPpTnUHimICMtXxpEzUfvbDQyBcEwV0MOLjX8KYSObDaXAzw?=
 =?iso-8859-2?Q?bwg5N0VpOZfeSVcrqv5mo5UTWJ7Hz1rwNC1LLQiKSbqbrkLqIHy430wbVc?=
 =?iso-8859-2?Q?p7HkAXIs7I3itUx4IBm/daiC4YfZSPpYYMzHfRcIMeqljseR/aH1pbRsUw?=
 =?iso-8859-2?Q?Hv2V7Qw98b/bsfgqDJlCRLpPrk0mAzHw2oYaVCBGBNJX9KanhZt5FjMSlq?=
 =?iso-8859-2?Q?Z8EN3yIiLlZLrnYKF7eQxizjvgWFDPnvJ5FeJpRV+Sgc80cfr1VF/oHE2o?=
 =?iso-8859-2?Q?Ahptl4cm/xcO9LXgBleOZ80sW86MGjGcqhX5FE1nErY5KfGOo8QcBSNpVc?=
 =?iso-8859-2?Q?5HATTfxa/salUcZgLAP74xV1ANK5wVsIG4OsmpdnseBoiAAjVLQg+dbhfT?=
 =?iso-8859-2?Q?ejO6nsuqeIfPDxv3TAbtZLH4DBGHtVDt7+tnCRNWpAdPMihO6eu7XdwxEt?=
 =?iso-8859-2?Q?1UVFTPaTvZw/Klr5nRTkJaUAT6HtPG+NIRH95N+ODhMNRMPMy8zFotrq4C?=
 =?iso-8859-2?Q?3tMbiylqWTR+yzs1ui8OoC6RMpqactmhPuhQgWoKBKc/u/0lqRvRXyOOx3?=
 =?iso-8859-2?Q?jGbGU1l66hjuPC5W4yOjWExy9pw8MaHFQkIgdOAK98VcpjGoinjYJOPEOm?=
 =?iso-8859-2?Q?ug7rt9Ldx3MBXWlvLnUHEupEu0/X2kvi3oPt116RTgVVOiM1YWaF2s52Su?=
 =?iso-8859-2?Q?tR54GeG47wQ1WomgN27lV/z91xpzY+zikFnXKQHJ5DX1Zk8Ug/f/Xn1d2k?=
 =?iso-8859-2?Q?A2TScmRvmbH1PwEinqlxrYeGCTAtR5xoxixT0ZMXIxejsREX5bIU4X6h6r?=
 =?iso-8859-2?Q?pPnqsD8NGt4daHo9YiOiRzVTXbh9Nq6Ex33hVwVMp923HvxQ6PqgKtmfgO?=
 =?iso-8859-2?Q?KbK3Hw195uFUqMOm9Wk3f+s5rSHuCFH4GtwraWOKCifckPiPGDaWkM3f7n?=
 =?iso-8859-2?Q?xJBs0NgSbL4WFb0ilbAomiBaqX1x1Pv/6sbCspMO7dr9hvdpCp/YNf12s/?=
 =?iso-8859-2?Q?XjHHe5gGzeVptKO9iZpQMCxgu+ggJNX2aMLHB3gITzexfX4yyooQj5CA5U?=
 =?iso-8859-2?Q?lLuV4saoCrMoHMQaKvtmEpPKcdprhDZtX2zdDr8j26eeoOM5tu0p/bmk1m?=
 =?iso-8859-2?Q?8G+fKcBOZ8WJxRlmh+rqr6g2yrDSdlIETi9Zw+2uK3fW6po4iepqY7qYpS?=
 =?iso-8859-2?Q?bZF+g8ilFcfp5Z3PUFsifAXF4KcHSlk5nsevyMoHz3uGOZs7C63ETP/4SJ?=
 =?iso-8859-2?Q?Rmt/x68vpTDQyC8g5+UD0xiqSj+kzCAYsne8XH7AGKSHJ9SpXYEsp7aV4r?=
 =?iso-8859-2?Q?WpTCikPub6m41UCrEJhjMoZQ8h+eagpLW+yVErawXbhSglo+XFXcYhnXMJ?=
 =?iso-8859-2?Q?8Nz34gmuPxWUWOZRYkKqkAtKKcXDjN97+pJsQNyMzcxaPd6kMfrAe7WAjq?=
 =?iso-8859-2?Q?2wSVnAdElr3i3vn5QadExh6Qpxdv?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923E35BD3BF01AA01217A45924BADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a88d79-1048-4f7e-9075-08ddc05c28ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 09:20:21.0191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /csZ6WwvhdF0ETJCoh88TETihnA3h0pAgGhDqHmPrBdPrHrClx+elbs9wjZIWy5ecmmJChFQDSovTg8ZQ0uhg3GFfSfiHd0HpfnRbJqX7d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0676
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923E35BD3BF01AA01217A45924BADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
The `posix_spawn/winchild` test was added recently by 2af1914b6ad673a2041cf=
94cc8e78e1bdec57a27 commit. It fails to build for AArch64=0A=
due to missing `stdlib.h` header where `malloc` and `free` functions are de=
fined. This patch fixes the missing header. =0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 9a2b435dd837bbc0baba16a5ef8dbcff1bdeabf5 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Tue, 1 Jul 2025 17:49:55 +0200=0A=
Subject: [PATCH] Cygwin: winchild: fix missing stdlib.h=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
The posix_spawn/winchild test was added recently by=0A=
2af1914b6ad673a2041cf94cc8e78e1bdec57a27 commit. It fails to build for AArc=
h64=0A=
due to missing stdlib.h header where malloc and free functions are defined.=
=0A=
This patch fixes the missing header.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/testsuite/winsup.api/posix_spawn/winchild.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/testsuite/winsup.api/posix_spawn/winchild.c b/winsup/te=
stsuite/winsup.api/posix_spawn/winchild.c=0A=
index 6fdfa002c..43fd35c58 100644=0A=
--- a/winsup/testsuite/winsup.api/posix_spawn/winchild.c=0A=
+++ b/winsup/testsuite/winsup.api/posix_spawn/winchild.c=0A=
@@ -3,7 +3,7 @@=0A=
 #include <winternl.h>=0A=
 #include <ctype.h>=0A=
 #include <stdio.h>=0A=
-=0A=
+#include <stdlib.h>=0A=
 =0A=
 int wmain (int argc, wchar_t **argv)=0A=
 {=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB0923E35BD3BF01AA01217A45924BADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-winchild-fix-missing-stdlib.h.patch"
Content-Description: 0001-Cygwin-winchild-fix-missing-stdlib.h.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-winchild-fix-missing-stdlib.h.patch"; size=1166;
	creation-date="Fri, 11 Jul 2025 09:19:17 GMT";
	modification-date="Fri, 11 Jul 2025 09:19:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YTJiNDM1ZGQ4MzdiYmMwYmFiYTE2YTVlZjhkYmNmZjFiZGVhYmY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVHVlLCAxIEp1bCAyMDI1IDE3OjQ5OjU1ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiB3aW5jaGlsZDogZml4IG1pc3Npbmcgc3RkbGli
LmgKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVU
Ri04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRoZSBwb3NpeF9zcGF3bi93aW5j
aGlsZCB0ZXN0IHdhcyBhZGRlZCByZWNlbnRseSBieQoyYWYxOTE0YjZhZDY3M2EyMDQxY2Y5NGNj
OGU3OGUxYmRlYzU3YTI3IGNvbW1pdC4gSXQgZmFpbHMgdG8gYnVpbGQgZm9yIEFBcmNoNjQKZHVl
IHRvIG1pc3Npbmcgc3RkbGliLmggaGVhZGVyIHdoZXJlIG1hbGxvYyBhbmQgZnJlZSBmdW5jdGlv
bnMgYXJlIGRlZmluZWQuClRoaXMgcGF0Y2ggZml4ZXMgdGhlIG1pc3NpbmcgaGVhZGVyLgoKU2ln
bmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+Ci0t
LQogd2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3Bvc2l4X3NwYXduL3dpbmNoaWxkLmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS93aW5zdXAvdGVzdHN1aXRlL3dpbnN1cC5hcGkvcG9zaXhfc3Bhd24vd2luY2hpbGQu
YyBiL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wb3NpeF9zcGF3bi93aW5jaGlsZC5jCmlu
ZGV4IDZmZGZhMDAyYy4uNDNmZDM1YzU4IDEwMDY0NAotLS0gYS93aW5zdXAvdGVzdHN1aXRlL3dp
bnN1cC5hcGkvcG9zaXhfc3Bhd24vd2luY2hpbGQuYworKysgYi93aW5zdXAvdGVzdHN1aXRlL3dp
bnN1cC5hcGkvcG9zaXhfc3Bhd24vd2luY2hpbGQuYwpAQCAtMyw3ICszLDcgQEAKICNpbmNsdWRl
IDx3aW50ZXJubC5oPgogI2luY2x1ZGUgPGN0eXBlLmg+CiAjaW5jbHVkZSA8c3RkaW8uaD4KLQor
I2luY2x1ZGUgPHN0ZGxpYi5oPgogCiBpbnQgd21haW4gKGludCBhcmdjLCB3Y2hhcl90ICoqYXJn
dikKIHsKLS0gCjIuNTAuMS52ZnMuMC4wCgo=

--_002_DB9PR83MB0923E35BD3BF01AA01217A45924BADB9PR83MB0923EURP_--
