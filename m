Return-Path: <cygwin-patches-return-8763-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85425 invoked by alias); 24 Apr 2017 23:55:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85399 invoked by uid 89); 24 Apr 2017 23:55:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=connector, ghost, HTo:U*cygwin-patches
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp1.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Apr 2017 23:55:36 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A37A89421	for <cygwin-patches@cygwin.com>; Mon, 24 Apr 2017 19:55:36 -0400 (EDT)
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 424A189420	for <cygwin-patches@cygwin.com>; Mon, 24 Apr 2017 19:55:36 -0400 (EDT)
Received: from [192.168.1.4] (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF2DD8941F	for <cygwin-patches@cygwin.com>; Mon, 24 Apr 2017 19:55:35 -0400 (EDT)
Subject: Re: [PATCH] Possibly correct fix to strace phantom process entry
To: cygwin-patches@cygwin.com
References: <20170424093754.536-1-daniel.santos@pobox.com> <20170424121922.GA5622@calimero.vinschen.de> <20170424153854.GA21872@calimero.vinschen.de>
From: Daniel Santos <daniel.santos@pobox.com>
Message-ID: <9c820100-2ca5-6716-9ee4-7803fdd82a52@pobox.com>
Date: Mon, 24 Apr 2017 23:55:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170424153854.GA21872@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 82904F42-2949-11E7-85AC-E680B56B9B0B-06139138!pb-smtp1.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00034.txt.bz2

On 04/24/2017 10:38 AM, Corinna Vinschen wrote:

> I'm going with my patch for now.  Mainly because I added some debug
> output to see if we need the Sleep loop at all.  Right now I don't see
> any situation which would qualify for this.
>
>
> Thanks,
> Corinna

Thanks for your help on this Corinna!

I'm inclined to agree about the sleep loop.  I have concerns about 
leaving these odd "ghost" process entries in and I have concerns about 
whacking them for all dynamic loads of cygwin1.dll. :)  The only cleaner 
solution that I can think of us to set an environment variable (or value 
in CYGWIN) to tell cygwin1.dll not to call pinfo::thisproc() in 
child_info_spawn::handle_spawn() -- that still feels like a bandaid.  (I 
suppose there's also using LoadLibraryEx and if there's some parameter 
we can pass to the DLL from there.)

Incidentally, when I debug strace with gdb the problem does away. Thus, 
I've been debugging this by littering the code with 
OutputDebugStringA()s, sometimes adding some Sleep delays, recompiling, 
exiting, restarting sshd, etc.  Is there an easier way to debug stuff 
like this?

Either way, I want to better understand how all of the cases of how 
cygwin1.dll is loaded and processes are inited.  Searching the code, I 
see that cygcheck also uses LoadLibrary, as well as 
cygwin::connector::connector (const char *dll) (although I can't tell 
what that is for).

I have to run, so I'll get back to this later.

Thanks!
Daniel
