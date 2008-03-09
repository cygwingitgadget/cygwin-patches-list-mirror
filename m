Return-Path: <cygwin-patches-return-6273-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2649 invoked by alias); 9 Mar 2008 15:14:59 -0000
Received: (qmail 2638 invoked by uid 22791); 9 Mar 2008 15:14:59 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 09 Mar 2008 15:14:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 5C5046D430A; Sun,  9 Mar 2008 16:14:40 +0100 (CET)
Date: Sun, 09 Mar 2008 15:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080309151440.GB18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <20080309143819.GB8192@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080309143819.GB8192@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00047.txt.bz2

On Mar  9 10:38, Christopher Faylor wrote:
> On Sun, Mar 09, 2008 at 10:28:06AM +0100, Corinna Vinschen wrote:
> >Bash as well as tcsh, as well as zsh (and probbaly pdksh, too) create an
> >environment variable $PWD.  Maybe Cygwin should create $PWD for native
> >apps if it's not already available through the parent shell.
> 
> I'd really rather not do that.  I don't think Cygwin should be polluting
> the environment any more than it has to.  Even if this worked, it is
> easily defeatable by setting a PWD environment variable before running
> cygwin, so you'd have to keep track of this value through multiple
> levels of process invocation.

Nothing against adding a cygwin_internal for such a purpose, but how is
that going to work?  Assuming the MingW application is called from a
Cygwin application.  If the parent application's cwd is a long path, the
MingW child gets its own cwd for apparent reasons.  If it loads the
cygwin DLL dynamically, as cygcheck already does, how is that new
invocation of the DLL supposed to know the cwd of the parent process? 

Maybe I miss something, but I don't see how that could work without
using another mechanism to transmit the cwd of the parent application to
the child, and the environment seems like a pretty simple way to do it.

What about just using PWD if it's set, but not to invent it in Cygwin if
it doesn't exist?  I see two situations which probably cover 99% of the
cases. 

The first case is starting cygcheck from the native command shell.  That
shell doesn't understand long paths anyway and always has a cwd which
can be fetched by GetCurrentDirectory.

The second case is starting cygcheck from a Cygwin shell.  The Cygwin
shell sets $PWD anyway, at least bash, tcsh and zsh.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
