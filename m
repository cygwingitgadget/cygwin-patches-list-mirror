Return-Path: <cygwin-patches-return-7528-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18941 invoked by alias); 12 Oct 2011 20:45:04 -0000
Received: (qmail 18926 invoked by uid 22791); 12 Oct 2011 20:45:03 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f43.google.com (HELO mail-bw0-f43.google.com) (209.85.214.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 12 Oct 2011 20:44:47 +0000
Received: by bkas6 with SMTP id s6so644588bka.2        for <cygwin-patches@cygwin.com>; Wed, 12 Oct 2011 13:44:46 -0700 (PDT)
Received: by 10.204.137.214 with SMTP id x22mr397925bkt.71.1318452286262;        Wed, 12 Oct 2011 13:44:46 -0700 (PDT)
Received: from [192.168.0.50] (a91-153-79-231.elisa-laajakaista.fi. [91.153.79.231])        by mx.google.com with ESMTPS id r12sm1277566bkw.5.2011.10.12.13.44.44        (version=SSLv3 cipher=OTHER);        Wed, 12 Oct 2011 13:44:45 -0700 (PDT)
Message-ID: <4E95FC38.1090500@gmail.com>
Date: Wed, 12 Oct 2011 20:45:00 -0000
From: =?UTF-8?B?VGVlbXUgTsOkdGtpbm5pZW1p?= <tnatkinn@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:6.0.2) Gecko/20110901 Thunderbird/6.0.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add support for Windows 8, first step
References: <4E949B40.20402@gmail.com> <20111012082643.GA10913@calimero.vinschen.de>
In-Reply-To: <20111012082643.GA10913@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00018.txt.bz2

Hello Corinna,

On 12.10.2011 11:26, Corinna Vinschen wrote:

> First of all, we need a copyright assignment from you before we can
> accept non-trivial patches to Cygwin, see http://cygwin.com/contrib.html,
> the "Before you get started" section.

I am going to do that just in case I actually get something working (see 
below).

> Windows 8 will very likely support the FAST_CWD stuff, the problem is
> just to find out how to find the global pointer pointing to the current
> FAST_CWD structure, and then, if the FAST_CWD structure changed.

It does do that, the code looks almost the same as in Windows 7. There 
are some differences that I haven't figured out yet. But I might 
actually wait for a beta version of Windows 8 before going forward.

> Therefore I don't want to disable this message.  If you're interested
> to get rid of it, it would be most helpful trying to track down how to
> find the global FAST_CWD pointer in W8.

If I understood the code correctly f_cwd_ptr is the location of 
ntdll!RtlpCurDirRef and find_fast_cwd_pointer tries to find that 
location. For some reason I couldn't get breakpoints working when 
debugging cygwin1.dll so I did some disassembling and found the correct 
location for ntdll!RtlpCurDirRef in Windows 8 version of ntdll (wow64).

Any hints for debugging the Cygwin dll itself as find_fast_cwd runs once 
per session so it has been very difficult trying to get a working 
breakpoint.

Teemu
