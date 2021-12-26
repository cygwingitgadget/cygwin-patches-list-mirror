Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2132.outbound.protection.outlook.com [40.107.220.132])
 by sourceware.org (Postfix) with ESMTPS id D39353858D39
 for <cygwin-patches@cygwin.com>; Sun, 26 Dec 2021 22:18:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D39353858D39
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsXDv9ge5xznPUi5vbzhOqCUjP5gqEMcJjyRtSzyj52LY1q+KDj8e5sEeJjzwvO6pjShHeaYfed3HoJ/gHksvsIphYc7VYZY3Guxj5ClCnI0qALpmH6rp0wR2CXq1Ip6Ts/oLX2YfaqGLa374DZsexnPoR4Oeu0ADQQlt7g0E55bceg2T46D1zPxOtP89FYw6ZKSZh3Vedg0s5qWyW4PNp3uV8f3d/TTMBn9/yR9s882Ffo/mBZ5AbI9LAickOJvsEFPv7PN2Fr7dTw4lswu0AYh4HLptUjjgadSOab/O+++30brK5YcptCx5PmrdphmF2RBOA2MYApO9NrO+GCRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMjVpVBrFUjclO6qsMezBAW4KWue12dQOcI1DY1smfE=;
 b=RYXIiRXeAjSFWGVXfdabY8t9YHyO0dANpuVOgOe+rSpxwk6xvX8vb+EUS40A1eP1+XaAqtX+p+yVI3EZt8miyfCYGMo0Ridq7+AOvvDZplswWw3OpeZo3v9LAsLxQ4JRWradFlCNkeKKhiXGwnFdp7y8qZdR5v6zxeuBb3Lgo5eGoSJ1zRh2ci+BYMIM2Oe5pSQuUCUN1ydzLxhNK6O4Sdj8jfyFw2bjp3cOlnczOx6y1x/e6gvhEqoSsIlN/8/hnzwN0ag2FmHxpXtdMEIRpu4NphkjfYXLuLv1+DGfAJUS8W52zcp2AVKJE3dkkwLC7uVTz4qnpGk4oWROxCS8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMjVpVBrFUjclO6qsMezBAW4KWue12dQOcI1DY1smfE=;
 b=ZI80vlJi8epKASeHru4a8jN6VKzIEB05FM4iz16667rsxZwaiDagUG4Xd4UUYkO3IUaqHifoO1jFNIlIgB960Q/EGftoWnBsx31iQPjCPJKl/Q5Vv8arX8rfxJiQ09+/kbYAVcGVKlLjlzGT4EuuCu+kIGhKE1wXW9n8Tp6ZmoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0659.namprd04.prod.outlook.com (2603:10b6:404:da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Sun, 26 Dec
 2021 22:18:51 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.022; Sun, 26 Dec 2021
 22:18:51 +0000
Content-Type: multipart/mixed; boundary="------------uV8X0oFj0N5vm6K1axTW8u6t"
Message-ID: <b278775d-03d9-6683-ec43-62729bb0054c@cornell.edu>
Date: Sun, 26 Dec 2021 17:18:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
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
 <317dc73a-fb9d-3937-7354-c79492c1c64c@cornell.edu>
 <alpine.BSO.2.21.2112261331090.11760@resin.csoft.net>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <alpine.BSO.2.21.2112261331090.11760@resin.csoft.net>
X-ClientProxiedBy: CH2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:610:38::20) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34490bd5-8233-4d58-9f4b-08d9c8bdb1e4
X-MS-TrafficTypeDiagnostic: BN6PR04MB0659:EE_
X-Microsoft-Antispam-PRVS: <BN6PR04MB0659DA69816CAA9D4122D954D8419@BN6PR04MB0659.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asfRhtGRQEIYSN3ezKIngJDwS8cupYqaQOSLfwt5gmXU8hyZWo/3qQh+UHCA5EuYznTv0tXpNPW8LNvvcDIkhZMz3hhDhKzsWFFcb0/2ZdYV6Lb74ctbNQKCA4GJumKIcaiLKIBQVaRqZWmVwYcRt/UQ5nAJ+vZvBAv/F5elohjdpPMq70cbN5J5546ORcv3DsmRxmcn/OSTM/dHFs4MAFASsStaYMCkTsWDS71wpMF5aTQHizewZ4GDVCncEP2jTe4TfB1jtNLOJFiNiJtRPNJ9Ltnk40tTRJIj8Hlypc+HZKg0iLk55CrFWocHNhIK5ImQPONs9fVGxNlzhOWTBW4PqqaIkOa0kdAKLoJ4rrG4duyML3a7ykik0stWz1Gf6kpDQwWTiZjPQz6N12IL/fsZFqeWah+rjIwMztcRt0b8IqO2JVnjN4hkvHiqDgRELFNDmYd4URu2O5fIia/zdZhqbmaG+X72AFkGfx9UvuVKrGyvc4kDcxV5+H81nEoTtCx7/gRPykhAwV6IszZVdqgIp1P33B27/JMlS458tvMVF8KH9qGcyBZyZ5kzI6vkqCdBNjJwchktD/agQt3ZnY6bBuSrkTvtZR2EfEVxcliyWsT0nHxIyOg6s5mdVVY3TWXCWsXYBv2Lk7aO1XVuFQ2LracjKmQwldsRqPkT3lj1JMyXkGjt0jMLnYxJEw38PUQGJf+rjTR2pATh4g/8vodaX3RGVqzGmkjczc94Ys0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(2906002)(235185007)(83380400001)(66556008)(66476007)(75432002)(8936002)(186003)(2616005)(508600001)(66946007)(6916009)(8676002)(36756003)(86362001)(6512007)(53546011)(6666004)(31686004)(38100700002)(33964004)(6506007)(6486002)(4326008)(316002)(786003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWFJODFSdEIrRlcxZkVxbHRvS0VnSU9HTEN3OXB6WVFGZUxvZFZPc2NaYzdZ?=
 =?utf-8?B?NE12c3F0K3A1UjcvZEpOUmFFdFVaK0xuLzJGSmhpL0ZSSTB2TU9WU2QyT2Qx?=
 =?utf-8?B?WXhmTStFSkNIWVl3OXdFd2ZwOG0zU3FmcmZ6R003WCt5emp6TW1Zd1NTc2wx?=
 =?utf-8?B?bnFVb3BMeUJwRVE1RWZTVlo5OW5uaUVXSGVWUmVtblE2UU55V25NczNaTE16?=
 =?utf-8?B?dXNMcThXNzU3aEp3Y2xyU091VFl4TTR6OVViWTVUekVCRTAxaSt3U09kSEo2?=
 =?utf-8?B?eWtJN1psZzBTb3FHcGMxZjc5ZENsOVp1Z0x6elBiVll0R2RENStEbms5VEZp?=
 =?utf-8?B?R2dKKy82a3IzSHM2SVVscnhJUmlzOUFRNGVHUUhhMGlzdGJ6SndaUWp1U2t2?=
 =?utf-8?B?QjBLM243OS9MUlUvaktDUy9nTVoxOHRQcWYvTDVuc0U0aWdMSFBoRmNndnJF?=
 =?utf-8?B?VFFITDNTMUVXRjJjaFlVZGxkcEpESWZrVE85NTNTUW03dHF0UDBxUk5rdGly?=
 =?utf-8?B?dTZxNTJEMTBwYnFYMERVbWJBZnc0enIwVXlJTnVvRnZDeWxhcFNTUnpKVUxX?=
 =?utf-8?B?dFNTamdqN2ZkSWozT0Q3M3kwbEtSYW9lWkk0d01KRk5YNDZZUmNTMDUvTndQ?=
 =?utf-8?B?aThGRWNMbXFLeWJkellCdUI4UjdYeFBLWVFPYi9mcFk0UkVBVDdTcW1WdHFT?=
 =?utf-8?B?aDdNNlRvVWhqL25yc0RnNWh4bmFkUUk0QlBNcm1aSzZ2OFVhM1BWeW9tN0JD?=
 =?utf-8?B?ajlMalNFTklydklvUURrOU9lUVMxcTB0MWl0cGN4dTRJRUNISk1HS1pyU0F3?=
 =?utf-8?B?SkhMamcva3lzeXZkaHV6dlJiT0lROFpBczVUb1BoSThNTzJlSnhDekZXRTlG?=
 =?utf-8?B?TXhldmk0VHQramVuL25iY3ZEcldRcTJUWWllUkgyOGZkc09Gd3N3aTVtb2Ry?=
 =?utf-8?B?dzNNcXZnL2YraDBSL1pRenRWVjY2RXpseDh5TkRIdkVXVTlXYUdCZFZpNmwz?=
 =?utf-8?B?Qi9FNGxRNjArNTJiWkMxVGZ3dXZXSk1pcEw1VUFMalMzSXl6MVRhK2xiU2g0?=
 =?utf-8?B?YTVlNUZZRVZISUFjK0pkMGpjMXBnWmNyZUFlNDgxcDRCQ1FOQmlMRzN2bGs4?=
 =?utf-8?B?NEl4S0FqNkdyMURMQWt3MGtJT01xN09LWHpwd0ExQjQ0VTFqQWxqS0JlM0Rj?=
 =?utf-8?B?R1FCUm1RNTRCbnJYMjlzOW43dm14c1pTYXVDUjBTTkozMkVic05aSUhIZlZi?=
 =?utf-8?B?YWRka0ZvUEZSTnhOdkJTbXRMRm1NSU1uaS96b0xsblNLYWNDb2k5dXlsWit1?=
 =?utf-8?B?WHhTc2lRQkZSN0hwcmRUaEpXakY4VjA0MHI3ZlI0Qk5wVXNJaWR0OGlxV000?=
 =?utf-8?B?L2oxL3c1azNjRFFXTDdhQkJFUmhsSEhjL2tNS0FJbXJoWXJHOTRmK0pEeXpX?=
 =?utf-8?B?d213WVFlODU0azhramtKK2tIeFNYdStyVnkxS0F4VElXR3o0UFE3RDNUZU4v?=
 =?utf-8?B?ek9GdG9EUWNlVmowamhtaEVmQnh4dVFUTE03eCtjWGxjWmZDQVcyU2lYMVl3?=
 =?utf-8?B?TmlHbVFuRWFNWWY4cTlRR3lYL0FJMWp4QXJYUzVrNU5sdlJUN3lZRit6QlRP?=
 =?utf-8?B?amxOVmN0QXlzT1N3a0sxcVN6a2JBNjlUTGlZUmdpNmt3akVZdkZicXE5ZnFF?=
 =?utf-8?B?eDgyWmxwbVFub3NBcWd4TkZjeEg4VG9XdXFBTUFPdEkrS0dkZmZwNHF4M3px?=
 =?utf-8?B?TVJZbEZBKzEwM0ZFOWVyRGxoMHMwVGgvMVV6NnZoa00vVEhmYmx6TmJrbkIv?=
 =?utf-8?B?YXd2WWpTNklNcWU4YzJtN1k1Ymp0YVhha0RCM1RabjFLZTNFL1diWWZnVFVV?=
 =?utf-8?B?TUZDajBhUDR0L3p6aEs5cnZ4UHdOczJURGMrMTRQRkhaOFdFY1RtamxqTUdm?=
 =?utf-8?B?Q21KSzdiYzh2dEgwYUxKK0tlYWp4OHlTYjYyeG9JQ2lqNGF2aU9VUUZ6akU4?=
 =?utf-8?B?bUZDVDNPenM1TUNVdFV2dHAxUjhjU3l1ME55Tm9UQVBIemZFbm11U2dxUk9X?=
 =?utf-8?B?cUVkODhBWVZUT01vTXFLSWNlWTJ2M3JDUWg5OVpSOHFyMUVUMEpCaG9xKytM?=
 =?utf-8?B?NDREK1d0UGhmakNjeUYrRk5VSFJvRzlrM3dOOG83bGJQbFFMSGlrT3RuYUpl?=
 =?utf-8?B?VnNkS0M0eTc1bjE0dFpKZGZZWnNyQ2RRQ0x6SFV6ZWxubXEwRXRWaEZMQmxy?=
 =?utf-8?Q?ip7sDJ3GM5LSTo9yEbqFXHqg0rsufewtnohfwfBS8g=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 34490bd5-8233-4d58-9f4b-08d9c8bdb1e4
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2021 22:18:50.9966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXTg03speMSAnocYy7vedoNtHOr6I4UZO7xV1yf7FHn2q07UYhCDl0jggUpghXp6Ib3loCvNqhkeZjevFvwDgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0659
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00, BODY_8BITS,
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
X-List-Received-Date: Sun, 26 Dec 2021 22:18:55 -0000

--------------uV8X0oFj0N5vm6K1axTW8u6t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/26/2021 4:35 PM, Jeremy Drake wrote:
> On Sun, 26 Dec 2021, Ken Brown wrote:
> 
>> On 12/26/2021 11:04 AM, Ken Brown wrote:
>>> On 12/26/2021 10:09 AM, Ken Brown wrote:
>>>> 1. For some processes, NtQueryInformationProcess(ProcessHandleInformation)
>>>> can return STATUS_SUCCESS with invalid handle information.  See the
>>>> comment starting at line 5754, where it is shown how to detect this.
> 
> I kind of thought something like this (that NumberOfHandles was
> uninitialized memory).
> 
>>> If I'm right, the following patch should fix the problem:
>>>
>>> diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
>>> index ba6b70f55..4cef3e4ca 100644
>>> --- a/winsup/cygwin/fhandler_pipe.cc
>>> +++ b/winsup/cygwin/fhandler_pipe.cc
>>> @@ -1228,6 +1228,7 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
>>>               HeapAlloc (GetProcessHeap (), 0, nbytes);
>>>             if (!phi)
>>>               goto close_proc;
>>> +         phi->NumberOfHandles = 0;
>>>             status = NtQueryInformationProcess (proc,
>>> ProcessHandleInformation,
>>>                                                 phi, nbytes, &len);
>>>             if (NT_SUCCESS (status))
>>
>> Actually, this first hunk should suffice.
>>
>>> Jeremy, could you try this?
>>>
>>> Ken
> 
> 
> I've built (leaving the assert in place too), and I've got 3 loops going
> on server 2022 and 1 going on ARM64.  So far so good.  I don't know how
> long before calling it good though.

Great, thanks for testing.  I'm attaching the complete patch (with 
documentation).  I'll push it once you're convinced that it fixes the problem, 
assuming Takashi agrees.  (I think Corinna is unavailable.)

Ken
--------------uV8X0oFj0N5vm6K1axTW8u6t
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-fhandler_pipe-get_query_hdl_per_process-avoid.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-fhandler_pipe-get_query_hdl_per_process-avoid.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0ODU4ZTczMzIxYTA2MThhOGIxZTEwNjA0MTZlZjdkNTQ2Y2RhODk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
U3VuLCAyNiBEZWMgMjAyMSAxNjo0MjoyNiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjog
ZmhhbmRsZXJfcGlwZTo6Z2V0X3F1ZXJ5X2hkbF9wZXJfcHJvY2VzczogYXZvaWQgYQogY3Jhc2gK
Ck50UXVlcnlJbmZvcm1hdGlvblByb2Nlc3MoUHJvY2Vzc0hhbmRsZUluZm9ybWF0aW9uKSBjYW4g
cmV0dXJuClNUQVRVU19TVUNDRVNTIHdpdGggaW52YWxpZCBoYW5kbGUgZGF0YSBmb3IgY2VydGFp
biBwcm9jZXNzZXMKKCJtaW5pbWFsIiBwcm9jZXNzZXMgb24gV2luZG93cyAxMCkuICBUaGlzIGNh
biBjYXVzZSBhIGNyYXNoIHdoZW4KdGhlcmUncyBhbiBhdHRlbXB0IHRvIGFjY2VzcyB0aGF0IGRh
dGEuICBGaXggdGhhdCBieSBzZXR0aW5nCk51bWJlck9mSGFuZGxlcyB0byB6ZXJvIGJlZm9yZSBj
YWxsaW5nIE50UXVlcnlJbmZvcm1hdGlvblByb2Nlc3MuCgpBZGRyZXNzZXM6IGh0dHBzOi8vY3ln
d2luLmNvbS9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMvMjAyMXE0LzAxMTYxMS5odG1sCi0tLQog
d2luc3VwL2N5Z3dpbi9maGFuZGxlcl9waXBlLmNjIHwgNiArKysrKysKIHdpbnN1cC9jeWd3aW4v
cmVsZWFzZS8zLjMuNCAgICB8IDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfcGlwZS5jYyBiL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXJfcGlwZS5jYwppbmRleCAyNWEwOTIyNjIuLjI2NzRkMTU0YyAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9waXBlLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4v
ZmhhbmRsZXJfcGlwZS5jYwpAQCAtMTI1Niw2ICsxMjU2LDEyIEBAIGZoYW5kbGVyX3BpcGU6Omdl
dF9xdWVyeV9oZGxfcGVyX3Byb2Nlc3MgKFdDSEFSICpuYW1lLAogCSAgICBIZWFwQWxsb2MgKEdl
dFByb2Nlc3NIZWFwICgpLCAwLCBuYnl0ZXMpOwogCSAgaWYgKCFwaGkpCiAJICAgIGdvdG8gY2xv
c2VfcHJvYzsKKwkgIC8qIE50UXVlcnlJbmZvcm1hdGlvblByb2Nlc3MgY2FuIHJldHVybiBTVEFU
VVNfU1VDQ0VTUyB3aXRoCisJICAgICBpbnZhbGlkIGhhbmRsZSBkYXRhIGZvciBjZXJ0YWluIHBy
b2Nlc3Nlcy4gIFNlZQorCSAgICAgaHR0cHM6Ly9naXRodWIuY29tL3Byb2Nlc3NoYWNrZXIvcHJv
Y2Vzc2hhY2tlci9ibG9iL21hc3Rlci9waGxpYi9uYXRpdmUuYyNMNTc1NC4KKwkgICAgIFdlIG5l
ZWQgdG8gZW5zdXJlIHRoYXQgTnVtYmVyT2ZIYW5kbGVzIGlzIHplcm8gaW4gdGhpcworCSAgICAg
Y2FzZSB0byBhdm9pZCBhIGNyYXNoIGluIHRoZSBsb29wIGJlbG93LiAqLworCSAgcGhpLT5OdW1i
ZXJPZkhhbmRsZXMgPSAwOwogCSAgc3RhdHVzID0gTnRRdWVyeUluZm9ybWF0aW9uUHJvY2VzcyAo
cHJvYywgUHJvY2Vzc0hhbmRsZUluZm9ybWF0aW9uLAogCQkJCQkgICAgICBwaGksIG5ieXRlcywg
Jmxlbik7CiAJICBpZiAoTlRfU1VDQ0VTUyAoc3RhdHVzKSkKZGlmZiAtLWdpdCBhL3dpbnN1cC9j
eWd3aW4vcmVsZWFzZS8zLjMuNCBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjMuNAppbmRleCBh
MTU2ODRmZGIuLjA0ODQyNjk0MiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMu
My40CisrKyBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjMuNApAQCAtMTQsMyArMTQsNiBAQCBC
dWcgRml4ZXMKICAgcmF0aGVyIHRoYW4gaW9faGFuZGxlIHdoaWxlIG5laXRoZXIgcmVhZCgpIG5v
ciBzZWxlY3QoKSBpcyBjYWxsZWQKICAgYWZ0ZXIgdGhlIGN5Z3dpbiBhcHAgaXMgc3RhcnRlZCBm
cm9tIG5vbi1jeWd3aW4gYXBwLgogICBBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9waXBl
cm1haWwvY3lnd2luLXBhdGNoZXMvMjAyMXE0LzAxMTU4Ny5odG1sCisKKy0gQXZvaWQgYSBjcmFz
aCB3aGVuIE50UXVlcnlJbmZvcm1hdGlvblByb2Nlc3MgcmV0dXJucyBpbnZhbGlkIGhhbmRsZSBk
YXRhLgorICBBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9waXBlcm1haWwvY3lnd2luLXBh
dGNoZXMvMjAyMXE0LzAxMTYxMS5odG1sCi0tIAoyLjM0LjEKCg==

--------------uV8X0oFj0N5vm6K1axTW8u6t--
