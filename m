Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 784703857005
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 07:33:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 784703857005
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id BCPokXapw695cBCPqkP3Ks; Thu, 27 Aug 2020 01:33:46 -0600
X-Authority-Analysis: v=2.3 cv=fZA2N3YF c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=I0CVDw5ZAAAA:8 a=nErxp0C4fr8eABQ6ILQA:9 a=QEXdDO2ut3YA:10
 a=YdXdGVBxRxTCRzIkH2Jn:22
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] winsup/doc/faq-api.xml(faq.api.timezone): explain
 time zone updates
To: cygwin-patches@cygwin.com
References: <20200825125715.48238-1-Brian.Inglis@SystematicSW.ab.ca>
 <20200825125715.48238-4-Brian.Inglis@SystematicSW.ab.ca>
 <20200826081622.GM3272@calimero.vinschen.de>
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
Message-ID: <763dde2c-9f9d-7e88-c6d6-5900bb08b8a4@SystematicSw.ab.ca>
Date: Thu, 27 Aug 2020 01:33:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826081622.GM3272@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIK9DIhRqB2u7jAvm8UU8LWMo4jPPRwGVtSqszB7GNABvPP5MrW5FTwAYRmVrWIkWfsUKWCDpeItkQdgxpgQCNTr8Jbc1uSOjUEA5h3ZPFmNF6TaL2UC
 v657CcL0/C73dy7k9uJcZmQWdlC9ONWjusplCAF9hqLwQvswK62/lre0QSNKJ1UNXyCNqFMIrToWiA==
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Thu, 27 Aug 2020 07:33:48 -0000

On 2020-08-26 02:16, Corinna Vinschen wrote:
> On Aug 25 06:57, Brian Inglis wrote:
>> based on material from tz@IANA.org mailing list sources
>> ---
>>  winsup/doc/faq-api.xml | 29 +++++++++++++++++++++++++----
>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/winsup/doc/faq-api.xml b/winsup/doc/faq-api.xml
>> index 829e4d7febd8..365e301555a5 100644
>> --- a/winsup/doc/faq-api.xml
>> +++ b/winsup/doc/faq-api.xml
>> @@ -385,13 +385,34 @@ Cygwin version number details, check out the
>>  </answer></qandaentry>
>>  
>>  <qandaentry id="faq.api.timezone">
>> -<question><para>Why isn't timezone set correctly?</para></question>
>> +<question><para>Why isn't time zone set correctly?</para></question>
>>  <answer>
>>  
>> -<para><emphasis role='bold'>(Please note: This section has not yet been updated for the latest net release.)</emphasis>
>> -</para>
>> -<para>Did you explicitly call tzset() before checking the value of timezone?
>> +<para>Did you explicitly call tzset() before checking the value of time zone?
>>  If not, you must do so.
>> +Time zone settings are updated by changes to the tzdata package included in all
>> +Cygwin installations.
> 
> Shouldn't a new paragraph start at this point?
> 
> Actually, maybe this could be changed a bit more.  The question might be
> better called "Why isn't my (or the) time zone set correctly?" and the
> order inside the FAQ seems a bit upside down now.  Starting with a reply
> only affecting developers with self-written applications is rather weird
> given the general discussion only follows afterwards.
> 
> The discussion on how time zones are updated in real life might be the
> better start, then how to rectify local settings by running Setup, and
> only then implications for developers.
> 
> Make sense?
> 
> Thanks, I pushed the other two patches in the meantime.

Thanks, changed as suggested: have a look and feel free to tweak minor nits or
bounce back if more issues.

Getting better with git due to this intense pressure! ;^>
Still easier to hack patches and reapply than figure out how to mess around with
them using git.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
