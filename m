Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.12])
 by sourceware.org (Postfix) with ESMTPS id 84003385700D
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 14:05:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 84003385700D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id ECL3kuh73ng7KECL5kWavF; Fri, 04 Sep 2020 08:05:15 -0600
X-Authority-Analysis: v=2.3 cv=ecemg4MH c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=wpI6bJtTXzhJjXI-IrUA:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
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
Message-ID: <79c66b27-1d0c-28b7-b5e1-6822b08faf9e@SystematicSw.ab.ca>
Date: Fri, 4 Sep 2020 08:05:13 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904124400.GQ4127@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNoHi4P9aSBB0JYVZYRgWTGD+GAt7iDFNTcyDAKIOPS+C5i9S+tLQmuHpqP5rqqOyVHBnzIytD4NxK2X6GfjLm7mbh+nfnbqZ7oCGYpobQjMFzdTXEWa
 7ur9Lnl/bBLc36GNom2LG+Gq6HZmoGcdNkMeuUuQEAU2xU0HMkOBLcRf1nNwOYoUui4ddpDjngyBxA==
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 04 Sep 2020 14:05:18 -0000

On 2020-09-04 06:44, Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Sep  4 18:21, Takashi Yano via Cygwin-patches wrote:
>> Hi Corinna,
>>
>> On Thu, 3 Sep 2020 19:59:12 +0200
>> Corinna Vinschen wrote:
>>> The only idea I had so far was, changing the way __set_charset_from_locale
>>> works from within _setlocale_r:
>>>
>>> We could add a Cygwin-specific function only fetching the codepage and
>>> call it unconditionally from _setlocale_r.  __set_charset_from_locale is
>>> called with a new parameter "codepage", so it doesn't have to fetch the
>>> CP by itself, but it's still only called from _setlocale_r if necessary.
>>>
>>> Would that be sufficient?  The CP conversion from 20127/ASCII to 65001/UTF8
>>> could be done at the point the codepage is actually required.
>>
>> I think I have found the answer to your request.
>> Patch attached. What do you think of this patch?
>>
>> Calling initial_setlocale() is necessary because
>> nl_langinfo() always returns "ANSI_X3.4-1968"
>> regardless locale setting if this is not called.
> 
> Well, this is correct.  Per POSIX, a standard-conformant application is
> running in the "C" locale unless it calls setlocale() explicitely.
> That's one reason Cygwin defaults to UTF-8 internally.  Everything,
> including the terminal, is supposed to default to UTF-8.  That's the
> most sane default, even if an application is not locale-aware.
> 
> So, to follow POSIX, initial_setlocale() is used to set up the
> environment and command line stuff and then, before calling the
> application's main, Cygwin calls _setlocale_r (_REENT, LC_CTYPE, "C");
> to reset the apps default locale to "C".  That's why nl_langinfo()
> returns "ANSI_X3.4-1968".
> 
> However, the initial_setlocale() call in dll_crt0_1 calls
> internal_setlocale(), and *that* function sets the conversion functions
> for the internal conversions.  What it *doesn't* do yet at the moment is
> to store the charset name itself or, better, the equivalent codepage.
> 
> If we change that, setup_locale can simply go away.  Below is a patch
> doing just that.  Can you please check if that works in your test
> scenarios?
> 
> However, there's something which worries me.  Why do we need or set the
> pseudo terminal codepage at all?  I see that you convert from MB charset
> to MB charset and then use the result in WriteFile to the connecting
> pipes.  Question is this: Why not just converting the strings via
> sys_mbstowcs to a UTF-16 string and then send that over the line, using
> WriteConsoleW for the final output to the console?  That would simplify
> this stuff quite a bit, wouldn't it?  After all, for writing UTF-16 to
> the console, we simply don't need to know or care for the console CP.

IIRC his locale was ja_JP.UTF-8 but he got English messages on CP 932!

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
