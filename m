Return-Path: <cygwin-patches-return-6593-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18828 invoked by alias); 10 Aug 2009 16:23:40 -0000
Received: (qmail 18817 invoked by uid 22791); 10 Aug 2009 16:23:39 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.148)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 10 Aug 2009 16:23:33 +0000
Received: by ey-out-1920.google.com with SMTP id 13so704803eye.20         for <cygwin-patches@cygwin.com>; Mon, 10 Aug 2009 09:23:30 -0700 (PDT)
Received: by 10.210.110.2 with SMTP id i2mr5190362ebc.8.1249921409958;         Mon, 10 Aug 2009 09:23:29 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm11652937eyh.16.2009.08.10.09.23.28         (version=SSLv3 cipher=RC4-MD5);         Mon, 10 Aug 2009 09:23:28 -0700 (PDT)
Message-ID: <4A804CA6.902@gmail.com>
Date: Mon, 10 Aug 2009 16:23:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCHes] Misc aliasing fixes for building DLL with gcc-4.5.0
References: <4A7F8FF5.5060701@gmail.com>  <20090810040452.GB610@ednor.casa.cgf.cx>  <4A7FA1E0.7070209@gmail.com> <20090810152209.GB2564@ednor.casa.cgf.cx>
In-Reply-To: <20090810152209.GB2564@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
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
X-SW-Source: 2009-q3/txt/msg00047.txt.bz2

Christopher Faylor wrote:
> On Mon, Aug 10, 2009 at 05:28:16AM +0100, Dave Korn wrote:

>>  My turn to say "ugh"!  The wrapper function would translate down to a single
>> 'jmp' if -fno-omit-frame-pointer was in effect, but as things stand it's a bit
>> ugly.  So maybe we should let both of these rest for a while and see how things
>> pan out upstream.
> 
> Yes, sometimes we do ugly things in Cygwin to avoid slowdowns, even if
> it is to avoid a simple "jmp".

  Sure.  So, let's leave this one out and wait for the bug to get fixed in GCC.

>>> Also, referring to a bug without explaining what the problem either in
>>> the source code or the ChangeLog is a guaranteed way to cause confusion
>>> tomorrow after a memory cache refresh.
>>  You mean the PR notation?  Hopefully GCC's bugzilla will still be there
>> tomorrow!  Anyway, with a bit of luck we won't end up needing this one at all.
> 
> Whether it is there tomorrow or not, we don't want to expect someone who
> reads source code to know where to go to look for a gcc bugzilla entry.

  Righto, will make a mental note for future patches.

    cheers,
      DaveK
