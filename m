Return-Path: <SRS0=LRyU=TM=cornell.edu=kbrown@sourceware.org>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20724.outbound.protection.outlook.com [IPv6:2a01:111:f403:2417::724])
	by sourceware.org (Postfix) with ESMTPS id 1F3B63858D21
	for <cygwin-patches@cygwin.com>; Thu, 19 Dec 2024 19:50:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1F3B63858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1F3B63858D21
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2417::724
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1734637841; cv=pass;
	b=lTvS+DFTHfcC8qXH9SrVnUhOaJMOBwmL9nHGh/YLxx2JjLin5FPREKctMHls7KSAe5VndUgT4e+RS3WNv8A4FClpEYKq6N5fx0W+AIrvl7zcAuP1c9y6xK90QhB7+G5RqF9gh4CtZ+vSqc2XR05YjUgirMNfRlsWEVVIHyjjFA0=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1734637841; c=relaxed/simple;
	bh=T+tPv1Wy61J+EIaAJjkyUQa+XiX94kSXJUUmt4lfUm0=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=rDf7ireTBz6bu9wkmOzhpujh7k1nxu2RJDWJMxs3O7a60orc3RIoYQcmSVTa9Iww2/AJKhPd47CF+uqNt3iKjSRLJ1C9QOhsi9nJsn2XZcIeYgUr0/u6Pklth2AXjeWzPyUnXhz/YWAl/8HK7hNRJkvusRTgByJVz9OUxM37BYs=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1F3B63858D21
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=D9eo+Qf6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ax0SgbYyrZvW3HkomCcWrjOOVoKYz0IiCd0Zi5CnjvUykYqcAISionIPQ9lxc5NFzZpRffX1rSOXFG/rhKmNFa8pp0pHSF1IzfuSKVqDGQAGKk4ar3m+cck4Oab/8YPfqXSOKGob9cV5B6zLB/TbN3Ovq+cFOGb7MSgaNNlDWJ/1fC09FaEzA+Np4D8TVVZSy4jlX2Ob11iQzbQqX+Ok6xY8zKLfUKomxeUzCFGKa9N4UOUIYxCz8Ro29+MuOVuM3SMg8nqGnVFOR1fSus4YqzJxbfRuqdytmprlG4M9ZPxGO0YVjvyRKLnqjr9WKm/J/z96ZUUy20+5Yo8xSh2KQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pl8W7U80IzzV3E9qF9PutNbyOEhj443TC1255vLX/c=;
 b=Nw6q0nXiTrdrAbj1WgAw+XmOHa2AMgLHoBp/ExYbKdO7oJR7ilCOJ0ZJE11aNtEcFlXlLwV28Pwzu7QKQjFSg/ZoY3aR28U3eXn6nfQywso1vGWIbA3Aybma0u9k9dizDqenH3twCPrvoWCtNoSp4rjcpIHM3QfdwKou9VdJjiyleDvgzR/jmXrye0kkklS1gvNosQ0XlVLFOLVO/gPrxP8OPluoz7+aeNjgyNeNZSB9n+bhuqflox4ObtbpVbx1afgrqJlYimhizvkPSf4EJkNv5mknz6epQJkU49zBtrCEpzvvxxkKrPHEShKYbgknDWu5XmRijOpxUPIF2FQFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pl8W7U80IzzV3E9qF9PutNbyOEhj443TC1255vLX/c=;
 b=D9eo+Qf6wyFT86h2Wesg8vzKQi4AR5ZwnTnWxr7sACupHPRJAE/WNMpuPlJAfu9QaqcxHgqtpo06m3JNlVudGyP0AUka3Qv6hNPARxHEsdrbU33vzQQstv1EVUNXQqgKLWe38kegyU22p8ABsLmz74Yb/w58lEqiB2mOmjyNzC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by BN8PR04MB6452.namprd04.prod.outlook.com (2603:10b6:408:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 19:50:39 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 19:50:38 +0000
Message-ID: <d7a916ea-6bab-494f-8b16-c2310eae259b@cornell.edu>
Date: Thu, 19 Dec 2024 14:50:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: mmap fixes
To: cygwin-patches@cygwin.com
References: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
 <Z2PyzRoS2QeOrNem@calimero.vinschen.de>
 <c2b2c0ee-e848-4b1d-b41d-7568671b77e4@cornell.edu>
 <3c63a503-af61-4a6d-8bae-b9dbab839fce@cornell.edu>
 <Z2RXbRhvAkGrXS6I@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z2RXbRhvAkGrXS6I@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|BN8PR04MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: e439aa6c-e8be-4e58-94ec-08dd2066698a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm9mYy9VbkpUeWVjKzBUL0RuOEZ4V2J0cmlHUnZGYTB4WUx3Sy9FdzJuRi91?=
 =?utf-8?B?VjJuWFdYUkpETDM5b0V4SmcrVUd5RUNIRXk4UWZsTkRlNjBLaHZObDBOR3gr?=
 =?utf-8?B?Y2JWWVozMlJYRlNBWUN4RUg2QnpyT1dwL05SNUo0SkdmdmJ2MmdrTE0ranlQ?=
 =?utf-8?B?aTZXNHRvSkQ2L0hWR1h5MVRuQUprOHQ5U3k5bEZmQ1l4cXZOZTZvMUtralVT?=
 =?utf-8?B?Y3ZYVk9OOTdxNElxWUQ1Sm0xR2pGMndTZVVKM0VVVGF4STZZVXdmelpyRWRQ?=
 =?utf-8?B?bzdKQTJHVWJib2h2cUp0ZllEZTFWZHZ6TFVBZlladkJ2cENYbzZRZXIrQXF6?=
 =?utf-8?B?ZGMxdUoxdEVVTWVlSmdGTkppdDZpRENnL1JYZlFkTWF4c2trbGlzbDY4eFkx?=
 =?utf-8?B?OG9wamw3ZkQzU2E0cEJIQ3EwbTl0K1NCZ0tpVlU1dGFlOHN1RWlNYnFPUkx3?=
 =?utf-8?B?bFVtT3NTWldHNU50WlFjWFNzSDkvelQ0ZUdxS2R0bVUwaUtoSndVc0FxeGlL?=
 =?utf-8?B?WHo2NGJ4MjZzN21YdHN0dEdNalBGZndoSEt1RFcvRVNXOFZkNlFqNStrUXNR?=
 =?utf-8?B?Ni9EdjU5Mm1kS1dOa3BTUUpuZlNvdUlJeW1uekxUYllKSFlOekJMYlI3Z3hO?=
 =?utf-8?B?NXJGVC9DYW16MGRaNEF5ZGY1Z0NoNVdVbXFoelgycnNFcW04a2xQdG96Vlcw?=
 =?utf-8?B?SVdoZm1maHViNUE0UWRoaTJZRy9HNVFielVFY0J1TUJ3N0sxWGVCbDlzMW0v?=
 =?utf-8?B?T2FsTDkvRDM2alBsdjRkYk1vNkhiVlNTQ05sVFZ2NkZrZ2hBcXBBU0c3NmtI?=
 =?utf-8?B?UFMwTHY4bjJHZkZsTTdBRWJHdjBmL281b2pTTDFGelRRcm1KZWZDOFliS2xp?=
 =?utf-8?B?ZTZFSFg5UFpaNzhXR3lTc1FIVWtFeVVZT0J1VElER1dqTHMzMmgvUU5UVlFC?=
 =?utf-8?B?OSttaUNQN2lGcGpVM2FxVkNITHUyeHpTQ1FQS2U5K0htTHpnVERmYzdCR0VF?=
 =?utf-8?B?ajdIaTAzQkVpRGJ4S3QvWEFmNEJ0WjRPbElTVEhOTU1rRTU0SVBRNWlEdS9j?=
 =?utf-8?B?aEIxbHQ4ZjBNUFQwdElieTNMU2QzVzhVcUJNUUs5NURhM1JEODFWVTA2b1R0?=
 =?utf-8?B?MXl6QkZoU3U0Zmg5R3B5Zm9YcFBEeFpEOWlkSytTWnZqUDE3NGY2ZFlGSUhB?=
 =?utf-8?B?TFl3S0dZWGpZc1BWVXllOXNwRlZHRnoxV2Z5M2RQc0JtbVVqRnIrVnRmQ0xP?=
 =?utf-8?B?KzMzbXp1NXpiRmxOUTUwb1RtN29PQXdMK29VTi9wZU5wVkNrNEhWcXRsbzhG?=
 =?utf-8?B?L3E5d1lQOHIwU1BmRnUrQTgyLzB6ZWw5Q0xHU2lpaThOb2I2d2NMZGwyd3Nm?=
 =?utf-8?B?MVIyYXk1TGhHcldjaEJQQ3J0YnUvVDRlYlZtT0RFeGhmNWg0VENiMWlUQUVK?=
 =?utf-8?B?MmRlSWVCSFF4SzR3WjhhRVZDYlNjUHBINjZzVGJIUGlrKzBvSktJdGRMMHd5?=
 =?utf-8?B?U3c3UHV2K1kwNVg5T09DeUp2aWdpdjQwNzFvSE51aGZyaVcwSG5sYzJaTm1G?=
 =?utf-8?B?Zk5iWGFma24wSHpxUlU1Zk5CdEtPbVZ5YmgyRTBETTdZTDU0K2FwWjhlZzZa?=
 =?utf-8?B?dDJMVWM4RFk4UDlucEdnaERIdEZnVUUxMFNiQXNDNlVhSzRIbjVGZFpTcm9n?=
 =?utf-8?B?QnZOTDFqRWdYcERJeXkvWnFjT3ZRQ24wN29iRURVNE5ja0VLSmQyZ3NEWGhs?=
 =?utf-8?B?MGhCYUNmQWRUSFJwMXRFWmdlcEw3bUJzL0lvRTgzdDFWNzJMWU1Hckt0Ymk0?=
 =?utf-8?B?a2lEKzhjRnZ0SFFZeE1mY29aTzlPK2NMQjlBdVpnR1h4YWdFd1dKaWtSMEQw?=
 =?utf-8?Q?dp5eTON4s7l7T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNRdEhza2FzdURoVHJROTgxV1ZQYk9PRUxjU3oyL2hSWUdwaVRQYjFjUTZX?=
 =?utf-8?B?VS9GNGt4YUpadmZSOGFpdzR0RzRTdjFYWEI2SjgvY2NpbzRzQU9CczBBWWtR?=
 =?utf-8?B?SHdkSTNQRDc5WEF0VUR3TzBiUWhML0ZyMElxVHJaYUZRVmZsa01UM3hqTUFs?=
 =?utf-8?B?Wnp2eU90MytXdHpSdjkxbDV3c3J0WVZIeUVTQjUvczhycEYyQ2swZko1MnNZ?=
 =?utf-8?B?czdtOEdaOGxyMHBxL2VMbGRKRGU2U2VsWFNmMllqQ0RXMmE1NkV2UzRBTnY4?=
 =?utf-8?B?blA0MnZ5VU5ORVdPb3IrN1ZDdjZuZkVIVFFSTk5aNlUyTTdEUWRuRk1uWUlv?=
 =?utf-8?B?TVJyOFo0d1NGT1Nqd0p0Ui9ra0ZHY1NGMm5tNWoyd0Y0cUtlRDR3U0lJNVMr?=
 =?utf-8?B?SkhwaFNQQkVyMDYwRWxac0JNOWh5cGRUNkVadXV4cUJvaXh6emc2eTQzOFQ3?=
 =?utf-8?B?UW9zNTJmenhpUUlRa08yTGdIalI1UkFoNkQ4NEFUSEFLa0JFTUVVbUZseWtH?=
 =?utf-8?B?Mkw0ZU0rekxSNVZzeXUwL1ZIZUx1aWoxV3J1aW5qNm0yclI5STZMVDZYOE9P?=
 =?utf-8?B?MzdtcVNPbmc2S21TZUpVWmxZQm9CYVQ3REpyUkdSWU5uK0tySnZLb2prT0Fl?=
 =?utf-8?B?S0JWTlZCSEloV1FkZENHR21Wc0JxTmdReklYQXJWM2s4NVl3ZVBYaEFHTkRm?=
 =?utf-8?B?elRMbHk5SmRiSGw5ZFN1OUpHZnVUaXc1SEQ4QTFnRVBqMnU2dVZ5MFh3cFdY?=
 =?utf-8?B?OFVxSWxTdGEzeThJc0ZjUXZlUUFXTy9qS1JGRkt1NFlpVDhiZnNNb1NvY1lv?=
 =?utf-8?B?Wit3SmNkSHk0ekdFZG5HYUJoQjB3M2VqMjRPd3YyMkhWdFJ0S1hQeXYycVQz?=
 =?utf-8?B?MytoVWFNM3ExVDVaRld4VmZlYlZMQnFsOHNXN0Q4Vkw0VW5pNm5QYzJtOXgr?=
 =?utf-8?B?UkFmVGVZWHgyMjFrNlJHL1RUNm91OTR0cFI2UnZtODdXazl1OGx0MlJpZklo?=
 =?utf-8?B?QW9lbjBRdjAvbzRGeU9XRDFDVUoyUXFBcUd5N0tPTFZUUForWk8vems3UDBo?=
 =?utf-8?B?WVg4a0ppZHAzQk5rK2Q0QXNSS2pQVnRlUDBhUjJOZTl1anNGZUgxVVZkTEky?=
 =?utf-8?B?L3VOeWh5UXgxRlpvNW96dm1IRExIWk1WcHNpdS9OOC9YV0xYUS9xRTJ2QlFo?=
 =?utf-8?B?c0hCdzBhZ0JiOWZxQStCSS9Ic1ZzYWxxYWV1cmoyZkN4WHFQSzViUzZZZG8r?=
 =?utf-8?B?bGxNMXZ0M1N5NTVwQm9UbmIwa1ZRNVBjQUdLV3Z1VmVrT1kyclBVakNPbkxS?=
 =?utf-8?B?YTkrMFJVUm1wamRORlN6bFJKZHlYeG1TSWpxK3dHTi8vcC9leUJaTW4xZXE0?=
 =?utf-8?B?VTM2VW9nTXVCRUQxZldCSUpYU0xjSEJzbjNVTkNjcTQ0bFdwTkhMRG1iWUdp?=
 =?utf-8?B?bjdlK2NQZjhSZkFFYW85a29yQjROdjRCNUxuMUtrNXlMUEVLYjdBTzFoY2ZK?=
 =?utf-8?B?RFR3eXJSV3BQVUpxcDJ3bDU4OHZMSjVDZGM1VXNYTTRrTWFkcEtkODk3MDJC?=
 =?utf-8?B?TEFMeFNPb3M4Y3psUVZHMVg0azJic3htWStvQ3FrTWpSMHM3NENMdXBIMVJy?=
 =?utf-8?B?YThMbGVzV0NsOWIybGp6akxxVEUwalVnczZCQXVUYW9SL0FLVW5aSmdmSDQr?=
 =?utf-8?B?TmxFeUkxWWlzQldtMEd0Y0dmcjZNK0I1OVJWL0VjdFR2UUhNNG5TdjZZalV0?=
 =?utf-8?B?V01LY0RVVTBBUzMyU2dLTVVYSzhid0J5MXhKdXQ0R0VBTnRISlV2V2dtUGNr?=
 =?utf-8?B?T0tYQVhaem5HTEpPOWgzNGhBV25SNE5zSm9FN2xPd1Q5ZU5Hd0p5NTNpYi9m?=
 =?utf-8?B?RjBFQnB6LzF0WFlvZi9EZk9KVU9DWDdFWjVtQzZEeWluY3U5cUpjK1ZYUUNO?=
 =?utf-8?B?bGZJNXJtWC9oY2daYjd3Q0JjK2l4T2sxcEE4dm9OTVp5Uy8yOHF0SnZWcWtt?=
 =?utf-8?B?L0J5dWtydWVXdm1jVWxPTWlFc3VONzljN1FYTUZsNDRwbThnVjJZMzJFemNa?=
 =?utf-8?B?SGZCZWhwbUJRSnNPYVh6VVhTK0FwTjNEY01zVUQyeGhyV1V2YU56ZU9ZS3N2?=
 =?utf-8?Q?S6yQumIhiddN7GCCYjmPnNei8?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e439aa6c-e8be-4e58-94ec-08dd2066698a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 19:50:38.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uw27BgxbH7/ZkN7o2gXU+rzey8UCHCReYoaU9y5fcs5fXrY5aARS0uXIGWTegjLsjcM8YuaUs6v6uv3h27drXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6452
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP,T_FILL_THIS_FORM_SHORT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/19/2024 12:27 PM, Corinna Vinschen wrote:
> On Dec 19 11:19, Ken Brown wrote:
>> I've pushed the two modified commits to both main and cygwin-3_5-branch.
>> When I pushed to main, I got back the following message from git:
>>
>> remote:  Committer: Ken Brown <kbrown@server2.sourceware.org>
>> remote: Your name and email address were configured automatically based
>> remote: on your username and hostname. Please check that they are accurate.
>> remote: You can suppress this message by setting them explicitly.
>>
>> I don't recall ever seeing this before, but it's been awhile since I've
>> pushed to main.  Is this to be expected or did I do something wrong?  I do
>> have my name and email address set in ~/.gitconfig:
>>
>> $ cat ~/.gitconfig
>> [user]
>>          name = Ken Brown
>>          email = kbrown@cornell.edu
>> [...]
>>
>> Ken
> 
> I have nothing else in my .gitconfig so I'm not quite sure what
> remote is trying to tell you.  Especially since your Committer info
> is entirely correct:
> 
> $ git log -2 --pretty=fuller
> commit 67bef16f7edf8642366ff55399bf9cf007c66d52 (HEAD -> main, origin/master, origin/main, origin/HEAD)
> Author:     Ken Brown <kbrown@cornell.edu>
> AuthorDate: Wed Dec 18 11:43:09 2024 -0500
> Commit:     Ken Brown <kbrown@cornell.edu>
> CommitDate: Thu Dec 19 10:40:18 2024 -0500
> 
>      Cygwin: mmap_list::try_map: fix a condition in a test of an mmap request
>      
>      [...]
> 
> commit 677e3150907a83f17e50d546f79b7ca863ebd77d
> Author:     Ken Brown <kbrown@cornell.edu>
> AuthorDate: Wed Dec 18 11:39:31 2024 -0500
> Commit:     Ken Brown <kbrown@cornell.edu>
> CommitDate: Thu Dec 19 10:25:53 2024 -0500
> 
>      Cygwin: mmap: fix protection when unused pages are recycled
>      
>      [...]
Maybe this has something to do with the way scallywag is invoked to do a 
build.  Jon, is the problem that I don't have a .gitconfig on 
sourceware?  In any case, I'm inclined to ignore this unless someone 
tells me I should fix it.

Ken
