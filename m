Return-Path: <SRS0=OfBw=Y7=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20729.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::729])
	by sourceware.org (Postfix) with ESMTPS id C336738083C8
	for <cygwin-patches@cygwin.com>; Mon, 16 Jun 2025 11:31:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C336738083C8
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C336738083C8
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::729
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750073471; cv=pass;
	b=loOqPxMwvwkjsXRL6mHyRbavq4m/Yay504nhj43R9REqFdDv1hpx4RKScBeKvY4gP6nM37Drx6xG4APsUwfxyp6dW7Op8xe2WfQsZcSRbzuuxgiSbkbsYrzhIu3/yXKJbMcVQmhSP7v7CC/6YgMCD0KOHgv3npzcpdiTG15pino=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750073471; c=relaxed/simple;
	bh=DlTx3Ee45ZAhMMF618+g4RUo1NJpWVwMFI6THP5cd0I=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=UwyU1EceovVl7+VsY+4khkhVAM3Mn4gg5jF2EZ981nidIBCB8k8NnpZGez2sXaLvH7K6aJgM49QMQ2MCKM4QG29SGOya1iVeuOEIIiGaAgTEnUoKL3Bm4d4WFwbBgrd9W2rw97CipshVr5Bvx2mHI0+hTGbKmTIT7BDR1genB9g=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C336738083C8
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=h9kG13H7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg1fIMIGwADrcxtqYvUO/xS2TVx1x6BjgfzVNIq97Xb8nL411r98ORaGc39qcWVlSgJ2P+k5UOrznrQ/w261wB4FXECA2GSVXk+UBS+PZl3oeSufR978EUyqCImm2+yXoFmAjwNgaKOz9tbanR2pcs1Kw7l0ksK8LGPTlJN6aLH1fdtrwaKOF29S3BJE84VeKRn36Zk/jfvyoTwtvmjuXRW2cCt3HOctf3n2GY7NJmpLYagA44yIlIX9J0Jc+K8LrHQ/2g2Jco/8A0lYNud0sT5Oc38mWKhKjA9xfFpptNkjl/8dq4yRfNK1yUpA4eMhOu+1ohTVIBk6OXxKYgP5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6/XvjpCgIqUiQWgGkQHb8c+d127OKFvBrMzmgRfiRA=;
 b=lsVWE+YC4/+S5haX6t1G2Kl0wB+QpkCpEc4W3OfMjx0cxh4L6oNBXZvOMvjacJyVh8mFNB7kec8KkLT8YiRp2BFWzr98FniHvlQZjJ55OPfRrv7J1bq5X+rKOpQGfZv3G/pyskZvwFRSKmvEhJsR84ULfJo8gGx4xR21fWUEfEyX3zxvip6K4gx0g30XErBtooHj0mA78Dkicn+9p0dkOCfFtkQPDHIauENlvHXq4CdA0OXOoH9W+oxNPRKDvdvxjlQaDGaAjjf6+rEXpS+/B1ZTubzbH+UWjR5+5A869wqeEV18fOjjxALnUj9ZWr4nSv7t8vOuOA1eWndJL6mSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6/XvjpCgIqUiQWgGkQHb8c+d127OKFvBrMzmgRfiRA=;
 b=h9kG13H7/JPX4k7/TOzNebtW0vIyiDUIGLZ4Pj8TSOsSysCseLJVFpkugf9S7AKav3Wf5scQjbxQWl9hhqaDMd8KWNYRMjDI6DxidpEX+1YshaBgvgL4rAyBuoLs3wzOtLDJxMOh+ZKXCY56a09o8/5cAMnE+hafOn6lKjm2+iE=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by VI0PR83MB0565.EURPRD83.prod.outlook.com (2603:10a6:800:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.16; Mon, 16 Jun
 2025 11:31:06 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.004; Mon, 16 Jun 2025
 11:31:06 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Newlib <newlib@sourceware.org>, "cygwin-patches@cygwin.com"
	<cygwin-patches@cygwin.com>
Subject: [PATCH/QUESTION] newlib: fenv: AArch64 Cygwin linking fixes
Thread-Topic: [PATCH/QUESTION] newlib: fenv: AArch64 Cygwin linking fixes
Thread-Index: AQHb3p9FpSdhgxITc0+yc9hnaqIR3w==
Date: Mon, 16 Jun 2025 11:31:06 +0000
Message-ID:
 <GV4PR83MB0941761524523870C31AC5BD9270A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-16T09:18:26.060Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
undefined: 3129546
drawingcanvaselements: []
composetype: newMail
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|VI0PR83MB0565:EE_
x-ms-office365-filtering-correlation-id: 4f29efac-d57c-495b-0352-08ddacc948de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?YSkajfBj8kh7rNp5i3zzC7auMUrs5I8L/c+MA+yZtIz7FKGIF+h7QSj72R?=
 =?iso-8859-1?Q?x9R0HHAWPtdxzZuz4gqWsP7+sMP9VjbUWE51ev+1zGCuAv2nJAABHqTUZ2?=
 =?iso-8859-1?Q?EBwPR0VEh/C6FwpNZcNn4rr11cbwqhS6SNmP/t0RKwjN+CaFSVRl8Kj5Bj?=
 =?iso-8859-1?Q?mJA4mZgbsWCTuOnIqf2sFTnaEKXDmYj0z5NvlldgTM66gZ4Q4D08zTQMFE?=
 =?iso-8859-1?Q?AltL8w3jl5LKsrM7v9fUfM5cPZtHGQEpJGxppB19GFVUl5UMCKFwYXjVj1?=
 =?iso-8859-1?Q?K1eu0sZ+x1DuDD1SInTgjifqOdaKjNjseGr39UUD76Ryx/86eBCGINVdo5?=
 =?iso-8859-1?Q?79t7mKVrrCbjRvZBKS2HJefKLUNbrVlDSEWQu+6wBP+RnB1ujpwsIuGpUi?=
 =?iso-8859-1?Q?jzzyOhQCItbKnKcnETbe6Jukt4pN9O+H3tWCg9iHrkaeqWIMtIWupn+SWI?=
 =?iso-8859-1?Q?OIvGeFjnQa/luBb37SWTFD6quC0Q69KfAVQ295YaXakvGuFGv04JN75ebo?=
 =?iso-8859-1?Q?NQAKT9LgaOF6TMCBVruY7gQDLF8VKK7wjxsNcpsYm97y+f1oCpzVIUxZ0r?=
 =?iso-8859-1?Q?SGr2RB2ti/K0cNxoIz8MKyI2Q6mDhJOi7Mt6LtbbLEDRedhf/e9WVjTN6O?=
 =?iso-8859-1?Q?qu0Ba/W+maM87DRG0w5O+qzSwnI+yA2MdQrpgw3v5ZRaTkhYKUXzzNPaLR?=
 =?iso-8859-1?Q?T8tk5bB4qMutHvEpzIPJbUG5ahTDNq35rTWlQXuTNtXmbBPwddKXIarbSq?=
 =?iso-8859-1?Q?WrQ59tSy9YBYukz/tZgy1j7Y5n6S8HdZAttNp6hXifTTVumTOL1RZRY8fN?=
 =?iso-8859-1?Q?3UO1WLtc8GhDzxr+8zAtqiSV1AoU+OvQLrzqZJlLhNwojQo6IUUlNCDs1A?=
 =?iso-8859-1?Q?AFYp57AXMhrSDDpg6+159pUetV5zVoePjYzFx/i2m17wG7VgIdDAvhqFvK?=
 =?iso-8859-1?Q?JxRcoAl6iSBD0RVpMTpgOlqRFGCnqiRWP9eDdbcK3qKbc+7yC8I9cLNWeU?=
 =?iso-8859-1?Q?7/kCl6uMl68cwxb1con6a6xoZSQUelYzb3p11mJki1bOMYSFcDF1LDihZu?=
 =?iso-8859-1?Q?SC0zDscZR+ve+1P0NS4Xgya4QsGV5lcJ9cVXrO6JFVC411tyt/CDk43tTE?=
 =?iso-8859-1?Q?pfxhJrCQ3/97yMN0DVzHiLHGtjwJCdqzDaAK1x19B9i3DCbrKPN1w1RBen?=
 =?iso-8859-1?Q?jdONwKMGq7jlEOyEJ2dUSlZr5BBDBXJHGMu7Xj/MmlHKKe7awTzllTQ6t3?=
 =?iso-8859-1?Q?joeUXaAhHirbFEvisfOUbq12r0t6lLoyQIcmRActOE415GzIbvfnbfHs3K?=
 =?iso-8859-1?Q?3JxwGzLCIqAJrx7eJ0eO8emW9QWNWI4nMBlyeaHxVvzqCvz+qNOhShfmVB?=
 =?iso-8859-1?Q?tzgF6Wxzd+KrUwqCm75s0Zw8EfYBB1iQRBYRc9FPfxR7FeRsA+woSGNxrE?=
 =?iso-8859-1?Q?IRQ/wVGtnV0sl/V30b/6ap39v5xgbQQ6nkRyP6jZtlPV2xcrv3170R9sc9?=
 =?iso-8859-1?Q?k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?A8FPqVKR5eRqK1ia3n7jkJNXSMYXoNYYB6RK+t8B+f+nM3mw+/38JQCIHC?=
 =?iso-8859-1?Q?gC3CLmsTqFVmJ7cWfWoBZih/bwVBeKfbTg9olyXQ0RQTWEaGNAqq1JSq+c?=
 =?iso-8859-1?Q?LkjSoUkH0jlEo7zDxkdGfEcoxk/d1L8KNvRKV4HF72p7XANB+IZmeWfSdv?=
 =?iso-8859-1?Q?LRD9SzPqzEQY7M5Qn0BNYCFx5jWwSRCUgHoBCr6mq9P86gADSXEpQDNeSc?=
 =?iso-8859-1?Q?wPPuBE4izAsdt32OC0tJtwW8Sk+R+uBrjKfvjwJONpDUZvU4opBgJ4a30D?=
 =?iso-8859-1?Q?itXWlVsnwYugOmtMkdKgrAWXrZi4l8Ij+0VvKtZ/KpqmNBbwLBukddvBvT?=
 =?iso-8859-1?Q?LpZ1f7diYiYaok64knt58/16F9227L+p3G960Br5mOABFt2J8w+t8MxwrU?=
 =?iso-8859-1?Q?fVCJh6W+gN2Qz/RLGLOqa8GLiF0Tpkjihqy/wNwpLnKq2RJEmZ+Hy2UwtS?=
 =?iso-8859-1?Q?apllZlTrspRo1BadfSzblH73Mhwt0KNwh0MxpPV0WKkSUN5biEKXLo9DsH?=
 =?iso-8859-1?Q?Hi4Gln3IKSoHRvyE4Jo5SGzVialBHEC+WERkA+7SUYBIyX8avBficJSfza?=
 =?iso-8859-1?Q?ltr02UjUMnabk6fhL/YnGm1W8xMJ3eCQVDpUyzwazg5IG0sRmDzzHoH5U3?=
 =?iso-8859-1?Q?CLgWX0Kph0UUQbB0RV84JSv/v9oDSGnh5jrBvV4J6N/bLyLXrjwVbnCL/S?=
 =?iso-8859-1?Q?DS90ajZkgUn+02luH+/2xL3uhXqPIC9wC0XzHHgZ91N+ln14ZxVXNS15iV?=
 =?iso-8859-1?Q?eENxDRcMnkkYwiQ/AviEX7TYyDL+2x9hqfSptvz9dZxrWTEhPmgs9MhqqT?=
 =?iso-8859-1?Q?A5sCSyz/88M5IBm/n8KbrJUsOya3ukB3AzhOE4zphrFqMS18c8Vxo0DzKe?=
 =?iso-8859-1?Q?NKIfAw7tamj5M9KsKIMVesVqVfpQ43P4wCMO2MkCzsehdoaRBechKj1fC3?=
 =?iso-8859-1?Q?hvflcBdBU12ZDflAFVdnsyKKzeEMeqc3FqL6zh6IlaRfrPCY0mx9T3UqzE?=
 =?iso-8859-1?Q?DUvIjjAyB9nPh4U4tT9EwG2q+PUsPynxvGPQJTKSNZUf0PVa63I0PG7dkF?=
 =?iso-8859-1?Q?yo8PU2ED9bRT+w56rtZnYDx4BQeksupoVVX1hbc2oTwgsXdGerY8aBnkPH?=
 =?iso-8859-1?Q?rcovGca1yWcpfYgirKgEG+kMrUKrLUJeYhoJGzpBGqjRcJJBi5Hf30QzaC?=
 =?iso-8859-1?Q?o0dRLKlaSVNrAkgnbXJOFqq6Wmrl0X6bHiRu5OJDr56iYV9ZRdNK6V6ZKj?=
 =?iso-8859-1?Q?fs1LnX233Erh8lQtWGDh1aKVzfD2qvKAm2jwSPr3AD9ZLeTK6GRyACBQhh?=
 =?iso-8859-1?Q?8qPdrjVm/f818rbtwoISJ/QbEHM6TIk6x0BYKfSkyFi1g9KO0+RbZ4Wvpq?=
 =?iso-8859-1?Q?HqaPi8ORZDlE8ALtzLyCiCFtFfSCgtbaSAbnyG4WZU0S8hGE/t8AXlSYp9?=
 =?iso-8859-1?Q?qWYZlEUL0EPQigRJkiKBbDDSLPl35PMtKwvwSUBh2Y8J9CDMlSTXCCAsiK?=
 =?iso-8859-1?Q?qzfnGZCZTRmqtjJ2a25O16s73KC+JnhZLPkfIqTWAU3FPNpHQW4QMTunSo?=
 =?iso-8859-1?Q?rVeBKxaTSGOHvXo18VQ3vpiezBg8?=
Content-Type: multipart/mixed;
	boundary="_002_GV4PR83MB0941761524523870C31AC5BD9270AGV4PR83MB0941EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f29efac-d57c-495b-0352-08ddacc948de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 11:31:06.7373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qp9ODoo4lLJRAtMUDx6bPtfteDt4dEQRIoCbzB6+wjTiC2LoOYrf6BZgQUXXVQ1FZuVg2zu9pfrzfE78sNMFaLxAORAl/nenLy7NrJ2/h8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0565
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_GV4PR83MB0941761524523870C31AC5BD9270AGV4PR83MB0941EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This is more a question than patch submission: Without the attached changes=
, the Cygwin cannot be linked for AArch64 failing on:=0A=
```=0A=
ld: cannot export _fe_nomask_env: symbol not defined=0A=
ld: cannot export fedisableexcept: symbol not defined=0A=
ld: cannot export fegetexcept: symbol not defined=0A=
ld: cannot export fegetprec: symbol not defined=0A=
ld: cannot export fesetprec: symbol not defined=0A=
```=0A=
Can anybody share some insights why are those changes needed and whether th=
ere is a better way how to overcome this issue?=0A=
=0A=
Note that the `feenableexcept`, `fedisableexcept`, `fegetexcept` implementa=
tions are similarly defined in=A0`newlib/libc/machine/mips/machine/fenv-fp.=
h` for MIPS architecture as well.=0A=
=0A=
Thank you,=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 17fd8e16061ab199d111b303a44c042ea43c4018 Mon Sep 17 00:00:00 2001=0A=
From: Radek Barton <radek.barton@microsoft.com>=0A=
Date: Mon, 9 Jun 2025 08:55:18 +0200=0A=
Subject: [PATCH/QUESTION] newlib: fenv: AArch64 Cygwin linking fixes=0A=
=0A=
---=0A=
 newlib/libc/machine/aarch64/machine/fenv-fp.h | 64 +++++++++++++++++++=0A=
 newlib/libc/machine/aarch64/sys/fenv.h        | 40 ------------=0A=
 newlib/libm/machine/aarch64/fenv.c            |  7 ++=0A=
 winsup/cygwin/fenv.c                          | 10 +++=0A=
 4 files changed, 81 insertions(+), 40 deletions(-)=0A=
=0A=
diff --git a/newlib/libc/machine/aarch64/machine/fenv-fp.h b/newlib/libc/ma=
chine/aarch64/machine/fenv-fp.h=0A=
index d8ec3fc76..e42e2d873 100644=0A=
--- a/newlib/libc/machine/aarch64/machine/fenv-fp.h=0A=
+++ b/newlib/libc/machine/aarch64/machine/fenv-fp.h=0A=
@@ -154,3 +154,67 @@ feupdateenv(const fenv_t *__envp)=0A=
 	return (0);=0A=
 }=0A=
 =0A=
+#if __BSD_VISIBLE=0A=
+=0A=
+/* We currently provide no external definitions of the functions below. */=
=0A=
+=0A=
+__fenv_static inline int=0A=
+feenableexcept(int __mask)=0A=
+{=0A=
+	fenv_t __old_r, __new_r;=0A=
+=0A=
+	__mrs_fpcr(__old_r);=0A=
+	__new_r =3D __old_r | ((__mask & FE_ALL_EXCEPT) << _FPUSW_SHIFT);=0A=
+	__msr_fpcr(__new_r);=0A=
+	return ((__old_r >> _FPUSW_SHIFT) & FE_ALL_EXCEPT);=0A=
+}=0A=
+=0A=
+__fenv_static inline int=0A=
+fedisableexcept(int __mask)=0A=
+{=0A=
+	fenv_t __old_r, __new_r;=0A=
+=0A=
+	__mrs_fpcr(__old_r);=0A=
+	__new_r =3D __old_r & ~((__mask & FE_ALL_EXCEPT) << _FPUSW_SHIFT);=0A=
+	__msr_fpcr(__new_r);=0A=
+	return ((__old_r >> _FPUSW_SHIFT) & FE_ALL_EXCEPT);=0A=
+}=0A=
+=0A=
+__fenv_static inline int=0A=
+fegetexcept(void)=0A=
+{=0A=
+	fenv_t __r;=0A=
+=0A=
+	__mrs_fpcr(__r);=0A=
+	return ((__r & _ENABLE_MASK) >> _FPUSW_SHIFT);=0A=
+}=0A=
+=0A=
+#endif /* __BSD_VISIBLE */=0A=
+=0A=
+#if defined(__CYGWIN__)=0A=
+=0A=
+/*  Returns the currently selected precision, represented by one of the=0A=
+   values of the defined precision macros.  */=0A=
+__fenv_static inline int=0A=
+fegetprec (void)=0A=
+{=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+/* http://www.open-std.org/jtc1/sc22//WG14/www/docs/n752.htm:=0A=
+=0A=
+   The fesetprec function establishes the precision represented by its=0A=
+   argument prec.  If the argument does not match a precision macro, the=
=0A=
+   precision is not changed.=0A=
+=0A=
+   The fesetprec function returns a nonzero value if and only if the=0A=
+   argument matches a precision macro (that is, if and only if the request=
ed=0A=
+   precision can be established). */=0A=
+__fenv_static inline int=0A=
+fesetprec (int prec)=0A=
+{=0A=
+  /* Indicate success.  */=0A=
+  return 1;=0A=
+}=0A=
+=0A=
+#endif /* __CYGWIN__ */=0A=
diff --git a/newlib/libc/machine/aarch64/sys/fenv.h b/newlib/libc/machine/a=
arch64/sys/fenv.h=0A=
index 6b0879269..1cfbeaaf4 100644=0A=
--- a/newlib/libc/machine/aarch64/sys/fenv.h=0A=
+++ b/newlib/libc/machine/aarch64/sys/fenv.h=0A=
@@ -77,44 +77,4 @@ extern const fenv_t	*_fe_dfl_env;=0A=
 #define	__mrs_fpsr(__r)	__asm __volatile("mrs %0, fpsr" : "=3Dr" (__r))=0A=
 #define	__msr_fpsr(__r)	__asm __volatile("msr fpsr, %0" : : "r" (__r))=0A=
 =0A=
-=0A=
-#if __BSD_VISIBLE=0A=
-=0A=
-/* We currently provide no external definitions of the functions below. */=
=0A=
-=0A=
-static inline int=0A=
-feenableexcept(int __mask)=0A=
-{=0A=
-	fenv_t __old_r, __new_r;=0A=
-=0A=
-	__mrs_fpcr(__old_r);=0A=
-	__new_r =3D __old_r | ((__mask & FE_ALL_EXCEPT) << _FPUSW_SHIFT);=0A=
-	__msr_fpcr(__new_r);=0A=
-	return ((__old_r >> _FPUSW_SHIFT) & FE_ALL_EXCEPT);=0A=
-}=0A=
-=0A=
-static inline int=0A=
-fedisableexcept(int __mask)=0A=
-{=0A=
-	fenv_t __old_r, __new_r;=0A=
-=0A=
-	__mrs_fpcr(__old_r);=0A=
-	__new_r =3D __old_r & ~((__mask & FE_ALL_EXCEPT) << _FPUSW_SHIFT);=0A=
-	__msr_fpcr(__new_r);=0A=
-	return ((__old_r >> _FPUSW_SHIFT) & FE_ALL_EXCEPT);=0A=
-}=0A=
-=0A=
-static inline int=0A=
-fegetexcept(void)=0A=
-{=0A=
-	fenv_t __r;=0A=
-=0A=
-	__mrs_fpcr(__r);=0A=
-	return ((__r & _ENABLE_MASK) >> _FPUSW_SHIFT);=0A=
-}=0A=
-=0A=
-#endif /* __BSD_VISIBLE */=0A=
-=0A=
-=0A=
-=0A=
 #endif	/* !_FENV_H_ */=0A=
diff --git a/newlib/libm/machine/aarch64/fenv.c b/newlib/libm/machine/aarch=
64/fenv.c=0A=
index 3ffe23441..86f8cd5aa 100644=0A=
--- a/newlib/libm/machine/aarch64/fenv.c=0A=
+++ b/newlib/libm/machine/aarch64/fenv.c=0A=
@@ -55,3 +55,10 @@ extern inline int feupdateenv(const fenv_t *__envp);=0A=
 extern inline int feenableexcept(int __mask);=0A=
 extern inline int fedisableexcept(int __mask);=0A=
 extern inline int fegetexcept(void);=0A=
+=0A=
+#if defined(__CYGWIN__)=0A=
+=0A=
+extern inline int fegetprec(void);=0A=
+extern inline int fesetprec(int prec);=0A=
+=0A=
+#endif /* CYGWIN */=0A=
diff --git a/winsup/cygwin/fenv.c b/winsup/cygwin/fenv.c=0A=
index 80f7cc52c..1558f76c2 100644=0A=
--- a/winsup/cygwin/fenv.c=0A=
+++ b/winsup/cygwin/fenv.c=0A=
@@ -3,3 +3,13 @@=0A=
    being called from mainCRTStartup in crt0.o. */=0A=
 void _feinitialise (void)=0A=
 {}=0A=
+=0A=
+#if defined(__aarch64__)=0A=
+=0A=
+#include <fenv.h>=0A=
+#include <stddef.h>=0A=
+=0A=
+/* _fe_nomask_env is exported by cygwin.din but not used at all for AArch6=
4. */=0A=
+const fenv_t *_fe_nomask_env =3D NULL;=0A=
+=0A=
+#endif /* __aarch64__ */=0A=
-- =0A=
2.49.0.vfs.0.3=0A=
=0A=

--_002_GV4PR83MB0941761524523870C31AC5BD9270AGV4PR83MB0941EURP_
Content-Type: application/octet-stream;
	name="0001-newlib-fenv-AArch64-Cygwin-linking-fixes.patch"
Content-Description: 0001-newlib-fenv-AArch64-Cygwin-linking-fixes.patch
Content-Disposition: attachment;
	filename="0001-newlib-fenv-AArch64-Cygwin-linking-fixes.patch"; size=4619;
	creation-date="Mon, 16 Jun 2025 11:28:49 GMT";
	modification-date="Mon, 16 Jun 2025 11:28:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxN2ZkOGUxNjA2MWFiMTk5ZDExMWIzMDNhNDRjMDQyZWE0M2M0MDE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWRlayBCYXJ0b24gPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQu
Y29tPgpEYXRlOiBNb24sIDkgSnVuIDIwMjUgMDg6NTU6MTggKzAyMDAKU3ViamVjdDogW1BBVENI
L1FVRVNUSU9OXSBuZXdsaWI6IGZlbnY6IEFBcmNoNjQgQ3lnd2luIGxpbmtpbmcgZml4ZXMKCi0t
LQogbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L21hY2hpbmUvZmVudi1mcC5oIHwgNjQgKysr
KysrKysrKysrKysrKysrKwogbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N5cy9mZW52Lmgg
ICAgICAgIHwgNDAgLS0tLS0tLS0tLS0tCiBuZXdsaWIvbGlibS9tYWNoaW5lL2FhcmNoNjQvZmVu
di5jICAgICAgICAgICAgfCAgNyArKwogd2luc3VwL2N5Z3dpbi9mZW52LmMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTAgKysrCiA0IGZpbGVzIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKyks
IDQwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2
NC9tYWNoaW5lL2ZlbnYtZnAuaCBiL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9tYWNoaW5l
L2ZlbnYtZnAuaAppbmRleCBkOGVjM2ZjNzYuLmU0MmUyZDg3MyAxMDA2NDQKLS0tIGEvbmV3bGli
L2xpYmMvbWFjaGluZS9hYXJjaDY0L21hY2hpbmUvZmVudi1mcC5oCisrKyBiL25ld2xpYi9saWJj
L21hY2hpbmUvYWFyY2g2NC9tYWNoaW5lL2ZlbnYtZnAuaApAQCAtMTU0LDMgKzE1NCw2NyBAQCBm
ZXVwZGF0ZWVudihjb25zdCBmZW52X3QgKl9fZW52cCkKIAlyZXR1cm4gKDApOwogfQogCisjaWYg
X19CU0RfVklTSUJMRQorCisvKiBXZSBjdXJyZW50bHkgcHJvdmlkZSBubyBleHRlcm5hbCBkZWZp
bml0aW9ucyBvZiB0aGUgZnVuY3Rpb25zIGJlbG93LiAqLworCitfX2ZlbnZfc3RhdGljIGlubGlu
ZSBpbnQKK2ZlZW5hYmxlZXhjZXB0KGludCBfX21hc2spCit7CisJZmVudl90IF9fb2xkX3IsIF9f
bmV3X3I7CisKKwlfX21yc19mcGNyKF9fb2xkX3IpOworCV9fbmV3X3IgPSBfX29sZF9yIHwgKChf
X21hc2sgJiBGRV9BTExfRVhDRVBUKSA8PCBfRlBVU1dfU0hJRlQpOworCV9fbXNyX2ZwY3IoX19u
ZXdfcik7CisJcmV0dXJuICgoX19vbGRfciA+PiBfRlBVU1dfU0hJRlQpICYgRkVfQUxMX0VYQ0VQ
VCk7Cit9CisKK19fZmVudl9zdGF0aWMgaW5saW5lIGludAorZmVkaXNhYmxlZXhjZXB0KGludCBf
X21hc2spCit7CisJZmVudl90IF9fb2xkX3IsIF9fbmV3X3I7CisKKwlfX21yc19mcGNyKF9fb2xk
X3IpOworCV9fbmV3X3IgPSBfX29sZF9yICYgfigoX19tYXNrICYgRkVfQUxMX0VYQ0VQVCkgPDwg
X0ZQVVNXX1NISUZUKTsKKwlfX21zcl9mcGNyKF9fbmV3X3IpOworCXJldHVybiAoKF9fb2xkX3Ig
Pj4gX0ZQVVNXX1NISUZUKSAmIEZFX0FMTF9FWENFUFQpOworfQorCitfX2ZlbnZfc3RhdGljIGlu
bGluZSBpbnQKK2ZlZ2V0ZXhjZXB0KHZvaWQpCit7CisJZmVudl90IF9fcjsKKworCV9fbXJzX2Zw
Y3IoX19yKTsKKwlyZXR1cm4gKChfX3IgJiBfRU5BQkxFX01BU0spID4+IF9GUFVTV19TSElGVCk7
Cit9CisKKyNlbmRpZiAvKiBfX0JTRF9WSVNJQkxFICovCisKKyNpZiBkZWZpbmVkKF9fQ1lHV0lO
X18pCisKKy8qICBSZXR1cm5zIHRoZSBjdXJyZW50bHkgc2VsZWN0ZWQgcHJlY2lzaW9uLCByZXBy
ZXNlbnRlZCBieSBvbmUgb2YgdGhlCisgICB2YWx1ZXMgb2YgdGhlIGRlZmluZWQgcHJlY2lzaW9u
IG1hY3Jvcy4gICovCitfX2ZlbnZfc3RhdGljIGlubGluZSBpbnQKK2ZlZ2V0cHJlYyAodm9pZCkK
K3sKKyAgcmV0dXJuIDA7Cit9CisKKy8qIGh0dHA6Ly93d3cub3Blbi1zdGQub3JnL2p0YzEvc2My
Mi8vV0cxNC93d3cvZG9jcy9uNzUyLmh0bToKKworICAgVGhlIGZlc2V0cHJlYyBmdW5jdGlvbiBl
c3RhYmxpc2hlcyB0aGUgcHJlY2lzaW9uIHJlcHJlc2VudGVkIGJ5IGl0cworICAgYXJndW1lbnQg
cHJlYy4gIElmIHRoZSBhcmd1bWVudCBkb2VzIG5vdCBtYXRjaCBhIHByZWNpc2lvbiBtYWNybywg
dGhlCisgICBwcmVjaXNpb24gaXMgbm90IGNoYW5nZWQuCisKKyAgIFRoZSBmZXNldHByZWMgZnVu
Y3Rpb24gcmV0dXJucyBhIG5vbnplcm8gdmFsdWUgaWYgYW5kIG9ubHkgaWYgdGhlCisgICBhcmd1
bWVudCBtYXRjaGVzIGEgcHJlY2lzaW9uIG1hY3JvICh0aGF0IGlzLCBpZiBhbmQgb25seSBpZiB0
aGUgcmVxdWVzdGVkCisgICBwcmVjaXNpb24gY2FuIGJlIGVzdGFibGlzaGVkKS4gKi8KK19fZmVu
dl9zdGF0aWMgaW5saW5lIGludAorZmVzZXRwcmVjIChpbnQgcHJlYykKK3sKKyAgLyogSW5kaWNh
dGUgc3VjY2Vzcy4gICovCisgIHJldHVybiAxOworfQorCisjZW5kaWYgLyogX19DWUdXSU5fXyAq
LwpkaWZmIC0tZ2l0IGEvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N5cy9mZW52LmggYi9u
ZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvc3lzL2ZlbnYuaAppbmRleCA2YjA4NzkyNjkuLjFj
ZmJlYWFmNCAxMDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N5cy9mZW52
LmgKKysrIGIvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N5cy9mZW52LmgKQEAgLTc3LDQ0
ICs3Nyw0IEBAIGV4dGVybiBjb25zdCBmZW52X3QJKl9mZV9kZmxfZW52OwogI2RlZmluZQlfX21y
c19mcHNyKF9fcikJX19hc20gX192b2xhdGlsZSgibXJzICUwLCBmcHNyIiA6ICI9ciIgKF9fcikp
CiAjZGVmaW5lCV9fbXNyX2Zwc3IoX19yKQlfX2FzbSBfX3ZvbGF0aWxlKCJtc3IgZnBzciwgJTAi
IDogOiAiciIgKF9fcikpCiAKLQotI2lmIF9fQlNEX1ZJU0lCTEUKLQotLyogV2UgY3VycmVudGx5
IHByb3ZpZGUgbm8gZXh0ZXJuYWwgZGVmaW5pdGlvbnMgb2YgdGhlIGZ1bmN0aW9ucyBiZWxvdy4g
Ki8KLQotc3RhdGljIGlubGluZSBpbnQKLWZlZW5hYmxlZXhjZXB0KGludCBfX21hc2spCi17Ci0J
ZmVudl90IF9fb2xkX3IsIF9fbmV3X3I7Ci0KLQlfX21yc19mcGNyKF9fb2xkX3IpOwotCV9fbmV3
X3IgPSBfX29sZF9yIHwgKChfX21hc2sgJiBGRV9BTExfRVhDRVBUKSA8PCBfRlBVU1dfU0hJRlQp
OwotCV9fbXNyX2ZwY3IoX19uZXdfcik7Ci0JcmV0dXJuICgoX19vbGRfciA+PiBfRlBVU1dfU0hJ
RlQpICYgRkVfQUxMX0VYQ0VQVCk7Ci19Ci0KLXN0YXRpYyBpbmxpbmUgaW50Ci1mZWRpc2FibGVl
eGNlcHQoaW50IF9fbWFzaykKLXsKLQlmZW52X3QgX19vbGRfciwgX19uZXdfcjsKLQotCV9fbXJz
X2ZwY3IoX19vbGRfcik7Ci0JX19uZXdfciA9IF9fb2xkX3IgJiB+KChfX21hc2sgJiBGRV9BTExf
RVhDRVBUKSA8PCBfRlBVU1dfU0hJRlQpOwotCV9fbXNyX2ZwY3IoX19uZXdfcik7Ci0JcmV0dXJu
ICgoX19vbGRfciA+PiBfRlBVU1dfU0hJRlQpICYgRkVfQUxMX0VYQ0VQVCk7Ci19Ci0KLXN0YXRp
YyBpbmxpbmUgaW50Ci1mZWdldGV4Y2VwdCh2b2lkKQotewotCWZlbnZfdCBfX3I7Ci0KLQlfX21y
c19mcGNyKF9fcik7Ci0JcmV0dXJuICgoX19yICYgX0VOQUJMRV9NQVNLKSA+PiBfRlBVU1dfU0hJ
RlQpOwotfQotCi0jZW5kaWYgLyogX19CU0RfVklTSUJMRSAqLwotCi0KLQogI2VuZGlmCS8qICFf
RkVOVl9IXyAqLwpkaWZmIC0tZ2l0IGEvbmV3bGliL2xpYm0vbWFjaGluZS9hYXJjaDY0L2ZlbnYu
YyBiL25ld2xpYi9saWJtL21hY2hpbmUvYWFyY2g2NC9mZW52LmMKaW5kZXggM2ZmZTIzNDQxLi44
NmY4Y2Q1YWEgMTAwNjQ0Ci0tLSBhL25ld2xpYi9saWJtL21hY2hpbmUvYWFyY2g2NC9mZW52LmMK
KysrIGIvbmV3bGliL2xpYm0vbWFjaGluZS9hYXJjaDY0L2ZlbnYuYwpAQCAtNTUsMyArNTUsMTAg
QEAgZXh0ZXJuIGlubGluZSBpbnQgZmV1cGRhdGVlbnYoY29uc3QgZmVudl90ICpfX2VudnApOwog
ZXh0ZXJuIGlubGluZSBpbnQgZmVlbmFibGVleGNlcHQoaW50IF9fbWFzayk7CiBleHRlcm4gaW5s
aW5lIGludCBmZWRpc2FibGVleGNlcHQoaW50IF9fbWFzayk7CiBleHRlcm4gaW5saW5lIGludCBm
ZWdldGV4Y2VwdCh2b2lkKTsKKworI2lmIGRlZmluZWQoX19DWUdXSU5fXykKKworZXh0ZXJuIGlu
bGluZSBpbnQgZmVnZXRwcmVjKHZvaWQpOworZXh0ZXJuIGlubGluZSBpbnQgZmVzZXRwcmVjKGlu
dCBwcmVjKTsKKworI2VuZGlmIC8qIENZR1dJTiAqLwpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9mZW52LmMgYi93aW5zdXAvY3lnd2luL2ZlbnYuYwppbmRleCA4MGY3Y2M1MmMuLjE1NThmNzZj
MiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9mZW52LmMKKysrIGIvd2luc3VwL2N5Z3dpbi9m
ZW52LmMKQEAgLTMsMyArMywxMyBAQAogICAgYmVpbmcgY2FsbGVkIGZyb20gbWFpbkNSVFN0YXJ0
dXAgaW4gY3J0MC5vLiAqLwogdm9pZCBfZmVpbml0aWFsaXNlICh2b2lkKQoge30KKworI2lmIGRl
ZmluZWQoX19hYXJjaDY0X18pCisKKyNpbmNsdWRlIDxmZW52Lmg+CisjaW5jbHVkZSA8c3RkZGVm
Lmg+CisKKy8qIF9mZV9ub21hc2tfZW52IGlzIGV4cG9ydGVkIGJ5IGN5Z3dpbi5kaW4gYnV0IG5v
dCB1c2VkIGF0IGFsbCBmb3IgQUFyY2g2NC4gKi8KK2NvbnN0IGZlbnZfdCAqX2ZlX25vbWFza19l
bnYgPSBOVUxMOworCisjZW5kaWYgLyogX19hYXJjaDY0X18gKi8KLS0gCjIuNDkuMC52ZnMuMC4z
Cgo=

--_002_GV4PR83MB0941761524523870C31AC5BD9270AGV4PR83MB0941EURP_--
