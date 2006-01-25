Return-Path: <cygwin-patches-return-5727-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18143 invoked by alias); 25 Jan 2006 23:02:36 -0000
Received: (qmail 18130 invoked by uid 22791); 25 Jan 2006 23:02:35 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 25 Jan 2006 23:02:34 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k0PN2WA7026096; 	Wed, 25 Jan 2006 18:02:32 -0500 (EST)
Date: Wed, 25 Jan 2006 23:02:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Brian Dessent <brian@dessent.net>
cc: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
In-Reply-To: <43D7FEF5.62A5A4D@dessent.net>
Message-ID: <Pine.GSO.4.63.0601251753110.839@access1.cims.nyu.edu>
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de>  <Pine.GSO.4.63.0601250907210.2078@access1.cims.nyu.edu> <43D7EFBE.5010505@t-online.de>  <43D7FEF5.62A5A4D@dessent.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00036.txt.bz2

On Wed, 25 Jan 2006, Brian Dessent wrote:

> Christian Franke wrote:
>
> > At least when regtool is used interactively, it is IMO not very useful
> > to have modem-line-noise-like output for REG_BINARY, but human
> > readable output for the other value types. But this is the current
> > behavior of "regtool get ...".
>
> Instead of an explicit -b flag, perhaps it should just call isatty() and
> if being run interactively, output human readable hex dump, otherwise
> output raw binary.

What if you want to redirect the hex dump to a file?  IMO, isatty() checks
are only useful if the output won't change qualitatively on redirection
(e.g., for coloring).  Otherwise, it's always better to use an explicit
flag.

That said, attempting to "regtool get" a binary value is no different from
attempting to cat a binary file -- and we're not changing "cat" to output
hex dumps.  What would be useful instead is a way to query the type of a
value via regtool.  We could also add a "-h" (for --human-readable) flag
to always output the value in human-readable form (see below).

FWIW, 'A=`regtool get KEY1\\VAL`; regtool set KEY2\\VAL "$A"' will already
break for REG_MULTI_SZ type values.  It would be good to make regtool's
behavior consistent: "regtool set -f FILE" reads the value from FILE,
which would work for all value types.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
