Return-Path: <SRS0=odvg=T2=cornell.edu=kbrown@sourceware.org>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070c.outbound.protection.outlook.com [IPv6:2a01:111:f403:2418::70c])
	by sourceware.org (Postfix) with ESMTPS id D338C3858D1E
	for <cygwin-patches@cygwin.com>; Thu,  2 Jan 2025 21:42:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D338C3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D338C3858D1E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2418::70c
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1735854137; cv=pass;
	b=wfSmwkRDkS3qSUXZjARTOtI7pyss4yjjICu4C6Vvqj13mjn45k3S2IAdVqf3WiKDgleMiLTvMV8JNtHNYko1vcusQTI58MOJQYd3ZTDTQM8c2xasMQTIb08cu4Vmc55hbTMUkTuVCFDec0Qz43uWDN4NyZbb/DrGs7vxKkw6plY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1735854137; c=relaxed/simple;
	bh=ZNVWpGCOw9U67ojb7qXGTVWVhSH+G0QW8hheQKfNrfA=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=bt0oJiltvjm0ujwmBqOcT9G3DiupuglAXryK6pcgcmdk4Qar3rh0bjb9F5KsDlB4RP5r1lxZ+iqEyp3XbvCCXcmPbjJaG6UtMm7X1fvlxTd8jAvAXZLZdQtk7cmcWOCdJxOe2hb2EVBTtEyOphllKjHzVLrxHO6jmqsGTJxsc+I=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D338C3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=O0arCqk/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6nEOx4SCPUEW7qY/o6z99YpNcih6A7lvxiCLwpbA/o9tXLtoJ0o5ujE0Bsnj+t2O6Q+8rirzXSjd5dvRjgs5fQyYv+XvET0GDjGmPF9jsVvc+aBEQBgQcoThE3fd7JbSNUKTZmVcZndpxN24kiiuBzd1NpPiAZykBVWTEkHoHfGL5MKgZ8lf03HTm+hrkRaC8hWWG1TWZJkx9PVUTJ9UviTzTz2v69fEciEm1mx2FzShWR7LFmrwmoZoQNsLjhoUEx+7/IyilLBxzH2ccxHisdrMSePBCDLoeOz01L75krVYqqwWxYDAeID2M5jNUCPwMNPvNOj3yOQT2Pr5togKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA8f+d5iIgoMT5OfLwTVIhq6ai0+KOPFQ2IXjPvaRpI=;
 b=WRShSEctPllqZ7T+/CzxAM8EJBlE8z881P26PWJif6xBIcUSqnKRb3Ww49gRuSp6U56OAVC8T4VoxCP6xQJ07GJNTbXEg2tGGNua4eWGNMPBvsghD6G57vxCNXoB7X1tN48PEAelGwzpCxG2ak93E1ueIFC83T8ObpthCjJs0302i99nhyiOJ23V98h/YO5X68mnKwPwczPv1XLAPvm+PZhS3X+xG0XlV3RG/e+7JTYiiUymC8zA/D1H7q357SjIQf87HwKRpLg3zZm1Bij2msAaJOLSz3joRjVCYJAXIkDyvTABirCdb0EdKaHP2LrHSHYqFM8CLYpAcYewa1FSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA8f+d5iIgoMT5OfLwTVIhq6ai0+KOPFQ2IXjPvaRpI=;
 b=O0arCqk/Vi+460jaFSZ2clKqxB7baJRNoKA7eJAAWTXVAJnZU8ukDwSEEAYh+KqjQjb0ltD4wbO6bd0s9/vrm9Rreu5i5qePLyQF2/8+waZSEHEb7ge74+Qe6iIOcrcWND8KdV1HBTrWSPtUhm0Svs9QSPJY2wPHkts8CTtBv7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by BN0PR04MB7982.namprd04.prod.outlook.com (2603:10b6:408:155::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Thu, 2 Jan
 2025 21:42:10 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8314.011; Thu, 2 Jan 2025
 21:42:10 +0000
Content-Type: multipart/mixed; boundary="------------XVN9V10ylJnKEQuhWav61Oa6"
Message-ID: <9b717926-06fb-4d34-a473-a709316de429@cornell.edu>
Date: Thu, 2 Jan 2025 16:42:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: mmap: allow remapping part of an existing
 anonymous, mapping
To: cygwin-patches@cygwin.com
References: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
X-ClientProxiedBy: MN2PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:208:239::19) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|BN0PR04MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: afe5778a-252a-42d8-cfa5-08dd2b764ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHFXSGxMMUYrczUydTFOU3FQaUc4NW13cUFRNHk2NGlhaWpaYUd5MjlnaVpx?=
 =?utf-8?B?bjRJeU4wbUpxU29rbHptMzhuTjU3K1FaWXZmb2U4QlBoQUlkR0JWRmZtbGlV?=
 =?utf-8?B?TGI3eHNpamdaUm9CMFRjZE5GaGFsVGRGY1NhWUpOcnZMQkpQd2hqeGFkSzkv?=
 =?utf-8?B?STRCUFlMSTUwQzJ6c3JNT2oxcW91d3B1dTNZZVJWK0NZWVBrZFF5R1BPbDBv?=
 =?utf-8?B?RWRHNXRqTUF0YXE3RDBqMHpNUTVHVVQ0ajg5YmtEQWFrd0ZkT3crOUZodWdo?=
 =?utf-8?B?bUxUd3B0R3paUEw0ZVlzZy81MUY0WVdqRE00L1oyYzRLVXh6WjU4MFltRm5p?=
 =?utf-8?B?QXc3V28xUU1KT3dPNGtDRXFaaEZEUWNkdXVsWDZwRVlHWXhoYVpxYlp6U1Jj?=
 =?utf-8?B?aFVub0xTYlp2eUhmMXhveEF4SFUvWDZGZklISXoxL3ppTXdCYjNwVENObmZR?=
 =?utf-8?B?Z1NVTWRDVWhFYnVITXVYU3U5NXZvNWFZL3AwSVN4TE01Q1A0STh5L3ZVR0xJ?=
 =?utf-8?B?QWpiTDZ6dU1tbHd6aTVnbjlGRERzWGFId2xlWGd5Z3J4dVN3UmpJUGxQd3J3?=
 =?utf-8?B?a0VqTmN5cUZZV3VBMDdlRGlvNlZGZXdlYTFLOUNBdXUzWHJ3Wkt1Z0N5b0Z6?=
 =?utf-8?B?M01rZGRhVDkzcmo2dUNTWTN6R0YrMDVRZml0anRGNFlLdVJpcmhLc2MyL2Nt?=
 =?utf-8?B?TVFYcE41ZFJvTnV4bHhRdkhsV3FJb2h2Sjc3dDVqY2FWNG10NUt1L2h2eTZq?=
 =?utf-8?B?WDlNQ2piVWl0cE15VzJDKzY0ZkVWbXlydmpGZHFTaG5BTDN4V2JHVzNjTTky?=
 =?utf-8?B?QS9PT1BNdjg5UmRiYnZ4cmljeVc4TFJESnBUbHp2SEwvaGJKTkxQVlk5RURx?=
 =?utf-8?B?K3lxQThPMXlmczEvZHh5V0FVc3J4dmpON2dST0hSZlNFYmJlelBOUUlWcFRk?=
 =?utf-8?B?alZEVi9Pam1FR1hjdUtneXFiTkY1ckdMU2dRSzdhaTFZaDE0S1gwZjh2dWVK?=
 =?utf-8?B?MWFNOHl5Unk0ZFExMkxOeXhRSzdROXlLZ0hkWXpLNWIyNzFQaGFnM21YSlRI?=
 =?utf-8?B?cE02Z01oSkxOd1R4RE0zWUhoQU5yendCdWtleWVDdzhzS2hlN1ZkMnVEWmZx?=
 =?utf-8?B?a0p1cE1DeGlUd1AxcHFFdE93djU3Ty84eHpJTHRBTzA0eUZZWi8wTE5vZFBI?=
 =?utf-8?B?VHhYRmt4WWVCOENHNVduTVN2bDU3VzlDRGlZTGpMMzVmZ0doRExXZjlIdFp5?=
 =?utf-8?B?VldSMjdkVjZ4WjdzcWZ5d1FuNmF3MXEvR1FNU2JCWExMVXRxSXVhcVpld2V5?=
 =?utf-8?B?WkRIMGs3SU5nUTdvTE5NM2taaXFyYy9xTHA5MFhUYjF6RDE3anlnbFVLSFZl?=
 =?utf-8?B?bTBVMEtoUWRyNXQvbnA3cGQvZXhZcFdUQ0huRVk2M1Y4WjFxUWhueElZSGd3?=
 =?utf-8?B?QkI5SUs4SjRXNzM1djZLUStjcE95Mk9iNDJ6MkZPUlcyb3RmR1UxM0lVdGkv?=
 =?utf-8?B?OEFsMTRGZ0o2R0hORVZyWWd3aDVHdG1ydDlPMUp0Z1FuaTUxWU5tdjhRZU9Q?=
 =?utf-8?B?U2x6TCtJK3E3dUJqTmY0Sy9LT1NZSkt4MTlLU1ZIR0k3OWlxbnVyQU9PMm9z?=
 =?utf-8?B?eEM3UlA2bGFpTngvNUpGM1ZIdEtMMTV5VGNlOEV3THFRN2xyMjdCaWZ6dUx4?=
 =?utf-8?B?aUNudTc5VHdNcFMzQkExdzNPaVhrdmRQY0p2NUk5UTNlREFVQ0VXajFWQ1BZ?=
 =?utf-8?B?THQvYVRHZXNWSFZvWG1rZUtreHRpUFlWdDRWTFYvWTh5VVB5VHlVTWJyTkNR?=
 =?utf-8?B?cDBSKzN2cVF5SEZkRkh3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGNaZzE1ZjN1Z1VLelpJa2JjbWp0KzdQT25mbjRYUzRRRHdOOEhpRTU2UnNF?=
 =?utf-8?B?SzdvalRMOTladm1jVGp2T0hNNTRsdHJlQkNvbGlJcFlsSm5qdnhSdUhaVjc0?=
 =?utf-8?B?Mmk1Q0IyellndlEyV3lGejBxMlBZWWh6OFd6WUpUMTNCM3BaMVg0eVQ4QmdP?=
 =?utf-8?B?YzRmd211a0thYWlKNnJ0OXJnRmlsbVJXYytscGNFSGVLYWd3WHdrL0g2ZDlG?=
 =?utf-8?B?UTluU2U4R1lZNjhoUUlXTlJJdFhBQ210MFNFNk1XVlIwTG5hVWhNUWJSbllx?=
 =?utf-8?B?QjBhRkdwb2ZGU2R1U21zREtFdks4M3ZXVXZsUHZjM2VqTk5tOTJOdkhkbE9D?=
 =?utf-8?B?R3BaR0xWcUJ1WjNjUHhNRGEwYjlKQTFrN05Sb2ZFdDhpWWd0VHVoclNIQVNM?=
 =?utf-8?B?WHNMK3M2NFA3Yi9oS04xTGVQWFNwbTF6emVvekVHZWk3ak0yU1BwUzdpTEVV?=
 =?utf-8?B?Q2ZzZWlCQ1RzdFQzZEZnSDlGNkRnSmpPWHA4NC9yZjJyc3RtWjVKRExFdDRB?=
 =?utf-8?B?VkZkWGhKRjZ6YnBNNG5hWkxJdmRBSWpZR2QzNUhqU0lnRUtmQ2NRYVRtQzkz?=
 =?utf-8?B?WW1ydEY5dExLYkpMWFpzV1B3dWZXRkMwUlFySllhVDJFblIxR3M2em93Wm9G?=
 =?utf-8?B?V0tWNWM1TWhMVEwvTlhsVVpWeDIyNWdaczFjNi80NDJzWTF3NlFMRk0xV294?=
 =?utf-8?B?R1BwQmRDVzdtcmpDK1kwTm5pcURNT05nMnp2aHdSTk9TNkwwRmtOWjI4VVJK?=
 =?utf-8?B?SmJ6TXpMTTA4SjhBKzVITjIwaEJjeUpUcS82NnN1OGwxU2p0ejJTT1l1QjRM?=
 =?utf-8?B?KzJpSHlDVHFPdStWSXJrYjlKMGVLTUt6SkRKWGhCcFh2SVB2ZWJyeWQrWExj?=
 =?utf-8?B?WjlHRHdjT28wdC9TbGFUSmt3WHpucHQwMld5YXlrU2V3d1ZyeGhvQnovRjRR?=
 =?utf-8?B?VTJsWEt2SmFWUjM0TXZiYTg5ZjY1VlE0TFpzY2cybFQ1OGcyUXE4L29TNElu?=
 =?utf-8?B?QUV1R1AxNW52N1Y2V2h2M0J6TFJHbGlXT2lUOE9TWVd6ZjYxMXhHRmREUmhJ?=
 =?utf-8?B?WGJPaFZMQXg0WldCM1ZFUnEyMlJWMjUreE9xbW1RWEg0Si9xMTFHL2p4V3lz?=
 =?utf-8?B?Wi9ZL2VmbWpPMUFab3lGc3ZyY1k4SG1Fd3Z4ZnFQRkZyVEJFcnRHeVo0Q1U4?=
 =?utf-8?B?STFDa1d6dnlscjU5aVNsU2dEMllXMjNtakg3aEloeC9mVlpVUTNZQmFNeVpK?=
 =?utf-8?B?bUxBRm1KT3ZjR0lFWkJTaWRZTkUrQVNnakIrcUpQTUl6V3dEak9DOEtHT3Q0?=
 =?utf-8?B?MjhxUm0vZExPVlArSEZ0bXRMZVV4QkhBU1lRNUt3eG9MYnZDVGtKOGtFaENt?=
 =?utf-8?B?Q2pYTk8zRGM2b3I0Z0FwTDFMUGlndmV2S3A3T1ExN3pGeExFbnBUM0tlQVZw?=
 =?utf-8?B?T2dQMXRlTFdRNzcrZWFTUzhJUjFzbVpWT0RXM0dIZEFQUHFVbzRna0d1TU1U?=
 =?utf-8?B?WlJGQzN1RGF2dDZJZktGWjBIZDdIa0FtNTdEN3d1WFI0UEhBQkZxeTZ4ZCtn?=
 =?utf-8?B?QWFvWHFMUWxDamNyM01GNnl5YUVSNzdYUUdmZFJwTktFNzdOdWtFUTFTZVM5?=
 =?utf-8?B?elY1anRkc0xJbjdTL0Rpa252WnRzeWNUSlg1T3NTK1JzWE1nenJ4QTQrc1ZG?=
 =?utf-8?B?Zk1JRnl3QjhxRmN3MVpuYkQ4MGhPZy92SE1ucndYTUZxNmNrWURsZlp6dmZK?=
 =?utf-8?B?VGg4eTBabDJiRmdCcVZ1bmx6Y1dPT05MS1Mvd2hCZk9yYU43YlFNSkZ1N2c3?=
 =?utf-8?B?d0RIN2FOOCtkN2puVnRDbWpOYkljaDZWK0wwQkZyTjRvbW5lVTFPNForTW12?=
 =?utf-8?B?VE54Q09wYTRzWDh4bGRMQlUyeHozM3A0eU1CajIvcVBnRHpoZTJvRmx2Y0Fm?=
 =?utf-8?B?SzQxTFhORXErMG5zOFBVcXNJOVYxSVJlUzNvRitkUDQ5YmhDM0JERGtNM0Nq?=
 =?utf-8?B?Wm1OMHRpclFxMFI4dzZiMXI2ZW0zTmxNZ1ZrdlRURTRWL3NlK3plU0p3U3pZ?=
 =?utf-8?B?R1IrV3RxOEc3U2dGaG5zY29meHpjK2M2eW1YZ2IzWWUyTlVsTWtBZUg2T1ZV?=
 =?utf-8?Q?sIKQ7dOAcLrst8tDR1x9zdatJ?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: afe5778a-252a-42d8-cfa5-08dd2b764ff9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 21:42:10.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLmx4IpIjKTaxrEPgaEumSBJWBl36ouuNl5sGhhxce1wZLtbZMHveRxW7KylYpZ/LadRRVq3L80AuTOoh/dVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7982
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------XVN9V10ylJnKEQuhWav61Oa6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/28/2024 4:40 PM, Ken Brown wrote:
> Patch attached.
> 
> I'm not sure I handled the noreserve case in the best possible way, but 
> at least I didn't make it worse.  The behavior in that case after my 
> patch is the same as before.
> 
> Ken
> 
> P.S. If no one has any comments in the next week or so, I might just go 
> ahead and push it (to main only), so it can get some testing.  Corinna 
> has already said that's OK in https://cygwin.com/pipermail/cygwin- 
> developers/2024-December/012723.html

v2 is attached.  The only difference is that I clarified in the log 
message and the release note that this affects only the MAP_FIXED case.

Ken
--------------XVN9V10ylJnKEQuhWav61Oa6
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-mmap-allow-remapping-part-of-an-existing-anon.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-mmap-allow-remapping-part-of-an-existing-anon.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2MjVjNzdhODI5MjUxODU4MDVhZDU3ZDVlZjNmMGQwZDkwZGM5YjU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
RnJpLCAyNyBEZWMgMjAyNCAxNjowOTo0MCAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIEN5Z3dp
bjogbW1hcDogYWxsb3cgcmVtYXBwaW5nIHBhcnQgb2YgYW4gZXhpc3RpbmcKIGFub255bW91cyBt
YXBwaW5nCgpQcmV2aW91c2x5IG1tYXAgd2l0aCBNQVBfRklYRUQgd291bGQgZmFpbCB3aXRoIEVJ
TlZBTCBvbiBhbiBhdHRlbXB0IHRvCm1hcCBhbiBhZGRyZXNzIHJhbmdlIGNvbnRhaW5lZCBpbiB0
aGUgY2h1bmsgb2YgYW4gZXhpc3RpbmcgbWFwcGluZy4KV2l0aCB0aGlzIGNvbW1pdCwgbW1hcCB3
aWxsIHN1Y2NlZWQsIHByb3ZpZGVkIHRoZSBtYXBwaW5ncyBhcmUKYW5vbnltb3VzLCB0aGUgTUFQ
X1NIQVJFRC9NQVBfUFJJVkFURSBmbGFncyBhZ3JlZSwgYW5kIE1BUF9OT1JFU0VSVkUKaXMgbm90
IHNldCBmb3IgZWl0aGVyIG1hcHBpbmcuCgpBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9w
aXBlcm1haWwvY3lnd2luLzIwMjQtRGVjZW1iZXIvMjU2OTAxLmh0bWwKU2lnbmVkLW9mZi1ieTog
S2VuIEJyb3duIDxrYnJvd25AY29ybmVsbC5lZHU+Ci0tLQogd2luc3VwL2N5Z3dpbi9tbS9tbWFw
LmNjICAgIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQogd2luc3Vw
L2N5Z3dpbi9yZWxlYXNlLzMuNi4wIHwgIDYgKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzMgaW5z
ZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9t
bS9tbWFwLmNjIGIvd2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjCmluZGV4IGZjMTI2YTg3MDcyYS4u
MDIyNDc3OTQ1OGVmIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21tL21tYXAuY2MKKysrIGIv
d2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjCkBAIC00OTQsMTggKzQ5NCwyNCBAQCBtbWFwX3JlY29y
ZDo6bWFwX3BhZ2VzIChjYWRkcl90IGFkZHIsIFNJWkVfVCBsZW4sIGludCBuZXdfcHJvdCkKICAg
b2ZmX3Qgb2ZmID0gYWRkciAtIGdldF9hZGRyZXNzICgpOwogICBvZmYgLz0gd2luY2FwLnBhZ2Vf
c2l6ZSAoKTsKICAgbGVuID0gUEFHRV9DTlQgKGxlbik7Ci0gIC8qIEZpcnN0IGNoZWNrIGlmIHRo
ZSBhcmVhIGlzIHVudXNlZCByaWdodCBub3cuICovCi0gIGZvciAoU0laRV9UIGwgPSAwOyBsIDwg
bGVuOyArK2wpCi0gICAgaWYgKE1BUF9JU1NFVCAob2ZmICsgbCkpCi0gICAgICB7Ci0Jc2V0X2Vy
cm5vIChFSU5WQUwpOwotCXJldHVybiBmYWxzZTsKLSAgICAgIH0KLSAgaWYgKCFub3Jlc2VydmUg
KCkKLSAgICAgICYmICFWaXJ0dWFsUHJvdGVjdCAoZ2V0X2FkZHJlc3MgKCkgKyBvZmYgKiB3aW5j
YXAucGFnZV9zaXplICgpLAotCQkJICBsZW4gKiB3aW5jYXAucGFnZV9zaXplICgpLAotCQkJICA6
Omdlbl9wcm90ZWN0IChuZXdfcHJvdCwgZ2V0X2ZsYWdzICgpKSwKLQkJCSAgJm9sZF9wcm90KSkK
KyAgLyogVmlydHVhbFByb3RlY3QgY2FuIG9ubHkgYmUgY2FsbGVkIG9uIGNvbW1pdHRlZCBwYWdl
cywgc28gaXQncyBub3QKKyAgICAgY2xlYXIgaG93IHRvIGNoYW5nZSBwcm90ZWN0aW9uIGluIHRo
ZSBub3Jlc2VydmUgY2FzZS4gIEluIHRoaXMKKyAgICAgY2FzZSB3ZSB3aWxsIHRoZXJlZm9yZSBy
ZXF1aXJlIHRoYXQgdGhlIHBhZ2VzIGFyZSB1bm1hcHBlZCwgaW4KKyAgICAgb3JkZXIgdG8ga2Vl
cCB0aGUgYmVoYXZpb3IgdGhlIHNhbWUgYXMgaXQgd2FzIGJlZm9yZSBuZXdfcHJvdCB3YXMKKyAg
ICAgaW50cm9kdWNlZC4gIEZJWE1FOiBJcyB0aGVyZSBhIGJldHRlciB3YXkgdG8gaGFuZGxlIHRo
aXM/ICovCisgIGlmIChub3Jlc2VydmUgKCkpCisgICAgeworICAgICAgZm9yIChTSVpFX1QgbCA9
IDA7IGwgPCBsZW47ICsrbCkKKwlpZiAoTUFQX0lTU0VUIChvZmYgKyBsKSkKKwkgIHsKKwkgICAg
c2V0X2Vycm5vIChFSU5WQUwpOworCSAgICByZXR1cm4gZmFsc2U7CisJICB9CisgICAgfQorICBl
bHNlIGlmICghVmlydHVhbFByb3RlY3QgKGdldF9hZGRyZXNzICgpICsgb2ZmICogd2luY2FwLnBh
Z2Vfc2l6ZSAoKSwKKwkJCSAgICBsZW4gKiB3aW5jYXAucGFnZV9zaXplICgpLAorCQkJICAgIDo6
Z2VuX3Byb3RlY3QgKG5ld19wcm90LCBnZXRfZmxhZ3MgKCkpLAorCQkJICAgICZvbGRfcHJvdCkp
CiAgICAgewogICAgICAgX19zZXRlcnJubyAoKTsKICAgICAgIHJldHVybiBmYWxzZTsKQEAgLTYy
NSw4ICs2MzEsOSBAQCBtbWFwX2xpc3Q6OnRyeV9tYXAgKHZvaWQgKmFkZHIsIHNpemVfdCBsZW4s
IGludCBuZXdfcHJvdCwgaW50IGZsYWdzLCBvZmZfdCBvZmYpCiAKICAgaWYgKG9mZiA9PSAwICYm
ICFmaXhlZCAoZmxhZ3MpKQogICAgIHsKLSAgICAgIC8qIElmIE1BUF9GSVhFRCBpc24ndCBnaXZl
biwgY2hlY2sgaWYgdGhpcyBtYXBwaW5nIG1hdGNoZXMgaW50byB0aGUKLQkgY2h1bmsgb2YgYW5v
dGhlciBhbHJlYWR5IHBlcmZvcm1lZCBtYXBwaW5nLiAqLworICAgICAgLyogSWYgTUFQX0ZJWEVE
IGlzbid0IGdpdmVuLCB0cnkgdG8gc2F0aXNmeSB0aGlzIG1hcHBpbmcgcmVxdWVzdAorCSBieSBy
ZWN5Y2xpbmcgdW5tYXBwZWQgcGFnZXMgaW4gdGhlIGNodW5rIG9mIGFuIGV4aXN0aW5nCisJIG1h
cHBpbmcuICovCiAgICAgICBTSVpFX1QgcGxlbiA9IFBBR0VfQ05UIChsZW4pOwogICAgICAgTElT
VF9GT1JFQUNIIChyZWMsICZyZWNzLCBtcl9uZXh0KQogCWlmIChyZWMtPmZpbmRfdW51c2VkX3Bh
Z2VzIChwbGVuKSAhPSAoU0laRV9UKSAtMSkKQEAgLTY0MCw5ICs2NDcsMTAgQEAgbW1hcF9saXN0
Ojp0cnlfbWFwICh2b2lkICphZGRyLCBzaXplX3QgbGVuLCBpbnQgbmV3X3Byb3QsIGludCBmbGFn
cywgb2ZmX3Qgb2ZmKQogICAgIH0KICAgZWxzZSBpZiAoZml4ZWQgKGZsYWdzKSkKICAgICB7Ci0g
ICAgICAvKiBJZiBNQVBfRklYRUQgaXMgZ2l2ZW4sIHRlc3QgaWYgdGhlIHJlcXVlc3RlZCBhcmVh
IGlzIGluIGFuCi0JIHVubWFwcGVkIHBhcnQgb2YgYW4gc3RpbGwgYWN0aXZlIG1hcHBpbmcuICBU
aGlzIGNhbiBoYXBwZW4KLQkgaWYgYSBtZW1vcnkgcmVnaW9uIGlzIHVubWFwcGVkIGFuZCByZW1h
cHBlZCB3aXRoIE1BUF9GSVhFRC4gKi8KKyAgICAgIC8qIElmIE1BUF9GSVhFRCBpcyBnaXZlbiwg
dGVzdCBpZiB0aGUgcmVxdWVzdGVkIGFyZWEgaXMKKwkgY29udGFpbmVkIGluIHRoZSBjaHVuayBv
ZiBhbiBleGlzdGluZyBtYXBwaW5nLiAgSWYgc28sIGFuZCBpZgorCSB0aGUgZmxhZ3Mgb2YgdGhh
dCBtYXBwaW5nIGFyZSBjb21wYXRpYmxlIHdpdGggdGhvc2UgaW4gdGhlCisJIHJlcXVlc3QsIHRy
eSB0byByZXNldCB0aGUgcHJvdGVjdGlvbiBvbiB0aGUgcmVxdWVzdGVkIGFyZWEuICovCiAgICAg
ICBjYWRkcl90IHVfYWRkcjsKICAgICAgIFNJWkVfVCB1X2xlbjsKIApAQCAtMTA2MSw3ICsxMDY5
LDggQEAgZ29fYWhlYWQ6CiAgIExJU1RfV1JJVEVfTE9DSyAoKTsKICAgbWFwX2xpc3QgPSBtbWFw
cGVkX2FyZWFzLmdldF9saXN0X2J5X2ZkIChmZCwgJnN0KTsKIAotICAvKiBUZXN0IGlmIGFuIGV4
aXN0aW5nIGFub255bW91cyBtYXBwaW5nIGNhbiBiZSByZWN5Y2xlZC4gKi8KKyAgLyogVHJ5IHRv
IHNhdGlzZnkgdGhlIHJlcXVlc3QgYnkgcmVzZXR0aW5nIHRoZSBwcm90ZWN0aW9uIG9uIHBhcnQg
b2YKKyAgICAgYW4gZXhpc3RpbmcgYW5vbnltb3VzIG1hcHBpbmcuICovCiAgIGlmIChtYXBfbGlz
dCAmJiBhbm9ueW1vdXMgKGZsYWdzKSkKICAgICB7CiAgICAgICBjYWRkcl90IHRyaWVkID0gbWFw
X2xpc3QtPnRyeV9tYXAgKGFkZHIsIGxlbiwgcHJvdCwgZmxhZ3MsIG9mZik7CmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAgYi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42
LjAKaW5kZXggNGI3NjA0OTA3OTAyLi4xNzFlZDE1ZTE0NmEgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9j
eWd3aW4vcmVsZWFzZS8zLjYuMAorKysgYi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAKQEAg
LTc4LDMgKzc4LDkgQEAgV2hhdCBjaGFuZ2VkOgogLSBSYWlzZSBtYXhpbXVtIHBpZCBmcm9tIDY1
NTM2IHRvIDQxOTQzMDQgdG8gYWNjb3VudCBmb3Igc2NlbmFyaW9zCiAgIHdpdGggbG90cyBvZiBD
UFVzIGFuZCBsb3RzIG9mIHRhc2tzLgogICBBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9w
aXBlcm1haWwvY3lnd2luLzIwMjQtRGVjZW1iZXIvMjU2OTI3Lmh0bWwKKworLSBBbGxvdyBtbWFw
IHdpdGggTUFQX0ZJWEVEIHRvIHN1Y2NlZWQgb24gYW4gYWRkcmVzcyByYW5nZSBjb250YWluZWQK
KyAgaW4gdGhlIGNodW5rIG9mIGFuIGV4aXN0aW5nIGFub255bW91cyBtYXBwaW5nLCBwcm92aWRl
ZCB0aGUKKyAgTUFQX1NIQVJFRC9NQVBfUFJJVkFURSBmbGFncyBhZ3JlZSBhbmQgTUFQX05PUkVT
RVJWRSBpcyBub3Qgc2V0IGZvcgorICBlaXRoZXIgbWFwcGluZy4KKyAgQWRkcmVzc2VzOiBodHRw
czovL2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi8yMDI0LURlY2VtYmVyLzI1NjkwMS5odG1s
Ci0tIAoyLjQ1LjEKCg==

--------------XVN9V10ylJnKEQuhWav61Oa6--
