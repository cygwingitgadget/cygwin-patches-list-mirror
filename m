Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 3E91F393A053
 for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020 12:06:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3E91F393A053
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id uxDujH2MHFXePuxDvjbxUz; Mon, 13 Jul 2020 06:06:19 -0600
X-Authority-Analysis: v=2.3 cv=ePaIcEh1 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=JZeu4sPTHj9YQVegERsA:9 a=QEXdDO2ut3YA:10
 a=FhXMovWKs60A:10 a=ylEQVlorgLYA:10 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Clarify FAQ 1.5 What version of Cygwin is this, anyway?
To: cygwin-patches@cygwin.com
References: <20200710173450.46857-1-Brian.Inglis@SystematicSW.ab.ca>
 <20200713070433.GH514059@calimero.vinschen.de>
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
Message-ID: <ba6d154a-679f-a121-f151-dd84d29ba116@SystematicSw.ab.ca>
Date: Mon, 13 Jul 2020 06:06:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713070433.GH514059@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCnraXRJOtKXc7LzV6oYUJp934PT9MHlX9SOnScAo8mY0cPYMNr0b57zyAuQciii4Q0p3/9KReircEiYbnHoweD0lc7e/TnvwJWek20aiimkqzCOqX8S
 pfZUqOQv/VElEUQGfYCpOGPDKwCPAUtXr9JJW08lvJbLtUv2X3MyrppOfN3Lgjn0R3goLfj2B3pc1A==
X-Spam-Status: No, score=-13.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 13 Jul 2020 12:06:23 -0000

On 2020-07-13 01:04, Corinna Vinschen wrote:
> On Jul 10 11:34, Brian Inglis wrote:
>> Patch to:
>> 	https://cygwin.com/git/?p=cygwin-htdocs.git;f=faq/faq.html;hb=HEAD
>> as a result of thread:
>> 	https://cygwin.com/pipermail/cygwin/2020-July/245442.html
>> and comments:
>> 	https://cygwin.com/pipermail/cygwin-patches/2020q3/010331.html
>>
>> Relate Cygwin DLL to Unix kernel,
>> add required options to command examples,
>> differentiate Unix and Cygwin commands;
>> mention that the cygwin package contains the DLL.
>> ---
>>  faq/faq.html | 49 +++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 33 insertions(+), 16 deletions(-)
>>
>> diff --git a/faq/faq.html b/faq/faq.html
>> index 1f2686c6..8659db5d 100644
>> --- a/faq/faq.html
>> +++ b/faq/faq.html
> 
> Huh?  This file doesn't exist in the repo.  The path is not relative to
> the repo root, and the file is called faq-what.xml.  Can you please
> check this again?

See top. So does:

	https://cygwin.com/git/?p=cygwin-htdocs.git;f=faq/faq.html

get generated from:

https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/doc/faq-what.xml

which is where I should be making FAQ patches?
I was looking around for FAQ files and this connection between cygwin-doc and
cygwin-htdocs was not obvious.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
