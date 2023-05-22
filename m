Return-Path: <SRS0=k5fQ=BL=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id CBB2E3858D35
	for <cygwin-patches@cygwin.com>; Mon, 22 May 2023 15:45:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CBB2E3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id 14BWqU1kmLAoI17idqtlGZ; Mon, 22 May 2023 15:45:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1684770307; bh=DiH6QXV3BRr9QR2ZoMlvHZUSr5dzHY8ECfGZ+K7955c=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=UAKHJXrOhDfFskcu9hZZrNzemndlnh3rfjOknD6WokDQyBzqNow37ZJt/i8X6igy+
	 mzXsup1BQY498YtzRLaHx6px3+k+pg20sNygMMHZtoT4jeHW1DWB3nA8OamXFp36pW
	 hdG6IR/mswiWr0HA3ewxx9oFCnBmqbDGRq2aDGjEPSDyNf9hcfYnlank4cbB4q5w7i
	 hQNMjLblRapQkjR/IO7fsrT0cMu7hZB7ok4cT/upEA7fQQW0kiqJUzcMmwyangUnP+
	 wwKPpedgCW5/HhM4oQMD1wwcRggLTWL19tNKNYRqkOHXtf7KyYbBAcbiKULTYpskCa
	 h+HZRhVhK0cig==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id 17icq3cwwcyvu17icqTkf0; Mon, 22 May 2023 15:45:07 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=646b8e03
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=Gp_UlsBtrc1a6HPts4QA:9 a=QEXdDO2ut3YA:10
Message-ID: <38121635-ae00-c3f1-b089-f73a4289966f@Shaw.ca>
Date: Mon, 22 May 2023 09:45:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3
 cpuinfo
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <68bbf3607bdf37fcd32613aa962abe50846d968a.1682994011.git.Brian.Inglis@Shaw.ca>
 <0a50e9ad-59c8-65e9-95f5-f53843fbf918@dronecode.org.uk>
 <8e45602e-91c6-9621-1e70-4b1b3c400679@Shaw.ca>
 <8818056b-6bc9-9e18-c5dd-a88a9106d535@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <8818056b-6bc9-9e18-c5dd-a88a9106d535@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfE6wT0fBTj6eP+yfeDU2IYUNhSZC6ORsc5klLB88KeubUGVn1l7HXvtCoylhiMpWk1pQK5frT7X6N0lYgJLKjKMT74s5xEsWlMa3e9kzilsL7CHw/9iQ
 kf/K5VAwkCoG4UhhTKunxHxWrkiarKNMCLJsI0xJFzqACY5A0DN/KT+wSMZiiA5ncCPvNvIezfy2Wo2jz8PNs09O+TtKlf4hcrQ=
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-05-21 14:32, Jon Turney wrote:
> On 12/05/2023 19:09, Brian Inglis wrote:
>> On 2023-05-12 09:36, Jon Turney wrote:
>>> On 08/05/2023 04:12, Brian Inglis wrote:
>>>> cpuid    0x00000007:0 ecx:7 shstk Shadow Stack support & Windows 
>>>> [20]20H1/[20]2004+
>>>>             => user_shstk User mode program Shadow Stack support
>>>> AMD SVM  0x8000000a:0 edx:25 vnmi virtual Non-Maskable Interrrupts
>>>> Sync AMD 0x80000008:0 ebx flags across two output locations
>>>
>>> Thanks.  I applied this.
>>>
>>> Does this need applying to the 3.4 branch as well?

TL;DR: don't think so, just the next mainline release.

>> How many users with the latest models will worry about this before 3.5 release 
>> about October, and may Cygwin have support by then?
> 
> I don't have the data to answer that question.
> 
> Instead, I would ask what have we done for previous additions to /proc/cpuinfo ?

While updated for each Linux release that makes visible changes dependent only 
on cpuid (and available Windows) data (without needing kernel data like 
processor bug errata, CR, and MSR settings), it is rarely mentioned in 
announcements, unless additional lines are added for better Linux compatibility.
Without the kernel info, some of the Linux output can not be provided.

This info is for compatibility and informational for human consumption, more a 
nice to have than an essential, and a side effect of keeping up my own arch and 
cpuid interests and code with AMD, Intel, and Linux next features.

I don't know if it is used by any code rather than using cpuid instructions to 
get the info directly.

I don't think Corinna ever back-ported it; I always also tested it on, and 
Corinna /may/ have also applied to it to, 32 bit 3.3 for consistency.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
