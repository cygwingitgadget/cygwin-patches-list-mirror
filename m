Return-Path: <SRS0=JPMj=ZQ=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070d.outbound.protection.outlook.com [IPv6:2a01:111:f403:2606::70d])
	by sourceware.org (Postfix) with ESMTPS id 7C26D385357E
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 14:40:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7C26D385357E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7C26D385357E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2606::70d
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751553604; cv=pass;
	b=f/2zf0n+nhkAc8+F4OBhVhyEvcSL0ubIRZ91SwYTs2GjA5OZqqpf/dM5cnOc67Etu6LShJHW/CjOuv1sRSlbZetu/yIjmMSzaZ1491C5r+IObDHgazo8+yO+pmnbrWwG1Kcs+iunUhtS7mPfmki+dklr96xjnloQcqwOC+kZEIs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751553604; c=relaxed/simple;
	bh=wYDt9LKjTD+1PIasJywzPysjj6Xm20W0hpV0MIQxkPE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=JwLOI+z2g8cD2Nr2v8xRXHYwxu/cLfWUn+MCeN2TMvaHy/wT2uZI6SjfJ7XE9UBvToYqR7LVoFOQRg1GMc88MqwVufCQ92o/WoaT9FA762eVg6MKG9Tz7kItC1/6VZ7iTQ9EXnRDCPQxNIwv+7VvFVZXP/4eevVUiJNMLheS6RM=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C26D385357E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=VqCRxXhN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps8AW5umtb0m5bdND5c1UOFLwt+YuBCbWA1As2WGiD2wdIHYeYkWdbodKl3AJpUig26foU/Lq25xT1LSd1/TXnSniacLryk4Mz+qcP43JqE4sP2DOZs3E/YxmjxexJVrORlBiXq0iaBTyeWYDAb1dFwZE+wSkiE22UA7MWCXGDIigVtvjCtw44iHNyh+J9p9e2bxT5kIB6ZK52buEXUhbCWiqlKGKw3WqAOLEjgXvfVEL+c0Aa8kAKw/W7EEFA3L5JM4Jau7aImzkKZR6gDoUGAzJZe6OGpQ0bvM6Ll1e22nm3lCWHVOSyUsMrl8vXsnqmQjWK6Bql18gelvp1njzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUa9y9wpz/lzgqz4QiZ1/TkCJvDB1bmap1f+OVXy5r4=;
 b=b7JKxd+cOL4N8TEEqe2c7nLbqhxmQdnUqJu9fIfFkCS/ydjYVu5plVtvQY+CJHswCKOQcMm1wUvjywxrPa25I+N2/otPwUXFL7H5i/zFGcWqzjtKfkddoweQMZwA8oryiu1cjPQIZpeDVJjWbwN0evoogi7GZo0Q2vHtMPSMVcNlzRxlV0SYIxMTdncYCUYYRU5XVSLRm/rgoibvs5HsiNS1EOwcbnOVvJeA0gL8+cIf8mY8jgiegnCsdG6zY5j8UXGg/tV6dikR/R7DhIJn4X9vcaEsUMY8v5pc6/12qCkPnFsa6kGzag5xpniZuQQQp7UczyJoojbgNLVaVeu1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUa9y9wpz/lzgqz4QiZ1/TkCJvDB1bmap1f+OVXy5r4=;
 b=VqCRxXhNhqNeUTaN1VQUMEf20mafC61mgDF3NbximOFjpy7tNWN7jZFR8tLGD8XGwqF6myyWGGKPNuuaQWB6GhcSm3TAS5ywZCHd3t4ZrOfXPMImaEJORJFEdvr38/vnwZMKNCEjQSJ8RBG+KItBWSWqrNyJ6WTgZUiUZCbLTYs=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA6PR83MB0627.EURPRD83.prod.outlook.com (2603:10a6:102:3d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.14; Thu, 3 Jul
 2025 14:39:54 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Thu, 3 Jul 2025
 14:39:54 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: gentls_offsets: port to support AArch64
Thread-Topic: [PATCH] Cygwin: gentls_offsets: port to support AArch64
Thread-Index: AQHb7CdmzQQteCxlX0uhmodhAarPNA==
Date: Thu, 3 Jul 2025 14:39:53 +0000
Message-ID:
 <DB9PR83MB0923C787C8B326444EC5E2969243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-03T14:39:52.988Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA6PR83MB0627:EE_
x-ms-office365-filtering-correlation-id: c94f90da-b5b6-4854-89f5-08ddba3f7975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?E1mzd7ADymnZvaKiseHcc2cl8C6gIHdCLdNOuxkJtlS1PNJvuwMEk1KXvt?=
 =?iso-8859-2?Q?Zweto+rkjpvUzF8+4XSA+vXJ3gRpyXl7u7ZIiDiVupYBgc+5fZn7uWx9je?=
 =?iso-8859-2?Q?hwdIF1XxLNkyhOwJPua5/6gsGOkt2fqkqpUX9PFAPSHH5e3MTRy+VDKIJe?=
 =?iso-8859-2?Q?bpUGjhCB/BD183HK8P3laYQBUy1zyjLty0jby0eHxMAAnFM8mcJMa8738/?=
 =?iso-8859-2?Q?YNwvE6m8+7SEEjCj4T1K3Z/kny+ttfBn1Fhic32PRugZznMSOhvzjrL9VM?=
 =?iso-8859-2?Q?17VGq4t2+1Naal3CKiWn4DiQawVLXxfO0dRNSALYuZ2fe+172oeGHAhcmu?=
 =?iso-8859-2?Q?ED4qaseq/EqDaoWh+UaWxK/1CC9f8ONxuRp752U8tBvYV7R2ilGYw/bUK1?=
 =?iso-8859-2?Q?CIwqq+s0cZ5lN700JRzIcZ7v91pLvoRyzMMLPNp9/ZgpTOowtzVGl+Ma++?=
 =?iso-8859-2?Q?KB9+RjCpZv1TRVH5bMK2oUkWzB6iVNxkhyfxevqWowG8UmUzWkgo0OHynB?=
 =?iso-8859-2?Q?UnQlAaroy4QBkRVBFGoVq6qnak9XfjuVL9Zlr18v01BrOe7yVSctyz86E4?=
 =?iso-8859-2?Q?MUJB7x7uF1T7JjqzDoXYsY/6SUvzq4t1pSolrBuJU22PssA+vZAAABZ4nW?=
 =?iso-8859-2?Q?1YCSroMZmfCe2uM07DdJChzJmTkJHTAEQfos2myD9h4e3jgdWy7vrOVRdw?=
 =?iso-8859-2?Q?GKlgFI84WWkuSeFBOeSLIY4FE583Iwujhuzz+pgnDJHBBh+vfEbJl7GhAZ?=
 =?iso-8859-2?Q?oCPTLZowUL0dyDCFPIo4eLL9jI3RDupUZfdhLvQ/KTqjUr3DB4JrDRQ4uz?=
 =?iso-8859-2?Q?dHFFUdff/7KureSBF/105xiSo6BMpIodUBNaYAM8Zw2l85sOd9RvZm6RQZ?=
 =?iso-8859-2?Q?rVh2Cpr6MUHd8RlQs1pEnh2xCB4SGwnbPOMWDWWWR4vcDMbpjWJqV6JpiT?=
 =?iso-8859-2?Q?87iyk9p7BtBtNYAQJf0rHkOd8d5anR/IbLpKCBKo0xi0ZU6xUWXPHplvdX?=
 =?iso-8859-2?Q?V+hj7H0V9NrujNMWNwaZi6QBO3jku04WP58YCeggvQyF/rJ0LKOfRwfisQ?=
 =?iso-8859-2?Q?4/3zjNriLq0mIXZH7MEIWJIF5boKElBJCWPl9TQEfCudPw82VSFPYfCsm6?=
 =?iso-8859-2?Q?Y2D0cxkQqZQNsD2EG1YyYpQsoPs6HVuwlA3zLccv9mJ5AiCBrkZ0dJ39hI?=
 =?iso-8859-2?Q?Qt/ZT5eGZ6EZcQ3TJzkQ12brEXbzzrPm28U06qb1oCxC+R5L01KGxuJz5L?=
 =?iso-8859-2?Q?6gSxPDYZ/NXJJ0KimN+qhoJ6lXR2LN57eujjrjZ5/mBHIfBTLsfbMvr3R2?=
 =?iso-8859-2?Q?7AQIzvscCVCZvwjcHXcBfc6ctw8/NAbnZoaPQSK8dZbWk3ydMMsJ3ObNNG?=
 =?iso-8859-2?Q?nAiCKSBc0frE922cWZu7kJmCOXJwQeG3W8bh5OJLbKHWwYvV5AK5vE7A01?=
 =?iso-8859-2?Q?bZd1vfEJ1KcCNi9Zphzjhdha3D5VzJbnfPJvG+iAGjbRU1paYWVaWakzky?=
 =?iso-8859-2?Q?cfzRNV/nK2xL23Zz61IvrDU78mVtYhBmZaL7W6hLiq2g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?EXaNSicSlOYogQdkWdzxdiFgSa5rl6NzXjBE1Pw+ESiWreE0xJKKyOfsFN?=
 =?iso-8859-2?Q?BPXCY1fmxLB0fn9IlXJ4flAISg18ZJ+4u2YsfRAeX5lVsGVhRryFMZxryX?=
 =?iso-8859-2?Q?f2fx6Iv/lAcesNmNq6S6XHzfZz4cHQm9uF09yra/96tSeZ8jjLSBHU5aEs?=
 =?iso-8859-2?Q?fzQ/d9jIeUOaHFkLojE7Jxek1x2I3afFuPnFKk1GUeq9XF7NAUiN4Du/Ii?=
 =?iso-8859-2?Q?AXNHA9u/bw9/1sZ1fx1RkRVoYtGxTatEWzh+bg7SL4wAWPXwbimO3mB0rw?=
 =?iso-8859-2?Q?++5aC3PrFvBpKWw0qebqxvVe0lZy0S+tNmSV25oi13uVj3CdKaIJ4wU3F4?=
 =?iso-8859-2?Q?ODEnCdHbl+cNdaawc418ffb7fkKKAKm9gWs6Lgy0hmnAgRtYIYYxZfoOwc?=
 =?iso-8859-2?Q?UvMw6vU4/dTr8XL4i/R1gCrNobG94uRk6f2oOoM3S482MgwqSITwCzm55J?=
 =?iso-8859-2?Q?tyjpyGHlnkVOH+Nevbp5aR/FPfiTXRFTHnUVs5FmG3iUvmHsP/7/pOKSru?=
 =?iso-8859-2?Q?1/m5GcaQEe7k1roD6bjIinAThR0rvK6mOzJ/+rDdt8MbPbOi/FBT44oHBF?=
 =?iso-8859-2?Q?tlIwduop+HSVn05YgFLzX8Zjngvce99W0xOb5Iv3BfejqhNtizZAxfD6iD?=
 =?iso-8859-2?Q?M2jlFFZo1QaXmHG0qHYv4VSCUJ/xMINHD6wHyBcXFGIuSkZ8uKEyScHiDs?=
 =?iso-8859-2?Q?FZFFFA/OfE5uBBJ0sTZjBXLUIHvlaeHjKPX8jKaDQpcwp9607/GKVWfKja?=
 =?iso-8859-2?Q?zDOZ2PwDZTxG1NRmsOy+eoZZBnZ/18K7TEiKe87KWG+5Id6OOHA5pZcmhN?=
 =?iso-8859-2?Q?RZPz2hMOCNEc7yfum90ECbqPyvSCMy6IPWFhTN0qpbxt9Jjfw2PTbZGKuO?=
 =?iso-8859-2?Q?f6EY+4v33J4OINDnstYS6FuamgIheJZxZWiXM9bppng77EfS7bm6zWjkty?=
 =?iso-8859-2?Q?JkQmo0mXob5EQy5uCqIiyMjog54XODq1yT9DgaUB2if3HGaoCsKVGBg9DX?=
 =?iso-8859-2?Q?0XU2+hnkjqj23j5LmKAJMNy3nnHdXx3WCQbaoq5dQa4p+W1H2wn1FKUdia?=
 =?iso-8859-2?Q?85TRz9gAz2PEuoXeummjgNNIDb7E3MjQpSywJsCsVnVENvSQ0z5RbtuAsZ?=
 =?iso-8859-2?Q?HDpAgr/ZOdNJcNNzHEu94RVgvkGzFXoFoy2M6cOZqueSSnFbTr5+a/Z6FS?=
 =?iso-8859-2?Q?cNAhM35/cJLdJLpBOW26VaTiOCRtBDoaIbY2M9BiDWGv3UPCF0p/I20L82?=
 =?iso-8859-2?Q?lpnQdo0NDPwP19GGBgHZuLhKIXG7E/w3cxZri87oSC9x+vqHQ0jPlAHCWi?=
 =?iso-8859-2?Q?gt4FTDac5Z/HY+5BAV4W09UZeK0YKzjQnn+yL2ekYlMFixrJgx5JVkJQpO?=
 =?iso-8859-2?Q?/f8Awtw7j7R2gowi5c6dTOseLOprti2mt1a49dBk3QUhu5Qacag0Akt1A/?=
 =?iso-8859-2?Q?Gy6bKGjQjUmUdYgLUb1+85ZTuBCQheOrv0faIStSHVPIqxEkD/0ahv1FEB?=
 =?iso-8859-2?Q?SeZCh74E7+c/2PlLZKGmuMowTBuLJwjVu2500dqDIHBlA1+ZJ1KqzlMiv1?=
 =?iso-8859-2?Q?VRKtTpi53Lfc3Q2VYKdkZZjkNs1R?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923C787C8B326444EC5E2969243ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94f90da-b5b6-4854-89f5-08ddba3f7975
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 14:39:53.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gb4IylQFACnJhPsyDst63U3vC/LrHKS2Ur++xmTVQNhs50zqekuKWqHl0JzvPLIqzHCexC7H79zCnyb00Pe3Tt4C1VjaBlK+HHLfNf74/ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR83MB0627
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923C787C8B326444EC5E2969243ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch ports `winsup/cygwin/scripts/gentls_offsets` script to AArch64 w=
here `.word` instead of `.long` is used.=0A=
=0A=
---=0A=
From b53e7dfcc0f31bdc5d8ad1fcff14753e0bd3399c Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Fri, 6 Jun 2025 11:21:11 +0200=0A=
Subject: [PATCH] Cygwin: gentls_offsets: port to support AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/scripts/gentls_offsets | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/scripts/gentls_offsets b/winsup/cygwin/scripts/g=
entls_offsets=0A=
index 040b5de6b..c375a6106 100755=0A=
--- a/winsup/cygwin/scripts/gentls_offsets=0A=
+++ b/winsup/cygwin/scripts/gentls_offsets=0A=
@@ -62,7 +62,7 @@ start_offset=3D$(gawk '\=0A=
   /^__CYGTLS__/ {=0A=
     varname =3D gensub (/__CYGTLS__(\w+):/, "\\1", "g");=0A=
   }=0A=
-  /\s*\.long\s+/ {=0A=
+  /\s*\.(word|long)\s+/ {=0A=
     if (length (varname) > 0) {=0A=
       if (varname =3D=3D "start_offset") {=0A=
 	print $2;=0A=
@@ -85,7 +85,7 @@ gawk -v start_offset=3D"$start_offset" '\=0A=
       varname =3D "";=0A=
     }=0A=
   }=0A=
-  /\s*\.long\s+/ {=0A=
+  /\s*\.(word|long)\s+/ {=0A=
     if (length (varname) > 0) {=0A=
       if (varname =3D=3D "start_offset") {=0A=
 	printf (".equ _cygtls.%s, -%u\n", varname, start_offset);=0A=
-- =0A=
2.49.0.vfs.0.4=0A=
=0A=

--_002_DB9PR83MB0923C787C8B326444EC5E2969243ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-gentls_offsets-port-to-support-AArch64.patch"
Content-Description: 0001-Cygwin-gentls_offsets-port-to-support-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-gentls_offsets-port-to-support-AArch64.patch";
	size=1243; creation-date="Thu, 03 Jul 2025 14:33:49 GMT";
	modification-date="Thu, 03 Jul 2025 14:33:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiNTNlN2RmY2MwZjMxYmRjNWQ4YWQxZmNmZjE0NzUzZTBiZDMzOTljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogRnJpLCA2IEp1biAyMDI1IDExOjIxOjExICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW50bHNfb2Zmc2V0czogcG9ydCB0byBzdXBw
b3J0IEFBcmNoNjQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBj
aGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClNpZ25lZC1vZmYt
Ynk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIHdpbnN1
cC9jeWd3aW4vc2NyaXB0cy9nZW50bHNfb2Zmc2V0cyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL3NjcmlwdHMvZ2VudGxzX29mZnNldHMgYi93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VudGxz
X29mZnNldHMKaW5kZXggMDQwYjVkZTZiLi5jMzc1YTYxMDYgMTAwNzU1Ci0tLSBhL3dpbnN1cC9j
eWd3aW4vc2NyaXB0cy9nZW50bHNfb2Zmc2V0cworKysgYi93aW5zdXAvY3lnd2luL3NjcmlwdHMv
Z2VudGxzX29mZnNldHMKQEAgLTYyLDcgKzYyLDcgQEAgc3RhcnRfb2Zmc2V0PSQoZ2F3ayAnXAog
ICAvXl9fQ1lHVExTX18vIHsKICAgICB2YXJuYW1lID0gZ2Vuc3ViICgvX19DWUdUTFNfXyhcdysp
Oi8sICJcXDEiLCAiZyIpOwogICB9Ci0gIC9ccypcLmxvbmdccysvIHsKKyAgL1xzKlwuKHdvcmR8
bG9uZylccysvIHsKICAgICBpZiAobGVuZ3RoICh2YXJuYW1lKSA+IDApIHsKICAgICAgIGlmICh2
YXJuYW1lID09ICJzdGFydF9vZmZzZXQiKSB7CiAJcHJpbnQgJDI7CkBAIC04NSw3ICs4NSw3IEBA
IGdhd2sgLXYgc3RhcnRfb2Zmc2V0PSIkc3RhcnRfb2Zmc2V0IiAnXAogICAgICAgdmFybmFtZSA9
ICIiOwogICAgIH0KICAgfQotICAvXHMqXC5sb25nXHMrLyB7CisgIC9ccypcLih3b3JkfGxvbmcp
XHMrLyB7CiAgICAgaWYgKGxlbmd0aCAodmFybmFtZSkgPiAwKSB7CiAgICAgICBpZiAodmFybmFt
ZSA9PSAic3RhcnRfb2Zmc2V0IikgewogCXByaW50ZiAoIi5lcXUgX2N5Z3Rscy4lcywgLSV1XG4i
LCB2YXJuYW1lLCBzdGFydF9vZmZzZXQpOwotLSAKMi40OS4wLnZmcy4wLjQKCg==

--_002_DB9PR83MB0923C787C8B326444EC5E2969243ADB9PR83MB0923EURP_--
