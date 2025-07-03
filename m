Return-Path: <SRS0=JPMj=ZQ=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071c.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::71c])
	by sourceware.org (Postfix) with ESMTPS id 7485E385357E
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 14:26:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7485E385357E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7485E385357E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::71c
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751552799; cv=pass;
	b=frzvh415stGOqCZlwjZwzXiifU4zKuAs+WrN6p9xX9h4oM0kp5u0YQWsQgP09x96AApnd4VbxR2H1I+xQQKS5paAO39CkXhuwSISXGdnu4SlEy2sQ6WnMiYgNCpRcw4Hzm/hQE7OvXrb1jA7oMeeIPYar9hwL8PuYf0TI/eRfj8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751552799; c=relaxed/simple;
	bh=Fi2nx5bEViVv/3oN5B4r3rW1eKvJ2UcfPWCj2v/i06c=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=XhECbLcqopaSZnwQJy0Vgzs6k4rRriQChZfiSMQHsIXcRSCNRIWQM04kZ7NZLks2VtgQvxiiTacZprge+c1AZtaXvQFggIFEdBbYDKOym/UYeuQitkxhhPYROgCsOtjqOuSdOAfxL10rlzd0SnrQN6ZYYRsC3prwzSMKpWZLDPo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7485E385357E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=V4syilFh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uc9R3iSYlkNL3kvapebmBCibNi0wKTrxl3rIyFp6EeUkYL5ij3y7kXaQftgFG/hyx1g2YQnyacxlG2qvW6Mf6tFb+1G/iJfDDl3mIel3LvfztrKU13GrnUE4L44QjzpRd9p3vZIiaB+TIvm9zLIqbd/fUnlGRdGLqE3JX/ghaZfAPkB/ZhZDMt5GQYFqN7hFG3CD8qtqTcrO9rXaxTDKoTOdoFXTDvDXjX6QbHAbybAmfPUXxMxLY1YqVzjyykp1OV+0Vo6qxk4PkLmYvkFwJkg8TJsM5yjh8xfTmWke2PA4U/w/OpicGZzDzgvg+i3c5ClpjsUY8E6UhkAufJ8Cug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjGonvWDJVCP7zSMWUwN87f6NsSfeY/XkFKE6evhXhE=;
 b=kJf0Yir+lauW4GTRi3uuc+36v4cpetR2uxhzcYckO8jK4/vqWBmkCAfXsW5/IJ89zsbI7XG2bA9FGnasfVGgJyGVQc86MuksZGIBxgeiwnfRX1vhSTL2Iyb50Vr2HM3zDXou95ES/cWRihlWpm/UTtOZHV5djUMRyYL+Xw91OrnN546Kxv3mAFIFBw/FIEU+13uBPRMMBAORzEXz5fztc73/eQpn3DSnfx9kjplT+uu/9U8hh1U99qOlCnlj6nFxIAPFr7bmBy2yWRRS7zQOJbdufIshgAWiAsLpGeCD7mNpvpzFmQIWUal3hUlwp0z/jpZpqQ1EviNaLSMPAhPvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjGonvWDJVCP7zSMWUwN87f6NsSfeY/XkFKE6evhXhE=;
 b=V4syilFhbqULQ5ZNgOga1IwU1jRbSYmFuKLzFayfALx/9haTT6ytDJgo2nDyCWUfytsAUgPOONKFrStnyv0EFAnpsOzEJc4F90LCMXvUh6okmwnvgT7fYsYSd310yfq+kv36op3ieNUR8e82pDwsNLKoy0bqAjXSSNWRqFT+kl4=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0618.EURPRD83.prod.outlook.com (2603:10a6:150:161::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.5; Thu, 3 Jul
 2025 14:26:33 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Thu, 3 Jul 2025
 14:26:33 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: add fastcwd to AArch64 build
Thread-Topic: [PATCH] Cygwin: add fastcwd to AArch64 build
Thread-Index: AQHb7B/G2nKaXriFXE2xWHBcbBbdtg==
Date: Thu, 3 Jul 2025 14:26:33 +0000
Message-ID:
 <DB9PR83MB09239DC5AA360EC8472C8F749243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-03T14:26:32.761Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0618:EE_
x-ms-office365-filtering-correlation-id: 11af0ae1-23cc-482e-9c88-08ddba3d9c82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?5T8DTgiBok1RjDq8dnxZ0/baf+IQXq7hqVh6ivhkopYSp29aRQebih6MXF?=
 =?iso-8859-2?Q?rNnXqQoyMC7Y/SFDmJhe20Xye6M2W1lN4jbLdw+mT0ZNf/0N8HM2sVLYgP?=
 =?iso-8859-2?Q?hhJCyGVc5sTazoqXXSUgFWHWyd+8/hn8U/Zck8SAvIakfdM7PwlfV/uCnj?=
 =?iso-8859-2?Q?d61mtIw2eRMdzN2prcGe7YjK24igB4ZRa10sMijA2U2jSHFlCSHsR6BqXy?=
 =?iso-8859-2?Q?33MzGbiQQIyYBwxCx+oKaBM6d+iJ8x4NWW+IWyTVn5t9oTGpOVEVdA0pOA?=
 =?iso-8859-2?Q?qFApTF7pmx0Aav4jYJGmWEi27+Fvu0NNyt69bKnCtMCF8pVcLUQaa/ytE2?=
 =?iso-8859-2?Q?SedGTh7WqyA4Pl4DpnbJtvZSrNQE3syqfPyeLatYiC1hLhD7Cv2maKvYTt?=
 =?iso-8859-2?Q?A26SjmSLRT6N3UzR9rkFumGaDXYeEcIm68E4+y2/WxkFoxWzPT41BzBW8N?=
 =?iso-8859-2?Q?2wO5EKVw609brHzBBNdQFvvHY0lJ2H/YlC1q9mGojYKG+4n8tV/RvV3V3s?=
 =?iso-8859-2?Q?MfemTwiDyxjEfYA2Lmi9O9K1l5lCFCjPfpoglYPjwi0PiSSsAfa1MMrI/l?=
 =?iso-8859-2?Q?3tRigv5/muW12XvwZ1LJXY3IGgZ7pTXDfxwPVNFaAuLV1RBwub0Sl0NXMy?=
 =?iso-8859-2?Q?yTXvDnBPeBzoT94RW7tAjhQCHhs/haE/TrS4RKbT1r6MkZ8s850egDZqVX?=
 =?iso-8859-2?Q?vHdQIc9ToBaYnByH/rfCJX8uVHpmYQwLr3qRktcP/dTg6FeZcunHSV1nYW?=
 =?iso-8859-2?Q?TokhL4PvIhSSyhLqAxfN0HINWEXyuJFyuMIUPap8+4bKBQflvzU4XViFwU?=
 =?iso-8859-2?Q?R6NytgaYf0f7si+NyvHvgrvrkkJu48DOULFeiGSvbX/5pRg4xWINXur5Ix?=
 =?iso-8859-2?Q?3Ct8HgSgVpELujSFItlCaOFdwbLek08j+CkWaHBms23MOCqsyxmvf7G2kh?=
 =?iso-8859-2?Q?mSDcK3E4OfpDjwtc+IcuiGdlz6G8XtSsUHBl/eiF3QM5ZdiFgOEscOo+Jc?=
 =?iso-8859-2?Q?mHgIpAqwLnjhizhrE29qveI4uV2Xh1Sy3fpB1mlDnqPRs6h4eC4v2ycw/+?=
 =?iso-8859-2?Q?eZVvlpsYQCD7lYdhLbYaKAFoGQopByKs3Y6aWMmY6tPAx5agvTlGNjRVzk?=
 =?iso-8859-2?Q?XlQRalbtgkpufq3rDr7dyLQQtentEMoIoY7lZqWukjkUdWeXSLf+WEaQKY?=
 =?iso-8859-2?Q?Xxzh3uXKkiusZ/2HaKdyogr9E1zksn6sx2gwNxIBETV85YhcfT9bT+GL6D?=
 =?iso-8859-2?Q?ZsEvRR3yIYiG3JtDCGF0LROEGV8RlrOzdJtwDaTqxz82/Q01MMFbQpCMvy?=
 =?iso-8859-2?Q?649clUKR7vSOtJF0/Aiu/QUFFdT/mXMyIGAy/mudsupRGVeMOULBTjFQ8D?=
 =?iso-8859-2?Q?qlBeQc1TYF4cuQT89Ok374FKs4qC2wfZn6VIcyE9IFIZ30byBUXcPos4Wy?=
 =?iso-8859-2?Q?twxOVWYPI8eCdoyQ6EnTgeutZnOP2LFy0roFwKmAlnL3hW00zofKmBmgNC?=
 =?iso-8859-2?Q?rtcWsOtoDu3a60EOT2OuDWGc13AvBj5+gpuTPeKkPdDA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?IBRQA8Ui1pgD/kbtZvD9ZOUw1sGwb0RP3uTOUSK6ieZlMyEx4TXAhkhvrn?=
 =?iso-8859-2?Q?LPCnL6VtT2YLu/y+FbCeGRWcsALWW7xn/G8zPn3N1fKG1oGkTZeZXlKvxE?=
 =?iso-8859-2?Q?xwVJHgSfFVo3l8VFmaMqjZO5rnH/QA/vZQPs/G9HQXz9Ho6LOnCYyTFIZY?=
 =?iso-8859-2?Q?z0rft3R2Pw2FDNfIxP+01fGSFAJBlkYy/u0EigODJ9qnCl5NPvKCykfJRE?=
 =?iso-8859-2?Q?rWOt8gJBMqe3LZdU7o+lVfXclGQ8SVvM8ESv4zIENoahxqJTl1nfmvSD67?=
 =?iso-8859-2?Q?yXFctVla3ML+DmzXqrLhDkR+M2ze3YiaHq7Cy0qe9kQDc28lRnCg7CduHI?=
 =?iso-8859-2?Q?sY/oFzNeASGkvrL7vdGsYekEgp15L5rNe/eCblioQOXpV0g2sCi2e520cS?=
 =?iso-8859-2?Q?k4GpyCSBwLrslLN018ucd/xAwdS+a/s2cpjKHzk2N3kreSLafoZpXtQqas?=
 =?iso-8859-2?Q?/G5Xqxb8AqDz3ZzqdxQnOiQyKM0xpqsqXhGaroar2vnZCmEy2rfYzgyT4U?=
 =?iso-8859-2?Q?HQunx9nXWpf1VP8AE6U2YiqsLGSc+Z7XrX480OKWi3VDmKFhR2sIcDaqbQ?=
 =?iso-8859-2?Q?Pv4gIyCJWubeWhrqOh/Roe8VXrsPsa4FEEJ2iKrBeWNTOW2kYkLrGkBtRV?=
 =?iso-8859-2?Q?qmPb6wODztJlvkBDAqEyzfBxnNNF5i3wz/cGPOn4D2erunf+1XjMh3XqyB?=
 =?iso-8859-2?Q?uGHB8RO2ul8ZnLSXsJEZnoc87z23EDfSh5MPeYXPYhi+j2ysWXcwqTZ1iN?=
 =?iso-8859-2?Q?Pxobrsj6C6VlTS4BoK6tEZaQpw/cOPx7UU384vSYR6ZivhSmUbahLH+jEx?=
 =?iso-8859-2?Q?zJQrQ0R1qPLkS5mPLHJ31HllWGcdufZ/D477VyB/ptrUNH2yn1Z4D35QG5?=
 =?iso-8859-2?Q?LH172Uq3rWMttCLumP7/omW6byuJmWSAMA4/LMwYuDYbMcdluVNACTQQ1Z?=
 =?iso-8859-2?Q?j8wMNn4K1FQMbEDcT/NJiDFOymED2T/dzeQa8s2kzOWS3eXRPeF2qGez6u?=
 =?iso-8859-2?Q?hVpU/We2FrrNzyt9XzrDkVTMA1GTUGoqPpybJFxzIaim6Cur316Tcz5KMC?=
 =?iso-8859-2?Q?Ah9KDh8cpUavYkJQErb5bKK4fs9YsKOZmuHgyaX0jrXg7rzRS9SOKYpGx5?=
 =?iso-8859-2?Q?p441CHf5Wzqo8wrZtDXxyIbQayaD9Zj7MsfsxCTVUjs/oR8lMJnVBwtMLH?=
 =?iso-8859-2?Q?gaIgnZdc17eLQUFQtS5kMGEkYRclbQM6MvBllGEJ7FC3vJYGsMJoM/xggi?=
 =?iso-8859-2?Q?O63pMTLMCcbu+chtsith92X4qNz9CD9CkJqcpmJewRJxHCjB9geGB28eJn?=
 =?iso-8859-2?Q?pQiRZbMyI6Roy8atHCFSAWAi9ev8p0ZhljSc/8QdSfHmFtwWnpg0MUFitc?=
 =?iso-8859-2?Q?wuhCM6u276pyhcPCaLtf8kGsFXkPXtPWUDNvUlsR2cXf8J/AXgh/Irwbyf?=
 =?iso-8859-2?Q?3k25wbkwOHJZYUCo0RZVCc6Kh9k4yVOr3nFMgg9pi2AL9qJIHPZELivvSm?=
 =?iso-8859-2?Q?QWxL7A2Vi9gD/5ywOmFMIdBQSfWmCd8pFc+W+tNN04/mxcfNu/DR/2Lhy8?=
 =?iso-8859-2?Q?Wt+IzeUXFKNw9UdBekwkT47/FYWy?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09239DC5AA360EC8472C8F749243ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11af0ae1-23cc-482e-9c88-08ddba3d9c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 14:26:33.7935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83LyD8ZbfT+CtKTn5u/d8LIbo/v+O0Td3TIlXSbEWpJQHS2q1o1Y+rwnTavczDIb3F0c/TEwDe0r9JlhPaQ0FPmo7Cs6LGeFAdfbdHNYAN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0618
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09239DC5AA360EC8472C8F749243ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello=0A=
=0A=
This patch adds `aarch64/fastcwd.cc` implementations to AArch64 build fixin=
g undefined reference to `find_fast_cwd_pointer_aarch64`.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From ff438392ffbd0c91a918b383a3e9947f1eb18212 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Mon, 9 Jun 2025 13:07:01 +0200=0A=
Subject: [PATCH] Cygwin: add fastcwd to AArch64 build=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/Makefile.am | 5 +++++=0A=
 1 file changed, 5 insertions(+)=0A=
=0A=
diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am=0A=
index 31747ac98..90a7332a8 100644=0A=
--- a/winsup/cygwin/Makefile.am=0A=
+++ b/winsup/cygwin/Makefile.am=0A=
@@ -64,6 +64,11 @@ TARGET_FILES=3D \=0A=
 	x86_64/wmempcpy.S=0A=
 endif=0A=
 =0A=
+if TARGET_AARCH64=0A=
+TARGET_FILES=3D \=0A=
+	aarch64/fastcwd.cc=0A=
+endif=0A=
+=0A=
 # These objects are included directly into the import library=0A=
 LIB_FILES=3D \=0A=
 	lib/_cygwin_crt0_common.cc \=0A=
-- =0A=
2.49.0.vfs.0.4=0A=
=0A=

--_002_DB9PR83MB09239DC5AA360EC8472C8F749243ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-add-fastcwd-to-AArch64-build.patch"
Content-Description: 0001-Cygwin-add-fastcwd-to-AArch64-build.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-add-fastcwd-to-AArch64-build.patch"; size=876;
	creation-date="Thu, 03 Jul 2025 13:39:44 GMT";
	modification-date="Thu, 03 Jul 2025 13:39:44 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmZjQzODM5MmZmYmQwYzkxYTkxOGIzODNhM2U5OTQ3ZjFlYjE4MjEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCA5IEp1biAyMDI1IDEzOjA3OjAxICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBhZGQgZmFzdGN3ZCB0byBBQXJjaDY0IGJ1aWxk
Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYt
OApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBC
YXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL01h
a2VmaWxlLmFtIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuYW0gYi93aW5zdXAvY3lnd2luL01ha2Vm
aWxlLmFtCmluZGV4IDMxNzQ3YWM5OC4uOTBhNzMzMmE4IDEwMDY0NAotLS0gYS93aW5zdXAvY3ln
d2luL01ha2VmaWxlLmFtCisrKyBiL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuYW0KQEAgLTY0LDYg
KzY0LDExIEBAIFRBUkdFVF9GSUxFUz0gXAogCXg4Nl82NC93bWVtcGNweS5TCiBlbmRpZgogCitp
ZiBUQVJHRVRfQUFSQ0g2NAorVEFSR0VUX0ZJTEVTPSBcCisJYWFyY2g2NC9mYXN0Y3dkLmNjCitl
bmRpZgorCiAjIFRoZXNlIG9iamVjdHMgYXJlIGluY2x1ZGVkIGRpcmVjdGx5IGludG8gdGhlIGlt
cG9ydCBsaWJyYXJ5CiBMSUJfRklMRVM9IFwKIAlsaWIvX2N5Z3dpbl9jcnQwX2NvbW1vbi5jYyBc
Ci0tIAoyLjQ5LjAudmZzLjAuNAoK

--_002_DB9PR83MB09239DC5AA360EC8472C8F749243ADB9PR83MB0923EURP_--
