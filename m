Return-Path: <cygwin-patches-return-4141-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32734 invoked by alias); 29 Aug 2003 14:18:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32718 invoked from network); 29 Aug 2003 14:18:13 -0000
Message-ID: <3F4F60A9.78B2260@phumblet.no-ip.org>
Date: Fri, 29 Aug 2003 14:18:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
References: <3F43B482.AC7F68F4@phumblet.no-ip.org> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net> <20030829011926.GA16898@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00157.txt.bz2

Christopher Faylor wrote:

> >I was planning to also eventually propose patches for the  following,
> >but it's more efficient to tell Chris while he is working on the code
> >and before I forget:
> >1) sigcatch_nosync could be an event instead of a semaphore. This
> >   doesn't affect the logic and will cut down useless loops, mainly
> >   at high load with pending_signals set.
> 
> Are you seeing a lot of loops through the signal handler due to
> semaphores being > 1?

Yes, in heavy traffic. That's what made me think of this.

> >2) When a signal is pending but blocked, pending_signals is set and
> >   sig_dispatch_pending() signals the sigthread. It would be more
> >   efficient to have a pending_signal_mask and to do mask comparison
> >   in sig_dispatch_pending(). It's just a courtesy call, no interlock
> >   is necessary.
> 
> There are all sorts of optimizations like this which could be done. 

I proposed those two because they are straightforward and will have 
an impact.
 
> Do you think that an occasional loop through the signal handler is slowing
> things down that much?  Do you think that sig_dispatch_pending gets
> called a lot with all pending signals blocked?  Are you convinced that
> you can set a mask in a non-raceable way?

Yes in heavy traffic, and it contributes the the trashing phenomenon
I saw with SIGALRM (system has to work even more in heavy load).

Races in sig_dispatch_pending() could occur because either a) the mask 
changes, or because b) pending_signal_mask changes. 
a) isn't a problem in the long run because with pthreads a mask can only 
be changed by its thread (there is no process mask). 
Races can occur with b), but races already occur today with pending_signals.
That's not a problem because sig_dispatch_pending() is a "good will" call, 
it can afford to have an occasional miss or a false alarm.

I am also starting to look at the relation with pthread and signals.
I noticed that sigactions are currently per thread, which isn't Posix. 
An immediate fix is to change "getsig (int sig)" in pinfo.h, you will
need to touch it anyway when you pull the sigactions out of pinfo.
Also I haven't yet found the private sigtodo for the main thread, nor
its mask.
Trying to imagine a possible implementation, I think it would help to have
per thread sigsave's, to avoid failed interrupts when delivering signals
to several threads.

Pierre
