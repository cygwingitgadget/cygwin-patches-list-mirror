Return-Path: <cygwin-patches-return-2571-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14831 invoked by alias); 1 Jul 2002 22:21:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14817 invoked from network); 1 Jul 2002 22:21:43 -0000
Message-ID: <06d801c2214d$f155ddd0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <Pine.LNX.4.33.0207011735010.2716-100000@this>
Subject: Re: Patch to pass file descriptors
Date: Mon, 01 Jul 2002 15:21:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00019.txt.bz2

"David Euresti" <davie@MIT.EDU> wrote:
>         There's the option of keeping full BSD semantics if the
cygserver
> is running.  I like that.  I can require users to run the cygserver.
I
> don't mind. [snip]
>         The question is, can you incorporate my code and then you
guys
> deal with the case when the cygserver isn't running? [snip]
>         I'm sure other people will want full BSD semantics also so
why not
> allow them to have it if the cygserver is running.

This seems to be the "standard" approach for this sort of issue (if
one example suffices to set a standard): the fhandler_tty code uses
cygserver to dup handles if available, otherwise falls back to doing
it locally; see the fhandler_tty_slave::open method in
"fhandler_tty.cc". So I don't see a problem with that.

>         Unfortunately the whole net.cc has been refactored so I'll
have to
> regenerate my patch.

Unless anyone has any objection, if you send this to the list, I'll
put it into the cygwin_daemon branch. It's not a complete or final
solution (as you've noted), and perhaps you ought to follow the
example, from the fhandler_tty.cc code, of putting some conditions
around calling cygserver, leaving a blank spot to be filled in with
the non-cygserver code. When/if such non-cygserver code appears on
HEAD I can merge it into the branch by slotting it into those blanks.

// Conrad


