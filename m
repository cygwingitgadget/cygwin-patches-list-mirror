Return-Path: <cygwin-patches-return-4075-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30692 invoked by alias); 13 Aug 2003 11:35:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30683 invoked from network); 13 Aug 2003 11:35:10 -0000
Date: Wed, 13 Aug 2003 11:35:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Questions and a RFC [was Re: Assignment from Nicholas Wourms arrived]
Message-ID: <20030813113509.GA24855@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030812191411.GH17051@cygbert.vinschen.de> <3F39704F.6030001@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F39704F.6030001@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00091.txt.bz2

On Tue, Aug 12, 2003 at 06:55:11PM -0400, Nicholas Wourms wrote:
> 1)Did my MUA strip the tabs from the patch?  The only reason I ask is 

Yes.  The patch already contained spaces.  I see you're using Mozilla/NS7
so I'm wondering how this happened.  AFAIK, Mozilla doesn't touch
attachments.

> [BTW, sorry about NBBY, I had been 
> meaning to send a follow up since I realized that I forgot that I had it 
> globally defined in another header :-(].

No worries.

> 2)I assume that my assignment covers me for Newlib contributions?

No :-)

Long answer:  You don't need any assignment for newlib due to the relaxed
licensing of newlib.

> 3)I'm still trying to figure out how to use lstat in newlib source code, 

What are you trying to implement?  If you need lstat, you're perhaps better
off implementing this in Cygwin instead of newlib.

>  since apparently the function declaration is hidden when building 
> newlib/cygwin.  So far, any attempt to use it results in undefined 
> references to _lstat when linking the dll.  I tried adding a definition 
> to _syslist.h, but that didn't work.  I hate to sound clueless, but if 
> someone could nudge me toward the right header or magic, that would be 
> great.

cd winsup/cygwin
ctags -R .
vi -t cygwin_lstat

However, thinking about this situation, I'm sure it wasn't really clever
to rename lstat to cygwin_lstat.  Your problem to link against it stems
from that fact and other declaration problems has been easilier solved by
just adding a bunch of defines at the top of syscalls.cc.

[...time passes...]

Ok, I've tested to revert the function name from cygwin_lstat to lstat
in syscalls.cc and applied the appropriate patch.  This is transparent
to all applications and should allow to use lstat from newlib as in
libc/sys/linux.

> 4)Corinna, I've been working on porting some of the missing 
> SUSv3/c99/bsd functions from the *bsd libc.  I noticed that the libutil 
> which you distribute with inetutils contains some of the functions I 
> thought belonged in libc, or at least the headers of newlib would have 
> me believe this.  Specifically, I was wanted to work on adding instances of:
> endusershell()
> setusershell()
> getusershell()
> ruserok()
> iruserok()

Don't do this(TM).  The reason is that, first, I have already code for
this in the loop and, second, I have to coordinate this with changing
my inetutils package not to contain the libutil.a anymore at one point.
I appreciate your effort but I'd like to keep these functions in my
hand, even though it might take a bit longer.

Especially I will not do this for 1.5.2 (or 3, whatever will be the first
gold version).  At this point, we should only apply bug fixes and very
obvious stuff.  New functionality should wait for later Cygwin versions.

> 5)This is meant as a general RFC based on something I noticed while 
> researching the freebsd libc.

Sorry, but I agree with Charles and I'm pretty sure Chris will have the
same opinion.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
