Return-Path: <cygwin-patches-return-5613-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28594 invoked by alias); 8 Aug 2005 14:24:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28562 invoked by uid 22791); 8 Aug 2005 14:24:50 -0000
Received: from ns2.bln1.siemens.de (HELO ns2.bln1.siemens.de) (194.138.127.35)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 08 Aug 2005 14:24:50 +0000
Received: from ns-srv-2.bln1.siemens.de (stbf7654 [194.138.127.67])
	by ns2.bln1.siemens.de (8.12.10/8.12.10/MTA) with ESMTP id j78EOgdr024960;
	Mon, 8 Aug 2005 16:24:46 +0200 (MEST)
Received: from scotty.bln1.siemens.de (stbd7124.bln1.siemens.de [192.168.120.17])
	by ns-srv-2.bln1.siemens.de (8.12.10/8.12.10/MTA) with SMTP id j78EObDm029821;
	Mon, 8 Aug 2005 16:24:37 +0200 (MEST)
Date: Mon, 08 Aug 2005 14:24:00 -0000
Message-Id: <200508081424.j78EObDm029821@ns-srv-2.bln1.siemens.de>
From: Thomas Wolff <towo@computer.org>
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: Re: [Patch] /etc/termcap missing eA capabilities
X-SW-Source: 2005-q3/txt/msg00068.txt.bz2

On Mon, Aug 08, 2005 at 01:46:13PM +0200, Corinna Vinschen wrote:
>On Aug  8 13:19, Thomas Wolff wrote:
>> 2005-08-05  Thomas Wolff  <towo@computer.org>
>> 
>> 	* termcap: Updated xterm and rxvt (from /usr/share/terminfo 
>> 	using infocmp) to include the eA capability in order to enable 
>> 	programs to enable the alternate character set.
>
>Wrong mailing list.  cygwin-patches is for patches to the Cygwin package
>only.  Redirected to the cygwin ML.
I didn't see the full patch appear on the cygwin ML, just the change log.
So I guess I'll have to send it again, subscribing myself first...

Christopher Faylor wrote:
>And a hint:  Don't use termcap.  It's obsolete.
Well, at least it's not so obsolete that it shouldn't be fixed.

Let me shortly discuss this:
There are two APIs to the terminal capabilities database:
* terminfo (using tigetstr etc)
* termcap (using tgetstr etc)
Both APIs are also offered by the ncurses library, in this case termcap 
being "emulated" and also using the terminfo database.
While this is nice-to-have, I have never really understood why a program 
that really just uses either the termcap API or the terminfo API to 
handle terminal features should be forced to link with libncurses if it 
does not actually use the curses functionality.

For compatibility, not only on source level but also on makefile level, 
systems maintain an explicit library aside the ncurses library. On Sun, 
there are two identical libraries, termcap and termlib, each also 
offering both APIs (termcap and terminfo). On Linux, there is just 
termcap and it only offers the termcap API, not terminfo, which I 
don't really understand either as the terminfo API does not offer more 
functionality than the termcap API.

Advantages of maintaining the termcap API:
* Compatibility with programs that contain legacy screen control 
  (with respect to termcap vs. terminfo; I do not consider it 
  legacy to not use curses), avoiding porting effort that is 
  unnecessary because it does not gain better functionality.

Advantages of maintaining the termcap library:
* Compatibility with packages / makefiles.
* If (for any reason) some software links statically, linking with 
  ncurses just for the termcap API is overkill because it includes the 
  overhead of the unused curses functionality into the program, making 
  the executable larger - why should that be desirable?

Combining the two aspects, I would summarize:
* It is useful and important to maintain the termcap library. It would 
  be even better if it offers the terminfo API as well. It could 
  use the /usr/share/terminfo database, though, for both, making 
  the /etc/termcap database obsolete.
* It is very important, as long as the termcap library exists, to 
  keep it correct and up-to-date, and not break programs that 
  legitimately use it.

Kind regards,
Thomas Wolff
