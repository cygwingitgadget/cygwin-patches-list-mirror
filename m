Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2108.outbound.protection.outlook.com [40.107.94.108])
 by sourceware.org (Postfix) with ESMTPS id 53600385840E
 for <cygwin-patches@cygwin.com>; Fri, 24 Dec 2021 22:47:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 53600385840E
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLlmAXjN2uLK82pTHpDOldY6OxdkxzusAUPbyj/fDXMW2eY3jL1ykhDaqKeDnoPdm3CrHzTb0dGHfAS6pDcum7AsDTNOaggGgY/lMvnrJbLRr9IdpafW60Y2EOKzRQLZNr3wnQBM9T42Mjiese6PUuSTDgqxZStCaCxls6ijwU7B97CcuEIJJfNNG/+iu48CmxNv2YNZlIzAztI6IexmE2/emID+nrF9HQU9r3ZouRBATniJ9x6E/HIHobKLFv1rgUVhuoocRnnPH+/jgOaq+0L9wEisvimv82fhoKbFZ9wUyS/dYWJzsQBxpJBNXXMVXVx72DN6GgWkFkiWM66ztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnOWPaVKpmVYISvqMS7nG3HJUJbQCMh6n9ugqIWz8gs=;
 b=ARuB54m1yJ55eiXmcA7MHBFslScNuGoeAKzxBQvjHelOdT0nlog3wQ4YO62HKg5SKoHt665Y4CcPfXLbAxs8oKQVufa21xWkxJ9WAI7o048A/TwNTGesr+kHhFOfj13FUPg639TcOFEol/a+zUjQrX9pv7CKGIugK0oRF+I80+saRzHT/1IdsR1hkv+xFLYJa5UAj4hn7IEsrylj4eMIrPDBkT+W8tsq/iQBPnQF2A2ssDqpwzIpw3sY/mOE6NAX1N8Ksv0u+Y6xZk1Tu37+ZUhG3bNJQZDybYOD478goQpaYhLzt7tTf2wtV34zbms33vCp0AE93700EvzUYljHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnOWPaVKpmVYISvqMS7nG3HJUJbQCMh6n9ugqIWz8gs=;
 b=OTA1RWR7QZZX55XrJ0AMk1pnw1VqexKBIakSEcuJ4Io4VMKy9HZixIVDmdZrbaq+7A6xRzmvCyCZC0v88qLHh4DYjtAwsaF+f2gcB1BUXioXSI2UHLayoJjEg7eRvsHFqhbHkDF6A5ZcL9w4jXlS6zECn1/45XkDKUuLf25hrn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5620.namprd04.prod.outlook.com (2603:10b6:408:a4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Fri, 24 Dec
 2021 22:46:58 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 22:46:58 +0000
Message-ID: <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
Date: Fri, 24 Dec 2021 17:46:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f644e91e-8a6c-4728-5b3c-08d9c72f4afc
X-MS-TrafficTypeDiagnostic: BN8PR04MB5620:EE_
X-Microsoft-Antispam-PRVS: <BN8PR04MB56207DD407C690C27C37C763D87F9@BN8PR04MB5620.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tG9j3h0uQ7hp3xs7+0EaJgWGrnGpjT2fCoEx3jnrebeHY9frpLVp084B+0sy9A2OcIpXgHGCdywZU+Uu8SnJp/LS8B8iNv47T3aAm/wzbiaINQ81GBtfx0Ue0CtTDZmnhJw/mxH9bpt0Nd6kUPFOV7L2KiiykgKQ82wAlQ//jpj5y0nvtcYrfdjYzkcJ7d9rvZ3vKIYdPogwqFcBhVC7ccP7wpQr6YNp+RfUGlw0Cnr7GMDPnurnD8LUBhl4UuM39sLSmX0JXrnRTQimiu5KBmFIVoYwtn3TXoU3fX8DAIc37YUYPauCkdgioNi/I2XmaiS1Uey9tLqPBHkdna+eSgukWWO64NrETYoNzP0xUYxxtSHiHIizaILRPFLi5KpqziBLf3Foupsyud0b2ceXtsrVdxGSFWeG3A2pXdU3kf1eZi3sg9lfcJV3EIm5HMsXCiYUDimFw71n61Xcgox0q8iUDMkubS6M1Buzqz6VbHNpl5h2g6O33q0a7XTEstdK2AFRPzrV1O9j/2FN1PRFY66OO59g6y5l3aOs1O5tuf58/ijPFT5QluHJJG4RaF53iLQiU9cIbHi7U9U9DuHLUbOOvVKOiJKkpEkeYf34SCna9QlTQWAy++y4B1k6rUxGNBkOaIEiiXuynl/YAz0McsQBCIpurhRonnZvtpWq7FsQ6brQ4310udGhhR8tklPYghzpmDiZvT5yGbB4VH720TugoM4n5V4xZE5NUjk0DQh31aqG1XH7bvu4SEclGZJcwolxP7q/GOXWLqshvVPJB3MEJJ0gAzs55eTv5sfxlhRYvatk8vBbfyK4pv2FBl6n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(6512007)(8936002)(5660300002)(66476007)(6486002)(83380400001)(75432002)(86362001)(38100700002)(4326008)(786003)(6666004)(31686004)(2616005)(6506007)(6916009)(36756003)(66556008)(966005)(508600001)(2906002)(53546011)(186003)(66946007)(31696002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0Q5dlhKOG1GWXc0a1VJKytHZ1B3QTRKYVFaZWN4WWVDWWZyOFBoYTRaQlgy?=
 =?utf-8?B?aFJTQmNlYzBwSlE3RVlPdmdRdURHc0VxbzU5Q0pXRmZRRHdpdzdLY2lMSHdz?=
 =?utf-8?B?WEpCRkFCYzBueEh6Y00yeUs4dXNqZnFETzBlZ1M5OTRXaStYR2pGSHhJRmk4?=
 =?utf-8?B?cnNCQ3VzQStiUnphai9zdmdHZWg2enlrUE5pMnlqR0Fyc1pwb1dBTjhjRkJM?=
 =?utf-8?B?S0JsYjc2V0NOaEt0OEdIM1o3UmhSVitmeEUrb0RNb1JTRkxvZmFodG9FbGR5?=
 =?utf-8?B?SEdteUYxUENKK3FYczlkWi9zR3ljVDd1N0lKVVM3aHFWaDlDVThyL2JweHpa?=
 =?utf-8?B?N3poYS9RMWgxTzJxSi9jUzZwMjhhNVJKM3k2bFZzalVwMjF6SXZjR0hhdXdW?=
 =?utf-8?B?anpIdURUZGFhWjZYeSt6UEcva1BvVFFrcUg5S25DMjVtS3ZCWjA4TGUyTFcv?=
 =?utf-8?B?UVlYWjByd0ZTcnFnQ21QcW1meE9nZ1BXRE9CVEhIbEFTZ1FTM0pjOFEyeTcx?=
 =?utf-8?B?b2dmcVBWZFVZVDRmMDJRQ0dSd3M2YnNCZTcyYUhNOG9YRzd4Q1Y0UDdCUmRj?=
 =?utf-8?B?ZDdGMnkrSWdQeCtSeE1TY3NPMFhuUEc4bC9hVGMvQkRoUXJJZk94eWxBbEJO?=
 =?utf-8?B?N3pWdU05T3c0dXpqUCtCazZxNkJnR1VrQzk4Ymt0QkFrSEM4SGNralduUDdX?=
 =?utf-8?B?ZnhXU3UyQVRjeUV4LzIyNEFNNTZFOWhmSStub1lJZVA0NzhYK0g2UHlJRkFD?=
 =?utf-8?B?QjNmanB2Z3dDUEs2WjVIYnlnNWd6aHlxTzFEdm5Wa0dMcndZYzVTVVBFZk81?=
 =?utf-8?B?bURYejJaMlJ5S0pjZEpIbVdON1JWL1Jwa3VITjBQN0NWMHJ4TTFzZ3o5NlR5?=
 =?utf-8?B?ekZaSUtIQ2tNOXFkV3BrbHgxUEVPZ2VodmpueHFlM0FUWHdVSzBrL1RySDU2?=
 =?utf-8?B?empDRm03d1Vja2Z5T3hKM1grWFNTWkFDWm9JU3dtZmlqZXFRclFmSjNvaEpI?=
 =?utf-8?B?Um1NZElFT1hib1E4Q21ndlFzOHBwRTcyT0Npc25kTGVjWGpvUG5YSTQ3Mi8w?=
 =?utf-8?B?ZXNzaWQ1M2V4NVdBUi9vNmJsMnpiTzQzNFJ6WStCOTg4WUJJUzBIcnc3eUtr?=
 =?utf-8?B?NTN2VytPV3VwODJYeEJ2cktiaWJVbkxMaWkwYVIwK3FtUENYL25IWk8wWG4z?=
 =?utf-8?B?UDlMV3k5aFpRcHdMNXV4WmVrcThDTnlnd1JIc1VrRUN1c0c3cnJEaVVoUU1D?=
 =?utf-8?B?VTZVVlJhNGIwbU1YOElXZnVnOXFNMjIyWHZZMWw3MmQ3QmJKOXFzN2RmMThj?=
 =?utf-8?B?RkJMN25jTmUxeEM5ZEZqZW9IcG9FOVF2UG9jaHhWQTZIU2RCcHZybml6M095?=
 =?utf-8?B?SUx4c1I5VU5xajFkS1I4TWE4cm5zWERaeFZWOWZWVlE2K3Ewb0pQTjZCZjg0?=
 =?utf-8?B?cG83bFhJRkNUTWRqdkVpcUZwY2kzUFBhRkJKS2puVnA3OVJPa1NxZktVRksy?=
 =?utf-8?B?bWNCZE4rWVNVT0laMUtWQ1lDK2hNeFhaTFpXZHk2ckhxc2RRMDN1SFFEWGFH?=
 =?utf-8?B?UEZkNVFwTGZTZmExYVFMVW4wdlhQdHpyOVlncFloeVMzeVFOZmdsNlE5blZ6?=
 =?utf-8?B?UWtiSUpMYlNUOEJZTkc0blZZaVVmZDQ0Y2ovMVRhcjN3eXBwNWFRRmZGakpF?=
 =?utf-8?B?ZFJqR1JhWlRNbCtYU0xrbC9nN0EySGRZWTRqYXZVRXhaWThkb2tBNHZSaHI4?=
 =?utf-8?B?bXZDNWR3L3ZLTUlid2lNdzNobzRoZENFSTZRRmdFYWh6eVRzWWZZU2pEcnB0?=
 =?utf-8?B?VGc0Tm1rVkZ5UkVHRkRQOCtqckxRbHVXcVpjeHF2RVpUaFRScElVenplN0NG?=
 =?utf-8?B?elVtN1NMS29pNmhYVVFSQ1laLzUrUU9uSUVXT2NBMndmVGF5RWxTWUgxUnZK?=
 =?utf-8?B?SjFBcFZiQkQrY2lCNGRIMUVFKzBZeGgyN09UNnlMdENOQ1lDeCt5WWVtVDdE?=
 =?utf-8?B?VzBOWkRxaXMyVGxrNVJOcUtLUEljVitJSUdNbDVhR1dHQXRLRmdOMVlzRitG?=
 =?utf-8?B?T3RuZzNVQTE0Q1BGZ1p2TFNQSkRkVGt6U3pLYytHQjNJaXlaS21vcDM0bTBF?=
 =?utf-8?B?WVBDODU0ckZmT1Z6RU9LcXRJeUt1NldGalBIV3NpalVrSXl0ekJEdTN3ODV1?=
 =?utf-8?B?cXFtNWxxS1M4YlpwVmJuUzNyME1leU9kRWF4ampTY3lTTlU5ZlJIdy9VTmMz?=
 =?utf-8?Q?TEjp/YgJa/HQhnMPKNc1DVH26nwbK+WSfXNL8aLiL8=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f644e91e-8a6c-4728-5b3c-08d9c72f4afc
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 22:46:58.6797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGxheMMzSv9BzGhXn2ybSiXWq0inij/KQn0cD7ANd6CiEwJd9DjVEGS3b3mE2UH07jjhbPxddW06AWpr5Nfzkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5620
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 24 Dec 2021 22:47:03 -0000

On 12/24/2021 2:42 PM, Jeremy Drake wrote:
> On Fri, 24 Dec 2021, Ken Brown wrote:
> 
>> I agree that it's hard to see how the line you quoted could cause an
>> exception.  But you were using an optimized build, so I'm not sure how
>> reliable the line-number information is.
>>
>> Is it feasible to run your test under strace?  If so, you could add some
>> debug_printf statements to examine the values of n_handle and
>> phi->NumberOfHandles.  Or what about simply adding an assertion that
>> phi->NumberOfHandles <= n_handle?
>>
>> Ken
> 
> This issue is not consistent, I was able to reproduce once on x64 by
> running commands in a loop overnight, but the next time I tried to
> reproduce I ran for over 24 hours without hitting it.
> 
> It does seem to happen much more often on Windows on ARM64 (so much so
> that at first I thought it was an issue with their emulation).  With this
> patch I have not seen the issue again.

So can you test your diagnosis by removing your patch and adding an assertion?

> Also, it seems to have started cropping up in msys2's CI when the GHA
> runner was switched from "windows-2019" to "windows-2022".

And does your patch help here too?

> I forgot to give a full link to the MSYS2 issue where I have been
> investigating this:
> https://github.com/msys2/MSYS2-packages/issues/2752

Actually I think I might see a small bug in the code.  But even if I'm right, it 
would result in n_handle being unnecessarily big rather than too small, so it 
wouldn't explain what you're seeing.

Takashi, in fhandler_pipe.cc:1225, shouldn't you use offsetof(struct 
_PROCESS_HANDLE_SNAPSHOT_INFORMATION, Handles) instead of 2*sizeof(ULONG_PTR), 
to take account of possible padding?  (And there's a similar issue in 
fhandler_pipe.cc:1296.)

Ken
