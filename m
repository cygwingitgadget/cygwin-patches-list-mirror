Return-Path: <SRS0=OgUa=ZC=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072f.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::72f])
	by sourceware.org (Postfix) with ESMTPS id 8C6A43857032
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 07:23:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C6A43857032
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C6A43857032
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::72f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750317828; cv=pass;
	b=p54N5jI6DlnliywJgZs+7cQGZsLdglDKB13GKRcI2b7vrde0jHV4kKcw531FA0OHurGoLLRnOUxG8dliHKAhCsrX3ftvPWwRTtc9Hz2oPUenb6fLox1OP8xRJVYHhjA4QgPiPLjuMM3TUfyj4BdO7cysDVco3hJoSotmywD8G0A=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750317828; c=relaxed/simple;
	bh=cZ93Gyq23eRNW5el7OwnT4Bb6f/XGG1FqryOc3rus1I=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=cYJRUkT7mJH7imJfD36958k8Yx0557TDNgNIkiXedkxqVTjPv4jNR0bapwDyNLQ//QvsJvUnrJokw2EJATEGW9a7CY5JDw01YAwWCpiexPTz7PkW5JEs1kjvlREYKVaSfBikRESIMhJzNDlmaUXBsP50V4IUz1dIKReoCEvkwRI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C6A43857032
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=NoThUb1S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzHWi8lFTdNNrJ/5Kyt6vH/eB+16grd22XKug/BTLXMsH6+DW6x4Wo0GzlgfgZxXX3eqNu8qBS8syCm9IZJFyqlcwKtkN7TJ/7ZmumBjbXc4sFHq5wqbnnVHHDma8Dg1MmzfI9OBZ5a1crj84zdYMs46jVPTCOVtCYXw4JhBTTpJvs6hoL0mb7nDWJPXwRCPxdSfrqDuD4rPx6WKkkO0IeSz7eWbxTYGoAeB1yw9KuG8Ne9atUcWGdrbEo5jJdAhfxt7TrjIji+LWs5X5TPX8SOb4ryhsDzMmQ4ACQp7N17GfTc7aZg26IYVPYu42vH+4Uten7Ogl8pWvKTg8K3O0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVkhHhATTjn/ghfP4Ofbc/x4sjjfkpgeA0Iawma+wac=;
 b=qTHp8CTUQkvjDv6Y2sHXDLuq/nGVhP3gJKIxidtdcZOmRhyKKs8ICTGYq3Q3ad3HEwNI/y4gU1Mwzh7AunacujxoImPopk7no0gWxm4/TnlQ6Jm+040+fZuvqRctg+A2ik/nvLV5/nxFF/ZuDsohBVnPXiUcwme7LbM6sKS/smTtdSUF//oCTczyJbmOE6/nvRzUbhU0wHNXWZzNpEghvSAgtjQfyHmDs/ln1bSycWY9OTbvjbMiTEM6yAPNdCdsE9bWi6WASkiB+xqdCNiDXpSuN9oB6QrFAU8TLidZeCqMO2Kl8/3CA8s6kecS4C2kvv3uhBvdQwUaHQSv7lX3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVkhHhATTjn/ghfP4Ofbc/x4sjjfkpgeA0Iawma+wac=;
 b=NoThUb1Sjl7CmEU8sV02ZHo2JpR/82LpYy1dAsQ0nlRwzl63FleVPlgIpYh71/ezqUrcGlUFsQZe6Q69aBtklO+RvikhrFcOc2WIvvTOdSUpjg3nD1O+qbfKjRtd6sm3AcnGB9CrQ9mwbLjnhXFt1VsVhZh3shIfezwa/S7sD60=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0680.EURPRD83.prod.outlook.com (2603:10a6:10:55d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 19 Jun
 2025 07:23:45 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.006; Thu, 19 Jun 2025
 07:23:45 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3] Cygwin: implement spinlock pause for AArch64
Thread-Topic: [PATCH v3] Cygwin: implement spinlock pause for AArch64
Thread-Index: AQHb4OsXmpz+VwGa9kuKl/xuxJrhPQ==
Date: Thu, 19 Jun 2025 07:23:45 +0000
Message-ID:
 <DB9PR83MB09234EABDFC5DAB5A16291A7927DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB09237758F38BC0ACB9AAB51B9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <c03e5943-d622-4381-8ce1-c85f1ffa3c69@SystematicSW.ab.ca>
 <e768114d-c2e5-7033-c30d-9991c5982f3b@jdrake.com>
 <7329e318-02fc-40d0-8f06-7c5ef8642182@SystematicSW.ab.ca>
 <DB9PR83MB092313132E1B9E5C8A8F91B79270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <2d42e239-1ed3-95ab-81d2-f310472e76c9@jdrake.com>
In-Reply-To: <2d42e239-1ed3-95ab-81d2-f310472e76c9@jdrake.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-19T07:23:44.901Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0680:EE_
x-ms-office365-filtering-correlation-id: 2879602b-b48f-4aa7-981c-08ddaf023a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXlzU1A3OFFiVTZoeXRwTnorQW9DMHIwNDJMSUFVbmFhTDIzc1kxS2hDSFNi?=
 =?utf-8?B?N1U0TlpSMUllcnVBaVBEOSt2dW9ISTdkYVVJd1FmUC9sYmY2NWdQVVlFOG9P?=
 =?utf-8?B?OEwzU1l0cWlCZEZUR3I1L2FSZXBieXBxcjRhTmVyMDY0aU9VRE9MNHVvTGVC?=
 =?utf-8?B?MFd1OFhkMDdPK3V4UE16aGMxQWRnbkl1V2s2SGhDRk5vSHRLd2s1b1M2NHh2?=
 =?utf-8?B?dnpaSU0vUEF0aDJSTG81SktaM2R6djF3Z2NYMUFVSFVwdk14WDdGVCtFT1lw?=
 =?utf-8?B?aVNPUzdZRVQ2RWJEUWxMZkdsN0pYNjlXa05jcllmY3lGSC8xRUpEbisxZXE0?=
 =?utf-8?B?M1hTU2lJelpvUG5aZDVwK3RPQ1ZVTDNUdXBVaTc0Y09WSXJqL2EzZnNmODRV?=
 =?utf-8?B?NFlialV1UDBiaUNMdVNxbWlHVC9RZy9SOURQd1pCTFJSaW9tVmRmU1EwWWI3?=
 =?utf-8?B?bFNFKzFnUWs3WFFZcnk5LzVYakJjWnh2NVhNeVp1RXlZRytlWUdPN2dSY3Fp?=
 =?utf-8?B?UnVEUENJMm9BMXM2eVhSMnJtdjYzdGs5bEp2eGVZRlhIb3Fza2I5cmJOcS9Q?=
 =?utf-8?B?ZTFBaDdmNVJPK3lvOEg1dE1KZnd1cVlVZzRTeDhYNzl3aG5LT2NwU005ZlNy?=
 =?utf-8?B?d3o5R0d2SUtOT0QvTkhuWEFtQ1hUUVpjaWF2WlgzKzVRM1dYYkRpY01lVUFP?=
 =?utf-8?B?MjRwVjdwMkpiWGUwRnEzRUJuSVp5ci9LWThhNEgvMFVwTWtyMlFLY2lMR2I5?=
 =?utf-8?B?R2R5UHJ2SHF2L3pXQ3B0bExUUnVqUjBkOFlLVFJHc2Y4YWh1RDU4K3VVSVh5?=
 =?utf-8?B?YjJ0dUFxeWRhRHNZYjVrN3VZcW5jazBTenJxZWlXanVaaEZJWlcvOCsyaFhJ?=
 =?utf-8?B?U3lFWUp4TUhRUEtvTlpKcnc5QjM5Zkg5YjkzdmEyaUhBUndUOFY1UGhpOVd0?=
 =?utf-8?B?NmN0ZTRuTmUzTzdQNkZua1BxV2k3L0FvZ3l2L2RNNThuMFkxZHdlOVpYaTY0?=
 =?utf-8?B?TGVndEJLZ3QzdXFMS21WMW9ZVjhIa1VDZ2paT1l2RHNRSGpqRjk5NWdSWUJL?=
 =?utf-8?B?VlZFR1pnWldjUEZtUUltYkROUjloSzdsa2I5V2RNVmNLV0p2Z0xteUxCKzlT?=
 =?utf-8?B?aXpINWQwYjZud2ZReExnWmZXajYybVExTkxNRWV2ZGVuZlhUTVpuWUdzZ0hH?=
 =?utf-8?B?Y0pjN3U4cWpDVVFHWWdUc09Ka204RTR5ZUI3RHAzRkNQb3RqdVBtYXBycHdu?=
 =?utf-8?B?UGFEd1ZpbVYvRU1hRjJPNlBVd1ZBOUtTRTYxZTcxZS9aclJHdkU2b29sTjh0?=
 =?utf-8?B?VEd5WHg5bFJCNldhODB3T0hCRkhkNmIxYTg3VXVhVDZ5a1MvRkZnbExaaGFV?=
 =?utf-8?B?UmpPTnZEUXJzWjR1dEdEakkyVVVMYlJGSmhmNFQvUlVsQ1kraEhxWkpnenpB?=
 =?utf-8?B?YXhvVisvN2w1ZXVHcWlKeXYxSFpDWTFRMlhoNTROeUk3Sm90YzN6ZDdBbHNF?=
 =?utf-8?B?U0RHRFpneFJIWGFlQ24xNkdhZmRqZHJqamUyZ1puWGl1RTVxVngzazlZRjJN?=
 =?utf-8?B?cG9BVjZMelJTR2hNbEJvWlVJN3AzK0lyWGlPN0lKcEErKzhYMnBCQnJGaGxj?=
 =?utf-8?B?Vi90Tkh2alpRQWFqdGo0NXZ2eXZKTDdWajd0VFNqeldudUlvUlk1MWdnWDVa?=
 =?utf-8?B?cEhXTTB4bEMxUm1MNm9sckRqaTNFNVoyRmhMNkU0ZGZwSVJ2cDRyZThIMEhF?=
 =?utf-8?B?MlVqUjNjT0hjZEtialFuOFA2dHJCMWtmN0ZVM2loMVhwL1FaZnA4RVlYRGdP?=
 =?utf-8?B?Z3p1UGtyWEZSMWpYNWVCOUk2TXYzM3ArZ3ljUWU4S0hydi9BUnl3a0JrUjQw?=
 =?utf-8?B?ZmdibFRUYkg3c3J5VmEwV0lQbnp2Tk1SeG1kcnNLeS9MYUs3WTYvRk9RRFlm?=
 =?utf-8?B?eHRnb3VBVUk0SUF4T05MQWtpbmlmSDNrdENoUUtZSUR5b05Rb0E1WVhXRExV?=
 =?utf-8?Q?h7ZOs8Tr+pVSVHtnZl0MMLQoh84Dyw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U250MXVxL1Y4Um9WMlFlMDhkaUNBVlg1bHRlR1p2TEpVZjlxalp4Z1pLN09x?=
 =?utf-8?B?akZqZlBZMEVWc2JNK29aNXdoZ2NyM2dOc1FwZmE2T2FtZ2FBWUtGWVpGYXJW?=
 =?utf-8?B?SVg5cmpZUmZTZ3g0MTBqc2V4OGYyaXhwaUtneFlSOTFhTk5IK3Z3c2VtQUxB?=
 =?utf-8?B?aWRRbzU3QWszWjNJWUdxTFVOS3hZT2FYNktjeGxKNlNubHRQdkVJeWZRZWpQ?=
 =?utf-8?B?U0FPcnc2Rzd5aG1mNitOZE9NdUhTUis3RVR2ZXppb3BLNEJxaTQ3bnI3bTZo?=
 =?utf-8?B?WnZIRk5vdTZacURrSVBzTHRLRzEvUE1rM0wyNEdrRWZnUkQzbzV1em5EaEYr?=
 =?utf-8?B?TnVWNjNRN2lzYW4yYXcrNXlWOWpldzJzQlJlcFpFTmM4czBNYkxWd3BKbVha?=
 =?utf-8?B?QmF5bndMcm1pZlQ2QjZyZHE1UG5Yencyd21WRCtMZE1VNGlKNGJzM2ZJcTFM?=
 =?utf-8?B?WCswZjVOMXU4Y2NBTG94VVFCVTlxN2pOcEFUOEppZlN2bTFqRFgraWNkMzFI?=
 =?utf-8?B?VCtvVUVJYk93WlhPcFFsVFRJVkZsOThvWVF5d0lRM1RBeFRhUjBKL2FQVXkv?=
 =?utf-8?B?S3VtZGx5VnZoWkU4MjA2czRIUWpPYnVzUDJTa0cwYXNzZHVkRThHL040N1p4?=
 =?utf-8?B?MDRQWVgyOFZrdWNkWXRWKzF5b0JlbC9pb2lyWis5R1oxNDh2aEtFREk1UGNC?=
 =?utf-8?B?dzJLTHE5bVcxVTEvWDR5V1gzNGxoZGtxbnBlT252RmNwV2pGTlRULzBxTUhB?=
 =?utf-8?B?dlNyNkZtY3pScE9ISGpYc2pFbURwOEYyaCt3T2k5SUtJV1pVWDY5WFZ5UVE0?=
 =?utf-8?B?YUJXUngyVmxxcFVwbGlsVERlL04vTEtMMG11dm04K2l3MHNZMkJMVjFiWG5s?=
 =?utf-8?B?Qm4vTk92eGwyVUNueVZYOGFOd3V3eDdrdkszWHhremx4akVpcXVTZ0hnOHgz?=
 =?utf-8?B?dHhIS3lyeEJqVzJRZ1FUbUNMdDlqeHUvV1ZZbGZhZUQxbkVQaFRibW84bFc1?=
 =?utf-8?B?N2FPRWIyMjhZVjVlaVAzbVdSZWlReTNHNGVZZlN4Wm93aVAwWDBkU3lhM3du?=
 =?utf-8?B?bklCL2dlditIZkpvck14V0FMR0I5RExGYkJpcEo4TytPeWZKL0t4Z29wUC9q?=
 =?utf-8?B?R0FzdUxaT20xdTdSYVVGS09Yb2czRWNQTjRXT2tEakQ2NHp5aHMwMERpWnZE?=
 =?utf-8?B?enQraDg1TnFTa3ZnblVMSGdvWGl6UnVHc1Y4MkpUSEowMU1VQlNRUmhHd1Ny?=
 =?utf-8?B?em54d3EyOHpLN1ZsODZzNVcvN0plUXBQVGNScnVMVVltekJ0MjBESHFnelEx?=
 =?utf-8?B?RHYrZklhck0wckdUR0prdGNmNG1kazlQZCtkaldnazlPWFBRK1VETDF4TmFp?=
 =?utf-8?B?RGpYWUJTR2thU0xQMkJ5WG4yOHM5TCthcWRHNWNCYnF3cEdJNHEyUllZSjBV?=
 =?utf-8?B?ejFHY0JyRllyNmxFUVpYUHVTaHNSaGxORTV5dDREbEgvZE13SlhHUkc4Vmwx?=
 =?utf-8?B?NmxHMVg3VFNoTHNRNzJ2STRNS2gvWnZvcEhJM3NUL3J5VWQ5c3VaRTUzMkhW?=
 =?utf-8?B?M1lLTWVtaHA2S0tTSEtZNm5hdE41cU1VNjE3RnIrRGdLN2Qzd1l3RnBRYTZt?=
 =?utf-8?B?OVJadCtITnRuaG9YNnRiZFo2QTBOUFhYK0RGbS96NlRuaXBMNTByMWNUNDJY?=
 =?utf-8?B?ZUdzbEpEU01SNWZLOU9xYllvTlRqYjhqRjZCcVN5OTFRSTB5NHlLV2hwdlB6?=
 =?utf-8?B?djNUN0c3WTJHUkxGSWxUcFZ0akZEcVVaMU5OWlZxOFVaVDhnWkhxOUcrYVQv?=
 =?utf-8?B?WW00OE9EUkZpNnhwSlU1azlYUE42NVFWTVJiMmx3ZS9UN1RENGV4b1pVZFZ1?=
 =?utf-8?B?VGF6T3BDTzVSQVpyWlg5NVBvbGw5bVI2allEQWZCTVY5QVpDV2c5LzhFYklk?=
 =?utf-8?B?RkZ1Qzc2b3BVY1R4YzVBcnFzV2ZXT0hNTnN2MHhyd3I2UHNadGE1bDV6anl4?=
 =?utf-8?B?NG9pdHk2VmNsVVJPUmZDMmJ1QUdkZUxOeEtpN1BwZGRuUkNzVHAvNk4yblJV?=
 =?utf-8?Q?2/yTEP?=
Content-Type: multipart/mixed;
	boundary="_004_DB9PR83MB09234EABDFC5DAB5A16291A7927DADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2879602b-b48f-4aa7-981c-08ddaf023a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 07:23:45.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lQa5pZsw+BYf0jYo3Se2ckOouZs3rj7JV+aCb+K7qU4prFoNE53RaTgnO0smU3MHC5v27CExezoGvs23+j6SVOwy0waehhVdrrAeP3+Ngc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0680
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,BODY_8BITS,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_MIME_MALF autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_DB9PR83MB09234EABDFC5DAB5A16291A7927DADB9PR83MB0923EURP_
Content-Type: multipart/alternative;
	boundary="_000_DB9PR83MB09234EABDFC5DAB5A16291A7927DADB9PR83MB0923EURP_"

--_000_DB9PR83MB09234EABDFC5DAB5A16291A7927DADB9PR83MB0923EURP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8uDQoNClNlbmRpbmcgbmV3IHZlcnNpb24gd2l0aCBTaWduZWQtb2Zm
LWJ5IGhlYWRlci4NCg0KUmFkZWsNCg0KLS0tDQpGcm9tIDI3MjZiNDBhZTFi
NDE1ODZlNDEwMTA1ZDVmZDUxNDlmOGU3ZjZiOTIgTW9uIFNlcCAxNyAwMDow
MDowMCAyMDAxDQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04
OD89IDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4NCkRhdGU6IFRodSwg
NSBKdW4gMjAyNSAxMjo0MTozNyArMDIwMA0KU3ViamVjdDogW1BBVENIIHYz
XSBDeWd3aW46IGltcGxlbWVudCBzcGlubG9jayBwYXVzZSBmb3IgQUFyY2g2
NA0KTUlNRS1WZXJzaW9uOiAxLjANCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFp
bjsgY2hhcnNldD1VVEYtOA0KQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdA0KDQpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0b8WIIDxyYWRlay5i
YXJ0b25AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIHdpbnN1cC9jeWd3aW4vbG9j
YWxfaW5jbHVkZXMvY3lndGxzLmggICAgICAgICAgIHwgNSArKysrLQ0KIHdp
bnN1cC9jeWd3aW4vdGhyZWFkLmNjICAgICAgICAgICAgICAgICAgICAgICAg
IHwgNSArKysrKw0KIHdpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wdGhy
ZWFkL2NwdV9yZWxheC5oIHwgMyArKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oIGIvd2lu
c3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaA0KaW5kZXggNjE1
MzYxZDNmLi4zMWNhZGQ1MWEgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2lu
L2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oDQorKysgYi93aW5zdXAvY3lnd2lu
L2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oDQpAQCAtMjQzLDggKzI0MywxMSBA
QCBwdWJsaWM6IC8qIERvIE5PVCByZW1vdmUgdGhpcyBwdWJsaWM6IGxpbmUs
IGl0J3MgYSBtYXJrZXIgZm9yIGdlbnRsc19vZmZzZXRzLiAqLw0KICAgew0K
ICAgICB3aGlsZSAoSW50ZXJsb2NrZWRFeGNoYW5nZSAoJnN0YWNrbG9jaywg
MSkpDQogICAgICAgew0KLSNpZmRlZiBfX3g4Nl82NF9fDQorI2lmIGRlZmlu
ZWQoX194ODZfNjRfXykNCiDigILigILigILigILigIJfX2FzbV9fICgicGF1
c2UiKTsNCisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQ0KK+KAguKAguKA
guKAguKAgl9fYXNtX18gKCJkbWIgaXNoc3RcbiINCisgICAgICAgICAgICAg
ICAgICJ5aWVsZCIpOw0KICNlbHNlDQogI2Vycm9yIHVuaW1wbGVtZW50ZWQg
Zm9yIHRoaXMgdGFyZ2V0DQogI2VuZGlmDQpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi90aHJlYWQuY2MgYi93aW5zdXAvY3lnd2luL3RocmVhZC5jYw0K
aW5kZXggZmVhNjA3OWI4Li41MTBlMmJlOTMgMTAwNjQ0DQotLS0gYS93aW5z
dXAvY3lnd2luL3RocmVhZC5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi90aHJl
YWQuY2MNCkBAIC0xOTY4LDcgKzE5NjgsMTIgQEAgcHRocmVhZF9zcGlubG9j
azo6bG9jayAoKQ0KICAgICAgIGVsc2UgaWYgKHNwaW5zIDwgRkFTVF9TUElO
U19MSU1JVCkNCiAgICAgICAgIHsNCiAgICAgICAgICAgKytzcGluczsNCisj
aWYgZGVmaW5lZChfX3g4Nl82NF9fKQ0KICAgICAgICAgICBfX2FzbV9fIHZv
bGF0aWxlICgicGF1c2UiOjo6KTsNCisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2
NF9fKQ0KKyAgICAgICAgICBfX2FzbV9fIHZvbGF0aWxlICgiZG1iIGlzaHN0
XG4iDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ5aWVsZCI6Ojop
Ow0KKyNlbmRpZg0KICAgICAgICAgfQ0KICAgICAgIGVsc2UNCiDigILigILi
gILigILigIJ7DQpkaWZmIC0tZ2l0IGEvd2luc3VwL3Rlc3RzdWl0ZS93aW5z
dXAuYXBpL3B0aHJlYWQvY3B1X3JlbGF4LmggYi93aW5zdXAvdGVzdHN1aXRl
L3dpbnN1cC5hcGkvcHRocmVhZC9jcHVfcmVsYXguaA0KaW5kZXggMTkzNmRj
NWY0Li43MWNlYzBiMmIgMTAwNjQ0DQotLS0gYS93aW5zdXAvdGVzdHN1aXRl
L3dpbnN1cC5hcGkvcHRocmVhZC9jcHVfcmVsYXguaA0KKysrIGIvd2luc3Vw
L3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3B0aHJlYWQvY3B1X3JlbGF4LmgNCkBA
IC00LDcgKzQsOCBAQA0KICNpZiBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRl
ZmluZWQoX19pMzg2X18pICAvLyBDaGVjayBmb3IgeDg2IGFyY2hpdGVjdHVy
ZXMNCiAgICAjZGVmaW5lIENQVV9SRUxBWCgpIF9fYXNtX18gdm9sYXRpbGUg
KCJwYXVzZSIgOjo6KQ0KICNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pIHx8
IGRlZmluZWQoX19hcm1fXykgIC8vIENoZWNrIGZvciBBUk0gYXJjaGl0ZWN0
dXJlcw0KLSAgICNkZWZpbmUgQ1BVX1JFTEFYKCkgX19hc21fXyB2b2xhdGls
ZSAoInlpZWxkIiA6OjopDQorICAgI2RlZmluZSBDUFVfUkVMQVgoKSBfX2Fz
bV9fIHZvbGF0aWxlICgiZG1iIGlzaHN0IFwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB5aWVsZCIgOjo6KQ0KICNlbHNl
DQogICAgI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0DQog
I2VuZGlmDQotLQ0KMi40OS4wLnZmcy4wLjQNCg0KDQo=

--_000_DB9PR83MB09234EABDFC5DAB5A16291A7927DADB9PR83MB0923EURP_--

--_004_DB9PR83MB09234EABDFC5DAB5A16291A7927DADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v3-0001-Cygwin-implement-spinlock-pause-for-AArch64.patch"
Content-Description: v3-0001-Cygwin-implement-spinlock-pause-for-AArch64.patch
Content-Disposition: attachment;
	filename="v3-0001-Cygwin-implement-spinlock-pause-for-AArch64.patch";
	size=2414; creation-date="Thu, 19 Jun 2025 07:23:15 GMT";
	modification-date="Thu, 19 Jun 2025 07:23:45 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNzI2YjQwYWUxYjQxNTg2ZTQxMDEwNWQ1ZmQ1MTQ5ZjhlN2Y2Yjky
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFk
ZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNv
bT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEyOjQxOjM3ICswMjAwClN1Ympl
Y3Q6IFtQQVRDSCB2M10gQ3lnd2luOiBpbXBsZW1lbnQgc3BpbmxvY2sgcGF1
c2UgZm9yIEFBcmNoNjQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBl
OiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXIt
RW5jb2Rpbmc6IDhiaXQKClNpZ25lZC1vZmYtYnk6IFJhZGVrIEJhcnRvxYgg
PHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIHdpbnN1cC9jeWd3
aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmggICAgICAgICAgIHwgNSArKysr
LQogd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MgICAgICAgICAgICAgICAgICAg
ICAgICAgfCA1ICsrKysrCiB3aW5zdXAvdGVzdHN1aXRlL3dpbnN1cC5hcGkv
cHRocmVhZC9jcHVfcmVsYXguaCB8IDMgKystCiAzIGZpbGVzIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaCBiL3dp
bnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmgKaW5kZXggNjE1
MzYxZDNmLi4zMWNhZGQ1MWEgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4v
bG9jYWxfaW5jbHVkZXMvY3lndGxzLmgKKysrIGIvd2luc3VwL2N5Z3dpbi9s
b2NhbF9pbmNsdWRlcy9jeWd0bHMuaApAQCAtMjQzLDggKzI0MywxMSBAQCBw
dWJsaWM6IC8qIERvIE5PVCByZW1vdmUgdGhpcyBwdWJsaWM6IGxpbmUsIGl0
J3MgYSBtYXJrZXIgZm9yIGdlbnRsc19vZmZzZXRzLiAqLwogICB7CiAgICAg
d2hpbGUgKEludGVybG9ja2VkRXhjaGFuZ2UgKCZzdGFja2xvY2ssIDEpKQog
ICAgICAgewotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2
XzY0X18pCiAJX19hc21fXyAoInBhdXNlIik7CisjZWxpZiBkZWZpbmVkKF9f
YWFyY2g2NF9fKQorCV9fYXNtX18gKCJkbWIgaXNoc3RcbiIKKyAgICAgICAg
ICAgICAgICAgInlpZWxkIik7CiAjZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50
ZWQgZm9yIHRoaXMgdGFyZ2V0CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3dpbnN1
cC9jeWd3aW4vdGhyZWFkLmNjIGIvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MK
aW5kZXggZmVhNjA3OWI4Li41MTBlMmJlOTMgMTAwNjQ0Ci0tLSBhL3dpbnN1
cC9jeWd3aW4vdGhyZWFkLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vdGhyZWFk
LmNjCkBAIC0xOTY4LDcgKzE5NjgsMTIgQEAgcHRocmVhZF9zcGlubG9jazo6
bG9jayAoKQogICAgICAgZWxzZSBpZiAoc3BpbnMgPCBGQVNUX1NQSU5TX0xJ
TUlUKQogICAgICAgICB7CiAgICAgICAgICAgKytzcGluczsKKyNpZiBkZWZp
bmVkKF9feDg2XzY0X18pCiAgICAgICAgICAgX19hc21fXyB2b2xhdGlsZSAo
InBhdXNlIjo6Oik7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorICAg
ICAgICAgIF9fYXNtX18gdm9sYXRpbGUgKCJkbWIgaXNoc3RcbiIKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAieWllbGQiOjo6KTsKKyNlbmRpZgog
ICAgICAgICB9CiAgICAgICBlbHNlCiAJewpkaWZmIC0tZ2l0IGEvd2luc3Vw
L3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3B0aHJlYWQvY3B1X3JlbGF4LmggYi93
aW5zdXAvdGVzdHN1aXRlL3dpbnN1cC5hcGkvcHRocmVhZC9jcHVfcmVsYXgu
aAppbmRleCAxOTM2ZGM1ZjQuLjcxY2VjMGIyYiAxMDA2NDQKLS0tIGEvd2lu
c3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3B0aHJlYWQvY3B1X3JlbGF4LmgK
KysrIGIvd2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3B0aHJlYWQvY3B1
X3JlbGF4LmgKQEAgLTQsNyArNCw4IEBACiAjaWYgZGVmaW5lZChfX3g4Nl82
NF9fKSB8fCBkZWZpbmVkKF9faTM4Nl9fKSAgLy8gQ2hlY2sgZm9yIHg4NiBh
cmNoaXRlY3R1cmVzCiAgICAjZGVmaW5lIENQVV9SRUxBWCgpIF9fYXNtX18g
dm9sYXRpbGUgKCJwYXVzZSIgOjo6KQogI2VsaWYgZGVmaW5lZChfX2FhcmNo
NjRfXykgfHwgZGVmaW5lZChfX2FybV9fKSAgLy8gQ2hlY2sgZm9yIEFSTSBh
cmNoaXRlY3R1cmVzCi0gICAjZGVmaW5lIENQVV9SRUxBWCgpIF9fYXNtX18g
dm9sYXRpbGUgKCJ5aWVsZCIgOjo6KQorICAgI2RlZmluZSBDUFVfUkVMQVgo
KSBfX2FzbV9fIHZvbGF0aWxlICgiZG1iIGlzaHN0IFwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHlpZWxkIiA6OjopCiAj
ZWxzZQogICAgI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0
CiAjZW5kaWYKLS0gCjIuNDkuMC52ZnMuMC40Cgo=

--_004_DB9PR83MB09234EABDFC5DAB5A16291A7927DADB9PR83MB0923EURP_--
