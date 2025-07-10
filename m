Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20719.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::719])
	by sourceware.org (Postfix) with ESMTPS id 48AF33858CD9
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 09:18:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 48AF33858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 48AF33858CD9
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::719
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752139090; cv=pass;
	b=gNM+YFunxL90XlIPk+owEzJz5O4cQdrhhbLrMPatGqQe8RpC7Ood3L1OrBYdmJrV3A4Bexkre71HqkFL2JDXRy3ei6mRfcHGP9mJ8LthkzJEWBqksyGDR4hC0VYW452HY3uf0bHV+npsT4fhdxYjR1z+qY+/TGXqUUAE6RhmU2o=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752139090; c=relaxed/simple;
	bh=cWO8ND+w66thxkBEO2ebBC5CbKSTNYNgjiryk+eio4o=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=lG3PsDj9mrLNxtiw5ZUM5CJxC7C+wPmakneMYc1wQprtEmYFgOUkNsEC7sBL9RpUh0V0bRXCNihhdYX4KUHYcnEpT2FD2FydPeuqQ1t2SQlvlHwPCweSDp0k5J3/UvRencKtZDxx06f4k5nGMuylQqh23d3at0zuqVBSgcWJYr0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 48AF33858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=LGeGnLMe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0Rcq9QM0FrI2eo6a/Ut6PWJ/Mt4mLiCoufclXzqil91brVdPjjoQMx4qhQxGCdsEYonBY1/H7Ptk9pUDfkx2x4N0iroW8+phTjLKWcQkYi3jiz1LoTkPeqc11JI/mIcfz+hwO4Wx3LZoCzEs9vqDPYOKfPf9OE3ARmRqBnDjySKrTnyDSK6TpJbBpakq0o4TTC2nQho/wQgMX9cGDlk+GC4AcdP30xZmoyrqWfe1Cq/VoAwAPIVYFwqEibdUZ5KJJB1sp2RTqymDthBpa/UJ3/jauzww3QUBu5r+le0LcMAzQzYSZf+ee2uaxUrt2zAC8xy0HLmi3Q7/j9mcvcKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cogw55+fgNzlZIptsLmunCeRQZEHqg/MUamCdbmxYDY=;
 b=fFpFgzFCDobyne5UFV9JXpXucAuuK9JYEUc0utRDHL/VFf0a1p2jkfEdP3AXbW1jxFDzAp3/TfLjvmPPcUHVvw2zoD4HlfEGKKyYefjckxJ4xLFI9lLGFghS6dzEkX6BrFssuwLuQUTmizjv3BcBhxDWuzf9LJ1VFl8KpOg49tgGA9/p2HEStgnI5rtdSIuI43/Gy4bD6Bu0fkykCINKtd1Ziwb+wPkSQSR2jVNw1efOM+DzGXaQALS0LHcheunga4N90fISOFgNrO9ccckCQQtC5U5sRTRYz3vDewd5o1l/U1gfiNZtplyaEhM+bqFU+zfhjrVNAGuwHYnHRQgqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cogw55+fgNzlZIptsLmunCeRQZEHqg/MUamCdbmxYDY=;
 b=LGeGnLMe6AU1VvEqpu4zlxKSqU9Jm5O9KV7nUhPJ/umm8DIykeKZxrNfyk3ORbubYApjC5xBBkTPVdh6S8wQhIXQqO4AqanQyyhr9FGjHnUo6c0bUKNfLRxoUf9Ygpn1KYd7OVyB9rvthmn7qVICrbuagT6ok9kNXgkRSA3NCMM=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0703.EURPRD83.prod.outlook.com (2603:10a6:10:56b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Thu, 10 Jul
 2025 09:18:07 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 09:18:06 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Radek Barton
	<radek.barton@microsoft.com>
Subject: [PATCH v2] Cygwin: gendef: stub implementations of routines for
 AArch64
Thread-Topic: [PATCH v2] Cygwin: gendef: stub implementations of routines for
 AArch64
Thread-Index: AQHb8XuLuU0VkROXK0WhumAvufrAug==
Date: Thu, 10 Jul 2025 09:18:06 +0000
Message-ID:
 <DB9PR83MB09233DE9CBD5304BB8D2D69E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923C9E8CCEA2C6CF37A60739242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB0923C9E8CCEA2C6CF37A60739242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T09:18:04.537Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0703:EE_
x-ms-office365-filtering-correlation-id: ffc52546-203b-49d2-df89-08ddbf92ae4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?kHMH402cDf7bLtOMRuhnQUern5BqA9/D9juxVCniulwpZI45jQSgP1zxVS?=
 =?iso-8859-2?Q?hc6unm53sNW9xuDF4GAgmMQ7qp0bz2fBInyqW/7MpUtgPOYVeR7ay7w6lm?=
 =?iso-8859-2?Q?9CCnSY0u8J/ooEN+9bCAhlX/Jc1REwQ2xuktrTv4xTJiYK5mkAxjteaHbm?=
 =?iso-8859-2?Q?Hs84aaKgA5GqDdBXbRKnqWoes27JzsYMuHDRKNEi0jh3XgBYzHr7SJxD3k?=
 =?iso-8859-2?Q?hxQfsOndTkNI+uvkReins4y7Gz/lzXfi4z0iu863k5nxE4D9XooXICr2Q/?=
 =?iso-8859-2?Q?KBffF3KO5CUi9nN+8zGwQFzEPXOXIBTMLFQ2iHWHR2pfzDF/pHrruZOrQt?=
 =?iso-8859-2?Q?qetGkygTJFrEJ15OuAEZht73dDPi49hLnT5Qx8PXZZQJOfNrqhxPg7a1xk?=
 =?iso-8859-2?Q?nylES/Dbe+hADPqzowC4OOc6F/r2O2Fy4RJi6f6eL0TRqBFgMu49VKdqp+?=
 =?iso-8859-2?Q?k2irU2fYdxMdUNwYQCiUgDyei+DQHADluBNM5Qo6dO2y71yw19nRbT+ILq?=
 =?iso-8859-2?Q?UjUeJwHVHXIacfUm/2jBu3EabPA77t2nUVwEq9/R/lVjqK3W+/KnxHz0u2?=
 =?iso-8859-2?Q?D8hD8LXFDHx+BZu7bhJxwKmzMH53T+E1qDUraWxiko+FgZz03P4y4GrXa8?=
 =?iso-8859-2?Q?N/HPiVfhO3sErsunuaPu/ah2rWGJbf9tl54+HPi+yasxMCY770KixoOzpG?=
 =?iso-8859-2?Q?WuF72rPO7dZjf1JxDHjPV469Qz0xnrVFnny5fa/QiZqva/1+n1voVklg8Z?=
 =?iso-8859-2?Q?VEx3g6xQ1jmx7M+kx4vJKIdiGdI2MHX+KUYDWV3aFJlD1bd0OUyxAfQ7B4?=
 =?iso-8859-2?Q?FVD7utwMO244I3jELJ2QF8FdYeVQsIGNjP1Z1k4j5SBPY9NbxdDUIIq5jF?=
 =?iso-8859-2?Q?EVib5kP8PTVQHEMKMgn0kyfb1lxn1BT9PhtZj8fne2C/Mwo6OC9czN92AH?=
 =?iso-8859-2?Q?sSqCcdpF4Zpe3RVftaJKCveUiakPLeO3RLfeH2EX2A9lGWOawyI/y4lO2+?=
 =?iso-8859-2?Q?nHdn8NS72BoF6am5shaWRIz8TqXnffNOv0Ap0UtO25CL1pOMKKLp7nbn2w?=
 =?iso-8859-2?Q?AnsAWWvWmLQnPfRsw8rdBMaGWsuggSQ/SH2+A8pmfPPm/UJEpjXGA1M0Tc?=
 =?iso-8859-2?Q?T5RRTsV1r12fSy+7bM07LSOZbGj6z7xNu0xIeMOexNJUj7FLBGBjbURlic?=
 =?iso-8859-2?Q?6SiBq0WjIUZV+ENlzXs4/A/Re5HqA03y253GPvpU4D2E40DCHPrPf/O6/D?=
 =?iso-8859-2?Q?/0njErq1Dt7QZRH1Nu24MbaiEkIuNgAQ4Gnjhh/6SqhZxXUdcmcfVcopUn?=
 =?iso-8859-2?Q?+MSlJY9mKI1AnG4aUOhkx0fafWAf2OvcPJD/KNBvs23I7VFxHFGDCTvqAH?=
 =?iso-8859-2?Q?VeIKUyg71pHyPLPMJ+JUeQ/wzWhTwuDywykJcheDrdGYb7jmOKNkFNh+Gf?=
 =?iso-8859-2?Q?Dclsay61KQ8fiybPa5M/dHKSuDBGY7YkODkpyxpRRepJ6A/MIynb5Q7Qgn?=
 =?iso-8859-2?Q?gZdvqSCUVATahohhggZE4yt1hUzDsvdah6HGa0UNK1HsSDTdsTR7FRN3Bc?=
 =?iso-8859-2?Q?rC2RCdk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Y4fhN3QlRb6DS4R89LspRvbTPYKNvKvzDJExjg8zGZEZDI51Myg5pM5nYJ?=
 =?iso-8859-2?Q?gVxsH6h0uBAXxTzhvi1SQqNVkSOarfWFnQO2So+qTcst8qTMHaJWR+P+ls?=
 =?iso-8859-2?Q?dZAhMwFfceRzQoLp95USlLTecsS4g5vycV6L9yuLXNOCLbrKrq573Jb9yU?=
 =?iso-8859-2?Q?X45wJFG/7bmFLPhC4BaL7sScIRowNXjJvZw7plAZ9a3bUIs5WsY/Gl8GIQ?=
 =?iso-8859-2?Q?dYoTHqqVQ2C3rMivJtdyPW1ffybOsDwg99i8rU33jERTOVmtb8Zy42wV/X?=
 =?iso-8859-2?Q?gTGld9F1o+H99Oc1t7coG4vCZYd17TEczZxa8g2eHBgvpawSu4fw3E5Uba?=
 =?iso-8859-2?Q?QFVlAa6mCipkbuOT5sTjzut+GDqJmgMz4L6LJldBbHdmG5KcVkzXcucVmb?=
 =?iso-8859-2?Q?2bpRl6L8D7/ya5VcMZEjeDfOh04lcSL/eRLMIc4//O3oliCl9BTriL92Ms?=
 =?iso-8859-2?Q?xpgmoCzOfH7IuP1JBPr1Q6f+Hrl+kGWCy7uDPgN2jvnRyuO+YwDqIca8S8?=
 =?iso-8859-2?Q?pU8ofS20vvsR/OX2Vs+Zj7evwfsHMjPT0lPrwEoeaz8r1PvOu+TUFeJNI7?=
 =?iso-8859-2?Q?8XO1q4piP85o/CHe6FWQ2ZBKhXISpT/sAgCF+wZ/MNW9ZcTqy2XeKzQL9H?=
 =?iso-8859-2?Q?hl53kEFPrhuIw1I0vqTf1IuaZVMzG6y6JfzJ4Y18EKOUDB6OHybkaTQbzv?=
 =?iso-8859-2?Q?ncnUKuLD4aqKTjjbufrPIz4y5if4cNfDN8w0d4GYh6T0Vwx5vArxdG2DMt?=
 =?iso-8859-2?Q?6VY7Vx9OID8/muNYKymc/Av8thXPMzL7UeDJXxTUDE4h7heD9MQoZrm7N5?=
 =?iso-8859-2?Q?cIiFPwnDAYrxuD5f8XdXsrrBzNyzj0uGwX1/vjVMhZy1SpDdW0W0LGCFCw?=
 =?iso-8859-2?Q?MmjHLXgnsC/cBLiMdnAlKcGO9OjuXgB7o6kWZU4TZQBTh3jNUusicCj7Cd?=
 =?iso-8859-2?Q?mOH+Sw0sJFGFl8GT5D8KuysvnpLdumLGJCxPkctJ3+2E+cmSfZD7fab0HQ?=
 =?iso-8859-2?Q?C6vyKujmq5fEPP3yb3qYAmpy7HFcSydXnSvKqp45CJbu+PKQ4+/ESBJ5BL?=
 =?iso-8859-2?Q?yhM8nKWuoPYJ2Hk65VEJwlm6YrUAGkIFb+4T7K6nlzvHifuXLv/eoN7mZl?=
 =?iso-8859-2?Q?PX+swyu02T2lXBx7j7RCs1Tw9IcgauDJ/8HS0a9M2M5rMkdQIVj7T9p85R?=
 =?iso-8859-2?Q?jxQdQXDPN6bFXZwZXvIKl8YnveqY0dD+l24NEszYmhjO/zwbmk3NXpVDFP?=
 =?iso-8859-2?Q?rEAu0ZI7hMrNRzigi3ZobXCU1LIIJmDmcciPoA3fzQS9L88QYFtJIjVxdi?=
 =?iso-8859-2?Q?CJQPpg7gdqBhd5z2LERwA1PQ38el8Uv1Jr/echdWQ9tvXpEXOCqHKaGHkB?=
 =?iso-8859-2?Q?+vCi3ztRaAOXSqcAP2xYzx9sYncj4/2TpMiO+pggXAeSVX21boX7HC5M3c?=
 =?iso-8859-2?Q?lkiLymTuOM2On62OYkXGu7boYUtYPZzWvwKIRNV1GgefaFdN50PE6e0+MM?=
 =?iso-8859-2?Q?qEDX5twzmFk+cRjemT1M5dicGpeWZpWlLyCrBVlUU0wartjhheNU1bK9o1?=
 =?iso-8859-2?Q?L1CyvgiLRj+IIyKzEF7dpeBlsXka?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09233DE9CBD5304BB8D2D69E9248ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc52546-203b-49d2-df89-08ddbf92ae4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 09:18:06.6686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFfiI2HfD0Vfz8271+zllzKFaRu2TaEiNA1C7mZeO7qgU3n61C6mFyRY6Jr7N9lFJsyNKqQRHk8/ZQYpoxdbL39E90H+mp73gGdCcC1oh5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0703
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09233DE9CBD5304BB8D2D69E9248ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending the same patch with more detailed commit message.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 98a989bfaef11097d5ce6705c3780ea6ebb284e9 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Fri, 6 Jun 2025 14:31:30 +0200=0A=
Subject: [PATCH v2] Cygwin: gendef: stub implementations of routines for AA=
rch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch aspires to provide only minimal changes to=0A=
`winsup/cygwin/scripts/gendef` allowing to pass the AArch64 build. It does =
not=0A=
provide any implementations of the generated routines.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/scripts/gendef | 42 +++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 41 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef=0A=
index 861a2405b..1bd724511 100755=0A=
--- a/winsup/cygwin/scripts/gendef=0A=
+++ b/winsup/cygwin/scripts/gendef=0A=
@@ -21,6 +21,7 @@ if (!defined($cpu) || !defined($output_def)) {=0A=
     die "$0: missing required option\n";=0A=
 }=0A=
 =0A=
+my $is_aarch64 =3D $cpu eq 'aarch64';=0A=
 my $is_x86_64 =3D $cpu eq 'x86_64';=0A=
 # FIXME? Do other (non-32 bit) arches on Windows still use symbol prefixes=
?=0A=
 my $sym_prefix =3D '';=0A=
@@ -89,7 +90,7 @@ sub fefunc {=0A=
     my $func =3D $sym_prefix . shift;=0A=
     my $fe =3D $sym_prefix . shift;=0A=
     my $sigfe_func;=0A=
-    if ($is_x86_64) {=0A=
+    if ($is_x86_64 || $is_aarch64) {=0A=
 	$sigfe_func =3D ($fe =3D~ /^(.*)_${func}$/)[0];=0A=
     }=0A=
     my $extra;=0A=
@@ -109,6 +110,15 @@ $fe:=0A=
 =0A=
 EOF=0A=
     }=0A=
+    # TODO: This is only a stub, it needs to be implemented properly for A=
Arch64.=0A=
+    if ($is_aarch64) {=0A=
+	$res =3D <<EOF;=0A=
+	.extern $func=0A=
+	.global $fe=0A=
+$fe:=0A=
+EOF=0A=
+    }=0A=
+=0A=
     if (!$main::first++) {=0A=
 	if ($is_x86_64) {=0A=
 	  $res =3D <<EOF . longjmp () . $res;=0A=
@@ -338,6 +348,23 @@ stabilize_sig_stack:=0A=
 	popq	%r12=0A=
 	ret=0A=
 	.seh_endproc=0A=
+EOF=0A=
+	}=0A=
+	# TODO: These are only stubs, they need to be implemented properly for AA=
rch64.=0A=
+	if ($is_aarch64) {=0A=
+	  $res =3D <<EOF . longjmp () . $res;=0A=
+	.include "tlsoffsets"=0A=
+	.text=0A=
+=0A=
+_sigfe_maybe:=0A=
+	.global _sigbe=0A=
+_sigfe:=0A=
+_sigbe:=0A=
+	.global	sigdelayed=0A=
+sigdelayed:=0A=
+_sigdelayed_end:=0A=
+	.global _sigdelayed_end=0A=
+stabilize_sig_stack:=0A=
 EOF=0A=
 	}=0A=
     }=0A=
@@ -474,6 +501,19 @@ longjmp:=0A=
 	incl	%eax=0A=
 0:	ret=0A=
 	.seh_endproc=0A=
+EOF=0A=
+    }=0A=
+    if ($is_aarch64) {=0A=
+      	# TODO: These are only stubs, they need to be implemented properly =
for AArch64.=0A=
+      	return <<EOF;=0A=
+	.globl	sigsetjmp=0A=
+sigsetjmp:=0A=
+	.globl  setjmp=0A=
+setjmp:=0A=
+	.globl	siglongjmp=0A=
+siglongjmp:=0A=
+	.globl  longjmp=0A=
+longjmp:=0A=
 EOF=0A=
     }=0A=
 }=0A=
-- =0A=
2.50.1.vfs.0.0=0A=

--_002_DB9PR83MB09233DE9CBD5304BB8D2D69E9248ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-gendef-stub-implementations-of-routines-for-AArch64.patch"
Content-Description:
 v2-0001-Cygwin-gendef-stub-implementations-of-routines-for-AArch64.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-gendef-stub-implementations-of-routines-for-AArch64.patch";
	size=2522; creation-date="Thu, 10 Jul 2025 09:17:50 GMT";
	modification-date="Thu, 10 Jul 2025 09:17:50 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5OGE5ODliZmFlZjExMDk3ZDVjZTY3MDVjMzc4MGVhNmViYjI4NGU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogRnJpLCA2IEp1biAyMDI1IDE0OjMxOjMwICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQ3lnd2luOiBnZW5kZWY6IHN0dWIgaW1wbGVtZW50YXRp
b25zIG9mIHJvdXRpbmVzIGZvciBBQXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlw
ZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4
Yml0CgpUaGlzIHBhdGNoIGFzcGlyZXMgdG8gcHJvdmlkZSBvbmx5IG1pbmltYWwgY2hhbmdlcyB0
bwpgd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZmAgYWxsb3dpbmcgdG8gcGFzcyB0aGUgQUFy
Y2g2NCBidWlsZC4gSXQgZG9lcyBub3QKcHJvdmlkZSBhbnkgaW1wbGVtZW50YXRpb25zIG9mIHRo
ZSBnZW5lcmF0ZWQgcm91dGluZXMuCgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0b8WIIDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVm
IHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdl
ZCwgNDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9j
eWd3aW4vc2NyaXB0cy9nZW5kZWYgYi93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCmluZGV4
IDg2MWEyNDA1Yi4uMWJkNzI0NTExIDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMv
Z2VuZGVmCisrKyBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKQEAgLTIxLDYgKzIxLDcg
QEAgaWYgKCFkZWZpbmVkKCRjcHUpIHx8ICFkZWZpbmVkKCRvdXRwdXRfZGVmKSkgewogICAgIGRp
ZSAiJDA6IG1pc3NpbmcgcmVxdWlyZWQgb3B0aW9uXG4iOwogfQogCitteSAkaXNfYWFyY2g2NCA9
ICRjcHUgZXEgJ2FhcmNoNjQnOwogbXkgJGlzX3g4Nl82NCA9ICRjcHUgZXEgJ3g4Nl82NCc7CiAj
IEZJWE1FPyBEbyBvdGhlciAobm9uLTMyIGJpdCkgYXJjaGVzIG9uIFdpbmRvd3Mgc3RpbGwgdXNl
IHN5bWJvbCBwcmVmaXhlcz8KIG15ICRzeW1fcHJlZml4ID0gJyc7CkBAIC04OSw3ICs5MCw3IEBA
IHN1YiBmZWZ1bmMgewogICAgIG15ICRmdW5jID0gJHN5bV9wcmVmaXggLiBzaGlmdDsKICAgICBt
eSAkZmUgPSAkc3ltX3ByZWZpeCAuIHNoaWZ0OwogICAgIG15ICRzaWdmZV9mdW5jOwotICAgIGlm
ICgkaXNfeDg2XzY0KSB7CisgICAgaWYgKCRpc194ODZfNjQgfHwgJGlzX2FhcmNoNjQpIHsKIAkk
c2lnZmVfZnVuYyA9ICgkZmUgPX4gL14oLiopXyR7ZnVuY30kLylbMF07CiAgICAgfQogICAgIG15
ICRleHRyYTsKQEAgLTEwOSw2ICsxMTAsMTUgQEAgJGZlOgogCiBFT0YKICAgICB9CisgICAgIyBU
T0RPOiBUaGlzIGlzIG9ubHkgYSBzdHViLCBpdCBuZWVkcyB0byBiZSBpbXBsZW1lbnRlZCBwcm9w
ZXJseSBmb3IgQUFyY2g2NC4KKyAgICBpZiAoJGlzX2FhcmNoNjQpIHsKKwkkcmVzID0gPDxFT0Y7
CisJLmV4dGVybiAkZnVuYworCS5nbG9iYWwgJGZlCiskZmU6CitFT0YKKyAgICB9CisKICAgICBp
ZiAoISRtYWluOjpmaXJzdCsrKSB7CiAJaWYgKCRpc194ODZfNjQpIHsKIAkgICRyZXMgPSA8PEVP
RiAuIGxvbmdqbXAgKCkgLiAkcmVzOwpAQCAtMzM4LDYgKzM0OCwyMyBAQCBzdGFiaWxpemVfc2ln
X3N0YWNrOgogCXBvcHEJJXIxMgogCXJldAogCS5zZWhfZW5kcHJvYworRU9GCisJfQorCSMgVE9E
TzogVGhlc2UgYXJlIG9ubHkgc3R1YnMsIHRoZXkgbmVlZCB0byBiZSBpbXBsZW1lbnRlZCBwcm9w
ZXJseSBmb3IgQUFyY2g2NC4KKwlpZiAoJGlzX2FhcmNoNjQpIHsKKwkgICRyZXMgPSA8PEVPRiAu
IGxvbmdqbXAgKCkgLiAkcmVzOworCS5pbmNsdWRlICJ0bHNvZmZzZXRzIgorCS50ZXh0CisKK19z
aWdmZV9tYXliZToKKwkuZ2xvYmFsIF9zaWdiZQorX3NpZ2ZlOgorX3NpZ2JlOgorCS5nbG9iYWwJ
c2lnZGVsYXllZAorc2lnZGVsYXllZDoKK19zaWdkZWxheWVkX2VuZDoKKwkuZ2xvYmFsIF9zaWdk
ZWxheWVkX2VuZAorc3RhYmlsaXplX3NpZ19zdGFjazoKIEVPRgogCX0KICAgICB9CkBAIC00NzQs
NiArNTAxLDE5IEBAIGxvbmdqbXA6CiAJaW5jbAklZWF4CiAwOglyZXQKIAkuc2VoX2VuZHByb2MK
K0VPRgorICAgIH0KKyAgICBpZiAoJGlzX2FhcmNoNjQpIHsKKyAgICAgIAkjIFRPRE86IFRoZXNl
IGFyZSBvbmx5IHN0dWJzLCB0aGV5IG5lZWQgdG8gYmUgaW1wbGVtZW50ZWQgcHJvcGVybHkgZm9y
IEFBcmNoNjQuCisgICAgICAJcmV0dXJuIDw8RU9GOworCS5nbG9ibAlzaWdzZXRqbXAKK3NpZ3Nl
dGptcDoKKwkuZ2xvYmwgIHNldGptcAorc2V0am1wOgorCS5nbG9ibAlzaWdsb25nam1wCitzaWds
b25nam1wOgorCS5nbG9ibCAgbG9uZ2ptcAorbG9uZ2ptcDoKIEVPRgogICAgIH0KIH0KLS0gCjIu
NTAuMS52ZnMuMC4wCgo=

--_002_DB9PR83MB09233DE9CBD5304BB8D2D69E9248ADB9PR83MB0923EURP_--
