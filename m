Return-Path: <cygwin-patches-return-5672-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6301 invoked by alias); 5 Nov 2005 19:17:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6290 invoked by uid 22791); 5 Nov 2005 19:17:15 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sat, 05 Nov 2005 19:17:15 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id EC32313C6C1; Sat,  5 Nov 2005 14:17:13 -0500 (EST)
Date: Sat, 05 Nov 2005 19:17:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Translate INSUFFICIENT_RESOURCES errno
Message-ID: <20051105191713.GA24715@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0511051037180.508@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0511051037180.508@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q4/txt/msg00014.txt.bz2

On Sat, Nov 05, 2005 at 10:41:35AM -0600, Brian Ford wrote:
>Trivial patch to do subject.  This would have made the error in this
>thread more consistent:
>
>http://cygwin.com/ml/cygwin/2005-11/msg00110.html
>
>2005-11-05  Brian Ford  <Brian.Ford@FlightSafety.com>
>
>	* errno.cc (errmap): Handle INSUFFICIENT_RESOURCES.

/usr/bin/ccache distcc /cygwin/bin/i686-pc-cygwin-g++ -c -gstabs+ -O2 -MMD -fmerge-constants -ftracer ... errno.cc
/cygnus/src/uberbaum/winsup/cygwin/errno.cc:74: error: `ERROR_INSUFFICIENT_RESOURCES' was not declared in this scope
distcc[21947] ERROR: compile /cygnus/src/uberbaum/winsup/cygwin/errno.cc on localhost failed
make: *** [errno.o] Error 1
make: *** [/cygnus/build/win32/i686-pc-cygwin/winsup/cygwin/cygwin0.dll] Error 2

I just downloaded MSDEV C++ and the Platform SDK and I don't see an
ERROR_INSUFFICIENT_RESOURCES in either of them although I do see this
referenced in MSDN in some places.  I didn't see a numeric value for
this constant in MSDN, though.  I didn't check every single reference,
however.

So, maybe I'm missing something but I'm afraid that I'll have to say
thanks-but-no-thanks for the patch.  I can't accept it if it doesn't
compile.  It would be a no-brainer if there was a value associated with
ERROR_INSUFFICIENT_RESOURCES.

cgf
