Return-Path: <cygwin-patches-return-6913-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20350 invoked by alias); 14 Jan 2010 16:27:08 -0000
Received: (qmail 20325 invoked by uid 22791); 14 Jan 2010 16:27:06 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-52-118.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.52.118)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 16:27:02 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 3577E13C0C8 	for <cygwin-patches@cygwin.com>; Thu, 14 Jan 2010 11:26:52 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 32A732B35A; Thu, 14 Jan 2010 11:26:52 -0500 (EST)
Date: Thu, 14 Jan 2010 16:27:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100114162652.GC9964@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>  <20100113214928.GA2156@ednor.casa.cgf.cx>  <20100114094027.GA3428@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100114094027.GA3428@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00029.txt.bz2

On Thu, Jan 14, 2010 at 10:40:27AM +0100, Corinna Vinschen wrote:
>On Jan 13 16:49, Christopher Faylor wrote:
>> On Wed, Jan 13, 2010 at 10:25:37PM +0100, Corinna Vinschen wrote:
>> >Hi,
>> >
>> >the below patch implements the Linux dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
>> >extension.  I hope I didn't miss anything important since it affects
>> >quite a few fhandlers.  Fortunately most is mechanical change, except
>> >for a few places (dtable.cc, pipe.cc, fhandeler_fifo.cc, syscalls.cc).
>> >Nevertheless, I'd be glad if somebody could have a second look into
>> >this.
>> >
>> >Eric, you asked for it in the first place, do you have a fine testcase
>> >for this functionality?
>> 
>> The number of times that you typed:
>> 
>>   sa_buf = close_on_exec ()
>>               ? sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid())
>>               : sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
>> 
>> implies that this should be a macro or a function.
>
>The combination with sec_none_nih/sec_none is used four times in
>different fhandler files.  Yes, good idea, I'll create an inline
>function in fhandler.h.
>
>The above combination with sec_user_nih/sec_user is only used two times,
>both in fhandler_fifo.cc.  What about an inline function in
>fhandler_fifo.cc for this one?  I'll add that to the revised patch.

Even though it's used in fhandler_fifo is it similar enough to the
other function that grouping them together might make things clearer?
Otherwise, nevermind.

>> Could the setting of close_on_exec be handled in the syscalls.cc open()
>> so that it doesn't have to be done so many times?  You could have
>
>Yesterday I was sure that it has to be set in the various open methods
>since they could be called from elsewhere.  Today, after a nights sleep,
>I'm not so sure anymore.  I don't see any call to fh->open outside of
>open(2).  And calls to the open_fs() function are covered anyway.
>I'll look into simplifying this.
>
>> build_fh_name set the noexec flag so that close_on_exec() would still
>> work in the fhandler_*::open functions.
>
>I'm not sure I understand you correctly.  Do you mean build_fh_name
>should already set the close_on_exec flag so that later fhandler_*::open
>only have to call set_close_on_exec if a set_no_inheritance call is
>required?

I was saying that build_fh_name could set the flag so that you could
query close_on_exec() rather than using "flags & O_CLOEXEC".  But I made
that suggestion too late in the night and I see now that the flags parameter
that I thought was being passed to build_fh_name is not that at all.  So:

>For now I'll go the road to add the default close_on_exec setting to the
>open(2) call.  It's easy to switch to build_fh_name from there.

I don't think we need to perturb build_fh_name.  It was just a sleep-addled
suggestion.

cgf
