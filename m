Return-Path: <SRS0=2n0R=CE=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 6AC343858D3C
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 21:26:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6AC343858D3C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id A8IeqzHVs6NwhAGxiq07vK; Fri, 16 Jun 2023 21:26:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686950790; bh=dnWbhcenysEHBf7RX4kaHxlQAAExp5MYQCF8/yudTGs=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=v+n9A8LjqLCn48Eadc88DYw//3h7ZlnDp7CrlQaFUpQd13Grmo+6KdTNEsjP1yWO1
	 b9pJyWWrS5QEx7WnEROyRqTdsDyajOY39F0qXD5H1KGbB/eFOANUBC0zxbH1VMRbVg
	 pHqscRW5o77K5DWTK37n4/75n/4V8Pvu5idH9yZ4oY8KPbfN9/Hh4ybX2nnc40658s
	 9sIED9eK0P8XejwB9ROKMZEcrJ4UZcIQTfCSIS4x0tSYrxgB+Mwr75e2q5Ibc7Efpe
	 KFOZFep+7vPmDW8gCdVu8df7orDtEDKJK6jy5UEr4GKpMXIGUUSfnpshaoFoD/9jop
	 FBbWYSYu/APzA==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id AGxhqpQnRHFsOAGxiqp4Ok; Fri, 16 Jun 2023 21:26:30 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=648cd386
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=g6YOUB8gMFjdjclL3OUA:9 a=QEXdDO2ut3YA:10
Message-ID: <5786973b-7343-6a8c-38d0-35212d80a2c2@Shaw.ca>
Date: Fri, 16 Jun 2023 15:26:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: Brian.Inglis@Shaw.ca
Subject: Re: [PATCH v3 0/3] use wincap in format_proc_cpuinfo for user_shstk
To: cygwin-patches@cygwin.com
References: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
 <ZIy9JuA2wxH4i37A@calimero.vinschen.de>
Content-Language: en-CA
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <ZIy9JuA2wxH4i37A@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDdZsPXaAFrJnPRRO5TnjKPenhKzl1C9teP8Mp50Q2syQMenWBukvh0JAW/bQgrd7pdgYThLntQAYiQ8iigG5sZCeKMO1kKwpVaT4o2k9vZ3E3DrnUsV
 cnRUrXkvvi4CgblAop+ktW6uwpwoVznT2r2scviA/6iCsNhs6AY/tIr44hAUkdj2TbK0f8/uKr0Amf7cnMiKOSknqsO8SDt9iDA=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-06-16 13:51, Corinna Vinschen wrote:
> Hi Brian,
> 
> On Jun 16 11:17, Brian Inglis wrote:

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>> Fixes: 41fdb869f998 "fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>> In test for for AMD/Intel Control flow Enforcement Technology user mode
>> shadow stack support replace Windows version tests with test of wincap
>> member addition has_user_shstk with Windows version dependent value
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> Is that actually the final version?  It's still missing the commit
> message text explaining things and the "Fixes" line...
Hi Corinna,

Is more required above?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
