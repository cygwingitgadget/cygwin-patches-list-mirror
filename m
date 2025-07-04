Return-Path: <SRS0=s6lY=ZR=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2072a.outbound.protection.outlook.com [IPv6:2a01:111:f403:260c::72a])
	by sourceware.org (Postfix) with ESMTPS id 4D6D13851A8E
	for <cygwin-patches@cygwin.com>; Fri,  4 Jul 2025 07:20:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4D6D13851A8E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4D6D13851A8E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260c::72a
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751613602; cv=pass;
	b=ptVmQQWoB1ZN+3h+iTDdUBpYKNoyMFtUomWttYQRNZhPImiQ8eU12iH+OO8ei7bnkJ9Cd4jhJfR42AtbLpfggkJ055g+2DaQtXCK3OYnkr8f6FOuk/t90J1SuL9q/aW1H/jGtlq2KVslIGANgNGhXbxn0QgjgAFyd1WUNpiPuAE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751613602; c=relaxed/simple;
	bh=QIhYm6kG+9J5uq8TJ/ZD9hxArTiI6/Qj5wRZsOD12r4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ov7cHKTVUKaoNNBxzLozsEwo7mclYb7bkg7iAWoVNdOcVSB0Inj1N6lDrxNkjDD1qE8xi0nogVvYXw1iLo0VpQa+p5DqaNEbfXVBObghu+bGVWh1D/vTCxSP1qc6wkXbTTVKZ/kqELlsEhNSjN4cc+yKxNYh8SUmGEQ82edpTTk=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4D6D13851A8E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=Bf+Mx8jV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx/kVZxCHwa4cFKSFYN72ZQAgaMaPIJ+0Fka0vqbzPiDHz2mPUnxpyHPM271Z7Y6XZL3uIV5Hf1FOmbu1H9NRoVggiJhV6qEx3K8exHF+8B2wIe4YLwtRLiLx6StPzWOOtqt+lqCRZwUzQPqZN0odc2zfKP3+6H4D4c+NUH1HQ6ZVSrxqvVtZdJipfSuGMha5D9qLLtu+ri5NdyX1Rt4kowzssW+Swom264nOwfersYTi4PojXESCMmw2lmflvZ/tJpfANoM9W2XZOBtlS++uBud3FJMSr/lKiG8ri/I64aggUlksLsF7r3R9Mh8GleXBuLZqy3Cf2sma1eY0zS+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGnkYPjjKl91VS5yC6pq5FHT0D1qYpVEy1TsRUSOfYs=;
 b=Tq/d70EgUP40GNlw+JhnBZsy0gd3Rq/4tP4XDYpWXThT9mHQR6jsw+VlD5sUCIRGmoUbVkwS7S1TiLIl0neRnEuirGPZyLHKaWN+Wvt1q4DmUjd5XdRoyMVQYp2ao3vlFxj0os5seSDq2v2/Cc9KsYIBr3GhapdBNadG0zE8n2UunndI6NaEBuvJDMDHd+4219CEmCo1qXcby6FuGdvB1EXeowpl7oKkqstkicQhMOFhO6x/O+IT3YEpLTaIAfHq/cUKXOlFyVXQV3uTSq0d4+b35XFVmkl4MC094pYnRMZfOgnv6ppI2DFBZuT8+li8ABnesbAhQZ1clXmPTjenFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGnkYPjjKl91VS5yC6pq5FHT0D1qYpVEy1TsRUSOfYs=;
 b=Bf+Mx8jV6Ue3XRpqrgvqn4mE9TSTuSI52t+r4YC3xBEM0BIdvQar6kJ2xVM9/38k8bTdYiKJ5w23/hDI0be04dpbpiSLIIoXAurnpIcKDuEHzVm2N/Wtr1Ec5OcZ/6ur6eZFoeVJ7nC8t8lJeGJLwifSWQG/Vk6Kqf9RUoI5xM4=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA1PR83MB0799.EURPRD83.prod.outlook.com (2603:10a6:102:492::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 07:19:58 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Fri, 4 Jul 2025
 07:19:58 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: profiler: port to AArch64
Thread-Topic: [PATCH] Cygwin: profiler: port to AArch64
Thread-Index: AQHb7LPbVw2/KYOptkeHhNpWuK+6mw==
Date: Fri, 4 Jul 2025 07:19:58 +0000
Message-ID:
 <DB9PR83MB09231ED3693E994CA770C8609242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-04T07:19:57.670Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA1PR83MB0799:EE_
x-ms-office365-filtering-correlation-id: 42bc0589-79a0-4af7-2ec0-08ddbacb2eca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|8096899003|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?3GI1wRzxI1jEwy850A7l5N/+nxiYZZOLK3vpGxiHNfYG0u8HXwOe8/8iP5?=
 =?iso-8859-2?Q?zNtjqi9qdDpUhUdgiwk+8DhjYDQkUzei5/MU92EChSuD4os8q7r/Es3sXd?=
 =?iso-8859-2?Q?CKjJSzTDncUOuIFzoIVWSSMTsInJAeUAa9O5WJb7bNI4WYz4udYy9hHxff?=
 =?iso-8859-2?Q?fZ8MXqzsBmPwqI1UmwBA+eL/FDsjA/+b32d9YtEez9QeQdS0qH+YhnFGsd?=
 =?iso-8859-2?Q?AXyrL2bHp8cvXeR2tWIzzMUBKzQd7TLBrrMhLwoHhVA7C7W2jEDGHIeg9x?=
 =?iso-8859-2?Q?f1wemxt67Unz3tze+BFnduZhl0CyDqhcOHzJXWYunV7MSo7ka5+QjyfBCJ?=
 =?iso-8859-2?Q?h5MOnpv8X9Bj6bWWSt4WSKNn1exsovev3EwbH6g8IxWM8XynIOo736FpK9?=
 =?iso-8859-2?Q?nAZzZnoScKJ3ijQvnXKx28Bjup/0JmECXSfh1dYiEVmgrydSrGUljdZKa2?=
 =?iso-8859-2?Q?ecqMTT0eScsPChJTmlCJZVbi4zxcmr6WPIBioPAyFID6qK7C0Cnub1zhGe?=
 =?iso-8859-2?Q?8dZtVtLCMPocxF/gNQkZBbRzj/sB/7/JX6DnbudXbBehxTUJjXIpR10+Rj?=
 =?iso-8859-2?Q?8VK6ab9Jw8m03jLR/J/xqzbghl0i3bQOa+uui4t+q7YwvOZwpXfQi8g4/3?=
 =?iso-8859-2?Q?W1Mc//Z+jpH5AKHUOWjVVdkoODJAu8Mv0a+4T+leKm3njoU0e8J43dYCAI?=
 =?iso-8859-2?Q?WkDPiIt+Ye5GyFx2Zrx9Cbep1P6bS4dQyJ9M9FqsEjGX6KVmLRIn9elzO4?=
 =?iso-8859-2?Q?asL4lMViwXCWhUW1jPK2kvG7Y+wLfJr3EbXFHqymuMtTkDqx9gM0zbk7hJ?=
 =?iso-8859-2?Q?eRrFmk+itkT8G/xIUGU1Zq+H6H7GZob7Jd9JTGLXb2oMap0okxiotJl4Cv?=
 =?iso-8859-2?Q?ImAQj18i4phFYAD99iDo5zmFBfrrwYPc9gkUyuvfpPoTT+wsIR10eKmUUT?=
 =?iso-8859-2?Q?bSZjoCoB3OY1OfWYVSW/kHJYV4rDbGt8KQyJFB9k/Uu8jsb1iC0K7YE+f0?=
 =?iso-8859-2?Q?nFiWWhQwhnmrVjqHmRbGNkUey83pk8GMsBFngfaz+fvMwdzK6Je7K79DHO?=
 =?iso-8859-2?Q?xzkes9xOXSxt71Yrvqb9kpN5/KrpxA73DuNWCKDo3xOO1hpEMcZ0oUXLjr?=
 =?iso-8859-2?Q?7MEIvps/xuAGjNCz7D3NPceC+QCGVDljAnQWnl4JjiaPkpLASKOSlDfBmk?=
 =?iso-8859-2?Q?Exrz57NbZljMNBDLhvGcWLn2SDDNQQkdfR9Z35kM2hzPtAHwL3EWxfw7Ya?=
 =?iso-8859-2?Q?lOd7soZJWsX2h7Z7vmqsmLDJ4b0tSLmir7wULo5oKPwOx3SUOe2Targl01?=
 =?iso-8859-2?Q?cf43jddTzmrIG3NouqkOBenNy1CeiReKbqG78iI+cvdehbqRNNNIZ7T90H?=
 =?iso-8859-2?Q?ztUlYb1ZBqlvFam+CxiHV70cDb6pspwIQuuB6ewmDZVx94pwWLYJS3TOPz?=
 =?iso-8859-2?Q?lpLu8i5qpg189KI0O4iiEwXsnLUGrgcONDfVkbzFYw2wjV2pT0OKJG5ODH?=
 =?iso-8859-2?Q?1D2c27Yidz5iPsHGoSKjesDGUbYuVUPEL6JkmjUhXBVBcr1ghqsaPOncue?=
 =?iso-8859-2?Q?ZVyf/qE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Bj+olls5xdrjc+KOC79/Pif2T+wVKv1hVQ0Sn1hgdebbBrCOJy1UlsHiYM?=
 =?iso-8859-2?Q?uwiQSxn1Q6p1d63ztT9ghI9PZ+c93wUekTHZtaWR7uQMa+fOWvsJJte3Ha?=
 =?iso-8859-2?Q?OBEzHvQXgZgwjXPBLFIMye/dBwf0o0iDaw/02Q3fMt1MKeMWmjXg44BJZA?=
 =?iso-8859-2?Q?yDokZD56m5OAZq9jOHUhedpsSVPE+EN6e0fRGoc6hfUtHFbzdx7+i2R/XQ?=
 =?iso-8859-2?Q?vCodfkr+9cbQY6oStikQH6VSKP+Fe9mtehZ9HhuclhK7sI9XBy1aK0dUZX?=
 =?iso-8859-2?Q?QhFI9aj1hV50/tvWAAwTxkIGFmVDuXUutCsXiZdGZLF2pwLSgmxmo8sG7a?=
 =?iso-8859-2?Q?FeBI6kBb4EmYhKg5RtCizWpSj0pOVQTRaU/kqskxUdOYXlBvvwy7W8vCuo?=
 =?iso-8859-2?Q?96ywO6jlMqj3rMn4XyFtHWZQtnxAdpgtrQvPTKlJJtnMsMyA3FDFVsji1b?=
 =?iso-8859-2?Q?jScI/bTr3/2+t1k6WeQZDPKkIwHjD++VfFpDoMaeeERrS9IelliM6krjmW?=
 =?iso-8859-2?Q?2HCi2/IN+pa9pgVIAI6/SpxOe5uMo4A6ziJH7cKfPy2tmHJC10GKGH1Eov?=
 =?iso-8859-2?Q?EZjcGfXJNOvPz9Sxv4+/CbrRmeEMpid3VARvFonp4OWocFiYiT/ahAoNVv?=
 =?iso-8859-2?Q?aqsLEvMVI1sypOe6AwHluneWSwhetGT/UXb4D974OvBFlsFRJeG4ASLwx3?=
 =?iso-8859-2?Q?BTOxXtitsfsHDwRqw28X1cLOeKY5zsrYJxLSVtqZRmSvMGYvr3fEmtQgCi?=
 =?iso-8859-2?Q?NfwGjXkbB8H9ok+/I9gdPsH+fLkijyGPdFFspm2fOKolYod4YNUHfTDex9?=
 =?iso-8859-2?Q?R0hezHKXKT+SDW/OQBMDw4qpX/YjNbeDPK8KRIeqbXUfUuXBHF8RAm6tyu?=
 =?iso-8859-2?Q?nEXgKJM5LLmhPstOIp2kPYpEOFJYGSdO2Y2YRKlVc79qKS1RQC/g5pRBXl?=
 =?iso-8859-2?Q?864mbhv8ib46lIOpUSxvu8GtJdM8UwKX4RaWm7Gs2ixcWU9nZ23ksVuuJN?=
 =?iso-8859-2?Q?HCIm5M1ZoojcGt6rUAH1MBJ7V8GD/pPCBUAt1ROX/7zzYHGTOb4TOL+ddf?=
 =?iso-8859-2?Q?v1ycymap/YU9lHSIR8MKbCKpD7ROIQlZwSEYmV4SVk5RYJlGJhb2odZVcY?=
 =?iso-8859-2?Q?sTGRq5FSq6t8jSxFIRahAXEpjCFyw6rdkTvBYWydZ4YPHGk8MaNLeiB1wL?=
 =?iso-8859-2?Q?SDzKfgGBB47xAhEhjsRXRRD2IHy45qIw/GQpyt8SdD7P/WsF/wUdJzyBY4?=
 =?iso-8859-2?Q?2KbysNZxD1gO8VrsU1DUQaoye4XmIknU02tBOQ9gXdxjPopuyi0HbH2qcz?=
 =?iso-8859-2?Q?JZCM7SGx6xC7P87rRfHdXYSGd99K1Nnx7cxPi+mG6+K6XTpz5XTu84zk0O?=
 =?iso-8859-2?Q?H2kXf5EK9Do5d86hAW7S4A5+BnmwyIU1GHPiFg40zjhTikoaPnjF1cVN/3?=
 =?iso-8859-2?Q?BV4MHO+3zXMSzQu5YTVw4w8fBvXq4qdsYPbtOwoEeKzVh0dd+1RSTPmbp1?=
 =?iso-8859-2?Q?aW0naskDlbgE08W90NqsuVB9FxuGVWDOOJa71Hg7KGbIY6HFaAXtknX7M3?=
 =?iso-8859-2?Q?HosMXrSGFAcHdIMYjwl7Yhkejqiw?=
Content-Type: multipart/mixed;
	boundary="_004_DB9PR83MB09231ED3693E994CA770C8609242ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bc0589-79a0-4af7-2ec0-08ddbacb2eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 07:19:58.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CENx+cMVL+2zgyPqj6TWKSuIGu8aMG4sbDfqE48Jf04uZO5JXsDA/tf27w7ynx1Zxe+pKC6W4amHlunjoRSDEhvQ2oMA+5lyytpGDnpUI0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0799
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_MIME_MALF autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_DB9PR83MB09231ED3693E994CA770C8609242ADB9PR83MB0923EURP_
Content-Type: multipart/alternative;
	boundary="_000_DB9PR83MB09231ED3693E994CA770C8609242ADB9PR83MB0923EURP_"

--_000_DB9PR83MB09231ED3693E994CA770C8609242ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.

This patch allows to build `winsup/utils/profiler.cc b/winsup/utils/profile=
r.cc`for AArch64.

Radek

---
=46rom 15fc1370c28c2d0214021f940fc1a62a6309576a Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com>
Date: Tue, 10 Jun 2025 17:11:20 +0200
Subject: [PATCH] Cygwin: profiler: port to AArch64
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>
---
 winsup/utils/profiler.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/utils/profiler.cc b/winsup/utils/profiler.cc
index b5ce16cf2..4fe900b7f 100644
--- a/winsup/utils/profiler.cc
+++ b/winsup/utils/profiler.cc
@@ -503,8 +503,10 @@ find_text_section (LPVOID base, HANDLE h)

   read_child ((void *) &machine, sizeof (machine),
               &inth->FileHeader.Machine, h);
-#ifdef __x86_64__
+#if defined(__x86_64__)
   if (machine !=3D IMAGE_FILE_MACHINE_AMD64)
+#elif defined(__aarch64__)
+  if (machine !=3D IMAGE_FILE_MACHINE_ARM64)
 #else
 #error unimplemented for this target
 #endif
--
2.49.0.vfs.0.4


--_000_DB9PR83MB09231ED3693E994CA770C8609242ADB9PR83MB0923EURP_--

--_004_DB9PR83MB09231ED3693E994CA770C8609242ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-profiler-port-to-AArch64.patch"
Content-Description: 0001-Cygwin-profiler-port-to-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-profiler-port-to-AArch64.patch"; size=1021;
	creation-date="Fri, 04 Jul 2025 07:18:58 GMT";
	modification-date="Fri, 04 Jul 2025 07:19:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNWZjMTM3MGMyOGMyZDAyMTQwMjFmOTQwZmMxYTYyYTYzMDk1NzZh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFk
ZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNv
bT4KRGF0ZTogVHVlLCAxMCBKdW4gMjAyNSAxNzoxMToyMCArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIEN5Z3dpbjogcHJvZmlsZXI6IHBvcnQgdG8gQUFyY2g2
NApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47
IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJp
dAoKU2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9u
QG1pY3Jvc29mdC5jb20+Ci0tLQogd2luc3VwL3V0aWxzL3Byb2ZpbGVyLmNj
IHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL3V0aWxzL3Byb2Zp
bGVyLmNjIGIvd2luc3VwL3V0aWxzL3Byb2ZpbGVyLmNjCmluZGV4IGI1Y2Ux
NmNmMi4uNGZlOTAwYjdmIDEwMDY0NAotLS0gYS93aW5zdXAvdXRpbHMvcHJv
ZmlsZXIuY2MKKysrIGIvd2luc3VwL3V0aWxzL3Byb2ZpbGVyLmNjCkBAIC01
MDMsOCArNTAzLDEwIEBAIGZpbmRfdGV4dF9zZWN0aW9uIChMUFZPSUQgYmFz
ZSwgSEFORExFIGgpCiAKICAgcmVhZF9jaGlsZCAoKHZvaWQgKikgJm1hY2hp
bmUsIHNpemVvZiAobWFjaGluZSksCiAgICAgICAgICAgICAgICZpbnRoLT5G
aWxlSGVhZGVyLk1hY2hpbmUsIGgpOwotI2lmZGVmIF9feDg2XzY0X18KKyNp
ZiBkZWZpbmVkKF9feDg2XzY0X18pCiAgIGlmIChtYWNoaW5lICE9IElNQUdF
X0ZJTEVfTUFDSElORV9BTUQ2NCkKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0
X18pCisgIGlmIChtYWNoaW5lICE9IElNQUdFX0ZJTEVfTUFDSElORV9BUk02
NCkKICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJn
ZXQKICNlbmRpZgotLSAKMi40OS4wLnZmcy4wLjQKCg==

--_004_DB9PR83MB09231ED3693E994CA770C8609242ADB9PR83MB0923EURP_--
