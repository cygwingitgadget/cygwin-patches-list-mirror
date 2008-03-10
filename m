Return-Path: <cygwin-patches-return-6280-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20938 invoked by alias); 10 Mar 2008 10:37:48 -0000
Received: (qmail 20926 invoked by uid 22791); 10 Mar 2008 10:37:47 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 10 Mar 2008 10:37:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id DE7CB6D430A; Mon, 10 Mar 2008 11:37:28 +0100 (CET)
Date: Mon, 10 Mar 2008 10:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080310103728.GG18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <20080309143819.GB8192@ednor.casa.cgf.cx> <20080309151440.GB18407@calimero.vinschen.de> <20080309162800.GB13754@ednor.casa.cgf.cx> <47D4266A.CE301EDE@dessent.net> <20080309195509.GD18407@calimero.vinschen.de> <47D48113.814F024C@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D48113.814F024C@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00054.txt.bz2

On Mar  9 17:30, Brian Dessent wrote:
> Corinna Vinschen wrote:
> > The problem is that the cwd is stored as UNICODE_STRING with a
> > statically allocated buffer in the user parameter block.  The
> > MaximumLength is set to 520.  SetCurrentDirectory refuses to take paths
> > longer than that.  In theory it would be possible to define a longer cwd
> > by defining a new buffer in the cwd's UNICODE_STRING.  But I never tried
> > that.  I don't really know if that's possible and what happens if you
> > call CreateProcess or, FWIW, any Win32 file access function after doing
> > that.  Nobody keeps us from trying, but I have this gut feeling that
> > different NT versions will show different behaviour...
> 
> How does this fit in with the practice of maintaining our own Cygwin CWD
> state separate from the Win32 CWD so that unlink(".") and the like can
> succeed?  Or is that precisely how we are able to support a CWD >= 260? 

Cygwin maintains its own cwd.  It writes the directory path and handle
back to the user parameter block, but it does not do that if the path
gets longer than 259 chars.  When a Cygwin process forks or execs
another Cygwin application, the cwd is inherited through the cygheap.

> If it is the case that we can only support a CWD >= 260 by faking it,
> i.e. not trying to sync the Win32 CWD to the actual long CWD, then it
> seems we are limited to two choices for how to deal with a long CWD in a
> non-Cygwin process: a) not supported, b) supported only through some
> special hook (such as cgf's idea of handle inheritance of the Cygwin CWD
> handle) or through relying on the shell to set PWD.

ACK.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
