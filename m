Return-Path: <kbrown@cornell.edu>
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2108.outbound.protection.outlook.com [40.107.102.108])
 by sourceware.org (Postfix) with ESMTPS id D99773858C27
 for <cygwin-patches@cygwin.com>; Fri, 24 Dec 2021 17:17:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D99773858C27
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e//KXck3w1m16pEd/OXZ5Lgz21bCb7FbBeK3a1zhDM2k0S7aRIcQgvlV9qxJry65cc8fLh9+PlN5RxDMv27h+j8xM5GSEzebKp1OcTADx8srpjWvPPJolQOe6jVBgd7ggL8rnoQl3SJFzi6COk6ycRtBJGSzZgIXiDnr6+EBDtFzZirJihzkR/OwgbvysEkji9ArX1GRbfu+qy80fIBqzVJ9K8gO1qUMRmPc08jRzZG1gDZAmLu4WDwYhbIoa0o7HmTLegZxC99S+0OUQ3jvJQ9I6rUMVycYk9ms4BpAxS659WK4vBMnwvDUq7/J7R5kfmE0YVHlZroPPTa5TbuY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hutBg2A2ScDXuJJ1U5RlTp/UU/nlLkdvqy6bon4RorM=;
 b=PQ9MgJhtBnhb3IWlF6lrAEkJ743PpFKRHa52EiPr6KDt51S/q3ha8y4304Orq8dfN7Faw+iT1XF+IcNaMuPqvbEBOYl1Z7wpqev5xcDwO1UJifmTzBXVzF5DE/mf5YKHfMmWTBTy/1qCON3WpAqpZdzWcsQDdRu3MnmOOcYw/Wz82OccJCz9BiMF7y/nOkUnddb8CoRPRzFoa1vCycFj61/DreIm3bgrJNzPgjHv9mAJDtH7YY/5qzVBwo3tPCsMIURcNCAZksukpGLTNQb2vWR6QU35H0t23tYa5dY1xFoat4zjNWxnhtVwy3iTPQhhzJpXD9CWvyo296BejBmc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hutBg2A2ScDXuJJ1U5RlTp/UU/nlLkdvqy6bon4RorM=;
 b=FM62j6z4E0XyJ24AoCOmMhwgXyE0Cq5y+Npsuhf2wjwv16pulcyTuJmP+Lh+faOI+dSc/tsdnpGGGJRN1el7KoL3sSTyTLMJ7IVKvTsKjMPG0xdsCmnqDv8wTImd8TmQulundIqsJEZDmxLoNvOa0lNZ2OtiuEZwduNf6GkumRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6162.namprd04.prod.outlook.com (2603:10b6:408:53::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Fri, 24 Dec
 2021 17:17:11 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 17:17:11 +0000
Message-ID: <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
Date: Fri, 24 Dec 2021 12:17:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:610:5a::18) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ebd02f-e9f1-451c-0998-08d9c7013896
X-MS-TrafficTypeDiagnostic: BN8PR04MB6162:EE_
X-Microsoft-Antispam-PRVS: <BN8PR04MB61628620F55AEA0A36A5DA0DD87F9@BN8PR04MB6162.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxn8PV0NxC9LsqrPsVNOODgBSx8+qDUvBKxSNfGOKzvcGvW8hsYBmXI3t+AAJhHjxIxsHDqjFy+Rhp9vYd9EKvbRQ1dwCqilHhMBUjtVi57Yei+62wAx/rragwpWqQ8TgkqQbIa7cWFDdo0jpmYdTWj2WYSUGGIAu0E6YE2yzCMrhwBjPtzklAjyveVNWTBhfJc3ol6pAEurd2DwzBZ9Hx1rUrGtSfulqy1S4QrBBstb3/18xG9MnGCLKdmHPZl01vtZ9Qp6iktLwNnte/4IULeKlq935ZrJX7Z6tAvNXyBzvxNorENcIuGAVhJaxeUfItM0g0p3xZqLQZyD7vfs6R/RJhop71cr40OwXNvRDedJepyhPGOdppSFpPOtGKegRlNMxedzoFF1/7c3YRxt08PYI2WsSmqoMa1aKF+CIgmUQ6WPYcAWYAKGV2bTDZ8X1E96czy5Ih3ZO0hH4Y8TRwO5UA5quFtYxo2VIViJ/DD/mkk7fz50o50dzTki5zF0Rw1snx4yNpVtnV/KEtt9kYB5rcDkQCDYOcAt004+Z1HJxE68+PpfkBGF4Ms7Z8iNOSp35Ru/2p2weMt03fLSOfn/6T1vgdyPk2fW2OLAr2/cRBA/oXFvy+q92fMfJe5fO6wEABvASS33rhA3my2mqjRsMi8swCjYoxQoupzGxEKDK2qn4rO4Uih9sDNc5jxGx0n5tB7+9OyeMWTUTes8uO+Yp6YUL9HwSkWTxMXKTnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(66946007)(38100700002)(6506007)(66476007)(31696002)(31686004)(53546011)(19627235002)(66556008)(6486002)(2616005)(6512007)(186003)(5660300002)(6666004)(75432002)(8936002)(8676002)(83380400001)(316002)(6916009)(508600001)(2906002)(86362001)(786003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTVDVFVsS3FJaWxrNk1EaVV5cytUbTZXK1ZlRlpTMmRNR3RPMExFb2pzb09r?=
 =?utf-8?B?Q1V5dlc1MTFManJxQks4QzRtSlhiaUN5dU5HWUhDSHpjWEUvcmszSkJvdXZj?=
 =?utf-8?B?Z2VPTmo1S2NZcVVwQWZ3TVp6YTROZ2hMbzUwbDZZUG9ORiticlJZb2dVdFZK?=
 =?utf-8?B?YzhLM3JYRzIrYTRVUlI5bG9vMHEzdXNzWkl4OHdHVFJEWitXcTJDNGFiYzhs?=
 =?utf-8?B?ekhpektTN1RDMlRtWXl6UVJ4dXVaYzBSV0hDVElHNk8zeVQzRnpheDN3WlI5?=
 =?utf-8?B?RU1WMEFhVndEREUzNW1OdEtmbGJNaUp5ZzlweVZwM2FQUTh3RzIvNGZ6dGdU?=
 =?utf-8?B?THVhTmFOcVdOeWhrQkc2TzB6c1VscVBMK01oVGV1R05kd2RDNlZSVEdOOTh1?=
 =?utf-8?B?TytiUmpURlYyWkJQSnhuK0luNjMxTUxWM3ZFbzkzMmNrVEVjNjM0MjBubXo2?=
 =?utf-8?B?eSsvbXpXWUFpYzFaSjI4WVJ6dW4xT01LS0QrMUt5Smo0Q2RxL2t2OWhhd2NY?=
 =?utf-8?B?cjloSUxOVFBRbFdnYi9XMlEvNkNOazNnYnFGRE82YjB6Q0Q0Wjl1TGxQaEg4?=
 =?utf-8?B?cENNb3NKbzdhczJLRnNHVFd1dmx3RUR2ekFzcXQ0RWcrSnhpaVVpeTFTK3NU?=
 =?utf-8?B?N2ZWQVFSTlYyRkJ2bHc1L0hUN0h1Yms2aDBvYjBpY29lZUsrbzdmODQxTDVt?=
 =?utf-8?B?dkh1NnNrUGticHd5WkFlQUxBN0I3SHFDZWZ6Mzh5OUVtRy9BWFJNNlMwZDFM?=
 =?utf-8?B?RjJFWnpML2xEOTVSRldUZTJUVmNZMXpzcjlocFJKR3l1L004cUlUNjQyRlZ0?=
 =?utf-8?B?YXdCMEo4cnR5WG1CMXRmbk84R1FYR2Z6Z0pJWklYMmFMeEt0OC90Y1d0R0Rw?=
 =?utf-8?B?K2REQXkvUGhsbFVCR2JXSnJSWVBwZExQSWJVYjBYUjJDV2sxVGlmNTZWcjBY?=
 =?utf-8?B?UXlHYzJ0eTY2eUJqYnMrT2w3dms5ODFtd2puWFRvekxZbFJWbnd4Tm81YWNV?=
 =?utf-8?B?Vlo3eGt4eW0ybGcrZEV6QUtsU0NRVVdodldhMHpYYTduOGE3QmlsS2N1dHU0?=
 =?utf-8?B?TFdFTDA4YXZ4Y21QeFhQM0NISk9ZdEpUYW1sV2YzTS81Qi9BTDVwaU9VQ0s2?=
 =?utf-8?B?bG81NzJsK0lrZlhhWDZ2QWtQOGs0UGdxYnV0VkhjQXBIeVJsZHI5b1ZIbU5H?=
 =?utf-8?B?c3lCV1R4RGFXSHB3ZjVuYjgvK0J1aXdJclFoZlYrKzhrVnkzcjFYdVI3cjNp?=
 =?utf-8?B?N3h3WTEvdXhzVkdIWGhTeERVQS91ZWdxc2ttQzdUZ3Y2Zk8xWStiVE9BUGdz?=
 =?utf-8?B?U2hRVncyUWNoN1lHTDNyNFdWUGxOUEthSzZkc25TUTlmc0RkdXFBcXRleG1w?=
 =?utf-8?B?Q0tIcXhGZk1LYitoK2xBTjRuZWpoUENucWpwcXg1RGRyd3MyUUIyV2FMTjRP?=
 =?utf-8?B?ZzBhUWpaNXF6b0laL2FraW1Ca1FTUGFsckk2aUJ4cWpaUGYyZ1dsLzFHUmRH?=
 =?utf-8?B?THZHcllZS0FiYU9JSWI1Z1VUNUZuNkFBd2c3eDMxQmx6bDFTcmo2bDE1bTZH?=
 =?utf-8?B?ejBrWTd1eFRZcnVxR1d1WGhRdy8rU0FEYTBNRVdFenR1NG9ORkVuQk50Z08x?=
 =?utf-8?B?Zm9IVyt1UzBRdUgxdVk0dFZGVkt0VmE1NC94SHl6bkQ5TE5rNk9vK3VrL3l5?=
 =?utf-8?B?eWRjYjlyVVVEdjV5UnZjTWR1Vi9qakYrZ1BVZzBReWtMSzVzNFBOdlc3VVNE?=
 =?utf-8?B?OHBUTGx2aW5zQzMzWnpITVVOc1dTMnlZeUdVdlFyU1Nvcmk5cU1kbHlLYnY5?=
 =?utf-8?B?WHNjZE41MlFwbStFdVZTOFhqL2lWWmx6OVNFcXY5dlIwT2lvUG9rOUV5Y0Yv?=
 =?utf-8?B?Ukw1aUZZbng0amR3UFVsTDRCV2d5WGQyRWR2MGJVMVlpa2Joc2RzUE5Obi83?=
 =?utf-8?B?VkZoUnZuMGhBaEZha0tFS2VaOHMvWXRBcEVRNjhhNWVFbzJYNDcxMmtkdm95?=
 =?utf-8?B?WVQxY1FJWEdidWxrWGgzTHR3T2dTNzk1YTdSNDA4ZkJyYTRHemtxaXNRZWtv?=
 =?utf-8?B?S2crUEhHRWdLYmJ2dG1vZWc1OVJhZXVraUd0RGlzdHNSSXJ5SWM5VW9OTXpQ?=
 =?utf-8?B?d0Y1dFRMempPSUlTMnExL2JSWG9xbWZoaDUyTlJmZllydCtQMEVUSlR2QW9s?=
 =?utf-8?B?akVEeTc5d1V0WjhKMUxPM3NXU1kyTGdLRDFEWUdTbkM0RUhEbW5rZ3lDODhW?=
 =?utf-8?Q?6zY1+KK9gA9HynIy4zZzMrGfp5OXBL1ZAl0OkdOVbg=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ebd02f-e9f1-451c-0998-08d9c7013896
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 17:17:10.9762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zo6LNGYNrp+fW3oENd0R8HO46kUxZquQOJRUdqqN7cLNHqTrs9tB9WBFDQrpUdTQgkBUbPBUGy6kyiRzExqGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6162
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS, TXREP,
 WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 24 Dec 2021 17:17:14 -0000

On 12/23/2021 7:29 PM, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 23 Dec 2021, Ken Brown wrote:
> 
>>> -      for (ULONG j = 0; j < phi->NumberOfHandles; j++)
>>> +      for (ULONG j = 0; j < min(phi->NumberOfHandles, n_handle); j++)
>>
>> Reading the preceding code, I don't see how n_handle could be less than
>> phi->NumberOfHandles.  Can you explain?
>>
> 
> Not really.  I saw this stack trace:
> ...
> #3  0x0000000180062f13 in exception::handle (e=0x14cc4f0, frame=<optimized out>, in=<optimized out>, dispatch=<optimized out>) at /c/S/msys2-runtime/src/msys2-runtime/winsup/cygwin/exceptions.cc:835
> #4  0x00007ff8abd320cf in ntdll!.chkstk () from /c/Windows/SYSTEM32/ntdll.dll
> #5  0x00007ff8abce1454 in ntdll!RtlRaiseException () from /c/Windows/SYSTEM32/ntdll.dll
> #6  0x00007ff8abd30bfe in ntdll!KiUserExceptionDispatcher () from /c/Windows/SYSTEM32/ntdll.dll
> #7  0x0000000180092687 in fhandler_pipe::get_query_hdl_per_process (this=this@entry=0x1803700f8, name=name@entry=0x14cc820 L"\\Device\\NamedPipe\\dd50a72ab4668b33-10348-pipe-nt-0x6E6", ntfn=ntfn@entry=0x8000c2ce0) at /c/S/msys2-runtime/src/msys2-runtime/winsup/cygwin/fhandler_pipe.cc:1281
> #8  0x0000000180092bdb in fhandler_pipe::temporary_query_hdl (this=this@entry=0x1803700f8) at /c/S/msys2-runtime/src/msys2-runtime/winsup/cygwin/fhandler_pipe.cc:1190
> ...
> 
> Line 1281 of fhandler_pipe.cc was
> 	  if (phi->Handles[j].GrantedAccess != access)
> 
> The only way I could see that causing an exception was if it was reading
> past the end of the allocated memory, if j was greater than (or equal to)
> n_handle.  Unfortunately, I haven't been able to catch it in a debugger
> again, so I can't confirm this.  I took a core with 'dumper' but gdb
> doesn't want to load it (it says Core file format not supported, maybe
> something with msys2's gdb?).

I agree that it's hard to see how the line you quoted could cause an exception. 
  But you were using an optimized build, so I'm not sure how reliable the 
line-number information is.

Is it feasible to run your test under strace?  If so, you could add some 
debug_printf statements to examine the values of n_handle and 
phi->NumberOfHandles.  Or what about simply adding an assertion that 
phi->NumberOfHandles <= n_handle?

Ken
