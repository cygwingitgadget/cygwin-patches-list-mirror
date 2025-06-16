Return-Path: <SRS0=OfBw=Y7=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070e.outbound.protection.outlook.com [IPv6:2a01:111:f403:2608::70e])
	by sourceware.org (Postfix) with ESMTPS id DB669390D8F1
	for <cygwin-patches@cygwin.com>; Mon, 16 Jun 2025 11:52:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DB669390D8F1
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DB669390D8F1
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2608::70e
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750074762; cv=pass;
	b=uIXEdxS2FxBlas0SC4Qv95fu5C06VBZ3WvOJcYhQYncJTGFffutV/zAOJHZMvLXwb8/1c1lfWz9ts/51GB+XUSV1DP5v+9bAfst30GOimwMA//fZWk776ujbx86q8aJhbTKsoz33LIaNmEmSFzWB28nTjuUMMOqUC+AVg/j/nAw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750074762; c=relaxed/simple;
	bh=y5BfyFsUbPoGLxk2AQPohzBM0Nw4g2Sq9xlh4oXvic4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ZO20stS+lxt9wUFlclf95SA42ObFQxJYW9cH1M/O8Aqcn34z/vXwKSWbEhvOy3TFp4X0daqXHiUzsvAKBvCIzgoj//P2LCO4wFJGoAf3QkYZS0Q1SbyHmGe6cwo1iAhBo4hf2J0yguPFRvQjbiTgviSDYMb+CbeSK+/pap1IaYY=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DB669390D8F1
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=WA5BsR6z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ewk6hPHAzemdORrAT3vfCZoZoO/xHZ3rGBjEM7iuLuONibxWsdgvXBx7w4zmCauVjDvYHx03p+jAkhthc6F5HuNOiOpCWLRyqB32RgiuX7jIl4k/7IDZhw9fz5muLZwepm5xMeCs8faeJsf4fzi0dWOdg5pWSBqx91JnaNFuYHBNuU7KvdhKADX05xhbzvYapVzpH9ECMBaPRa/m9RexAriIdG7A8kmo+zq5FTNchX0yMfIZb3dIf2U5KILqoLon68PG8GpmwOqtoiRQWwbDyv43a+eYL1P5P9QHDVNmA+DBjHQ2HDE6jgSwusPRPWF0Zi6kq6/pzTCsf01fzzqzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze0c98nOeYtqoazSD8uGeUcJLdYF5oWr+bJYXMKvXb4=;
 b=cUaZmjyhnL/JO0IqBWj2z7cjR5qXejTT3cVDNzsGS67ZRgZKunZsA84sDjw5tuOgRhlwWv2fZAm9WB/zvm925lD9PFziSOpt1jJ4tIil7jKIuGPHVAQKzWsxgUCFbvqKnCsiwKPy6ADMnxO7p3Q0HKCZe+6yHFpp5EWNiaNANNhkGMk9PsyLvM74nV1EpRdVw5NZ+bfIxd3VZ2Xp3DfN0YMPoVUakbUlc0a3rgBR9IN88jujVo1WOBLUl6HzrHJo379GzHcvdmwJmaIuda1zmpgcBogtitBY0H3THDRZMwp8s+2DPx4NZfstV9Y9Jd04MDn542fi6xGR5DQsGLTYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze0c98nOeYtqoazSD8uGeUcJLdYF5oWr+bJYXMKvXb4=;
 b=WA5BsR6z+Mr+tmFB3Z/HWTmly28tr+VqtS86BeO8cqBt/qs1mqWx2x22mamtTYfKdFOJC67qz2Ag3lFEZdhn4XJ9ApCpzhc2DOfLwuzNt1mKSUg7AYnC27Nc2lPuP9f/mYaNtAyyrWJKrzoLP5liQjDeAXxcQ2Uf2P0x01H/MF8=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA1PR83MB0663.EURPRD83.prod.outlook.com (2603:10a6:102:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.14; Mon, 16 Jun
 2025 11:52:39 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.004; Mon, 16 Jun 2025
 11:52:38 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: fix MALLOC_ALIGNMENT already defined in newlib for
  AArch64
Thread-Topic: [PATCH] Cygwin: fix MALLOC_ALIGNMENT already defined in newlib
 for  AArch64
Thread-Index: AQHb3rTjS9SA55xgg0Kk0dOY9KG+1g==
Date: Mon, 16 Jun 2025 11:52:38 +0000
Message-ID:
 <DB9PR83MB092385493BAC19ED728089929270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-16T11:52:37.283Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA1PR83MB0663:EE_
x-ms-office365-filtering-correlation-id: 3f1f9905-7173-4092-c61a-08ddaccc4ab4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cnJUJTF+ySQFNo5+aFa8ozw0i017BRdMY0Z+MS7OYc4+rbtT5Njh+81IFh?=
 =?iso-8859-1?Q?Ny7RJtDAOgt+vw3fJUdt7b/biKT/9iVNmFuFlS384TyO6m8/KPJE9JRucu?=
 =?iso-8859-1?Q?vRuexB2W85wYEpbYAEFaFgIIdgLmICClAEzlDV+0AFWO0NAjRVISH/GhwX?=
 =?iso-8859-1?Q?MYa57rAJUTUv2qdkwpeWGH9lMEA5XvkvmZDHppCYTxUsAgDIQv1prIF5eG?=
 =?iso-8859-1?Q?tSNwYKGqk0R9Bhlme+ZvtcIflm0ar9n/alzGQfdPbWRNaLJvUrozJz9FPb?=
 =?iso-8859-1?Q?Y6G5te9AhIPRMl/H5E9oPoUgcYz1BmwjGL31GplHTpFqR0ZBNwDJ9FWTwq?=
 =?iso-8859-1?Q?rP67lLVSSLtHZFe1aLdm/FEA9lVFvS3P5xhqonDofxCTBq4P8aVEdUwLiz?=
 =?iso-8859-1?Q?9Hi02k2ADBNb/h78dRXU4v4qlET2vMmT+q+RJ/ME3a9j8ejRugRUXmFQbA?=
 =?iso-8859-1?Q?MNsCVbqv19q8sf656l8jBAPRNwYS5L6A1zYGgyenEE0BaXxjwcqJtMveqm?=
 =?iso-8859-1?Q?cQL72bEBe7GTm5sboizD2wHUae2z5eZ8HHRKX9PqPo26hcbNrKSNnwgtGy?=
 =?iso-8859-1?Q?DQwUuzUMDP55sVIBChPfTPpt41mWxeUd9kw1aJFBIvorFskYbEgdu9geN2?=
 =?iso-8859-1?Q?X+E1nat8ERkFFSF39oxNKAR31s9n3q02X/KHIMwRoea/nWM7MaySDxP+24?=
 =?iso-8859-1?Q?WSm6MAWY52xep/JJtYGQzm1ocRBmZrjlf82jXCabUXR3BsTbj59VjaAAEz?=
 =?iso-8859-1?Q?g3meD6XLCmfxURe2un6fLQ51fJspRzyVzqW1It3bUA1i0WSWEn5kNreHM9?=
 =?iso-8859-1?Q?wMnQNmQlkyvHzgKo1pC4e25CC/cGowKrjyAy5rad1P7dZEyH7YPjNPfNjD?=
 =?iso-8859-1?Q?mD8nbU8fK6Ga6gzj5esndzXlOxt1XVMFL0N7UYp3AKSBC5wtosKai63nzS?=
 =?iso-8859-1?Q?BvBO0R2igVLaCNxGFi13vD0syE26ZzJcRIN7cJi/WkvtWGuRKQsCF9ixhF?=
 =?iso-8859-1?Q?MhrzZShfQx2Z8fXOPjWAaRfGKnwJ1IH2gu1L9Bu78+hbV0txUnM7o67ktL?=
 =?iso-8859-1?Q?X8bHbtyqXsKz6aWB4PfeAcQc/oGPwU6CGX1CkRQ5pxkuz9QO9T4aW+flLA?=
 =?iso-8859-1?Q?kV01inZb7Kl+X3mypkWTQ02ciJdWfkf0hcayTSEJWWvSZxQ11fW3dcnGxM?=
 =?iso-8859-1?Q?tMhLcAhLZGVh6JlyBp25SaZk//ddGKncbACfN+dX9zwLry13WHSMeMcvbH?=
 =?iso-8859-1?Q?/uMGB+oXZd629vqdkH5vBp9U6tm/hYd43QWKIgmeonljkJyKQDHstWy8Du?=
 =?iso-8859-1?Q?cYlSRIWSWki87nBvjYdCad7/+op2c1fKDh+Z68uPpzibG9/DyL4zmTscI5?=
 =?iso-8859-1?Q?DxiW3lYRjemv6y3CKvsaFAfdrv91JoqK8+3dSvCXTBV5CrTtedD3M164Pm?=
 =?iso-8859-1?Q?8KC/5NnIl9r5CN71Zz5Vfsgw6E6j8Bxl8wFGyjOLRKGrp4fssYPlSEttYd?=
 =?iso-8859-1?Q?/MOx2aRbyVX6W8x97YSPsiGNmSJA0aqN0fLdDUtkFEfQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/8MFPnqLszdYaUntN1OLbvsrGCeg6J8VUSbaJT9DR+g39K9LcPe8bYmPML?=
 =?iso-8859-1?Q?OHoZx2+ascSgNESqO3aFy75n7L/Y6cvJ9dGleL/cc1dSOG+rYXAisaQKBx?=
 =?iso-8859-1?Q?A/LVi3CX0nFgte8wF3KEDFsBS1z/k6CTE4MwTIEzAJaux9xEGLB+ArtJ61?=
 =?iso-8859-1?Q?ZlL380XC7pLf2NGcYeFVi6fxSPQQgG7dsDFzkqxAEWfjrA1j2mCdVANd8l?=
 =?iso-8859-1?Q?7T7Fl9L53thWErehWtA1r+odCgeSQqRbeO0KpR502AaGg8VikfR+vfu+O5?=
 =?iso-8859-1?Q?euIqRt3bEXXJ2LMbRDhPkak9v5LqYhSsHUVUnOj7vrsm5NFkReHRZVAZrI?=
 =?iso-8859-1?Q?SmMfNA6PLYFq8eoo/aezowSaIWo0UD2OPFccWndGWaeJkVj0z942vZXRVc?=
 =?iso-8859-1?Q?yci987GhKuAPFab8FO1v2OzjpyVZdwq7l6NtGsgthh3ZmrK1XW+lZFOPlt?=
 =?iso-8859-1?Q?ZDZwUqQrgfibydu++EGROEWkmINFSsMzZyEC6UAOK81xXWKBK9LRHklYcO?=
 =?iso-8859-1?Q?u90Hd55Fzi5RJQLmQoRazWKbin+HvQyHk9nl1jO3XqXckvgH1hTEAit/+T?=
 =?iso-8859-1?Q?eARlr8glGn6uAOvX1VUhM/ZXzpAibA53GWAQVoZdCKDZyO2EDaRmhDddny?=
 =?iso-8859-1?Q?i8w+FGGVSy5s8l+1/BPDnr/DiVhgHU/OxX3Q7ejFWQIbCVOusmjYvP1voC?=
 =?iso-8859-1?Q?tED6EaACplTuzXWdLH6nHz6PF9DnUr8tdYbehTd33WPOXcTQwmTHoCq+Ph?=
 =?iso-8859-1?Q?vTY94tdEgyq3i9oGPUso2y7OGPhhSsl/oOzDZQOjXPAmIiozuHwzK3IqmK?=
 =?iso-8859-1?Q?m3NMPb5Imvulr1YAvfLzRmu26QydGPgxPqAwPBvAzi8IpwRo68IuRLjVsT?=
 =?iso-8859-1?Q?Ma8qUgp0ruT9JM5a6IH0+3L8HIbRQDnwy0zL49ZAOpUgP71VKT3p+R5SGE?=
 =?iso-8859-1?Q?0R+7Htv858Ba5zc++9Z5GQOIfvYOYDRk04d+tTo+KGbFNIBg9XXyh9+dIW?=
 =?iso-8859-1?Q?OB8BAYS9FB981jEZKkbrb5Qg5/ENyt0hzoPQxuV4739ot491HqOsqhFWY0?=
 =?iso-8859-1?Q?wfKmnh2eMqb6+4NUnizZN/rrNUX0JmUYvZQIhVGliVjLzFcA6T4m1dcyCO?=
 =?iso-8859-1?Q?drXtTF0yGygLZ1PMCnjNbyVl2vJQUBJHEyV66c73HaO2joy/LwsoiSN13l?=
 =?iso-8859-1?Q?9p0r5QYiv3itOgGEdTONwhcUItdjmBSGsYiTm5snxzhbcMem7glZgbrM0Y?=
 =?iso-8859-1?Q?i9Om3/3GiHS4+9tCB8YsoH7lGCchQdBwwb5FDN3coec/yyjUWd+VJsb63W?=
 =?iso-8859-1?Q?/WGEu65+FgpKqt6aC0IeXSLTwOD2e97/KgxBzRFRvZV7+eSeHOmtIJLDQs?=
 =?iso-8859-1?Q?bka11OPR4xxeHg/djlWHhQilcCFatviK0AedRma96cgzV6aiMGkyJGVBcW?=
 =?iso-8859-1?Q?gI2zyCNnR8dB6By5ZBjNJQO+nTp3Ha4PLlkU60hS50s94+EJ1MErhhdJPX?=
 =?iso-8859-1?Q?Uk6POiCir7CT6R2KXxGfsjYGAg9NE1VHDSzAmy3tUca9ktNxP8OR/a/5kA?=
 =?iso-8859-1?Q?R45lliWph++BH5iRefVLZvcJK/Va?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB092385493BAC19ED728089929270ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1f9905-7173-4092-c61a-08ddaccc4ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 11:52:38.2010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHb0lnqmSxWxUKlUgiSmJcoRKvWikFrXdH7Lc3HRcAHrYeocg4DviKw9Pr+hVkf7Jc/Fk0oDjaTrEiybu3KL5avvlJWrDQJJOgBoQ8Vx8Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0663
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB092385493BAC19ED728089929270ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
The `MALLOC_ALIGNMENT` macro is already defined in `newlib/libc/include/sys=
/config.h` for AArch64.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From ac23da59b18480c9a98be5ec41492182f24b0f45 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 13:16:20 +0200=0A=
Subject: [PATCH] Cygwin: fix MALLOC_ALIGNMENT already defined in newlib for=
=0A=
 AArch64=0A=
=0A=
---=0A=
 winsup/cygwin/local_includes/cygmalloc.h | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/winsup/cygwin/local_includes/cygmalloc.h b/winsup/cygwin/local=
_includes/cygmalloc.h=0A=
index 5e1fe8154..898ea56a5 100644=0A=
--- a/winsup/cygwin/local_includes/cygmalloc.h=0A=
+++ b/winsup/cygwin/local_includes/cygmalloc.h=0A=
@@ -21,7 +21,10 @@ int dlmalloc_trim (size_t);=0A=
 int dlmallopt (int p, int v);=0A=
 void dlmalloc_stats ();=0A=
 =0A=
+// Already defined for AArch64 in newlib/libc/include/sys/config.h=0A=
+#ifndef MALLOC_ALIGNMENT=0A=
 #define MALLOC_ALIGNMENT ((size_t)16U)=0A=
+#endif=0A=
 =0A=
 #if defined (DLMALLOC_VERSION)	/* Building malloc.cc */=0A=
 =0A=
-- =0A=
2.49.0.vfs.0.3=

--_002_DB9PR83MB092385493BAC19ED728089929270ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-fix-MALLOC_ALIGNMENT-already-defined-in-newlib.patch"
Content-Description:
 0001-Cygwin-fix-MALLOC_ALIGNMENT-already-defined-in-newlib.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-fix-MALLOC_ALIGNMENT-already-defined-in-newlib.patch";
	size=902; creation-date="Mon, 16 Jun 2025 11:52:26 GMT";
	modification-date="Mon, 16 Jun 2025 11:52:26 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhYzIzZGE1OWIxODQ4MGM5YTk4YmU1ZWM0MTQ5MjE4MmYyNGIwZjQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEzOjE2OjIwICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBmaXggTUFMTE9DX0FMSUdOTUVOVCBhbHJlYWR5
IGRlZmluZWQgaW4gbmV3bGliIGZvcgogQUFyY2g2NAoKLS0tCiB3aW5zdXAvY3lnd2luL2xvY2Fs
X2luY2x1ZGVzL2N5Z21hbGxvYy5oIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z21hbGxv
Yy5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWdtYWxsb2MuaAppbmRleCA1ZTFm
ZTgxNTQuLjg5OGVhNTZhNSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRl
cy9jeWdtYWxsb2MuaAorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z21hbGxv
Yy5oCkBAIC0yMSw3ICsyMSwxMCBAQCBpbnQgZGxtYWxsb2NfdHJpbSAoc2l6ZV90KTsKIGludCBk
bG1hbGxvcHQgKGludCBwLCBpbnQgdik7CiB2b2lkIGRsbWFsbG9jX3N0YXRzICgpOwogCisvLyBB
bHJlYWR5IGRlZmluZWQgZm9yIEFBcmNoNjQgaW4gbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvY29u
ZmlnLmgKKyNpZm5kZWYgTUFMTE9DX0FMSUdOTUVOVAogI2RlZmluZSBNQUxMT0NfQUxJR05NRU5U
ICgoc2l6ZV90KTE2VSkKKyNlbmRpZgogCiAjaWYgZGVmaW5lZCAoRExNQUxMT0NfVkVSU0lPTikJ
LyogQnVpbGRpbmcgbWFsbG9jLmNjICovCiAKLS0gCjIuNDkuMC52ZnMuMC4zCgo=

--_002_DB9PR83MB092385493BAC19ED728089929270ADB9PR83MB0923EURP_--
