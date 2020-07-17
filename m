Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.9])
 by sourceware.org (Postfix) with ESMTPS id 1CBA539A0C10
 for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2020 12:50:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1CBA539A0C10
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id wPpEjQdTZng7KwPpFjztcT; Fri, 17 Jul 2020 06:50:53 -0600
X-Authority-Analysis: v=2.3 cv=ecemg4MH c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=jChkm-x5hCMFubTIiR0A:9 a=QEXdDO2ut3YA:10
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: FAQ Proposed Updates Summary and Preview Diff
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <5dd6e092-3963-a47e-dda5-160d15b70ca0@SystematicSw.ab.ca>
 <20200717111718.GF3784@calimero.vinschen.de>
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
Message-ID: <01553db3-9d39-ba0e-d43d-50d612e76fa9@SystematicSw.ab.ca>
Date: Fri, 17 Jul 2020 06:50:52 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717111718.GF3784@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHz+mXr8LdnCctylta/jyywFxAqJrH1jNT1m7pA9I0s4lHuYnkgZvbwWGtA0xPvh/U7eqc+OuXAbTd9Co2ZpMfmsnFADa9FuBYD+yWuf8minEV9XhZsQ
 +4H3t/CUnEno4cl9XakHWofaDuk9a/prgznhKu8s0Mhltildlkf0YsaCcd11dRRlEJiqDMl0fojvmg==
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 17 Jul 2020 12:50:56 -0000

On 2020-07-17 05:17, Corinna Vinschen wrote:
> On Jul 16 21:35, Brian Inglis wrote:
>> Just want to get feedback on how these FAQ changes should be packaged as patches
>> (separate, series, single) and whether some of the changes should not be applied
>> at all.

What about how they should be committed - by file or all in one, and submitted -
separately by file, or as a FAQ patch series?

>> Summary
>>
>> General:
>>
>> change setup references to use the Cygwin Setup program;
>> change Win32 references to Windows;
> 
> Please, no.  At least not where Win32 refers to the API.  While this is
> called "Windows API" these days, the word Windows alone doesn't really
> cut it.  At leats use "Windows API" then, or IMHO even better, use the
> informal "WinAPI" abbreviation.

Good idea - will check and change depending on context.

>> reword net release or distribution references;
> 
> Uhm... example?  I'm not sure what you mean here.

They look like original wording from when there were Cygnus/Red Hat releases and
net releases: the distinction has been moot and the phrase not used in these
lists for years.

>> emphasize 64-bit Cygwin and setup-x86_64 over 32-bit;
>> change see <ulink/> to place links around available wording;
>> change <literal> for <filename> or <command> where appropriate;
>> change bash .{ext1,ext2} usage to .ext1/.ext2;
> 
> Using comma separated lists within curly braces is the offical
> shell way to express alternatives:
> 
>   $ echo a.{b,c}
>   a.b a.c
> 
> Please keep them as is.

These usages are in descriptions, not in shell command contexts, and not used in
most (POSIX) scripts, so many users will not recognize this convention, not even
those who do some scripts but are inexperienced.
My fingers are trained in their use, but would use them in text only to other
developers. ;^>

>> trim trailing spaces highlighted by git diff.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
