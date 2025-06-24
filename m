Return-Path: <SRS0=J7gK=ZH=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20705.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::705])
	by sourceware.org (Postfix) with ESMTPS id D5ABB3858D20
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 19:49:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D5ABB3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D5ABB3858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::705
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750794585; cv=pass;
	b=x4sYv517zf5AFFRnt+IGlnak3ebDl+c4z1dyK/cTyRVGZgHV6Iuo22NqQAap88VV0QBLsaUQKxdOu1cQ8O9IpS5h/bMvehYuXuuWo4lc9rf1isrdFkFzGQJME4C8Y9upc5YO2AKeyYreq8YGpIieegRwfnfmET4ECpacYQe+ymM=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750794585; c=relaxed/simple;
	bh=MAsRIWNYqv1JiMgVK4QSFOzrpgY+OsC9h98zDxnt1rs=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=oWI7YwA5WnmiI6Q0XH6iykEChb5v1q0xqGHaZO2ULxz1Zb6kMkwvk9BdNu4dhrdXqPezXBiZmDggJ2hCBtcZToTBlRAPWRqHXsueZQOeWiarvi+fBn+RjZ4ZxqJy8F/YIkrIrD1HO2ipycsit0HdLIKpsbdrgAQyjARa87XWuiI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D5ABB3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=g51QY4CW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soPUo2kOOVMwSZmcfq4BcWGqAMYn8US+fgIKjKadoPiORgJnBbF7f+Kt1fJBFRg9QoPJCzOU+yMzMvZEQuwGms2j74i5/j/Bqj2f5IAOhrJILx5BMJ8HUu5XHRlqCUGaiiNOwRrvMhP+zNW6dLmk58Prdv3Ms96jZe0TgciZE8Wa81Jx4SdaPxKuLztTLl6HwGBkunN2Bl7UYlvaHWdAkGKRKV/7Sy11mMbp337HFabVvtWiRMSIBE0YPZeivNfbqOwXtSTEmloWwsmmIp9FKL6k41XUq6znHnXvGDP9nMXmMg/H7+JiIXK0GlPHOOjGDi8SzmkUC+KHzoafrcXAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE+DQNa02RRKG0B7F3hnhH6wx4WBcFIeBt2gqjNigv0=;
 b=XRsTB4iuwzmtqQedOl5Lmj8O5bZgmO6iMSVuN27SnJpZJExtpqDyMG8vw3rt1IO/B34Ni4id6a+kB3tvHz1tHeuBPNifolRcYRkOfwL3i1LsE9u+bOdqUm44bL7ElbfSn2uk1ssRUNCTEVTqEnUdY5buTAH/2sW6dqXLdOAY6CbZE8wiyudMoGgZhLW4U8IgwGQ/IfCLNja9AiZA23AjPbtn1s73EByFiqrISD6f5S6/5ZOmRVEe9XsSJ1hFVkT8MvHqMGrcaNTgj+OAyt1DmP+CF/7KAUpJn1ZGuirN5Jw+fO3Jae+GNTFltGorw3ZL0EFKW1bL2TWyljW/cqJclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE+DQNa02RRKG0B7F3hnhH6wx4WBcFIeBt2gqjNigv0=;
 b=g51QY4CWvsCMFnjUv6NSdkjwAJax1KrxUuigRv8PeA1bJ3ExiwlO+L3/jYUfxyYtfZ6bIgokP6mMssomL03pvXazpua/z0EOff1e5I0LRVTR7Xy5UHfpmaUgNaMAk6+JcYRIOjzvha1ouGFP7MZ3YtlWRl47KfjUf7XY5b9Nxgg=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by VI0PR83MB0568.EURPRD83.prod.outlook.com (2603:10a6:800:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.13; Tue, 24 Jun
 2025 19:49:40 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.012; Tue, 24 Jun 2025
 19:49:40 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Thread-Topic: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Thread-Index: AQHb5UDckVtgDmjjTkWd5emeZDaynA==
Date: Tue, 24 Jun 2025 19:49:40 +0000
Message-ID:
 <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-24T19:49:38.867Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|VI0PR83MB0568:EE_
x-ms-office365-filtering-correlation-id: c460843a-1616-4cb7-9593-08ddb3584212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?MHaPJokKWZ0xZC57205sJQqAGVIrzAEAfwDdy9h/epS5cY90SXPfLdXO1B?=
 =?iso-8859-2?Q?7nl0+WJbKpG9sb38zVucddSw1NnVK3ftufp9CJL+hAJz2qeFJNZSnMtF9G?=
 =?iso-8859-2?Q?gjojAlDj8aZzg0jBjltlm+r4imAmKEVYAtYxUdINmakR3amjqTGYDi1Y0C?=
 =?iso-8859-2?Q?GPQqj4mefGCLTqB8rS0YaORdQW3b173N0xjJnPJpp0PB3QjmCIqrAREdVP?=
 =?iso-8859-2?Q?Y9hqHirkVos/nyG2qgu8LTGs2llkkUbGLdDN13zOzhSxf6u+VSco4CzTm7?=
 =?iso-8859-2?Q?dYfI7aIxW075aXP6kkGRFGQxyFd0Nd3rqVATPLjaV7/ykyiD4WDyx/vxqh?=
 =?iso-8859-2?Q?QCKH38Mf9HSVPBZEe9QRWIlY5PcHcraqIhYAu7QPYDNG8AIUIQu688/J3J?=
 =?iso-8859-2?Q?JQYB4jPcMeh3mJtn4QUBE1QDIj7UPQ8b8NYygJQ/XMqKTgPqCYVl6kbbZP?=
 =?iso-8859-2?Q?oTZgDXU0ACmGHoNoAQjpteX35PkxSVXNr9aXcTeUsS7pd3qu8hKwWO9HQ5?=
 =?iso-8859-2?Q?1rX5u1SJRmf1n2AvLKjIo0H/U21mgFwQn/11JfozYWSXlSSDeLlhnpgNAZ?=
 =?iso-8859-2?Q?1kktZCQLbffJdYjZ4JbGQMThzlycTFJEwxXj4wx2O0vE1RJXwOTe9bXr7d?=
 =?iso-8859-2?Q?9zts7j6QqDNXAwuAdGrppg41sD7lQJyVADIIUvzXX9OQEqbK8jy/f4mzla?=
 =?iso-8859-2?Q?fHnaqwcPG1hdkClfKKv+ZJ+vvoA12y6ra081t28+gyXorKZe4kVFwHQmma?=
 =?iso-8859-2?Q?3ZJ+R6pKdF5CeqKmaSSyfSYU5BwuaLapApuE+V329HX9b1IXuBvXtb4D/I?=
 =?iso-8859-2?Q?pIDp1pSzTjV0Sf/V9T4fB3xjyIk5WJpvn0dyjQ2o186W+pFJjjzv4Kb2u3?=
 =?iso-8859-2?Q?xocxt2h3ERGtagvBpWCG3/QGfzb4efD+QSYTtG5kMsbQQm+00pydrchrX4?=
 =?iso-8859-2?Q?Yfq54LTMM154nXh18zBTgWZxy/E2Cz3ZX6+F2npy5HMFqamwGvB1rT5yRI?=
 =?iso-8859-2?Q?SyghwuRfq8LO04Hi4wq2vsV/kfJO5Opu5B0+UqiVleI0cw5T8chQQXPXdY?=
 =?iso-8859-2?Q?B0U5UYcK+IEizAl0wDVQ07RzrZu/ETbrRpG2Ysc/IA+Nsz3B753g4cXS27?=
 =?iso-8859-2?Q?qlkkt+ghJv5PQPJrNh2nAqljpRnQEUy5rYJyo50SIFbmmRmBF1jDXG+lMB?=
 =?iso-8859-2?Q?6Qe1q63tOqdF/ouvyXKE5J056TXCVSfdb91D8K/RJYTfghcBydeQQ4IPgH?=
 =?iso-8859-2?Q?mbqRzMtXfvyysATE35eZe7gaB4/FAmzuLATuMYFf5LnxP9KhyTlaBPqtbt?=
 =?iso-8859-2?Q?HdJ+jcD+g3gG5oBhgYj7RqEEqv6kKv0jUlupV94cCQ2eyDPafdA+3ZC3kx?=
 =?iso-8859-2?Q?EAiW2AP2UcScK80PuH6isnfTY2jC2RZSHkJtm6jSJJaH8wC5RxmKP+Rzln?=
 =?iso-8859-2?Q?9TvPuWGS472evlzj7EKbGtdL/eqkuxrm6CfbcKpNYz9/uVQynAR5joxbKd?=
 =?iso-8859-2?Q?67lol2dVmaF+e8/BMC9TwiOusbJ11FDs7F+8Z4dFm9eny40d+wduzKbDKs?=
 =?iso-8859-2?Q?ZQ25NAM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?w6BLLJr9AseFCEmFwK78+J1Pw5HloWMinErJcJrbxpoeFkd02rqhLmoVBr?=
 =?iso-8859-2?Q?2lhBJSxjdvdS+PwvIbbHydGaZHopDsehcSjRJwZ2zTmyuEjOKGiG1F6zSv?=
 =?iso-8859-2?Q?AgFyasGOZdCKsCYGP3ByAC5sKjvGN9f+jvWljBjr6jernL9ap4jkuo5gwe?=
 =?iso-8859-2?Q?nv4ETJ7TBDfEilMQCBJopbTj/LECkvTReArbGah+gNFLksFr4s1bYztWut?=
 =?iso-8859-2?Q?QN4MqmR5wK6Zhr9OBVDD6gJ/RXpugdiI0ZFwtF27dGYHaD1oY7I2ocFDI1?=
 =?iso-8859-2?Q?NZ78J9qJ66q78wYlIFP+tnee/F47IIOhMQp3GISJ5lbU0ikO5ZVRUpAEfP?=
 =?iso-8859-2?Q?VbnAXtKyq1tH6J8jhz3iqvISk7UVPr6wF1CdYSUUxvCUUEUYP/b6iJkVE6?=
 =?iso-8859-2?Q?VCTshb8fLTm16kuFcNJZs6qwTBLlKVO5VRSfv5KgqrvMGa3O5ODzqTXXzg?=
 =?iso-8859-2?Q?Trv3goDaauR2hcZ4KFOo7vRZs22qmrtJ8UCgo1jg3NhKUX3XD22SS9/S5K?=
 =?iso-8859-2?Q?OI5IYgm+mshvF+QpQrqMk3NyRkgLOEdUnoPoGc8EongHS5DSF8iXReMwNB?=
 =?iso-8859-2?Q?7i86mrNleOqKFi2q+9ViNUAnoQI1l+unxqZE9H3aKks8TnbJmLUFXcEznf?=
 =?iso-8859-2?Q?+zVHIGz28qChr2a5LSKiPtFGpRmIyp61/qUq8hNpk+pk/f6gOeFwUI+HV0?=
 =?iso-8859-2?Q?ci4pES6/44qie+hgIC3/BPrSJjl4jLMtkVX8MsISo2kTaxMj0cAX1/qY/T?=
 =?iso-8859-2?Q?a8DK6z9pDpYUSixo4hFXLyupNh4BcMWT+8DsvdovSyM9bbRyS258bjU+3m?=
 =?iso-8859-2?Q?s3H+53ZLFt2w8ciKVvwZd7peN4DgaELXK0GdHGaZSDcrQCLVyvfaBx08fl?=
 =?iso-8859-2?Q?NgpzIQNosK4rYUCNRHs0vHoBklMfIdIlimKFyO1TwOiW+MfKS4XSvymOjz?=
 =?iso-8859-2?Q?oJR+5GxsKtWazn/yoho9DilhkSc9XPB6I89cH9jc+qZT2+LMq+dQeU1v2d?=
 =?iso-8859-2?Q?ME/4XdkxJg3qiNYsSJ3I2UgIIk6AcaBX8PXIaf+FjzRlp63RQ7KoE/pLO9?=
 =?iso-8859-2?Q?djhp7PZTZqLH4RJfEweUCHeutJGun36buzcccYYLry3mN6o/Sw2H02PDQ2?=
 =?iso-8859-2?Q?oTIkGLjvpbpva1J3bipmTWC100DYXnNHn71KP6G0n+7P39ybY2yzNjlucR?=
 =?iso-8859-2?Q?Y+2jmvJ5PqizthkeVEKWMzOzTd8P9ZiNsGZcQ+wD74f6WmgZSTf0HQBjOa?=
 =?iso-8859-2?Q?S56xRPoe923hB1N4bg1268sat73qhnlHvdfW9ufkuujVVzo9NHy1a468tL?=
 =?iso-8859-2?Q?RA3clpTwK40aBlgzUbpBCt8Tv/KBqV8afOQ22Aea/DOW0VptLaCh/gvq1w?=
 =?iso-8859-2?Q?+jHrxlTUVcrZf7BdP/CWdiaL2AUvOHvhtgYF9aQunT3nHpeMS6CDKPiEWP?=
 =?iso-8859-2?Q?cdA9TjfeC61xlppq1jsN65Wazl3wV3bNnTu/1NhivYVefeYOTiAJbXdEmt?=
 =?iso-8859-2?Q?SrB2D4TIUywGRpaSp2BA6MKmA5Xy1Xz+DTGcrWqf9hR8Xw/6xf+o8MITle?=
 =?iso-8859-2?Q?wZ/DMMHhBZ4095ywmbKI71e9dknj?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923BA573EA5101074C2F0B79278ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c460843a-1616-4cb7-9593-08ddb3584212
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 19:49:40.3111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynEEMKPQ9RjsjVE9BOhdQmOlsAkBPggDLGCTSw477850cJs6FUTSVqNfe3Go11ggGUDdsvRm8KekvGlxuTPd/VAdbLC9Hu5uJs3pI3dl4pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0568
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923BA573EA5101074C2F0B79278ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This change defines `OUTPUT_FORMAT` and `SEARCH_DIR` in `winsup/cygwin/cygw=
in.sc.in` file for AArch64.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 420a2c9bd13c338c037e583b663ccdabf4c02cd4 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Fri, 6 Jun 2025 14:13:16 +0200=0A=
Subject: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/cygwin.sc.in | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in=0A=
index 5007a3694..3322810cc 100644=0A=
--- a/winsup/cygwin/cygwin.sc.in=0A=
+++ b/winsup/cygwin/cygwin.sc.in=0A=
@@ -1,6 +1,9 @@=0A=
 #ifdef __x86_64__=0A=
 OUTPUT_FORMAT(pei-x86-64)=0A=
 SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=3D/usr/lib/w3=
2api");=0A=
+#elif __aarch64__=0A=
+OUTPUT_FORMAT(pei-aarch64-little)=0A=
+SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api"); SEARCH_DIR("=3D/usr/lib/w=
32api");=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
-- =0A=
2.49.0.vfs.0.4=0A=
=0A=

--_002_DB9PR83MB0923BA573EA5101074C2F0B79278ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-define-OUTPUT_FORMAT-and-SEARCH_DIR-for-AArch64.patch"
Content-Description:
 0001-Cygwin-define-OUTPUT_FORMAT-and-SEARCH_DIR-for-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-define-OUTPUT_FORMAT-and-SEARCH_DIR-for-AArch64.patch";
	size=992; creation-date="Tue, 24 Jun 2025 19:48:19 GMT";
	modification-date="Tue, 24 Jun 2025 19:48:19 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MjBhMmM5YmQxM2MzMzhjMDM3ZTU4M2I2NjNjY2RhYmY0YzAyY2Q0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogRnJpLCA2IEp1biAyMDI1IDE0OjEzOjE2ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBkZWZpbmUgT1VUUFVUX0ZPUk1BVCBhbmQgU0VB
UkNIX0RJUiBmb3IgQUFyY2g2NApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQv
cGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKU2ln
bmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+Ci0t
LQogd2luc3VwL2N5Z3dpbi9jeWd3aW4uc2MuaW4gfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vY3lnd2luLnNjLmluIGIv
d2luc3VwL2N5Z3dpbi9jeWd3aW4uc2MuaW4KaW5kZXggNTAwN2EzNjk0Li4zMzIyODEwY2MgMTAw
NjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vY3lnd2luLnNjLmluCisrKyBiL3dpbnN1cC9jeWd3aW4v
Y3lnd2luLnNjLmluCkBAIC0xLDYgKzEsOSBAQAogI2lmZGVmIF9feDg2XzY0X18KIE9VVFBVVF9G
T1JNQVQocGVpLXg4Ni02NCkKIFNFQVJDSF9ESVIoIi91c3IveDg2XzY0LXBjLWN5Z3dpbi9saWIv
dzMyYXBpIik7IFNFQVJDSF9ESVIoIj0vdXNyL2xpYi93MzJhcGkiKTsKKyNlbGlmIF9fYWFyY2g2
NF9fCitPVVRQVVRfRk9STUFUKHBlaS1hYXJjaDY0LWxpdHRsZSkKK1NFQVJDSF9ESVIoIi91c3Iv
YWFyY2g2NC1wYy1jeWd3aW4vbGliL3czMmFwaSIpOyBTRUFSQ0hfRElSKCI9L3Vzci9saWIvdzMy
YXBpIik7CiAjZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CiAjZW5k
aWYKLS0gCjIuNDkuMC52ZnMuMC40Cgo=

--_002_DB9PR83MB0923BA573EA5101074C2F0B79278ADB9PR83MB0923EURP_--
