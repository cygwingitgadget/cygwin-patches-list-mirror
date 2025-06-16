Return-Path: <SRS0=OfBw=Y7=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070c.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::70c])
	by sourceware.org (Postfix) with ESMTPS id A2FB238083C4
	for <cygwin-patches@cygwin.com>; Mon, 16 Jun 2025 11:44:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A2FB238083C4
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A2FB238083C4
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2612::70c
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750074255; cv=pass;
	b=YmMf8ulcbDv9A309Na8zJ1B6iuGuIao8J65XNepMW3tXpVMILKv7XlFEe94nc9QUssPUFvjQykzfRccEROAx8Zzvmnk2kSQ6vopklIUP/xlZh2/53UvL26UtTrZXh3X67OYJcuLtx/x6N6CM20JDeI6xtfJ0EyAkRPtoV5julPI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750074255; c=relaxed/simple;
	bh=wJIoy/9LWjRCvHrZ4i1RfvbUESs+PZVeXWdrrQP0lno=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=UEVPxoOkB3xW/bSJKoz3/UMVJ7zbw9tScTFneOIyMf6jhEVLSov7Bl8TqqSefrBqe0Wd5YI0aqTyLNAWA1SmxqmkyzZxVV9Bbr7ByUMklJT3GQOy5bAFfcTnwgQIVFBtDkek3ZrDDseUNXMZr836eUktnIFFvtDWD6ixzGOdw+k=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A2FB238083C4
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=UTEeIIV5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6LeQ97ZxW+W406VZ7hef6zCItsXMV+4W8GiDGNvnK6lk6uEUNmeTtSta2JKcIVITHHzEhh0jE5dURup7WCAOTv6ceZA+w4+efqz3K5KcPA0SxyI2BnBNXDS5vbglSwX2w3QJa3NiR+Ma+qjQdZRNiL8EhpJZOb8Pya5TNrMH0s5W45o54wdZx0sg1dn6pNolBs2mwLniKbSNN+tFepDQz328dzhYOadg99AQibu6XopwhWckOfIy6hUVBY7nqMY3fjknCipkVXr3CN1iu5qA1hjXSM5sM2RvF2Z/d3nQQIE2vWFKn5RrSd7vbw4mP+TsvNyNQnOXYA4fyWlmUu8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez8OV/w6ilbZ7OtC3hEScQsDHzrqCV2nbH8RpA5uGRU=;
 b=cAahvVmNS3oqPAP3IXF1vLEUTyJRtdSi+lkcCEDHXBYeQnXtJGFSb8ISDISO5B/i/+ogqliUFkGIQufhVrjgN+O8KUxr02JhnwqlzJlhf2gEkHv8NwJg3uveT8Hkuc+v72mmMC0aszM+eEbcnbhGglRKGL3YQTiCq6RzOe1g4n5svdnDG96WOYHinTFyDhXExAyj1rlemOX1BfbOO87DzLvdY4PUYfghzqK40CsOS9hRD6sASt/Ofz7krKh5yfe62hfn33+05poh8fQcOBF0vveOE3nLb58EfS7+yWekOK31N6M3PXbsSRKG9us/8v9AE33uoHr10WhU3vePFeVC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez8OV/w6ilbZ7OtC3hEScQsDHzrqCV2nbH8RpA5uGRU=;
 b=UTEeIIV5XSLAmRlia1TdjYKaRZVYyy6ktmKYkt0bxxONaPMnkSBtK9rmKwk3cpZXz8lNcHK+ybwsSpgGjhdM0cwQpX+7BXFy+fW/Dj3l3v89jZBIFAsH/o3lRmlxKFLRFGjMXawYu6J8NVSt8MqFyHcS/mDjaYEW8yo/5S97Qfs=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA6PR83MB0646.EURPRD83.prod.outlook.com (2603:10a6:102:3d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.16; Mon, 16 Jun
 2025 11:44:12 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.004; Mon, 16 Jun 2025
 11:44:12 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: fix compatibility with GCC 15
Thread-Topic: [PATCH] Cygwin: fix compatibility with GCC 15
Thread-Index: AQHb3rOEBcpLk2ABHECBNl8rJ+qFZw==
Date: Mon, 16 Jun 2025 11:44:11 +0000
Message-ID:
 <DB9PR83MB09231D8148C836A3AECDB3E19270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-16T11:44:11.203Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA6PR83MB0646:EE_
x-ms-office365-filtering-correlation-id: 9ade57a5-1169-4bca-a26a-08ddaccb1cec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?YEgo0XCw+YqjUgfm5/wgEjPt9sviC8hHPxkwJ8t5ce2mqQNbddY2n8v8aW?=
 =?iso-8859-1?Q?nCWyvUv4UistLBvLZA0dKaM6PIK0ZCpQfSbRkvS6FeEy9oZ3BhccVpGZ2S?=
 =?iso-8859-1?Q?tifrslYJJmLVJXCK+5hJ/rlcreVd5v8n2u85aXfJKfF9CIceHYmBbiDXR/?=
 =?iso-8859-1?Q?kVg1i2Wg4SZAK6qEDQEF+bJD6NSG6qsNJy9sVKWYC/UJDkuM0LEA4l4vLV?=
 =?iso-8859-1?Q?VsoRFndBQ+gawJHRGPoyg7NoZmiGVH5ooSHOBD4aGu4brXpZGkvvKTNr7w?=
 =?iso-8859-1?Q?5h5SukLd7ezpcTqJfyQzDCdYVQHjauN5jG8HtwfMaX48De4jurVai2E3Gg?=
 =?iso-8859-1?Q?OfW1xmwypVk7aJ9IwANf83g6ZVLe1JnOixtKe7WsqWih7AYT5ZcnagvyE4?=
 =?iso-8859-1?Q?IWr2QLX3AIy5sqPW2ObGvCaJVxGgSxx+JmST8ADHzigtSZG2MsZ9EnwPj+?=
 =?iso-8859-1?Q?UxLFncKVhxi4AIKkWFDUj4qAAd//ZIzmKclJ/M+7EQSsoiFDy4lIQnOHsC?=
 =?iso-8859-1?Q?UZihwGeS6W3RAXUnMOkGXsY6l66V8cxK6PovthzyQW3iRw0NRtxmZvAQKN?=
 =?iso-8859-1?Q?HxLDREkS5odjxqjMfoQAO3sqprAeabn7Rt90HSbQxtkg8Z3ehuiiTaWunt?=
 =?iso-8859-1?Q?EpYnPq68KDsZqRF+ouh6c8JgfIRqh3xsfd6aXaSrogVspUT0ZWxlun4dCY?=
 =?iso-8859-1?Q?/pR7erE4ZfWes69WOvaqwxIwnwtg4CgDaT+je2LLAtR1YXW59UU39RvQ1b?=
 =?iso-8859-1?Q?0ebHOF+3A2bjNNJ7dySGbo4wy0uP3/4Obc9O+FP0S+4/TjuXPjSCJsG07L?=
 =?iso-8859-1?Q?i2CLtI8R0imYB7w5YTRwDqRCcV408UPcoZQfHPgEIshH82SFT0KdS36ixo?=
 =?iso-8859-1?Q?A/gNk+LXM9S/BBb/HSPoeXfDieWnXokrqagAN/giSEX2KEbab40/oplZnl?=
 =?iso-8859-1?Q?QlpfUcVE8SvCjbZENhppV+uDInEfaBUiVg9eY4vKgHI2Dgkcg+BlG+2xoa?=
 =?iso-8859-1?Q?mgxArKPpwoWcAtfZ6+e6bV07MMBYHeymf1XD3lDNoygIjHqMIi+O4yqD/W?=
 =?iso-8859-1?Q?rqtPDid5ErMc0ra68OASpJAAxdp/UGbGnsqAsl7SYRc+hFewcRaWZdLbuR?=
 =?iso-8859-1?Q?Sl+V1I5KM1KVRp2EyA2GbDoCS8csqKa1QUyjyAlOEBHI53iERrUH3aF5K+?=
 =?iso-8859-1?Q?VPxNmEzOVnbzyV5XKc4Rhk3ekM2ode4z60+NheWr31LnFvKz4KdbNwDT8R?=
 =?iso-8859-1?Q?GmQ5JnLNowZ4Dp/RcgAn9QjGrAvPNLcMhyH401wN+epZANIMIczP3DJb/T?=
 =?iso-8859-1?Q?rE3NE99rTYCAr4Kz8VmnlhJ4r4MSZ1jRACvNXmBjvAS9TT7/8OW1yxlH44?=
 =?iso-8859-1?Q?lHf3VZo85w8nuaa8QsziA+2Aq+iNbfUt0Iu9MDBGXt/7Eo2Hz7lKdhdYqx?=
 =?iso-8859-1?Q?qIkZsJEyvesor80NWoQ1O+WxPunMXTd/yvyFaE4pThP3ClsPJOFr81Xuwo?=
 =?iso-8859-1?Q?s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2LyJuEAPU/aoDktWQTdFWnFHaUG/wTIPiiUMYlyF7WmCKbRxV6DnA30R3/?=
 =?iso-8859-1?Q?SmLiiTklqnghZGOpM9dnG2Lm0DKiLIK/SpD3aqqifIdwUQtm21HDnoQtnc?=
 =?iso-8859-1?Q?sldKPaCBV2TVQINd03IB8foGplw55+0DK+b9e4HCJ+AtJp6+afig2agFo+?=
 =?iso-8859-1?Q?FSZDqaYfxHkLNKHK+O8SbLfSwRnwP3mYQOp1/PU+LI3CPaJaaiO4w2S29v?=
 =?iso-8859-1?Q?DfcppSYvvqOYdSVlkl2g0/WDJ6s7PKNGYuVsLsImJFfzSXvEgsv7h7R79G?=
 =?iso-8859-1?Q?+b7Zfz9BIi+u9TBPc2KYM19MvZuxDGRiIo2PvuqC586Da48jVyHNzERLE6?=
 =?iso-8859-1?Q?OxwtvbNKjbj2MAkqdkDe07K5niAnjlg0BtyuA1vH+txCgPgi+3eWbXnZ1B?=
 =?iso-8859-1?Q?cFQ/PunKNWW8wZ92S56x79AIWdLCTIYZzgC8FlcbTxdOe4+Z7UILT51+EF?=
 =?iso-8859-1?Q?4jMy4pnGW4Y0m6TX6wMd3MfR/gcQPz5uRoK6DLpJIMReZiQroEkWnQyxkn?=
 =?iso-8859-1?Q?WchPM164FoM8TS42AigKOsLr87QmRHm4Let6kNULK2S69B8TlhEJHUBT1e?=
 =?iso-8859-1?Q?Mw9sSPQ7MUoJ0RadhnNploCPz6QDVice5+BhlIy2atVa4V2o9xHCldFwNA?=
 =?iso-8859-1?Q?idNEM/R/4twtHnbQKaYUWSK9zpGkGv0GLsAUc374wJc9Bny2NAhs6k1RNF?=
 =?iso-8859-1?Q?0zxRtgGyi1/AMRKrbdv+E4jnsutpVezddZICU8zisood14uWij9+b2MS6n?=
 =?iso-8859-1?Q?0R7X9jRk+qfbdu10jjLb2TJCTMfVFhbHoSb2XujkANe9mka2itwX5//BXn?=
 =?iso-8859-1?Q?oKccDrkHHmu9ZBZlLcc3iNyQkMb5AKN9gLi+t79UaN2eIHtLJ6sP+zsU38?=
 =?iso-8859-1?Q?MRPJnN4Lq/LYE/hdgq89e+ylxfniuvKu6wDkRhigNDBZiRUTBhRgW79xHN?=
 =?iso-8859-1?Q?F6H/wavdkz8qdeF7L6fg0QWMujv3TvVsu0+SDwBGC+i4yWlAPNdQDhjgmK?=
 =?iso-8859-1?Q?JYx8HTSSTNDXjywP9//aDV0NLMSjQUaqoaldqX098OSWTDxOAKKRi0mLhQ?=
 =?iso-8859-1?Q?Wus4k8q8HRF01fwGO37G3AEehx7UPxYfPmz2N4RNx4+m3YTT2AmpyI2CCF?=
 =?iso-8859-1?Q?GfS0LsLiI1x4Q2TkgmWykOMhIEGqWw5JdeDe6HOH9GB0xVdcrPzUAF//wL?=
 =?iso-8859-1?Q?K2Z/8XQn+H3qrAqJLpE6lSKVXgp8JVpXz6XyuY6iHP+a3nZdHPmbGUr05X?=
 =?iso-8859-1?Q?yiFzp91TEhMG83n4HIiQGXQtit+ScujzfIZEp7KubaaUQJWy2SIK+gZ0zt?=
 =?iso-8859-1?Q?mr2luR0myMDyPTlHhn3mFn4/p7FgKl+t/NH+7+qFRm+S45LaI4UWRFByYX?=
 =?iso-8859-1?Q?tyzrFWM+nrPwqk+ZHkViquoD0K49fk4IjS1NxYuiENjSO0JKI5z45w/VfM?=
 =?iso-8859-1?Q?9WeJhTdxOsXpEa4drYJZzyqOMZhiGB8EJ9NUh0YoQv4iPoMNbA19yMa6Ym?=
 =?iso-8859-1?Q?N9FEY2eRvc8/TYaEVA+TBituZOM1r14LGCFlbBZaEBXA0NaBDdrGPMdOhW?=
 =?iso-8859-1?Q?TG60EdmnD+ChfYkcjyzoCewNSCQc?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09231D8148C836A3AECDB3E19270ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ade57a5-1169-4bca-a26a-08ddaccb1cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 11:44:11.9604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R64BhxI1GlmvYCzzHNy8eVeoVZTGAadO36Yh+xg6SYPR41yIrt5J+r+xPo48zLXnLHh8i0S48+CsA9eexJNgLMv7oCNbO85nlLow7Scl5VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR83MB0646
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09231D8148C836A3AECDB3E19270ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch is a follow-up of https://cygwin.com/pipermail/cygwin-patches/20=
24q4/013051.html and https://cygwin.com/pipermail/cygwin-patches/2025q1/013=
561.html for the changes that happened since then.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 9dff21cfdcf650256711b12d8d04fef3ca072afb Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 12:42:05 +0200=0A=
Subject: [PATCH] Cygwin: fix compatibility with GCC 15=0A=
=0A=
---=0A=
 winsup/cygwin/create_posix_thread.cc    | 2 +-=0A=
 winsup/cygwin/local_includes/fhandler.h | 6 +++---=0A=
 winsup/cygwin/local_includes/thread.h   | 6 +++---=0A=
 3 files changed, 7 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_po=
six_thread.cc=0A=
index 8e06099e4..3fcd61707 100644=0A=
--- a/winsup/cygwin/create_posix_thread.cc=0A=
+++ b/winsup/cygwin/create_posix_thread.cc=0A=
@@ -206,7 +206,7 @@ class thread_allocator=0A=
 public:=0A=
   thread_allocator () : current (THREAD_STORAGE_HIGH)=0A=
   {=0A=
-    alloc_func =3D wincap.has_extended_mem_api () ? &_alloc : &_alloc_old;=
=0A=
+    alloc_func =3D wincap.has_extended_mem_api () ? &thread_allocator::_al=
loc : &thread_allocator::_alloc_old;=0A=
   }=0A=
   PVOID alloc (SIZE_T size)=0A=
   {=0A=
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_=
includes/fhandler.h=0A=
index 03f20c8fd..3d9bc9fa5 100644=0A=
--- a/winsup/cygwin/local_includes/fhandler.h=0A=
+++ b/winsup/cygwin/local_includes/fhandler.h=0A=
@@ -1699,9 +1699,9 @@ class fhandler_disk_file: public fhandler_base=0A=
   uint64_t fs_ioc_getflags ();=0A=
   int fs_ioc_setflags (uint64_t);=0A=
 =0A=
-  falloc_allocate (int, off_t, off_t);=0A=
-  falloc_punch_hole (off_t, off_t);=0A=
-  falloc_zero_range (int, off_t, off_t);=0A=
+  int falloc_allocate (int, off_t, off_t);=0A=
+  int falloc_punch_hole (off_t, off_t);=0A=
+  int falloc_zero_range (int, off_t, off_t);=0A=
 =0A=
  public:=0A=
   fhandler_disk_file ();=0A=
diff --git a/winsup/cygwin/local_includes/thread.h b/winsup/cygwin/local_in=
cludes/thread.h=0A=
index 3955609e2..cbbbc3f1e 100644=0A=
--- a/winsup/cygwin/local_includes/thread.h=0A=
+++ b/winsup/cygwin/local_includes/thread.h=0A=
@@ -221,12 +221,12 @@ public:=0A=
   ~pthread_key ();=0A=
   static void fixup_before_fork ()=0A=
   {=0A=
-    for_each (_fixup_before_fork);=0A=
+    for_each (&pthread_key::_fixup_before_fork);=0A=
   }=0A=
 =0A=
   static void fixup_after_fork ()=0A=
   {=0A=
-    for_each (_fixup_after_fork);=0A=
+    for_each (&pthread_key::_fixup_after_fork);=0A=
   }=0A=
 =0A=
   static void run_all_destructors ()=0A=
@@ -245,7 +245,7 @@ public:=0A=
     for (int i =3D 0; i < PTHREAD_DESTRUCTOR_ITERATIONS; ++i)=0A=
       {=0A=
 	iterate_dtors_once_more =3D false;=0A=
-	for_each (run_destructor);=0A=
+	for_each (&pthread_key::run_destructor);=0A=
 	if (!iterate_dtors_once_more)=0A=
 	  break;=0A=
       }=0A=
-- =0A=
2.49.0.vfs.0.3=

--_002_DB9PR83MB09231D8148C836A3AECDB3E19270ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-fix-compatibility-with-GCC-15.patch"
Content-Description: 0001-Cygwin-fix-compatibility-with-GCC-15.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-fix-compatibility-with-GCC-15.patch"; size=2472;
	creation-date="Mon, 16 Jun 2025 11:42:03 GMT";
	modification-date="Mon, 16 Jun 2025 11:42:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5ZGZmMjFjZmRjZjY1MDI1NjcxMWIxMmQ4ZDA0ZmVmM2NhMDcyYWZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEyOjQyOjA1ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBmaXggY29tcGF0aWJpbGl0eSB3aXRoIEdDQyAx
NQoKLS0tCiB3aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQuY2MgICAgfCAyICstCiB3
aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2ZoYW5kbGVyLmggfCA2ICsrKy0tLQogd2luc3Vw
L2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy90aHJlYWQuaCAgIHwgNiArKystLS0KIDMgZmlsZXMgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1
cC9jeWd3aW4vY3JlYXRlX3Bvc2l4X3RocmVhZC5jYyBiL3dpbnN1cC9jeWd3aW4vY3JlYXRlX3Bv
c2l4X3RocmVhZC5jYwppbmRleCA4ZTA2MDk5ZTQuLjNmY2Q2MTcwNyAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vY3Jl
YXRlX3Bvc2l4X3RocmVhZC5jYwpAQCAtMjA2LDcgKzIwNiw3IEBAIGNsYXNzIHRocmVhZF9hbGxv
Y2F0b3IKIHB1YmxpYzoKICAgdGhyZWFkX2FsbG9jYXRvciAoKSA6IGN1cnJlbnQgKFRIUkVBRF9T
VE9SQUdFX0hJR0gpCiAgIHsKLSAgICBhbGxvY19mdW5jID0gd2luY2FwLmhhc19leHRlbmRlZF9t
ZW1fYXBpICgpID8gJl9hbGxvYyA6ICZfYWxsb2Nfb2xkOworICAgIGFsbG9jX2Z1bmMgPSB3aW5j
YXAuaGFzX2V4dGVuZGVkX21lbV9hcGkgKCkgPyAmdGhyZWFkX2FsbG9jYXRvcjo6X2FsbG9jIDog
JnRocmVhZF9hbGxvY2F0b3I6Ol9hbGxvY19vbGQ7CiAgIH0KICAgUFZPSUQgYWxsb2MgKFNJWkVf
VCBzaXplKQogICB7CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2Zo
YW5kbGVyLmggYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2ZoYW5kbGVyLmgKaW5kZXgg
MDNmMjBjOGZkLi4zZDliYzlmYTUgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5j
bHVkZXMvZmhhbmRsZXIuaAorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2ZoYW5k
bGVyLmgKQEAgLTE2OTksOSArMTY5OSw5IEBAIGNsYXNzIGZoYW5kbGVyX2Rpc2tfZmlsZTogcHVi
bGljIGZoYW5kbGVyX2Jhc2UKICAgdWludDY0X3QgZnNfaW9jX2dldGZsYWdzICgpOwogICBpbnQg
ZnNfaW9jX3NldGZsYWdzICh1aW50NjRfdCk7CiAKLSAgZmFsbG9jX2FsbG9jYXRlIChpbnQsIG9m
Zl90LCBvZmZfdCk7Ci0gIGZhbGxvY19wdW5jaF9ob2xlIChvZmZfdCwgb2ZmX3QpOwotICBmYWxs
b2NfemVyb19yYW5nZSAoaW50LCBvZmZfdCwgb2ZmX3QpOworICBpbnQgZmFsbG9jX2FsbG9jYXRl
IChpbnQsIG9mZl90LCBvZmZfdCk7CisgIGludCBmYWxsb2NfcHVuY2hfaG9sZSAob2ZmX3QsIG9m
Zl90KTsKKyAgaW50IGZhbGxvY196ZXJvX3JhbmdlIChpbnQsIG9mZl90LCBvZmZfdCk7CiAKICBw
dWJsaWM6CiAgIGZoYW5kbGVyX2Rpc2tfZmlsZSAoKTsKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3
aW4vbG9jYWxfaW5jbHVkZXMvdGhyZWFkLmggYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVz
L3RocmVhZC5oCmluZGV4IDM5NTU2MDllMi4uY2JiYmMzZjFlIDEwMDY0NAotLS0gYS93aW5zdXAv
Y3lnd2luL2xvY2FsX2luY2x1ZGVzL3RocmVhZC5oCisrKyBiL3dpbnN1cC9jeWd3aW4vbG9jYWxf
aW5jbHVkZXMvdGhyZWFkLmgKQEAgLTIyMSwxMiArMjIxLDEyIEBAIHB1YmxpYzoKICAgfnB0aHJl
YWRfa2V5ICgpOwogICBzdGF0aWMgdm9pZCBmaXh1cF9iZWZvcmVfZm9yayAoKQogICB7Ci0gICAg
Zm9yX2VhY2ggKF9maXh1cF9iZWZvcmVfZm9yayk7CisgICAgZm9yX2VhY2ggKCZwdGhyZWFkX2tl
eTo6X2ZpeHVwX2JlZm9yZV9mb3JrKTsKICAgfQogCiAgIHN0YXRpYyB2b2lkIGZpeHVwX2FmdGVy
X2ZvcmsgKCkKICAgewotICAgIGZvcl9lYWNoIChfZml4dXBfYWZ0ZXJfZm9yayk7CisgICAgZm9y
X2VhY2ggKCZwdGhyZWFkX2tleTo6X2ZpeHVwX2FmdGVyX2ZvcmspOwogICB9CiAKICAgc3RhdGlj
IHZvaWQgcnVuX2FsbF9kZXN0cnVjdG9ycyAoKQpAQCAtMjQ1LDcgKzI0NSw3IEBAIHB1YmxpYzoK
ICAgICBmb3IgKGludCBpID0gMDsgaSA8IFBUSFJFQURfREVTVFJVQ1RPUl9JVEVSQVRJT05TOyAr
K2kpCiAgICAgICB7CiAJaXRlcmF0ZV9kdG9yc19vbmNlX21vcmUgPSBmYWxzZTsKLQlmb3JfZWFj
aCAocnVuX2Rlc3RydWN0b3IpOworCWZvcl9lYWNoICgmcHRocmVhZF9rZXk6OnJ1bl9kZXN0cnVj
dG9yKTsKIAlpZiAoIWl0ZXJhdGVfZHRvcnNfb25jZV9tb3JlKQogCSAgYnJlYWs7CiAgICAgICB9
Ci0tIAoyLjQ5LjAudmZzLjAuMwoK

--_002_DB9PR83MB09231D8148C836A3AECDB3E19270ADB9PR83MB0923EURP_--
