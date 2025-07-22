Return-Path: <SRS0=7K4E=2D=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::701])
	by sourceware.org (Postfix) with ESMTPS id 2F0EA385C6FF
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 07:44:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2F0EA385C6FF
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2F0EA385C6FF
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::701
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753170268; cv=pass;
	b=n5FmnJML6dlrjuMkNnM8GvHSd/OSXjEYUVPBUtFDAEXLNhCrtXDW+9No1QrnyqZhydmsXb3UpwhzMAcV9BEnPoHbkJdr5GTGt1AjNngVHuRQCQrri3+1ur/JBjqgInOIGCm+Y2RPyvXspxT/UqiW1T4c+L7e4B7oCrlTEd/9mrw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753170268; c=relaxed/simple;
	bh=fS7um45tyvOQOZT3T+rGpfA5osxNR4Csgd8legsfznk=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=iOmtFxnlypmf1GYt1vYxMzLw/WgHwLd3+z3ATUYDx/f2sGjyIEF+WptkaAi6EM3rro2q758GCrL5AtNNAI7RsHxcBV/I9WBDg2YRB46kvtNNEAfARL0FTJ/0p9pK/kGQgu3G5P2Yx+PEz1R9IyuRVipc3QaP7oyF3zHA21dI5s0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2F0EA385C6FF
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=LHOdlqjv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJXdz7Nm5Xra8dcR4bSFevKXbKqDktEec6ln4lbwBD/wWI11pWCn7+igFe+K9WWGSU12GBKDlKkBn5dY/RIY7Yc1EsDHefKQKP0VT4ktfTYH4aa6C0m4AuMkzCJjojWSlO1mEhenvaRd49jHg1tbyJDCq5pB+6ASnvdvXAtWcmuBvghvnZo8bR4GQkzXeqY4Fhd9x8PFberbSEbazSr4WG2wBrO3BfDa02tTSzN2fvJv69Win2kLhCI3n4cJBkSKyKBpf1Hft0UrYuj8LVvZv5fIlzbni3bzeWrrTwIbEWmDtjFmBtRAdzTC5a0dOVbTuHWWUZvFlQ9ZLm82ZET6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS7um45tyvOQOZT3T+rGpfA5osxNR4Csgd8legsfznk=;
 b=b/hpXb3HKfEHVWw86FsNwLJBD3IITFoshNzXULKhuBnEKcWWJYygRc3GrWb5EfR8CUIjplKP+hEBq7QrzRPj2r7SLU2PUpdQFVtzpvo1EKx3MsImRDGQkdJxL4IBIu7cfxhcafHZ8/joc2kXPeA55HFa1KAgEm+HXs8anJDS0UZ/HQllBN9cZ3pIGlimXREXzH3WEFwIn+J7cOhS/dTxmWyTMZmeDj3+3Af2WczX+QTksvsOT2plQYMLk0QTgBqpXohhJ8kZ4N1q7KgwdDyTtgt4w5R4IjLA8vOz2mvUNNSfX5bYa3iU41wRRZ92oB8iFuJv0jYGZKInjgwRLVIGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS7um45tyvOQOZT3T+rGpfA5osxNR4Csgd8legsfznk=;
 b=LHOdlqjvTHeFtr0a92R7623tdFKS5J2jyM4yO1nTeS4isC21kYY49mZqTiQxy2On+ezFU75ojWje5VvPPdTYUXBjtrdnbO6JNzZ2DJF5PyqROOQQEySshZm0BgnKfvhV+t/X2Wro78p7edZPwK8Ko1NU0kO25VfEt2fGTL13wLQ=
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com (2603:10a6:150:27e::22)
 by PA1PR83MB0686.EURPRD83.prod.outlook.com (2603:10a6:102:447::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.15; Tue, 22 Jul
 2025 07:44:25 +0000
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a]) by GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a%3]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 07:44:25 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Jeremy Drake
	<cygwin@jdrake.com>
Subject: Re: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Topic: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Index: AQHb+txxbc5KthQQjUOqbt8Hxemkvw==
Date: Tue, 22 Jul 2025 07:44:24 +0000
Message-ID:
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
In-Reply-To: <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV4PR83MB0941:EE_|PA1PR83MB0686:EE_
x-ms-office365-filtering-correlation-id: 2b7668a2-d4bf-413c-5ea9-08ddc8f3946d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dA63VkwXRkPnRc2qyv0AOCKMzOeKe7vDgQ7G/LzDmxq5HYcbfYBfs+8oHA?=
 =?iso-8859-1?Q?axRZnp3I4PZW6Cr2JcwjY7QufGlaWDffWQQaKKVFye9na+JPyJU7y+8Myj?=
 =?iso-8859-1?Q?saSVPjAc9XJZYrtNhFdyC79JadsGYQOHvDh0cYkoxfZ2CjxuwZZQ7CwEbO?=
 =?iso-8859-1?Q?SMnxl4soSxr4tIKCam7eDGg1xXaZiAedcNpbEJ77T+ca7gf+O2wiTq5BS3?=
 =?iso-8859-1?Q?pieLKuODZ+cWDBrOs7l/Rw01ndWzblf+5creav9D0SPaIoCldMHKVZff/O?=
 =?iso-8859-1?Q?7tyRV8QL9FAjA+etvVCHoX+QryHBtxKdl3jGtaSv8nlfh+6ppcJl7nssTm?=
 =?iso-8859-1?Q?cK5Q746WJeIKlURGai9gghhOFxdV1WlMuIv5ReZBCVAfWePRoe5Aywy0d+?=
 =?iso-8859-1?Q?uMOiciC0s09oLYi3mHL74+BB25/mqVl/bUQiFrVVf/CTniY1Sg2bLRvZTZ?=
 =?iso-8859-1?Q?LsBCJS7q6kEWa3YfhFcNcYf9B2PGIchPlZ9V4XsAkHDGPSVgbPmp3xbZdb?=
 =?iso-8859-1?Q?+Gazz+F8PaReLie9fFCSBuNIR+Ayqu6cEkNLFisdAv+J3j+W7Xjz+rObq2?=
 =?iso-8859-1?Q?wGaWbR8ktgfY9wAulT3k1dV33Y3Saeo8ZPC0jTknqtX/6FYAhWo3u+kynn?=
 =?iso-8859-1?Q?R6weUo6b9k5C4oEqminu8trteGcXD0CZ3RhJxCHzMoVvJgdjYjGHp6wE9P?=
 =?iso-8859-1?Q?vcUi9e1Seu8lKNiej50ATxuTe+pnUzKPhl9U3pUx+dn13Xvk23dO0UD26C?=
 =?iso-8859-1?Q?UO8bzuMRiO2QD17nrngs5uQNxb1Qjn0T7cePnJ9u+qspaqvNVOM5c5K8KL?=
 =?iso-8859-1?Q?H2EzsL4rPuw4mZNmv7Hx8KKlLpuAAclxpr3AgPSnn3AfwmcUpFrndcNXtx?=
 =?iso-8859-1?Q?mXyAqQcYjtfhSaGksVRcGwww4Bq2cBiIqWRrRhwJLHf7HOqr0UymnEj79d?=
 =?iso-8859-1?Q?IbX8O2pomS8SPQdLyVx0XUPPKoAiIwD9w8u+Ael69b9wr74Wg7ceSUJ//K?=
 =?iso-8859-1?Q?w3ZeVw0b2bkaNvewpLHvJWGEwEJOE+2Wshi1z+ttQoDP94tkrMyi4Js2m5?=
 =?iso-8859-1?Q?YrJuetb6djK5N7TUS6LmBTHqasEjLWVhxt+fOI0Nwenq4LM2pR4UcQZdcd?=
 =?iso-8859-1?Q?Bd9cD9m+89TVtS+52UtmyuQGaafiN8c417vO3iRA/Ez6B+uOnt+6gtirrp?=
 =?iso-8859-1?Q?Wf0xqpZdhAsSjZ2wWybGu0/WlGjdCvvxcuKU4QeW8hLs+makUFP+drWoWZ?=
 =?iso-8859-1?Q?YdTihYtHE6Wbn99DNRjWyk+b7dNl7EJFT+AJ/oUwnVlDRd7oNo/uhPJGHa?=
 =?iso-8859-1?Q?SCsWSi/GfC1ahCJkaaqkxI4Ng1JhK/n7uxgjZa//dbS1+u642O/b5FbLMr?=
 =?iso-8859-1?Q?ldrRM6rvZ7NImE2W9yylmhNcWTYc9328GxlM2tjazdIaokaS/AatlZes6Y?=
 =?iso-8859-1?Q?Lvv5LmKXu8wfJEHHz9LGmEqSctOs2dhvJOPovEx4X7T/rlBDNQeiWcfwG7?=
 =?iso-8859-1?Q?6/Q+p9D7bq42H3ys7UO91MjqayK5V+YQviMOOCZ0BZ9wlcgg6XSwCtpxAw?=
 =?iso-8859-1?Q?5t53qVs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV4PR83MB0941.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+ZsiLMoXUoX4qp1R7jDGOmIpj6Qajqx+eZSYPuprTaF7x2mL0axLM/bWoy?=
 =?iso-8859-1?Q?dw3kci4/371N/ZX9s3dJTTgzieFpQtmnRhQfRqSwjrrQKEVNDrpe5Gapr5?=
 =?iso-8859-1?Q?a0dlpkSYxoSG54eTw5TEZ6Sn3QiNdvAHIFp8yH/zm6I8koq2Be5KbjnNhy?=
 =?iso-8859-1?Q?kjrvpbNdijYfeTbXiCPjm6wxYFUkPUBT1dlY8A/N0MhMo6WRSua2coT2PY?=
 =?iso-8859-1?Q?1R8ssg7OBaLXDiiqBb31gwQbDJFd4vSPsH0z3Q8A41ILgsLEKc30oWb49t?=
 =?iso-8859-1?Q?yQT4Om9kkgzXtfTDY7CxoQanj18woYiKHCbGk8hpsrgskKwa9pt9tveDah?=
 =?iso-8859-1?Q?ywiGn3YC437hjGne020nncoW9EaewA8dkHUyf+bNTJRv9zXNacUS0FBcxr?=
 =?iso-8859-1?Q?9F1PQruoTvwRYsuqo7Iw2aiMKbk26M9fEy/m0f1Yyj5EHc2wJzFcSiDsiT?=
 =?iso-8859-1?Q?WZAVb0sH3oqlHnRxWwcEA8+6h/9FUuRuRuB9nFT+X+hHu+tG0VGX9W0pEU?=
 =?iso-8859-1?Q?8nBEY7ePTY9eG+LIfP9EFD/cP271Rd2fTnSv69SrlRaf5jempQPGzQxv41?=
 =?iso-8859-1?Q?kbyx6kHTHpRQ/JnzY0zdJdP/fqbpoMHquLEkV39HVXgnRpd+jLvrMcItSK?=
 =?iso-8859-1?Q?LnXf5vShSmOB6735FVL1850TA9+os7zBxrMpZA6Sbp0MrRdSZLXFzNYhZl?=
 =?iso-8859-1?Q?ptz6LsbQ/jZ2sUj1WgBw4jREZ39sDMulvpzbS/xPyDRZJQiG6KHypYU8zf?=
 =?iso-8859-1?Q?MRa8s+unNZuU8jRZGgfJzlTTFnAwDFvXS/E4VHp3H7rqk+oBVT7/yqzRTZ?=
 =?iso-8859-1?Q?Axp0FDATSrsxL3Djaq7B2VkA0JQAl6M0JfFechJdV76jwXCtVlc0B2+byC?=
 =?iso-8859-1?Q?z8FnwChcDBYmWit4B4m0vUqdSXjkVFDpmHf13IJHzPcjve2VzdD++3gC+1?=
 =?iso-8859-1?Q?fcLnzM5yDogneIz4ACfo4FcQOyn3iqIZJ76bE60qf6z6zRRSWuSu6UUvzh?=
 =?iso-8859-1?Q?h3EquoS5KjtYEcBK2uah0M6Ct9Gv1oXUM6t5kY4AfFogbmDJcgJEkF9DvE?=
 =?iso-8859-1?Q?vMKgoDBTKcXMgGcUtYoJhYnUuEEemNsTMKn14FqJDR1Uu0tnM8XYGxVV/w?=
 =?iso-8859-1?Q?sYijxVe9iRm/mfTqEkVhKTMgYy4C+AVuVBG7NMK2fAkwk7IabOeFqPQbQ4?=
 =?iso-8859-1?Q?cikLPmUASkI1UoLxzUduLwBNSliOBSsOSr0I2RVDjNIhmHt3kveKx40A7V?=
 =?iso-8859-1?Q?D+RpooQzBvAFeQ3AbkaCOUY6cFCmGcHylvhKuv0VXnGjBXJiCPkhz35xes?=
 =?iso-8859-1?Q?IFKlkNxHAATiuCZMJxXQON5a2syg8c+RI1bePfqhmQZaaNOfPkE+gSzljF?=
 =?iso-8859-1?Q?SjsOjZyFEa8BJESCV+v1+l5fQqknZZL7KxA92Ww/cmiwG/fWaS/hZkQAhD?=
 =?iso-8859-1?Q?Q0MGJ+c83eFmxeTRGW+07Pxo3IuShsXFrHxEObHZE5iMQBUOxvGaHpZB4/?=
 =?iso-8859-1?Q?tVPSm7ESqXYBE2/tdTr1QkKhRMAxAlTaA34Hvx3moQj9Hho0CHMjMtujuo?=
 =?iso-8859-1?Q?3wtjik9J0HcCt6CvTOTcnvotS3oK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV4PR83MB0941.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7668a2-d4bf-413c-5ea9-08ddc8f3946d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 07:44:24.9069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDifiy3ucJdkAjHFTdLNlU/Uvniz3UO8S5jLodP5bbKqtQyQO2BXk0Bbcehb1S2MgMEhP629k+8KF4WROQ/oEkwRtD7lnfMymPTwCq9Ux/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0686
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
I understand your concern and thank you for brining it in. If I understand =
the comment at https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/=
blob/woarm64/winsup/cygwin/lib/_cygwin_crt0_common.cc#L123 correctly, this =
can happen when Cygwin application is linked with non-Cygwin stdlib. I don'=
t know if this is a legit use-case supported on x64 but, nevertheless, I'd =
IMO suggest to consider it as an extended use-case that is not implemented =
yet. If that is OK, I can add that information to the patch commit message =
and/or TODO comment in the code...=0A=
=0A=
Radek=
