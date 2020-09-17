Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 3828A3851C25
 for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2020 23:26:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3828A3851C25
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id J3HzkLgr4HxtDJ3I0kdLKM; Thu, 17 Sep 2020 17:26:08 -0600
X-Authority-Analysis: v=2.4 cv=Ce22WJnl c=1 sm=1 tr=0 ts=5f63f090
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=f3U24a_MXnVC_4C7sc4A:9 a=QEXdDO2ut3YA:10
 a=A90EPXCT5DQA:10 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc/faq-what.xml: FAQ 1.2 Windows versions
 supported
To: cygwin-patches@cygwin.com
References: <20200917182917.6116-1-Brian.Inglis@SystematicSW.ab.ca>
 <f5cadd54-84dc-9511-3cd0-c18ee94c9ebb@cornell.edu>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Autocrypt: addr=Brian.Inglis@SystematicSw.ab.ca; prefer-encrypt=mutual;
 keydata=
 mDMEXopx8xYJKwYBBAHaRw8BAQdAnCK0qv/xwUCCZQoA9BHRYpstERrspfT0NkUWQVuoePa0
 LkJyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFN5c3RlbWF0aWNTdy5hYi5jYT6IlgQTFggA
 PhYhBMM5/lbU970GBS2bZB62lxu92I8YBQJeinHzAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAAAoJEB62lxu92I8Y0ioBAI8xrggNxziAVmr+Xm6nnyjoujMqWcq3oEhlYGAO
 WacZAQDFtdDx2koSVSoOmfaOyRTbIWSf9/Cjai29060fsmdsDLg4BF6KcfMSCisGAQQBl1UB
 BQEBB0Awv8kHI2PaEgViDqzbnoe8B9KMHoBZLS92HdC7ZPh8HQMBCAeIfgQYFggAJhYhBMM5
 /lbU970GBS2bZB62lxu92I8YBQJeinHzAhsMBQkJZgGAAAoJEB62lxu92I8YZwUBAJw/74rF
 IyaSsGI7ewCdCy88Lce/kdwX7zGwid+f8NZ3AQC/ezTFFi5obXnyMxZJN464nPXiggtT9gN5
 RSyTY8X+AQ==
Organization: Systematic Software
Message-ID: <4089a1ef-d598-72ef-0349-08ea7efca015@SystematicSw.ab.ca>
Date: Thu, 17 Sep 2020 17:26:07 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f5cadd54-84dc-9511-3cd0-c18ee94c9ebb@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGjL0h9AukxxQt/18CmlIfjg6m1TKUw7RXI1fnMCMOlBijRECYH5bQQ7wZQw+ONeOpDM8HnDICQHon32HEaw/WB86tetmQHKaP25lYeVvYgJPPyEqkAO
 nuYYurNv832Le6mK1n/B0hxOyzr5fDg3lpLfa5vw9IoU+hKJqZocoagLZrEXzC9DBHf0lx6HAbhnVYzLFLYFl/XYUGmg7Yugkqo=
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 17 Sep 2020 23:26:11 -0000

On 2020-09-17 16:22, Ken Brown via Cygwin-patches wrote:
> On 9/17/2020 2:29 PM, Brian Inglis wrote:
>> Based on thread https://cygwin.com/pipermail/cygwin/2020-September/246318.html
>> enumerate Vista, 7, 8, 10 progression to be clear, and earliest server 2008
>> ---
>>   winsup/doc/faq-what.xml | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
>> index ea8496ccbc65..09747532c2e8 100644
>> --- a/winsup/doc/faq-what.xml
>> +++ b/winsup/doc/faq-what.xml
>> @@ -30,9 +30,9 @@ They can be used from one of the provided Unix shells like
>> bash, tcsh or zsh.
>>   <question><para>What versions of Windows are supported?</para></question>
>>   <answer>
>>   -<para>Cygwin can be expected to run on all modern, released versions of
>> Windows.
>> -State January 2016 this includes Windows Vista, Windows Server 2008 and all
>> -later versions of Windows up to Windows 10 and Windows Server 2016.
>> +<para>Cygwin can be expected to run on all modern, released versions of Windows,
>> +from Windows Vista, 7, 8, 10, Windows Server 2008, and all
>> +later versions of Windows.
>>   The 32 bit version of Cygwin also runs in the WOW64 32 bit environment on
>>   released 64 bit versions of Windows, the 64 bit version of course only on
>>   64 bit Windows.
> 
> Since this is something that changes over time, I don't think you should drop
> the date completely, though I see no reason to retain "January 2016".  What
> would you think of revising your patch so that the text says something like this:
> 
> "Cygwin can be expected to run on all modern, released versions of Windows.  As
> of September 2020 this includes Windows Vista, 7, 8, 8.1, and 10, Windows Server
> 2008, and all later versions of Windows Server."

No problem with adding 8.1 explicitly if deemed desirable.
See suggested wording - keeping similar wording the same problem recurs each
month - wanna change it monthly? ;^>
Would not want to limit later versions to just Server, and omitted versions
because now Server versions are like W10 updates e.g. WS version 2004, which is
stupid and confusing, as it looks 16 years old!

Damn you for making me think about this! ;^>
We now probably have to add exclusions for Windows S and also mention ARM under
Cygwin32.

Anyone out there interested in starting a Cygwin Windows ARM64 port (and
toolchain fixes for PE/COFF ARM64/AAarch64 machine type 0xAA64 if needed)?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
