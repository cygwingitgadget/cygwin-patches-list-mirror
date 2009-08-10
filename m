Return-Path: <cygwin-patches-return-6592-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 732 invoked by alias); 10 Aug 2009 15:22:28 -0000
Received: (qmail 721 invoked by uid 22791); 10 Aug 2009 15:22:27 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-170.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.170)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 10 Aug 2009 15:22:20 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id E2F6513C0C5 	for <cygwin-patches@cygwin.com>; Mon, 10 Aug 2009 11:22:09 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id DD50D2B352; Mon, 10 Aug 2009 11:22:09 -0400 (EDT)
Date: Mon, 10 Aug 2009 15:22:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCHes] Misc aliasing fixes for building DLL with gcc-4.5.0
Message-ID: <20090810152209.GB2564@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A7F8FF5.5060701@gmail.com>  <20090810040452.GB610@ednor.casa.cgf.cx>  <4A7FA1E0.7070209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A7FA1E0.7070209@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00046.txt.bz2

On Mon, Aug 10, 2009 at 05:28:16AM +0100, Dave Korn wrote:
>Christopher Faylor wrote:
>> On Mon, Aug 10, 2009 at 04:11:49AM +0100, Dave Korn wrote:
>>> 	* fhandler_tty.cc (process_input): Add dummy return to silence warning.
>>> 	(process_ioctl): Likewise.
>> 
>> Shouldn't these be defined with __attribute__ ((noreturn))?
>
>  They probably should also, but (I forgot to mention) I tried it and it didn't
>solve the warning.
>
>>> 	* fork.cc (cygfork): New name with friendable C++ linkage for ...
>>> 	(fork): ... un-friendable extern "C" function becomes stub calling it.
>>> 	(class frok): Declare cygfork() friend, not fork(), avoiding PR41020.
>> 
>> Ugh.  I don't like this.  fork is slow enough and complicated enough
>> without adding this kind of workaround.  If this is a problem with
>> declaring an 'extern "C"' friend function then it should be fixable by
>> just making fork() a C++ function but exporting it as a "C" function
>> in cygwin.din.
>
>  My turn to say "ugh"!  The wrapper function would translate down to a single
>'jmp' if -fno-omit-frame-pointer was in effect, but as things stand it's a bit
>ugly.  So maybe we should let both of these rest for a while and see how things
>pan out upstream.

Yes, sometimes we do ugly things in Cygwin to avoid slowdowns, even if
it is to avoid a simple "jmp".

>> Also, referring to a bug without explaining what the problem either in
>> the source code or the ChangeLog is a guaranteed way to cause confusion
>> tomorrow after a memory cache refresh.
>
>  You mean the PR notation?  Hopefully GCC's bugzilla will still be there
>tomorrow!  Anyway, with a bit of luck we won't end up needing this one at all.

Whether it is there tomorrow or not, we don't want to expect someone who
reads source code to know where to go to look for a gcc bugzilla entry.

cgf
