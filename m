Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.12])
 by sourceware.org (Postfix) with ESMTPS id 785A9385783A
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 04:53:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 785A9385783A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id FVcpkDYQ662brFVcqkublo; Mon, 07 Sep 2020 22:53:01 -0600
X-Authority-Analysis: v=2.3 cv=LKf9vKe9 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=ObcLf_uJAAAA:20 a=Ed7FdIT4gc43trk-okQA:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
To: cygwin-patches@cygwin.com
References: <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200907082633.GC4127@calimero.vinschen.de>
 <20200907183659.5150b2a8f296e4df13b1df1c@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009072252550.56@tvgsbejvaqbjf.bet>
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
Message-ID: <0230057a-9d5f-c442-df94-203cd0232d29@SystematicSw.ab.ca>
Date: Mon, 7 Sep 2020 22:52:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2009072252550.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIho/crREun5myX/nOZLq2S9krXNKs7vXOP95YI23IeEZk8WHCa1mwhf8wSTTpvDXb6xPzELLz2q8jUPjjY32t8Ovj15Mq02lCFQK9KTsH0sSbE89nCz
 Rzz/tfDhtzhTleEDOsdZCsUF6Oh/24n+j14SnbC5VEfP17+lLw+DngH66xotfdlrsg/4ADR91PYtPQ==
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Tue, 08 Sep 2020 04:53:04 -0000

On 2020-09-07 15:08, Johannes Schindelin wrote:
> On Mon, 7 Sep 2020, Takashi Yano via Cygwin-patches wrote:
>> On Mon, 7 Sep 2020 10:26:33 +0200
>> Corinna Vinschen wrote:
>>> Hi Takashi,
>>> On Sep  5 17:43, Takashi Yano via Cygwin-patches wrote:
>>>> On Fri, 4 Sep 2020 21:22:35 +0200
>>>> Corinna Vinschen wrote:
>>>>
>>>>> Btw., the main loop in
>>>>> fhandler_pty_master::pty_master_fwd_thread() calls
>>>>>
>>>>>   char *buf = convert_mb_str (cygheap->locale.term_code_page,
>>>>>                               &nlen, CP_UTF8, ptr, wlen);
>>>>>                                      ^^^^^^^
>>>>>   [...]
>>>>>   WriteFile (to_master_cyg, ...
>>>>>
>>>>> But then, after the code breaks from that loop, it calls
>>>>>
>>>>>   char *buf = convert_mb_str (cygheap->locale.term_code_page, &nlen,
>>>>>                               GetConsoleOutputCP (), ptr, wlen);
>>>>>                               ^^^^^^^^^^^^^^^^^^^^^
>>>>>   [...]
>>>>>   process_opost_output (to_master_cyg, ...
>>>>>
>>>>> process_opost_output then calls WriteFile on that to_master_cyg handle,
>>>>> just like the WriteFile call above.
>>>>>
>>>>> Is that really correct?  Shouldn't the second invocation use CP_UTF8 as
>>>>> well?
>>>>
>>>> That is correct. The first conversion is for the case that pseudo
>>>> console is enabled, and the second one is for the case that pseudo
>>>> console is disabled.
>>>>
>>>> Pseudo console converts charset from console code page to UTF-8.
>>>> Therefore, data read from from_slave is always UTF-8 when pseudo
>>>> console is enabled. Moreover, OPOST processing is done in pseudo
>>>> console, so write data simply by WriteFile() is enough.
>>>>
>>>> If pseudo console is disabled, cmd.exe and so on uses console
>>>> code page, so the code page of data read from from_slave is
>>>> GetConsoleOutputCP(). In this case, OPOST processing is necessary.
>>>
>>> This is really confusing me.  We never set the console codepage in the
>>> old pty code before, it was just pipes transmitting bytes.  Why do we
>>> suddenly have to handle native apps running in a console in this case?!?
>>
>> This is actually not related to pseudo console. In Japanese environment,
>> cmd.exe output CP932 string by default. This caused gabled output in old
>> cygwin such as 3.0.7. The code for the case that pseudo console is
>> disabled is to fix this.
> 
> It is related to Pseudo Console insofar as it was slipped in as part of
> the Pseudo Console patches.
> 
> And what Takashi reports as a bug fix is the underlying reason for the
> tickets in MSYS2 (and elsewhere) that I mentioned.
> 
> In fact, I even suggested in
> https://github.com/msys2/MSYS2-packages/issues/1974#issuecomment-685475967
> to revert that change.
> 
> What Takashi describes as "correct behavior" unfortunately seems not to be
> very common in practice, which is why I contend that from the users' point
> of view, it could not matter less whether the console applications are
> "correct" or not. From the point of view of users who have their `LANG`
> set to something like `en_US.UTF-8`, the encoding was correct before, and
> now it is no longer correct. And _that_ is the correctness users actually
> care about.

But also for users running locales and localization using non-Latin scripts, it
is important that messages be generated in languages they understand and output
in characters they can read.
It has been for some years (at least since the EU was formed in 1993) inadequate
and erroneous to support only en_US.ASCII.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
