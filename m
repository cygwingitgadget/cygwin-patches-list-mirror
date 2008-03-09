Return-Path: <cygwin-patches-return-6272-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20557 invoked by alias); 9 Mar 2008 14:54:41 -0000
Received: (qmail 20546 invoked by uid 22791); 9 Mar 2008 14:54:41 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 14:54:15 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id BD02642809A; Sun,  9 Mar 2008 10:54:13 -0400 (EDT)
Date: Sun, 09 Mar 2008 14:54:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] utils/path.cc fixes and testsuite
Message-ID: <20080309145413.GC8192@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <20080309084452.GV18407@calimero.vinschen.de> <47D3A5F1.4EF422A6@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D3A5F1.4EF422A6@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00046.txt.bz2

On Sun, Mar 09, 2008 at 12:55:13AM -0800, Brian Dessent wrote:
>Corinna Vinschen wrote:
>
>> Doesn't that install testsuite.exe at `make install' time?
>
>Ack, how about the attached?
>
>Brian
>2008-03-09  Brian Dessent  <brian@dessent.net>
>
>	* Makefile.in (install): Don't install the testsuite.
>
>Index: Makefile.in
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
>retrieving revision 1.70
>diff -u -p -r1.70 Makefile.in
>--- Makefile.in	9 Mar 2008 04:10:10 -0000	1.70
>+++ Makefile.in	9 Mar 2008 08:52:06 -0000
>@@ -157,7 +157,7 @@ realclean: clean
> 
> install: all
> 	$(SHELL) $(updir1)/mkinstalldirs $(bindir)
>-	for i in $(CYGWIN_BINS) $(MINGW_BINS) ; do \
>+	for i in $(CYGWIN_BINS) ${filter-out testsuite.exe,$(MINGW_BINS)} ; do \
> 	  n=`echo $$i | sed '$(program_transform_name)'`; \
> 	  $(INSTALL_PROGRAM) $$i $(bindir)/$$n; \
> 	done

Out of curiousity, does anyone know if program_transform_name ever gets
set to anything for cygwin?  If not, this loop could be made into a make
construct.

I suspect that it probably is used to translate cygcheck.exe ->
i686-pc-cygwin-cygcheck, even though that would be worthless.

You probably could get rid of it even if it did get set but it would be
trickier.

cgf
