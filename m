Return-Path: <cygwin-patches-return-7771-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18838 invoked by alias); 12 Nov 2012 21:50:48 -0000
Received: (qmail 18817 invoked by uid 22791); 12 Nov 2012 21:50:39 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 12 Nov 2012 21:50:29 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4C21F2C00FB; Mon, 12 Nov 2012 22:50:23 +0100 (CET)
Date: Mon, 12 Nov 2012 21:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121112215023.GA1436@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121112200223.GA16672@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00048.txt.bz2

On Nov 12 15:02, Christopher Faylor wrote:
> I decided over the weekend to port over configury changes that I made to
> Cygwin's now-out-of-date GIT repository.
> 
> These changes basically just cleaned up some of the configure scripts
> and made it easier to pinpoint where windows headers and libraries come
> from by adding a --with-windows-headers and --with-windows-libs options.
> However, some of the assumptions made for the git repository weren't
> really valid for the CVS repository so there was a fair amount of work
> involved.
> 
> I thought that I'd do this so I could easily get up-and-running with the
> MinGW64 stuff but I ran into some problems building things with gentoo's
> MinGW64 implementation.  So, I switched to using the files from the
> Cygwin release.
> 
> As I mentioned in cygwin-developers, getting the most recent version of
> mingw64 stuff working required making some changes to some Cygwin source
> files.  Most of the changes just involved #undef'ing constants defined
> in Windows headers.  Still, I was surprised that these hadn't already
> been handled since I thought I was behind the times by still using the
> Mingw32 stuff.
> 
> Anyway, is a summary of the changes I've made to files is below.  I'll
> be doing appropriate ChangeLogs too, of course.  I've also attached the
> patch.
> 
> This is a heads up in case this conflicted materially with any of the
> w64 development.

Looks good at first sight.  I see only one place which won't work for 64
bit, the ccwrap script.  It uses i686-pc-cygwin-gcc/g++ hardcoded, but
it should use something like ${target_cpu}-pc-cygwin-gcc/g++ to make it
platform independent.  With a matching change, I can give it a try on
64 bit tomorrow.

I'm a bit puzzled about the necessity of some of the changes to source
files.  Yaakov's Fedora 17 version of the headers is supposedly cut from
the mingw64 trunk on 2012-10-16, while JonY's official headers have an
upload date of 2012-10-18.  They should be practically identical.  Why
do I not see any problems to build CVS HEAD?!?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
