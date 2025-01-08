Return-Path: <SRS0=+JKb=UA=cornell.edu=kbrown@sourceware.org>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071d.outbound.protection.outlook.com [IPv6:2a01:111:f403:2412::71d])
	by sourceware.org (Postfix) with ESMTPS id D3AFB3858C31
	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2025 23:03:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D3AFB3858C31
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D3AFB3858C31
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2412::71d
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736377421; cv=pass;
	b=ho0BaNzu1T61CYNLl2PmFngjjsY3PasQeo1H9NqkmC0I1m9aoaBfd2pKaN89g4KVcSdsVDP6p4LtpeuuNGOgqs3l8XikM0xaVK2j5YTFoIXzSQOoKnaKdEhqEmLC7tr0puJ5wJrWj7YGnuDLhBeq5ZepWJxjY0dp9TGStxxynsY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736377421; c=relaxed/simple;
	bh=D00XQ/kh7652UKWaNX7d3qn7Df0gBePZ3flyFGNuDW8=;
	h=DKIM-Signature:Message-ID:Date:To:From:Subject:MIME-Version; b=dgVaDdRMgImlazFocVvKvNicLStvKfVFUwYS1lRv8/o6wkXeDWDwHDSHV0KUvQDDb7s5WMTWwAQDWXdX70YOrXblmQ6Q/xT83EW/CUFZ6D68NmV38/fFAiRrCuppQL4eM7tA3ZvTd/vw8UkULivB1DD9BXgPUiT7pPHxM6dzAd4=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D3AFB3858C31
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=EWuEfolp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnn04cui1Cycd6YVSQv1byOkAmZZUqz30kHv3X2Z8Gh/UczXH1l4qW2/QgQ6796Z6XseOYyDfCmzgMnHJ9zxucNJUCyHyHu1nRd3qHIe/lRom8ZTXN75krhhYn/2gSi941KB9+m3PWwVuhc0ntKtyvDKakflFJtwmSaiujI7hQfnLeXi74KuHc6yxX+BLAGAK4dgIxRLaHEjVuLLoiQ5VnFtVLevrqcbov7i5lKvgTLx5D3/dIDhZxUnp4aEvTPmtxVmLaQ+HWQaXfT3dP7zt3ec4w0h7GZ//q4jn1h/ai+YKrcX++ULWVmXjQ70azCNXfck1yqajDS1HSQwYj6q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D00XQ/kh7652UKWaNX7d3qn7Df0gBePZ3flyFGNuDW8=;
 b=uP7hmIN236vWFTsrYuIGqfNhawJYb2RzkumlgVetXZWMQJsARwLjRIkI41KdsRnAclYxjWKAG+ezNE+K5pFpPJJU7lUyaq81fBV6No+GUORStYzidtoejPgzs1EEVCNYx8ILl9jb+tfJ7jE6rWJz5F6/YGqJZ6Ggyje8juhX45hw+ylGJwJyplwMb9fEp7n1/65VrX7+NkGZ9DGQCVuQap3w47LrDw2mR1WAd4onC4q+Mwj8248sI3xVwlebjjp5vWJIgb4bqQtLEZqZGcvjjkBUuza3WaGtC49W8Q6ezxNcDENfBWRF4edi5zkmMf+8KipyN5m15AKUj6ZZKOdgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D00XQ/kh7652UKWaNX7d3qn7Df0gBePZ3flyFGNuDW8=;
 b=EWuEfolpSV9gMk61nZ2JDotPND30GXDzOe//Ie/J7KZITUoL9MNJ8PTTzI1xBuMz6kaIFMZkRh4O4BM8Q1eibS9MwJWh+BEa8cpTiEe8JHsH+KkL+A0Padd6bQmzRKdjo9jixw+a9LMhrpEt3tAQI5RVrYdO1q+qbDkirH0EWeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DS1PR04MB9654.namprd04.prod.outlook.com (2603:10b6:8:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 23:03:39 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 23:03:39 +0000
Content-Type: multipart/mixed; boundary="------------Dg0v9BJXTZHdKAx5Bw2VPAzT"
Message-ID: <9d64113d-0355-4df3-b477-952c4f315292@cornell.edu>
Date: Wed, 8 Jan 2025 18:03:37 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 1/5] Cygwin: mmap: refactor mmap_record::match
X-ClientProxiedBy: BN9PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:408:fb::8) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4204372a-2e12-4453-4931-08dd3038b043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTJqZWNxQ2xZT3pHMjRXWHk2Mm5NMW9PME5PMVBhQzJUSkdoQ3M1SVBBZEhZ?=
 =?utf-8?B?SDBEVDM2aDczVG94c0lvWGFZNUpGaUxmbENwR1pBbHdzcEdDT21GT2VSY0tr?=
 =?utf-8?B?M0tEWjB4NlUvY2QwZk5PS2kzRG5nZENJVlRGQkNEMU03VnFpS3hrb0VLQzdR?=
 =?utf-8?B?ZnlZQ012R21FSml0b3U2S1phNG42emgyREFidytIN3JxZUV5b2VJTk96SGtW?=
 =?utf-8?B?WVhZLzJXdGtheGVwMFI1NE9SVnhlelVxOTVHL3lrSmI3RURyRDh3M3dOM0dh?=
 =?utf-8?B?VEs4WTVEazk4U0xOUE1hWHJnNTlIbjJWanFSS2ZGUFI4NGU2WHhtb005WWtz?=
 =?utf-8?B?cDNnNklaeHNBRnBDSDQ1VEFTLzVNbW5RdU5PN2x1S2pGeFVhNDQ5VURGTlhH?=
 =?utf-8?B?eFpLeWRBZFJ5dEFjdDVjYVBET2ZGSGg5RkpWdXNueXJSRmRsUE1lOU5YYjM0?=
 =?utf-8?B?S0c5d3JYb1hOeWIvQkk3UWRvUDdSWXh4UnJDOERHN0RGSjdiTmxwaFdxaHJB?=
 =?utf-8?B?UWd0VUJjWmkwVUZzTzBTMmxrK1lLVzZxOXVMbk55ZTBHU05zZ2RBYVJiak5i?=
 =?utf-8?B?YnI5OG5ydFp6MUZEcU1FL0VINUxmWHZIbXFoWHZHY01KYXJDcXBBNEpXcjYv?=
 =?utf-8?B?N1N0NkRRek90MWFFTzlKNUYrMzR5WFVPZ1p1emxVendCR0dGVnlmSmthb0hm?=
 =?utf-8?B?TU9xeCt3YWRlYkhlOUNuNW9qMmtMSURacHMyMWFscDJtWlBGbDg3Mzdxa1Ji?=
 =?utf-8?B?YS9MQnVzbFk5Q2FqWHV3Q3FuamdyVmZVMGgxSHU3VXFPVExOVXBHUEljY1hr?=
 =?utf-8?B?SGJvN2hGTVRUN3MyNCtjV0ZodVVVdS81ekZRcUtlK1lFVHRweGZJUVU2azJZ?=
 =?utf-8?B?eWpVS3Vuay9IWGdHK3hpMmMycFFyMHhjR0llV2lGb0NheXdiVVRJU2d0NzRR?=
 =?utf-8?B?SEVRSlZpdTcwS1FnK1pWQlFZK1VvSXFPK0gxVURmS0xXQ0tnMFFIK3pYWWl4?=
 =?utf-8?B?VmRNbVJqU1hBSHc0QjhFbkEzeW15aUc1aU5Jb3pRSE5OZEtMS2dUb2VZWFgx?=
 =?utf-8?B?dmNaS0pML0E5MjkzMWx2cHBZQ2d3a3FzdURrYlpXMU00UlBhdlRmNjFpd3VJ?=
 =?utf-8?B?alJveGo1ZFJhUm54NkI5WFEyZEg5ZGROdTBKWGtVNGJ1UnJCdmtHb3MwOG9J?=
 =?utf-8?B?eTZ6YldEUXZKNzhIaTZPOVdaeDQxanhmMDl0QTRQZnBwSGt3S2s0dWR2RmdW?=
 =?utf-8?B?WktnWW53OHJVWFJxVTRkdXNoUEt6anBqRGRRdWJzdlVSMDRla1VQSEVPM3ly?=
 =?utf-8?B?bVV0RzZQZ2ZzZEZvYWR0L3B5ZFptYWJrQVI0c0VYYVdGZlBUbjBCRXN1QjNO?=
 =?utf-8?B?YVFqa1hmMEtxWEQvTzU4em9Eam4yNVBKRHJzNUNXQWZHZGlOcldhd0crMmdh?=
 =?utf-8?B?RithREVLbTR2YUJ4bElRRU5QY1JBVkxYdFE4RS9ZQTMzZW11SFRUa3A3QmRt?=
 =?utf-8?B?QWdmTUZnaXVnL0Ixd1JiRElHZjFoV2pGcEdwOWw4aWVDNVZsdm4wRlVzcnJ6?=
 =?utf-8?B?SG5DQUJzMjBEOUlpVkMxeHg3eFFHbnY1MFp0WFlxd0lpOUNOUk9XRlc3Q1lK?=
 =?utf-8?B?RUtyV281SnUwSDJwU2hralNySE5VSS9Gc0JYREZ1R0lyUGo0YnN1N1BNVlNK?=
 =?utf-8?B?YnJmajBidm8wL2hGRUNMc3c4OWx2YUdZY2JONithNGtwVW9Pc080L1JjMzRv?=
 =?utf-8?B?MHdIV1FzUUtMUlRsRVM3ME1HTWViTW5BNm1TWklQVUNsNnBWUjRwWEo5ckRl?=
 =?utf-8?B?UDg1dC80OTRuSWNab2tQdXFOeHZydlhzSGcxTUZvZi92Z0JsR0Z4b2t5WG1V?=
 =?utf-8?Q?XDcAIGd5aANNy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejBNd2pnZngzd01rOWZrR1NQM2dBRE9ka3l0MmZBc2RwbGR1eU5BQTBjZnlo?=
 =?utf-8?B?YVhRQXhyMVZzWGhXYU52ZjhwQUZQbG1Cb0xFZFdQcDExTklnaE9mQ21STThp?=
 =?utf-8?B?UnI4SUlsQlB4R1B3ZDdTbXJVcGdBTVVQc0FsS2tmVUpjMWxSTWl0RGRJditi?=
 =?utf-8?B?d2s5UzEvRjBZV1RTQlYzSG42L3BCM00yeTZKUmZ1eUFINWVpWkxkUWdvbFZK?=
 =?utf-8?B?bnlHMVVtMEY5djU2WURUNDkvMm5Zb0UwZ3lKKytGM1dFRUZVSHpJSmJubGo3?=
 =?utf-8?B?akNoM2FOanBMYVh1OW9QQjYxdzM0SUhkRXpiMU1FRUhURTdGeURRRHNKYUlL?=
 =?utf-8?B?WlhjVVYwYWVaZ1BwZnpmakhjaGpXMldlMFFtVlJxM1ZQOW5TYUFGeDNoamt2?=
 =?utf-8?B?OTc1bUdOalpIbzFOTDgwOEtnR3lqZUkzWlp1Um8wS2dvd1JoeFdXRUVnUGZh?=
 =?utf-8?B?TGpRdmVOb1k4cGFDaG1DSTZwRkNEc20wRlVWK1RSQ1dNaklHaDB1eFYvRFU2?=
 =?utf-8?B?WEs5Y0hnNlRvclM4ZVdjVi9nSUhIa1FjQlQ3S2hrZU1xTzMxb2dldFhsNmVS?=
 =?utf-8?B?K2lpOEhFWHNxZUl5NW13eGRpYWNxaG1vQUFoLzZIY0hEeVc2L2N6YkNoVWlu?=
 =?utf-8?B?TEh5dm1lRmlIdHA4NmZ4bGNFOVhpMjlHRFFZTUNJOCtxNFZtbjEyakJuTVZW?=
 =?utf-8?B?UWFicWF3M25FT2w0RDJGZVNWOFNJamlCYnVveDIyYW1rREFwbU14cnFMT2gr?=
 =?utf-8?B?a3VYb2hTTDhqakFFaW1rMS8ydFZtR3I5ZzF4L29FRGwzZUtYVnlUS2t2YlYw?=
 =?utf-8?B?ZTF5ZDFwakNteEZnK1ZmQ2NUbzZEN0JXVTZXaTNvL2hhL1RENUlxOEpranky?=
 =?utf-8?B?Wkp0M1U1YXY5RjFOQlhtZDRMWXAyQXo0ZXFqZk1GVzAyZGZ2cTZNSDJMREdk?=
 =?utf-8?B?OTFHWE1kV3FmQk1uaHlBTTFyWmlPbzEzZVVFR2R1RDdQN3RoUFNkbDdld1c1?=
 =?utf-8?B?aEYwSW9BbmVEZzNKdmxqUlg5TXNpTTNuV2EyWDFnSDFUNjJvOSsrVDJaS1Bp?=
 =?utf-8?B?Q1BXYzRrKzBkeFhENEdjSzlyZVBReVZyUnF5VzdmTE9oOHRieVZuTG12NDVP?=
 =?utf-8?B?dHNwbmNmbXIzdC9OR1FYb0t5UGpEalZpWUhBRnk5SEN5NEJtbWFRRVJyN1ov?=
 =?utf-8?B?UVJlN21XY25BVlJ2bDRkbGpLY2RtNkdDSTJaSkdmVjhraVZZSmQ0MmFqcnl4?=
 =?utf-8?B?UHdMVE1MbFpEUWhMK0lic3B6MjdDMGhFYjhZVGlFaEw2aU9idXdRV3VpVFpC?=
 =?utf-8?B?N2xrSVV0TytZRFBuc2krd1MyQXRoYnNoaUVsUDRCYXhtYUhzSy84L3Y0WUIx?=
 =?utf-8?B?WmIzU3BUWUs2MnRPZ2pPTUhTcWF6S3ZUenFSMFpCZkwyNGFzdjNIQWVYbVhK?=
 =?utf-8?B?clpQWlhucWRLWWxCWTRtdFZqQllXQ3gzSHMyVS9LTjdPTnk5VlBFL2ltRVpF?=
 =?utf-8?B?MXNSN3dETUdEdU5lQ0xzcUdoT3ljdzZER0Jrc2NPWDVOejVuWVI0OFlrWDFE?=
 =?utf-8?B?Q094WHdURGNXNHprOW94V29rODg2blkxTnBuQWg3cUY1QXFiV2kxWUpFcUVB?=
 =?utf-8?B?L3VobjdSOU5jaENndEFaRFpYUXppMmVzT1hDYklJMGNWa1c4NHgvV2QyMnN5?=
 =?utf-8?B?NjkzYjVUTXZNZWZoZGVBYzBWQ1ZCZ3hEZXZRSFovdVR6RG9uakNIdTlFbEd2?=
 =?utf-8?B?Q082VXlnMGI1dlo5eEpZVDJjMXkxTHBhMFZmS2tIaVUwenErcFJ0U2xYVHhU?=
 =?utf-8?B?VEE3OUxkdDdscnlHZlUybEsvQkZycmgxeWkxMzRhWVFpdTNYWFd1eXBjbVhQ?=
 =?utf-8?B?ZlZrT1htTHFRWTQwNVJ5RkJiY2NEdktBMDlkSHZtTkd5UjlLRXc5RmtEUktZ?=
 =?utf-8?B?Z2lQb0hFYnBPaVZ6YkRKMFNMWGNDWDNmcXN2MFQvZEswK0tXNUFCbCtxYXBN?=
 =?utf-8?B?WEJxNXd4YVpSUjJETWRFN0NiQjRHM0ZVaFEyYjFNVmhTRFBCTFI2MjhJYWVF?=
 =?utf-8?B?cklZTG91ZlVnYWFjUzl2bm40MVVKK2x3ck5kVnRPWjVKa0VlamVWanJJUDhr?=
 =?utf-8?Q?YvTZPYqESgoIo5tqoys0SW7JY?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4204372a-2e12-4453-4931-08dd3038b043
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 23:03:39.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 077fJUUIdJeB0Duv0Y/iUpGI3CDNUZJYCneFuWoCODs9utODTqktq3QrXq/uO1029OMmoFVV1T9O2NpEHQpa4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9654
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------Dg0v9BJXTZHdKAx5Bw2VPAzT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
--------------Dg0v9BJXTZHdKAx5Bw2VPAzT
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-mmap-refactor-mmap_record-match.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-mmap-refactor-mmap_record-match.patch"
Content-Transfer-Encoding: base64

RnJvbSA0Mzg3YTczZDU1OTNkZGFkNGNmNzU5Mjg2NWI1YjI1N2U2YTlkNmRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
RnJpLCAyNyBEZWMgMjAyNCAxNTozMDoxMiAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggMS81XSBDeWd3
aW46IG1tYXA6IHJlZmFjdG9yIG1tYXBfcmVjb3JkOjptYXRjaAoKU2xpZ2h0bHkgc2ltcGxpZnkg
dGhlIGNvZGUgYW5kIGFkZCBjb21tZW50cyB0byBleHBsYWluIHdoYXQgdGhlCmZ1bmN0aW9uIGRv
ZXMuICBBZGQgYSBuZXcgcmVmZXJlbmNlIHBhcmFtZXRlciAiY29udGFpbnMiIHRoYXQgaXMgc2V0
CnRvIHRydWUgaWYgdGhlIGNodW5rIG9mIHRoaXMgbW1hcF9yZWNvcmQgY29udGFpbnMgdGhlIGdp
dmVuIGFkZHJlc3MKcmFuZ2UuCgpTaWduZWQtb2ZmLWJ5OiBLZW4gQnJvd24gPGticm93bkBjb3Ju
ZWxsLmVkdT4KLS0tCiB3aW5zdXAvY3lnd2luL21tL21tYXAuY2MgfCAzNyArKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNj
IGIvd2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjCmluZGV4IDAyMjQ3Nzk0NThlZi4uYWNhYjg1ZDE5
Y2YwIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21tL21tYXAuY2MKKysrIGIvd2luc3VwL2N5
Z3dpbi9tbS9tbWFwLmNjCkBAIC0zMzgsNyArMzM4LDggQEAgY2xhc3MgbW1hcF9yZWNvcmQKICAg
ICB2b2lkIGluaXRfcGFnZV9tYXAgKG1tYXBfcmVjb3JkICZyKTsKIAogICAgIFNJWkVfVCBmaW5k
X3VudXNlZF9wYWdlcyAoU0laRV9UIHBhZ2VzKSBjb25zdDsKLSAgICBib29sIG1hdGNoIChjYWRk
cl90IGFkZHIsIFNJWkVfVCBsZW4sIGNhZGRyX3QgJm1fYWRkciwgU0laRV9UICZtX2xlbik7Cisg
ICAgYm9vbCBtYXRjaCAoY2FkZHJfdCBhZGRyLCBTSVpFX1QgbGVuLCBjYWRkcl90ICZtX2FkZHIs
IFNJWkVfVCAmbV9sZW4sCisgICAgICAgICAgICAgICAgYm9vbCAmY29udGFpbnMpOwogICAgIG9m
Zl90IG1hcF9wYWdlcyAoU0laRV9UIGxlbiwgaW50IG5ld19wcm90KTsKICAgICBib29sIG1hcF9w
YWdlcyAoY2FkZHJfdCBhZGRyLCBTSVpFX1QgbGVuLCBpbnQgbmV3X3Byb3QpOwogICAgIGJvb2wg
dW5tYXBfcGFnZXMgKGNhZGRyX3QgYWRkciwgU0laRV9UIGxlbik7CkBAIC00MTgsMjAgKzQxOSwz
MCBAQCBtbWFwX3JlY29yZDo6ZmluZF91bnVzZWRfcGFnZXMgKFNJWkVfVCBwYWdlcykgY29uc3QK
ICAgcmV0dXJuIChTSVpFX1QpIC0xOwogfQogCisvKiBSZXR1cm4gdHJ1ZSBpZiB0aGUgaW50ZXJ2
YWwgSSBmcm9tIGFkZHIgdG8gYWRkciArIGxlbiBpbnRlcnNlY3RzCisgICB0aGUgaW50ZXJ2YWwg
SiBvZiB0aGlzIG1tYXBfcmVjb3JkLiAgVGhlIGVuZHBvaW50IG9mIHRoZSBsYXR0ZXIgaXMKKyAg
IGZpcnN0IHJvdW5kZWQgdXAgdG8gYSBwYWdlIGJvdW5kYXJ5LiAgSWYgdGhlcmUgaXMgYW4gaW50
ZXJzZWN0aW9uLAorICAgdGhlbiBpdCBpcyB0aGUgaW50ZXJ2YWwgZnJvbSBtX2FkZHIgdG8gbV9h
ZGRyICsgbV9sZW4uICBUaGUKKyAgIHZhcmlhYmxlICdjb250YWlucycgaXMgc2V0IHRvIHRydWUg
aWYgSiBjb250YWlucyBJLgorKi8KIGJvb2wKLW1tYXBfcmVjb3JkOjptYXRjaCAoY2FkZHJfdCBh
ZGRyLCBTSVpFX1QgbGVuLCBjYWRkcl90ICZtX2FkZHIsIFNJWkVfVCAmbV9sZW4pCittbWFwX3Jl
Y29yZDo6bWF0Y2ggKGNhZGRyX3QgYWRkciwgU0laRV9UIGxlbiwgY2FkZHJfdCAmbV9hZGRyLCBT
SVpFX1QgJm1fbGVuLAorCQkgICAgYm9vbCAmY29udGFpbnMpCiB7Ci0gIGNhZGRyX3QgbG93ID0g
KGFkZHIgPj0gZ2V0X2FkZHJlc3MgKCkpID8gYWRkciA6IGdldF9hZGRyZXNzICgpOworICBjb250
YWlucyA9IGZhbHNlOworICBjYWRkcl90IGxvdyA9IE1BWCAoYWRkciwgZ2V0X2FkZHJlc3MgKCkp
OwogICBjYWRkcl90IGhpZ2ggPSBnZXRfYWRkcmVzcyAoKTsKICAgaWYgKGZpbGxlciAoKSkKICAg
ICBoaWdoICs9IGdldF9sZW4gKCk7CiAgIGVsc2UKICAgICBoaWdoICs9IChQQUdFX0NOVCAoZ2V0
X2xlbiAoKSkgKiB3aW5jYXAucGFnZV9zaXplICgpKTsKLSAgaGlnaCA9IChhZGRyICsgbGVuIDwg
aGlnaCkgPyBhZGRyICsgbGVuIDogaGlnaDsKKyAgaGlnaCA9IE1JTiAoYWRkciArIGxlbiwgaGln
aCk7CiAgIGlmIChsb3cgPCBoaWdoKQogICAgIHsKICAgICAgIG1fYWRkciA9IGxvdzsKICAgICAg
IG1fbGVuID0gaGlnaCAtIGxvdzsKKyAgICAgIC8qIEkgaXMgY29udGFpbmVkIGluIEogaWZmIHRo
ZWlyIGludGVyc2VjdGlvbiBlcXVhbHMgSS4gKi8KKyAgICAgIGNvbnRhaW5zID0gKGFkZHIgPT0g
bV9hZGRyICYmIGxlbiA9PSBtX2xlbik7CiAgICAgICByZXR1cm4gdHJ1ZTsKICAgICB9CiAgIHJl
dHVybiBmYWxzZTsKQEAgLTY1MywxNCArNjY0LDE0IEBAIG1tYXBfbGlzdDo6dHJ5X21hcCAodm9p
ZCAqYWRkciwgc2l6ZV90IGxlbiwgaW50IG5ld19wcm90LCBpbnQgZmxhZ3MsIG9mZl90IG9mZikK
IAkgcmVxdWVzdCwgdHJ5IHRvIHJlc2V0IHRoZSBwcm90ZWN0aW9uIG9uIHRoZSByZXF1ZXN0ZWQg
YXJlYS4gKi8KICAgICAgIGNhZGRyX3QgdV9hZGRyOwogICAgICAgU0laRV9UIHVfbGVuOworICAg
ICAgYm9vbCBjb250YWluczsKIAogICAgICAgTElTVF9GT1JFQUNIIChyZWMsICZyZWNzLCBtcl9u
ZXh0KQotCWlmIChyZWMtPm1hdGNoICgoY2FkZHJfdCkgYWRkciwgbGVuLCB1X2FkZHIsIHVfbGVu
KSkKKwlpZiAocmVjLT5tYXRjaCAoKGNhZGRyX3QpIGFkZHIsIGxlbiwgdV9hZGRyLCB1X2xlbiwg
Y29udGFpbnMpKQogCSAgYnJlYWs7CiAgICAgICBpZiAocmVjKQogCXsKLQkgIGlmICh1X2FkZHIg
PiAoY2FkZHJfdCkgYWRkciB8fCB1X2FkZHIgKyB1X2xlbiA8IChjYWRkcl90KSBhZGRyICsgbGVu
Ci0JICAgICAgfHwgIXJlYy0+Y29tcGF0aWJsZV9mbGFncyAoZmxhZ3MpKQorCSAgaWYgKCFjb250
YWlucyB8fCAhcmVjLT5jb21wYXRpYmxlX2ZsYWdzIChmbGFncykpCiAJICAgIHsKIAkgICAgICAv
KiBQYXJ0aWFsIG1hdGNoIG9ubHksIG9yIGFjY2VzcyBtb2RlIGRvZXNuJ3QgbWF0Y2guICovCiAJ
ICAgICAgLyogRklYTUU6IEhhbmRsZSBwYXJ0aWFsIG1hcHBpbmdzIGdyYWNlZnVsbHkgaWYgYWRq
YWNlbnQKQEAgLTczMCwxMSArNzQxLDEyIEBAIGlzX21tYXBwZWRfcmVnaW9uIChjYWRkcl90IHN0
YXJ0X2FkZHIsIGNhZGRyX3QgZW5kX2FkZHJlc3MpCiAgIG1tYXBfcmVjb3JkICpyZWM7CiAgIGNh
ZGRyX3QgdV9hZGRyOwogICBTSVpFX1QgdV9sZW47CisgIGJvb2wgY29udGFpbnM7CiAgIGJvb2wg
cmV0ID0gZmFsc2U7CiAKICAgTElTVF9GT1JFQUNIIChyZWMsICZtYXBfbGlzdC0+cmVjcywgbXJf
bmV4dCkKICAgICB7Ci0gICAgICBpZiAocmVjLT5tYXRjaCAoc3RhcnRfYWRkciwgbGVuLCB1X2Fk
ZHIsIHVfbGVuKSkKKyAgICAgIGlmIChyZWMtPm1hdGNoIChzdGFydF9hZGRyLCBsZW4sIHVfYWRk
ciwgdV9sZW4sIGNvbnRhaW5zKSkKIAl7CiAJICByZXQgPSB0cnVlOwogCSAgYnJlYWs7CkBAIC03
ODYsMTAgKzc5OCwxMSBAQCBtbWFwX2lzX2F0dGFjaGVkX29yX25vcmVzZXJ2ZSAodm9pZCAqYWRk
ciwgc2l6ZV90IGxlbikKIAogICBpZiAobWFwX2xpc3QgPT0gTlVMTCkKICAgICBnb3RvIG91dDsK
KyAgYm9vbCBjb250YWluczsKIAogICBMSVNUX0ZPUkVBQ0ggKHJlYywgJm1hcF9saXN0LT5yZWNz
LCBtcl9uZXh0KQogICAgIHsKLSAgICAgIGlmICghcmVjLT5tYXRjaCAoc3RhcnRfYWRkciwgbGVu
LCB1X2FkZHIsIHVfbGVuKSkKKyAgICAgIGlmICghcmVjLT5tYXRjaCAoc3RhcnRfYWRkciwgbGVu
LCB1X2FkZHIsIHVfbGVuLCBjb250YWlucykpCiAJY29udGludWU7CiAgICAgICBpZiAocmVjLT5h
dHRhY2hlZCAoKSkKIAl7CkBAIC0xMTc3LDEwICsxMTkwLDExIEBAIG11bm1hcCAodm9pZCAqYWRk
ciwgc2l6ZV90IGxlbikKICAgICAgIG1tYXBfcmVjb3JkICpyZWMsICpuZXh0X3JlYzsKICAgICAg
IGNhZGRyX3QgdV9hZGRyOwogICAgICAgU0laRV9UIHVfbGVuOworICAgICAgYm9vbCBjb250YWlu
czsKIAogICAgICAgTElTVF9GT1JFQUNIX1NBRkUgKHJlYywgJm1hcF9saXN0LT5yZWNzLCBtcl9u
ZXh0LCBuZXh0X3JlYykKIAl7Ci0JICBpZiAoIXJlYy0+bWF0Y2ggKChjYWRkcl90KSBhZGRyLCBs
ZW4sIHVfYWRkciwgdV9sZW4pKQorCSAgaWYgKCFyZWMtPm1hdGNoICgoY2FkZHJfdCkgYWRkciwg
bGVuLCB1X2FkZHIsIHVfbGVuLCBjb250YWlucykpCiAJICAgIGNvbnRpbnVlOwogCSAgaWYgKHJl
Yy0+dW5tYXBfcGFnZXMgKHVfYWRkciwgdV9sZW4pKQogCSAgICB7CkBAIC0xMjk5LDEwICsxMzEz
LDExIEBAIG1wcm90ZWN0ICh2b2lkICphZGRyLCBzaXplX3QgbGVuLCBpbnQgcHJvdCkKICAgICAg
IG1tYXBfcmVjb3JkICpyZWM7CiAgICAgICBjYWRkcl90IHVfYWRkcjsKICAgICAgIFNJWkVfVCB1
X2xlbjsKKyAgICAgIGJvb2wgY29udGFpbnM7CiAKICAgICAgIExJU1RfRk9SRUFDSCAocmVjLCAm
bWFwX2xpc3QtPnJlY3MsIG1yX25leHQpCiAJewotCSAgaWYgKCFyZWMtPm1hdGNoICgoY2FkZHJf
dCkgYWRkciwgbGVuLCB1X2FkZHIsIHVfbGVuKSkKKwkgIGlmICghcmVjLT5tYXRjaCAoKGNhZGRy
X3QpIGFkZHIsIGxlbiwgdV9hZGRyLCB1X2xlbiwgY29udGFpbnMpKQogCSAgICBjb250aW51ZTsK
IAkgIGluX21hcHBlZCA9IHRydWU7CiAJICBpZiAocmVjLT5hdHRhY2hlZCAoKSkKLS0gCjIuNDUu
MQoK

--------------Dg0v9BJXTZHdKAx5Bw2VPAzT--
