Return-Path: <cygwin-patches-return-5192-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2092 invoked by alias); 6 Dec 2004 19:54:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1891 invoked from network); 6 Dec 2004 19:54:37 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 6 Dec 2004 19:54:37 -0000
Received: from buzzy-box (hmm-dca-ap03-d12-060.dial.freesurf.nl [62.100.11.60])
	by green.qinip.net (Postfix) with SMTP
	id B495D4366; Mon,  6 Dec 2004 20:54:34 +0100 (MET)
Message-ID: <n2m-g.cp2gdj.3vvajm7.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] fhandler.cc (pust_readahead): end-condition off.
References: <n2m-g.cp0gle.3vsh6i5.1@buzzy-box.bavag> <20041206151619.GA11120@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041206151619.GA11120@trixie.casa.cgf.cx>
Date: Mon, 06 Dec 2004 19:54:00 -0000
X-SW-Source: 2004-q4/txt/msg00193.txt.bz2

Op Mon, 6 Dec 2004 10:16:19 -0500 schreef Christopher Faylor
in <20041206151619.GA11120@trixie.casa.cgf.cx>:
:  On Mon, Dec 06, 2004 at 02:45:10AM +0100, Bas van Gompel wrote:
[...]

: > 	* fhandler.cc (fhandler_base::puts_readahead): Fix end-condition.
:
:   This patch changes things so that len characters are always output if
:  len is != -1.  It has been a while since I worked on this code but it's
:  not clear that that is correct.

I found following clues:


C1:
`cvs annotate -r1.16 fhandler.cc`, line 75:
| 1.1          (cgf      17-Feb-00):   while ((((len == (size_t) -1) && *s) || len--) &&

This code seems to intend to not test ``*s'' when len != -1.


C2:
`cvs annotate fhandler.cc` (for current version), line 57
| 1.17         (corinna  09-May-00):   while ((*s || (len != (size_t) -1 && len--))
ChangeLog-2000 about above change:
| 	* fhandler.cc (fhandler_base::puts_readahead): Change
| 	while condition to disallow wild runs.

The wild runs would occur when *s became 0, len would then be
decremented to -2. This ``new'' code does not seem to want to decrement
len when ``*s'' is nonzero.


C3:
(fhandler_tty.cc (fhandler_pty_master::accept_input):)
...
|      rc = WriteFile (get_output_handle (), p, bytes_left, &written, NULL);
...
| 	  p += written;
| 	  bytes_left -= written;
...
| 	      puts_readahead (p, bytes_left);


I don't think there is a reason to not send all that wasn't written,
to the readahead-buffer.
[...]


I hope this helps.


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
