Return-Path: <cygwin-patches-return-4118-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21468 invoked by alias); 19 Aug 2003 20:30:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21432 invoked from network); 19 Aug 2003 20:30:08 -0000
Message-ID: <3F4288CE.C5133419@ieee.org>
Date: Tue, 19 Aug 2003 20:30:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00134.txt.bz2

Christopher Faylor wrote:

> >Don't we have the same problem today?
> >
> >Handler is running with current mask M1, old mask M0
> >New signal occurs, sigthread prepares sigsave with new mask M2, old mask M1
> > but is preempted before setting sigsave.sig
> >Handler terminates, restores M0
> >sigthread resumes and starts new handler. It runs with M2 and restores
> >M1 (instead of M0) at end.
> 
> Is this any different from UNIX?  Some races in signal handling are
> inavoidable, IMO.  I guess you could make things slightly more
> determinstic by setting a lock.  Probably UNIX has the luxury of being
> able to tell the process handling a signal to stop working for a second
> while it fiddles with masks.  We don't have any reliable way of doing
> that.

Here is a safe way.

1) change sigsave to contain the incremental mask bits, set by sigthread
   (instead of old mask and new mask) 
2) on starting, the handler
   a) pushes the current mask on its stack
   b) or's the current mask + incremental bits and calls set_process_mask
   c) clears sigsave.sig
3) on ending, the handler pops into the current mask and signals
   the sigthread.

Regarding your changes (it will take me a while to fully understand them)
- What problem are you trying to solve by having a local sigtodo?
  Specifically now that you have removed the thisproc argument in sig_handle,
  rc is not used in any function call and I don't see why it's helpful
  to segregate signals on a per source basis. 
  
- Having low_priority_sleep (SLEEP_0_STAY_LOW) in the sigthread loop 
  leaves it running (and WFMOing) at low priority. 
  I have observed a case where the mainthread was waiting for the 
  sigthread, which was trying to deliver two signals. The second delivery 
  fails because sigsave stays busy until the mainthread runs again. 
  Those are the two reasons why on interrupt failure I was immediately 
  going back to the outer loop and doing the sleep at the top of that 
  loop.

Also, as you wrote the signal code is not as simple as a bicycle!
A question I have is why it's helpful to call thisframe.call_signal_handler
in sig_dispatch_pending. I was under the impression that something
like it would happen automagically on return.

Pierre
