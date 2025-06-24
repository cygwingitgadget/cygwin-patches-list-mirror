Return-Path: <SRS0=J7gK=ZH=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::70f])
	by sourceware.org (Postfix) with ESMTPS id 68DC23858D20
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 19:21:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 68DC23858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 68DC23858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::70f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750792902; cv=pass;
	b=YisHWdOcV8RaEMz87qU6oxoliFFjyr05a+xucxQPuMUi+FbxmuWffDsnOexuWxapxKXOaGsq+u0ujNoSKHubdBMp6YjiLFic6lnouh07URCEuFYua9iHnX8dQ5WRsEgbNWg0sPaheBpVyLVELtWLSHpFdKod5DlAfuXyTkGTuIw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750792902; c=relaxed/simple;
	bh=+Qdjun5V3pF6/tjvArJogL+suQnAL4IBhFBLfj7kHWg=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Gya7X00ody7eBEg88tDWXwoHURC5pYeNTaadc/+WnCyxB8qJGNsQAH1eBaJAEdR52HKfFDbvelTMmC/qphgkXuldaK6gbcOWVtMV10BCp/DbGqdePaBMt9XuKKkbb3lKExmCh9auJbpWWxybMhr5ZIk2T1Kcg3GZCbnhntz2soU=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 68DC23858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=WXeGyxwS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNFjnR2s6gUuEQkxC1EL3VCyNjDU0OSHbQ2WmxreIH6I3RVuX7vqJvypuoQvfilOAUperXc0b83yIk9A+jPvKpWjBwEQEjErHH8/obSi/AzgVj3uoop0LMSxlYE6ZChYhC1haTrMWv3OPMa4fScc5VSAeHHlHUARhsJ+gXE418/dvBR+ORUT0WBFHJnB/U4KsnHRKa7r8nHiLPDM/iTd8AYhoJOAA0mlMdUpjJ1VGACeDUJ+WmCLjsmiuOZzqOfWLjUxOZ+46j0foRQCA9qr+XmEJ2xOSx/UoyodSKMU5tGct7wI1M2s9eFCUqM/Sgjq/jx9hIS/QHlCGn3tulz2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2bICkeeaCUwxNNIast7a6Ycyo27qKAD5SUFxFs6ae8=;
 b=mCAAnyFHEj9QK10GSRr6GI8bbjw7p4kBKGPZUI8ImFIBcJWqzShkdrHzZJSmNHsurQR5P98PPOjH1YhJHD4tzOV1bOzBgtFvsW5D30X08SdXGB+aCfCM1tgGycLSVvk3rHQhfIsiMj5vCfVSFjRylnvow8aJR48io0+h6XD/oeGEz8glfwINNr3havf0YVib6vu19u8iE25ieaAXpgGUoLoA75BXy4qIBikeEH25s8fObHC6jMRxZPK9ma49EseZMFVPucozcwzv6AltBuhPB/9Adf+TWvxM0egMqC8pCnC9m7qHG2Haffj8aS50Rw2bvHU5qLlFsowwWEymRHXowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2bICkeeaCUwxNNIast7a6Ycyo27qKAD5SUFxFs6ae8=;
 b=WXeGyxwSFu7XuLqkrCjgijxORPY/XNaPxts4ueVXXk/eaBn3xkBkeJzJvl3XhybixF/Bkz7QtOMUZXYR/+I6YBk5DiQRIn+v2/mdShzOvuw3FXg4GIHSPMwcQF8SY9WEthnPZjIY/aWjGqMCW9NzRV8Ct4keUMhmgOqHpScHJU4=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GVXPR83MB0690.EURPRD83.prod.outlook.com (2603:10a6:150:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.13; Tue, 24 Jun
 2025 19:21:37 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.012; Tue, 24 Jun 2025
 19:21:36 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3] Cygwin: stack base initialization for AArch64
Thread-Topic: [PATCH v3] Cygwin: stack base initialization for AArch64
Thread-Index: AQHb5T0zjgzqsN7dCU+0C5sqS6fNVA==
Date: Tue, 24 Jun 2025 19:21:36 +0000
Message-ID:
 <DB9PR83MB0923D30C1D31D3B74457118C9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com>
 <5a0ee0d2-6fac-1886-45c0-c75dba8d0bd7@jdrake.com>
 <DB9PR83MB0923E495EA001D0887EC80469279A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFj-bZ28sTEOvVqj@calimero.vinschen.de>
In-Reply-To: <aFj-bZ28sTEOvVqj@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-24T19:21:34.942Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GVXPR83MB0690:EE_
x-ms-office365-filtering-correlation-id: 87cb1b6f-e55e-4f78-30bd-08ddb3545669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?L27zTgDj2KastGd7uYOl4wd0706EShyGKiz4BiV0EidyMbnGZxtdi5gsXh?=
 =?iso-8859-2?Q?gq92IdxvaMIfC4AcdUvp1jNkGpziC4J5MKU2rxElwoYE98gxiw+WH6m6Or?=
 =?iso-8859-2?Q?eGi98Ke0Rzxov+ne0I3uZ7G7Z1Mn1S4oagIh02zD6Mt9G4gu0a1vOz8dgl?=
 =?iso-8859-2?Q?6PQzvMzGu/1Ai+5TFxtPokwxR/yXvkj7U20r1udbScnxXLtxA+OVP3MQUa?=
 =?iso-8859-2?Q?g54MJSDlNv1IWY0IGcMsDlf1asUlpE7ARFCGpCnBuJprsJC4pztWmhDXMh?=
 =?iso-8859-2?Q?TYJe25y43yduovLbd6P5dYdoEohSl4QSxcvdDtOviJKF26WDNUFPod8NFW?=
 =?iso-8859-2?Q?g9+DMB2iir95AatAMbja5KUIFEh1oGXbK6xX7NAiTzu2PHSR5NY30SdtZ/?=
 =?iso-8859-2?Q?vxQ6Gq396cM9M+I//MDw5mU4KeIgRnAo7wP9RkyfBVKxp0md1PNXBZfE0Y?=
 =?iso-8859-2?Q?3m48/g2fgiN4KiYonfxTBXxLMdcvpSLxruf9PLXcCEAO+47mVhP5vz6mfs?=
 =?iso-8859-2?Q?015UCnM9tCIidKOjX+OfIQyzj3oWiCqRjhyuaNYPXY5gUTmuhXygIx7qdM?=
 =?iso-8859-2?Q?9Z9H+bRgmVijAJGu2gC6t84saOpxy2vHd2PBgx2jM7WDuusRx+fXyxXm63?=
 =?iso-8859-2?Q?6oDDQT5ZSxDyujiTBuiRj5CVd3rlHPhXW+wbeukKXgzj9EIHLBeooXKHdo?=
 =?iso-8859-2?Q?gpeU98hG0EZlM5gzswTNnet2U64KhSAJl9u+e0RhGIHTvAS3ob8416o5IG?=
 =?iso-8859-2?Q?Th5L4lbmbbcjz3qMB0fBGCSg4VxoCYcHBanW+Z1LJhrWophRl7Z0WB2ojV?=
 =?iso-8859-2?Q?V1D/V8O2JLDMwAR8HfQ00hwiwYRCYA+cpHkFkSLHVTXR+8jNmtdymgJRY2?=
 =?iso-8859-2?Q?0SRhBy8ja4KeU9imy2A0kjoLBhnJxOB232eIeo2SHcgLRfYLFF68jTFKLk?=
 =?iso-8859-2?Q?FxtNwDwhsJtikayqipRxINL2Bwsx1KLh6FY8aGJEfdJReLlsYHMPrh61w9?=
 =?iso-8859-2?Q?UrsDFfdeH+20l73VC1XYAfrO31EpD0WN4JX7sU0v4foO6iQad+eA259Xqf?=
 =?iso-8859-2?Q?/H6qxteT+p/W+OvGpePnza89k/WlUT5EQv0Ayym4cbX0FzOE6MwDEBtaDC?=
 =?iso-8859-2?Q?mg9uaWYD4s6q1+3WPKU3kHNtEr+0FYnMItB3VTm4YVfMwYHxKbFIiT7vK0?=
 =?iso-8859-2?Q?nL1LD41tZDji5RYc0aeaS/d6o462ns4Qnh/u2m/ohXa6KHGTX3qE04n4sA?=
 =?iso-8859-2?Q?9or+7T2c2oTJuVjJYUqh/QFErqnmoxfAm/LfBMB6lyaGUR7wfYUFuWwWFq?=
 =?iso-8859-2?Q?kmnVmaD6AHzd0Q+1aglpsmaCEVuptoJFPmf3vX0IQOrfGWy8ompD5pyETW?=
 =?iso-8859-2?Q?6qax73so2b/lGKuAO3b/FEbjfNJuLk7GQFQbn/j/Wb5641izvKqerV6ltd?=
 =?iso-8859-2?Q?Wx6HWVnpqLrry4qmn9VG1efuQ36RR+pt+EOxfLrWf8Mx0LHUbsZR4tdzHu?=
 =?iso-8859-2?Q?4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?kAxevF/2KRs4zpeL3c2Gbsrtt8ttkR7l/KvbMzjS0F66vq9cRvcB9Gg0in?=
 =?iso-8859-2?Q?8F91L+N7z/y+f2XWqA1JLY0NoNeP/EsQnRnQyXyJz9GbiLIYHf6sbiwVGx?=
 =?iso-8859-2?Q?mElZJoFJnOocZr6SR5fac3PMv9Mggu/qCAj+sjaBM8w9F/RzO3LHQankE+?=
 =?iso-8859-2?Q?Exciggx4pNntyzyn+Yv/7tKTta1hHplKkTTLj/4m3ucL10cMVlybJmKFqu?=
 =?iso-8859-2?Q?A221Iq53LKUSicIbpMz8JN2WeOFC9elgz9ji62ZlauhuufVuny+dOMjD81?=
 =?iso-8859-2?Q?M30P/12y8AKzCNNL951rz/t5xEJbbLE5y8MYClpovP+sN+K63WGwngRx3F?=
 =?iso-8859-2?Q?yqVgdw7x7r78ygPG1NnlcgItE4/3RhvzjNbvX7YdS7u9uW4pT/7ATT5Gcy?=
 =?iso-8859-2?Q?qmuWhoL5LSjrUGCf30jUQSiZJGXYwtam972Hazs2phkT1g5MWQwSN49HfB?=
 =?iso-8859-2?Q?8tO+Ay+vsvd6qGrd0oG6l3QAHLJj9ihJqlEhvsqrmtkdornJHZEm8/SCDc?=
 =?iso-8859-2?Q?tcPu7I6SI7rC7Ub4mrJkeLpKWgthHD8lcsn//p/jSSKEIyppenfply2yuc?=
 =?iso-8859-2?Q?uaKmOp06psPlgOFU2MiJnI6f3OtN8ZycaNDvG1NsxNG3xx9of3mpL8+12h?=
 =?iso-8859-2?Q?ILcp8Hh3cgWWYqwer5UExE7EBEvYrLazUDRjAkVS8i2KfBD5MlUMYUZyNG?=
 =?iso-8859-2?Q?CjwqzkjuUBpg8Dgb3P8yjd3lpGS+X6mDaVqly2EIrNqWWONS7HKKzheD+T?=
 =?iso-8859-2?Q?NbCeVTdlxwpcJvHxHF7fo7e2UwPP9l17Zln6JYGAZzaMs4RTUO77w/dGlP?=
 =?iso-8859-2?Q?BtZoP13gLBCT9HDXsIkhKaCl0dNdYoJzSk1+QaEz14GJ9Wi05VXLxohCzv?=
 =?iso-8859-2?Q?Q4vv6WwAq2GAJfJdEbD+WGZ1iA8ui6IoW9CdIG3Jm4wO6YpL0x9elXWB06?=
 =?iso-8859-2?Q?1D3Pk4ZPHezJmmj3w5JAB9JNGy66+lOzbOJIQ3HTfR2bWw6oGuwaGD0qnZ?=
 =?iso-8859-2?Q?04V8Z/ccwW0Kk1bZJ7yvB0V8oa5t2j6G99U4KjHzwrHdCMshlr/pVkSaZi?=
 =?iso-8859-2?Q?LXq4t8L1X4l7SOMvMH+YBBlKOBuHl4b8slHLTScHxjHQgB3+meZja3GRf2?=
 =?iso-8859-2?Q?cKsMAdKDHz5kNYuBJdzf4kcVs3E8pArR8zxcRyCLotNrpmi/TusU+eU/WA?=
 =?iso-8859-2?Q?2+IC2FRkzh5UKCojpfQURhO/ZQcYVt0DeBAwQ74VE11yhNh0TNCor/sF6v?=
 =?iso-8859-2?Q?WvCyn5W94BneS3X0qvwS/Uvz2UTjgV6/yzOMT1ssCuerob6rCLzlZ9ciiA?=
 =?iso-8859-2?Q?xBmpXtukBQLOhJ9TJmbudRVNSiVSrcvC0z+PLfDqvti4hWRbafCaTHyUjL?=
 =?iso-8859-2?Q?VFHYOl3yZqPvrIz48Ub5VnAz57s1zTf5D99/rlw+3n8Vn6tduayT+6i5jC?=
 =?iso-8859-2?Q?E5/qWNJtCeldf07aHfbUTDGsbKGFmR6jLBvA9BH4+3ruvHZ6hj1uVyOp5g?=
 =?iso-8859-2?Q?NIfJ4D9+/2mtT0q4tScp+gXhUJKPpWckVWCmswjEZHaGIvCNonWUNeKcXZ?=
 =?iso-8859-2?Q?Xq1aDxLiswYna50Jn7QyNQT6KvSN?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923D30C1D31D3B74457118C9278ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cb1b6f-e55e-4f78-30bd-08ddb3545669
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 19:21:36.4304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+28UXTlN+W/WJC8QVWVw5U8mb36U1R4+5XI4Ni0uu2ziUJvEr81rv81HiQjtxfTpZ+N0OSBsl5gUTWuG1WUyPO8oLiECbdlurYZxi+liVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0690
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923D30C1D31D3B74457118C9278ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello=0A=
=0A=
Finally we've managed to rule out that the regressions were actually introd=
uced by https://sourceware.org/pipermail/cygwin-patches/2025q2/013832.html,=
 Thiru will send the fix soon.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From c33f2e1b0037f9e5a3dbae4a0c82070db851cb33 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 13:15:22 +0200=0A=
Subject: [PATCH v3] Cygwin: stack base initialization for AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/dcrt0.cc | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc=0A=
index f4c09befd..3dceae654 100644=0A=
--- a/winsup/cygwin/dcrt0.cc=0A=
+++ b/winsup/cygwin/dcrt0.cc=0A=
@@ -1030,14 +1030,20 @@ _dll_crt0 ()=0A=
 	  PVOID stackaddr =3D create_new_main_thread_stack (allocationbase);=0A=
 	  if (stackaddr)=0A=
 	    {=0A=
-#ifdef __x86_64__=0A=
 	      /* Set stack pointer to new address.  Set frame pointer to=0A=
 	         stack pointer and subtract 32 bytes for shadow space. */=0A=
+#if defined(__x86_64__)=0A=
 	      __asm__ ("\n\=0A=
 		       movq %[ADDR], %%rsp \n\=0A=
 		       movq  %%rsp, %%rbp  \n\=0A=
 		       subq  $32,%%rsp     \n"=0A=
 		       : : [ADDR] "r" (stackaddr));=0A=
+#elif defined(__aarch64__)=0A=
+	      __asm__ ("\n\=0A=
+		       mov fp, %[ADDR] \n\=0A=
+		       mov sp, fp      \n"=0A=
+		       : : [ADDR] "r" (stackaddr)=0A=
+		       : "memory");=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
-- =0A=
2.49.0.vfs.0.4=0A=

--_002_DB9PR83MB0923D30C1D31D3B74457118C9278ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v3-0001-Cygwin-stack-base-initialization-for-AArch64.patch"
Content-Description:
 v3-0001-Cygwin-stack-base-initialization-for-AArch64.patch
Content-Disposition: attachment;
	filename="v3-0001-Cygwin-stack-base-initialization-for-AArch64.patch";
	size=1351; creation-date="Tue, 24 Jun 2025 19:18:04 GMT";
	modification-date="Tue, 24 Jun 2025 19:18:04 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjMzNmMmUxYjAwMzdmOWU1YTNkYmFlNGEwYzgyMDcwZGI4NTFjYjMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEzOjE1OjIyICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2M10gQ3lnd2luOiBzdGFjayBiYXNlIGluaXRpYWxpemF0aW9u
IGZvciBBQXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsg
Y2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpTaWduZWQtb2Zm
LWJ5OiBSYWRlayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5z
dXAvY3lnd2luL2RjcnQwLmNjIHwgOCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZGNydDAu
Y2MgYi93aW5zdXAvY3lnd2luL2RjcnQwLmNjCmluZGV4IGY0YzA5YmVmZC4uM2RjZWFlNjU0IDEw
MDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2RjcnQwLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZGNy
dDAuY2MKQEAgLTEwMzAsMTQgKzEwMzAsMjAgQEAgX2RsbF9jcnQwICgpCiAJICBQVk9JRCBzdGFj
a2FkZHIgPSBjcmVhdGVfbmV3X21haW5fdGhyZWFkX3N0YWNrIChhbGxvY2F0aW9uYmFzZSk7CiAJ
ICBpZiAoc3RhY2thZGRyKQogCSAgICB7Ci0jaWZkZWYgX194ODZfNjRfXwogCSAgICAgIC8qIFNl
dCBzdGFjayBwb2ludGVyIHRvIG5ldyBhZGRyZXNzLiAgU2V0IGZyYW1lIHBvaW50ZXIgdG8KIAkg
ICAgICAgICBzdGFjayBwb2ludGVyIGFuZCBzdWJ0cmFjdCAzMiBieXRlcyBmb3Igc2hhZG93IHNw
YWNlLiAqLworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAkgICAgICBfX2FzbV9fICgiXG5cCiAJ
CSAgICAgICBtb3ZxICVbQUREUl0sICUlcnNwIFxuXAogCQkgICAgICAgbW92cSAgJSVyc3AsICUl
cmJwICBcblwKIAkJICAgICAgIHN1YnEgICQzMiwlJXJzcCAgICAgXG4iCiAJCSAgICAgICA6IDog
W0FERFJdICJyIiAoc3RhY2thZGRyKSk7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorCSAg
ICAgIF9fYXNtX18gKCJcblwKKwkJICAgICAgIG1vdiBmcCwgJVtBRERSXSBcblwKKwkJICAgICAg
IG1vdiBzcCwgZnAgICAgICBcbiIKKwkJICAgICAgIDogOiBbQUREUl0gInIiIChzdGFja2FkZHIp
CisJCSAgICAgICA6ICJtZW1vcnkiKTsKICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3Ig
dGhpcyB0YXJnZXQKICNlbmRpZgotLSAKMi40OS4wLnZmcy4wLjQKCg==

--_002_DB9PR83MB0923D30C1D31D3B74457118C9278ADB9PR83MB0923EURP_--
