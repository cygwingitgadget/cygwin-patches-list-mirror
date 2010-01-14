Return-Path: <cygwin-patches-return-6916-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9221 invoked by alias); 14 Jan 2010 16:51:20 -0000
Received: (qmail 9180 invoked by uid 22791); 14 Jan 2010 16:51:16 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-52-118.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.52.118)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 16:51:12 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 9F66E13C0C7 	for <cygwin-patches@cygwin.com>; Thu, 14 Jan 2010 11:51:02 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 9CB172B35A; Thu, 14 Jan 2010 11:51:02 -0500 (EST)
Date: Thu, 14 Jan 2010 16:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100114165102.GF9964@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>  <20100113214928.GA2156@ednor.casa.cgf.cx>  <20100114094027.GA3428@calimero.vinschen.de>  <20100114162652.GC9964@ednor.casa.cgf.cx>  <20100114164536.GG14511@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100114164536.GG14511@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00032.txt.bz2

On Thu, Jan 14, 2010 at 05:45:36PM +0100, Corinna Vinschen wrote:
>On Jan 14 11:26, Christopher Faylor wrote:
>> On Thu, Jan 14, 2010 at 10:40:27AM +0100, Corinna Vinschen wrote:
>> >The combination with sec_none_nih/sec_none is used four times in
>> >different fhandler files.  Yes, good idea, I'll create an inline
>> >function in fhandler.h.
>> >
>> >The above combination with sec_user_nih/sec_user is only used two times,
>> >both in fhandler_fifo.cc.  What about an inline function in
>> >fhandler_fifo.cc for this one?  I'll add that to the revised patch.
>> 
>> Even though it's used in fhandler_fifo is it similar enough to the
>> other function that grouping them together might make things clearer?
>> Otherwise, nevermind.
>
>In my revised patch it's in fhandler_fifo.cc, called sec_user_cloexec.
>First I was planning to make a similar sec_none_cloexec function in
>fhandler.h, but it didn't make it for two reasons:
>
>- It should be rather in security.h, where sec_none and sec_none_nih
>  are declared as well.
>
>- If it's inline in security.h, it breaks the build since O_CLOEXEC
>  isn't always known in files which include security.h.
>
>Therefore it's a macro in security.h now.  The sec_user_cloexec
>doesn't get an `int flags' but a bool due to the way it gets called
>in fhandler_fifo::wait.
>
>To unify this, I could make sec_user_cloexec a macro in security.h as
>well, and change the flags parameter to a bool parameter in the
>sec_none_cloexec macro, like this:
>
>  #define sec_none_cloexec(f) (((f) ? &sec_none_nih : &sec_none))
>  #define sec_user_cloexec(f,sa,sid) (((f) ? sec_user_nih ((sa),(sid))
>					   : sec_user ((sa),(sid))))
>
>If you prefer that, I have no problem whatsoever to change it that way.

I have no preference so whatever you have is fine.

>>>For now I'll go the road to add the default close_on_exec setting to
>>>the open(2) call.  It's easy to switch to build_fh_name from there.
>>
>>I don't think we need to perturb build_fh_name.  It was just a
>>sleep-addled suggestion.
>
>No worries.  Parts of my patch suffered from the same problem ;)

Part of my problem is that I've recently discovered Runes of Magic and
that has been occupying way too much of my time.  But on the plus side
I'm now a Level 18 Mage with a level 14 Scout secondary so at least I
have something positive to show for my lack of sleep.

cgf
