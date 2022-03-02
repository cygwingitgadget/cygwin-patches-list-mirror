Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id 3711A3858D39
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 19:45:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3711A3858D39
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
 by cmsmtp with ESMTP
 id PLstn5Zl843SgPUuPnZpO2; Wed, 02 Mar 2022 19:45:13 +0000
Received: from [10.0.0.5] ([184.64.124.72]) by cmsmtp with ESMTP
 id PUuPnmyPfd7RfPUuPnC1vl; Wed, 02 Mar 2022 19:45:13 +0000
X-Authority-Analysis: v=2.4 cv=XrLphHJ9 c=1 sm=1 tr=0 ts=621fc949
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=IkcTkHD0fZMA:10 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
Message-ID: <b7a385c3-5480-9881-9feb-7fb49350c755@SystematicSw.ab.ca>
Date: Wed, 2 Mar 2022 12:45:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: cygwin-patches@cygwin.com
Subject: Re: Cygwin sysconf.cc
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20220225163959.48753-1-Brian.Inglis@SystematicSW.ab.ca>
 <20220225163959.48753-3-Brian.Inglis@SystematicSW.ab.ca>
 <Yhy6OKd/2o8VqIUH@calimero.vinschen.de>
 <d71a5b05-531f-8028-7b06-6ee466053f5f@SystematicSw.ab.ca>
 <2a8615a6-1214-ed7a-71f1-d191bcf2f3fe@SystematicSw.ab.ca>
 <Yh8p80lFZNuUYWTw@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <Yh8p80lFZNuUYWTw@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDO404T9m5Gj46ZZayuq1/CxIRblB9Ahvt5tCSDKUDePq7vC+xZU+8wn/b48Zyw3jz/fchsvN2gZesVDvmyLgy+IoRACJvelcifBnnRQHCOXMvBhIQO1
 NKYjDknVv6yEF8xvAe7ITdxmP7L3jyBcHnxafhvxASLnS9hz0ygqvi2tl0yYbAf8GThQOMRqD0ZSe3lWPkPjxLBtN1G+cTXMcFw=
X-Spam-Status: No, score=-1163.9 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 02 Mar 2022 19:45:15 -0000

On 2022-03-02 01:25, Corinna Vinschen wrote:
> Hi Brian,
> 
> On Mar  1 13:20, Brian Inglis wrote:
>> Interested in a patch for sysconf.cc to return:
>>
>>       _SC_TZNAME_MAX => TZNAME_MAX and
>> _SC_MONOTONIC_CLOCK => _POSIX_MONOTONIC_CLOCK?
> 
> not sure I understand the question.  Both are already implemented.
> 
>    $ getconf -a | egrep '(TZNAME_MAX|MONOTONIC_CLOCK)'
>    _POSIX_TZNAME_MAX                   6
>    TZNAME_MAX                          undefined
>    _POSIX_MONOTONIC_CLOCK              200809

Sorry, must have been looking at very *OLD* version online, as 
_SC_CLOCK_SELECTION and _SC_MONOTONIC_CLOCK were not defined.

Why did you not define _SC_TZNAME_MAX => _POSIX_TZNAME_MAX when you 
tweaked it?

My rereading of the man and POSIX pages leads me to believe that for all 
known values of _SC_... the entries now showing {nsup, {c:0}} should be 
{cons, {c:-1L}} supported but undefined, and only out of range values 
for the parameter should be treated as {nsup, {c:-1L}}?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
