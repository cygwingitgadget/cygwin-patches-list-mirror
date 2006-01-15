Return-Path: <cygwin-patches-return-5714-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7318 invoked by alias); 15 Jan 2006 09:30:16 -0000
Received: (qmail 7302 invoked by uid 22791); 15 Jan 2006 09:30:15 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 15 Jan 2006 09:30:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A0785544001; Sun, 15 Jan 2006 10:30:09 +0100 (CET)
Date: Sun, 15 Jan 2006 09:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] load wininet dynamically in cygcheck
Message-ID: <20060115093009.GA12283@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <43C7F635.9FDD093F@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C7F635.9FDD093F@dessent.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00023.txt.bz2

On Jan 13 10:49, Brian Dessent wrote:
> 
> This uses LoadLibrary and GetProcAddress instead of -lwininet so that systems
> lacking IE3 can still run cygcheck.  Tested on XP and NT4, and verified that
> with WININET.DLL renamed cygcheck can still function.
> 
> 2006-01-13  Brian Dessent  <brian@dessent.net>
> 
> 	* Makefile.in (cygcheck.exe): Do not link against libwininet.a.
> 	* cygcheck.cc (pInternetCloseHandle): Define global function pointer.
> 	(display_internet_error): Use it.
> 	(package_grep): Attempt to load wininet.dll at runtime.  Call WinInet
> 	API through function pointers throughout.

I tested it additionally on my NT4 which never had IE3 installed and it
works fine, as on XP and 2K3-WOW64.

Thanks, applied.


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
