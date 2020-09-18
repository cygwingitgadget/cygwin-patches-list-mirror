Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id 26F933850426
 for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2020 15:29:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 26F933850426
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id JIKTkQA1bHxtDJIKVkesTU; Fri, 18 Sep 2020 09:29:43 -0600
X-Authority-Analysis: v=2.4 cv=Ce22WJnl c=1 sm=1 tr=0 ts=5f64d267
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=jChkm-x5hCMFubTIiR0A:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] winsup/doc/faq-what.xml: FAQ 1.2 Windows versions
 supported
To: cygwin-patches@cygwin.com
References: <20200918025335.43795-1-Brian.Inglis@SystematicSW.ab.ca>
 <ea6c7db5-5c8c-6e5c-d9be-6ffa50f2d236@cornell.edu>
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
Message-ID: <b347ae40-0eaf-8fd6-9698-f3a04f5640ff@SystematicSw.ab.ca>
Date: Fri, 18 Sep 2020 09:29:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ea6c7db5-5c8c-6e5c-d9be-6ffa50f2d236@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfG2z6WvMoj82za9AnnKs0rbV6yOOF4TOvv6Z5IqzLRJx6jMG25EvWMgCUdrG5KJudi/zLqMK2O8i4+uaOXtXuo3u5ZHFE8I46zHYKFOYc32mFOPOt75z
 fTsPcRFoAJOLKTsqdbV3tNwCa/C1ICrDwAOVsu0H3k3P52Y2Uz/pfzazbc+l3IlebJ/d1r7h0Zfo6oA7GCuvImT2oIMEzOlNt1s=
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 18 Sep 2020 15:29:45 -0000

On 2020-09-18 05:59, Ken Brown via Cygwin-patches wrote:
> On 9/17/2020 10:53 PM, Brian Inglis wrote:
>> enumerate Vista, 7, 8, 10 progression to be clear, and earliest server 2008;
>> add 8.1, exclude S mode, add Cygwin32 on ARM, specify 64 bit only AMD/Intel
>> ---
>>   winsup/doc/faq-what.xml | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
>> index ea8496ccbc65..77ba1c5fdd9c 100644
>> --- a/winsup/doc/faq-what.xml
>> +++ b/winsup/doc/faq-what.xml
>> @@ -30,12 +30,12 @@ They can be used from one of the provided Unix shells like
>> bash, tcsh or zsh.
>>   <question><para>What versions of Windows are supported?</para></question>
>>   <answer>
>>   -<para>Cygwin can be expected to run on all modern, released versions of
>> Windows.
>> -State January 2016 this includes Windows Vista, Windows Server 2008 and all
>> -later versions of Windows up to Windows 10 and Windows Server 2016.
>> +<para>Cygwin can be expected to run on all modern, released versions of Windows,
>> +from Windows Vista, 7, 8, 8.1, 10, Windows Server 2008 and all
>> +later versions of Windows, except Windows S mode due to its limitations.
>>   The 32 bit version of Cygwin also runs in the WOW64 32 bit environment on
>> -released 64 bit versions of Windows, the 64 bit version of course only on
>> -64 bit Windows.
>> +released 64 bit versions of Windows including ARM PCs,
>> +the 64 bit version of course only on 64 bit AMD/Intel compatible PCs.
>>   </para>
>>   <para>Keep in mind that Cygwin can only do as much as the underlying OS
>>   supports.  Because of this, Cygwin will behave differently, and
> 
> Pushed.  Thanks.
> 
> Ken

Thanks Ken,
Do you have to run something to regen the docs, FAQ.html, and push to the web
site, or does it run periodically, so I can follow up to the OP and get feed
back from the responder?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
