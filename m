Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id C9A1D3858D38
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 23:30:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C9A1D3858D38
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id u2TTjSUCsYYpxu2TVjERaL; Fri, 10 Jul 2020 17:30:37 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=gwMg6M9y6T5EFgRA8E4A:9 a=QEXdDO2ut3YA:10
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] COMMIT_MSG - cygport patches
References: <20200710230432.57869-1-Brian.Inglis@SystematicSW.ab.ca>
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
To: Cygwin Patches <cygwin-patches@cygwin.com>
Message-ID: <1f6ba88b-ccc9-5df5-ecdf-c9e9204ae92e@SystematicSw.ab.ca>
Date: Fri, 10 Jul 2020 17:30:35 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710230432.57869-1-Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC3VPq3JM2JmLkuxWuBVs1JrfiTDcewXDiLLI50qvRh1pzryyyhAitlIT6tLfkBKrBzbT45iWBeyTczBXFo/SGgnaIsBjGHGJax3+koCgJ0qc8OT+imV
 F9QTb2F0/LkmGgpzeyEirP2qZQzqG0V6t7CYOInVHdqdlGBZdzMbKu9h29n08h63tYLzmq+ca8vSSg==
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_BL,
 RCVD_IN_MSPIKE_L3, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Fri, 10 Jul 2020 23:30:39 -0000

Sorry,
These cygport patches were expected to allow edits as usual but just went!
Minor "unrelated" ~/.gitconfig changes seem to have removed confirmation.

This should have been an -F COMMIT_MSG but I typed -m COMMIT_MSG.

The next fixes a cygport announce SMTP server issue using code from git send-email.

The last fixes a cygport install infinite loop when there is a symlink along the
path to DEST host prefix.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
