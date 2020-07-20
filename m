Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id 8979A3857C73
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 23:14:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8979A3857C73
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id xez1jJVML62brxez2jRQNb; Mon, 20 Jul 2020 17:14:09 -0600
X-Authority-Analysis: v=2.3 cv=LKf9vKe9 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=JZeu4sPTHj9YQVegERsA:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
To: cygwin-patches@cygwin.com
References: <20200720133442.11432-1-kbrown@cornell.edu>
 <20200720142303.GJ16360@calimero.vinschen.de>
 <ceb31948-ec43-3bf1-a164-53b54828535f@cornell.edu>
 <3d3597af-7bb8-bc83-2522-9282566f80b8@cornell.edu>
 <d1ac7543-34a2-90c6-07b4-96d90142df34@cornell.edu>
 <20200720154139.GL16360@calimero.vinschen.de>
 <c0269ad1-515e-dbf5-aae1-8d57b7ef39b2@SystematicSw.ab.ca>
 <f85c42c6-18ce-720d-328a-352ca7cb78fe@cornell.edu>
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
Message-ID: <eef0b033-2ecc-b803-e9b4-4c9c9d1812b6@SystematicSw.ab.ca>
Date: Mon, 20 Jul 2020 17:14:07 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f85c42c6-18ce-720d-328a-352ca7cb78fe@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGBeuxLPsheKuEf9yTUtrkTCvVnlFi3YIa9ZcTOkTxUYKQns6OZnblPQ1jMMQJjqA936BXpG6ABerenWO621EZlQCe89+jkhkQdi8vG8nxX7lREhtz1A
 qCz6ZGXXEAYRsjliMZWAWVlq1EhCgH6Xqm9tykQiQ+Iz/+ObLw2Ly00jiTUKnQ3puGJyalwqdebBfA==
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Mon, 20 Jul 2020 23:14:12 -0000

On 2020-07-20 15:08, Ken Brown via Cygwin-patches wrote:
> On 7/20/2020 4:29 PM, Brian Inglis wrote:
>> On 2020-07-20 09:41, Corinna Vinschen wrote:
>>> Ultimately, I wonder if we really should keep all the 32 bit OS stuff
>>> in.  The number of real 32 bit systems (not WOW64) is dwindling fast.
>>> Keeping all the AT_ROUND_TO_PAGE stuff in just for what? 2%? of the
>>> systems is really not worth it, I guess.
> [...]
>> If you don't want to ask and perhaps reconsider the impact of your approach,
>> maybe give folks a heads up on the mailing list that the current release will be
>> the last to support 32 bit Windows?
> 
> Corinna didn't propose dropping support for 32 bit Windows.  She proposed
> dropping a feature that works *only* on 32 bit Windows.

Sorry if I misunderstood, but it sounded more drastic than that, and required
for the code to work compatibly on Windows 32 bit, rather than supporting a
different feature that only worked on Windows 32 bit, as anything
non-Linux/BSD/POSIX can be considered non-essential if support is not
widespread, nor essential for critical packages.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
