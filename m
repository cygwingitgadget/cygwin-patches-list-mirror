Return-Path: <SRS0=vJ3Z=UF=cornell.edu=kbrown@sourceware.org>
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c002::])
	by sourceware.org (Postfix) with ESMTPS id 867103858D38
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 22:36:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 867103858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 867103858D38
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c002::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736807783; cv=pass;
	b=fbZFviOJJI/KkL6G3SeS6Lkwe6fUckdSoh3SnIDw6R4vPFcckcXLjyd5gufqJh0AWv4S+d2hYDzZKbYxv4DhBucQMLXug3PXlnWRiODI5FYOqdu2rh2ixh7hdGXnPta0M6gG+kFpLnIdoG50a3kdohzZZs2B7KSjbM2kXTZfwsA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736807783; c=relaxed/simple;
	bh=rdADTWRJS1rp2TWCayDUVUhu2D/zKclWlgyGC582RD8=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=Tl0Tm/C65AFlEgD9uNUqhYNGPhSLWNdcEb7Vo78o48x+M3gCC77INl/G//9K9/czgCZB+EJBtWDxlKdcoRkO2fTTe4ArInj9nrYrSgRbRi7f6pIUsSSRNCMWsENmeJuSArzyVnpfFjZXi05+MYPa3pMMmCE3Wfu3UxZTrvZ/34o=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 867103858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=fW/zsVJP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryalFi3rQgxk7E55CcIr8zD67rNTJ7igBeVVY3i5OFJiWFvuguk/tF6R+OMaMwCHsJ4J8yRODj7fIo72X1NqVdT2Dvj5Ce6A6pRUlJbBSkA4gJmWVmSWqWr2+oKPD7u/hk8UoGr5BMLHj7zeZoyuPwuEwSZRgwCyb7BAwdSe+7vTHUYiQhqnx722COHwPUGs2avChNqpe/AZog6Hj++KAp9y5HBvTCyci00i4juZk6lyTjuyhrVrB2k+K3gZ1z33yNnMTyQiP3jHVNn7pMLbrp6igrZLgmC1/ZK72z9RnfN7q7PXZt9+aIJkHsTssNKLMMXMTnUFingFdhfS+oB8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/o6sWqU91lucWaJQlZ0uQ6AwIJ3x715kEI4XwPzkes=;
 b=jJ9hL2YwZ4mv6CJ16a9WTd1SYIWL7u/HNZv6GDe7OoNQK8yURLdd8yovQgxQWNs6As2fQR9wVj8RV5a0SbluRgdOgvxx/9hktQ3OxyvwFyBYEH5Xqut/Y3qWLZKT7cHv31dxPSyrgtRaSogf7smQ9XADJ313dVq8ZddPaqpc68K9OK1YyQuAAQEVfBY8WEYKnA8YDwjC6Py8myGgannq0hP72C14tbFNUUrAWHffULDON+VTF4KCh6IaWWcCgu26kO5/lHsAJ9z6WDU7VDZYDGARVlMVKnRodnxk21YobIKA7/jv4n4L1mSW4syeh2L8DHF7uoXHjtXIbaHYQcfp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/o6sWqU91lucWaJQlZ0uQ6AwIJ3x715kEI4XwPzkes=;
 b=fW/zsVJPWlBkbRvUWeNVlQoJi7jJRPm3qHgsbv48D7aeliOkE7lNvL2+jtQhf1B5rb+r5X7vgb9bZTZszldDwhkV5Vf7iFArVXqI7oKJTUDdcKiHgqtgj+diZXqEoep2xILxqbxtp76Pga6ESOFHEK0aWJtk9ANWYevS+eGgl9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by PH0PR04MB8371.namprd04.prod.outlook.com (2603:10b6:510:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 22:36:20 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 22:36:19 +0000
Message-ID: <1376bc44-bd98-4bda-b599-3ce4b6ed1bb9@cornell.edu>
Date: Mon, 13 Jan 2025 17:36:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: mmap: allow remapping part of an existing
 anonymous, mapping
To: cygwin-patches@cygwin.com
References: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
 <9b717926-06fb-4d34-a473-a709316de429@cornell.edu>
 <Z32MB5VR4vCszv9J@calimero.vinschen.de>
 <de64c367-6695-4109-bbcb-591356a7470e@cornell.edu>
 <Z36Yr7cdOFXrWt2h@calimero.vinschen.de>
 <05430d18-35fd-4957-8277-5ae3077b3bf3@cornell.edu>
 <Z4TyYc2jPepx-rCn@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z4TyYc2jPepx-rCn@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::8) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|PH0PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: b3436409-75c5-478f-2fca-08dd3422b2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTBuL3Fiam5qcXpSMzBHQWo0N1pUR0svK2k3eEFjbFgvNUZnYkhEN2hkUzR2?=
 =?utf-8?B?M2pKamYxYzllZGJHYXhRdi9DNStIMVlqWm1aeXNkYytIWnlNYkp6bXR1WW9m?=
 =?utf-8?B?VWR4bXdHNDE3d3BHdldub1BIQzRUZEwyMng1Y0NYVS9TYjE5UmZmNGE4R3Ar?=
 =?utf-8?B?R29ubzYwTzQwcHlvMXRxSGJiL1FjQlIwd25vSFFOZ3hYTWkyRG5hN0xBTGlO?=
 =?utf-8?B?dG5yQXFtdkVQNUhTSXhzellReldCYUtzc05GdHN2ZkZXRzMyWXRJd2NzUXBs?=
 =?utf-8?B?YzJ3dHRWVGszQ2NpZmluMzhReVlDcU5OQzFhTm9kMVlkWXgvUkxKYk01Q3Qy?=
 =?utf-8?B?YmdZNytIUXdWS1RJTDV5c3BBWjZlRklTZG9PT2tTdld0SXBuWXZEbVFhbzBi?=
 =?utf-8?B?RExzWGNnUjRJbFhJbmE2eUZuaG9ERllFVitGMWpTc3UvMVlhQ09VSWdNRStq?=
 =?utf-8?B?anBMTmZjbFFVeEJqcC9LWHVFblluWkxKRzZmUmVzRmVjWm5zblRYZFJJMS9h?=
 =?utf-8?B?STNDWm83czNQdSt4TSszOUROTXBaZ1EzVFhRdVNzN241TmhRSExBMVVMakdU?=
 =?utf-8?B?NW5OdEpZQlhhc0M0czR0ZHI1dGJVRlB5alExdmRjaEFiZTNMNytNQmFWeFJT?=
 =?utf-8?B?VytFQVJLaDVyZlhyNjhpT3hSbTlrSElaTnIyNWxWUUYwWXhmZ2RucEhYRHBM?=
 =?utf-8?B?WWdzUkdwVkxYYzZaWFA0WkpPQmVYcW1qQnFRRzFVNEQzYlR4ZHVobndDZG50?=
 =?utf-8?B?Q2xsbTA1cVVWb1pHR3AxREU1OHRPeFlTVEh2WjBzRXVOai9TbXplTkc4eGJl?=
 =?utf-8?B?a2JLOS9sVWg1ZnVNd095VTR0ZVZBZ3pubXRLbkQzVmxHdnNkNGVFZWVCcm9m?=
 =?utf-8?B?ZHFxbEQ1d25GT2w1bGs1SUxTcmxBVjJhZ3RKSGhCWVZaRHF1QjRpWXMyV3Bl?=
 =?utf-8?B?SUU5aHF6cklmUitzTkx5VnVKQzdMU2pMK1RnbjBqN05vdjQ0bTd6aGlmRjlX?=
 =?utf-8?B?TFdHNFJQdThncGNhM3RYY3pIY3hHbVdwU0pQVEV6MDZoNTQxTS9sWGcxdFBY?=
 =?utf-8?B?S3ZQOTA3VXRSUGNORGZCVGVnM3dMSzR5dWZFZ25yVnlmS1lTWk9uelJZdnJS?=
 =?utf-8?B?c0lBOWFOUENyVkw4SDZZdGY4K05Lak5LYW1zbWppYS8rWXUzb0d6SWZEOFB4?=
 =?utf-8?B?d0dEOWhlWTNIbDBSb3dSZGdHbUFPQkJEMCtOSVhxcFlpQTgxbjk2RFhlSHhX?=
 =?utf-8?B?UEk0UmZ6ZUQ5UXRxb0FDKzg0aU9yVHZjRk5nVXhmU1NwVHZRQnBNS0piUFlS?=
 =?utf-8?B?MUhaT0luRmlkb1dDRWVwcDB5R2RpRGw0Rm5aQXFVdVBNUTlscm1ra05wSUhY?=
 =?utf-8?B?U0JSMTEwYWx2MmFNQ0tIYk1HTlhld2FMQVRMRkozSU9oVDBFNHM4MERuMlBz?=
 =?utf-8?B?c1pKL3piclRoOVl2T1VKV3BRay9kREFzemtuQk5qSFJNTWpBV0ZHTnZSWWoy?=
 =?utf-8?B?NWY2MUl1d1d6VXVsd0QzMnlHR3o0R0tBZG9PWDNWU21Ta1hhbkIzM01DZjg5?=
 =?utf-8?B?L1BRbWdTSURtd3dXMFM1VUttcm1NNER2VWNHYXdBellqWDUrYVZKNjVNSm1C?=
 =?utf-8?B?c0krTG16UWo0UnFpamRnak9YYUdLaXBvM2cyclJxcGxWeGhhMytab2Yzc0oy?=
 =?utf-8?B?b09SU3ZVbEtnM2pqckxvNnlUV0FiTlZ3eGdIUzk3Y0dzWE03VExRMkZPNWxV?=
 =?utf-8?B?M3RTcTViK3BmWE1DRDJHS1UvQ1lSL0l3RlFBUDh1VHBURnE1aTFPbWt4aWhJ?=
 =?utf-8?B?RUhuNVpGVllMdFNtdk10aWRSbEZRK0RJQ0xWQ3F4Z240alFzTzlaZDU3UGY3?=
 =?utf-8?Q?3PxJ+HZjD1bOl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnBMTWVIdWVGd3Yyai9qRGtjT1g4eHVaWnhNb2h2UHNWRy9ybTZ5K0xLd0Z0?=
 =?utf-8?B?aWFGaGw2UVVvWWE1S0oyVlB3anV6Z0hYOGlaTUptcU5xTWIyeXJFc1ZoQzNk?=
 =?utf-8?B?TnBZR3E1R1VaeFhGbnFTQWN0NkdmUTRxL2t5ZHVGZ21SekhCbXl1R3BJRE9M?=
 =?utf-8?B?WkY5bDdTQzVmeXdIb0prS1R0UEVINHEvWGIxRkk5QmZkbEx4RmcycGYxUERO?=
 =?utf-8?B?bWhoOVd4TXdiWjZCeTZiVTR4aXhrMnJ5WDh6WERlcm9Bbi84bC9sRUJYQ3FO?=
 =?utf-8?B?NGh0UEU1U2I2U3N5RUY5c0ovQjU3WTJvQmtaWDZYTEEzRjRjRGRuaVZ2dmpU?=
 =?utf-8?B?WVV6MzlQNVlEalBPRGdVYTR3Ny9mSnl4Vjl6WEpiK3YwWG1iRDVrTDVwMmlQ?=
 =?utf-8?B?bDYwTUhmYitsSGlXQ0EwYkUyNTduZmtuK3VrYXhSVUdPQk5YeUhGcElpVkwx?=
 =?utf-8?B?YkxPdWROTDIvb3NRbnBLMzlaL0hkcG0yckFxWVZjeVlsZ1ByQVJSZEhvRkhY?=
 =?utf-8?B?c0NocEdPMzhTQXR1M2dKaEFVWloycHNBcDg2NXRaWGtOV1ZHdFFCSXlJbFkx?=
 =?utf-8?B?eVo0RWxFRHBYM1RlREZTTE5KTW1KTkpIYitCVHpNR2V6L2M3TG9ZbjJXM3M2?=
 =?utf-8?B?eHN2WUZjdk9naHZOSDZDa2hXanNjbW5GNnRkK2Jmbkl3aDNRVy9rMGtSWklp?=
 =?utf-8?B?RC9PRlV0UERXOXRsTUozRjB6VTFEUnhrTHJzMnE2QStCRWNjdkhUYWFyTzFa?=
 =?utf-8?B?S0JTWmdBTlU4MDFSVHViaDJwK2hWaTNhQnhWTnpTOFhzam5JZ1oxc1hvck1R?=
 =?utf-8?B?Ulp1SDlXMFZjTjliUFg4RUlRSy9UZGlyTE9TS1h2VUl6MlYyd1FuZlU0b0E3?=
 =?utf-8?B?VFNVbzVJWVgyZS9EU2hsRG5nc3FOcFRsM3RkVnBJc29HY1NUOTRLWjUwdDVw?=
 =?utf-8?B?ZWU3b2YwK3hoNVdBenFBYnRKVGttQWtxOGYyTU1Bd3Zqc1MzL0RRZmI2TEpF?=
 =?utf-8?B?QUNGSjdEQStUcUxzQmNZcXJVT1lzbWw5b0lxbk1wT2xFeU1Xd3FEV1U0WmVq?=
 =?utf-8?B?UVE3MDRmZ1hFbGpBRjlvREJIVnJsWW9oVFMxTnQyUEdPeHdBakJHdlJ6a2Mv?=
 =?utf-8?B?UVhNVTlnNkxoVmNxQTUxTENQSjhjWXRKSmk2TkpLWlZNNEV5emJWYnlsUnh0?=
 =?utf-8?B?M0U1aklXT29tU3NNMFI3dU1YbkI3THFXMnpvc2tZczhpNUJ5bTJ1THRRSEJX?=
 =?utf-8?B?enBBazJjQW0xRi9IZUtwUXh4RTlMOCtoa2ZleGY2MUIvYlJzSm1qWmVHWGdO?=
 =?utf-8?B?UlFEa1RjSUNFSjVvQkc2QXhIcytvNndsLzVHRDVsbTJsblIyakRaYjNMTi9N?=
 =?utf-8?B?SkxBUkdRYk9SR1UzK3JqVW1TcVBPZUVOZWtJQldEd3d1YVRuZFlscXlibGZQ?=
 =?utf-8?B?WlBLZXM5cnN5MHVUN3MvVTh6TXNqODdlL2lLT1dXbkFBakFhRHZLODA0VUg5?=
 =?utf-8?B?clpvNU15bFJ5TmpxQW9nZnpVRzNBd25uaXU5L0tucWtxejRDYkxaSnFFZkZx?=
 =?utf-8?B?WUx0bnZ6bnpaVmV6WE9zM2ZBNW5mUVMyeTlqazlZZnZRWk1xUkx0b1orTzQ0?=
 =?utf-8?B?aDlKRVExVklVTG8rWUJTUHJYYlJjNWxqQkV4Vlo1TG04cy9lVGNGTUg2Y210?=
 =?utf-8?B?cStmL21yOUx5aXR2R0JUaEFaWUFvVXUrQldpckhuYnRDcVZGMlI3QTBsMHV2?=
 =?utf-8?B?Nm5obEtWbVBZWVgrVTQwclpGbHRmQ0ZIcklXd2pXZG0wKy9XSXR6RlBTeE1C?=
 =?utf-8?B?WG4xSGdmWGErREwrblA3TEV2QklpcU9BNk8zS3hIb1gwZHlYMnJsZDBWaUFO?=
 =?utf-8?B?eUF4MVJHbXhDajU3V2REam9nRHZVS1I5NE5EWUlSUTc3dC9BWlp4K3FzdnZp?=
 =?utf-8?B?bkdWUFRMMVdEdmQ4dy9vMHp6MUJlUUFVa29qQjhXeGlWWU1yUDlrSHRQdjBW?=
 =?utf-8?B?UjhrMFlKbDJMMWRmYTBEczNUSndUeDN3MXJkaFJRNEU1cmhEeFAxSms1ZVhR?=
 =?utf-8?B?OFdIb3RuNkF4WHd4MnVEMnNaRVRrQ09Sb1NkTVpQYTJtZElXc083M2NraWMy?=
 =?utf-8?Q?O/CALh6fhN5Bpm8MqzbN9uNCT?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b3436409-75c5-478f-2fca-08dd3422b2a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 22:36:19.5433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccSIalqX4cZgTjbN7JUWzsFmxaReVSX769bMZ6vvoKBvCt0OJ4V4M/5OgmtyfObUHlzlGqS35xOFj1x5MN6KYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8371
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/13/2025 6:00 AM, Corinna Vinschen wrote:
> On Jan 11 18:43, Ken Brown wrote:
>> Another question: Adding this array to mmap_record, we have two flexible
>> arrays in the class: one for page_map and one for the protection array. My
>> understanding is that a class or struct can have only one flexible array
>> member, and it has to be at the end.  What's the best way to deal with that?
>> The only thing I can think of is to use a pointer instead of an array for
>> the protections, and then allocate memory for it separately when an
>> mmap_record is created.  Or is there a better way?
> 
> Excellent question. Right now the page map is a bitwise array, one bit
> per page.  From the top of my head I think the best way to deal with
> that is to just change the existing page_map to a uint8_t per page and
> store the mapping state in the upper bits and the protection in the
> lower bits.
> 
> Alternatively, define a bitfield, kind of like this:
> 
>    struct {
>      uint8_t	protection:3;
>      uint8_t	mapped:1;
>    } page_map[0];
Thanks.  Both of these ideas are better than what I had in mind.  By the 
way, I forgot about __PROT_ATTACH when I said we need 3 bits for the 
protection, so it's actually 4 bits.  If I decide to use your first 
suggestion, those 4 bits would have to be consecutive.  I assume it's OK 
to redefine __PROT_ATTACH to be 8 rather than 0x8000000?  Or is there 
some reason that would be bad?

Ken
