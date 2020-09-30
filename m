Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 6A09A3857C6B
 for <cygwin-patches@cygwin.com>; Wed, 30 Sep 2020 03:30:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6A09A3857C6B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id NSolkpbYzHxtDNSomkHADN; Tue, 29 Sep 2020 21:30:13 -0600
X-Authority-Analysis: v=2.4 cv=Ce22WJnl c=1 sm=1 tr=0 ts=5f73fbc5
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=iMpC6L0jGsNNbTZxuiUA:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Warning fixes for gcc 10.2
To: cygwin-patches@cygwin.com
References: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
 <1425a69b-d1a9-1479-4083-3839910352ee@cornell.edu>
 <f5291780-3a7e-9112-8178-2ef0edafc006@SystematicSw.ab.ca>
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
Message-ID: <1c0de813-d574-1b86-1b70-258e736c0f57@SystematicSw.ab.ca>
Date: Tue, 29 Sep 2020 21:30:11 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f5291780-3a7e-9112-8178-2ef0edafc006@SystematicSw.ab.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLCs+dcxj9/IyyFSiB863HvG9QdXSHauu2OBaMQKusTO+66CkQBLymTOhOgq3PvHIFaIHKhdDb0e5abF7Ej68oZ0niwmCT8tB1Qt6BihAs8uuxSWAj3z
 e1aBYODpG1C9wP3weYMQ9IuR9jV7HBGDRNd7TuefDEVVjGniNxzoNW98xKd1dd+9kviDXKLLDhP81/UJVNgnS4lag9C3yC2TJJY=
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT, NICE_REPLY_A, RCVD_IN_DNSWL_LOW,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 30 Sep 2020 03:30:15 -0000

After pulling the error fixes, rm **/config.cache, and re-making, I got some
funny results while rebuilding cygwin32 only.
Some previously built object files were no longer recognized as such, and halted
the build; even file showed them as generic "data".
This persisted even after rm **/config.cache, plus those object files not
showing as "Intel 80386 COFF object file", and redoing ./configure && make.
Only after doing "make distclean", rm **/config.cache, ./configure && make, did
the build complete normally.
Any ideas what the issue might have been, and best practices for rebuilding
cygwin after tool updates?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
