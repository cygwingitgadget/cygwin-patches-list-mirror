Return-Path: <cygwin-patches-return-4111-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22280 invoked by alias); 19 Aug 2003 02:46:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22269 invoked from network); 19 Aug 2003 02:46:18 -0000
Date: Tue, 19 Aug 2003 02:46:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Cc: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030819024617.GA6581@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>,
	cygwin-patches@cygwin.com
References: <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030818222927.008114e0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00127.txt.bz2

On Mon, Aug 18, 2003 at 10:29:27PM -0400, Pierre A. Humblet wrote:
>>However, this does demonstrate a flaw in wait_sig.  It exhausts the sigtodo
>>array based on he last received type of signal.  So, if process a sends ctrl-c
>>to itself and "at the same time" process b sends ctrl-c to process a,
>>then the signal will be randomly processed as coming from either process a
>>process b.  If the signal is handled as coming from process b, process a
>>will never get the notification it needs.
>
>Yes, that's what I had in mind. There are also the sig_dispatch_pending (0)
>in net.cc (and other places) that generate events with rc == 2 even though 
>they are local.

Hmm.  Now that I look at this more, I think maybe this should be a
'rc == 1' rather than a 'rc != 2'.

>I don't understand their role.

All of the calls in net.cc are sig_dispatch_pending (0).

It's supposed to synchronously flush all pending signals.  Only calling
sig_dispatch_pending (1) should call the nonsync semaphore.  This
justwake semaphore is problematic as it is used in exceptions.cc,
though.  It will confuse wait_sig when signals are stacked up.  That may
explain the occasional signal hang reports.

cgf
