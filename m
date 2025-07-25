Return-Path: <SRS0=+QaW=2G=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on20709.outbound.protection.outlook.com [IPv6:2a01:111:f403:2608::709])
	by sourceware.org (Postfix) with ESMTPS id 425313858D33
	for <cygwin-patches@cygwin.com>; Fri, 25 Jul 2025 20:51:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 425313858D33
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 425313858D33
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2608::709
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753476663; cv=pass;
	b=CVROK0Q9Hfe7hzou188L65fWF93NU5zPI2QM3kCqmRpPP3iwpiEfjXWw5ZoyPTlqh1aWFa2DhzZn6DbWpV+nZtzAsf9vsp36vPsiIuxJcmAp72hcnfJZlG1XvhmRg34Y+8Hh5DFya5Gf8fsEI3b1+mg9JOVTUoDofj6PeL3Y9NY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753476663; c=relaxed/simple;
	bh=BJ+m2IRYFOS0Ib3f6Mr0rL3VqHIdgmBwgxUwuzxwCHI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=q/lNNQFdSnO6h91DLJCRi48XdlGteEIvI9sCxXSbzQuNyuwxjH4x5K4o4oaYBdUH8biseT27OsQRa1wgLazAqPW2GsTekddzFfLCR5n2zfaK8Er3ssf+wGbVDzhapf3tTrxkL2g93OcbU04Tp8hwlX0qM4qAsf6bMvXe5rHetBA=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 425313858D33
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=dJSw5Jji
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym9+dgorAWNWB5SuAU9fdvcL27tp/sWGfaiPWfFwYt1ld6BgnzIYqHGDn9ZJ9fDLN5rYNMi7oLdM3n5R88RLKxLg4LxZWwHedFVcR/AOWNuGq2Pn1DU3TUCc+81mmaudExd6Vk01+1lg3c1kwKaTN+mbY258Hh5Y+KcchyZKQ7gV2wIeGOPsfdbqJ3aWCJUvJPIWxJHJv3QydQIdGsmLKENQ4i7J0LRYrIITA4P0o4GbMNoDbAVhQQrwW/P2HNIA8sZGQu3Wc2rxXeXQC5kfAXqo59MVf4oUH9QnPz9c/gfXVIhWkL6AFCywqJ6QxVhJlwO25s5OIkfL+IXiWG32/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNM5oH9kwdAUdM7vfAcO8rSvAwc4XzIKb6py3vIUE20=;
 b=rwNcy/QEkin6OPqRNLo0JgpPt4wIDEhvKkfoxCNXltZlAhxeh0y45jiQbWu3uYrdFuHw8uaLZSFA0RAUqDLrSBux6On0xYAcQtwgo5zPSTrxaVCmIzd7WzPdl4sAdBQguSS61GUg9Wbu1G0r5O7c2KEIF8NqsRjxeI7AKEKF11bEKCjHZNGhT7L23t/0G8Zk2NbgwAkhHPgiTp/0obiJvOiDSB0ev/iVTeiRpZWhi7rAvII9AZltS3dDkKEUI8B3Ly4w8lew/WeI88byBU54fJ/h2b+ZwLWpWjhFMveZijaETU4Ni7fZJtzEhwablMWrUt7coptOOstsZ43W0MgOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNM5oH9kwdAUdM7vfAcO8rSvAwc4XzIKb6py3vIUE20=;
 b=dJSw5JjijaAgrad+QsOI0NuHm6sPP2TxdGdu28hUOn0lmm2EVH9O6jXf/V6jezBmUasv0GsrifdmtkuGeJBLOXVV7/ClFEw2yQ+1U1qDaG6Y9xcfRrtzs8rTKvrnXBKbIGt4PDkTKXclGCqYIUmnfy0ck8hF9D9ckopEDbJtApQ=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU7PR83MB0832.EURPRD83.prod.outlook.com (2603:10a6:10:5b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.16; Fri, 25 Jul
 2025 20:51:00 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e%4]) with mapi id 15.20.8989.006; Fri, 25 Jul 2025
 20:50:59 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v5] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Topic: [PATCH v5] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
Thread-Index: AQHb/aXTFAQSJqiNs0a5T9uG+z8bfw==
Date: Fri, 25 Jul 2025 20:50:59 +0000
Message-ID:
 <DB9PR83MB09238A32DBD70B395AE2EDEB9259A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
 <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9jZCS92AGUaP-o@calimero.vinschen.de>
 <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com>
 <aICZuCg3tKXOj_mR@calimero.vinschen.de>
 <GV4PR83MB0941AA5AD0E67B89787B1FE0925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aIIM-ZOEUZDsq-og@calimero.vinschen.de>
  <GV4PR83MB0941BC79A50B76470922FE38925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <039ff598-6a8d-3a16-c544-be7dae5b2a78@jdrake.com>
  <DB9PR83MB092391AD95379EB112A8EC339259A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <62741773-3864-2deb-c26c-4ae3dcea9344@jdrake.com>
In-Reply-To: <62741773-3864-2deb-c26c-4ae3dcea9344@jdrake.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-25T20:50:58.365Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU7PR83MB0832:EE_
x-ms-office365-filtering-correlation-id: 2d381301-8c0e-4c0b-4019-08ddcbbcf5f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?07PQOb7twqdaJKZpA/R7xr9s/t72cRrssT1cXfgZPNGu062drNHmHC1R9d?=
 =?iso-8859-2?Q?tC+hwXTgYm57icwAIj+cDToz9VhQaW8jaGHLvyvsjL/cU/BDJIZZ1BDtdz?=
 =?iso-8859-2?Q?FnLbFErVw6xdZ+IVJvmCEcGq0V1nznmLA2Yrt42Fj4NVpFkcLO+xeC8Ixo?=
 =?iso-8859-2?Q?0cwIHt3ujBCaMZlFyv62Ug+IM6nfBZ5VlgIpcEp5F43kVB6V6BFt5mAz/S?=
 =?iso-8859-2?Q?fHVWyBWRcOHW3egkp8AwbcgYc2sE0ja+KQpEYvaJMFOHdom7OryUaJJTfs?=
 =?iso-8859-2?Q?59usAM8qtm50akLHzRMaZ/fePAgK/gVoYiui/SuhVoOiLDHOWnxU71mkGc?=
 =?iso-8859-2?Q?EIRmbZqbLlGkyOGG4WPcGzOAiaEapSsTMOngAwHD2rdzBlPSc8IABF7k11?=
 =?iso-8859-2?Q?4c5dl0O5qwJ2Sa6NxLGFZXhqOn4PEKjNUu+QR6gZ4N4081A52c1DpPncST?=
 =?iso-8859-2?Q?te7sS/k7Lu75/u51kGde8z9DXk9eQtmtGKMKK0Z1knjFQ6CLqbCOhK/W/R?=
 =?iso-8859-2?Q?jOdjSkTvgCwYuCQFgJZQ3X1kd5ByOx6ByIQYNu16ituxYvL9+ZffGXgraU?=
 =?iso-8859-2?Q?K+T0m4BsOw5HpUCbgGvCFjJL2yLMuV4d/8p0KnYhEZ5+gFIJSOAnLE5oS3?=
 =?iso-8859-2?Q?9Gs6xgGpHj0ruOsLy1xO3LqcRdJOdKy/RQ+ZPlsHZecwqfRPP4eutiYgHG?=
 =?iso-8859-2?Q?z+JiEgmu6X5hmPROG/I+qlFshbK7VFschuJYsYtfcMBt1yqzfYaR2mWpaZ?=
 =?iso-8859-2?Q?xnxonQ4vhb9+zpst4C8wW+wxL+N77nOhLi/00tvZ328ypRNNQWkr6TsIXf?=
 =?iso-8859-2?Q?i/8KEK/fDBzlO2X1M7Z7CfayKGjwp9DmW7DkExWgey6qBJMG5JNUCp6Xi8?=
 =?iso-8859-2?Q?vnFsdmt71g3T79HYXjbdgSd3ITcNjLGgGoGzCNXMlHPfjcPU8bBMaI2b60?=
 =?iso-8859-2?Q?yTuAeU5yb/YUXWcTTDSPP90s6d66M2e3y37w6L1Zzr4K8iYKIbuPIWviVD?=
 =?iso-8859-2?Q?SisAwf0w41lOWQG1Bzk4MBJl5E4uHj+YsLkKns8TneXVVOxCRp8846uYR7?=
 =?iso-8859-2?Q?Q4PcOnqqFcKqgyDiWt3Vr3bGjCyueIWlcz2W8ljI+24NUz8HNBfkzjw1xr?=
 =?iso-8859-2?Q?RBzbkLLRPwj/jHPPzCi1jZu4Pb0W5nokuF/S9i6Sztfbo3n9+qzOZJRbAT?=
 =?iso-8859-2?Q?/An28AbHtuA0WDTKuahDZOIL9lufDufMtYgmhPFqlzMK5jOzsPd00ZjfN2?=
 =?iso-8859-2?Q?T/+gl/OzvIjnzzPMyJNX2WkGyxzkuxD7o5Mkv5nvIlrQFb5SWag81/b+YB?=
 =?iso-8859-2?Q?mFrjbGDmesFjdueYrPIgibs50VYCxAzer7UNOIv7B9nv/wS+CdpL4bXdEc?=
 =?iso-8859-2?Q?8RBsHuX029E3a0WaCw+c/90X104zdxxxqW5tOAqz4GJpE17xPkrRLJL9R0?=
 =?iso-8859-2?Q?+h1Mr1m020lHfByqGIqSZZX6uRRDep4JaJhBRWSTyk6/DcQCHSI4k6ve/9?=
 =?iso-8859-2?Q?g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?N+lm9NEUQ0m5Om7E7VGcMeL9sa2sQ+W50+zwk7YumJyBR2d3+EudRCO/TK?=
 =?iso-8859-2?Q?5wCSMJATx715ujqgalE84DgYY0/x4c4AxgJSuba3bu0/jePjd9vfVbqdcF?=
 =?iso-8859-2?Q?Wkdx8DwCGsaH7TsjC0Q5bofZVzwr0OZU6TmUPGXXc1AVmnue/5w3et5Rkm?=
 =?iso-8859-2?Q?1esEBHBOkDzn8gHfl/54uOzL7CIiG/CvbFS17pM/JD3pmFpARdUnlFTh5B?=
 =?iso-8859-2?Q?2r73O2d4fEZiLaUaqJsTW7GYlTybrehikFGsP8Dxx0uTjDQOv9GFnd3yYG?=
 =?iso-8859-2?Q?Vx7bbrHzDUdkfPOBks5W8MwV5EfhI3Z+SbbIIQB2OLKVvptQMczl76Z8qt?=
 =?iso-8859-2?Q?T/wxiRF5Ku9Y1QoN+a4Jv+MUlpqzqLM6I/Z37NYpPGn0UA8kVwbW9s6YXc?=
 =?iso-8859-2?Q?cEnA4c5+mlQI0o39JKTXx4oY6IYT9sFYZQaJsGTX8YxssYB5DNLPj5W6iy?=
 =?iso-8859-2?Q?x+8RMwLZkJUIZoNQ3URCzHM5DYpgNbVnt1fBAfgSj5aQvmFubDp5QCxDNI?=
 =?iso-8859-2?Q?4vVP+t5AlMvUCefay+Hrxmvqk7AFalQHbqKYBYrghVCNDncDp+e6CNMRsZ?=
 =?iso-8859-2?Q?Axe1SfozN9AK71JBAjlbu2BL5ApdckqsLbeJOIeRie3zsD/xneqxupHNFG?=
 =?iso-8859-2?Q?c48VyCtdsOVXo5FjOsvxn+xEW+S6c+PQ4UGzsDZRY17gay1ddBOn2e8yNt?=
 =?iso-8859-2?Q?Q6CLFdhIHE4CxjY+yRVuQetAn8Q1BBeIqbycPcQQFlShjChZqwCEgdcL1/?=
 =?iso-8859-2?Q?7X8EKWOaolaFTs//KF8vDeHZfI9gmva6jzoUAx99WpT/M2PvRev2KwWPEL?=
 =?iso-8859-2?Q?ONNnfxdDQoBgzSZpJQLxCchoQhDwf4O1EpchQXGqc1Rvwc4lo1Vq5H1ZXs?=
 =?iso-8859-2?Q?fj4nC/yBo3eY+lp4AbzKhtgK3a3Fr7zF6IsaLc74/u6PdiLJv3CL6lMQdT?=
 =?iso-8859-2?Q?yqruhgLdWAchnE6nW+XffOlQKJ1L027LyWTNiZcpMCxgNNXgvP4GGfC9lo?=
 =?iso-8859-2?Q?srtX0WaPPR+pnWNUhSi8giCvhTd2LPuMY3fOd208qW27XdTpZZd77KryYw?=
 =?iso-8859-2?Q?L1+mtRxGFrf+ZfK3kL0bfc7c9HPhPyHwNtEzXGrEZp2Agm7vacZDGpas+u?=
 =?iso-8859-2?Q?zOjC/YRqDjSqZtpmh+RQcAlQumikoh4dcx53O19qAA//D1g92HuG308h3R?=
 =?iso-8859-2?Q?8KTZM8RBB8zrvchR/aVhGY0uE8mBQGYwizyQba5vNOsqEOsnOZKhJ3gIy/?=
 =?iso-8859-2?Q?suma9UGsqFwRvfxntPBWqce8KhrB5VxAfcpFyDsPPPjQiw5+uZXY0pDJv9?=
 =?iso-8859-2?Q?JNl7UJ3XhP1Oge1Gkk5MfZEFn5U2JCZNOfzdYoNuj1PYLcQjWDCseVp8/f?=
 =?iso-8859-2?Q?Lv250Zxj2KR1h3MjjzjDvM8zKtY3laxIBrD4J6LgWGvDP6O5QllmLp+5U9?=
 =?iso-8859-2?Q?FfJcRRzJjO/8alfAah+7xwNKT9Eq7z+XcnIFnPlZAXbgwhUCMErDPCgMs9?=
 =?iso-8859-2?Q?9iUB0H+bpmrljPE503fCI462GYJ8VWmSxPqgkd+mUX9yuc8V4Ma0zufl8j?=
 =?iso-8859-2?Q?fLZuUA2iut0k3zyJQAB8yZEUjSBJ?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09238A32DBD70B395AE2EDEB9259ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d381301-8c0e-4c0b-4019-08ddcbbcf5f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 20:50:59.6838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsSnPvFxNgc9P3WkvRtQFYvYd95PP1TfHINm6rjfV/wgI1LgcIAklzLztDSCNcNj5qdCyuMesz0pJuJ5GvXjyiTFwqbL0xY81obMeujYoxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR83MB0832
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09238A32DBD70B395AE2EDEB9259ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello=0A=
=0A=
Sending version with the comment updated and indentation fixed.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 494dfb736813385179e083864e1610284ca43ec8 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 19 Jul 2025 19:17:12 +0200=0A=
Subject: [PATCH v5] Cygwin: mkimport: implement AArch64 +/-4GB relocations=
=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Based on https://sourceware.org/pipermail/cygwin-patches/2025q3/014154.html=
=0A=
suggestion, this patch implements +/-4GB relocations for AArch64 in the mki=
mport=0A=
script by using adrp and ldr instructions. This change required update=0A=
in winsup/cygwin/mm/malloc_wrapper.cc where those instructions are=0A=
decoded to get target import address.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/mm/malloc_wrapper.cc | 34 ++++++++++++++++++++++--------=0A=
 winsup/cygwin/scripts/mkimport     |  7 ++++--=0A=
 2 files changed, 30 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/malloc_w=
rapper.cc=0A=
index 863d3089c..9444cb4c8 100644=0A=
--- a/winsup/cygwin/mm/malloc_wrapper.cc=0A=
+++ b/winsup/cygwin/mm/malloc_wrapper.cc=0A=
@@ -51,16 +51,32 @@ import_address (void *imp)=0A=
   __try=0A=
     {=0A=
 #if defined(__aarch64__)=0A=
-      // If opcode is an adr instruction.=0A=
-      uint32_t opcode =3D *(uint32_t *) imp;=0A=
-      if ((opcode & 0x9f000000) =3D=3D 0x10000000)=0A=
+      /* If first three instructions of the imp are:=0A=
+	   adrp x16, X=0A=
+	   ldr x16, [x16, #:lo12:X]=0A=
+	   br x16=0A=
+	 References:=0A=
+	   - https://www.scs.stanford.edu/~zyedidia/arm64/adrp.html=0A=
+	   - https://www.scs.stanford.edu/~zyedidia/arm64/ldr_imm_gen.html=0A=
+	   - https://www.scs.stanford.edu/~zyedidia/arm64/br.html=0A=
+	 NOTE: This implementation assumes that the relocation table is made of=
=0A=
+	 those specific AArch64 instructions as generated by the=0A=
+	 winsup/cygwin/scripts/mkimport script. Please, keep it in sync. */=0A=
+      uint32_t opcode1 =3D *((uint32_t *) imp);=0A=
+      uint32_t opcode2 =3D *(((uint32_t *) imp) + 1);=0A=
+      uint32_t opcode3 =3D *(((uint32_t *) imp) + 2);=0A=
+      if (((opcode1 & 0x9f00001f) =3D=3D 0x90000010) &&=0A=
+	  ((opcode2 & 0xffc003ff) =3D=3D 0xf9400210) &&=0A=
+	  (opcode3 =3D=3D 0xd61f0200))=0A=
 	{=0A=
-	  uint32_t immhi =3D (opcode >> 5) & 0x7ffff;=0A=
-	  uint32_t immlo =3D (opcode >> 29) & 0x3;=0A=
-	  int64_t sign_extend =3D (0l - (immhi >> 18)) << 21;=0A=
-	  int64_t imm =3D sign_extend | (immhi << 2) | immlo;=0A=
-	  uintptr_t jmpto =3D *(uintptr_t *) ((uint8_t *) imp + imm);=0A=
-	  return (void *) jmpto;=0A=
+	  uint32_t immhi =3D (opcode1 >> 5) & 0x7ffff;=0A=
+	  uint32_t immlo =3D (opcode1 >> 29) & 0x3;=0A=
+	  uint32_t imm12 =3D ((opcode2 >> 10) & 0xfff) * 8; // 64 bit scale=0A=
+	  int64_t sign_extend =3D (0l - ((int64_t) immhi >> 32)) << 33; // sign e=
xtend from 33 to 64 bits=0A=
+	  int64_t imm =3D sign_extend | (((immhi << 2) | immlo) << 12);=0A=
+	  int64_t base =3D (int64_t) imp & ~0xfff;=0A=
+	  uintptr_t* jmpto =3D (uintptr_t *) (base + imm + imm12);=0A=
+	  return (void *) *jmpto;=0A=
 	}=0A=
 #else=0A=
       if (*((uint16_t *) imp) =3D=3D 0x25ff)=0A=
diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimpor=
t=0A=
index 0c1bcafbf..5583099bb 100755=0A=
--- a/winsup/cygwin/scripts/mkimport=0A=
+++ b/winsup/cygwin/scripts/mkimport=0A=
@@ -73,8 +73,11 @@ EOF=0A=
 	.extern	$imp_sym=0A=
 	.global	$glob_sym=0A=
 $glob_sym:=0A=
-	adr x16, $imp_sym=0A=
-	ldr x16, [x16]=0A=
+	# NOTE: Using instructions that are used by MSVC and LLVM. Binutils are=
=0A=
+	# using adrp/add/ldr-0-offset though. Please, keep it in sync with=0A=
+	# import_address implementation in winsup/cygwin/mm/malloc_wrapper.cc.=0A=
+	adrp x16, $imp_sym=0A=
+	ldr x16, [x16, #:lo12:$imp_sym]=0A=
 	br x16=0A=
 EOF=0A=
 	} else {=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB09238A32DBD70B395AE2EDEB9259ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v5-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch"
Content-Description:
 v5-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch
Content-Disposition: attachment;
	filename="v5-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch";
	size=3545; creation-date="Fri, 25 Jul 2025 20:50:43 GMT";
	modification-date="Fri, 25 Jul 2025 20:50:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0OTRkZmI3MzY4MTMzODUxNzllMDgzODY0ZTE2MTAyODRjYTQzZWM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAxOSBKdWwgMjAyNSAxOToxNzoxMiAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjVdIEN5Z3dpbjogbWtpbXBvcnQ6IGltcGxlbWVudCBBQXJj
aDY0ICsvLTRHQiByZWxvY2F0aW9ucwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRl
eHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoK
QmFzZWQgb24gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMv
MjAyNXEzLzAxNDE1NC5odG1sCnN1Z2dlc3Rpb24sIHRoaXMgcGF0Y2ggaW1wbGVtZW50cyArLy00
R0IgcmVsb2NhdGlvbnMgZm9yIEFBcmNoNjQgaW4gdGhlIG1raW1wb3J0CnNjcmlwdCBieSB1c2lu
ZyBhZHJwIGFuZCBsZHIgaW5zdHJ1Y3Rpb25zLiBUaGlzIGNoYW5nZSByZXF1aXJlZCB1cGRhdGUK
aW4gd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyB3aGVyZSB0aG9zZSBpbnN0cnVj
dGlvbnMgYXJlCmRlY29kZWQgdG8gZ2V0IHRhcmdldCBpbXBvcnQgYWRkcmVzcy4KClNpZ25lZC1v
ZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIHdp
bnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MgfCAzNCArKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0KIHdpbnN1cC9jeWd3aW4vc2NyaXB0cy9ta2ltcG9ydCAgICAgfCAgNyArKysr
LS0KIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyBiL3dpbnN1cC9j
eWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKaW5kZXggODYzZDMwODljLi45NDQ0Y2I0YzggMTAw
NjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKKysrIGIvd2luc3Vw
L2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYwpAQCAtNTEsMTYgKzUxLDMyIEBAIGltcG9ydF9h
ZGRyZXNzICh2b2lkICppbXApCiAgIF9fdHJ5CiAgICAgewogI2lmIGRlZmluZWQoX19hYXJjaDY0
X18pCi0gICAgICAvLyBJZiBvcGNvZGUgaXMgYW4gYWRyIGluc3RydWN0aW9uLgotICAgICAgdWlu
dDMyX3Qgb3Bjb2RlID0gKih1aW50MzJfdCAqKSBpbXA7Ci0gICAgICBpZiAoKG9wY29kZSAmIDB4
OWYwMDAwMDApID09IDB4MTAwMDAwMDApCisgICAgICAvKiBJZiBmaXJzdCB0aHJlZSBpbnN0cnVj
dGlvbnMgb2YgdGhlIGltcCBhcmU6CisJICAgYWRycCB4MTYsIFgKKwkgICBsZHIgeDE2LCBbeDE2
LCAjOmxvMTI6WF0KKwkgICBiciB4MTYKKwkgUmVmZXJlbmNlczoKKwkgICAtIGh0dHBzOi8vd3d3
LnNjcy5zdGFuZm9yZC5lZHUvfnp5ZWRpZGlhL2FybTY0L2FkcnAuaHRtbAorCSAgIC0gaHR0cHM6
Ly93d3cuc2NzLnN0YW5mb3JkLmVkdS9+enllZGlkaWEvYXJtNjQvbGRyX2ltbV9nZW4uaHRtbAor
CSAgIC0gaHR0cHM6Ly93d3cuc2NzLnN0YW5mb3JkLmVkdS9+enllZGlkaWEvYXJtNjQvYnIuaHRt
bAorCSBOT1RFOiBUaGlzIGltcGxlbWVudGF0aW9uIGFzc3VtZXMgdGhhdCB0aGUgcmVsb2NhdGlv
biB0YWJsZSBpcyBtYWRlIG9mCisJIHRob3NlIHNwZWNpZmljIEFBcmNoNjQgaW5zdHJ1Y3Rpb25z
IGFzIGdlbmVyYXRlZCBieSB0aGUKKwkgd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0IHNj
cmlwdC4gUGxlYXNlLCBrZWVwIGl0IGluIHN5bmMuICovCisgICAgICB1aW50MzJfdCBvcGNvZGUx
ID0gKigodWludDMyX3QgKikgaW1wKTsKKyAgICAgIHVpbnQzMl90IG9wY29kZTIgPSAqKCgodWlu
dDMyX3QgKikgaW1wKSArIDEpOworICAgICAgdWludDMyX3Qgb3Bjb2RlMyA9ICooKCh1aW50MzJf
dCAqKSBpbXApICsgMik7CisgICAgICBpZiAoKChvcGNvZGUxICYgMHg5ZjAwMDAxZikgPT0gMHg5
MDAwMDAxMCkgJiYKKwkgICgob3Bjb2RlMiAmIDB4ZmZjMDAzZmYpID09IDB4Zjk0MDAyMTApICYm
CisJICAob3Bjb2RlMyA9PSAweGQ2MWYwMjAwKSkKIAl7Ci0JICB1aW50MzJfdCBpbW1oaSA9IChv
cGNvZGUgPj4gNSkgJiAweDdmZmZmOwotCSAgdWludDMyX3QgaW1tbG8gPSAob3Bjb2RlID4+IDI5
KSAmIDB4MzsKLQkgIGludDY0X3Qgc2lnbl9leHRlbmQgPSAoMGwgLSAoaW1taGkgPj4gMTgpKSA8
PCAyMTsKLQkgIGludDY0X3QgaW1tID0gc2lnbl9leHRlbmQgfCAoaW1taGkgPDwgMikgfCBpbW1s
bzsKLQkgIHVpbnRwdHJfdCBqbXB0byA9ICoodWludHB0cl90ICopICgodWludDhfdCAqKSBpbXAg
KyBpbW0pOwotCSAgcmV0dXJuICh2b2lkICopIGptcHRvOworCSAgdWludDMyX3QgaW1taGkgPSAo
b3Bjb2RlMSA+PiA1KSAmIDB4N2ZmZmY7CisJICB1aW50MzJfdCBpbW1sbyA9IChvcGNvZGUxID4+
IDI5KSAmIDB4MzsKKwkgIHVpbnQzMl90IGltbTEyID0gKChvcGNvZGUyID4+IDEwKSAmIDB4ZmZm
KSAqIDg7IC8vIDY0IGJpdCBzY2FsZQorCSAgaW50NjRfdCBzaWduX2V4dGVuZCA9ICgwbCAtICgo
aW50NjRfdCkgaW1taGkgPj4gMzIpKSA8PCAzMzsgLy8gc2lnbiBleHRlbmQgZnJvbSAzMyB0byA2
NCBiaXRzCisJICBpbnQ2NF90IGltbSA9IHNpZ25fZXh0ZW5kIHwgKCgoaW1taGkgPDwgMikgfCBp
bW1sbykgPDwgMTIpOworCSAgaW50NjRfdCBiYXNlID0gKGludDY0X3QpIGltcCAmIH4weGZmZjsK
KwkgIHVpbnRwdHJfdCogam1wdG8gPSAodWludHB0cl90ICopIChiYXNlICsgaW1tICsgaW1tMTIp
OworCSAgcmV0dXJuICh2b2lkICopICpqbXB0bzsKIAl9CiAjZWxzZQogICAgICAgaWYgKCooKHVp
bnQxNl90ICopIGltcCkgPT0gMHgyNWZmKQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY3Jp
cHRzL21raW1wb3J0IGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CmluZGV4IDBjMWJj
YWZiZi4uNTU4MzA5OWJiIDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvbWtpbXBv
cnQKKysrIGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CkBAIC03Myw4ICs3MywxMSBA
QCBFT0YKIAkuZXh0ZXJuCSRpbXBfc3ltCiAJLmdsb2JhbAkkZ2xvYl9zeW0KICRnbG9iX3N5bToK
LQlhZHIgeDE2LCAkaW1wX3N5bQotCWxkciB4MTYsIFt4MTZdCisJIyBOT1RFOiBVc2luZyBpbnN0
cnVjdGlvbnMgdGhhdCBhcmUgdXNlZCBieSBNU1ZDIGFuZCBMTFZNLiBCaW51dGlscyBhcmUKKwkj
IHVzaW5nIGFkcnAvYWRkL2xkci0wLW9mZnNldCB0aG91Z2guIFBsZWFzZSwga2VlcCBpdCBpbiBz
eW5jIHdpdGgKKwkjIGltcG9ydF9hZGRyZXNzIGltcGxlbWVudGF0aW9uIGluIHdpbnN1cC9jeWd3
aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MuCisJYWRycCB4MTYsICRpbXBfc3ltCisJbGRyIHgxNiwg
W3gxNiwgIzpsbzEyOiRpbXBfc3ltXQogCWJyIHgxNgogRU9GCiAJfSBlbHNlIHsKLS0gCjIuNTAu
MS52ZnMuMC4wCgo=

--_002_DB9PR83MB09238A32DBD70B395AE2EDEB9259ADB9PR83MB0923EURP_--
