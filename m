Return-Path: <cygwin-patches-return-4489-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3561 invoked by alias); 9 Dec 2003 03:47:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3552 invoked from network); 9 Dec 2003 03:47:38 -0000
Message-Id: <3.0.5.32.20031208224603.0082cc00@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 09 Dec 2003 03:47:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part
  1).
In-Reply-To: <20031209032857.GA11205@redhat.com>
References: <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net>
 <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
 <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
 <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00208.txt.bz2

At 10:28 PM 12/8/2003 -0500, Christopher Faylor wrote:
>On Mon, Dec 08, 2003 at 10:10:10PM -0500, Pierre A. Humblet wrote:
>>Either myself->set_ctty should be smarter, or fhandler_tty_slave::dup
>>could see if it's about the ctty and simply copy it.
>
>I stared at the set_ctty code a long time trying to understand why it
>went out of its way to do the ctty dance when there was already a ctty
>and eventually convinced myself that maybe it was necessary in some
>cases.  However, I can't see why it would ever be necessary to overwrite
>the saved ctty so I've checked in a patch that avoids that which, I guess,
>qualifies as making myself->set_ctty smarter.
>
>Does that solve the problem?

Yes, but now I see another one: open_fhs is off.
fhandler_tty_slave::close: decremented open_fhs -1

Pierre

P.S. I thought you would have chosen to copy the ctty in dup.
