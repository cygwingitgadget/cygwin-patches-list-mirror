Return-Path: <cygwin-patches-return-4114-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25174 invoked by alias); 19 Aug 2003 04:13:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25164 invoked from network); 19 Aug 2003 04:13:07 -0000
Date: Tue, 19 Aug 2003 04:13:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030819041307.GA9022@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819024617.GA6581@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00130.txt.bz2

On Mon, Aug 18, 2003 at 10:46:17PM -0400, Christopher Faylor wrote:
>On Mon, Aug 18, 2003 at 10:29:27PM -0400, Pierre A. Humblet wrote:
>>>However, this does demonstrate a flaw in wait_sig.  It exhausts the sigtodo
>>>array based on he last received type of signal.  So, if process a sends ctrl-c
>>>to itself and "at the same time" process b sends ctrl-c to process a,
>>>then the signal will be randomly processed as coming from either process a
>>>process b.  If the signal is handled as coming from process b, process a
>>>will never get the notification it needs.
>>
>>Yes, that's what I had in mind. There are also the sig_dispatch_pending (0)
>>in net.cc (and other places) that generate events with rc == 2 even though 
>>they are local.
>
>Hmm.  Now that I look at this more, I think maybe this should be a
>'rc == 1' rather than a 'rc != 2'.
>
>>I don't understand their role.
>
>All of the calls in net.cc are sig_dispatch_pending (0).
>
>It's supposed to synchronously flush all pending signals.  Only calling
>sig_dispatch_pending (1) should call the nonsync semaphore.  This
>justwake semaphore is problematic as it is used in exceptions.cc,
>though.  It will confuse wait_sig when signals are stacked up.  That may
>explain the occasional signal hang reports.

Nope.  I was wrong again.  I don't believe that this should cause a
hang.  Understanding the signal code is nothing like riding a bicycle.

Anyway, in an attempt to simplify this somewhat, I've moved stuff out
of setup_handler and back into wait_sig (for at least the second time)
as your patch did.  I've also changed the inner while in wait_sig to an
if (for at least the second time).  This will move things around so your
patch probably no longer cleanly applies but I'll deal with that in the
next few days as I dissect more of it.

I may not be able to get to your patch soon since I have actual
honest-to-gosh Red Hat Cygwin duties to attend to for the first time
in quite some time.  I volunteered to help out on a cygwin project even
though I've moved from the group that is responsible for cygwin.  I
neglected those duties tonight, in fact, thanks to the excitement of
someone actually submitting substantial signal handling patches.  :-)

cgf
