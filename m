Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id 3CBB6385840A
 for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2022 22:38:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3CBB6385840A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id 8rHNnpweWyr5H8rglnfE9n; Sat, 15 Jan 2022 22:38:23 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id 8rglnLhD8Nat48rglnDODu; Sat, 15 Jan 2022 22:38:23 +0000
X-Authority-Analysis: v=2.4 cv=e9cV9Il/ c=1 sm=1 tr=0 ts=61e34cdf
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=7vT8eNxyAAAA:8 a=w_pzkKWiAAAA:8 a=TImcKGuyeGIbufSLrCcA:9
 a=QEXdDO2ut3YA:10 a=Mzmg39azMnTNyelF985k:22 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <5331131e-7f49-1fef-4279-54b231df5022@SystematicSw.ab.ca>
Date: Sat, 15 Jan 2022 15:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH 2/7] Use matching format for NTSTATUS
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
 <20220114221018.43941-3-lavr@ncbi.nlm.nih.gov>
 <e79bbaae-e146-e4ad-b16b-0563c7768c33@SystematicSw.ab.ca>
 <DM8PR09MB7095F22ADD4B2CE55608084EA5559@DM8PR09MB7095.namprd09.prod.outlook.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <DM8PR09MB7095F22ADD4B2CE55608084EA5559@DM8PR09MB7095.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLUyuP692J9WmGQLtbCHypdszxRn0MbiVm1yCLHZMkTktMmPO/imuEv806l6GWRx7BQxLorGzHum6LwRDg5/9f6qPzHFAhmGVzwMI7O4+6rdjf8bNsOH
 CWeefd1xEFzDnRbIKsmVtSnTak5nuv6k+j7VWgB7jZwqHVhegWbsdw6Yuaqwr2LiB+xs0EoLU5Xc2QdEtj4R6IZf8WZLUEXBzeM=
X-Spam-Status: No, score=-1169.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Sat, 15 Jan 2022 22:38:25 -0000

Just the suggestion that as all standards support using %#08x to prefix 
with 0x (prefix output capitalization follows format letter 
capitalization) and would be preferable to hacking the text 0x onto the 
format %08X, doing all of the formatting work with the format flags.

My awareness and attitude to modifying output presentation using only 
formats was hardened by those not using date formats to modify date 
presentation during projects prior to Y2K!

[I want to scream and rant when I see imbeciles still producing output 
using meaningless 10/11/12 date formats, on systems and especially on 
web sites, where JavaScript supports perfectly nice internationalized 
formatting that shows dates and times in my zone and preferred formats!]

On 2022-01-15 12:04, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
> So?  With %X (capital X) the alternate form has the prefix 0X capital, too; and it's really hard to read.
> 
> IDK what is exactly your point that you are trying to make, is my patch somehow incorrect, or what?
> 
> Anton Lavrentiev
> Contractor NIH/NLM/NCBI
> 
>> -----Original Message-----
>> From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
>> Sent: Friday, January 14, 2022 11:38 PM
>> To: cygwin-patches@cygwin.com
>> Subject: [EXTERNAL] Re: [PATCH 2/7] Use matching format for NTSTATUS
>>
>> CAUTION: This email originated from outside of the organization. Do not click links or
>> open attachments unless you recognize the sender and are confident the content is safe.
>>
>>
>> See fprintf(3p) POSIX:
>> #   Specifies that the value is to be converted to an alternative form.
>> ...
>>       For x or X  conversion  specifiers, a non-zero result shall have 0x
>> (or 0X) prefixed to it.
>>
>> On 2022-01-14 15:10, Anton Lavrentiev via Cygwin-patches wrote:
>>> ---
>>>    winsup/cygwin/libc/minires-os-if.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
>>> index 666a008de..6e17de0b8 100644
>>> --- a/winsup/cygwin/libc/minires-os-if.c
>>> +++ b/winsup/cygwin/libc/minires-os-if.c
>>> @@ -359,7 +359,7 @@ static void get_registry_dns(res_state statp)
>>>      status = RtlCheckRegistryKey (RTL_REGISTRY_SERVICES, keyName);
>>>      if (!NT_SUCCESS (status))
>>>        {
>>> -      DPRINTF (statp->options & RES_DEBUG, "RtlCheckRegistryKey: status %p\n",
>>> +      DPRINTF (statp->options & RES_DEBUG, "RtlCheckRegistryKey: status 0x%08X\n",
>>            DPRINTF (statp->options & RES_DEBUG, "RtlCheckRegistryKey:
>> status %#08x\n",
>>>               status);
>>>          return;
>>>        }
>>> @@ -381,7 +381,7 @@ static void get_registry_dns(res_state statp)
>>>      if (!NT_SUCCESS (status))
>>>        {
>>>          DPRINTF (statp->options & RES_DEBUG,
>>> -            "RtlQueryRegistryValues: status %p\n", status);
>>> +            "RtlQueryRegistryValues: status 0x%08x\n", status);
>>                 "RtlQueryRegistryValues: status %#08x\n", status);
>>>          return;
>>>        }

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
