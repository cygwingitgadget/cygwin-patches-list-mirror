Return-Path: <cygwin-patches-return-4143-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23560 invoked by alias); 29 Aug 2003 15:54:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23461 invoked from network); 29 Aug 2003 15:54:25 -0000
Date: Fri, 29 Aug 2003 15:54:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030829155425.GA12672@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net> <20030829011926.GA16898@redhat.com> <3F4F60A9.78B2260@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4F60A9.78B2260@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00159.txt.bz2

On Fri, Aug 29, 2003 at 10:18:17AM -0400, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>>Do you think that an occasional loop through the signal handler is
>>slowing things down that much?  Do you think that sig_dispatch_pending
>>gets called a lot with all pending signals blocked?  Are you convinced
>>that you can set a mask in a non-raceable way?
>
>Yes in heavy traffic, and it contributes the the trashing phenomenon I
>saw with SIGALRM (system has to work even more in heavy load).
>
>Races in sig_dispatch_pending() could occur because either a) the mask
>changes, or because b) pending_signal_mask changes.  a) isn't a problem
>in the long run because with pthreads a mask can only be changed by its
>thread (there is no process mask).

Aren't you talking about having wait_sig build up a mask of pending
signals as it iterates through the list?  That sounds like a potential for
a big race condition to me.

In any event, I have just found an interesting paper by Ulrich Drepper
which talks about not using an actual mask for signals but using an array
instead.  I'm still mulling over if that is something I want to change
or not.

>I am also starting to look at the relation with pthread and signals.

i.e., it doesn't work at all.  That is a known problem.  Please don't
waste your time trying to fix this.  I have many ideas on how to fix
this and have the seeds of some code in cygwin already.

>I noticed that sigactions are currently per thread, which isn't Posix. 
>An immediate fix is to change "getsig (int sig)" in pinfo.h, you will
>need to touch it anyway when you pull the sigactions out of pinfo.

On looking at this further, I won't be able to do this (at least
trivially) since there are parts of cygwin which rely on being able
to have processes inspect this info.

cgf
