Return-Path: <SRS0=StkZ=V3=hotmail.com=Strawberry_Str@sourceware.org>
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn190110001.outbound.protection.outlook.com [IPv6:2a01:111:f403:d405::1])
	by sourceware.org (Postfix) with ESMTPS id 12E593858D1E
	for <cygwin-patches@cygwin.com>; Sat,  8 Mar 2025 08:43:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 12E593858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 12E593858D1E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d405::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1741423393; cv=pass;
	b=g3/2ofYel1/yBviJ4uGzDaF2AN3211CSfXL2bTMRUNJ/TQL2m1Qf2AhcfQ6VExwzN2HaZbLytbtaNIsiRon1m0SK8+PdYW+IS8gSd5wFFJ9ZUmy5HWUOZKuCl/jIF3kgoihqItnVrkWmo+B5dyuf5HNR0PMWeJ5hW4+MKNue9bU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741423393; c=relaxed/simple;
	bh=K9n3iC/RQtxZ3AjuoZHdWDdOvsbc8edQCUgXCCzAMZk=;
	h=DKIM-Signature:Message-ID:Date:From:Subject:To:MIME-Version; b=p7Xia64v3rxhKz1Ukb/1n05fY179ZC8CxM5K+6ajatGJPPd3zniftp+HN3DVbXkt/Q5l8qaUs+YX5gmP8ADVq2xe+qp7f5upSpgChg2Y7SHBqAAFtwZF8w0Ly8fUoHC9Uk8r0CDdmPxaJKXLWT+w5SAd6HQUTK8gqF06vKYHtrw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 12E593858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=PwkWUZQZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RM0WpKmowd3EG9DG4KT4+WgxxvN/MyVENWZPn46M3LsvUaBt970Uh3gFMlmzIzhnA+OCZPqh7qnSIEV6GJz+xn/3CECJZzQlbHneLMwlCdlgX9qoFOLDd3br9lQSse0wXNCW4V4QFg/Px3Rp8zjYtP9Bp6oNuysN8ocTYE1pxZ8Dh5uqPARJ0AmPzKBpi14hPKHxYMb4LbKnRksu/qJKmxM3vk40z9K6qMYvRdwKEHkQu+ck0u5cmY0bQT5UGHLWX/By0P46/JgBUwr3JLNvi59Y9CfxKy94qm7By62HDI5tMRxFhHaWGWkWblIZR6MbttXdd/NQqvLT5GP1t6y86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2AusItcim/H670kmd4L4tr0TbTwsmrECwtBsfX1eOw=;
 b=TolYPHW4mUXQ2JnNdwLplxTT5fkjKQEJR3kDhFF7YMvQAiB9qvT0CKefUznN7Y8gqkgrkt9veMnBTaj37zmWdvv6sN1sMMHSbaeThNyPb4CfRS+CtgSGFTK6PAiabGwzt5Nwd/Me96VQGJSdcgwiAnJ7pI1NSbipcneu4x1WerLN4ba6YpmbgaPyCu/j5kOENjA0+9+4PX4er+iFm8NPwzhLb1UNMxsUcNmUcSpXvFNmjUSjiVZi5L5H6rQS4owhivHZAaDIJtGxjK59aYXvysfFs64qnikpxpkRXO9MrJN3NohDqUP/jIpIQ2a1gi1xqcfIWFiIepce7FbXH4Ghxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2AusItcim/H670kmd4L4tr0TbTwsmrECwtBsfX1eOw=;
 b=PwkWUZQZli45FmBmCSilu/IHG5cvhoiOQgo7+xWedSAlV6jEg8JE8YRH34J+G8w54Cw4zWnhTJJrrqudbnugU8kQQoeeHnsPOHu7O7opFbn+5mCGuUFPOGz6n6anuR8+Ep2MJ3ksdp5eSGP2JQ3tmo9ostWnzkzBAlDXDHTbtqTQjpvD96UAEqyL1/WDWouXSHlPZb8f6jLg6bMdax40ZGSTsrcmJMsZnYbsDRw3W48xA/p51a+3Q2NXYp1h0CxLYBMpNIRUAMdyWvR0MU1WGiFqgp3R5hB10GNdOmY2w+ST41wBQgFcKEmYeG03SUtpcdfJJ8V9LeTcDrtEM7Ti1A==
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com (2603:1096:400:3a3::6)
 by TY4PR01MB15332.jpnprd01.prod.outlook.com (2603:1096:405:26b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Sat, 8 Mar
 2025 08:43:09 +0000
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209]) by TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209%4]) with mapi id 15.20.8511.020; Sat, 8 Mar 2025
 08:43:09 +0000
Message-ID:
 <TYCPR01MB10926EE2486839280DCC3742CF8D42@TYCPR01MB10926.jpnprd01.prod.outlook.com>
Date: Sat, 8 Mar 2025 16:43:05 +0800
User-Agent: Mozilla Thunderbird
From: Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: [PATCH] Cygwin: signal: sigaction should ignore SIGKILL & SIGSTOP
 sliently
To: cygwin-patches@cygwin.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To TYCPR01MB10926.jpnprd01.prod.outlook.com
 (2603:1096:400:3a3::6)
X-Microsoft-Original-Message-ID:
 <410acf24-b318-42bd-b1b2-17d2472da209@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10926:EE_|TY4PR01MB15332:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e735202-6fd8-4c5c-4812-08dd5e1d4098
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|7092599003|6090799003|461199028|15080799006|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDJ4bTA0UzlIdjIyMEpuWFdLdzBxenRlNUE4OWRWSFc4VnRNRzZ4cGFTV29O?=
 =?utf-8?B?aFB5OVNoRXFlNDZHZk5xaWw0NDNManRaMlZTUHdRNUJIYWFLekhSQkRaOGhi?=
 =?utf-8?B?R3UyT2h3UnNwc2d1dHh6Nmg0SUVLZFRjNEIvTStFTjZOMzFpdkdqNlJWcWtp?=
 =?utf-8?B?SFhWdkNXSTl6Y3lVbEJKYVBJcCt0bVc0WjBDSFk0SE9QSmcxZlNDd0p4NTlG?=
 =?utf-8?B?cEVUZDdSZGJyZUtnanZWN2FBckp2b3dVWmpjTTlDZVBvNWpJVGR2Ry9rZzBx?=
 =?utf-8?B?ZGQ1OXI0VDMxVEMyaGxKd1VDek5xRWE3N3EwTUIxQkRCR2tZaEtOMkw1SzZl?=
 =?utf-8?B?Z2NIRHBiQ1Z1bEpERmYvbTdpczU3cXN0VmF4VFRWVTZKeWtmOEQvSEJDd1Bx?=
 =?utf-8?B?aXY4SXZDdTRmTjFXQ1dBdXRpNXduSC9KSVA3d3MzdlpEbFBHNzNVZ2FHalkw?=
 =?utf-8?B?Mm8wWFRPejVHRGhIeEE2SFNvV3BVZmVSZWhYY0JDQzZOZUtWYlhFTXBjbmQx?=
 =?utf-8?B?NTNGOW1TdFJ1UTdHUWtuTlpQTkVqeUZ5UldCaklrY0xSdS9Wd0psL24xb2R0?=
 =?utf-8?B?UzVleHdIR2U2Q0pUZzhmc0FPUW5EV0p0YkY4UTJOc3RYM2diaEd4MTV6a2lr?=
 =?utf-8?B?bzJBQ0pjMkJ4NFlHYVBydkt2SVlBNU1nK2NhZUEvMEtIL1o3bE5xcFdGQWY1?=
 =?utf-8?B?dURHVkUxcE5sMzUyOHR6U2VFby9VNXlOc2xuUThqYU1Oc203Wjlod2hMYm1I?=
 =?utf-8?B?V0l2MHExVTgzQkJoZFBuSVF2WDZucDU0eEZ5aTJEZ0dUY01MVHJNUkhZWU4x?=
 =?utf-8?B?VW40SlI1TFp0c1RVMGxlbjBra0VoNWFRTU5GcmRST3B0bHQra2ZUWEhVa1pl?=
 =?utf-8?B?L3pXY3FZM3gwOUUrQTRCbmQrUmZ3WjhsTVg0WjFMS3Y1L1VNQ283cy9NV3VR?=
 =?utf-8?B?VGZtK29wUTJlYjdrZ0c0aExCb0JBbUhzWldNcHI5NUpMQjh4cDN3bFJ2L0hR?=
 =?utf-8?B?dmFIdEd2MzZzWEtjZ2VLWDdSaEdtN3VLMmRLTHU0T3lBOERKYUp1ZlZVbHFZ?=
 =?utf-8?B?WTdmUEg1UWRwZE44KzRDNEhkeVBpcjc4WlVveVZqcjF6K2hZYmZaY1dBQmxH?=
 =?utf-8?B?M2NpUVZSM0xkREJVVktkQUNKS01pRUsrZ2U5VjV0NE85TFhWOW9qbTFMRDc5?=
 =?utf-8?B?U2wvbzFqSVU1RnFQajdBZ29kZ1ZZV1dJa0QrZFByNE8zdFpxbGNhM2gvRlVi?=
 =?utf-8?B?VnVhMzJycy9aUlFJYUpzOXY0blNBVC9hQ3VZT3NtYVFTeDVMYjhPU1hIMlZI?=
 =?utf-8?B?aGFnV2JQUUZBa2k3Um5IMGZhRDZJc0M3dkl6Wm1IUG8wWVcrQU84cXpwaGxo?=
 =?utf-8?B?QUxPbVhVbW02b3VFNkt1eGp4eHVzdDJPYW52Wk1zRWM1Tk51THBBU2F2MDhF?=
 =?utf-8?B?V2NOdmQ5eDg0VXlORlpKakZRM3JwOUh3eUZIRW1kZjlWSVMxWFFGNkpZeFlv?=
 =?utf-8?Q?ftupXQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzQ4M1VVaU15RDBCTjhQbExzR1Y4QjBDMms2dVJNdU41a0hqT0oxYXRBeXBN?=
 =?utf-8?B?OWJpTWtvMW5MaVRuS0NjL01CeWRESHRBa3d4MU1oVkdxNDFtVXJBTGc2NXJi?=
 =?utf-8?B?Mmw1eGtMam1lZHRFeVhzZnNTT2tMY3NUeUxyUU9YYzdLR3lPL1dvZUJuWHRQ?=
 =?utf-8?B?NGgzY2VIeE9za2kwTDFlS21DYkxYYXU4cDVlVnF2WDhKVlVhSkZmODU1Vjkw?=
 =?utf-8?B?MHFiVCt5Z2x5Q00rcitORm9ablc0MnpwTFEvM3J6L0czdVZickhISnFmL0ZT?=
 =?utf-8?B?NHRYaGlTV0w2cXVLdk5RQzJLckdpOHViZjFHR1VHRExhM013N1NMelZET1Fs?=
 =?utf-8?B?T2pZQUdQa2RFSUg5cXY4RUIrSXlNcXQ5ZHROUVdXMDltMFlJU1FoRTkyeWM3?=
 =?utf-8?B?bmNFdGw5cFFIM2RPbHlid0xLT0xvOFIxdDVDcnN3YVFrMW9CY3h2VlhmU3oy?=
 =?utf-8?B?RnJVYm1la3g1bWVPNCs5UVdXV08wOE5lZVBxcTdmUk43TjR4Zy9RR2J4VUxG?=
 =?utf-8?B?bm1rR1BxSWVxMlZDc1lKU0dYamtiNE05QXFRbHNSajlDZHhQWTFwNm1WelUr?=
 =?utf-8?B?Ym5oSGhhNkFSTkd3UzVSQlQvOVhaY01pRElxVnlQdlRLMnQ5YVF3akFBc05H?=
 =?utf-8?B?ZWVhYm1UQ29xMExyUkdSaHR2YjRFaGlhZUgwNWdKMTlPMkx6RmRrR28zaTUy?=
 =?utf-8?B?Y3E5cVV5cXBOK2hUMkpoY0Z4MzZDTXNOZTRBSWxXZG5TUC8vU2I5UWRSR0Ey?=
 =?utf-8?B?aTg3azNPRUp4MWt0VHdocmg0UEwxTk9xTUlyUFMvZGQzVnM5bTU1NldTc1Bs?=
 =?utf-8?B?dnpFc3lLYjAxT2ZKUTFVTkJIV1JNUXZyMGxHNTVCcTFLRFFSTFF6eFJTdUEx?=
 =?utf-8?B?eUt2Y1Y2aEF5Z04xVk5BSDRKU0pFbWxaT2pzS1ZVSW5ldnhnc2h6anJFcHNx?=
 =?utf-8?B?S0NZQkZpaENBNjdiczMxZEc4QWNydGNzZHdBVmtYMm5ZazJ2Z2J2Z0I2aW43?=
 =?utf-8?B?TXdPdy93bDBWdnlOSE9sKzFiSjNCUittS3Z6MjZ6d1ppeE1KSmx2WWxicENy?=
 =?utf-8?B?Ty9jSzlBUEh4d1h4QTRSRFBlSUhBUXFpQXVUMitBa1IzOCtzWjNYM28ybXkx?=
 =?utf-8?B?d3VxWWZKOGZJSTBVOXF0ZkpPTGpBVFdlTlBNS1d3bFYzMmZuSTZaWWl3SVdH?=
 =?utf-8?B?RHFTOTFwN2NSN3JFb09Yc1dzamJldWYxOStvVHZxZWFXbFdnRVNCVzdwbStn?=
 =?utf-8?B?NG5wd2dDNmNSdnNuaHFVLzNKUXdGb1VuTEgxQjJYM1luMTUxMHRkYTYwYWhR?=
 =?utf-8?B?UDQ2UEczK0QrTGNzWE5hbGhLVitJVXlzbGs2TUg4dDhwbGRIVjhzN2x2Y3p2?=
 =?utf-8?B?K3h1UnpQWksyRzhORVVEV0IxVzNKWlJWVkFjNE1TRHhFN3cxRWNvZkgrYTZP?=
 =?utf-8?B?UGdDTzMyVVo2MTAwL3VWcnJid1Z0aGN1SmYvK2JUUWtvbVJMUXAwSHJZdGJv?=
 =?utf-8?B?MmRtSWJXUUxzOVp4c1JDeTd6bVVCRU1uZ2gvNDBnMjRJUDAvM0p3eFNlazRl?=
 =?utf-8?B?NHdaZlJ2YU0xMEVBU3V0WWdCQkxLZVZJV29LZERTOUcycHpjZ3VWQjZ5bEt3?=
 =?utf-8?B?VTNpakdGY2w2Uld5RjJuSGt2dldKcDlIYzVGZnI5NXBvOHhvdmFNaEJiZVNH?=
 =?utf-8?Q?9gDaAh2gUvhvreSKj/ms?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e735202-6fd8-4c5c-4812-08dd5e1d4098
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10926.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 08:43:08.9484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15332
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>


The current behavior returns EINVAL on these 2 signals, which is
different from the requirement of POSIX. In addition, it makes
posix_spawn fail to set POSIX_SPAWN_SETSIGDEF. In
newlib/libc/posix/posix_spawn.c:200, it tries to set for all signals
including SIGKILL & SIGSTOP, and sigaction should not fail.
---
  winsup/cygwin/signal.cc | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index f8ba67e75..a964c3b29 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -440,7 +440,7 @@ sigaction_worker (int sig, const struct sigaction 
*newact,
                    oa.sa_handler);
            if (sig == SIGKILL || sig == SIGSTOP)
          {
-          set_errno (EINVAL);
+          res = 0;
            __leave;
          }
            struct sigaction na = *newact;
-- 
2.48.0

