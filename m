Return-Path: <cygwin-patches-return-6823-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29042 invoked by alias); 9 Nov 2009 15:23:06 -0000
Received: (qmail 29031 invoked by uid 22791); 9 Nov 2009 15:23:05 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 09 Nov 2009 15:23:01 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E39AD6D41A0; Mon,  9 Nov 2009 16:22:49 +0100 (CET)
Date: Mon, 09 Nov 2009 15:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events
Message-ID: <20091109152249.GA12652@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091109133551.GA10130@calimero.vinschen.de>  <20091109145458.GB31587@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091109145458.GB31587@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00154.txt.bz2

On Nov  9 09:54, Christopher Faylor wrote:
> On Mon, Nov 09, 2009 at 02:35:51PM +0100, Corinna Vinschen wrote:
> >On Nov 8 23:02, towo@towo.net wrote:
> >>Corinna Vinschen schrieb:
> >Ooookey, if they aren't listed in terminfo anyway, I have no problems
> >to change them.  But we should stick to following the Linux console, I
> >guess.
> 
> I agree.  I'm surprised that we've had the function keys wrong all these
> years.
> 
> >>>>* I intended to implement cursor position reports and noticed that
> >>>>their request ESC[6n is already handled in the code; it does not work,
> >>>>however, so I started to debug it:
> >>>This needs some more debugging, I guess.
> >>Do you have an opinion about my theory that the wrong read-ahead buffer
> >>is being filled here (stdout vs.  stdin)?  If so, I still have no clue
> >>how to proceed; maybe you'd kindly give a hint how to access the stdin
> >>buffer / stdin fhandler?
> >
> >I have no opinion yet, since I don't know this part of the code good
> >enough.  IIUC you think that the readahead buffer of the wrong
> >fhandle_console is filled, the one connected with stdout, not the one
> >connected with stdin, right?
> 
> I'm still struggling to understand what a "stdout read-ahead buffer"
> might be.  Could you point to the place in the code where you see the
> problem?

As far as I understand it:

  Application writes ESC [ 6 n to stdout which is connected to one
  fhandler_console.  Cygwin creates the reply and copies it into the
  readahead buffer of this very fhandler_console.  But that's not the
  same fhandler_console which is connected to stdin, which is the
  fhandler the application reads the reply from.  So the reply never
  makes it to the application.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
