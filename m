Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2090.outbound.protection.outlook.com [40.107.236.90])
 by sourceware.org (Postfix) with ESMTPS id 25E5D3858D39
 for <cygwin-patches@cygwin.com>; Sun, 26 Dec 2021 23:12:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 25E5D3858D39
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R18R63wIRmeflb5/X2w1MsQvxgCxNNj4TrFoqwIgmkJ8/tN9qm2XBa0LewqPPwI/7bu5OZDVri0QuREfzaeARZtZI5ESpr2v+TmBdl7wciaA4VOI1O3XxyubnV079Hk7tQqej+l6VtD2tFVPWv0AjUQ3z7T4Z1bAiOauJQgbHxQDIiVbX2UFqpXqIyD5vbqJC7gvKHeUhDmHSenX6ihZH/ktcGg3gbwIHEfi0zC0PorMIaMU1Q1t8jePLYHe3CZ0xoh0GYlq7x/vM2r/tW3UXiHbMeMP/8Wu9LpRl/yEBuKYAcYMNnSRpUE79Lc4DdXqwVsCht/Gk8ETJbhe7BKT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBhwWEGxvveezlxndcPRefFPX7cobmHwWtbHBSddbBk=;
 b=JsE2/rhpUOCX5f7WLYGrek8WZuq8OoB/eb5E7QoojuKMTCpx37KjESs33vlO7g1sNs7u7UG266/1Xqj0Dlzk1V+N/rgA+u1HIG7LQjudqZGFrX6rBfiZ1CV2IxNhxSp5c2vnxjHVBTDU/pZaOSDtJXDXfalNwgcQIoi5wfw8ZOzYSKLGZBo5c4R4OaDzUi4C2y48CfhAdwtnT/fmIgl9XXfx4403PkYRFedCwW8a0SrPSfUHwtNNu0nZ7AqXkCsNGHSYOzERqzQgj1hacWRX/1+nGb11RUZS/EAlVGr8O/5cmuMTzb4GvXIQ8NfpDaZHCy9x08nSeEMQR75x7dxuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBhwWEGxvveezlxndcPRefFPX7cobmHwWtbHBSddbBk=;
 b=EchWJtFv5MtVUEHO9N/eZxWQsi9Qjcy2AL/R1Y+353/jRDuo31RvXqsPegUut1yfGBjCPl42qO6lI0qnSDRiwKQJB96I0rVCK8j/PzIMezt94kyXHQke3tWewdt4uxwivT2kGEbJrdMZi3MNUQ9Sp2hCPv2kvnM/ejB3MTuzuPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5953.namprd04.prod.outlook.com (2603:10b6:408:50::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Sun, 26 Dec
 2021 23:12:33 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.022; Sun, 26 Dec 2021
 23:12:33 +0000
Message-ID: <7781155f-d4a1-2e9d-a5c7-2ecc2250a5cf@cornell.edu>
Date: Sun, 26 Dec 2021 18:12:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
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
 <317dc73a-fb9d-3937-7354-c79492c1c64c@cornell.edu>
 <alpine.BSO.2.21.2112261331090.11760@resin.csoft.net>
 <b278775d-03d9-6683-ec43-62729bb0054c@cornell.edu>
 <alpine.BSO.2.21.2112261432360.11760@resin.csoft.net>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <alpine.BSO.2.21.2112261432360.11760@resin.csoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:208:23b::14) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82da2920-f820-4b03-4786-08d9c8c532a5
X-MS-TrafficTypeDiagnostic: BN8PR04MB5953:EE_
X-Microsoft-Antispam-PRVS: <BN8PR04MB59533A3E7380BB1388DBE771D8419@BN8PR04MB5953.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sO0WTXLyz6KUsANQVbXYiJFzIetTVdMB79+xDOmL5rr7+jJ6Ax2gsPcCv+fD6itu2NxipwdqS8b2MKWQcd0GMxiDKwCu8XtHPkkpEQ19W2R0N1y/tUN4PlF3LYZ8P/yCyJahngeVO1M0yYgvEP3BzR+1Xnnxz5n+6hA/tV5wbTYJkCT0mW8Iggp1/hGekzViC+bmL8C36As8ptGu7wtN3s24OjTVzM9TLHMsGr7mbLtZ4O1+BU+IR/rxJKjtu0Qt4ypIA8oQl2O1khnr0jCW5elGhnyFPH1TeerIUXWc7CBgvR8IIz1lx5J2Mx+cfo/fHD9ZrZ426GRO0swhab/VHoq2sIAPnDnwEZEVPIkaHrs9Kv4RzO65Kor26+Rj0NUbfnn4LVBIwF9b6L8CYkFAjJ4FZ97PUXagUzTV/WE0gKWEfNxgvSdi8g+zHCVE1ZTGKaVKnr+hhjohmmJokOmxf3UDwV4Pb5KVcN0hgPFHpUeXBoL2R932MysOSlozXtUe9/zDhxrCEPuQ/9ZYlY2NgpTxmRUguHWVbO5kLYrIahohghIIzaVYKQubvscitiEGwg2VgITsmgtCHaGyRXSvL0t/0nHb0MVF1JtLnXACNZuyg4AaRzSDUbxSQQAJV9yQVV8aT45hzxoDg9Gx9vbYHMgNKxpazZfR5lmNYbfcB5Zg82b+0xZoTyb5nEjtDSkTOLNqHbu/j33o5XEtAyLLQekuI5dpwWVShMuRaXvFxvGuxtcPC9OYvyaKni7jkdvj8DAb/czN5BybYXehyOgrWnhX4YaarZCjYh5WYCJx54zbtsdOFONHLV1tkLfPxlXbgtajxeEU+N1m31UwtnsHMkY1d9UnilxgteVk0EyCVvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(8676002)(8936002)(31696002)(38100700002)(6486002)(66556008)(66946007)(2616005)(6916009)(6666004)(6512007)(186003)(316002)(66476007)(2906002)(31686004)(4326008)(75432002)(53546011)(6506007)(786003)(966005)(5660300002)(36756003)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJYTWFrN3VKUGdjbmVDY3VwckUvK0NoRmt1aTAyWi8zamZMWnRGR0VnQ0Jt?=
 =?utf-8?B?bTE3MCt3N0pzTERwNTlLZnAwa0FDaXFOUTFWRkdjM0JmdWdoZ1M2b2VsZHF6?=
 =?utf-8?B?UHdOYzkvb292QndQLzMwM1dxRlVCOVlyVGlxeWkxUFI4eFRjMjhGdDJKQWV6?=
 =?utf-8?B?QWRVM2w3NFRPUHBHM2djSTdVRXhEbWY0ZmtiMmZVNXUxM0NWZFdwWEpLTmh4?=
 =?utf-8?B?aVJ0YXBXL290S0cvR1lJRGt4RlN6ZjN4WEY2d2RYbzZnNy9kTEtrZTk2QUlM?=
 =?utf-8?B?d1lSOTNXOW15T1FRbjk3eDYya0JYYU5zQnBzTnJvVU53NlAyQVovN0k1THlG?=
 =?utf-8?B?VVROcmlCenc4M3ZwUzNBU0poa2pmKzlyYThVcHpVWDlYOTlJTVF1UHRoLzdK?=
 =?utf-8?B?Y25WSFNSSHpjekhoenNJQ1g1cmc0SVk0QW1XUEE2VGhON3RFZXZKZ1ltRHRB?=
 =?utf-8?B?VlZKTUxUd3F6YVVCekFmTzlTVTdCbDRoL2tvRjVRR25abGtKWmlOeE5JNnA2?=
 =?utf-8?B?bG5aS2JmMmU1V2luY296bEJRVllxUWd6b3FXNkFXYUdBRW9PbXRoSENraEtV?=
 =?utf-8?B?NUsrbnNBNnZlc3VhWUx4VldkeDJpNHMxSnc4Wm1jR3dFY1E5S09xZm1HTFFt?=
 =?utf-8?B?UkF1WWNQakhieEt2dVVJZitwYjNRMXI5blhYNDlPREZZaHZ1V0FxdmczVUdw?=
 =?utf-8?B?aERVT1hBWUlpakQ4L242dkdGNWN2ZHdrNXptd2oreVl4SjRRWUJYTjcvL1R1?=
 =?utf-8?B?ejJqS2JxMzEybUJ1ak56MERYbFY5WEpsSzd5N04vaVBlUlZsNjM4OWhpTExU?=
 =?utf-8?B?ZUFSY0RQUTVpbHZwNUhNNWNwY2svcCs0TldoYkJIelcxV295Q1p5cC9NM0gy?=
 =?utf-8?B?Smx4ZzhkUThMRjcwT0d1VEtpWEU2UU1MWk9sQ1hRZHhiRDZqdTdSZlBHaXlQ?=
 =?utf-8?B?cytMM3JTQzl2a3BqZkVqYVpxemdzclgxNzVQU01McnBlQU85SjFwRFk3ekZh?=
 =?utf-8?B?eWh2bmRHL0lrbXFHVENHcmVpTkQyOUFrOUtLSXRZT2FDWk9xOVJ1c2E0QlFa?=
 =?utf-8?B?SWVMQTR6cTBqQWxCbFJ6OExPME1ibnFjdnhoT2FRTnN3TGRLd09aM1B1cnVJ?=
 =?utf-8?B?dnprWnNtMUtPNmNBYkg5Q2Vnb3orVzlyWis0cFVoWkMra2xDUUo4K2tEN1Jx?=
 =?utf-8?B?OU90a0ZnWkd1SlVKYURYQWwzN2o2L1hiOGVtem9YM2NZSWlzVzV1QVd6YkpN?=
 =?utf-8?B?RUt2TGVoMnVCZzJlelIzc1JJZERJc1VKUUJlaXBuTGtON2lCTmswSDgyQ3NM?=
 =?utf-8?B?UFRnQUh0QnZEUE43RDM5eE5kdWpXRUFBWjFiSGJiU243OTFHWVFmVUNHNWxw?=
 =?utf-8?B?QnJxc2N6ZHVOOWlSaldNTmhqcThvK25POTN3VmxHZ1QzWGZxK3RQSlhUTlAr?=
 =?utf-8?B?M1F0NEh4LzdXL1F5WDZFZHZXWk54WDVuajFEUzRzc3hUZFhYMEMyZjZ2OFdH?=
 =?utf-8?B?SGwwbVREZmsyRnVtNC82NUhNTkVxVTZuLzhhWnNtSUtaRUxrb2pQR01maU1B?=
 =?utf-8?B?QjhKZ20zWksxVUdNOWdxeFRITmRReUphVDh2Vk1KRjVZaU9rbXhCdTBPdkpX?=
 =?utf-8?B?ekNJWHY2OUk0ZjY1c2VYRml6NVEySDRwRFR4MG5LYWd6cSt4QXZCVmpwbFls?=
 =?utf-8?B?TWo0U0VFbE56M1JjNE1mT1BZeEpmSDkybGFrb0E0a1YxWnNHRUIwUTJGMHpz?=
 =?utf-8?B?RDQzdlRVbHptSkFuMkhJM0FaV2JzZ1dMMmFVSVdhNDFWbnZHeit4dGJ0ZUQw?=
 =?utf-8?B?NEVLa2JZNEpXYjFHL2tFZWRJeWdPNnBOODNaN1FsUjdYWkk2QWxQUlBpaUxI?=
 =?utf-8?B?WnYwOU5YdzRySGt5d2x4SEwvZW9iR3NYKzdtNnl0ZG4yREp5Ym9uUEl3cFhC?=
 =?utf-8?B?TFk1c0NTQzJNTFM2dnpjeldISlJSUzFWZmcwd0lpd2JvbVZ5VmRqb2JhdDFk?=
 =?utf-8?B?VWxUemhIWWowbXZBMWFVWm13dXArQ1lUZnAxbWpITVlSc2pTdDV0QUNhMU5y?=
 =?utf-8?B?U1MrVlh1Y0VzVm9jcWVvUC80VXVoWlQxTXNMbUN0NlFhNzZ3VkwwTDRzeURM?=
 =?utf-8?B?YXgvb0Y2YTdqS3ZuY0lIaHFOVFRuZUJwNDZUUmZkNG50UmRBN1JNR2Rxc25h?=
 =?utf-8?B?TFZ4UW9OdSs5ZzdYTCtKZGhzL0tkUHkyNDlFcE43N1FCdm5JVks2V3drVS95?=
 =?utf-8?Q?IpDk8UHJO6to4tf6xnIDgyDYSVM16uPxlREV4yUjDc=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 82da2920-f820-4b03-4786-08d9c8c532a5
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2021 23:12:33.4690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKpKE6WnXN+y2prAa7RJrZjzHFNIVzBzCjRqvc2CEtJ3PCVIdZTYdH8vI916B7myttimltnKlGEBRnGGCyftIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5953
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sun, 26 Dec 2021 23:12:37 -0000

On 12/26/2021 5:43 PM, Jeremy Drake wrote:
> On Sun, 26 Dec 2021, Ken Brown wrote:
> 
>> +	  /* NtQueryInformationProcess can return STATUS_SUCCESS with
>> +	     invalid handle data for certain processes.  See
>> +	     https://github.com/processhacker/processhacker/blob/master/phlib/native.c#L5754.
> 
> I would recommend using the "permalink" to the line, since future
> commits could change both the line number and even the comment you are
> referring to.
> 
> https://github.com/processhacker/processhacker/blob/05f5e9fa477dcaa1709d9518170d18e1b3b8330d/phlib/native.c#L5754

Good idea, thanks.

>> +	     We need to ensure that NumberOfHandles is zero in this
>> +	     case to avoid a crash in the loop below. */
>> +	  phi->NumberOfHandles = 0;
>>   	  status = NtQueryInformationProcess (proc, ProcessHandleInformation,
>>   					      phi, nbytes, &len);
>>   	  if (NT_SUCCESS (status))
> 
> Would it make sense to leave an assert (phi->NumberOfHandles <= n_handle)
> before the for loop too just in case something odd happens in the
> future?  That made it a lot easier to know what was going on.

Yes, I think so.

> My loops are still going after an hour.  I know that ARM64 would have hit
> the assert before now.
> 
> Would this also be pushed to the 3.3 branch?  Or are there plans to make a
> 3.3.4 at some point?  I saw a pipe-related hang reported to MSYS2 (that I
> didn't see this issue in the stack traces), but I am not sure if there are
> any more pipe fixes pending post 3.3.3.

There are some fixes (though not pipe-related) pending for 3.3.4, so I'll push 
it to the 3.3 branch after I've heard from Takashi and/or Corinna.

Ken
