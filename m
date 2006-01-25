Return-Path: <cygwin-patches-return-5722-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1869 invoked by alias); 25 Jan 2006 14:14:54 -0000
Received: (qmail 1854 invoked by uid 22791); 25 Jan 2006 14:14:53 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 25 Jan 2006 14:14:50 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k0PEEmA7015339 	for <cygwin-patches@cygwin.com>; Wed, 25 Jan 2006 09:14:48 -0500 (EST)
Date: Wed, 25 Jan 2006 14:14:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
In-Reply-To: <20060125105240.GM8318@calimero.vinschen.de>
Message-ID: <Pine.GSO.4.63.0601250907210.2078@access1.cims.nyu.edu>
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de>
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
X-SW-Source: 2006-q1/txt/msg00031.txt.bz2

On Wed, 25 Jan 2006, Corinna Vinschen wrote:

> On Jan 24 21:00, Christian Franke wrote:
> > Hi,
> >
> > the attached patch adds commands "load" and "unload" and options "-b,
> > --binary" to regtool.
> >
> > Load a registry hive from PATH into new SUBKEY:
> >
> > regtool load KEY\SUBKEY PATH
> >
> > Unload and remove SUBKEY later:
> >
> > regtool unload KEY\SUBKEY
> >
> > Print REG_BINARY value as hex:
> >
> > regtool -b get KEY\VALUE
> >
> > Set REG_BINARY value from hex args:
> >
> > regtool -b set KEY\VALUE XX XX XX XX ...
> >
> > [snip]
> > Thanks for any comment
>
> Thanks for this patch, it looks pretty useful.
> [snip]

I wonder if it would be better to use stdin/stdout for binary data (or
even add a -f option for set).  IMHO,

regtool -b get KEY1\\VALUE | regtool -b set KEY2\\VALUE

or

regtool -b get KEY1\\VALUE | regtool -b set -f - KEY2\\VALUE

looks cleaner than storing the hex encoding into a string...  If you want
a hex dump,

regtool -b get KEY1\\VALUE | od -t x1

will do it.  I'm not aware of any program that does the reverse
(hex dump->binary), but writing a perl script for that is trivial.

That said, I also think this functionality would be very useful.
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
