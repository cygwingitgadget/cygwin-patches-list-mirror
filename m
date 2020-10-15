Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id 34FA4385780B
 for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2020 05:48:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 34FA4385780B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id Sw84kYR4ttdldSw85kxSik; Wed, 14 Oct 2020 23:48:45 -0600
X-Authority-Analysis: v=2.4 cv=INe8tijG c=1 sm=1 tr=0 ts=5f87e2bd
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=1JG7gZeFAAAA:20 a=M50a3OxpAAAA:8 a=bLS4dgGPAAAA:8
 a=6nZ-pI_sAAAA:20 a=epJJJZYCAAAA:20 a=94nOnFI1EgyDtX4ev68A:9
 a=QEXdDO2ut3YA:10 a=gdPjTkYc40LR4nVGQZjH:22 a=6MjYSiuBMAqTm5pKnR_V:22
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/6] Some AF_UNIX fixes
To: cygwin-patches@cygwin.com
References: <20201004164948.48649-1-kbrown@cornell.edu>
 <87bd83c6-5333-6287-01ce-d91ffec83244@cornell.edu>
 <20201013114933.GJ26704@calimero.vinschen.de>
 <ea3b1e6a-8857-cd1f-349d-6fc64c2d1b77@cornell.edu>
 <9d20509e-486b-ce79-0701-22557702b2b0@maxrnd.com>
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
Message-ID: <304c4d06-0ede-2e53-a638-1c5f54a4a342@SystematicSw.ab.ca>
Date: Wed, 14 Oct 2020 23:48:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <9d20509e-486b-ce79-0701-22557702b2b0@maxrnd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLs+0fHGGkdh18x0ALliAfJMMvLV2fm//b9JPAW0sUusfdq7O2YDT9ltXfvvndjgQLQmXLOaZjxWsuZ8m6GglTvLhd9kHmhffL4kvUEZQOWk1fE5i3Oa
 wWOl2IX4ieNxdSuKvV5jaTwHNG2JxuSBIXo/GiwIy/AJi0TGmCNAOAZcs/UaoxEUHtw7kEdHlvDFRRLgNHS0tgsN2DnogQa6nA8=
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4,
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
X-List-Received-Date: Thu, 15 Oct 2020 05:48:48 -0000

On 2020-10-14 22:19, Mark Geisert wrote:
> Ken Brown via Cygwin-patches wrote:
>> Are you aware of any test suite that I could run?  I've been using examples
>> from Kerrisk's book, because that's what I read to learn the basics of
>> sockets.  But those are just examples and are not meant to be comprehensive.
> 
> In ye olden days I used to use Stevens+Rago "Advanced Programming In The Unix
> Environment, 2nd ed.".  Chapter 17 covers UNIX domain sockets as advanced IPC.
> It's more examples but maybe they hit different corners of the playing field.  I
> don't know of a test suite or even a standalone program that exercises AF_UNIX.

The late author's Unix Network Programming has been updated by his co-authors to
Vol 1 3rd ed. and has some Unix domain AF_UNIX/AF_LOCAL content:

	https://github.com/unpbook/unpv13e.git

Cygwin utilities nc, nttcp, socat, ttcp are available, some with Unix domain
AF_UNIX/AF_LOCAL support and tests;

replaces netperf.org web site, HP copyright somewhat non-free, includes Unix
domain AF_UNIX//AF_LOCAL tests, but I never tried it under Cygwin:

	https://hewlettpackard.github.io/netperf/
	https://github.com/HewlettPackard/netperf.git

also came across a mention of:

	https://github.com/rigtorp/ipc-bench.git

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
