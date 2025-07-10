Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20720.outbound.protection.outlook.com [IPv6:2a01:111:f403:260d::720])
	by sourceware.org (Postfix) with ESMTPS id 3A34B3858CD9
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 09:24:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3A34B3858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3A34B3858CD9
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260d::720
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752139455; cv=pass;
	b=rqx1GOVTlkhcqNHitAqMMJf17SZz5iSo0FhNFLazbZqr/fCwODwNfobgBLFcvSKTpr8YgjGNQixx6XioZ22HbRm+eGH60e+mVUAqmkDeYh74hnhsaYUMqE3tVTbsctRVjRfzo3NpQRn+c5BIJpkEqpOBpKuxZFCTNss+EKc/+uU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752139455; c=relaxed/simple;
	bh=MSD+btJotb6VQE4G76qXJxcHXkFkv596IaeSDubmSjE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ZLn4pI5YcIsxnVHu1Mbita7IU2wY+/H3JO9Ydgx5ku5Wbl+H1zsqOoZj9IQ9a4tMhpYOX8CJs2Rq9+1OMiA9/q69Ogyn2j6Gif0DedHermZPODn529Le57opoFo26Tv0w5ZgV1kGPzEVV+79XKEDFL9A44u2Pz4T8J+qQc1M/ng=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3A34B3858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=P/id7KKy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvEfENdSVNuYcDwXa62dvG8T2S3KCDMBQMy6EwqgUWS+XEpSQ5mV05UM3z4bXjERwykJ7VT80M8lPn8sbuVNd2NaGcxNun/NNJNzuuRMUQzN34H98U0xEPK7WZfIvbAUIwdWhGAbZjC1HloB6yKIhaO8hvuw6s5yKRf93WJLrUK7i5Gwnq/ZtjImX2a89j8DvUQRQsyrRTq8l/BxvaWMX+ySm0VenQT4nJhs6johRuKeoPxpAGhTPB+m+X/ElX7TJWLpuXhurdwYr49csPhQopAQAiwjR6EWDlSd5D69QwzT3+xkjb2sapHDBVojHZaSXY7LUV6doWv1Tqz8CTLtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caaw9IrE9qsT6WM3eOpTgSIRV6p3soXnHOANr33Keyo=;
 b=PnhFFXqMghbtAfHS6SelEUohwq/3NbbLAsLZcmhi6eNk5E+/L+C6U4xYQUo8Xq55Y3MseBJxzpFpsVZiAAQ/4CG++RZKgt9KGRmT/q11FctU/LIQbyb/SkN2gXgLj8TBn6kwtRt82YPyBqNp2ZAwZ488dEHkdERwe+dJQlNDJMC3CF1z3vqXxS3ymcuZhjB3zd6BcO3Y12I5LbakTpDWsfHikcpBU/5QNfEN5Bbt5qxhxqb8N3qgfB8d1dHD+1HR/6tMAgnoE96PnJp1FzRf0a+yhiIRDMFBzuHD9ulOqrp1Zm8micambAiruUeZVU94Uc5QQ/8dXWav4kdCrKQuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caaw9IrE9qsT6WM3eOpTgSIRV6p3soXnHOANr33Keyo=;
 b=P/id7KKyAYs5PGA7M8JiWjhne3kZzwy5E5zkiumubK8L7MAjdjGIEEwZS9HYGXb3+BllpTR5wViM2/gdK09Nvfu93XWHKW12HidIrTUH09J9xjxxh5SQJiFrSyscY5QvNkMwNjaVpO995culUB5qwcCfX95b5Ah+Zllx0GNXsqA=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA1PR83MB0775.EURPRD83.prod.outlook.com (2603:10a6:102:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 09:24:12 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 09:24:12 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Radek Barton
	<radek.barton@microsoft.com>
Subject: [PATCH v2] Cygwin: mkimport: port to support AArch64
Thread-Topic: [PATCH v2] Cygwin: mkimport: port to support AArch64
Thread-Index: AQHb8Xxlxyb5F+0NwEqDrFQg+LCd3Q==
Date: Thu, 10 Jul 2025 09:24:12 +0000
Message-ID:
 <DB9PR83MB0923D524D8A33D763CBDD0369248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923C4491893524EF694F6829243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB0923C4491893524EF694F6829243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T09:24:09.763Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA1PR83MB0775:EE_
x-ms-office365-filtering-correlation-id: 954237ef-60cb-4b6b-3947-08ddbf938816
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?v09jOwioEdV0Qm3tKWm2fVlrxpBqwM1b917gmKyogGxcnwdLVgjHlQ4tRx?=
 =?iso-8859-2?Q?m8Esxz7BD7bInKJnEP3spHuj9hMUbU1DWrjeFU6C7s+CQ8IK5V833D3S2c?=
 =?iso-8859-2?Q?sK/trGFP84SXO+dRr249sbnjJpfHHR3MfwNKH/CGPEg0pXh7gGaOKLt35I?=
 =?iso-8859-2?Q?lqYAAQvssWdHhav37IAGDN+C+nz2QmAh/aP+jVrpy0pKkh1SxsYl+eGtnR?=
 =?iso-8859-2?Q?mTgLCWbe0/3DgVcOyAxLZLl//4sEINgU178CJ1/Pnhmjx6J7EbF0Iu4SGX?=
 =?iso-8859-2?Q?jC0hgL9BADYZ5cSwnJPtURLKmjWNj/vcQB+jLrudM+i353gBo7S9AR9D9C?=
 =?iso-8859-2?Q?S3WhKw04MtHKCIM+svj95hwfZ24AyVLlPHnWNZ/NPZDpigr1qx4xd5LQgj?=
 =?iso-8859-2?Q?IFluFZaskDPK3JYJW5QgKqdgMFe2FTg8nQn+m3LZlDfhZfj+hY0C5ed9/p?=
 =?iso-8859-2?Q?kIN+70Pu/Q4k7yDGu7w+WrfkvAG5iQ/U0XZygNn+xhpkwo/cdLkQDzyFQr?=
 =?iso-8859-2?Q?rfim4rtJBkq/ZuoKsoUtYQ7ZQ36h21N9iy9OkOxpAJRm1LRaCcDkFucpwr?=
 =?iso-8859-2?Q?j/zndZ0IPIaxHT7CoP0CmsMZYV2PcLxE/i0udHvhP7G5eHJ7z1TXGk2VQa?=
 =?iso-8859-2?Q?EjBK5UjwKfFtKSwXwdPOjqYUpeTQth17HucHyVl/h3N17XETkeNog9BO7S?=
 =?iso-8859-2?Q?tEBOfrvKW0tcASPFzE6NZoXc7jD9Jw5XzRbDs5gayoBjwdC5BTGg1vr1jL?=
 =?iso-8859-2?Q?9KNPTzyxOJk+AjewQ8SKfyLFmPh6Zwklo2Mp8B3lD0hgMM6/6myXtcWpxq?=
 =?iso-8859-2?Q?ZoM0iOHmifFu+qX9CHzTdj0xIGHZR2XK6lLHQ7FrBIyx4LITC+Tut/sMFG?=
 =?iso-8859-2?Q?wabolDVpYQ/P5L60r85obRPjU+Jm5laVOja4ymtFIeE0FRjNBadt3eDdvj?=
 =?iso-8859-2?Q?kpigmS76J2IFzXZ5A1nCGRt34BoE7nojKI8HQwNkeQb+cm3g/rckIomxzm?=
 =?iso-8859-2?Q?I9GjAlpOMefJzj4fzN4RiIuXqXK2lCeYQEybCTFaWl1GdtTeGHHEx0UguS?=
 =?iso-8859-2?Q?XFkknEcNZlmVa3UnLCFJVejIcp0UP0YwVuofai8TCkkO19YWS6ON1a6EZ7?=
 =?iso-8859-2?Q?vJTUPo0lr2xZgOSnewieTPbpxf59r9h+16FeKRVJbMF6CBmVokSbtBLt+m?=
 =?iso-8859-2?Q?hs/oXEIKRSj4yw6bHXqAifrXFJXrUFXJyG3j2BYChOrNTEvHISHpYQrcuP?=
 =?iso-8859-2?Q?nMYy3+FGMK/h51vFQ+C0osBpmdQSez6nAgrTxW8dym0fH+s2htGr7sSHyM?=
 =?iso-8859-2?Q?G+TJ08rjKXJzY1HKNb76IWwnYv9C5ZVv41S05CV8hn4J78tXggc+JNknms?=
 =?iso-8859-2?Q?KiHTIJS206rtr+tC/E6HnJLr5EDNHaLE75H2aVlt/VySbPIXR7QlyeuszH?=
 =?iso-8859-2?Q?P8iKfSXyt1tNiDYj5Jk7yLzjlbCc1pfhWeflHCAiY/Nxvgcr6kk0T+n1BK?=
 =?iso-8859-2?Q?CpNlrxLAcX6HabKQtspZNEq5hZXXuGsLKrCrrbUrWPWVqYnvsWJMuDTIU+?=
 =?iso-8859-2?Q?UIdDIyA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?mTPQIoCbDRDK3fWz3f3dSWO5soR7E1jnDCr2Faxer8P2OVkALoCUcvCHYr?=
 =?iso-8859-2?Q?ChV2DHOTFLXvAyZBoHlZeNBimYscyjChSQ3ke+n6wTeaLiPtZZC7NeKBwO?=
 =?iso-8859-2?Q?PbtRNs9mZjUUUXVkv78wZGSDUeiROYFhO9PLLFQiBqq2MsE+Dp49DcWCqn?=
 =?iso-8859-2?Q?vJIUVDrUz/MHAWbp3md+pURdFlHSLIvotNRig2n1C7BK3omL5GpSZpDzED?=
 =?iso-8859-2?Q?e7qwiWcTm09unMerurEU5ODwvpdrT7z0fOz4OsoDdGoE5ofTBna08uEScU?=
 =?iso-8859-2?Q?xads5UdINFSRMLM5FCL2ZyblITnXEf+6erPgUXFtI1zl5XS4yZiExqEJN9?=
 =?iso-8859-2?Q?yMbBwsnGwpibmMdJQTpFhXQ34Kd30XX08KkBSMXr6ebGLPvfezFfxIakLV?=
 =?iso-8859-2?Q?0Xo9E82ww247iJuzUGfR1SWkEvKnxYoHkuUczT2vpOGjbfRdjMwQ8SaCgG?=
 =?iso-8859-2?Q?eDpeWcQKmR7nAzYZlukMrAh2ikYKR1uhL1uBeH0lhpXP4W+dUKgo8V+h9V?=
 =?iso-8859-2?Q?/Apsb6UKvygkU1jp//EA33ZYhGUmosi1mRF4K8uuUm3CLo3qeYCKMuInzr?=
 =?iso-8859-2?Q?v3VR3DqZ8x8eXfDtkBr+k+xdCzabu+I0Rk2X/IJnIgwBgUX8Hm/hpaT93K?=
 =?iso-8859-2?Q?mhXUvjedgNYVpza8FU2ut/3TrCKh1cpMLA3ZKciqYt/LB8AB12AqBcM7Di?=
 =?iso-8859-2?Q?pkKDwgLqdWZqdxh7IRrQp46gAKKOw7GNOqkJqqExQ52R7ee8Elb5L0kQNH?=
 =?iso-8859-2?Q?ubf0TIkGKdYbeCQouNJYK9c/CHLPpPAy4NZi3JxqHjrlC8FOEQq6tJIEvV?=
 =?iso-8859-2?Q?gQS1gueyyGvNGORSEH9SMAv9Me4BPlaLDdiF4siv2bVm1/o5ReMoT83DwW?=
 =?iso-8859-2?Q?rnhNEtKx0bvi0x65nT/C7/I2U/GynliBBBxCSzWNmNj7G+vwJUvZiu+oAh?=
 =?iso-8859-2?Q?l0p75dHk8/xoUTbfL1U7sI8iNS4e7Q5cCGcUpNabBcPYgLDilz1id24WJt?=
 =?iso-8859-2?Q?8QYXQrl5bDWZPFDPUh6cxa+zXnq7mcNap3byPnWdGR71HbGIWEiFXNvlXB?=
 =?iso-8859-2?Q?SVzzwfv+I9JqnBQfuZXT6tBwTKwGIFOW6mrwv7SNpPgNrbm1CciyvhAzbZ?=
 =?iso-8859-2?Q?wzT/k/1wI4wNhE/FtO9kUIY8mI/2qOUmejvtVauRglxTFF5NliAwis3W+9?=
 =?iso-8859-2?Q?Bqfrx+67c5e7H8nwrQVoH9GhT5ikpoCEUsfoRnN4iVuVKgl1uFAIxTpfdm?=
 =?iso-8859-2?Q?sN/XdV7WAzx9/P9cLi3LGJ0xFuZbcoI/zN6XFYbONyaYIyiPMFXSrWvpfy?=
 =?iso-8859-2?Q?Sk8xGZd3NMX/XYnYXKndhB6Xpw3ZOeSV8B2Kj0H0JPRWAGekhS+neYGKQn?=
 =?iso-8859-2?Q?udsdbfKvou9Mt/A2nOGhgC4SeJq1wbDKt5TnktiRhR9kpvw72w8/nonk8T?=
 =?iso-8859-2?Q?GE3Kx2N6eb4dmqUrBUuMfHFfnlh5SzKbX7vpyACWhFd86Qfw1379xCW3sH?=
 =?iso-8859-2?Q?JCcacf+DoQgDMjduJKTa3yAyPknkCARjRFuUjWmBbmm8GGEQpJzIn/bITj?=
 =?iso-8859-2?Q?Y/Mh/NkwP1b6GdHRtxSbMbOL9u+d?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923D524D8A33D763CBDD0369248ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954237ef-60cb-4b6b-3947-08ddbf938816
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 09:24:12.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3zrt9EhUkVw8peadL9nGZCUijuPNzZt3T4Sqj1+jtg+k5CaymM82ww1oi+GelBqcxzEIydrSsWZv/3fQu/dAtYvsziJVCdh5NdALgovMsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0775
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923D524D8A33D763CBDD0369248ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending the same patch with more detailed commit message.=0A=
=0A=
Radek=0A=
---=0A=
From e5060aa9afc7346301b7f394515d7a280b3c703d Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Mon, 9 Jun 2025 08:45:27 +0200=0A=
Subject: [PATCH v2] Cygwin: mkimport: port to support AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch ports winsup/cygwin/scripts/mkimport script to AArch64, namely=
=0A=
implements relocation to the imp_sym.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/scripts/mkimport | 11 +++++++++++=0A=
 1 file changed, 11 insertions(+)=0A=
=0A=
diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimpor=
t=0A=
index 9517c4e9e..0c1bcafbf 100755=0A=
--- a/winsup/cygwin/scripts/mkimport=0A=
+++ b/winsup/cygwin/scripts/mkimport=0A=
@@ -24,6 +24,7 @@ my %import =3D ();=0A=
 my %symfile =3D ();=0A=
 =0A=
 my $is_x86_64 =3D ($cpu eq 'x86_64' ? 1 : 0);=0A=
+my $is_aarch64 =3D ($cpu eq 'aarch64' ? 1 : 0);=0A=
 # FIXME? Do other (non-32 bit) arches on Windows still use symbol prefixes=
?=0A=
 my $sym_prefix =3D '';=0A=
 =0A=
@@ -65,6 +66,16 @@ for my $f (keys %text) {=0A=
 	.global	$glob_sym=0A=
 $glob_sym:=0A=
 	jmp	*$imp_sym(%rip)=0A=
+EOF=0A=
+	} elsif ($is_aarch64) {=0A=
+	    print $as_fd <<EOF;=0A=
+	.text=0A=
+	.extern	$imp_sym=0A=
+	.global	$glob_sym=0A=
+$glob_sym:=0A=
+	adr x16, $imp_sym=0A=
+	ldr x16, [x16]=0A=
+	br x16=0A=
 EOF=0A=
 	} else {=0A=
 	    print $as_fd <<EOF;=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB0923D524D8A33D763CBDD0369248ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-mkimport-port-to-support-AArch64.patch"
Content-Description: v2-0001-Cygwin-mkimport-port-to-support-AArch64.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-mkimport-port-to-support-AArch64.patch"; size=1343;
	creation-date="Thu, 10 Jul 2025 09:23:56 GMT";
	modification-date="Thu, 10 Jul 2025 09:23:56 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlNTA2MGFhOWFmYzczNDYzMDFiN2YzOTQ1MTVkN2EyODBiM2M3MDNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCA5IEp1biAyMDI1IDA4OjQ1OjI3ICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQ3lnd2luOiBta2ltcG9ydDogcG9ydCB0byBzdXBwb3J0
IEFBcmNoNjQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFy
c2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRoaXMgcGF0Y2ggcG9y
dHMgd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0IHNjcmlwdCB0byBBQXJjaDY0LCBuYW1l
bHkKaW1wbGVtZW50cyByZWxvY2F0aW9uIHRvIHRoZSBpbXBfc3ltLgoKU2lnbmVkLW9mZi1ieTog
UmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+Ci0tLQogd2luc3VwL2N5
Z3dpbi9zY3JpcHRzL21raW1wb3J0IHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1w
b3J0IGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CmluZGV4IDk1MTdjNGU5ZS4uMGMx
YmNhZmJmIDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvbWtpbXBvcnQKKysrIGIv
d2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CkBAIC0yNCw2ICsyNCw3IEBAIG15ICVpbXBv
cnQgPSAoKTsKIG15ICVzeW1maWxlID0gKCk7CiAKIG15ICRpc194ODZfNjQgPSAoJGNwdSBlcSAn
eDg2XzY0JyA/IDEgOiAwKTsKK215ICRpc19hYXJjaDY0ID0gKCRjcHUgZXEgJ2FhcmNoNjQnID8g
MSA6IDApOwogIyBGSVhNRT8gRG8gb3RoZXIgKG5vbi0zMiBiaXQpIGFyY2hlcyBvbiBXaW5kb3dz
IHN0aWxsIHVzZSBzeW1ib2wgcHJlZml4ZXM/CiBteSAkc3ltX3ByZWZpeCA9ICcnOwogCkBAIC02
NSw2ICs2NiwxNiBAQCBmb3IgbXkgJGYgKGtleXMgJXRleHQpIHsKIAkuZ2xvYmFsCSRnbG9iX3N5
bQogJGdsb2Jfc3ltOgogCWptcAkqJGltcF9zeW0oJXJpcCkKK0VPRgorCX0gZWxzaWYgKCRpc19h
YXJjaDY0KSB7CisJICAgIHByaW50ICRhc19mZCA8PEVPRjsKKwkudGV4dAorCS5leHRlcm4JJGlt
cF9zeW0KKwkuZ2xvYmFsCSRnbG9iX3N5bQorJGdsb2Jfc3ltOgorCWFkciB4MTYsICRpbXBfc3lt
CisJbGRyIHgxNiwgW3gxNl0KKwliciB4MTYKIEVPRgogCX0gZWxzZSB7CiAJICAgIHByaW50ICRh
c19mZCA8PEVPRjsKLS0gCjIuNTAuMS52ZnMuMC4wCgo=

--_002_DB9PR83MB0923D524D8A33D763CBDD0369248ADB9PR83MB0923EURP_--
