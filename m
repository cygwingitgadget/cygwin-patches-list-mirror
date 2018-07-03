Return-Path: <cygwin-patches-return-9107-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38923 invoked by alias); 3 Jul 2018 17:12:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38913 invoked by uid 89); 3 Jul 2018 17:12:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=exhibits, behind, HContent-Transfer-Encoding:8bit
X-HELO: smtp-out6.electric.net
Received: from smtp-out6.electric.net (HELO smtp-out6.electric.net) (192.162.217.191) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Jul 2018 17:12:37 +0000
Received: from 1faOqx-0006wh-US by out6d.electric.net with emc1-ok (Exim 4.90_1)	(envelope-from <tim.adye@stfc.ac.uk>)	id 1faOqx-0006zT-VW	for cygwin-patches@cygwin.com; Tue, 03 Jul 2018 10:12:35 -0700
Received: by emcmailer; Tue, 03 Jul 2018 10:12:35 -0700
Received: from [130.246.236.11] (helo=exchsmtp.stfc.ac.uk)	by out6d.electric.net with esmtps (TLSv1:ECDHE-RSA-AES256-SHA:256)	(Exim 4.90_1)	(envelope-from <tim.adye@stfc.ac.uk>)	id 1faOqx-0006wh-US	for cygwin-patches@cygwin.com; Tue, 03 Jul 2018 10:12:35 -0700
Received: from [192.168.0.115] (86.0.81.86) by exchsmtp.stfc.ac.uk (130.246.236.18) with Microsoft SMTP Server (TLS) id 14.3.319.2; Tue, 3 Jul 2018 18:12:35 +0100
Subject: Re: [PATCH] Cygwin: Fixing the math behind rounding down ch.stacklimit to page size
From: Tim Adye <T.J.Adye@rl.ac.uk>
To: <cygwin-patches@cygwin.com>
References: <42f484e4-f091-dfa3-7c9d-825c76a22eb8@rl.ac.uk>
Message-ID: <e4a67fb2-229b-3b7e-cfc0-402f9ec940e5@rl.ac.uk>
Date: Tue, 03 Jul 2018 17:12:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <42f484e4-f091-dfa3-7c9d-825c76a22eb8@rl.ac.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EsetResult: clean, is OK
X-EsetId: 37303A29411E55616C7762
X-Outbound-IP: 130.246.236.11
X-Env-From: tim.adye@stfc.ac.uk
X-Proto: esmtps
X-Revdns: exchhub03.rl.ac.uk
X-TLS: TLSv1:ECDHE-RSA-AES256-SHA:256
X-Authenticated_ID:
X-PolicySMART: 3590380
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00002.txt.bz2

Hi Corinna, Sergejs,

Sorry, I should have followed up in this thread sooner. I can confirm 
that I tested the x86_64 cygwin1-20180607.dll.xz snapshot and it 
resolved my issue with bash with HitmanPro.

Thanks!
Tim.

On 05/06/2018 12:16, Tim Adye wrote:
> Hi Corinna,
>
> On 29 May, 18:44, Corinna Vinschen wrote:
>> Hi Sergejs,
>>
>> On May 25 17:43, Sergejs Lukanihins wrote:
>> > Hello,
>> > > Looks like ch.stacklimit wasn't being page-aligned correctly in
>> > fork.cc; you need to subtract 1 from page_size to do it correctly (see
>> > the attached patch).
>> > > As a result, this was causing stack-overflow exceptions whenever the
>> > stack needed to grow beyond the stacklimit value. When the stack grows
>> > beyond stacklimit value, Windows uses ntdll!_chkstk() function to
>> > check the stack and map in additional stack pages. However, it expects
>> > stacklimit to be page aligned, and the function does not work
>> > correctly if it is not (it triggers STATUS_STACK_OVERFLOW, even if
>> > there is enough stack space).
>> > > Normally, this was not causing any issues, as the stack never really
>> > needs to grow, but it was causing issues when AV software was being
>> > injected into the process (specifically, HitmanPro.Alert being
>> > injected into gitâs sh.exe process). Due to function hooks, it lead to
>> > a bigger callstack, and more stack space being required. Making the
>> > change specified in the patch actually resolves the issue.
>> > > I am providing my patches to the Cygwin sources under the 
>> 2-clause BSD license.
>>
>> Good catch!Â  Patch pushed.
> Thanks for adding this patch, and thanks to Sergejs for providing it!
>
> I think I may have encountered this problem (fork failures for some 
> constructs in bash, only when HitmanPro is enabled). Would it be 
> possible to make a new cygwin1.dll snapshot so I can test that? I 
> tested the current x86_64 snapshot, which was produced just hours 
> before this patch. That still exhibits the problem, but seems to work 
> fine otherwise.
>
> Thanks,
> Tim.
