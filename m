Return-Path: <cygwin-patches-return-7631-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12638 invoked by alias); 1 Apr 2012 22:45:30 -0000
Received: (qmail 12628 invoked by uid 22791); 1 Apr 2012 22:45:29 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_RX
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 01 Apr 2012 22:45:16 +0000
Received: from pool-173-76-45-163.bstnma.fios.verizon.net ([173.76.45.163] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SETWM-000OOA-CQ	for cygwin-patches@cygwin.com; Sun, 01 Apr 2012 22:45:14 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id EABB513C076	for <cygwin-patches@cygwin.com>; Sun,  1 Apr 2012 18:45:13 -0400 (EDT)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+9sYzmzDKgjz+QWb3PssjM
Date: Sun, 01 Apr 2012 22:45:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ctrl-C and non-Cygwin programs
Message-ID: <20120401224513.GA26458@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4F73CF37.4020001@elfmimi.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F73CF37.4020001@elfmimi.jp>
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
X-SW-Source: 2012-q2/txt/msg00000.txt.bz2

On Thu, Mar 29, 2012 at 11:55:51AM +0900, Ein Terakawa wrote:
>This is a proof of concept demonstration which
>makes Ctrl-C behave in a way a lot of people expect
>concerning non-Cygwin console programs.
>
>What it does actually is it generates CTRL_BREAK_EVENT with 
>Windows Console API GenerateConsoleCtrlEvent on the arrival of SIGINT.
>And to make this scheme to be functional it is required to specify
>CREATE_NEW_PROCESS_GROUP when creating new non-Cygwin processes.
>
>To my surprise there seem to be no way to generate CTRL_C_EVENT using API.
>
>I must also point out that virtually all of the terminal emulators
>are sneakily keeping hidden Windows Console in the background.

Yes, Cygwin does this by design.  It helps some programs work better if
they detect that a console is available.

>Lastly first third of the patch is a workaround of a problem observed
>with cygwin1.dll of cvs HEAD.
>To reproduce:
>1. Launch a terminal emulator like rxvt or mintty.
>2. Execute cmd.exe or more.com from shell prompt.
>3. Type in Enter, Ctrl-C, then Enter again.
>Whole processes including the terminal emulator will just hung up.

I added a fix to Cygwin a couple of days ago which was supposed to fix
this.  It just avoided trying to process a SIGINT if the user typed
CTRL-C when a non-Cygwin program had been execed.

I could duplicate this problem before the patch and couldn't after the
patch.  However, Corinna reports that she can still duplicate the hang.
Is that true for others also?

In any event, making a determination for every SIGINT seems like the
wrong way to handle this.  Catching it only for the case where a console
user has typed CTRL-C is how I'd like to handle it even if that means
more tweaking for the code I just checked in.

>	* spawn.cc: (child_info_spawn::worker) CREATE_NEW_PROCESS_GROUP for
>	each new non-Cygwin process.

This change is puzzling.  If you look at the existing spawn code, it is
already adding CREATE_NEW_PROCESS_GROUP to the CreateProcess flags iff
we aren't about to create a cygwin process + a few other tests.  See the
code under the comment that starts with /* If a native application
should be spawned, ... */

If the current test isn't adequate then the only thing I can see is that
the additional test fhandler_console::tc_getpgid () != myself->pgid is
causing a new proces group not to be created when it should be.

cgf
