Return-Path: <SRS0=+JKb=UA=cornell.edu=kbrown@sourceware.org>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072e.outbound.protection.outlook.com [IPv6:2a01:111:f403:2412::72e])
	by sourceware.org (Postfix) with ESMTPS id BCD8A3858C51
	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2025 23:04:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BCD8A3858C51
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BCD8A3858C51
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2412::72e
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736377463; cv=pass;
	b=rySc8IhpVft38+ImAkbHcboDmsBku6sGmNRlWkLrAuI93B8fw0qK4cRiFl6QQovLf6dpJPEDvp3wWSXN9m97twAr8Yph6cUu6ENcMDFl3U/FCQsTBfMOLPWBdin4Guy6cHaTJhYq7bhDWgfPVbyT3uoIAeoCk6JLaOXxMfBtBV4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736377463; c=relaxed/simple;
	bh=KKHYvWDxNTmsp/f9pEk6BiNp7WP3z+/0wVAL1Tg+j34=;
	h=DKIM-Signature:Message-ID:Date:To:From:Subject:MIME-Version; b=J04iJk46AwwNTYwuI10PLjf7vQDYILarAnzqSQ/nKPavob7hziVnwlpln5EbXBFycLw/t5rQnFdyXh0K/hczSv3srYpFGmci7G/QRZaMdqSBjTfg7eomXxw1cy2KTfruBf1cagsOrwjkXfGT/U7Z9RoxQNVtsHBl0o9pP6nV/vY=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BCD8A3858C51
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=f+9WksV9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylkXL4PhAQ/JRLm+TxkmmzLFCRMfsbSMZ5EW6ZKXLr9qngs/h+Abz8Lue9wriZ+If0D1vZt+UkkKfqurP0UhDyzdV4CxuOAkIkQ3BN6bxi3944uzXEjxqH7/8DJ2U474Bt6fcFs4fwwKNNWTujkbr36ezm61cIvYiH+5DA29lRgD42cD0R52GokbTPlsTk/DJIp0TXYGb8FrkWGlpUGMCtNc/1di28eIF6k1UKEU4/xQGuc6grfUqVS7nvCHvYqJITR4nzaRG/kWV3XW9yERaNe9ZhHhk3/6rumi0wwxtCvowt+EltJdAoxmYlMDVlTvahXUc31WdulTC49Qe2k8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKHYvWDxNTmsp/f9pEk6BiNp7WP3z+/0wVAL1Tg+j34=;
 b=VV0SNAkF8iTVtug/BC/I2YrJLKdl5xyeqelSNLPUEMI6VxKORrqmREjTz5fO9GTBAL8JMOWdARm5XZ4ta09bcig3BY+RJPVrXVizn6CIon1uqtv6rmp201QFQh6Ia+gZ2erEiI5oKDvw8JFqaYwNZuKvEyEi8WTl1yhgLoJb0ml6r6g5rDSb7mcQmrXgNRGtGun3jOqTW+anGKJtOgzwPESIqxQ1jmYSa7WWByaUspb/oiarHCyfgwzmXQ9TImb/J3396mtuR/rjVSU/lKz0s0x1VojhNwXdVvsKck3MpxXUD7pruH7COP13IFIgWSGWjUr2WiJLNZR24m2mqOMgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKHYvWDxNTmsp/f9pEk6BiNp7WP3z+/0wVAL1Tg+j34=;
 b=f+9WksV9AZz87hunMv6tI/1Nk5cyXRE4mFK4Wd7V6CV05UbivZZpG5sjAoc89re3uUcCfBe/hxBGfRSvnba3yf2X1y28w7ZW3jkbUCBbFCZm5OysQ7W1kLoof6SEckiT7c3HMObWaUGJD3JAIrY+vdBhaA7TSXWaANeqxiS1Bh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DS1PR04MB9654.namprd04.prod.outlook.com (2603:10b6:8:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 23:04:16 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 23:04:16 +0000
Content-Type: multipart/mixed; boundary="------------q4agu0cO3RYudmzRwzOwbugF"
Message-ID: <22b45a82-79f5-464a-86d4-dbdc10251012@cornell.edu>
Date: Wed, 8 Jan 2025 18:04:14 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 5/5] Cygwin: remove winsup/cygwin/local_includes/mmap_helper.h
X-ClientProxiedBy: BN9PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:408:f4::25) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 25230c7a-f17f-49e5-054f-08dd3038c68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1ZzbUl1dG5TeEwyQ0ZPUFpITkRtQ1YxeFlmUHFPaVNEdVVScEhaSW1JdW5l?=
 =?utf-8?B?MVBJUGFDc1JsR0hCbUJXNTJjTVN6eHBQR2N0N254MDYxSnZ3dnJDajRvZTRE?=
 =?utf-8?B?ME83K1hLemNhbHFIYjNuanNCQjhJYzk2UmJNN2t2VklzN1BjZWM4bXU0ODFO?=
 =?utf-8?B?NlNpWTFZYnZmcmtoTC9SSWZBTVdUQTM3L2dmenFSbWp4ZVdHeUNES0N5bTIr?=
 =?utf-8?B?OGtkR3Q0UjgwN0l6eHhTbW9FNGRXUDE2RGl6YnI3ditOUVJxY3F4SncyT1pq?=
 =?utf-8?B?N2UyeTE3YzliaCtuWFJnM2NZOGJ2Sm5ydEZRdXlOWDBMazVaWXlFYzNNNklM?=
 =?utf-8?B?d0RYc2Z0MkowV084bEJFelZIYkoyekVSaXZkTXVIdzYzNXR1bGRTS3J4SVFy?=
 =?utf-8?B?UXJyTldLU1V4dkZYVFZWV0tsbzlvZWxCRlpxUENoSm0vRXcyK2drQTdZWlpH?=
 =?utf-8?B?aVdBbnBjN3h6VEtYZDRuRjdWTEJqVVpBRGN1ejhDSTM0RUIzcXl5ZGk5dUEz?=
 =?utf-8?B?Q1FTRTA3VWJYRXpYYW5QVUt3QjExSU82TFl2R3V4c25sMzkwb21HKzRPK0lQ?=
 =?utf-8?B?bGp3a1RQVmk1Z3FGejd6UmhVOG8vZXBFa1hocFQ2dzNaOTJCRExJVDR6UVlE?=
 =?utf-8?B?bWR4V3QrckY2ZWJ3QVdnL1psS0hQQVhpeWQ4VmRnWGZlODZDdmxxd3NheWRI?=
 =?utf-8?B?MWtKS2dKRWs2WllWdVEyR0ZPRzJLMS91T1Z3UnBMWXA1T2lHNy8xcExXWVNN?=
 =?utf-8?B?aVBJWVBVTEZoQ3RMS1NtU0R3cUJxakF5eEdFQ3o2Mys1YWNkNUlHZUlnYkdt?=
 =?utf-8?B?Snp6RjEydSttazYyNm5BYXVTeGRXUFg5Zllta3hxOUZmMkVBUHFvYko0OWhK?=
 =?utf-8?B?elVHRnlnNlA5enh2cFh0Y0NaUVpBQytXTVFQWnFlUW56R3BuUUxFS3N3UU1F?=
 =?utf-8?B?RTlIdlBEYlJsM1BZWWRVMGRSVzhFRWdYZEZaYzRMeDl1TmV3TEVRYnprc01w?=
 =?utf-8?B?NkhObXlxY3BwNzBNdDJBVTZSclpiWkUrK1BNN3kwWTJQSFN1WEs5aW1GblhP?=
 =?utf-8?B?QVJoNi9UNnFtbi9yMlV5cWJKcHVrUXNpOXRhRVVoMkhOekdWc09Peno3WENL?=
 =?utf-8?B?d3huUlBSMFdIdzk4VEw4RUZjTVYzRHhaY3Qzb08rODJKSi9oYnYyYXZ1Z1BN?=
 =?utf-8?B?eWxaU3dDWEplaDBTVWtzV2Nreit4VmVLRStpR0Z0dzFPdjRDR004cWg2MjA1?=
 =?utf-8?B?V3dlMkRRZFZrTUNveEdnWTdJVE1UQlVlbmRWUytqa3c2Qm9wRXZZUUJVeFFt?=
 =?utf-8?B?NDgzcUZEbTVwZHFteWE4T1B0SGtVWWJ2MC9ZOFcrdWVqQ1FNNTAwbmN5MGdP?=
 =?utf-8?B?KzNkcldHN0x5UENwWUVSRG1kQlgzK3c1Q25CaWtWWWRJVXBqTG1hU0VHbFRy?=
 =?utf-8?B?ME5wQ2RnZ2Q4aGI1TkM1TzhCY1VXUGpnUUZ2bXBCemJMdjhIR1dGei9SYi9y?=
 =?utf-8?B?T1FqQnFTN0FoNlQ1clkzaHVPenl2ZnoyeXFrSEwwTXVkZ0I1Y3daSFphbFFo?=
 =?utf-8?B?alNsajEvRkR1SE5ObzZKQzBabFVUeGpWT3ZwNkorSzFBTEM5bkZMTFdKU3Rm?=
 =?utf-8?B?WmxUcVhZQllXN08yREx5T2kxNkdEZXdDY2F2eVhXWmorOFpPc2ZjS0RIOW9K?=
 =?utf-8?B?Sjc5ejhRSFpZblJ2SldNSWdubVZOcUt1QzVPZzY5bnlrWnMrT0FkbWoxSnFN?=
 =?utf-8?B?T2hmbXdORzdDaGQybEZlakFrOHhuMDllMG5JelFuSjZ6Tzhrb3Rpc2hmNGxx?=
 =?utf-8?B?RkdhYzkyNTZvZytyT3ZQUklwdkE0S0pxVHhacktEL3YzYXdta1FzV0VROGF4?=
 =?utf-8?Q?hrfnKIM38lfjR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlJxNkVKU0ZFOXI4S0QzRzVqdi90TnJKT3JDdTdTYVRERjkxK3BwTkZha3VT?=
 =?utf-8?B?RU5xdzJ3R0JVb016V2ZYQmp0bXRMeEdiOTNwa2ZVazFaUGptbmNxZmRCdEhm?=
 =?utf-8?B?YmIyM3FDeXRQY2p1ZjBNdnNGSWF5SkdHMzFrZERNTkMvSTRQVkN0QUNvbHYv?=
 =?utf-8?B?eGxFZXNUMDB4S3ZyNmhEZ2NPT2cvQjdkUG42VC9Cd1BUckswd01uamRrb05s?=
 =?utf-8?B?TVB2NDNDWVRyWU41dnp5MkFML0J4U2VnRUZPYzExVThUQWE5Q3BVNFA2ek4v?=
 =?utf-8?B?OTZCSTBXdndkOVFUS2t0OWw3VXlrdVc4NmtjajRHdUlYRVQ4eE9yN0p6dEZn?=
 =?utf-8?B?dC95WU5aMXhXZW9JODRoek9JM0V6ZjRlajZMMldEZnZrWGVWYktidG9JMVRE?=
 =?utf-8?B?WUhaVWVObCtFTW96ai9hcm4xRW9oOGwrMEVNdXVXZ1N1M3lkRDlublJhdlVy?=
 =?utf-8?B?bzRkZ0NOUGFYY1RVaGhIaE0wNllEWjJYOFA0dTI4bU5JK2JvNjlXV0MvUzZ2?=
 =?utf-8?B?bFFmbWJxK29KSzJybWpGdG11am9NN2ZyTTJmNE5Mamw5SVA2anY1b0pWM2RR?=
 =?utf-8?B?cmt0SU90S0NWME41d3JUSEx5U1B6bmI4enFmTTRRYTljeWpxbE1ieEwwY0li?=
 =?utf-8?B?QmVaa2JQVDd0cWQ2V3ArNEV6R0g2QWtRazdiNzBINzVQV1lDYmduam9IT0xp?=
 =?utf-8?B?Y08rR00xcWZDV1hIRU5hQ1hHU2ljZkdFTFVFTjBjOVpUaHlZaHEwWlRPbCtR?=
 =?utf-8?B?YzlTN1E3YmlqeW5XS3lZZlFEcUR1dFR4VFpObytOR0xmUlBSZ3NURWg1Nkc0?=
 =?utf-8?B?WXB5MUdqblJwdk5IOGxtTEMvSHNJenZocU5KQ0hUN25odDUyN0g3TDBja0pY?=
 =?utf-8?B?bE9tenVnS25HdjRaendYUVVOQ1djN2NKSzlML0pVakUycSsxTmFPVzU5cjVu?=
 =?utf-8?B?dTFhb3R3U3l4Y0xOd0t1c2dkY1FpU0JxTUhvZGJjdXhIMHljcnUydjl3SFd5?=
 =?utf-8?B?ajZ0NkllZFJSZm1hUzBsSG44ZVRYWWRUYUFzaUYvZnRheXVoekZSdjBJUGxj?=
 =?utf-8?B?eFFBMk95MTgyNGVSbUhOOVBUU3lkOUhkMERtM2FNRXN2YW1vWGZrOU5VUFZy?=
 =?utf-8?B?a3RGRlpVWkFBbngrcnBnZm1heHBlMVdzQUlkRDA2a2k1WXpwZTFtVTNGV1dK?=
 =?utf-8?B?b3ZCbENBSEZBUUFDZS9pczNvTGdCVXRUdTJiMXNoZTcyUFVicDEwZUhDbVJ5?=
 =?utf-8?B?SDFONW1Yd2FmU0duN2QzMW5uUlV1dEFiZFVmN0VRMHYwT1BLZFZYbUY0YlFi?=
 =?utf-8?B?bWtUSnhES2xQcFJkUjIvYmpraHJuamtjVTY5TUZycEtYbEZBTmdpejcvNkRx?=
 =?utf-8?B?bFROdlo1SmNMbUV5U2JoQ3E4S1EwTGRpR2xWS2tXckhNZ0EzZ3plejBjaG1M?=
 =?utf-8?B?dzhEVG5BajZOUEg0Q0IyRUIwNmp3dXRCWU81aUpubWoyQ0p6UjdFbTJ5clBj?=
 =?utf-8?B?WlhDOEJCSUxBeCtpSFpvS0ZjcHhlZkdOeEFmR3RDZnN5K003MXM5UXlsYkdU?=
 =?utf-8?B?dXdoOS82ZFBDTzZubDlxclNVMmtwNkFxeGhBUTFObGpCOEM0U09iTDhWTGE0?=
 =?utf-8?B?ZU5CejNuOFBqd1VxdVVaaTRqMW54NEtQK1Y4MTZSTzNybzZpaFdOOXE1MzhI?=
 =?utf-8?B?WGxUYklwNDlLUnhmdTdiaWV6dWg2aWRySzdnaC83ZmgxMTAxdXh4aFNoVElq?=
 =?utf-8?B?S1ZSdWt3VFFQaHJzbVF2SG91MTg2SHQzOENXUlZYN1hMd1RSSytnK3l5RFM5?=
 =?utf-8?B?TkhnaHVEQVNWQzZsY0wzclVhR1FNcFZnUEZlWXByQVhWRVI3S0lWdHRoZHFh?=
 =?utf-8?B?RDBhM3R4cG81N0wzNzdRcGppVzNRSW1Lb0d1bFd1VldHUXZ2ajR5R0lMZFVJ?=
 =?utf-8?B?SkE0QWNXMzJOa1RQd3psNldqZWk4b1VsTEYyVXRBZWZ6M0R0Y3Fla3VKeVJq?=
 =?utf-8?B?cjRxaEFaMnZoc21ZMWJmUklza3VyQzBpTGhxd0xscFo4TmcrK2ZjZGJUSW0y?=
 =?utf-8?B?TTI3QWVYUjJneFZCNXFYMVRiejVpK0ZTYXo3NW1JVXQwYTVST1BJSTFiLzZK?=
 =?utf-8?Q?mjbBx9Vbf4DgsdAf9NCi9x65h?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 25230c7a-f17f-49e5-054f-08dd3038c68a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 23:04:16.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCSHl2zVWLR9o8CT34b1HSkWDK+/N+rU9o5bSty6j/BEuVYq992nFknY9WEkNycihxl4PxIq/abHhPT9Lo3XsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9654
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------q4agu0cO3RYudmzRwzOwbugF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
--------------q4agu0cO3RYudmzRwzOwbugF
Content-Type: text/plain; charset=UTF-8;
 name="0005-Cygwin-remove-winsup-cygwin-local_includes-mmap_help.patch"
Content-Disposition: attachment;
 filename*0="0005-Cygwin-remove-winsup-cygwin-local_includes-mmap_help.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4YzNhOTE4YzM0NmE5YWU5N2UyMTk2NzlkNzgwYzliNzE2NTg4ZmM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
U3VuLCAyOSBEZWMgMjAyNCAxODo0Nzo1NCAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggNS81XSBDeWd3
aW46IHJlbW92ZSB3aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL21tYXBfaGVscGVyLmgKCk5v
bmUgb2YgaXRzIG1hY3JvcyBhbmQgZnVuY3Rpb25zIGFyZSB1c2VkIGFueW1vcmUuCgpTaWduZWQt
b2ZmLWJ5OiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KLS0tCiB3aW5zdXAvY3lnd2lu
L2xvY2FsX2luY2x1ZGVzL21tYXBfaGVscGVyLmggfCA4OSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgODkgZGVsZXRpb25zKC0pCiBkZWxldGUgbW9kZSAxMDA2NDQgd2lu
c3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9tbWFwX2hlbHBlci5oCgpkaWZmIC0tZ2l0IGEvd2lu
c3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9tbWFwX2hlbHBlci5oIGIvd2luc3VwL2N5Z3dpbi9s
b2NhbF9pbmNsdWRlcy9tbWFwX2hlbHBlci5oCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCA2NDVjNWUzYWFjODQuLjAwMDAwMDAwMDAwMAotLS0gYS93aW5zdXAvY3lnd2luL2xvY2FsX2lu
Y2x1ZGVzL21tYXBfaGVscGVyLmgKKysrIC9kZXYvbnVsbApAQCAtMSw4OSArMCwwIEBACi0vKiBt
bWFwX2hlbHBlci5oCi0KLVRoaXMgZmlsZSBpcyBwYXJ0IG9mIEN5Z3dpbi4KLQotVGhpcyBzb2Z0
d2FyZSBpcyBhIGNvcHlyaWdodGVkIHdvcmsgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRo
ZQotQ3lnd2luIGxpY2Vuc2UuICBQbGVhc2UgY29uc3VsdCB0aGUgZmlsZSAiQ1lHV0lOX0xJQ0VO
U0UiIGZvcgotZGV0YWlscy4gKi8KLQotI2lmbmRlZiBfTU1BUF9IRUxQRVJfSAotI2RlZmluZSBf
TU1BUF9IRUxQRVJfSAotI2RlZmluZSBfTU1JT1dSQVAoX19wdHIsIF9fbGVuLCBfX2Z1bmMpIFwK
LSh7IFwKLSAgQk9PTCBfX3JlczsgXAotICBmb3IgKGludCBfX2kgPSAwOyBfX2kgPCAyOyBfX2kr
KykgXAotICAgIHsgXAotICAgICAgX19yZXMgPSBfX2Z1bmM7IFwKLSAgICAgIGlmIChfX3JlcyB8
fCBfX2kgPiAwKSBcCi0JYnJlYWs7IFwKLSAgICAgIERXT1JEIF9fZXJyY29kZSA9IEdldExhc3RF
cnJvciAoKTsgXAotICAgICAgaWYgKF9fZXJyY29kZSAhPSBFUlJPUl9OT0FDQ0VTUykgXAotCWJy
ZWFrOyBcCi0gICAgICBzd2l0Y2ggKG1tYXBfaXNfYXR0YWNoZWRfb3Jfbm9yZXNlcnZlIChfX3B0
ciwgX19sZW4pKSBcCi0JeyBcCi0JY2FzZSBNTUFQX05PUkVTRVJWRV9DT01NSVRFRDogXAotCSAg
Y29udGludWU7IFwKLQljYXNlIE1NQVBfUkFJU0VfU0lHQlVTOiBcCi0JICByYWlzZShTSUdCVVMp
OyBcCi0JZGVmYXVsdDogXAotCSAgYnJlYWs7IFwKLQl9IFwKLSAgICAgIGJyZWFrOyBcCi0gICAg
fSBcCi0gIF9fcmVzOyBcCi19KQotCi0jZGVmaW5lIF9NTVNPQ0tXUkFQKF9fcHRyLCBfX2NvdW50
LCBfX2Z1bmMpIFwKLSh7IFwKLSAgaW50IF9fcmVzOyBcCi0gIGZvciAoaW50IF9faSA9IDA7IF9f
aSA8IDI7IF9faSsrKSBcCi0gICAgeyBcCi0gICAgICBfX3JlcyA9IF9fZnVuYzsgXAotICAgICAg
aWYgKCFfX3JlcyB8fCBfX2kgPiAwKSBcCi0JYnJlYWs7IFwKLSAgICAgIERXT1JEIF9fZXJyY29k
ZSA9IFdTQUdldExhc3RFcnJvciAoKTsgXAotICAgICAgaWYgKF9fZXJyY29kZSAhPSBXU0FFRkFV
TFQpIFwKLQlicmVhazsgXAotICAgICAgZm9yICh1bnNpZ25lZCBfX2ogPSAwOyBfX2ogPCBfX2Nv
dW50OyBfX2orKykgXAotCXN3aXRjaCAobW1hcF9pc19hdHRhY2hlZF9vcl9ub3Jlc2VydmUgKF9f
cHRyW19fal0uYnVmLCBfX3B0cltfX2pdLmxlbikpIFwKLQkgIHsgXAotCSAgY2FzZSBNTUFQX05P
UkVTRVJWRV9DT01NSVRFRDogXAotCSAgICBnb3RvIGtlZXB0cnlpbmc7IFwKLQkgIGNhc2UgTU1B
UF9SQUlTRV9TSUdCVVM6IFwKLQkgICAgcmFpc2UoU0lHQlVTKTsgXAotCSAgZGVmYXVsdDogXAot
CSAgICBicmVhazsgXAotCSAgfSBcCi0gICAgICBicmVhazsgXAotICAgIGtlZXB0cnlpbmc6IFwK
LSAgICAgIGNvbnRpbnVlOyBcCi0gICAgfSBcCi0gIF9fcmVzOyBcCi19KQotCi1leHRlcm4gaW5s
aW5lIEJPT0wKLW1tUmVhZEZpbGUgKEhBTkRMRSBoRmlsZSwgTFBWT0lEIGxwQnVmZmVyLCBEV09S
RCBuTnVtYmVyT2ZCeXRlc1RvUmVhZCwKLQkgICAgTFBEV09SRCBscE51bWJlck9mQnl0ZXNSZWFk
LCBMUE9WRVJMQVBQRUQgbHBPdmVybGFwcGVkKQotewotICByZXR1cm4gX01NSU9XUkFQIChscEJ1
ZmZlciwgbk51bWJlck9mQnl0ZXNUb1JlYWQsCi0JCSAgICAoUmVhZEZpbGUgKGhGaWxlLCBscEJ1
ZmZlciwgbk51bWJlck9mQnl0ZXNUb1JlYWQsCi0JCQkgICAgICAgbHBOdW1iZXJPZkJ5dGVzUmVh
ZCwgbHBPdmVybGFwcGVkKSkpOwotfQotCi0jaWZkZWYgX1dJTlNPQ0tfSAotZXh0ZXJuIGlubGlu
ZSBpbnQKLW1tV1NBUmVjdkZyb20gKFNPQ0tFVCBzLCBMUFdTQUJVRiBscEJ1ZmZlcnMsIERXT1JE
IGR3QnVmZmVyQ291bnQsCi0JICAgIExQRFdPUkQgbHBOdW1iZXJPZkJ5dGVzUmVjdmQsIExQRFdP
UkQgbHBGbGFncywKLQkgICAgc3RydWN0IHNvY2thZGRyKiBscEZyb20sCi0JICAgIExQSU5UIGxw
RnJvbWxlbiwgTFBXU0FPVkVSTEFQUEVEIGxwT3ZlcmxhcHBlZCwKLQkgICAgTFBXU0FPVkVSTEFQ
UEVEX0NPTVBMRVRJT05fUk9VVElORSBscENvbXBsZXRpb25Sb3V0aW5lKQotewotICByZXR1cm4g
X01NU09DS1dSQVAgKGxwQnVmZmVycywgZHdCdWZmZXJDb3VudCwKLQkJICAgICAgKG1tV1NBUmVj
dkZyb20ocywgbHBCdWZmZXJzLCBkd0J1ZmZlckNvdW50LAotCQkJCSAgICAgbHBOdW1iZXJPZkJ5
dGVzUmVjdmQsIGxwRmxhZ3MsIGxwRnJvbSwKLQkJCQkgICAgIGxwRnJvbWxlbiwgbHBPdmVybGFw
cGVkLAotCQkJCSAgICAgbHBDb21wbGV0aW9uUm91dGluZSkpKTsKLX0KLSNlbmRpZiAvKl9XSU5T
T0NLX0gqLwotCi0jZW5kaWYgLypfTU1BUF9IRUxQRVJfSCovCi0tIAoyLjQ1LjEKCg==

--------------q4agu0cO3RYudmzRwzOwbugF--
