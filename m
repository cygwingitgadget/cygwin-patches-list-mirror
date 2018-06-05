Return-Path: <cygwin-patches-return-9081-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79487 invoked by alias); 5 Jun 2018 11:16:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79472 invoked by uid 89); 5 Jun 2018 11:16:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, HContent-Transfer-Encoding:8bit
X-HELO: smtp-out4.electric.net
Received: from smtp-out4.electric.net (HELO smtp-out4.electric.net) (192.162.216.184) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jun 2018 11:16:45 +0000
Received: from 1fQ9xD-0005T9-TT by out4b.electric.net with emc1-ok (Exim 4.90_1)	(envelope-from <tim.adye@stfc.ac.uk>)	id 1fQ9xD-0005ZB-Vz	for cygwin-patches@cygwin.com; Tue, 05 Jun 2018 04:16:43 -0700
Received: by emcmailer; Tue, 05 Jun 2018 04:16:43 -0700
Received: from [130.246.236.11] (helo=exchsmtp.stfc.ac.uk)	by out4b.electric.net with esmtps (TLSv1:ECDHE-RSA-AES256-SHA:256)	(Exim 4.90_1)	(envelope-from <tim.adye@stfc.ac.uk>)	id 1fQ9xD-0005T9-TT	for cygwin-patches@cygwin.com; Tue, 05 Jun 2018 04:16:43 -0700
Received: from [130.246.41.110] (130.246.41.110) by exchsmtp.stfc.ac.uk (130.246.236.18) with Microsoft SMTP Server (TLS) id 14.3.319.2; Tue, 5 Jun 2018 12:16:42 +0100
From: Tim Adye <T.J.Adye@rl.ac.uk>
Subject: Re: [PATCH] Cygwin: Fixing the math behind rounding down ch.stacklimit to page size
To: <cygwin-patches@cygwin.com>
Message-ID: <42f484e4-f091-dfa3-7c9d-825c76a22eb8@rl.ac.uk>
Date: Tue, 05 Jun 2018 11:16:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EsetResult: clean, is OK
X-EsetId: 37303A29411E556163756A
X-Outbound-IP: 130.246.236.11
X-Env-From: tim.adye@stfc.ac.uk
X-Proto: esmtps
X-Revdns: exchhub03.rl.ac.uk
X-TLS: TLSv1:ECDHE-RSA-AES256-SHA:256
X-Authenticated_ID:
X-PolicySMART: 3590380
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00038.txt.bz2

Hi Corinna,

On 29 May, 18:44, Corinna Vinschen wrote:
> Hi Sergejs,
>
> On May 25 17:43, Sergejs Lukanihins wrote:
> > Hello,
> > 
> > Looks like ch.stacklimit wasn't being page-aligned correctly in
> > fork.cc; you need to subtract 1 from page_size to do it correctly (see
> > the attached patch).
> > 
> > As a result, this was causing stack-overflow exceptions whenever the
> > stack needed to grow beyond the stacklimit value. When the stack grows
> > beyond stacklimit value, Windows uses ntdll!_chkstk() function to
> > check the stack and map in additional stack pages. However, it expects
> > stacklimit to be page aligned, and the function does not work
> > correctly if it is not (it triggers STATUS_STACK_OVERFLOW, even if
> > there is enough stack space).
> > 
> > Normally, this was not causing any issues, as the stack never really
> > needs to grow, but it was causing issues when AV software was being
> > injected into the process (specifically, HitmanPro.Alert being
> > injected into gitâs sh.exe process). Due to function hooks, it lead to
> > a bigger callstack, and more stack space being required. Making the
> > change specified in the patch actually resolves the issue.
> > 
> > I am providing my patches to the Cygwin sources under the 2-clause BSD license.
>
> Good catch!  Patch pushed.
Thanks for adding this patch, and thanks to Sergejs for providing it!

I think I may have encountered this problem (fork failures for some 
constructs in bash, only when HitmanPro is enabled). Would it be 
possible to make a new cygwin1.dll snapshot so I can test that? I tested 
the current x86_64 snapshot, which was produced just hours before this 
patch. That still exhibits the problem, but seems to work fine otherwise.

Thanks,
Tim.
