Return-Path: <cygwin-patches-return-4026-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32499 invoked by alias); 24 Jul 2003 13:17:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32473 invoked from network); 24 Jul 2003 13:17:36 -0000
X-Authentication-Warning: localhost.localdomain: ronald set sender to blytkerchan@users.sourceforge.net using -f
Date: Thu, 24 Jul 2003 13:17:00 -0000
From: Ronald Landheer-Cieslak <blytkerchan@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: patch for winsup/cygwin/Makefile.in
Message-ID: <20030724133356.GC4296@linux_rln.harvest>
Reply-To: cygwin-patches@cygwin.com
References: <20030723171718.GA2875@linux_rln.harvest> <16159.8636.275403.480394@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16159.8636.275403.480394@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
X-Disclaimer: I had nothing to do with it - I swear!
X-loop: linux_rln.harvest
X-SW-Source: 2003-q3/txt/msg00042.txt.bz2

Right you are - I forgot I copied the script.

Sorry about that :|

rlc

On Wed, Jul 23, 2003 at 05:01:00PM -0700, David Rothenberger wrote:
> Ronald Landheer-Cieslak writes:
>  > The attached patch fixes a (micro) problem that has been bugging me for a while
>  > now: the various header files could not be installed with a `make install` 
>  > without creating the proper directories first.
>  > 
>  > patch is against current CVS
>  > 
>  > HTH
>  > 
>  > rlc
> 
> 
> The supplier patch didn't work for me, because it assumed
> mkinstalldirs was in src/winsup/cygwin instead of src.  The
> following patch (against current CVS) works for me.
> 
> Dave
> 
> --
> 
> diff -u -r1.127 Makefile.in
> --- Makefile.in 7 Jul 2003 05:30:33 -0000       1.127
> +++ Makefile.in 24 Jul 2003 00:00:12 -0000
> @@ -269,6 +269,7 @@
>         cd $(srcdir); \
>         for sub in `find include -name '[a-z]*' -type d -print | sort`; do \
>             for i in $$sub/*.h ; do \
> +             $(SHELL) $(srcdir)/../../mkinstalldirs $(tooldir)/$$sub ; \
>               $(INSTALL_DATA) $$i $(tooldir)/$$sub/`basename $$i` ; \
>             done ; \
>         done ; \
> @@ -276,15 +277,19 @@
>  
>  install-man:
>         cd $(srcdir); \
> +       $(SHELL) $(srcdir)/../../mkinstalldirs $(tooldir)/man/man2 ; \
>         for i in `find . -type f -name '*.2'`; do \
>             $(INSTALL_DATA) $$i $(tooldir)/man/man2/`basename $$i` ; \
>         done; \
> +       $(SHELL) $(srcdir)/../../mkinstalldirs $(tooldir)/man/man3 ; \
>         for i in `find . -type f -name '*.3'`; do \
>             $(INSTALL_DATA) $$i $(tooldir)/man/man3/`basename $$i` ; \
>         done; \
> +       $(SHELL) $(srcdir)/../../mkinstalldirs $(tooldir)/man/man5 ; \
>         for i in `find . -type f -name '*.5'`; do \
>             $(INSTALL_DATA) $$i $(tooldir)/man/man5/`basename $$i` ; \
>         done; \
> +       $(SHELL) $(srcdir)/../../mkinstalldirs $(tooldir)/man/man7 ; \
>         for i in `find . -type f -name '*.7'`; do \
>             $(INSTALL_DATA) $$i $(tooldir)/man/man7/`basename $$i` ; \
>         done

-- 
