Return-Path: <cygwin-patches-return-6620-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26591 invoked by alias); 9 Sep 2009 23:52:52 -0000
Received: (qmail 26396 invoked by uid 22791); 9 Sep 2009 23:52:50 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta13.emeryville.ca.mail.comcast.net (HELO QMTA13.emeryville.ca.mail.comcast.net) (76.96.27.243)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 09 Sep 2009 23:52:45 +0000
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36]) 	by QMTA13.emeryville.ca.mail.comcast.net with comcast 	id emtc1c00N0mlR8UADnslhz; Wed, 09 Sep 2009 23:52:45 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA11.emeryville.ca.mail.comcast.net with comcast 	id ensj1c0090Lg2Gw8Xnska1; Wed, 09 Sep 2009 23:52:45 +0000
Message-ID: <4AA83FC0.9070703@byu.net>
Date: Wed, 09 Sep 2009 23:52:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
References: <loom.20090903T175736-252@post.gmane.org>  <4AA01449.6060707@byu.net>  <20090903191856.GB3998@ednor.casa.cgf.cx>  <20090903210438.GA25677@calimero.vinschen.de>  <20090907200539.GA4489@ednor.casa.cgf.cx>  <20090908191657.GA17515@calimero.vinschen.de>  <20090908201635.GA25289@ednor.casa.cgf.cx>  <4AA7AFCE.2060705@gmail.com> <20090909155900.GA29003@ednor.casa.cgf.cx>
In-Reply-To: <20090909155900.GA29003@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
X-SW-Source: 2009-q3/txt/msg00074.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/9/2009 9:59 AM:
> Of course, all of the hundreds of changes that have gone into newlib
> really are suspect too.  Why is it ok to change something in one
> directory and not another?  I think (and have always thought) that there
> is a huge hole in that there are lots of changes in the newlib directory
> which have never been assigned.

And up till now, I've exploited that hole rather handily ;)  But now that
my papers are in the mail, hopefully they count retroactively for my
non-trivial sum total over the past.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqoP8AACgkQ84KuGfSFAYCyvQCfcSIGVojBcU9FQA1ce7+HIfB6
CPMAoIA7Cw7kxMzZWgBaTRRSkVOk6V9F
=GRBh
-----END PGP SIGNATURE-----
