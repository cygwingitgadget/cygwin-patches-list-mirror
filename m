Return-Path: <kbrown@cornell.edu>
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2122.outbound.protection.outlook.com [40.107.102.122])
 by sourceware.org (Postfix) with ESMTPS id 6870E3858C39
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 22:18:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6870E3858C39
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNK0I9gHhnxY8+X4QV+gS8sd4RhcASL1Y69jfwjdYFYhQ3ko1dBx67baXdVeHPxe6EzKLRNsel/g5vFFfl07ezTQp50Fs758rIQDbqMNJmM//XiPHHhWw5bKZSSFaMpChC8f2gMI+Dl4QmhfG/j2+dnBljXf0wc8+qYGyqnhy0Gy4yAG2aO/MJwerodBQZak1T2PSiTBCjpKqAcpS1bkxnLRXSKQwZXwJW+qOWTdGrI9iX2IeW+QmdBf4SV9uxbJaLJ9DcIq/NVtTRC4mZtQzkMsO2lwq2t788gQRZ2jaZghteLIPRpZ7Aq0qbCSvGsAnuKpb8DSZDzeu/XGrGQ0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTMSSbdtR/Axeev/6z/+2p3YJSe1SGzV47R7gsikNxg=;
 b=F1550cllv4+tfWuGPO2fDI6+Ha0MICDhB3iJvALuNLeuOFkkHlmyDAIl1YeI7WTOhMV4R50ib41IrqkB8X41/wEAqiShXX8+WFJ4O2LxlHpYDXk/2NrU/dpPZXNc42lA9Ob7E1QEMsKvDiU/clo2SrlP7Pfsrd40288QlKl6o+lY7tZOsMF0GGhO6rBhYdTNpiQJyOiD3Z0HOiiqc8EZSUscDT0cSM+c1Y5aoXGRtfsg00deCTvSWurYQNq6Cs2dy0JfMS7vSK9hRS8YgIwAp+l28ZG5U4Md9h3g9sZfA6zWMqfJ3o2dYSkMQMYiVix2mNqPRj6KrXoK/7XUAhd3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTMSSbdtR/Axeev/6z/+2p3YJSe1SGzV47R7gsikNxg=;
 b=jkOj58EMKHsigAta0uTf+2IZsCzNFTRVS47TG3nNImhvwlsYZs+ruBxqB5Htjq9BXXe/YB6nmuZ5X5fFVUjCYSlCMP7EXgnGWZDGDWp9PQLeZ3ZKUfYbNtUaPCS1/9wr0kikF7pezWTv6rB7/Vn0wnHQxZQSx1sSVJf5ln3HbO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB3953.namprd04.prod.outlook.com (2603:10b6:406:c9::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Sat, 25 Dec
 2021 22:18:08 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.022; Sat, 25 Dec 2021
 22:18:08 +0000
Message-ID: <c5a383f1-59b9-d925-b686-ed36e7753ebb@cornell.edu>
Date: Sat, 25 Dec 2021 17:18:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
To: Jeremy Drake <cygwin@jdrake.com>, Takashi Yano <takashi.yano@nifty.ne.jp>
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
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <alpine.BSO.2.21.2112251111580.11760@resin.csoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:208:e8::46) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68abc387-3fe5-4a7b-b02b-08d9c7f46dc5
X-MS-TrafficTypeDiagnostic: BN7PR04MB3953:EE_
X-Microsoft-Antispam-PRVS: <BN7PR04MB3953A86EFA5811798CA62B7ED8409@BN7PR04MB3953.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMerwifro0d5vDHM31jlPT0DaYiCz5f4ILwidPToetGnc1sfo4EGteniotciCDLZ7+5jSAxJcQgIyNUFK7Uh3Sy3C2Jy2fMC/PeqyhxNBFDEIzCtwT0K5NDKNhJv/wctOeLwGtOunjE0z+/5h3BbQPsfllaLi9/papXlCD0jPExcz0kMJvgYy3RoLldzZjKNujQnCTVuVA4d+VwIXKYaabQ++10Y3VY4wlB+H5B/Ax9V2a0WMjXIhHlUfpnoK1ZE4JPAH2qG4TKZdVQq+0/l+vZ2MRHqlXU1JI7NzjcECXEhFTyEHnh4whyzYqnSIlRcHDOXWbNcsQVnB8rRcagwQW7x143zrdQBKv9B9kpCfjKCxnisFZR/5F+0S2uMs/8aUFs8LKXZh/RQV5mynvyl1tS+81GhVjhLcl7roDA7EyjfIOE6ZfRgNkHLTfYby6gTgP2lM7pNUaf3/AtMxmXHzlurXAjzsLP+KSmtMnYhSk5aZ+2tr2ItdgNfKuwm4lwikuVS3k4xywQb3i6w/YbGCdyMLS2pR3/OxKCvHcnblkCb6a5SdKZhVdkB0zu1GAPm2/wZdn5aVu1fmuCeXInQjzodWS5kSH0dsp9PlPWt8EEcpkISGA9nMcADtS3PBHnsPzZA5dKplg42ne4L/WG3IOwJtIXvDyim69r0dQL5Ecy3PoWcp2yWc+KaAiCFQ3QSwP5e/JxXwwzXeRM+gcdojYDsnOBQtsrxFBAJ6TOwHR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(75432002)(110136005)(31686004)(186003)(2906002)(53546011)(66476007)(4326008)(66556008)(86362001)(83380400001)(6506007)(66946007)(6486002)(6512007)(31696002)(5660300002)(6666004)(36756003)(38100700002)(8936002)(2616005)(316002)(508600001)(786003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0p6Z3RKZXRTcDN0REZ3ZUdhbzFDcWNYYjQ3c3p5Y09BMmdDMm5ZNDdLUXRn?=
 =?utf-8?B?V3VEQmxmaEdNQ1dZWCt6a1ltOXphQlNHdXhUMFBaNkgwSVVibHB1cnVJSjZ4?=
 =?utf-8?B?SHNld2hkUjZUbnNyaU9yV0dLNm5zTXpnbjFhdjlVUzd5Z3RzR3M4amlLWFdU?=
 =?utf-8?B?bGlYTEsxZlU1djg5cFpBR2xRYUppdkNvTkxGYzROWHhRMGxRQW4vdDJkbmcy?=
 =?utf-8?B?OUJOd3VxSko3YndPMDhxdWtFMll3am9tQjE0NEpFb2xFcVZ4MTJSNTF5d0Jt?=
 =?utf-8?B?MzVOd2lOZ2EvT0IrUWhnMjJ3U0JIaTQ0ckZieEZiK2NNdVZrLy9JOVFXWWsy?=
 =?utf-8?B?a1VLZmtWYTM5Um5DS211SndZdDcvS1ZyaWdkYmx1SmR5QVpObjhuKzNTY2JB?=
 =?utf-8?B?NzBZVi9XRytSOWY1MHY4T09rU1loYjlybVB0SFVCVHFUMWxNcUZDMms5Y3E5?=
 =?utf-8?B?SnBxaUpqREJLb2dRMWtWSEI3NVpPenNudjVZRWNYOTNsM1JtbkVuQzBJbTR0?=
 =?utf-8?B?cmcvT0NxS1hReXNxNWI0VE13TjZ1WXVqNlBwdHdWVms1OENiNDM2bXZwT0VR?=
 =?utf-8?B?eHVSWG9Fb2R0OVV3aDgvbklrUEc4YS9waVFPUnlwMzBxMDVuSk9aS0habW0x?=
 =?utf-8?B?b1czelRpaXRKQ3EwdW9sazNNVWNLMWR1YWxGa2VpQmErdGtiZnAvNjVVamE4?=
 =?utf-8?B?UlNWRTkrZWhOdmVrUTRkQmlPc3Y2U2s4REVMQ0NFVjNkZ2hPRzlBelBxWWlk?=
 =?utf-8?B?aU1BaGxSMmZRL3pRZ1VkRFpXUm56dzJXbzZzWHdVUytTc2xMM0FRSHkvU1J3?=
 =?utf-8?B?dTVhMTh0WkQ2ZStQajRwdnkyZFkyWmlsL2VVMTRWRTk1QlppVGsxcWgzeXdS?=
 =?utf-8?B?NHRPRjhkdlk2S0J0a0MwaGVlWjhDaDh6YTNIZ080YzB4ZmdvdW5PcXAvcG9N?=
 =?utf-8?B?L0d1RVY4eHQ2bnpJdm9xelA5aGRpdVlLYUcyRDZpZkU0T0ZWdHBRZW1Wd2c2?=
 =?utf-8?B?Z2pxeTVlS2dBbWVpYTQwV0lUYVRxSGs0UWlXNGxtTTVFQmNCc2dvWXd3U0Rj?=
 =?utf-8?B?K0JpUmN3OHl0RnEvekc4UVZQL0NPSWx0bFBhQmhpRjhyRlVsU3ZkbXpwNmJs?=
 =?utf-8?B?a21UakVkMnVXL1QzbXltcVNYM25JN3F1eFFCR2lkZ2tTNk1OcElhb0RRSDdu?=
 =?utf-8?B?bUZ2bFk5N3lDdW1KRHRkQXFhYVVCT1Rod2pZdGxsNGpZbXJjd3h1ODZ5MHo3?=
 =?utf-8?B?UXZJR0FmT3RjWVd3WmNKSXdGdjA2RHB2MlJMR212cmxYdGIwUFJha3lFcDVU?=
 =?utf-8?B?cEloaUFVSkpQLzh5amh6Y2V3Q3B2TTgrQTFmTE1WV21SRTE4aXFtZlFSVndQ?=
 =?utf-8?B?Zmh0RHRaQ2FHb2plQ2R2aXU2cWg3dzVIS29LQmhZR1IxRUE1WExrTCtna2tw?=
 =?utf-8?B?ZGVwc2M3dXZ5eVlXeHpPN0tVVHR3eWVZdlVSb1E4emwvKzNaYmNIUHN4TzM5?=
 =?utf-8?B?bzV1L0RUcEo5Uy9CYi9iUjh2M2RvQmhybkNCMXdYUDBkUkt4eWhqSElyYmlR?=
 =?utf-8?B?UVV0cFptempkZW5BOFh0UXpyc1k0MzBMblZVY29XZFhKS0JZWXJaVGVKbG1Z?=
 =?utf-8?B?ZDdiRXJFT3pJS25TRmFHNzZxZjh2SjdMa3J6Zkw4bmJsUFNLeUx4RmIyZUFv?=
 =?utf-8?B?aXVGTjJ1YXhOYy9UWWxJWlhSaGY1OERndlArN0ttSElUaXNuL1ZSY1ZISklL?=
 =?utf-8?B?dDVLV3F0a0V6eVNqWTlrU1dIa245VVRzZCtsVGJiSjhVWDN3OW8yTVFCeXhp?=
 =?utf-8?B?ejhsUVR2bEtjYkJmdy9nblc5bzVaT0c5bGJRTlRxL1IvbVVtVEJSclhJa0NM?=
 =?utf-8?B?bDlwa242S0MzaXE0YkV3SU81elRTRTBRNE9xbzBGZzFBOWNRYnN0VTMzK1pE?=
 =?utf-8?B?UmhqQ1Q1c251Y3MyQktaQUhwSU01VU9VS0p0WWxXSWh0TllNMnJzUVRpQy9G?=
 =?utf-8?B?cUg3dVlPN1pnMUpTQ2I0YzVpSjlqcmx4NWUySmNZN1NyOGxKcjVsVkxlazNu?=
 =?utf-8?B?emFXMzI0VWIySTIyRFBTNUhLZ3dnODZXSHVKaEhOZnpkN3JReXBCQXQwNXNr?=
 =?utf-8?B?OFI4cW5LRTdHNGplQzZlM2xFUnNYdHo3c29yWGpRK2J6bUE2YVBleDJjYS94?=
 =?utf-8?B?V2xacUVkVUd3Ti9lS2dYMVoxT0tyd21XL1FWSVliakE1YUFpREpUK1VBSUov?=
 =?utf-8?Q?gOARWd/XEysorhsav6LMZih1MUBgP+1AInKSv/W9hw=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 68abc387-3fe5-4a7b-b02b-08d9c7f46dc5
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2021 22:18:07.8974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4u1Fga4hz1iZ72/Ifiw9UucpzdPi7MbG1rAd6beulanzOdlCD1NV82CL33MiiMS34onuV9G8synrShlNv0YIuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3953
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Sat, 25 Dec 2021 22:18:11 -0000

On 12/25/2021 2:20 PM, Jeremy Drake via Cygwin-patches wrote:
> On Sun, 26 Dec 2021, Takashi Yano wrote:
> 
>> Could you please check the result of the following test case
>> in that ARM64 platform?
>>
> 
> I will probably not be able to get to this until tomorrow at the earliest.
> But keep in mind the issue I'm seeing is not deterministic - I have to run
> pacman in a loop validating files via GPGME and eventually it will hang
> (or hit the assert I added in that version).  Most of the time, it's
> perfectly fine.

The results you've already posted seem to indicate that, on your platform, 
NtQueryInformationProcess(ProcessHandleInformation) returns STATUS_SUCCESS even 
if the buffer it's passed is too small.  [That won't necessarily cause a problem 
in every one of your pacman runs, so it might appear non-deterministic.] 
Takashi's test case is designed to verify that that's what's going on.

And I think he also wants to see if phi->NumberOfHandles is reliable on your 
platform even when the buffer is too small.  If so, then (on your platform), the 
do-while loop could be replaced by two calls to NtQueryInformationProcess.  The 
first call would determine how big a buffer is needed, and the second call would 
use a buffer of that size.

But we don't know any of that for sure yet.  We also don't know (or at least I 
don't know) what aspects of your platform are relevant.  For example, does this 
always happen on Windows 11?  or on ARM64?

Ken
