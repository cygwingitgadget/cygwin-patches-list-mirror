Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.9])
 by sourceware.org (Postfix) with ESMTPS id 991903851C21
 for <cygwin-patches@cygwin.com>; Tue,  2 Feb 2021 18:02:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 991903851C21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id 700flNthJ2SWT700glAVcZ; Tue, 02 Feb 2021 11:02:42 -0700
X-Authority-Analysis: v=2.4 cv=fdJod2cF c=1 sm=1 tr=0 ts=601993c2
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] CYGWIN: Fix resolver debugging output
To: cygwin-patches@cygwin.com
References: <20210129192903.939-1-lavr@ncbi.nlm.nih.gov>
 <20210201103445.GK375565@calimero.vinschen.de>
 <DM8PR09MB7095CE3228ED706E16BA0F16A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
 <20210201150209.GP375565@calimero.vinschen.de>
 <DM8PR09MB70952B27AFDF02848ABB50C7A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
 <20210201190215.GA4251@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Message-ID: <9f964f14-4e8e-b36f-fa73-777c567f2f3b@SystematicSw.ab.ca>
Date: Tue, 2 Feb 2021 11:02:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201190215.GA4251@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGbRid1Ruzqg09QFmySNdJ9B5CyCotxnzwXnwTkMeJOcKbOI6vWC+5vmLLnDQd41lbFwA6ZjtsNw4ndPNI0Rh3fnoL5ar4qUHqeWcW0ZA6ir2oeIwRyW
 ywIQBT4/YDonM9vHAdPqXCwvi3arD8RAzBypheOHx0r2PH+lS327ft1affZEHcSdbAcpnDXfrkPE1wGF66EyItsZ01cJEfDBXEo=
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Tue, 02 Feb 2021 18:02:45 -0000

On 2021-02-01 12:02, Corinna Vinschen via Cygwin-patches wrote:
> On Feb  1 15:46, Lavrentiev, Anton (NIH/NLM/NCBI) [C] via Cygwin-patches wrote:
>>> Except, the value has no meaning for ipv6.
>>
>> It'll print all 0's :-)  But: minires does not make use of the _ext field.
>> It does use the conventional nsaddr_list (which is IPv4), but only if
>> Windows native DNS API is not used: "osquery"(aka use_os)=0. >>
>> For debugging purposes, that is enough and very convenient (yet the output 
>> needed some tune-up, which I suggested in my patch).

> Ok.

>> But for practical purposes, only Windows API should be used in regular 
>> applications (which is the default, anyways, since /etc/resolv.conf is not
>> routinely provided, so "osquery=1" implicitly).
> Yeah, I think so, too.  Ideally we should have stripped out all code
> providing non-Windows means (i. e., /etc/resolv.conf support) back when
> this code was folded into Cygwin.  It just doesn't make sense, at least
> not by default.

I've been generating /etc/resolv.conf -> /run/resolvconf/resolv.conf for years 
in an /etc/postinstall/0p_...dash script from ipconfig /all output (not aware of 
a Cygwin source to get this interface info) also run at startup, with some 
customizations, and not noticed any issues so far. Should I be wary in future?

>> I'm not sure if improvements to use _ext by the minires own code would be 
>> any beneficial.
>> 
>> Having said that, AAAA replies should be made understood by the 
>> minires-if-os shim code (and I can provide a patch for that, too).

> That would be great!

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
