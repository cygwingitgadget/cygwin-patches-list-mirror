Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2109.outbound.protection.outlook.com [40.107.94.109])
 by sourceware.org (Postfix) with ESMTPS id 9587C3858D39
 for <cygwin-patches@cygwin.com>; Sun, 26 Dec 2021 16:24:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9587C3858D39
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe1HaGwZiS6FLn0hjssTmH4s0KZ0v7PCTr52iezzKZzdjhKeefciJVQutP58SgA/NSbpOyUIrrAuaFpIq+DnwjjxKGBgx8nRYghLJ5d1MVRnu9mGmkftGwnVJ1g7NHSZ1Moq5Dvo8cl819BKDb8yvSo3k+QIChcUQsNksbeTfLyNxsgkMi6vW1JGDgSkmMJE/Xdj0yHOZSQ/pw3+3rIp1u4bU04yj7Xfui4uhdJGcritqQuoFeevTvN1H2pWsZyNSGAgiOuF/8JafJmuJRRaPaJkZn3zPD5wp/9LDmxhaH3W9xdXvdMr480ehB8jWK7lFGTYOhTeYKuo+iZKUFJBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8x4+tWSGlo+Wfupw6Lfudf84zAIhxIv4dzuyYRT5J8=;
 b=EnsUojXyF3dYnVE7zA+n1YYN3rP2ZzD1bjdp4ivyGWPftieDMzfX0ylpN1zp35aDxvuq9PFDRikiu8zskUw1/BIDWcizJSzigoGlgSh9QWsaE8rXmjyHuMBQBYCwwRR2rS82MljYV1CQNonHGv30RINjOI7upKkq6UWfnWaT9gfDjULCQWM+r3LLbkRNfzWh9v6rdZJyJV95F8X6kPbvgZ3LBKfbHZsG+QMjZcSGtA/1bE84YAWybp4B2NbZgxjCoKZ45qUBxh/1LaH5Jw3JXHrZr4KC9ee2seJCXXynDUzq9Sg8JrRKrvmjiMq123ikUb9k4LjDuXjXvucPA+VQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8x4+tWSGlo+Wfupw6Lfudf84zAIhxIv4dzuyYRT5J8=;
 b=MUbTmD929BDk15VGKrLJl9Y7FlKWemYURffjgRo4DAIQSMyin3mlVFjd0oKY7jzPdQD48zsYySY9mhh+Hw++blEvMwGRNMpjTIbXg/tn5HhKhXideav8d7nZHEpTbIpFjRu3RMM5C8fTkY20lrxQkIbqa+7LVpcrlJGfY2FL02k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5619.namprd04.prod.outlook.com (2603:10b6:408:a2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Sun, 26 Dec
 2021 16:24:42 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.022; Sun, 26 Dec 2021
 16:24:42 +0000
Message-ID: <317dc73a-fb9d-3937-7354-c79492c1c64c@cornell.edu>
Date: Sun, 26 Dec 2021 11:24:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
 <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
 <alpine.BSO.2.21.2112251111580.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112251457480.11760@resin.csoft.net>
 <8172019c-e048-4fe2-79c9-0b3262057d3e@cornell.edu>
 <alpine.BSO.2.21.2112252054310.11760@resin.csoft.net>
 <c7664703-0ec2-388f-64e3-8c46d4590b3e@cornell.edu>
 <d2af0b22-666a-b820-acb0-afc835836372@cornell.edu>
In-Reply-To: <d2af0b22-666a-b820-acb0-afc835836372@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:208:e8::48) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c5a48bd-e610-4330-0d93-08d9c88c38f5
X-MS-TrafficTypeDiagnostic: BN8PR04MB5619:EE_
X-Microsoft-Antispam-PRVS: <BN8PR04MB561912A23FBD61724873C9E3D8419@BN8PR04MB5619.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nlMou9bjJCkk2gaUcN0X7tje7kQ+xFnSkvqz27tXtuzMw5B6uAuF2ILgk2NEKSgF2MiYDH8JbugDwiCqhZwe8Zc2sM4w17EnJPjbq01BiaZviTjqY7As1byQ4dKXxTBdylfqzWF5DO5ANenR+WdjhkfmcCRCpWGBwcXCB+/HYXUygIv7xIX/ZPvBitnCht8xiDeCM+sRgIl6PhieKexRHEPSpdbKvuluPPmq7kJnum7t5fsvW4TKKuqlER4V+YgQ9BXTm9EkgBMsR/tmG6LoEPFgFfhe9yFA+QI6ulQkD9Ty3EuPCTXyfaOY1TXHit7e812eIDWEQOqyxB1QEpAMUCbDfCiLGd9urwIsztFhGkL0wmcsWk28pBg4ioGaoflpZlJNOjs87mnOttnZeQogxyGTU3deO3a/wShiuIHbBoubU33ylKga4jRY09tAW0lcvfCrCWfGP2Sv67v5e48DMzkm2Hy6knwLsYz2qPSpTVKW5Eth91v3swB5152PqP2ReZAH30wI1nCf8277h67s4DtDVwoJ/OoB5gUaP5O4vhOX3KzMmZqQeJiZIvTyOE9Y9Iv3yti0QenZiTAE9ZtGpnJ6SHMLGJZgVAUlyB6KhjdgwxQ3aKhgrsDqOd0CKDwIIUGdq1GxNI8vb0jwnb8RaDramvet6Mh/a2SlkkCjt3L1I5GPVjjqTgORYwLVuNoYF56LTW6FXQrUstuyTQK0LZ4etO0xONnzVdS34dRJFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(38100700002)(31686004)(83380400001)(86362001)(6486002)(75432002)(786003)(5660300002)(6506007)(316002)(66946007)(2616005)(36756003)(53546011)(2906002)(8936002)(508600001)(8676002)(4326008)(66476007)(31696002)(66556008)(6916009)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dllROUo2dVViZW92am1YREFGNVBZRlc2ZktpL1FkWVM5REVPWUs1VWhKZG9U?=
 =?utf-8?B?MlVUVlVmMlRBRG1Qb0NVejdKazRYRThpc2NnRjNFamh5WGJTWjg3NGNORTJ6?=
 =?utf-8?B?U2I4Q2FpZjlLc0pFYVZxeFQ0VFd6YzVjMG1MenlBRTYvdnpPeXI2WFU1d3dU?=
 =?utf-8?B?ZUp6VjBRYmlSblY5VVdJb0R6a0FVdWM5VjNxVlJwL21mUUVNSHFUb0ZHbVJB?=
 =?utf-8?B?WnlvUy91eW85cjZJZ215RUtlY3lYZ2tDeFMzOGlJZXNvb3BpbnJ1REF1WUxw?=
 =?utf-8?B?R3VzWEY5QndZdDhZWmh3T2lhSkZWeVdtc09HYnp5c1BQOStBSXRTUjRkaUIr?=
 =?utf-8?B?QWJCUXN6ZzR6K0M4Z3ZScWgvYUhPWUpVb3lia3B6N0RvQmgwNzJJWEcxUk15?=
 =?utf-8?B?NFhkNlhuSUxBK015ZjAvMWVmcTFQaVNicmw1clpkTHh5V1JoZVg5MkFtK0ZO?=
 =?utf-8?B?dTdHNkFXcGZUV0w4T1YzYnpoZ1pLTWgwa0hmM2lGMHl3UjF0eWIyNFlPSFJk?=
 =?utf-8?B?cGk2YURCNVRxZkRvRFN2WnpQQzJ6N2pqRW1BSlpVRU5yTytVNXhGbmlxNTR0?=
 =?utf-8?B?R3pLbHRVMzlVQXdpUEdEeG9xN3dFZk1FNnNYbHhqUHBkMEhmVENzNkVkbGpK?=
 =?utf-8?B?REpDUHF2TXFPck1LWFNmUEc1SVd2NTZYWHVBUDAvQW1ZdUpwS2N4VzAwNFBN?=
 =?utf-8?B?S1RmdmQwTFA1aGsySW82d3N6ajVMQ2pkRzhwbkNKWFFoanRxTmhxb3FkV2M2?=
 =?utf-8?B?VFF6dnMxK2tmaDBuZ1lDUzVoajViMHo2YSt0YlJnZ29DZmg5bTBadjA5RG9n?=
 =?utf-8?B?eks2azFLWExzRjZKeTBoRG1CeElRZXhCNXFTUWxlZkUwU2tjL3dFQmp5U3F3?=
 =?utf-8?B?dnpFSDd5STBqQnd0T2FJdlJsQ08yMXp2c0w3bWNmNE4wRmdhalVCUXVPbFBX?=
 =?utf-8?B?QTdjL3F4cmVDamQyS1UrZ3Z4YTZWRWZNSHJRSnhGdWR2L0g2VmZyTUZGSnVJ?=
 =?utf-8?B?OXRQM1I4bllZd1J6M2RHdlM0NGFSK28wWS9WRlREdzFreFI4VW5YcGhnK0NO?=
 =?utf-8?B?T3hqSnlZcmZlWkptRVh4MGkrdEJHNU1XNHJWQ2wxeWdsMjdIZjNzV0xQVExE?=
 =?utf-8?B?clM2MXk4VEZhQUZyMkhuNHQza2FBOTB2UlBTUnFFUVVxS2Y1djMxMDFFeGRN?=
 =?utf-8?B?dG9ER3BVSXZYMlJMODg4dHIvYUtLaGlZNHg2RHp3NFQ5cHBncW1XQWtpV3pl?=
 =?utf-8?B?R0h3Qm5EQ3M0a01SUTVNSEkrTUU4OXEvR1VkZVFrRjNrOWNaS1ZneVM4bUxa?=
 =?utf-8?B?aWdzK2V2VHl5UEhuaUZBRXFuT0pXVDVWbnI4Wk5tRVByV3loc0piM0VLVzVj?=
 =?utf-8?B?WG5na3FYdnhVdVF3VTk4K2c0WjlFa3JBaTdtbUJJK2ZNYUhxNThoYyt4VlY5?=
 =?utf-8?B?Q3RoRUJTWTIreHZQbHU0WDZ4bExFTzZFL1Z2bklkQWgvS1JhdmdzbFovREtx?=
 =?utf-8?B?ak9zYlREMnd4dFhMU3h6aWxoLzhjMG13RHdoY3U1M25nc0N0c1BlR0lJQ2p3?=
 =?utf-8?B?NU5RTjdQV05vWXlvSFB6S25hd2VmdVlMOXFMR28wbFBVOTk4ZGQxRy8rb2NM?=
 =?utf-8?B?dGhTRk9KSGl0R0xtNW5HaHJGWFZlOWdmL3FoMXVhL0tOL2t4NDBlY1hMMjM3?=
 =?utf-8?B?TEdLK1JDNDg0RGI5UzU2cFdMQm8ybFNRYURQYk1DZlVNYTBpTzNQcGlMbUlZ?=
 =?utf-8?B?N2FHbUFVUHNkS3FEOHZrbGRKK2xmcnZqMzR2cERYRHJYU2FCRlJjUnArYlNn?=
 =?utf-8?B?c1dmMndYVS9kazZobkhLM3ZFaHNsNzlDZW82eURVZEQzRk9rZGlWZ01Ec2RE?=
 =?utf-8?B?V3A2SjcwR1hsa1lVd2g0Q2tCYmtWejVNWDk1MEZqQXVsazdlQVF6Q0dCSCtt?=
 =?utf-8?B?cm80OTN6Q3BOZjZkczJQeWhMaWptcktIWmVrRTNjbUFnYkNUcld1UG90T3F4?=
 =?utf-8?B?V3pTWkdRUWs3dTVZRktQRDBhcnl5VUFIQTJVeXNWZWo1VFozVEUwNHdkOGJ0?=
 =?utf-8?B?RnQ0NkJ3UFFYUlRaU2tGdU83VGJ3bmRLRHBLTVNUYnpVUnkyOFhLbGU5MWJl?=
 =?utf-8?B?VElTdVlCbldjcElOUS9kbS9mSHVxTXdZLzBRYXhMRnI0QUZ3Y2RtY1dPdXpm?=
 =?utf-8?B?QlR0L0xZWmg1Rk80V3YxQ05KMU5hRHZoVVFNaitiYmw5bThKY2Q3NHRyZ0NO?=
 =?utf-8?Q?SbMM42F1tl+vRccddl52HsbQRBpPyIUE0i8GaEivP0=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5a48bd-e610-4330-0d93-08d9c88c38f5
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2021 16:24:42.7290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Tmx0tbWdfTSmoKfTowUajwXpKfyHWIh+nsflScIMJcCkMUxpbDffnUIsiJ88bWnZBy0kiKqo6byJ1BY4sfxoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5619
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 26 Dec 2021 16:24:47 -0000

On 12/26/2021 11:04 AM, Ken Brown wrote:
> On 12/26/2021 10:09 AM, Ken Brown wrote:
>> 1. For some processes, NtQueryInformationProcess(ProcessHandleInformation) can 
>> return STATUS_SUCCESS with invalid handle information.  See the comment 
>> starting at line 5754, where it is shown how to detect this.
> 
> If I'm right, the following patch should fix the problem:
> 
> diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
> index ba6b70f55..4cef3e4ca 100644
> --- a/winsup/cygwin/fhandler_pipe.cc
> +++ b/winsup/cygwin/fhandler_pipe.cc
> @@ -1228,6 +1228,7 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
>              HeapAlloc (GetProcessHeap (), 0, nbytes);
>            if (!phi)
>              goto close_proc;
> +         phi->NumberOfHandles = 0;
>            status = NtQueryInformationProcess (proc, ProcessHandleInformation,
>                                                phi, nbytes, &len);
>            if (NT_SUCCESS (status))

Actually, this first hunk should suffice.

> @@ -1238,6 +1239,11 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
>         while (n_handle < (1L<<20) && status == STATUS_INFO_LENGTH_MISMATCH);
>         if (!NT_SUCCESS (status))
>          goto close_proc;
> +      if (phi->NumberOfHandles == 0)
> +       {
> +         HeapFree (GetProcessHeap (), 0, phi);
> +         goto close_proc;
> +       }
> 
>         for (ULONG j = 0; j < phi->NumberOfHandles; j++)
>          {
> 
> Jeremy, could you try this?
> 
> Ken
