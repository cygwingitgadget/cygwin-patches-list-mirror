Return-Path: <cygwin-patches-return-4481-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22581 invoked by alias); 7 Dec 2003 22:40:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22571 invoked from network); 7 Dec 2003 22:40:19 -0000
Date: Sun, 07 Dec 2003 22:40:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part 1).
Message-ID: <20031207224017.GA6290@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00200.txt.bz2

On Mon, Sep 29, 2003 at 09:55:25PM -0400, Pierre A. Humblet wrote:
>Here is a patch that allows to open master ttys without giving
>full access to the process, at least for access to the ctty. 
>
>It works by snooping the ctty pipe handles and duplicating them
>on the cygheap, for use by future opens in descendant processes.
>
>It passes all the tests I tried, but considering my lack of knowledge
>about ttys, everything is possible.

I checked in a variation of this patch.  It restructures the way
controlling tty is handled, making it a little easier to deal with
/dev/tty at the fhandler level.  I suspect that eventually there will
be a fhandler_ctty class but, for now, this seems to work.

I'm not 100% certain that I got the close-on-exec stuff right but, fwiw,
it seems to work with the combination of ssh/zsh which is usually a
pretty tough test for this kind of thing.  I did check to make sure that
access to a tty is now not allowed from a non-privileged account thanks
to the tty.cc change below.

Thanks for the patch and sorry for the delay.

cgf
