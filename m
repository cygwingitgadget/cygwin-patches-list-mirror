Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.12])
 by sourceware.org (Postfix) with ESMTPS id 474453858022
 for <cygwin-patches@cygwin.com>; Sat,  1 May 2021 00:37:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 474453858022
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([68.147.0.90]) by shaw.ca with ESMTP
 id cddEl7WDAycp5cddFlx9Bl; Fri, 30 Apr 2021 18:37:17 -0600
X-Authority-Analysis: v=2.4 cv=H864f8Ui c=1 sm=1 tr=0 ts=608ca2bd
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] format_proc_swaps: ensure space between fields for clarity
To: cygwin-patches@cygwin.com
References: <20210430131921.36002-1-Brian.Inglis@SystematicSW.ab.ca>
 <YIxVIjqTpV+5Sf7T@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Message-ID: <b23fbd54-67d6-61f2-44ef-43f3f8c88d86@SystematicSw.ab.ca>
Date: Fri, 30 Apr 2021 18:37:16 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIxVIjqTpV+5Sf7T@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLVGPVZuxrRm9DBD/mIJ1M7L0toa+7/xDYSKCqEwnfwA/+V60IVHZjNz2t6aCI8CDvKBfl+NDQWtFxS1ZNNxGb+DENmwZ31A4rXE9UWuQhC/sttCaTUR
 q+swlwkf2wz4UphF+5elfbHlrcbYW1AGuYXB/3l4dvyQiAXUpY+Qyu76XhyDsLiZzUWkFkvLudj6XpMmjnXDz88O8UIz5dc8+Jk=
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Sat, 01 May 2021 00:37:22 -0000

On 2021-04-30 13:06, Corinna Vinschen wrote:
> On Apr 30 07:19, Brian Inglis wrote:
>> page/swap space name >= 40 or size/used >= 8 leaves no space between fields;
>> ensure a space after name and add extra tabs after size and used fields;
>> output appears like Linux 5.8 after changes to mm/swapfile(swap_show);
>>
>> proc-swaps-space-before.log:
>> ==> /proc/swaps <==
>> Filename				Type		Size	Used	Priority
>> /mnt/c/pagefile.sys                     file            11567748292920  0
>> /mnt/d/pagefile.sys                     file            12582912205960  0
>>
>> proc-swaps-space-after.log:
>> ==> /proc/swaps <==
>> Filename				Type		Size		Used		Priority
>> /mnt/c/pagefile.sys			file		11567748	241024		0
>> /mnt/d/pagefile.sys			file		12582912	182928		0
>> ---
>>   winsup/cygwin/fhandler_proc.cc | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> Pushed.

Cheers!
Don't know how those numbers got bumped - perhaps during Windows 20H2 update? 
Must have been original 8GB when updating proc(5) in docs, or I'd have noticed.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
