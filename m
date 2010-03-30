Return-Path: <cygwin-patches-return-7012-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7631 invoked by alias); 30 Mar 2010 16:15:12 -0000
Received: (qmail 7554 invoked by uid 22791); 30 Mar 2010 16:15:10 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 30 Mar 2010 16:15:06 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 416F26D435B; Tue, 30 Mar 2010 18:15:03 +0200 (CEST)
Date: Tue, 30 Mar 2010 16:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
Message-ID: <20100330161503.GB18364@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20091216145627.GM8059@calimero.vinschen.de>  <4B29934A.80902@towo.net>  <4B2C0715.8090108@towo.net>  <20091221101216.GA5632@calimero.vinschen.de>  <20100125190806.GA9166@calimero.vinschen.de>  <4B5F0585.9070903@towo.net>  <20100330095912.GZ18364@calimero.vinschen.de>  <4BB1D83A.8010406@towo.net>  <20100330142200.GA12926@calimero.vinschen.de>  <4BB21CBF.7030701@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BB21CBF.7030701@towo.net>
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
X-SW-Source: 2010-q1/txt/msg00128.txt.bz2

On Mar 30 17:46, Thomas Wolff wrote:
> Corinna Vinschen wrote:
> >>>Since you were looking into the Cygwin console code lately, maybe you
> >>>could find out why `stty sane' doesn't reset the character set?
> >>The tool to use would be 'reset'. So I'll try to find out why
> >>'reset' doesn't reset the character set :-\ .
> >>There are two methods to switch to the alternate character set. One
> >>is by just sending a Control-N. Most terminals "guard" this method
> >>by requiring an enable sequence before this works. I guess this
> >>would considerably reduce the risk that this happens, that's
> >>probably why they do it.
> >>I didn't implement the guarding mechanism in fhandler_console
> >>(although I prepared it somewhat) so I think I should fully
> >>implement that.
> The attached patch should make 'reset' work, and it should make the
> 'VT100 graphics garbage effect' less likely. Miraculously, even
> 'pstree -G' works now...

Cool, thanks for this patch.  How can I enforce printing garbage so I
can test the reset command?  My trick calling head -3 on the Fedora 11
ISO image doesn't work anymore.  Tcsh is always in a clean state
afterwards.  Obviously this is a good sign, but still...

> 2010-03-30  Thomas Wolff <towo@towo.net>
> 
>         * fhandler.h, fhandler_console.cc: Tune VT100 graphics mode
>           switching to follow ISO 2022 strictly.

One request.  Please look into the ChangeLog file and try to follow
more closely the layout of ChangeLog entries in the Cygwin ChangeLog
file.  For instance, we don't add multiple file or multiple functions
into the same line.  Sometimes a "throughout" is in order but usually
you should point to the changed function in parenthesis.

For now I'll just change the ChangeLog entry to:

  * fhandler (class dev_console): Drop vt100_graphics_mode_active.
  Add flags vt100_graphics_mode_G0, vt100_graphics_mode_G1 and
  iso_2022_G1.
  * fhandler_console.cc: Throughout, tune VT100 graphics mode switching
  to follow ISO 2022 strictly.

> diff -rup orig/fhandler.h ./fhandler.h

Hint:  Try `cvs diff -up'.  You don't have to have a clean copy
elsewhere.

Otherwise, the patch looks good.  I'm just wondering how I can test
reset as mentioned above.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
