Return-Path: <cygwin-patches-return-4488-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31446 invoked by alias); 9 Dec 2003 03:28:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31436 invoked from network); 9 Dec 2003 03:28:58 -0000
Date: Tue, 09 Dec 2003 03:28:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part 1).
Message-ID: <20031209032857.GA11205@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net> <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net> <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00207.txt.bz2

On Mon, Dec 08, 2003 at 10:10:10PM -0500, Pierre A. Humblet wrote:
>Either myself->set_ctty should be smarter, or fhandler_tty_slave::dup
>could see if it's about the ctty and simply copy it.

I stared at the set_ctty code a long time trying to understand why it
went out of its way to do the ctty dance when there was already a ctty
and eventually convinced myself that maybe it was necessary in some
cases.  However, I can't see why it would ever be necessary to overwrite
the saved ctty so I've checked in a patch that avoids that which, I guess,
qualifies as making myself->set_ctty smarter.

Does that solve the problem?

cgf
