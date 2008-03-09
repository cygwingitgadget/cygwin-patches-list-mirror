Return-Path: <cygwin-patches-return-6276-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31017 invoked by alias); 9 Mar 2008 19:55:33 -0000
Received: (qmail 31005 invoked by uid 22791); 9 Mar 2008 19:55:33 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 09 Mar 2008 19:55:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A97676D430A; Sun,  9 Mar 2008 20:55:09 +0100 (CET)
Date: Sun, 09 Mar 2008 19:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080309195509.GD18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <20080309143819.GB8192@ednor.casa.cgf.cx> <20080309151440.GB18407@calimero.vinschen.de> <20080309162800.GB13754@ednor.casa.cgf.cx> <47D4266A.CE301EDE@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D4266A.CE301EDE@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00050.txt.bz2

On Mar  9 11:03, Brian Dessent wrote:
> Christopher Faylor wrote:
> 
> > I guess I misunderstood.  I thought that the current working directory
> > could be derived through some complicated combination of Nt*() calls.
> 
> I could be wrong here but the way I understood it, there is no concept
> of a working directory at the NT level, that is something that is
> maintained by the Win32 layer.

That's right.  NT doesn't have a notion what a cwd is.  It only has the
OBJECT_ATTRIBUTES structure which defines an object by an absolute path,
or by a path relative to a directory handle.

The cwd is maintained by kernel32.dll in a per-process structure called
RTL_USER_PROCESS_PARAMETERS.  The cwd is stored as path (always with
trailing backslash) and as handle.

Sometimes the Win32 functions use the cwd's path to create an absolute
path from a relative path, sometimes they use the cwd's handle and the
relative path in calls to NT functions.

> My question is, what does GetCurrentDirectoryW() return if the current
> directory is greater than the 260 limit?  Does it choke or does it
> switch to the \.\c:\foo syntax?

It can't do that.  See the MSDN man page for SetCurrentDirectory:
http://msdn2.microsoft.com/en-us/library/aa365530(VS.85).aspx

 "The string must not exceed MAX_PATH characters including the
  terminating null character."

The problem is that the cwd is stored as UNICODE_STRING with a
statically allocated buffer in the user parameter block.  The
MaximumLength is set to 520.  SetCurrentDirectory refuses to take paths
longer than that.  In theory it would be possible to define a longer cwd
by defining a new buffer in the cwd's UNICODE_STRING.  But I never tried
that.  I don't really know if that's possible and what happens if you
call CreateProcess or, FWIW, any Win32 file access function after doing
that.  Nobody keeps us from trying, but I have this gut feeling that
different NT versions will show different behaviour...


Corinna


(*) See cygwin/ntdll.h, struct _RTL_USER_PROCESS_PARAMETERS.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
