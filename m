Return-Path: <cygwin-patches-return-4117-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27500 invoked by alias); 19 Aug 2003 14:33:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27488 invoked from network); 19 Aug 2003 14:33:06 -0000
Date: Tue, 19 Aug 2003 14:33:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Cc: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030819143305.GA17431@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>,
	cygwin-patches@cygwin.com
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00133.txt.bz2

On Tue, Aug 19, 2003 at 08:46:36AM -0400, Pierre A. Humblet wrote:
>At 12:13 AM 8/19/2003 -0400, Christopher Faylor wrote:
>>
>>I may not be able to get to your patch soon since I have actual
>>honest-to-gosh Red Hat Cygwin duties to attend to for the first time
>>in quite some time.  I volunteered to help out on a cygwin project even
>>though I've moved from the group that is responsible for cygwin.  I
>>neglected those duties tonight, in fact, thanks to the excitement of
>>someone actually submitting substantial signal handling patches.  :-)
>
>No problem, sorry to keep you awake! Some thoughts came to my mind 
>during the night, don't know if they are still relevant after your
>changes.
>
>1)
>>Are you saying that that someone reported execing a process, hitting
>>ctrl-c, and having another process simultaneously sending CTRL-C's to
>>the exec'ed stub?  
>
>The thisproc argument in sig_handle was only used to handle that exec'ed
>stub. Couldn't that condition be detected reliably in handle_exceptions(),
>case STATUS_CONTROL_C_EXIT ?

Moot point but it used to be handled that way.  I don't remember why I
changed it.

>2)
>>I only applied the reversal of the movl with the call above since I'm
>>not convinced that moving the set_process_mask into interrupt_setup
>>doesn't introduce a race. 
>
>Don't we have the same problem today?
>
>Handler is running with current mask M1, old mask M0
>New signal occurs, sigthread prepares sigsave with new mask M2, old mask M1
> but is preempted before setting sigsave.sig
>Handler terminates, restores M0
>sigthread resumes and starts new handler. It runs with M2 and restores
>M1 (instead of M0) at end.

Is this any different from UNIX?  Some races in signal handling are
inavoidable, IMO.  I guess you could make things slightly more
determinstic by setting a lock.  Probably UNIX has the luxury of being
able to tell the process handling a signal to stop working for a second
while it fiddles with masks.  We don't have any reliable way of doing
that.

cgf
