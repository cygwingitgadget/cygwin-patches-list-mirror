Return-Path: <cygwin-patches-return-4120-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18284 invoked by alias); 19 Aug 2003 23:33:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18246 invoked from network); 19 Aug 2003 23:33:06 -0000
Message-Id: <3.0.5.32.20030819193152.00817750@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Tue, 19 Aug 2003 23:33:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030819143305.GA17431@redhat.com>
References: <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818222927.008114e0@incoming.verizon.net>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00136.txt.bz2

Christopher Faylor wrote:
>
>>> >Don't we have the same problem today?
>>> >
>>> >Handler is running with current mask M1, old mask M0
>>> >New signal occurs, sigthread prepares sigsave with new mask M2, old
mask M1
>>> > but is preempted before setting sigsave.sig
>>> >Handler terminates, restores M0
>>> >sigthread resumes and starts new handler. It runs with M2 and restores
>>> >M1 (instead of M0) at end.
>>> 
>>> Is this any different from UNIX?  Some races in signal handling are
>>> inavoidable, IMO.  I guess you could make things slightly more
>>> determinstic by setting a lock.  Probably UNIX has the luxury of being
>>> able to tell the process handling a signal to stop working for a second
>>> while it fiddles with masks.  We don't have any reliable way of doing
>>> that.
>>
>>Here is a safe way.
>>
>>1) change sigsave to contain the incremental mask bits, set by sigthread
>>   (instead of old mask and new mask) 
>
> And while you are in the process of saving the incremental bits, they
> are in the process of being changed == race.  I don't see why this adds
> anything.  I'm also not sure that this is posix-sanctioned behavior.

Here are the details.

Currently the sigthread executes
  sigsave.oldmask = myself->getsigmask ();
  sigsave.newmask = sigsave.oldmask | siga.sa_mask | SIGTOMASK (sig);
As you noted last night there is a race condition with the handler,
which may terminate and change the sigmask, so that the new handler
will run with and restore incorrect masks.

What I was suggesting is to set (instead of .oldmask and .newmask)
  sigsave.deltamask = siga.sa_mask | SIGTOMASK (sig);
and to let the handler compute when it starts
  newmask =  myself->getsigmask () | sigsave.deltamask;
and then call set_process_mask (newmask)

Alternatively it's not even necessary to define sigsave.deltamask,
the handler can call directly  
set_process_mask (myself->getsigmask () | siga.sa_mask | SIGTOMASK (sig));
although that doesn't fit that well with the current asm implementation.
 
The overall behavior is as per posix.

Pierre
