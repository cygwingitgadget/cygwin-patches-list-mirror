Return-Path: <SRS0=6c8O=Y3=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f403:2608::70a])
	by sourceware.org (Postfix) with ESMTPS id 731DA386FEF2
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 13:17:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 731DA386FEF2
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 731DA386FEF2
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2608::70a
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1749734269; cv=pass;
	b=bfaSW+A39ZOc6aOh2JiwyfWmuVKG+KidikYWVH58S6bYE609WzUOE57X+00+YpAJ3nhuuwtTW8lQigSHUcCKfoLpvPounErU3WtBupkJSoP1hICmS3z+BuPyeNhqeVa6Ih7+GfiWgrH1mXwIdACV41+hoUq+HsWTULCpubVHEZI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749734269; c=relaxed/simple;
	bh=ZWqSWXNGAmbqUMFPGvm7KbImeTS3ZrS2pZgGTaJcE2o=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=E2yOJuiznuDDcvHR9w2RslNTffEzEkoXr1jueTE1zzJiBsbTJEGvloCF9qtfnHodFo9sHdKqN1N+3Dbj89qUOFkrGznOFwQTGHsSJPvBQBSI1uyKUjmIwNs6nNLVgXhioBcS8fP2xf/Jqjh0Z0W+2C6MZf67GTS0OBE6qgvrfj4=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 731DA386FEF2
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=KNgYug3/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAxDLX7fWzwx/C/z+HeC073dNyryldQ1QLgJKKXks0xsogYOhTXbaC3wazAxYLopGmBPPNwNJYKWuGc8Fhn2GJLpt4L17Uj8Ty2Fo2Y1Y0t6+ka1CGkaSZpRVcRWj5x+8PQ29pKC9RvijV65zBakiCGaG5bnPV64fE0TsYl/d2sm1Un8rzrLoylmDP4cnDWDDY7LYKHKQevWNUK5m7czo8VxImOPIJrOOYUlQ0KU85yfyfJMlp3UxoY4XuYOLQlUjW8oLY5+M/3jdTq/BCmX/4Gmq8eRM6p0o+Zu7Icxi9nss5opeYIZSyFzEdJfPh27Kak5yxgjc0t4cMUrXXWygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks/bRgGcpwMte4EOMQQGEfZXcuWxq/ACn07p/9vggSY=;
 b=JVR3jhX/Wug5NibwfyDnXtwI4lqScPqiS10dmgak253oqylNoivjfIIg3E8F34D+WcmWDj+UAr4fz5pRUj+i1wV3fse0nYqUfrkgecaK/apGYw7qm2MytDVrUSdTEtW5PZNlQ6aQmgMCwbmoM+zXqA3YZgkW9w4PW2bhDQ4yh+aSlKfAMnLIFSV8ulNoJtOC1jkCOxT9HdQ997m/OG9vaIh2oFkybSxt5WsRfTsaosroZqeUl+h9lUivXhQ7lxADy7nLrEntNSg8DlY5fBLLS3ZRfzDpXA1WDgyP8dTPGauJSiuFrJKnLz/o6VEcjd2sWgTF45yMmNv+RWwVPc1Hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks/bRgGcpwMte4EOMQQGEfZXcuWxq/ACn07p/9vggSY=;
 b=KNgYug3/UMj297LPBGVwbw+qqh9aunFdUHW7bsEyRIb6/qrWeYv+IIv5FuaZ5XF7lyMQgblgkWK+D9yz7EjuxvRpe9sMZFsMDMjTm0CUGvwTKdUkmjMY9j4F8KVMx0GBDhTjM92tuUFY1Rs+1zjU6gPhDOLQocnyqrvB9mPhQt4=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA1PR83MB0687.EURPRD83.prod.outlook.com (2603:10a6:102:44a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.16; Thu, 12 Jun
 2025 13:17:45 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 13:17:45 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: implement spinlock pause for AArch64
Thread-Topic: [PATCH] Cygwin: implement spinlock pause for AArch64
Thread-Index: AQHb25wP2Q+0J9odlUCiIRsTY3/cvw==
Date: Thu, 12 Jun 2025 13:17:45 +0000
Message-ID:
 <DB9PR83MB09237758F38BC0ACB9AAB51B9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-12T13:17:44.520Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA1PR83MB0687:EE_
x-ms-office365-filtering-correlation-id: f8a13c2f-05b0-44b4-b04c-08dda9b3853a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3+rXVsD4iJSzoPH1WdR9HNQVIIgg2eRZurngOHJvfosnph6CbcWIeIW9tp?=
 =?iso-8859-1?Q?1v+ZCbFJ5i6hH3ViOf+oylMByA1njWwxGXhIWI6J1uZ6yq/B3C9bN9R1D1?=
 =?iso-8859-1?Q?2+OFeQB23Hm45fQA7+xYgaHGVDdoiKYZ7qd66DdLagqLCd55VpYgl2I3+E?=
 =?iso-8859-1?Q?9+xlDwknkEImgQDcdT2DS9uKjdtFJhHRo0iAEMQEPfIISm5eHtpWQ0dyGs?=
 =?iso-8859-1?Q?8U4ipoW5fxvmqfgBSlI5tH1/F6wnSe0kyYtXn/Z5fgmEIGUXUni7KMEGSH?=
 =?iso-8859-1?Q?EELGP/x2/Y3o0ltHzGRroI/hjhPof5nSIYnAxqpTklApRSYOGUFcBvyIEZ?=
 =?iso-8859-1?Q?s3TV5X2sFz4Qgh3L2S5DIvVb8onyJs/YKBsgrL+K3YLC2+qNE1e/Qv3KOf?=
 =?iso-8859-1?Q?pYTNFuXzOVUGVgzXUEHf766A4zPOW9lL2oxlLcMvniNDw+dxOgOGkid9vu?=
 =?iso-8859-1?Q?rnqJebZoBPlkDI74HNwSSAEzYsKOBN8N0stWXbVufsTWUw6dEmYJgmmB9W?=
 =?iso-8859-1?Q?j6parKcwmsbnfAYy/2mbsi+aLtwgvxxgTAlPCXwm4PPsJJt6lKmex4Y+0G?=
 =?iso-8859-1?Q?JLs/ewf99bXOFBsuWyRH7x47ULxqBghSKPCJp0bv6w+xGFCfkFwMVCCtNC?=
 =?iso-8859-1?Q?okHcGSFvJO0c+TKmnb1bJz0BpM91K3yrxNJWmtUjtcMGqoOjwpVoLI1G9e?=
 =?iso-8859-1?Q?q7jlwvvV9PIaf/fzTsdIzo659ACTsGMF+Qjy3Qng+Ed98D3jS2f5abUdPk?=
 =?iso-8859-1?Q?q37U8a5OqP0zdtMXixirAgD5hZlid7Eo+urpCEEXtzcSKx6cWqisXOUFk+?=
 =?iso-8859-1?Q?S36ZcGBqkFzzAj2WbVKjznHzVa6bFyH3C5DIEY3daYKroFCkGKsKLf7x0q?=
 =?iso-8859-1?Q?PdDsHn5N+2Ak3mSMP3hgGlsi2nHMmQ2GSdCOSVQWxoy5kwUn68OIhRHewF?=
 =?iso-8859-1?Q?zEyW6+/LtC5/Lo3qGN7GccYXWldX7QBYHS2nDSqjtmnpv8IDiOo+jorOXQ?=
 =?iso-8859-1?Q?znZH+NX+f5LmbwLRNV7mV03geCgbOXG6RdLlaQw/Z4lzIRTsfgTuTCBhEH?=
 =?iso-8859-1?Q?YR3kVUT7/WxyNoJkuXNGBsmx+yHi30gGLiXbglcaVb8JmAe204GyPBsXEw?=
 =?iso-8859-1?Q?LI1bFCLPSVmDtoMo/7USWiFplxTGAr/XkVFcFXwCR1U5JzLyWF2s5lyhbz?=
 =?iso-8859-1?Q?K7ORGzDHfvPpdSjCsBcpLWl0GOuAQ+XijhJ1kdC2liZgRPjZufKp0Gs8gY?=
 =?iso-8859-1?Q?ztAvZL07vggnUqe3jjnnSlFgjyfFeZ2ieWG/BIFsmoUF8zj9vZdOPTWXUz?=
 =?iso-8859-1?Q?I+64+MUr5Afe2l3fDYxWan6oGXghbUfbVzoNqX4hqpd3ZolQoxVTwAiUvJ?=
 =?iso-8859-1?Q?pZuPXpxrybjOHom11+WA80uPUA/E6o4wJaYcBTCIqi2WpHnFIAehysr7vD?=
 =?iso-8859-1?Q?1kwJAdzRB4u8LBu33DV7mUar0e0p3lNbE/2aizqS7pMhsil0V/akkrBEWE?=
 =?iso-8859-1?Q?FKAcRG+WBchWUhZbE+tpD9GkhJtmyz41tbXb7kOex01ojqFXCxZX6FdMme?=
 =?iso-8859-1?Q?BcJWT5U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?j7jr0T3pAMFX7oW0ZjJjoorwCy/tl+m0hhGFS+R8eBZ0ySQm4gALqyGjkO?=
 =?iso-8859-1?Q?Q0ygj8wOcPG1bAPohkWs+B6iQUEW0xuxOMpP7JWIn6SqENqG+4FA8Xno0M?=
 =?iso-8859-1?Q?zddpR9i99i5eXTwXE6SjOz6uehPL+l2f5M55ppJXal2+rI0nM8HT0S18ux?=
 =?iso-8859-1?Q?RlyU6D9CFNP6RAdKN1t/pBQrWP0H9Q3deiWhEVvSwbEZvldh+mvfE/QpuQ?=
 =?iso-8859-1?Q?3UvLn+vZr4/nOglJarqIkCp+06QtEJtpCAfIFT6rWRvaLYAEis6r75HSr8?=
 =?iso-8859-1?Q?mnBo8W0tfrlsrA7GKvIO77CZWgzCbxwGXF7s+PgoRP7/yXp2ZYNQYQkNCR?=
 =?iso-8859-1?Q?vA0vGGmJ+58vrwtcm7oRLqK+yUNu85l99wDYKnN4TTdCAzX8VdMQKXPOZ/?=
 =?iso-8859-1?Q?nS8eZ6ryjt33XxVfliOo/SCTdo6MBs+qG5n5xo6QwB3n90pabBlAUsRNtr?=
 =?iso-8859-1?Q?zLh/A6FnBPrz9INEnHVivrwpxSG3FVIYhUKflnFstrj0VmXOeULTA/gnQu?=
 =?iso-8859-1?Q?c07h4cWyij45fz3414vyVAnM8xWZeL19OWX2NnNQjybzOiZZAr8RRBOVye?=
 =?iso-8859-1?Q?FjdF5fDDD7CPPCyPF///DuG8eFcL8BqpM2n+GHqdvz6+TwV7lpSPtFYOhg?=
 =?iso-8859-1?Q?id7MJkjBi2ESDiSkwTGctfigklZw0uraZLwy4CPTm96hS14ql/3kD1hodd?=
 =?iso-8859-1?Q?DzrdSoriDwtChp4izAkx7b9oSsTD6Yhr7V8eCFIdSrc4TDb7nE2Ibxla/J?=
 =?iso-8859-1?Q?DO393bOOR56ljaXLN0eMbCWqdA1CRCfg5++RpVSk6h4zeJCP4Uu4C5aQfN?=
 =?iso-8859-1?Q?iSGsF0POGMiexxQJNPTEaidk+IYcLWcYKbBVAK4WzxvvMeYKW8Olrj3bSg?=
 =?iso-8859-1?Q?/uHbFtcKKixLMpZ5NQG0H52/l3572ebS+2v4SZ0hhB2f1bJDbyPCZZ+Svi?=
 =?iso-8859-1?Q?4jEVYQhIW7IXMzXLqSlHZD6INvFr77Xvinymxo75tvc0+XZYKooZmsFqF8?=
 =?iso-8859-1?Q?r7zOD3uzI+7uRGTf+3m7RutgaBAL6U2uvofMFKv8ivqXKAyWC5eAB2rJiE?=
 =?iso-8859-1?Q?Y6jFy/P42AtdnnaOSmEd8U1zAToegtt4anHsrX0nj3CqRvbvpCWZwt99o+?=
 =?iso-8859-1?Q?DZoyfaQ5hy3DXwWWtdQLb0b7lJr/mdKcjF3gObMd73H9lfMJ/mMBNeIKZ6?=
 =?iso-8859-1?Q?QmOeaa+0cDVIykxSD7uHT8noZ1MYAL5pjQLj61/7LNPhAe2h+7dRoEe2D2?=
 =?iso-8859-1?Q?dsm11/R/uuuJwGMH8aBQWmmLRajPpW8ydcYuitY0vJQR8K/FEySeZroyEf?=
 =?iso-8859-1?Q?rTfSYBEYuxywezuRGdvgcfXzbQV0IgBdGYXiSVASlNuGJkRKV2Gb8ftyk4?=
 =?iso-8859-1?Q?GVPXeZ12HQxZIAuGuTp4x9lP9qHgCHBql1KfQofka4IOwHbw/XFiwT3jtD?=
 =?iso-8859-1?Q?J3WWuaYxUJhVOEDruyUdfweddmjkWiL7aU3KNldVC/qiyehTJVbMjzdL/u?=
 =?iso-8859-1?Q?TyYu99jQMwmVgbGKXEBVxnAlAhmUiK3laU/UJCClyYwdgAXp2+UgDUUgs+?=
 =?iso-8859-1?Q?i/spygA6snsf151RgHpDC0pqs+/G?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09237758F38BC0ACB9AAB51B9274ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a13c2f-05b0-44b4-b04c-08dda9b3853a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 13:17:45.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hatf8oGWaLXiZCjhtYvEV6kwHQ9yAA0Ttt20Dq/Df+SeUO77mRvtMapQUAkrlNLggwabgZxWoO1kIOdc+zdTGBiAtFvF/uas4gwGulisTR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0687
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09237758F38BC0ACB9AAB51B9274ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch implements pause for spin locks at two places in the codebase: w=
insup/cygwin/local_includes/cygtls.h and winsup/cygwin/thread.cc b/winsup/c=
ygwin/thread.cc.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 0f82052a8c60811f784bbc76f6df1e0d9a971947 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 12:41:37 +0200=0A=
Subject: [PATCH] Cygwin: implement spinlock pause for AArch64=0A=
=0A=
---=0A=
 winsup/cygwin/local_includes/cygtls.h | 4 +++-=0A=
 winsup/cygwin/thread.cc               | 4 ++++=0A=
 2 files changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_in=
cludes/cygtls.h=0A=
index 4698352ae..74ff92971 100644=0A=
--- a/winsup/cygwin/local_includes/cygtls.h=0A=
+++ b/winsup/cygwin/local_includes/cygtls.h=0A=
@@ -242,8 +242,10 @@ public: /* Do NOT remove this public: line, it's a mar=
ker for gentls_offsets. */=0A=
   {=0A=
     while (InterlockedExchange (&stacklock, 1))=0A=
       {=0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
 	__asm__ ("pause");=0A=
+#elif defined(__aarch64__)=0A=
+	__asm__ ("yield");=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc=0A=
index fea6079b8..a504e13b5 100644=0A=
--- a/winsup/cygwin/thread.cc=0A=
+++ b/winsup/cygwin/thread.cc=0A=
@@ -1968,7 +1968,11 @@ pthread_spinlock::lock ()=0A=
       else if (spins < FAST_SPINS_LIMIT)=0A=
         {=0A=
           ++spins;=0A=
+#if defined(__x86_64__)=0A=
           __asm__ volatile ("pause":::);=0A=
+#elif defined(__aarch64__)=0A=
+          __asm__ volatile ("yield":::);=0A=
+#endif=0A=
         }=0A=
       else=0A=
 	{=0A=
-- =0A=
2.49.0.vfs.0.3                       =

--_002_DB9PR83MB09237758F38BC0ACB9AAB51B9274ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-implement-spinlock-pause-for-AArch64.patch"
Content-Description: 0001-Cygwin-implement-spinlock-pause-for-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-implement-spinlock-pause-for-AArch64.patch"; size=1404;
	creation-date="Thu, 12 Jun 2025 13:16:06 GMT";
	modification-date="Thu, 12 Jun 2025 13:16:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZjgyMDUyYThjNjA4MTFmNzg0YmJjNzZmNmRmMWUwZDlhOTcxOTQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEyOjQxOjM3ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBpbXBsZW1lbnQgc3BpbmxvY2sgcGF1c2UgZm9y
IEFBcmNoNjQKCi0tLQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaCB8IDQg
KysrLQogd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MgICAgICAgICAgICAgICB8IDQgKysrKwogMiBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oIGIvd2luc3VwL2N5Z3dpbi9s
b2NhbF9pbmNsdWRlcy9jeWd0bHMuaAppbmRleCA0Njk4MzUyYWUuLjc0ZmY5Mjk3MSAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaAorKysgYi93aW5zdXAv
Y3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oCkBAIC0yNDIsOCArMjQyLDEwIEBAIHB1Ymxp
YzogLyogRG8gTk9UIHJlbW92ZSB0aGlzIHB1YmxpYzogbGluZSwgaXQncyBhIG1hcmtlciBmb3Ig
Z2VudGxzX29mZnNldHMuICovCiAgIHsKICAgICB3aGlsZSAoSW50ZXJsb2NrZWRFeGNoYW5nZSAo
JnN0YWNrbG9jaywgMSkpCiAgICAgICB7Ci0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQo
X194ODZfNjRfXykKIAlfX2FzbV9fICgicGF1c2UiKTsKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0
X18pCisJX19hc21fXyAoInlpZWxkIik7CiAjZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9y
IHRoaXMgdGFyZ2V0CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNj
IGIvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MKaW5kZXggZmVhNjA3OWI4Li5hNTA0ZTEzYjUgMTAw
NjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vdGhy
ZWFkLmNjCkBAIC0xOTY4LDcgKzE5NjgsMTEgQEAgcHRocmVhZF9zcGlubG9jazo6bG9jayAoKQog
ICAgICAgZWxzZSBpZiAoc3BpbnMgPCBGQVNUX1NQSU5TX0xJTUlUKQogICAgICAgICB7CiAgICAg
ICAgICAgKytzcGluczsKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAgICAgICAgICAgX19hc21f
XyB2b2xhdGlsZSAoInBhdXNlIjo6Oik7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorICAg
ICAgICAgIF9fYXNtX18gdm9sYXRpbGUgKCJ5aWVsZCI6OjopOworI2VuZGlmCiAgICAgICAgIH0K
ICAgICAgIGVsc2UKIAl7Ci0tIAoyLjQ5LjAudmZzLjAuMwoK

--_002_DB9PR83MB09237758F38BC0ACB9AAB51B9274ADB9PR83MB0923EURP_--
