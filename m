Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id C58623857C51
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 20:29:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C58623857C51
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id xcPjj9Y8Hng7KxcPkj9aO2; Mon, 20 Jul 2020 14:29:32 -0600
X-Authority-Analysis: v=2.3 cv=ecemg4MH c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=JZeu4sPTHj9YQVegERsA:9 a=ScRBEX30mr1d40Os:21
 a=-827Cxc37FkvmoCp:21 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
To: cygwin-patches@cygwin.com
References: <20200720133442.11432-1-kbrown@cornell.edu>
 <20200720142303.GJ16360@calimero.vinschen.de>
 <ceb31948-ec43-3bf1-a164-53b54828535f@cornell.edu>
 <3d3597af-7bb8-bc83-2522-9282566f80b8@cornell.edu>
 <d1ac7543-34a2-90c6-07b4-96d90142df34@cornell.edu>
 <20200720154139.GL16360@calimero.vinschen.de>
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
Message-ID: <c0269ad1-515e-dbf5-aae1-8d57b7ef39b2@SystematicSw.ab.ca>
Date: Mon, 20 Jul 2020 14:29:31 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720154139.GL16360@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPmyo0XFkb03ZWhbgSFAcPGsqW7QAXY58pRABhArtgXDlPbLyKn1VcxmldswJREeDjQoeqMMqJZx7jaETffQJIOTlNBMcy9MYFkwMZmW9rlIgMYgUNtS
 rWlcB3PO0X4MJNQrLuh4ROeHTbjfdY8+h/t1J/rCoOvsxM3dE9HeAsgdIH5v3kNzq7nK3LKwSOdxvg==
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 20 Jul 2020 20:29:35 -0000

On 2020-07-20 09:41, Corinna Vinschen wrote:
> Ultimately, I wonder if we really should keep all the 32 bit OS stuff
> in.  The number of real 32 bit systems (not WOW64) is dwindling fast.
> Keeping all the AT_ROUND_TO_PAGE stuff in just for what? 2%? of the
> systems is really not worth it, I guess.

A lot of older/smaller laptops, especially low cost budget models for lower
income groups including students, seniors and for developing countries, Windows
(Surface, etc.) tablets, and VMs supporting legacy systems and applications, run
Windows 32 bit, and MS still sells W10 and supports 32 bit for that reason,
except in OEM channels going forward from the 2020-04 release[1].
About 40% of W7 systems sold were 32 bit, with about 25% of systems still
running W7, so 10% of systems could still be 32-bit.

If you don't want to ask and perhaps reconsider the impact of your approach,
maybe give folks a heads up on the mailing list that the current release will be
the last to support 32 bit Windows?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]

[1] 2004 looks like it is 16 years old - delete software still using 2 digit
years for anything, as we will have many ambiguities until 2032!
