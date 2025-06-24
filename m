Return-Path: <SRS0=J7gK=ZH=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070d.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::70d])
	by sourceware.org (Postfix) with ESMTPS id 324ED3858D20
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 19:47:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 324ED3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 324ED3858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::70d
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750794435; cv=pass;
	b=ptlHzM/xHzPFEg/7ki5Wkq4tRu6k0aMJubUV6Y1uNTeq3zYP+uzds5nXsD9YbrEsbm9HYipDHDxiUnVoq2WN+9nA52Qp3frPYvNOnIi/Xx6tu9JbiibmGT+lDZzSpHDS1MHDCufzypNOyW33Gra3Fp8j8Ay3bZrq/2rt3FzC5wk=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750794435; c=relaxed/simple;
	bh=Mc4xG5WG5uBNtvtrDXYDyeFdUcSeerd0vhnJnvuqDEs=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=PjNkjdI/ETntNY50qVScJVoC0/E8KH+aadRolsTJoQ/St9Up4NESrCMXOQQBIC5op4w0YXVxuFI8kHrxMJtwRZ7UYRhEMjmfYqx2G96+zSfrW/a5HbjkKW8ybFJfqr9T/JhiVmVd+S/+OoewDcASzqzvY9MY0K/n6wQqSiv47Qw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 324ED3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=eKIL8V37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZjmw7PXHySj+u3ae8NEKeSWRm1Nkq8Y0P9eLWBuvPfOiM6gaYa1QO+PJ+Wc7ThTkAtV7/ZXyEYB6Y16A9HEulwaJvm9nCl7gHnMNhc2ifiUvOyGEtyNhu6/GBLQrhap1LtNEbZLrbxz2geZ5PhE3nOjdufe/MgNq7RFaIoKaM/42caofYQIsexjDh2rf49o/BQ6ppiNVgBDWgWqrtdVf51gNuBFllWmN5qGqYqc40oPFK22XgNRr4YjK404x6W17T0E0gWOaVEthnXUzFSbjfj16FFxoadZbrldf9OJGExnqEKHFCuRkWZv0iAK/gohVaW/R57YpBf1EtPzLf1Mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoPqe9FTxYOPkUOEQtLgQ7ulllrviN7NGeSEhj2cEqA=;
 b=JCTCxudK3ZHR3i862d5wTWhYPIQbSI8kKEE325Eu7DxgnTfJHWSPBnoXvvQwKgM/g6XBmYVMOwN351X8ri3nsywrxZN2SHRWIlvlkUta326vVWaDXkM7wtSN3Bor3AEUtWlCHvB5Cbitdanynv2MrtcBvUiu0mbU+I1GbUd6NAVqYN+2R6hOYwJbZquwDK6455F9BvskugyB64p2T9HsMBcjZ6WvLFSdRMJxJQJdiVx9PyQWfW4opYl6fX+WJkdm8Cf0DdFj5Q4T4qAzwu/235VuFG8kP2lZlxEfZ50rlwI2DdBRon3h0shA8rvv+nYPgs0owo1LCMoGSSatfxS0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoPqe9FTxYOPkUOEQtLgQ7ulllrviN7NGeSEhj2cEqA=;
 b=eKIL8V37MTF4NV5SpsT9uJrLguTzULAPylQjG/EbLQPOPwXQnOpmiLNRCWQZQtvxnvKgkiixwlmG5VpW4cbABerHTH2AX1KFldEijCvLnUBXPcMSoSf143REu0OemoU2OGD6GR88A9D2VwoeSxZaA2KQ6QHrQiAxJUCH9kTOeAo=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by VI0PR83MB0568.EURPRD83.prod.outlook.com (2603:10a6:800:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.13; Tue, 24 Jun
 2025 19:47:08 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.012; Tue, 24 Jun 2025
 19:47:08 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: define ___CTOR_LIST__  and ___DTOR_LIST__ for AArch64
Thread-Topic: [PATCH] Cygwin: define ___CTOR_LIST__  and ___DTOR_LIST__ for
 AArch64
Thread-Index: AQHb5T54lQzg/zxAI0mRTsLXOET7VQ==
Date: Tue, 24 Jun 2025 19:47:07 +0000
Message-ID:
 <DB9PR83MB09231C714B9D3D3166E455DE9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-24T19:47:05.458Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|VI0PR83MB0568:EE_
x-ms-office365-filtering-correlation-id: 48cd2857-a6bc-4adc-61ce-08ddb357e6bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?N36EpnQ0lKkYa2UY6tdnq4Kxehbi6avIry4u/gt+Ajd9/wbNg7HY2y/QTH?=
 =?iso-8859-2?Q?pbgFKbhHHEDU8B6r2yso/tAMa+P0qSFFvVKkix+kD9ro/ll1p8og/AyUWH?=
 =?iso-8859-2?Q?Pqlv0P2HMpjYBmgpaoDTTVJWnzfidtQEnW2Y6Ln8RTEkThHI0mlpx5dEBu?=
 =?iso-8859-2?Q?oIvGeqMYyXf7kCL3T40jMrKJ7Eg33tj4BQ+R5cl4/93JVkyobXYzwO/pAA?=
 =?iso-8859-2?Q?Wc3MJeLy3U3xUAX7b+dF+DG2LsUpdi7yb6GRckW7WkJb9UzbfIERCpwacj?=
 =?iso-8859-2?Q?Aw4iIRWUOhPvRyPjnJxJ/Y0+ros3fA5MHJk3cCA5x/uZfW1md5YW2fk8Py?=
 =?iso-8859-2?Q?B/FWRDZvAKiEWFPgmiWbvqWkiVDVJRQF517W5H6bYnaY0uWMsFVzXvFWVj?=
 =?iso-8859-2?Q?7DBDSiM69ULttFmIDUDfPBbk+Yjbx0pxteByKzrw0N2CZ14BMHfA5l7u96?=
 =?iso-8859-2?Q?T7rq06cANGa0dR4Vb7oHudIwAA/LIeiFYOBd1oucVSnH5mC6x48tQyi2Jc?=
 =?iso-8859-2?Q?eswHX04FpfTqmsUGXp763WwN83CMGSN1ALTTZQd2dJDS2p5/o4JMKqw1nY?=
 =?iso-8859-2?Q?LdN+H7980o14V5yG1gYFd57hW+lkkD+BHlZaiu6X1avcQHf0MN8Zu2qstB?=
 =?iso-8859-2?Q?IdOpL4Br82QVgnz1mXe+DnSUUyBraLIL6kMR7SWA+5iJ8Q6F9yxACdV70e?=
 =?iso-8859-2?Q?zAjBMT+W7QL7iI15OW3qLHNk0V1xbVOw45oeiZF4A/GI+YHft3ImSKHW8s?=
 =?iso-8859-2?Q?n+Lw1Qs2fvf5/gdoY/LcYmilgAgyAWWW8t3PhLGXKbN3+YLNHxYDwytpNx?=
 =?iso-8859-2?Q?XfpoBlrDt675s17HM50iwM5pLwc5tMgQVh7DrZe+VrETebbXFQ3C+ng4gn?=
 =?iso-8859-2?Q?TDL6e6tGoOtliSdK7AsuwFq1K0dOdP6D9yk6tRmzAQtTYrQRwq/VQrbZ5E?=
 =?iso-8859-2?Q?5xAs7nQg0HN5xF5EPf5/8exeQD2V2lKcf0eB/Yfo9EeuKGnd8ZDp8r88zO?=
 =?iso-8859-2?Q?GA9iJIkz2R5ne6mSjWWQqGQMftUyQazvMJbxZkkZ4Z2dhXGoXk/9x4XBsI?=
 =?iso-8859-2?Q?kbaKxYPC5mzKFpmc2TEsH0ncl9U3SkMbGnG0hx1B08QT+Qt72nOXb5wMR4?=
 =?iso-8859-2?Q?9ht96oBhMgTtwwaJWjwQK8N7NghVmSxKBXtvhFNT4gPb8rtFRZ89UMKCvw?=
 =?iso-8859-2?Q?JrCCv0soehRsYhEbFnrt5q4/PMxWdMK2CmIEfrvyVOez8xvb/5y5XexJfX?=
 =?iso-8859-2?Q?7AiQC4osaY2q9gP+pDEGDzwA2BGQ+CjrBr5bRoJ3fQEKhkpp76enb1y1nL?=
 =?iso-8859-2?Q?lEpn12blKBGXHae/ZU84Xjn2GFaO7uRxAl9edWfEoKziQ1Yg6HF3GF0zgm?=
 =?iso-8859-2?Q?bKXTEeNHxiTwBx9ZTQRh/VPHMNCNY/ZAhglj7ejMYe11Of/+A5WPoQ6qrX?=
 =?iso-8859-2?Q?d1F0Qc7q7+Vxvyz2wJjSGvzipgziHHGIwoa1BhXAZIQ9PUgm8sCOG2Tiqt?=
 =?iso-8859-2?Q?xy/3+/a5PjWHMVB9g+c/kGjCNNcDa/Qgct74xa7+0GKXb86EOFO6qLSoAS?=
 =?iso-8859-2?Q?B4chBGA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?YkiYRBFKcyIqfkFvrVTzzmxXkKpD0B99YE2g/SVSjEku1Sd46l7T10PyET?=
 =?iso-8859-2?Q?+AaSE3UUKMyiYIxzeiN+8uBsJ10erdiMeL+q9nBtn3eQPPUVWwlqH44uKr?=
 =?iso-8859-2?Q?yr1kGeC2yFJ5rcWRNhN24zAXShLgnIDR9l5W/L4Ki2q8N41lJKuqLr9S0f?=
 =?iso-8859-2?Q?Cq4MXlGQcZNSY83WwSOxXfNBEevpUjgslEo+K6fqfBRPYMVta7cBJoJ3ep?=
 =?iso-8859-2?Q?IGucgADQCPFbXTb6tBwf3AP0tOZTIWsB25wOizZXD7Z8NvU9WT3iQGXfCp?=
 =?iso-8859-2?Q?NxD61yrrALQ3M0M32lOxNlQU/Hj/M5j7AZYZ8K/AbfNJRWm2j2/8g1MKHq?=
 =?iso-8859-2?Q?EpEagNl6b0eMcm4pgeFiyz7BCbT4sIDZFUjUBgDS5yGX8RcIoJw1dN8+Dd?=
 =?iso-8859-2?Q?LurDOfUcRxy0rZ77ag4QY1T/CGO7GAnTru+ETzIzM8SbPwMK3MNw4kZDoq?=
 =?iso-8859-2?Q?rn3OLKFl/AOhj0OWj/7g1l6fGGnc/LN06zPiD1Rd7NRh4QHU4jbKkG9G80?=
 =?iso-8859-2?Q?27iDUNU+mNAqnrGd4PClD8lig3qh/8pBCZ02qOPXKc7uTLquT8hCWqSQBJ?=
 =?iso-8859-2?Q?QUcNZIIRjlOyFXhcSyOkfkXL2pnoCtTWJ5n4nKhmTZwZaafOHINoNWeaz/?=
 =?iso-8859-2?Q?FKUewUgBaEdBLo59oLcUo0fsOh43g4AP46ZHBCt0lXmanSM3fH4FmjhjGP?=
 =?iso-8859-2?Q?kcOczx0RyRd7VQVsTNMNYW+ieiz3/6/Kvdrn8g8NmxfFginOhx0UNMP3ox?=
 =?iso-8859-2?Q?jPH7t6Zc3HuGLHKjswq6BuMCVOKOqmShgPss2sEOtTm81/ceQYhetRVAFi?=
 =?iso-8859-2?Q?/MHvCBN2Ry9UYYlSvcBAGFBL/c9LNAUlSmtT/2nfGv+fSkLhMgdPYbQpbP?=
 =?iso-8859-2?Q?GBiUQOziRqtg0VvvZUHJHuqsIxhD3vKxXtsuLWK0ZXaBtIK8NvL+fA/VAw?=
 =?iso-8859-2?Q?V9FG0Mt7KMvYaW1OSyv19MOYSUnUzP7TjizXuibE0lZGa7ztoXbzV7dZqL?=
 =?iso-8859-2?Q?yUyWwRO1nqVazOgCV1Sz/F1Z/MngzlyOhhJqJXv7cNatU8MnhQBIx3fogt?=
 =?iso-8859-2?Q?ODw9Y4QFtgKslGtkLVoKdVNYzMIuSCYW/09k0v1Z1PhKwaIVKep1lQPkkD?=
 =?iso-8859-2?Q?ruOLD6Ks00Ei2hZWpI3WeXcHEe6EmC+h7HdvGTkfEdNJuPOmOmJqN0YLaw?=
 =?iso-8859-2?Q?jOcTC61S8x62r9ohilmB+qsHv5OzbUim7Rh+9VLugojosfym8+KryLW3ro?=
 =?iso-8859-2?Q?SSMjikDyVAPjgYk9pEBzvOKFMtHETqPmrs6GNR+jExa5XXoS/d3lhXGIdM?=
 =?iso-8859-2?Q?bjkyHHT7rPcOWsIUjD1PlzArU/QCZTTnS3dayoRUxLam3ChWwpOsd0T1CM?=
 =?iso-8859-2?Q?PU6t7hjm105a+IzSkA2qqnAcoivlQdn/irwSJMxNnggOKqOPjNzwPzbEOg?=
 =?iso-8859-2?Q?1Dl9eLg7sYklUa5jVNt99cF3lF12QdtrnAc9OqRqeE8EAAcgVIWn0iRPaO?=
 =?iso-8859-2?Q?GIsy+xOtHY19L8NltJ+mC4ODwnENjhZbh1YDIlGFJ0FGk5YAI130qx4xlr?=
 =?iso-8859-2?Q?IkZy8euO/+aMBkp0pJIyNBVaPnXN?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09231C714B9D3D3166E455DE9278ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cd2857-a6bc-4adc-61ce-08ddb357e6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 19:47:07.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eamkJpzosW6xTHw4xbKuhFive0t9NrvI4PLahLqrCKu19Oa9yiQAt+LTtJ3rDZLReyt/ge9yHc+xyedUriVTo7fq27DpJYvFVDljxBy1hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0568
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09231C714B9D3D3166E455DE9278ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This change defines  `___CTOR_LIST__`  and `___DTOR_LIST__` for AArch64 in =
the same way as for x86_x64 as AArch64 uses `pei-aarch64-little` and x86_x6=
4 uses `pei-x86-64` COFF formats, which both are defined at https://github.=
com/Windows-on-ARM-Experiments/binutils-woarm64/blob/woarm64/ld/scripttempl=
/pep.sc#L159 resp. https://github.com/Windows-on-ARM-Experiments/binutils-w=
oarm64/blob/woarm64/ld/emultempl/pep.em.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 1dc5dbeb5e8b9f2783ceddc7dcf227bc7b922e08 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Fri, 6 Jun 2025 14:12:28 +0200=0A=
Subject: [PATCH] Cygwin: define ___CTOR_LIST__  and ___DTOR_LIST__ for AArc=
h64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/cygwin.sc.in | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in=0A=
index 69526f5d8..5007a3694 100644=0A=
--- a/winsup/cygwin/cygwin.sc.in=0A=
+++ b/winsup/cygwin/cygwin.sc.in=0A=
@@ -17,7 +17,7 @@ SECTIONS=0A=
     *(SORT(.text$*))=0A=
     *(.glue_7t)=0A=
     *(.glue_7)=0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__) || defined(__aarch64__)=0A=
     . =3D ALIGN(8);=0A=
      ___CTOR_LIST__ =3D .; __CTOR_LIST__ =3D .;=0A=
 			LONG (-1); LONG (-1); *(SORT(.ctors.*)); *(.ctors); *(.ctor); LONG (0);=
 LONG (0);=0A=
-- =0A=
2.49.0.vfs.0.4                  =

--_002_DB9PR83MB09231C714B9D3D3166E455DE9278ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-define-___CTOR_LIST__-and-___DTOR_LIST__-for-AArch64.patch"
Content-Description:
 0001-Cygwin-define-___CTOR_LIST__-and-___DTOR_LIST__-for-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-define-___CTOR_LIST__-and-___DTOR_LIST__-for-AArch64.patch";
	size=979; creation-date="Tue, 24 Jun 2025 19:31:11 GMT";
	modification-date="Tue, 24 Jun 2025 19:31:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxZGM1ZGJlYjVlOGI5ZjI3ODNjZWRkYzdkY2YyMjdiYzdiOTIyZTA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogRnJpLCA2IEp1biAyMDI1IDE0OjEyOjI4ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBkZWZpbmUgX19fQ1RPUl9MSVNUX18gIGFuZCBf
X19EVE9SX0xJU1RfXyBmb3IgQUFyY2g2NApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6
IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJp
dAoKU2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5j
b20+Ci0tLQogd2luc3VwL2N5Z3dpbi9jeWd3aW4uc2MuaW4gfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL2N5Z3dpbi5zYy5pbiBiL3dpbnN1cC9jeWd3aW4vY3lnd2luLnNjLmluCmluZGV4IDY5NTI2
ZjVkOC4uNTAwN2EzNjk0IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2N5Z3dpbi5zYy5pbgor
KysgYi93aW5zdXAvY3lnd2luL2N5Z3dpbi5zYy5pbgpAQCAtMTcsNyArMTcsNyBAQCBTRUNUSU9O
UwogICAgICooU09SVCgudGV4dCQqKSkKICAgICAqKC5nbHVlXzd0KQogICAgICooLmdsdWVfNykK
LSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKSB8fCBkZWZpbmVkKF9f
YWFyY2g2NF9fKQogICAgIC4gPSBBTElHTig4KTsKICAgICAgX19fQ1RPUl9MSVNUX18gPSAuOyBf
X0NUT1JfTElTVF9fID0gLjsKIAkJCUxPTkcgKC0xKTsgTE9ORyAoLTEpOyAqKFNPUlQoLmN0b3Jz
LiopKTsgKiguY3RvcnMpOyAqKC5jdG9yKTsgTE9ORyAoMCk7IExPTkcgKDApOwotLSAKMi40OS4w
LnZmcy4wLjQKCg==

--_002_DB9PR83MB09231C714B9D3D3166E455DE9278ADB9PR83MB0923EURP_--
