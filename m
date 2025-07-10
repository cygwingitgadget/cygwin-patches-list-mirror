Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071d.outbound.protection.outlook.com [IPv6:2a01:111:f403:260e::71d])
	by sourceware.org (Postfix) with ESMTPS id 8C49D3858C62
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 07:29:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C49D3858C62
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C49D3858C62
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260e::71d
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752132597; cv=pass;
	b=jWE50xm27G/6QWPmS1h7/Wj9x6/VtAWeEqJHFBPDYJKkAz9iNvMSMYY3/sx+pUY5j69GPjD+kIidq3aiY8skKc0jKdgDcKwFVVLFXfJP8Rpq1p6+gBTs+L3nsHj+xBhhPs4Npgg+S28/tmYeF/D0ESCWR98bIQR8WasjGK/Tz2E=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752132597; c=relaxed/simple;
	bh=CkMOC1i6l5/DxQXXDz5CyBvwu7pyYWwFOflA1esN1ZA=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Jv2d9JrwdRd/4erMPnyYojt/bNnMUZcgZ6duslWwIBXQ5EMB4rGj50wHrgs2ZaUu6BIf0kDNgixRnpRo3AoLblfBePovJttGg+x3JGGNZ7KUHs0I9ddi8n8g8SDsyxEn1Ab6Fv6aHlYyeWsJgYgutNd367/AtfnKdjBK3iwiOgw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C49D3858C62
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=cM+UerJI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/AATkEHe/Uz1kT3JL9JzP9hiX/o+TPNaEZAwAUXKxX5FTERMqZ/964hj4lEKlp8UOEyN2Ap/+D/nXuTIErRzj31Fj8OGOzpkTb4NXZVn95m3VWN0D8NyhZ0e7IZ/i2sToAHvC9QD3NoNsDgWmHvFrT0MzJNA2NPKfQRB6qXefheh8Cy+oLbHBjkvsPwByCIvPt0PH1G6DOEZzSha+SR186iww99x0uLfXip4iRWeZ4+Kn8T0L4Tg0wmCsEPdJ7e77OqKz4xuL/aJsc2xEMZpURGMc4oNc+H6Y73tfPZy7nWEHBZhnOBdSgdvktnSs/3WiAwBDZJFpPzYCTBocyOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkMOC1i6l5/DxQXXDz5CyBvwu7pyYWwFOflA1esN1ZA=;
 b=eLbd/raR8mlB52H16GgpLauF1x+PUO3EK3V2nB7TcGOGX9+kifYCKqUZMBkJp5fvVnKQtTQx3tcDkBYQ4f2vzNa+b9nCqK7Sh+ug0HSuOJ/9qnB1lvepyaE9xBD3jLvJSyUdce0XGQqiwPQ5q54V+D+a9Vd1kjFwjt5kcDjMWWto9HgHJIdpe8z95Jq0WncqSZJXMkTFVSrYQlqUKR6WVTQD78ufAPY1OWqeGn1acxk1VTntT56eI2fWLGd1sTXcIKbAQXt8A/1tTLwYfLdZ8dvvA4/GaFu7cgZXGviIDd7Dqi7H9OvbhUFZcpdo5EvBaXuHBXOi1WvbGvA5scFwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkMOC1i6l5/DxQXXDz5CyBvwu7pyYWwFOflA1esN1ZA=;
 b=cM+UerJIJsHjrg2N0rT0wovrRVQKDWOjx2v1/vaADoOpvMSWHWlFXCs4d71PKkyxZOTCzSYgwaqTKZIRxhq0n7CPWD1/1AIdLuuIYX97fRMYRleAFuKD1brW16x4Zd8xDq9gMpnBluML3l9oRMTei1OMqIXRSIh1Z7aY2RuKjKI=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA6PR83MB0579.EURPRD83.prod.outlook.com (2603:10a6:102:3d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.4; Thu, 10 Jul
 2025 07:29:55 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 07:29:55 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Jeremy Drake
	<cygwin@jdrake.com>
Subject: Re: [EXTERNAL] [PATCH] Cygwin: testsuite: link cygload with
 --disable-high-entropy-va
Thread-Topic: [EXTERNAL] [PATCH] Cygwin: testsuite: link cygload with
 --disable-high-entropy-va
Thread-Index: AQHb8QH2daoqfINnT0SnhuSnCSE0K7Qq9iPJ
Date: Thu, 10 Jul 2025 07:29:54 +0000
Message-ID:
 <DB9PR83MB0923C10CF1CE91D0AE67EA7A9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References: <e997b36d-d166-8bee-4eff-fea7ebbdd7fb@jdrake.com>
In-Reply-To: <e997b36d-d166-8bee-4eff-fea7ebbdd7fb@jdrake.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T07:29:52.868Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA6PR83MB0579:EE_
x-ms-office365-filtering-correlation-id: bc051f0c-c174-4cc5-e32e-08ddbf8390ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KocqxdvN5LDrKLFU15fZL4POlNkoMTlM6rYtxLkUhmV9KYNWc5U+Z941hM?=
 =?iso-8859-1?Q?pjQTw1YjFsjuvAaJ1VPTLhhIUAU3Q7WtyEy21cBvBT1R9TKvuyhPTJ2rkH?=
 =?iso-8859-1?Q?L3fOtbgSFEqEMOCsh6Dibe9xjYBlfRRjFmw595i9WTUTp2N0hCzfic/xqJ?=
 =?iso-8859-1?Q?UdiNE+wQNWM9k+69pQt4yK7AeH/pRbccEshGDSJUytVpJnqKsUL9ok7Md0?=
 =?iso-8859-1?Q?IUIB16wHnAfVVKv0YHdzMe1Y8jWQ0fKtzcm89v9YwaRfM7VDFa/5eHmvcg?=
 =?iso-8859-1?Q?hRseZEanOzj8aWQ8klvmjKirh8W3+l5imw3Q9n5JlMwEEOw3DZ3P9gMjU3?=
 =?iso-8859-1?Q?1/ETAjjW+ZT98W0BoxEusnDhLaaLHzb15TUVBCrAR9vJfVYxOcudicO8x2?=
 =?iso-8859-1?Q?x3F+RnN0FLYJnrVKA/Rthwxse/hhxkabNv5JX/EV8r3XmkudlnT0z9pGf0?=
 =?iso-8859-1?Q?xJXOKm6qKVl9OAGYLc/o4p3T9AaVDh1lckcyjCnUQQqkpZZTZNUfm9RSrB?=
 =?iso-8859-1?Q?4km0oFsdtBUIXuTzGSJUUumXhFsvamBG6rhPh2A/hR6sxzIOOC1Me50YVi?=
 =?iso-8859-1?Q?nnVWy4zxzE4xZ8aqMds9XWqk8IoF+h7FuBXdbCK4CtqxQ8tHrnT8xH+Ggs?=
 =?iso-8859-1?Q?pLIpI65SkVPcpyu0MEfLRXMwxaPyeGAP0K9HYQKXlRCLTBF5u8kfF/UMEu?=
 =?iso-8859-1?Q?VI4rwDlFS4CveBx1x6c4L+ZkyxiSF7aqx98EOsDv/AVTN5Cv3F31mH3w2h?=
 =?iso-8859-1?Q?zrnu5cZi9OibB5dWtLwaV5cKJswQCRzOIAz/FYdcseJsqjzENikArJNXLB?=
 =?iso-8859-1?Q?6QmXVcXVptHJaWn0mJwmtoQEPLhJWWmM+5h3cmVgb+a1HegVaGNkMRu0hP?=
 =?iso-8859-1?Q?lXx7pLwexWVx1fuLU0e0CMgiv3gN0+rERd3FQEx3t/y13q/BHfBW3tmD4Y?=
 =?iso-8859-1?Q?5+3+v9GynEtW3cY2XDu1HtQlW9JtFyFodb4KNR6CufldSVJyCJ4LJvOh33?=
 =?iso-8859-1?Q?kdM1JzpHUqHNxVUXgC0jJ+TYeyvMtbSD1YrwdhymBRO/PNWWa9hOVTsyZb?=
 =?iso-8859-1?Q?95IRBCRWmE2frqq+d7efZKw9KyJEqZe8Qj/PFBWkWES3Gph+zDd1vKYJ9g?=
 =?iso-8859-1?Q?vfNLFyBOXtSLiMkxYK4KFUy5PDkBH0WJhTsgScmlyv6ZKl0M/75VDnHsbz?=
 =?iso-8859-1?Q?Ej0LHILt5E+zzdurZMIvw4g2mDoIQHfVMlJpXtdmj5FmzsRb+DTUvp8v/g?=
 =?iso-8859-1?Q?TzY+C4CVhlTVDAoUyC7K9E0ZOMpjq72M+Hso82qRW8UFMynXebZeETSRsc?=
 =?iso-8859-1?Q?6mdTKVMOeU1Z83z6zGnHbHAXYrRXR3gts90GWxVa31HiTSfKA2IFAKcT2Y?=
 =?iso-8859-1?Q?S3pDklT4k3GA/va6mJ9P1MyVPGwsIwa4+J84DwRywxMRZG4PzpdQis+CxO?=
 =?iso-8859-1?Q?YtErK3rgauC3TicX5sOMJN5I8xHp16Jwfj043GtifexwGhH6UQNBo9uYzq?=
 =?iso-8859-1?Q?N7KcIz6djubn4cjCAb1nsH9qOuDbb1KeCJx1mwoUbZ2Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MFyXp6zyOJXU2ZX05L5yXt5pvqHJMp3XhfUJPRaCcICDTj7+EYhMmpMd5U?=
 =?iso-8859-1?Q?VnfMINZCtND6MxcbYN4HnSPmG47s2yKmy4NEQI9BtxARBlYmpw3MG/dmIx?=
 =?iso-8859-1?Q?6cvA9TOjkXEfpHPZlPZRXFgA2WE5AD2rJYHoFoLVDMNFpQ8PlRUC1Zn6pH?=
 =?iso-8859-1?Q?f/fKS9bFYNGzqWfB2uBX/p4ayO2XwCXJ30xe48IdgbSAUr0Po6/J0jiy9H?=
 =?iso-8859-1?Q?rIQDnfGKoDfCD7gj15ipml/APmNTx5gdqNrsTOg7ib56BlKMxP9dOuDbA4?=
 =?iso-8859-1?Q?t9zzx8kM/wlckmauCsEf+Wr8TaVWSIGUVKJ68qsC2IGD23La07mz2Dg38S?=
 =?iso-8859-1?Q?UqU6hovSKCVLtxBi14JhpcuvTVYwWhnuzl2pMYtri0vQt6gYH+8vVnhN28?=
 =?iso-8859-1?Q?Uf4OFtTnfPev23t6bj2H/NCTdgroqyo98cDRg7n753VyyEIh+senoy/aYO?=
 =?iso-8859-1?Q?KXDgHZPOf8k1NhQe2pair+CDJkqTG3U7n2FXx0w3qpH92SnyEIVOctVTkU?=
 =?iso-8859-1?Q?ytD5AE6NJ76MDH5677vbG9Eq7zusPg3HSTNgis4p5GbT02GZ36i6LLFK43?=
 =?iso-8859-1?Q?X5FPeyyGMbgGGzUF3tQTQZwIM5ZsFc65Z8Fet+InT6sQJojLmBnTFkERlh?=
 =?iso-8859-1?Q?dzxhCNYVCkRBDzygTuc1yimlCsKc7Wt5MdPrmCpZOsEfP59iqneCNGfC9y?=
 =?iso-8859-1?Q?cznI1pvncEPdzroTPqWSg/vlPFFdr9AIeyU9lodTHFJrw7nG9vXp3anxjv?=
 =?iso-8859-1?Q?bhrtzKWwjfbIvh91JGgaL9lMlolwmJrmHa3SQK5K99bOVAvC/k24rHyXkM?=
 =?iso-8859-1?Q?9bOvv1rcTtY3S3Emwl6t+qs9/AVzFtEZXJ53bd7hGzomue0LB3v4WcqX5J?=
 =?iso-8859-1?Q?nax1rdOFdHtSNcIR3GmqfxCJywofIcTI2QRs9xYPcWAuhUObGLWjulJscl?=
 =?iso-8859-1?Q?5bEPLXi6fZQE9pNawj9kJFqa95OIux8GppwbcRQGbhSREm6ZrgFFTTpEfO?=
 =?iso-8859-1?Q?08I0W9mPrEecCB+2HM3t4dweWZIEbbWp8uoy2Q1QyCJakvp+3lIhunZkQx?=
 =?iso-8859-1?Q?LFodrx0aZLXtvNUr9KrC5SC2OsP2ie8JasgG8A1skZE+zCr8eOrzzihkZL?=
 =?iso-8859-1?Q?lQhpRAk90tzHVc7nIOS/QH8bx30t5ujF9nL/b9M2XY6iIZOkO2zFYtbpa5?=
 =?iso-8859-1?Q?37vom0XPlpomTlPXdYHukAFvAZ3QZ9aeI4unahgROR8voXzon6Og1lm6yz?=
 =?iso-8859-1?Q?g3JMEGbp6f6HzUIlXq5EyJ9QhFIOdB4OKBj5EqutTPwoWDvQyOxhc3l31W?=
 =?iso-8859-1?Q?YXWoAk3UPOFLJduU77/rxPha3IWDTWsJQ/DedexjE/XYmhK/Dy46+u0+xM?=
 =?iso-8859-1?Q?skx0CwfgJULRgj7LJHySdPVfl741tMLYhdT5eIKjqhQinqhaIa9uLRAz+d?=
 =?iso-8859-1?Q?tol/oyiR5sM9zYRuNa9GsU84btGJo/WpZScWQ7Wz7h2Lsq1wJOX85Qkfxw?=
 =?iso-8859-1?Q?N61M1za+iNlpG8BxTbaoPsjIbr35SuSHaIcYADmsqlVxo6iVNDq7CGuAQw?=
 =?iso-8859-1?Q?J03zSvIoBujg4IG+wbFFYb4Z7DGe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc051f0c-c174-4cc5-e32e-08ddbf8390ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 07:29:54.8912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZfGlrM6kkOHi1vO4SbDldo+QEpEYamSuIkjSttoP3jJr+lH+yZ1nEnp52XOP8kT2pFtIvvDauk1Tk9QQ3xx+BHWE6PJayJ0HVXhomy4lJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR83MB0579
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,BODY_8BITS,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
Does this disable ASLR completely, or `-Wl,--disable-dynamicbase` is needed=
 as well? If it would just disable High-entropy VA but not ASLR, wouldn't i=
t make the situation worse because there would be higher change for address=
 space collision?=0A=
=0A=
Radek=0A=
=0A=
________________________________________=0A=
From:=A0Cygwin-patches <cygwin-patches-bounces~radek.barton=3Dmicrosoft.com=
@cygwin.com> on behalf of Jeremy Drake via Cygwin-patches <cygwin-patches@c=
ygwin.com>=0A=
Sent:=A0Wednesday, July 9, 2025 8:47 PM=0A=
To:=A0cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>=0A=
Subject:=A0[EXTERNAL] [PATCH] Cygwin: testsuite: link cygload with --disabl=
e-high-entropy-va=0A=
=A0=0A=
This is a mingw program meant to demonstrate loading the Cygwin dll in a=0A=
non-Cygwin process, but the Cygwin dll still initializes the cygheap on=0A=
load in that case.=A0 Without --disable-high-entropy-va, Windows may=0A=
occasionally locate the PEB, TEB, and/or stacks in the address space=0A=
that Cygwin tries to reserve for the cygheap, resulting in a failure.=0A=
=0A=
Fixes: 60675f1a7eb2 ("Cygwin: decouple shared mem regions from Cygwin DLL")=
=0A=
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>=0A=
---=0A=
=A0winsup/testsuite/mingw/Makefile.am | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/testsuite/mingw/Makefile.am b/winsup/testsuite/mingw/Ma=
kefile.am=0A=
index 25300a15d9..775d617aef 100644=0A=
--- a/winsup/testsuite/mingw/Makefile.am=0A=
+++ b/winsup/testsuite/mingw/Makefile.am=0A=
@@ -23,7 +23,7 @@ cygrun_SOURCES =3D \=0A=
=0A=
=A0cygload_SOURCES =3D \=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 ../winsup.api/cygload.cc=0A=
-cygload_LDFLAGS=3D-static -Wl,-e,cygloadCRTStartup=0A=
+cygload_LDFLAGS=3D-static -Wl,-e,cygloadCRTStartup -Wl,--disable-high-entr=
opy-va=0A=
=0A=
=A0winchild_SOURCES =3D \=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 ../winsup.api/posix_spawn/winchild.c=0A=
--=0A=
2.50.1.windows.1=0A=
