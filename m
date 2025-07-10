Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on20716.outbound.protection.outlook.com [IPv6:2a01:111:f403:2606::716])
	by sourceware.org (Postfix) with ESMTPS id 9E34D3858CD9
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 19:21:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9E34D3858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9E34D3858CD9
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2606::716
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752175307; cv=pass;
	b=Ql08ZvpUmqIAnenfwMsIx6srX74foHOBkxUAJLvm4ABmu/d127l5ikPPHfYx0YJDpD2afyATBvcsW61GZnIzu/AeI8phKlhxes7/mBAUUzzFdEZcJ751z0PwAUcTFZrcFDNwMxx/ZJbyuCM4ARtIFkINooEl4us6TkeuXw9u2Ik=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752175307; c=relaxed/simple;
	bh=Au1quJTphOT8yZRdPC93/R2GJwiN9QdYQR4PqMJlxI8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Lp9SMg4Xt7HwCQCJuyejqdrSaRE2Tb8zjKRXCsw1RblaXyTyM5WzzFX14Jyb2e/fC1rnLyHu317E4vdHpivpthiVA2trxFSWA47vYBrPsp8+44Gt9YU25u7aX1Lk8uJpRgEKOfJsxsWdMPkpEDrBhugTrM9Tt5E8dJbls7ZnFdo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9E34D3858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=Ocojs23Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjiGLF8drpAihu9/wabMOuv1q9a/FgbHWZ/Youy+ipBCMOHFYXMbIKzsL1tZfgVQ2TM5mIxP9vqvBdYc1Xu3RmaLnbl71/L3JK0ebfs+fm0jSaVbKF4RpaBeg35M0UtUFTpQXjL/IRGzs67na4ByuNjskHJtCp9kEK7cxP7dcGIC6/hzXhhpe+Kk10BORxcif4LVaNhl+KVcI9E0CAG0e4jWkQapUvf8lDYNJtMxm0lD5K2p9OoW+0cvhxQGoXOXdzG0WuRAI7O31CVmrTtMTAuHD5gAhXvEAlJ6rH1TRhlf3vVoQMJtJs9DaiEGofjDy9Gwve9Us8Jzm5WWBPgwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gquflayYI0fUyMbzrdJaP2j2vkZDx5881NYNZrLxLA=;
 b=HxEDj58XC5tEszNSFSxpwDtk0lzMwKOz/BpML/aJzor+ftyL72K9N2Tm3xa7eVDPTXJsm6ta0xNLJ9A6JikCLurrnJu+B4+YAgDHx68KiuyRTrYdQulWQB/Rlm21CccISiutqtkpgpNPpe7MrutUjPTWKSJu1cTSja4M3n29OqELnAOiad+saGVi4GyYujHaaYNx6+K4gqiW8yLYb/Y7yuePdDrNT2a4cTxMLBFilGKc78H57NNGL3Pnq4oHizrF3eh7sVbmgjN/BjWOsxURYD0HYBcu5YKiLPmtwoctpNWfoWsV4rgSz5TKo6Dz4o3BUJzhZuOfSUnn3k/6Pt4+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gquflayYI0fUyMbzrdJaP2j2vkZDx5881NYNZrLxLA=;
 b=Ocojs23Z+iJu6Xh3Ozfg98vKM39yqSVJl0raYLUfHjtGIfZx0jc/UJydVnwKB9KL4mOkZKAjtQYGd+adwUO8V39RDanZM3KV5b9AS792L4ZWWc3DHYMkuIMaBIQzmPcorNa3QobzM/K4UhNu//f5kAc/Pp4B+h5UDlOHB/j+T74=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0818.EURPRD83.prod.outlook.com (2603:10a6:10:58e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.10; Thu, 10 Jul
 2025 19:21:44 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%4]) with mapi id 15.20.8922.023; Thu, 10 Jul 2025
 19:21:44 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Thread-Topic: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Thread-Index: AQHb8c98UO3l6Yj5Mk+U7ImBGJ/smQ==
Date: Thu, 10 Jul 2025 19:21:43 +0000
Message-ID:
 <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T19:21:41.147Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0818:EE_
x-ms-office365-filtering-correlation-id: 20ff18ce-c348-4a44-e6a4-08ddbfe70159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L05halF1dDNXUkR3MjVxYkR2SGpzVzlHeFNiZDRQQ3k4aVZTSzhuVmNjbGdK?=
 =?utf-8?B?VDFwU2JGSHpwT0xFNDBEc0MyRU1Bbm9ENEV3T201QnJsRlNFU1B5b0VLK0Jk?=
 =?utf-8?B?Vk5INHQzcW5qQm9vck8xa0FkU1dZUTlRUmI5dUt0VG5yMUlWR2M4WGpraEl2?=
 =?utf-8?B?SDVMVUhyclZPM3FsamhuZ3NhMERKdHpuQm8xcEMvUkk3NHc1V0p4ZlZOazV0?=
 =?utf-8?B?dTRwelY4SFY1UDEzclJFdmdia0Rra21ZeW9xQzhwNXRQMnF2ZFg5bWhmcTdE?=
 =?utf-8?B?VU1tOEMrb1A0QUxBN1p4N1VDakxJM3dmM1NBTkNCRlNrRW44YkcyK2ZETExP?=
 =?utf-8?B?UmNuNFFEb2tmMUs1b0NwcXA4VkRqMXB6ZWVmYXBqQWhxQW9XZWY3VUxERHox?=
 =?utf-8?B?T01uZkFXRjBzREdPRU5GMWhNUnloRmFaUnl5T1lzakVqS3ZFaGRuT2o2UDBv?=
 =?utf-8?B?Nk05L0IzdStuN3krcldZWWNIUm04cWp5Nm5hVFlSZ1Uwb3h5dUNPWjFzZUxO?=
 =?utf-8?B?bmRIN21GRlNneG9aQS8xT2ZNWjNuMnVNN05YVVcrRlJNK1BkQnlIdFBIK093?=
 =?utf-8?B?bUg2MG1CVHF1cHJaMUZjZ3BONGlLYytUR01xNjhnWTVGVWxkK0FGMVh5ejRB?=
 =?utf-8?B?L2d6ckJXSXBMMEZtSk9YNWFCYjRCT00rTWFONjJSN254ckxleDRGVTZzYjJV?=
 =?utf-8?B?N2p2T1BtQjNxVTNHVTJNVG05WEtlS2lWdnRSc1BBeUJUb3krNHZlRUNua001?=
 =?utf-8?B?dExVWVJMTk8wL2xjYzlaa1NwSFRZMVNLbXFUeVAxMWFwN29KL3RMb2hNWnBJ?=
 =?utf-8?B?aHl2Wklsb05salQyTFZPdzVGYnVUbkJKOUVzRGxTcHdOcjZEbE9SaHNndVkw?=
 =?utf-8?B?c0VVckhOekhjckRoL1BaUVEvbXFpbXZ3aU5pemVOOGg4ZjRQcjJwR0JVVXor?=
 =?utf-8?B?V0I0RUVIVzg2OVV3UFFPN3lld1R3Um5NcFRwQklJcXRKQmlWVHRIRzVzUnlQ?=
 =?utf-8?B?SjJBSmh0dWZOamlIUWQ4VUZXKzl0Qk5jVVhZa25NQU1CdGY0OThrc2FIbXdh?=
 =?utf-8?B?ME5aKzQrc1NxOUl6Y2tLYnhmWkFKNVRzOHB6cGxpQktpVHEyT2ttZEpDVVFk?=
 =?utf-8?B?N2V6K3ZaZFV1dDN1bXVucTFxRWphbk5XM1FORnNFcEVjbHpuS2xxNk1MZERy?=
 =?utf-8?B?T3BVc3VwNzRINzNwRnU2WVN1RlZlZDF3eFFiWi9WQ09UZTZmeWhJamN2dkNX?=
 =?utf-8?B?ZFFwWUF4bCtDKzNoRmcrbk4yQXgxQzJ0TEZXWUxEYnlxcnpveWNWcGdGRk5W?=
 =?utf-8?B?bUxOZm54R2k3NUlXZWpwa0RvbEQ2cm5XMlgxNm9DenlwT2grV05YRnhDVFla?=
 =?utf-8?B?dHRlQWFZT0FjVXY4UTBxVWJkTUZ0Rkw5VFV6ek9rVGRmN3gvRjBFYmdyRnVm?=
 =?utf-8?B?V2tXdVpuSzFSSVhUUFUyQkNScnRYWE5CMWpYR09IbCs4dmxybzJkT3NvT3FD?=
 =?utf-8?B?eWo5WlpIeE00cVF4ejhiOHcxNG9ra0dVNVdDVXowbDJTK25icVQ3T0VuV3Zu?=
 =?utf-8?B?ZnVxVkVWcjVxdHltM1RlSVVWajNHbjZNN2NCMmJBTWZ1SjJUSG8wN2hMN1c1?=
 =?utf-8?B?OVJYdWZZclZIejJjb0Fwd3FGblAra1BCM3ZoWTdQcnFNZnBSM05LZmlHZkUw?=
 =?utf-8?B?VDFOMVMyTVJlNS8zY2NvLytBYTEyakFJL2JldDhYODBWVldZZVBiandzb3Bp?=
 =?utf-8?B?TEI3NlNLdEo1ZUlibGpqeU5RcmdoM3VOeFoyNlpHa3NSQmQ5Q1BPandkUVps?=
 =?utf-8?B?M01HZlVKUDZObjZGNmUzS1VyY3FhbS95K1pkVVVROW1uTUtJNlBFWnJmWjlo?=
 =?utf-8?B?TlJ3RUtDaEhVeFBNWUdXWnQzc3FYa21NNUt6ZURCUis3K1c5UHNrOWxQUzdG?=
 =?utf-8?B?Q0tGa256Mi8zQUdxSG1ady9ybWx4QkVlZmJhczRla1kvUlIyY2J6bEZxNzNz?=
 =?utf-8?Q?olURWF4ghROmn4Ls5qVaLsdbYFnbGg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlYyaWFtNHlQdkdUc25RWENMbmRRL3g2Ym1TY2w1TTkxUjk3NHpyblVnRGJs?=
 =?utf-8?B?WkxQYmpsSUQzVHRlMCtRNHY3dDd0dE5aSG0vWStmKzlveXdXTjZORVlIaTVP?=
 =?utf-8?B?aFVhTUo4UlZjb0x0VzVnaFpzRkVLTTR3QmlmbVAremtBdDQ0Q3hmMTdnOHpP?=
 =?utf-8?B?OFRoaEV0RmtmNEc2c2RwQklLV240Sk9Vbkp5aHk5U0F3MHJ4WU1UQS9XOHJy?=
 =?utf-8?B?NnF4QzlFcEZrZExmVkhFN0tUM3I3Q3hzT0ZXRE1RbXI3Ykh6bVU1c1I4a0pU?=
 =?utf-8?B?aGVUOXhhSjg2SEdhZEhkK2I5c1c3RW82QmoyTkZSVXVCdVJ2dk1yWFA5UHdm?=
 =?utf-8?B?Tzg1ZFdUcjl3UEdESTV2Nmk4T2pUcDc5ZzV2d3JqZGJCdVZJdEdBWGJhZHpY?=
 =?utf-8?B?MG5SZklMZWdmRGcyOG0wQkpQbWRqOE5lQWxPMm00MTRGZ2ZxUmM2OXIwNVU5?=
 =?utf-8?B?c25VNlR5UVRVd01VS2dtWmNDUFF2NkhXYVhIZmh2WUprQTk5T2NoaGJlUWNw?=
 =?utf-8?B?UXA1Tjd0Z0tWNmM4L2NBWldFUHFaMTQwRlNTTmdjcUJVTi92cGE4ai93dS9W?=
 =?utf-8?B?ajF4enU1djRUczRjMHlNM2VWb2xFOVNCTWNpemVXbU1XcWkxU0NjdnFZR1hU?=
 =?utf-8?B?aWoyRUI2VmEyRUtXM3lNTTgvQkRtcXdjQ2pxc29kbjAwTU1MUlduU3FoQ1VP?=
 =?utf-8?B?Nlp4cWJockxDWnk1djB0S1J2dlprenRQbzVqYXpZbkU1RitJYWJGcGxHcTRN?=
 =?utf-8?B?aFJsY25RcmdhTFRJYVdaMDNsb25pb3NWU0htYnB1aXRIWGJoVzFpb09ldlAy?=
 =?utf-8?B?YzNtYStPR2pGU290Rm03aHlCNm9FRTJYcnhvbUQyMy85WTF1bkRMc1JXSFNp?=
 =?utf-8?B?Z0l3OS8xeUhGOTBTekc2dERlMnJFMWpERlB6cCtFcnRUMjJKbHRpL1h4cjU4?=
 =?utf-8?B?TUkvRWRFTlk2cDAwVjRPMWV5MFlMVWNHaGFnRmRFOXJwcGJ0cnJ4ZGhkT25z?=
 =?utf-8?B?N2pKZjNsbE80UEtEV3k0ck5keWc3Rlp1TWg4WVVZQmZ6bEczVU9wYXNpbWZI?=
 =?utf-8?B?N3gxTGJCd3VrWmlrTWxtbzlvN1dNcjJqOGhjMDErT2kyMWdCcmJmYy9XRlFS?=
 =?utf-8?B?bWc0dHlQbGthRjg4NTZwR0gweDZkZEVEeXh1VS91QkRUZ3kxbS9oWU1zMURM?=
 =?utf-8?B?cGFZZ1l5YTBlOGkrMGJzemdwcmJOci83bEh4NFZyUGx4VTFMR054eWlPUzhT?=
 =?utf-8?B?TDR3ZzVqWHd4M3FKOFA4eE9ONFAzMm5PY0pPQ3lod3FlcXZmendCTU9KVmNP?=
 =?utf-8?B?Z2J1MlM4N05aa1NaSmIrVXplVmhzK0NQNzFScHUwSEJ6UXYrY1QxL3gzWVpl?=
 =?utf-8?B?aWh2YW4yc3BXU040QkduRTdETmNFc2YzdDNYRTJHMFBmVUZqK1RCVEpOQk9k?=
 =?utf-8?B?Wm5VcHJ5U09RNkVHR0pRRXJUYXVxaGhWMW91RTdKenh6bmdhZmNZRDkrYlpE?=
 =?utf-8?B?VjFLU0E0QWdwNDhrVGgxa3dkWWZ3K2FKVmJVQk9VZ2w3Y2Fnei9qTGE5VkxE?=
 =?utf-8?B?RnA1cWtEdDVCUEsyc3R4eWZhdXA0eU5nVjRTOUpwYkhpWVJ6WjVHTzdzRXQ1?=
 =?utf-8?B?K1h4S2V4RFgxL3dFQUhDdTBRblArYmJkWi9FOFBkUGR4SzNGK3YxYnpyUUgw?=
 =?utf-8?B?cVdLWmJ0MlExNkRqeHBTZitYcG5HbitUZWFvdm9OazM0SnU1WkJvTjB2WG50?=
 =?utf-8?B?R09XckxYTUVpTUtneUFub1p1KzR2dHprT2V4djZvQWhXYmgxNW5wOGE5elJK?=
 =?utf-8?B?c0k5dm5xdlp1ZEFQNEJ5ZGM1YVdXem1saVNGbXVzQytPMTduL2ZyK3pkcGQ5?=
 =?utf-8?B?THhQVjZmbXhXS05ZSWhBYkFHTDdqYzVqdmxQcFhFOTR3L1dVRVlUNTZ6M1Bq?=
 =?utf-8?B?bUFUVHhUbEo1QnFsOFdNRGxHQi9zWkl3MkdpL0ZhM1dMekI2YlNuTFpxWjZW?=
 =?utf-8?B?YTVTMFQreU1wRWUrdytTMlA0Y3ZheDVmaEh0YnpHNXlxU0Q1Q1YyMnYyZmdF?=
 =?utf-8?Q?ZYtK21?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB092300A5FEDFB941EEB3F5969248ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ff18ce-c348-4a44-e6a4-08ddbfe70159
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 19:21:43.6974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJLYkFM4epapDp4QbYf5dAkm2PIb0D6R8HI1A/Mz4Ka69VCbmBlKfaqgWe3/5JB6YmjNWjxTVlX18qhyOgfTXjK/G1wzoADLl4D65ybBdtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0818
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,BODY_8BITS,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB092300A5FEDFB941EEB3F5969248ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8uCgpUaGlzIHBhdGNoIGltcGxlbWVudHMgYGltcG9ydF9hZGRyZXNzYCBmdW5jdGlvbiBi
eSBkZWNvZGluZyBgYWRyYMKgQUFyY2g2NCBpbnN0cnVjdGlvbnMgdG8gZ2V0CnRhcmdldCBhZGRy
ZXNzLgoKUmFkZWsKCi0tLQpGcm9tIDhiZmMwMTg5ODI2MWUzNDFiYmM4YWJiNDM3ZTE1OWI2YjMz
YTkzMTIgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEV2Z2VueSBLYXJwb3YgPGV2Z2Vu
eS5rYXJwb3ZAbWljcm9zb2Z0LmNvbT4KRGF0ZTogRnJpLCA0IEp1bCAyMDI1IDIwOjIwOjM3ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBtYWxsb2Nfd3JhcHBlcjogcG9ydCB0byBBQXJj
aDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1V
VEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpJbXBsZW1lbnRzIGltcG9ydF9h
ZGRyZXNzIGZ1bmN0aW9uIGJ5IGRlY29kaW5nIGFkciBBQXJjaDY0IGluc3RydWN0aW9ucyB0byBn
ZXQKdGFyZ2V0IGFkZHJlc3MuCgpTaWduZWQtb2ZmLWJ5OiBFdmdlbnkgS2FycG92IDxldmdlbnku
a2FycG92QG1pY3Jvc29mdC5jb20+Ci0tLQrCoHdpbnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBw
ZXIuY2MgfCAxNCArKysrKysrKysrKysrKwrCoDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyBiL3dp
bnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKaW5kZXggZGUzY2Y3ZGRjLi44NjNkMzA4
OWMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKKysrIGIv
d2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYwpAQCAtNTAsNiArNTAsMTkgQEAgaW1w
b3J0X2FkZHJlc3MgKHZvaWQgKmltcCkKwqB7CsKgIMKgX190cnkKwqAgwqAgwqB7CisjaWYgZGVm
aW5lZChfX2FhcmNoNjRfXykKKyDCoCDCoCDCoC8vIElmIG9wY29kZSBpcyBhbiBhZHIgaW5zdHJ1
Y3Rpb24uCisgwqAgwqAgwqB1aW50MzJfdCBvcGNvZGUgPSAqKHVpbnQzMl90ICopIGltcDsKKyDC
oCDCoCDCoGlmICgob3Bjb2RlICYgMHg5ZjAwMDAwMCkgPT0gMHgxMDAwMDAwMCkKK+KAguKAguKA
guKAguKAgnsKK+KAguKAguKAguKAguKAgiDCoHVpbnQzMl90IGltbWhpID0gKG9wY29kZSA+PiA1
KSAmIDB4N2ZmZmY7CivigILigILigILigILigIIgwqB1aW50MzJfdCBpbW1sbyA9IChvcGNvZGUg
Pj4gMjkpICYgMHgzOwor4oCC4oCC4oCC4oCC4oCCIMKgaW50NjRfdCBzaWduX2V4dGVuZCA9ICgw
bCAtIChpbW1oaSA+PiAxOCkpIDw8IDIxOwor4oCC4oCC4oCC4oCC4oCCIMKgaW50NjRfdCBpbW0g
PSBzaWduX2V4dGVuZCB8IChpbW1oaSA8PCAyKSB8IGltbWxvOwor4oCC4oCC4oCC4oCC4oCCIMKg
dWludHB0cl90IGptcHRvID0gKih1aW50cHRyX3QgKikgKCh1aW50OF90ICopIGltcCArIGltbSk7
CivigILigILigILigILigIIgwqByZXR1cm4gKHZvaWQgKikgam1wdG87CivigILigILigILigILi
gIJ9CisjZWxzZQrCoCDCoCDCoCDCoGlmICgqKCh1aW50MTZfdCAqKSBpbXApID09IDB4MjVmZikK
wqDigILigILigILigILigIJ7CsKg4oCC4oCC4oCC4oCC4oCCIMKgY29uc3QgY2hhciAqcHRyID0g
KGNvbnN0IGNoYXIgKikgaW1wOwpAQCAtNTcsNiArNzAsNyBAQCBpbXBvcnRfYWRkcmVzcyAodm9p
ZCAqaW1wKQrCoOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAgiDCoCAocHRyICsgNiArICooaW50MzJfdCAqKShwdHIgKyAy
KSk7CsKg4oCC4oCC4oCC4oCC4oCCIMKgcmV0dXJuICh2b2lkICopICpqbXB0bzsKwqDigILigILi
gILigILigIJ9CisjZW5kaWYKwqAgwqAgwqB9CsKgIMKgX19leGNlcHQgKE5PX0VSUk9SKSB7fQrC
oCDCoF9fZW5kdHJ5Ci0tCjIuNTAuMS52ZnMuMC4wCgo=

--_002_DB9PR83MB092300A5FEDFB941EEB3F5969248ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-malloc_wrapper-port-to-AArch64.patch"
Content-Description: 0001-Cygwin-malloc_wrapper-port-to-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-malloc_wrapper-port-to-AArch64.patch"; size=1564;
	creation-date="Thu, 10 Jul 2025 19:21:09 GMT";
	modification-date="Thu, 10 Jul 2025 19:21:09 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4YmZjMDE4OTgyNjFlMzQxYmJjOGFiYjQzN2UxNTliNmIzM2E5MzEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmdlbnkgS2FycG92IDxldmdlbnkua2FycG92QG1pY3Jvc29m
dC5jb20+CkRhdGU6IEZyaSwgNCBKdWwgMjAyNSAyMDoyMDozNyArMDIwMApTdWJqZWN0OiBbUEFU
Q0hdIEN5Z3dpbjogbWFsbG9jX3dyYXBwZXI6IHBvcnQgdG8gQUFyY2g2NApNSU1FLVZlcnNpb246
IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFu
c2Zlci1FbmNvZGluZzogOGJpdAoKSW1wbGVtZW50cyBpbXBvcnRfYWRkcmVzcyBmdW5jdGlvbiBi
eSBkZWNvZGluZyBhZHIgQUFyY2g2NCBpbnN0cnVjdGlvbnMgdG8gZ2V0IHRhcmdldCBhZGRyZXNz
LgoKU2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5j
b20+Ci0tLQogd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyB8IDE0ICsrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dp
bnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MgYi93aW5zdXAvY3lnd2luL21tL21hbGxv
Y193cmFwcGVyLmNjCmluZGV4IGRlM2NmN2RkYy4uODYzZDMwODljIDEwMDY0NAotLS0gYS93aW5z
dXAvY3lnd2luL21tL21hbGxvY193cmFwcGVyLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vbW0vbWFs
bG9jX3dyYXBwZXIuY2MKQEAgLTUwLDYgKzUwLDE5IEBAIGltcG9ydF9hZGRyZXNzICh2b2lkICpp
bXApCiB7CiAgIF9fdHJ5CiAgICAgeworI2lmIGRlZmluZWQoX19hYXJjaDY0X18pCisgICAgICAv
LyBJZiBvcGNvZGUgaXMgYW4gYWRyIGluc3RydWN0aW9uLgorICAgICAgdWludDMyX3Qgb3Bjb2Rl
ID0gKih1aW50MzJfdCAqKSBpbXA7CisgICAgICBpZiAoKG9wY29kZSAmIDB4OWYwMDAwMDApID09
IDB4MTAwMDAwMDApCisJeworCSAgdWludDMyX3QgaW1taGkgPSAob3Bjb2RlID4+IDUpICYgMHg3
ZmZmZjsKKwkgIHVpbnQzMl90IGltbWxvID0gKG9wY29kZSA+PiAyOSkgJiAweDM7CisJICBpbnQ2
NF90IHNpZ25fZXh0ZW5kID0gKDBsIC0gKGltbWhpID4+IDE4KSkgPDwgMjE7CisJICBpbnQ2NF90
IGltbSA9IHNpZ25fZXh0ZW5kIHwgKGltbWhpIDw8IDIpIHwgaW1tbG87CisJICB1aW50cHRyX3Qg
am1wdG8gPSAqKHVpbnRwdHJfdCAqKSAoKHVpbnQ4X3QgKikgaW1wICsgaW1tKTsKKwkgIHJldHVy
biAodm9pZCAqKSBqbXB0bzsKKwl9CisjZWxzZQogICAgICAgaWYgKCooKHVpbnQxNl90ICopIGlt
cCkgPT0gMHgyNWZmKQogCXsKIAkgIGNvbnN0IGNoYXIgKnB0ciA9IChjb25zdCBjaGFyICopIGlt
cDsKQEAgLTU3LDYgKzcwLDcgQEAgaW1wb3J0X2FkZHJlc3MgKHZvaWQgKmltcCkKIAkJCQkgICAo
cHRyICsgNiArICooaW50MzJfdCAqKShwdHIgKyAyKSk7CiAJICByZXR1cm4gKHZvaWQgKikgKmpt
cHRvOwogCX0KKyNlbmRpZgogICAgIH0KICAgX19leGNlcHQgKE5PX0VSUk9SKSB7fQogICBfX2Vu
ZHRyeQotLSAKMi41MC4xLnZmcy4wLjAKCg==

--_002_DB9PR83MB092300A5FEDFB941EEB3F5969248ADB9PR83MB0923EURP_--
