Return-Path: <SRS0=+JKb=UA=cornell.edu=kbrown@sourceware.org>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f403:2412::70a])
	by sourceware.org (Postfix) with ESMTPS id 3C1D63857C5F
	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2025 23:03:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3C1D63857C5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3C1D63857C5F
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2412::70a
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736377439; cv=pass;
	b=XkpC9Eve+JbGax8YItwqGuFqPVVdwLYDd7Fouxjmu7EFNzrP6MK1GM0V4Zzj6uFOmvC+NfnM4NkCqKdN0cMqrF8O3LkVfny1cZ/GP3eobCA8lACJKPT/srHlpYEvuLwOpczpjuVScZmK3uvlFaL3Npmw4TPtBpFpFO8IuNfFBbQ=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736377439; c=relaxed/simple;
	bh=FUqej+yC6Tc/3VFwbL9/SDOnLlhNZfOneFqN+aDlngw=;
	h=DKIM-Signature:Message-ID:Date:From:Subject:To:MIME-Version; b=rfvBF5YnvJeGYXBxsL1rDKXNI5jyyzVE1ZGzex+ua4oxqaRmqqvFylIDZme7mDeI+ca418oGQwSnyGWVkactIU45eQeP4hoOulvl4EPaW9BaW7fSy6+9KDPgzXoJKbD9DRz3txup7rH30vKkb3yz7dBggrSDPr8TZ5Nobmk3C8A=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3C1D63857C5F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=BjE4wqQz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsJpo6NMC3yCODiFPtB4/jyz8/i8bVVm5U1LsZ01bU/FPjYMa6DeNWpbHZs9euc3TPd4koWYs/p4Q9ClrRxLZHixm6sXIHJw8ulLJFIVLF0sMIhQNgmvrXJUapcCanKm6T376eFWiT2WLJDuqA+CX75NbBS4opVinLqH3+O9BJD91uNO85gGL1Hmoonm9kFoo4Y85eRjMC+Tx8/8cWWBKhFji0ociOXmWIt+ozJEam7EYG/UdwR2DYHOOa2tNK1qHRkr65R1o0NywEpdVnai8KK+CVREZZ1wE5EL+B5LBRbbt2PEliIdam4GzrPdo/fyna7HtOSzoB5lWJrKuqpk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUqej+yC6Tc/3VFwbL9/SDOnLlhNZfOneFqN+aDlngw=;
 b=TykdQX3M1DylYEV4RDYZzwze8VQXEELjjyww/3rAPOxOW+JzUSXZSYI0CboxUBM8M/lRSX1WMl0RQ0lKBtp0IukDZwY+HNMHSLMJmKAzGo1TnQ+veLKJS8L9H/TdW0ObSmv8Hu1xyOwOFRsp32EpdTuyIMj7MGKRupEIcYs4rA4zZFGlG6kBpEjxHyg02yjS/cIfsMnhP05lQDYlBs6AIjpkg9IVtqvFwhrIN8mEg1M36RPhD0SzUBoh6V3aNS1fIBSRQg5K6PYZK4QLf1Nse5aSX/07vtu0WIomzIm/w7zxw5pbAdgpZB2tMAGsvN9jCtuisypbKSWINu9SAQNCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUqej+yC6Tc/3VFwbL9/SDOnLlhNZfOneFqN+aDlngw=;
 b=BjE4wqQz2ZyTW9NRjlweYyOmnKkbLWuTFCKp5SuEDIMB8qC6jxeNTiADuMHFIxhA4UDf9w64UWrlKDxPcmKMgccek2XVPl+ttaBKId/pWMToqOd0zr6O6rQpaDCgBpt+ltSYbUJEz9FGpS6H7hSKxg6bZ8CCnw7qWvdz0hFLq5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DS1PR04MB9654.namprd04.prod.outlook.com (2603:10b6:8:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 23:03:56 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 23:03:56 +0000
Content-Type: multipart/mixed; boundary="------------8yPDOeBEvT3ktfukcsC0qDC5"
Message-ID: <dc8fa635-bc5e-4ef4-824a-0d2a73e838bc@cornell.edu>
Date: Wed, 8 Jan 2025 18:03:55 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 3/5] Cygwin: mmap: remove __PROT_FILLER and the associated
 methods
To: cygwin-patches@cygwin.com
X-ClientProxiedBy: BN9PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:408:f9::9) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e93556-2a0c-4b32-ef37-08dd3038bac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enU0Vzg4aUlsTm5OZ055U0dRb0grRWZDWGswQTNTQUtTT2VsSkpUYWVGZU1X?=
 =?utf-8?B?c0FEZk1lZW50a1VXcHp4S3gxQWE4RXhPYVVHWkVsVHJmcHdKS2pYVVlTMmpu?=
 =?utf-8?B?L0NzcG0rNXlKbzY1STkrdEFyYnMzeE9IanVabFN1c2pMVDNYeDczeWRsRk5m?=
 =?utf-8?B?VDF1UHUxVmkrNldROTBLakZRcVV3ZFFhZlBCR3FIRElYSWZ4WW9Cck5JMzlE?=
 =?utf-8?B?blAwZ2FvY2lQc0JtL09VWHdVcUR6VkIwTWJQWDUvQkVycmJ0R1QySnFVRjl1?=
 =?utf-8?B?WUFzbER1UnN2K29KbU9IMlEwZG4rWUY3STNRNzVaaG1OTjl2Ui9FSnlCQ3NW?=
 =?utf-8?B?d1lVcktHMlRoL3VjTmJjcWVheXpqRWNrNzRDSUttTFJFUER5LytzUGs4S2Jw?=
 =?utf-8?B?djcvQk80N2d3TGdzUU5SZjlvV3ZDanlGWjJJd0pvbGcvdmlJSFMybXhPVkV3?=
 =?utf-8?B?Qk9JazdOajRkT3BSQXd4aVNyb2RpWE1jRkNidUJpSmlBd2RUSW5FN0xoVVJ4?=
 =?utf-8?B?bWt2WW9sS2FJb3d3Z1F4bk92a3VUVEhkd2ZtRVpMNDBDZW1yclNZeWlFaW5u?=
 =?utf-8?B?eDVUOFo0czVwMDJ2OGQyL0Vzbk00alhvNnUrYVZtZXRNczhWV0ZzbldwK0xD?=
 =?utf-8?B?cnQ1Q0xmTklORVJvTURoRGNyR1hiNVg0NC9NUUhUUkI2RUNNcVdsT2RWN2Zv?=
 =?utf-8?B?RndsQldpYnpkdURNeUZpVHN1azVqUVNVQWFHTDduSWdpV2pJdnhqdit5R1Nl?=
 =?utf-8?B?US9tdFp4ZFdRZXV6Q09VVHhpVHhZZUcvMEFkMXp2a2VNMDF5aXo2b1R0V2xT?=
 =?utf-8?B?MzA1dmlUdEYwYm1zRDhhUHU2bWcyNEJzLzdWVzIwWjhCWEZ0Y1JtNStMUlVV?=
 =?utf-8?B?ZnQyNEZJZjhMRmE3S1A1c0dRNzl1Uy9VVWFKUWllUE1PVndWQ3hIQnpieE92?=
 =?utf-8?B?Nm5EMzV2cHcyY3oxdDJrSUZ6SjlPNk1Qd3U3SElyU2Q0dzlXU3pCQXFncm5P?=
 =?utf-8?B?K3FHRE1BSFo5ZURtZjBhYjExSHNkaUt0QVE1NENsdGtHeklzcmlhbnE5cno4?=
 =?utf-8?B?Z0lDT0toL0VnT0JEclZWYXMyUE93TXl4Z1Rhc24rVnhxSFM4TG1hbEJTU1h2?=
 =?utf-8?B?blZVVkVyZTRBczlpeStKK01xVEdPMUVKbmpGYmZNSnRjTXE0N0N3ZVlMM24r?=
 =?utf-8?B?UGowRDNrUHhYa01sdlIzaUlYUGRtZ0g2cTM5MWFGejU5TmxLYjFWV0s2aDJ3?=
 =?utf-8?B?RnV4K0VtYU00M3FWK1RVOGpqQlh2MkhndStqYngrNWdnYitheWFPQUxTbXM3?=
 =?utf-8?B?UlN0ZmV6ekFKbVVYdnR3V0U2Z2Vpc3NlMTNlVXI5Tk8rR1pKTUs2NzRkVlBU?=
 =?utf-8?B?MHZBYmFlRUFzODVzQ3U4S2pvWlJZNzNpNUwrRDNJQmhFSjBuNDJEd2gyaUk4?=
 =?utf-8?B?a0JIMFM5dVkrcW5EM1pucTlRWW94VTdnbUVWZ3Fpdi96Y0hWeTV1OHVORDQ1?=
 =?utf-8?B?dlU4WWc2eFo4Q04zMGpwOWJ4Z3BLdDI2T3VPaGZYaXJqV3dxNGdjQXBGVkRH?=
 =?utf-8?B?elhJcnlpY2J6SUtjUG9TTFZCZ3dSSzN2VlVDaXF6RFloTWlFb1VYWThVVE5E?=
 =?utf-8?B?R0pBb1hKd2V5UjcrS1hpZVl4enAzcDFkMWRlNDlyLzhhM0ZncUFKSDE3SmpF?=
 =?utf-8?B?ZVBac0hDRUVTd0JyaUxtV2VVTisxTlpSQmdGRlRqN21YNkswWHRmSFJETVN3?=
 =?utf-8?B?VWYzMEhjdS9wMHdKRkxBYmZUTEFnU3ltQ0VOTHZjaCtlOXdYUDJ2SEVDWjlh?=
 =?utf-8?B?bVNaYmxsL0ZsY09uUDJzTkNmWno5QWcySldNZGs1UHEwa0dUNnZTTXFTc2tT?=
 =?utf-8?Q?Zrn8YD5P8yBxV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2pvZ3gvRUdrdEY1WnBoQ2hReUtsdXNkSm1XRC8wYWFaZk5MSlhtUWo0amtu?=
 =?utf-8?B?elprMHlsdEIzcSs5N0Z5Smt5dyt0cVlSb3JlZ0RVdVBrVXhIVU1ac0hvSm9G?=
 =?utf-8?B?c00zVkR0aDQvUlpuTFAwOVcvUFNReE9CaHNuTG1xSnZwd0I3bEtwWVV1WDRh?=
 =?utf-8?B?V2dNSkhOMFY4bndXOUVWVFZHcHg3bTIxQnFsR3ZlTEN5YU5HaGFTS1g4UFpW?=
 =?utf-8?B?VjJodVdNSldVV2kwQVNHS0tOQitYY1Y1ZytyTWxPZW9TdHM5YW96Y3BsN3M1?=
 =?utf-8?B?TFppekZ5RU5NcmJ0aUxFZkZLNGpVUXpGSHViUDQ3VDl6eHJXWG9tcUZFMm4r?=
 =?utf-8?B?MytuRlZycEVBdFdHQm1vcjhyTjByMmFYZ3BreU5ZbXR4QVBsZHFjdHhpY3NZ?=
 =?utf-8?B?alprN1FOaXdLUmlXK2QxOXlySkN0ODdsSSttaUpqTnBWU3ZnUWt1NnM3YVFh?=
 =?utf-8?B?V0pQM2ZDYXBFSFprTGJYaEtUcitEL09uaWRYMGNSaXdlYjJIQlVHR2lzMXVo?=
 =?utf-8?B?SmhjZ2owaFZoaGJEcmRMK0lpOXRFVmtCUFJwSU5GVi96ZlRVbjVKVHBVRk54?=
 =?utf-8?B?b3B4ZGY0RWx1OUtrcUVrWWo5SE82ZXJscnV1NlY2dGZZWnhaeWpvN0JWUkpx?=
 =?utf-8?B?a3ZXQ3VXRFkxZmxTRUR0c2IrMFdxSmRRU3lFM21pdnRRQWl5aU5pSmxreW9F?=
 =?utf-8?B?c3JKcG1aa2p3VWh0LzdsS0RONzQrblhib2VPRFgwalpaRlhSOG9FRXVxQmpw?=
 =?utf-8?B?cU8yZkdxbVUrZEdFenAxRkwrL056VzhuQTFHYnk0THVLV2hTcitvRHB3bGZN?=
 =?utf-8?B?VGFnQnVmcnJ0V3RnYkU2Y3RtWE5MTllBYzk0dXFNbDljUWdwVm1vTzVPUkJW?=
 =?utf-8?B?RlBGejVzUGR1OE5EMjc4cVNSTm1sYXpkS083dkhWOER6SXdnNkNxY2RPam9Q?=
 =?utf-8?B?M3ZHQ3lyUDN1R2lGWGI2bVJ5dTNKbVZNQkRpSjJIWENXQ0VDaUZXRzNLRGZx?=
 =?utf-8?B?UEEwZkgycVRXMnVrNGk0UTRjU2JKVUhzYi9nVTVHSi9KZENzVUtqaUN1SHVj?=
 =?utf-8?B?aldkSjZWS24zT0tDYW1vV2dldTE5OFFHN3FmSEVVeFN4T3JmeWFhcllGeXM3?=
 =?utf-8?B?L2x6bURuNnp4akQ1c1BkcXh2cE5RZEI4R1RVNVgyM0dNSDc3RlRoMklUZFFh?=
 =?utf-8?B?TmI5Yjl4QXpGZ1Y5b2wzc1dFbVQvWUtzdlA0ZFhKT3R0U3prTm5CUEtvbEl4?=
 =?utf-8?B?b0FOVmIwVC9hbGE0TzFpaWVGRFJubytMaXlFTUVrLzB4QlNzVXdzaGUrS2NB?=
 =?utf-8?B?cHR6YU9vV3pGTlpKb25hYXhRLzlKaHRQQjBHUXNpcTk4SzcvNy9YZHdINUZC?=
 =?utf-8?B?NG5aVW5UK1JIRDdyU2I2Q3Y1S2lVUkZKdGEvVlorSnRjOW9Bem1HYngxdE9S?=
 =?utf-8?B?WW5TSStoc0hJeDlCUzNrckx1NG1xbzlZL2xRRjdTSE9qeWVpU0hqZTluTy9W?=
 =?utf-8?B?RzhuSExjNFFHNE11dDdVZmtPTkx0Z080VW1mYXVGWmUvWndNcGZ3RmdJQkdW?=
 =?utf-8?B?clZ3MGRpR01WQzVOS0ZlbkNFL1FvdVNxcjJQVWl3aGI1LzZlVlplWXp0SUw3?=
 =?utf-8?B?a2pRTDEzNTFNOE1qZGNwWXNDek5hQnowUkhvZ2VoWnhQQVMvYzI4eFJVLzMv?=
 =?utf-8?B?MlZZdThpMHRPdVR3RVo2SEhqQ1R2Tml3cGpCb0FGb2ZZMFVOZXhzY24vTXlt?=
 =?utf-8?B?S2ltSEJsVUZRYXRuN1RpcHdUTTRmTGh2WmN0bHBWVG5HQnB4MlB1MURKVDlK?=
 =?utf-8?B?UEhoWjd3TElPNy9xUGlhNnhZZUtHVzNSdFJsUG44NVpIVlgyaDNHWnpqc042?=
 =?utf-8?B?ajZCWlFXeW5ObzdIZmRrd0tUS0RITlplUFJHVDJaR1psUDUwaUMrUVRpWlda?=
 =?utf-8?B?OXYydWxxL1RuWmo3R3hVMkQ4dDdBWjd5SytGblhrUkd0czhxY2FqNG1ZK1p0?=
 =?utf-8?B?SkRwSWJDb01oeHN3NEpDM3BTTGthek1jeG5WTFFHUmdPVUpjdlorU2R5Umox?=
 =?utf-8?B?RXdueWZLRlBuSnd2WlBRTGdxbTJBZ25ZQmE3SlB1MzNUb2F1M2hPRXdWbUZW?=
 =?utf-8?Q?JxdslitLglF5JLccgVgV3cCws?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e93556-2a0c-4b32-ef37-08dd3038bac2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 23:03:56.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRo3OROIr/v4DXEjVoK99STlJpd/AnDKxEhTn0V80NtQMySvgetjpjPjanjmunFBLW2A9Vl5xCbrO5dGtayQtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9654
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------8yPDOeBEvT3ktfukcsC0qDC5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
--------------8yPDOeBEvT3ktfukcsC0qDC5
Content-Type: text/plain; charset=UTF-8;
 name="0003-Cygwin-mmap-remove-__PROT_FILLER-and-the-associated-.patch"
Content-Disposition: attachment;
 filename*0="0003-Cygwin-mmap-remove-__PROT_FILLER-and-the-associated-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4N2UwN2VkYjdjNTNmNDI1Yzg2NTc5ZDAxM2QyOWVmZDNmOTA1MjAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
RnJpLCAyMCBEZWMgMjAyNCAxMzoxMToyMiAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggMy81XSBDeWd3
aW46IG1tYXA6IHJlbW92ZSBfX1BST1RfRklMTEVSIGFuZCB0aGUgYXNzb2NpYXRlZAogbWV0aG9k
cwoKVGhpcyBpcyBsZWZ0IG92ZXIgZnJvbSAzMiBiaXQgQ3lnd2luIGFuZCBpcyBubyBsb25nZXIg
dXNlZC4KClNpZ25lZC1vZmYtYnk6IEtlbiBCcm93biA8a2Jyb3duQGNvcm5lbGwuZWR1PgotLS0K
IHdpbnN1cC9jeWd3aW4vbW0vbW1hcC5jYyB8IDMxICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbW0vbW1hcC5jYyBiL3dpbnN1cC9jeWd3aW4vbW0v
bW1hcC5jYwppbmRleCAxM2U2NGMyMzI1NmMuLjllNjQxNWRlOTk1MSAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9tbS9tbWFwLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vbW0vbW1hcC5jYwpAQCAt
MjcsMTQgKzI3LDggQEAgZGV0YWlscy4gKi8KICAgIGlzIHRvIHN1cHBvcnQgbWFwcGluZ3MgbG9u
Z2VyIHRoYW4gdGhlIGZpbGUsIHdpdGhvdXQgdGhlIGZpbGUgZ3Jvd2luZwogICAgdG8gbWFwcGlu
ZyBsZW5ndGggKFBPU0lYIHNlbWFudGljcykuICovCiAjZGVmaW5lIF9fUFJPVF9BVFRBQ0ggICAw
eDgwMDAwMDAKLS8qIEZpbGxlciBwYWdlcyBhcmUgdGhlIHBhZ2VzIGZyb20gdGhlIGxhc3QgZmls
ZSBiYWNrZWQgcGFnZSB0byB0aGUgbmV4dAotICAgNjRLIGJvdW5kYXJ5LiAgVGhlc2UgcGFnZXMg
YXJlIGNyZWF0ZWQgYXMgYW5vbnltb3VzIHBhZ2VzLCBidXQgd2l0aAotICAgdGhlIHNhbWUgcGFn
ZSBwcm90ZWN0aW9uIGFzIHRoZSBmaWxlJ3MgcGFnZXMsIHNpbmNlIFBPU0lYIGFwcGxpY2F0aW9u
cwotICAgZXhwZWN0IHRvIGJlIGFibGUgdG8gYWNjZXNzIHRoaXMgcGFydCB0aGUgc2FtZSB3YXkg
YXMgdGhlIGZpbGUgcGFnZXMuICovCi0jZGVmaW5lIF9fUFJPVF9GSUxMRVIgICAweDQwMDAwMDAK
LQotLyogU3RpY2sgd2l0aCA0SyBwYWdlcyBmb3IgYm9va2tlZXBpbmcsIG90aGVyd2lzZSB3ZSBq
dXN0IGdldCBjb25mdXNlZAotICAgd2hlbiB0cnlpbmcgdG8gZG8gZmlsZSBtYXBwaW5ncyB3aXRo
IHRyYWlsaW5nIGZpbGxlciBwYWdlcyBjb3JyZWN0bHkuICovCisKKy8qIFN0aWNrIHdpdGggNEsg
cGFnZXMgZm9yIGJvb2trZWVwaW5nLiAqLwogI2RlZmluZSBQQUdFX0NOVChieXRlcykgaG93bWFu
eSgoYnl0ZXMpLCB3aW5jYXAucGFnZV9zaXplKCkpCiAKICNkZWZpbmUgUEdCSVRTCQkoc2l6ZW9m
IChEV09SRCkqOCkKQEAgLTkxLDEyICs4NSw2IEBAIGF0dGFjaGVkIChpbnQgcHJvdCkKICAgcmV0
dXJuIChwcm90ICYgX19QUk9UX0FUVEFDSCkgPT0gX19QUk9UX0FUVEFDSDsKIH0KIAotc3RhdGlj
IGlubGluZSBib29sCi1maWxsZXIgKGludCBwcm90KQotewotICByZXR1cm4gKHByb3QgJiBfX1BS
T1RfRklMTEVSKSA9PSBfX1BST1RfRklMTEVSOwotfQotCiBzdGF0aWMgaW5saW5lIERXT1JECiBn
ZW5fY3JlYXRlX3Byb3RlY3QgKERXT1JEIG9wZW5mbGFncywgaW50IGZsYWdzKQogewpAQCAtMTI1
LDcgKzExMyw3IEBAIGdlbl9wcm90ZWN0IChpbnQgcHJvdCwgaW50IGZsYWdzKQogICAgIHJldHVy
biBQQUdFX0VYRUNVVEVfUkVBRFdSSVRFOwogCiAgIGlmIChwcm90ICYgUFJPVF9XUklURSkKLSAg
ICByZXQgPSAocHJpdiAoZmxhZ3MpICYmICghYW5vbnltb3VzIChmbGFncykgfHwgZmlsbGVyIChw
cm90KSkpCisgICAgcmV0ID0gKHByaXYgKGZsYWdzKSAmJiAhYW5vbnltb3VzIChmbGFncykpCiAJ
ICA/IFBBR0VfV1JJVEVDT1BZIDogUEFHRV9SRUFEV1JJVEU7CiAgIGVsc2UgaWYgKHByb3QgJiBQ
Uk9UX1JFQUQpCiAgICAgcmV0ID0gUEFHRV9SRUFET05MWTsKQEAgLTMzMCw3ICszMTgsNiBAQCBj
bGFzcyBtbWFwX3JlY29yZAogICAgIGJvb2wgbm9yZXNlcnZlICgpIGNvbnN0IHsgcmV0dXJuIDo6
bm9yZXNlcnZlIChmbGFncyk7IH0KICAgICBib29sIGF1dG9ncm93ICgpIGNvbnN0IHsgcmV0dXJu
IDo6YXV0b2dyb3cgKGZsYWdzKTsgfQogICAgIGJvb2wgYXR0YWNoZWQgKCkgY29uc3QgeyByZXR1
cm4gOjphdHRhY2hlZCAocHJvdCk7IH0KLSAgICBib29sIGZpbGxlciAoKSBjb25zdCB7IHJldHVy
biA6OmZpbGxlciAocHJvdCk7IH0KICAgICBvZmZfdCBnZXRfb2Zmc2V0ICgpIGNvbnN0IHsgcmV0
dXJuIG9mZnNldDsgfQogICAgIFNJWkVfVCBnZXRfbGVuICgpIGNvbnN0IHsgcmV0dXJuIGxlbjsg
fQogICAgIGNhZGRyX3QgZ2V0X2FkZHJlc3MgKCkgY29uc3QgeyByZXR1cm4gYmFzZV9hZGRyZXNz
OyB9CkBAIC00MzAsMTMgKzQxNyw5IEBAIG1tYXBfcmVjb3JkOjptYXRjaCAoY2FkZHJfdCBhZGRy
LCBTSVpFX1QgbGVuLCBjYWRkcl90ICZtX2FkZHIsIFNJWkVfVCAmbV9sZW4sCiAJCSAgICBib29s
ICZjb250YWlucykKIHsKICAgY29udGFpbnMgPSBmYWxzZTsKKyAgU0laRV9UIHJlY19sZW4gPSBQ
QUdFX0NOVCAoZ2V0X2xlbiAoKSkgKiB3aW5jYXAucGFnZV9zaXplICgpOwogICBjYWRkcl90IGxv
dyA9IE1BWCAoYWRkciwgZ2V0X2FkZHJlc3MgKCkpOwotICBjYWRkcl90IGhpZ2ggPSBnZXRfYWRk
cmVzcyAoKTsKLSAgaWYgKGZpbGxlciAoKSkKLSAgICBoaWdoICs9IGdldF9sZW4gKCk7Ci0gIGVs
c2UKLSAgICBoaWdoICs9IChQQUdFX0NOVCAoZ2V0X2xlbiAoKSkgKiB3aW5jYXAucGFnZV9zaXpl
ICgpKTsKLSAgaGlnaCA9IE1JTiAoYWRkciArIGxlbiwgaGlnaCk7CisgIGNhZGRyX3QgaGlnaCA9
IE1JTiAoYWRkciArIGxlbiwgZ2V0X2FkZHJlc3MgKCkgKyByZWNfbGVuKTsKICAgaWYgKGxvdyA8
IGhpZ2gpCiAgICAgewogICAgICAgbV9hZGRyID0gbG93OwpAQCAtMTU2OSw3ICsxNTUyLDcgQEAg
ZmhhbmRsZXJfZGV2X3plcm86Om1tYXAgKGNhZGRyX3QgKmFkZHIsIHNpemVfdCBsZW4sIGludCBw
cm90LAogICBIQU5ETEUgaDsKICAgdm9pZCAqYmFzZTsKIAotICBpZiAocHJpdiAoZmxhZ3MpICYm
ICFmaWxsZXIgKHByb3QpKQorICBpZiAocHJpdiAoZmxhZ3MpKQogICAgIHsKICAgICAgIC8qIFBy
aXZhdGUgYW5vbnltb3VzIG1hcHMgYXJlIG5vdyBpbXBsZW1lbnRlZCB1c2luZyBWaXJ0dWFsQWxs
b2MuCiAJIFRoaXMgaGFzIHR3byBhZHZhbnRhZ2VzOgpAQCAtMTY3OCw3ICsxNjYxLDcgQEAgZmhh
bmRsZXJfZGV2X3plcm86OmZpeHVwX21tYXBfYWZ0ZXJfZm9yayAoSEFORExFIGgsIGludCBwcm90
LCBpbnQgZmxhZ3MsCiB7CiAgIC8qIFJlLWNyZWF0ZSB0aGUgbWFwICovCiAgIHZvaWQgKmJhc2U7
Ci0gIGlmIChwcml2IChmbGFncykgJiYgIWZpbGxlciAocHJvdCkpCisgIGlmIChwcml2IChmbGFn
cykpCiAgICAgewogICAgICAgRFdPUkQgYWxsb2NfdHlwZSA9IE1FTV9SRVNFUlZFIHwgKG5vcmVz
ZXJ2ZSAoZmxhZ3MpID8gMCA6IE1FTV9DT01NSVQpOwogICAgICAgLyogQWx3YXlzIGFsbG9jYXRl
IFIvVyBzbyB0aGF0IFJlYWRQcm9jZXNzTWVtb3J5IGRvZXNuJ3QgZmFpbAotLSAKMi40NS4xCgo=

--------------8yPDOeBEvT3ktfukcsC0qDC5--
