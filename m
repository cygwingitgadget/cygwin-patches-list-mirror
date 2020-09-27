Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id 47BB23894C07
 for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2020 18:04:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 47BB23894C07
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id Mb28klgU6LWW5Mb29kHnLb; Sun, 27 Sep 2020 12:04:25 -0600
X-Authority-Analysis: v=2.4 cv=Z5JSoFdA c=1 sm=1 tr=0 ts=5f70d429
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=iMpC6L0jGsNNbTZxuiUA:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Warning fixes for gcc 10.2
To: cygwin-patches@cygwin.com
References: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
 <1425a69b-d1a9-1479-4083-3839910352ee@cornell.edu>
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
Message-ID: <f5291780-3a7e-9112-8178-2ef0edafc006@SystematicSw.ab.ca>
Date: Sun, 27 Sep 2020 12:04:24 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1425a69b-d1a9-1479-4083-3839910352ee@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCLQGrcr8WEF/MuqZLpIFqzsmIuxhr1uvCAmKedzJJrgPR7Y6yd6vKG48ZE/MyS86agLwpW7WCUjlP3q3hPPHCOvmkMg+vkHd7r4PTuMe/BTnCOFhz87
 JmpMIUi432DqqeZGpGLVBfTEI5jd/5+WU8fVULWfok+XS6xIFeIbbiXzamcYukH3KYKMuvhGpNny0R9VLZsmBnTOBpZbI1oLt+w=
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00, BODY_8BITS,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT, NICE_REPLY_A,
 RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sun, 27 Sep 2020 18:04:28 -0000

On 2020-09-21 16:39, Ken Brown via Cygwin-patches wrote:
> On 9/21/2020 3:25 PM, Jon Turney wrote:
>> Jon Turney (3):
>>    Cygwin: avoid GCC 10 error with -Werror=parentheses
>>    Cygwin: avoid GCC 10 error with -Werror=narrowing
>>    Cygwin: avoid GCC 10 error with -Werror=narrowing
>>
>>   winsup/cygwin/fhandler_console.cc     | 4 ++--
>>   winsup/cygwin/fhandler_socket_inet.cc | 2 +-
>>   winsup/cygwin/ntdll.h                 | 2 +-
>>   winsup/cygwin/pseudo-reloc.cc         | 2 --
>>   4 files changed, 4 insertions(+), 6 deletions(-)
> 
> LGTM.
> 
> Ken

Same or better than what I came up with, before I came on here to post, and saw
you had already dealt with those! ++PUSH

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
