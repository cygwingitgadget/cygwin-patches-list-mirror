Return-Path: <cygwin-patches-return-6794-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18642 invoked by alias); 23 Oct 2009 06:21:10 -0000
Received: (qmail 18617 invoked by uid 22791); 23 Oct 2009 06:21:09 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail.gmx.net (HELO mail.gmx.net) (213.165.64.20)     by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 23 Oct 2009 06:21:04 +0000
Received: (qmail invoked by alias); 23 Oct 2009 06:21:01 -0000
Received: from xdsl-87-78-92-122.netcologne.de (EHLO localhost.localdomain) [87.78.92.122]   by mail.gmx.net (mp043) with SMTP; 23 Oct 2009 08:21:01 +0200
Received: from ralf by localhost.localdomain with local (Exim 4.69) 	(envelope-from <Ralf.Wildenhues@gmx.de>) 	id 1N1DWH-0005kW-6M 	for cygwin-patches@cygwin.com; Fri, 23 Oct 2009 08:21:01 +0200
Date: Fri, 23 Oct 2009 06:21:00 -0000
From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
Message-ID: <20091023062100.GA21987@gmx.de>
References: <4AD78C5B.2080107@cwilson.fastmail.fm>  <4AE0DE77.3090300@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AE0DE77.3090300@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.20 (2009-08-09)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00125.txt.bz2

Hi Chuck,

* Charles Wilson wrote on Fri, Oct 23, 2009 at 12:36:39AM CEST:
> --- mingw/Makefile.in	27 Jul 2009 20:27:09 -0000	1.89
> +++ mingw/Makefile.in	22 Oct 2009 20:43:27 -0000

> @@ -204,6 +207,7 @@ FLAGS_TO_PASS:=\
>  	RANLIB="$(RANLIB)" \
>  	LD="$(LD)" \
>  	DLLTOOL="$(DLLTOOL)" \
> +	DESTDIR="$(DESTDIR)" \
>  	exec_prefix="$(exec_prefix)" \
>  	bindir="$(bindir)" \
>  	libdir="$(libdir)" \

> +check-DESTDIR-compatibility:
> +	 @test -z "$(DESTDIR)" || { status=0; \
> +	   for path in $(need-DESTDIR-compatibility); do \
> +	     $(MAKE) --no-print-directory $$path  DESTDIR="$(DESTDIR)" || status=$$?; \

As long as none of the subordinate makefiles initialize DESTDIR (which
they shouldn't), you don't need to ever actually need to set DESTDIR
anywhere.  But it shouldn't hurt either.

> +$(need-DESTDIR-compatibility):
> +	 @case "$($@)" in *:*) \

Wouldn't ?:* suffice?  Not that I'd like anyone to use a path with a
colon stuck in the middle of it on unix, but it certainly wouldn't be a
Win32 path.

> +	   echo DESTDIR is not supported when $@ contains Win32 path \`$($@)\'\; \

Cheers,
Ralf
