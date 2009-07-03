Return-Path: <cygwin-patches-return-6550-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20224 invoked by alias); 3 Jul 2009 19:19:08 -0000
Received: (qmail 20209 invoked by uid 22791); 3 Jul 2009 19:19:07 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_36,J_CHICKENPOX_62,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta04.emeryville.ca.mail.comcast.net (HELO QMTA04.emeryville.ca.mail.comcast.net) (76.96.30.40)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Jul 2009 19:19:02 +0000
Received: from OMTA09.emeryville.ca.mail.comcast.net ([76.96.30.20]) 	by QMTA04.emeryville.ca.mail.comcast.net with comcast 	id BXJK1c0060S2fkCA4XK1oF; Fri, 03 Jul 2009 19:19:01 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA09.emeryville.ca.mail.comcast.net with comcast 	id BXJz1c00H0Lg2Gw8VXK02s; Fri, 03 Jul 2009 19:19:01 +0000
Message-ID: <4A4E59AE.60904@byu.net>
Date: Fri, 03 Jul 2009 19:19:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: mkstemps
References: <4A46A3AB.2060604@byu.net>  <20090628103249.GX30864@calimero.vinschen.de>  <4A4DFA3E.2010909@byu.net>  <4A4DFAE4.3090008@byu.net>  <20090703130134.GB12258@calimero.vinschen.de> <20090703151740.GA26910@ednor.casa.cgf.cx>
In-Reply-To: <20090703151740.GA26910@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00004.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 7/3/2009 9:17 AM:
> Is there some reason why we're not just using the newlib version of all
> of these functions?  I have stared at the code in mktemp.cc and the only
> thing I see that seems to be Cygwin specific is the arc4random function.
> Is the security that this provides the only reason not to use newlib?
> 
> That is probably a good enough reason right there but I was just
> wondering.

Well, before today, cygwin had mkdtemp but newlib didn't.  But you are
correct that after today, the only substantial difference is getpid() vs.
arc4random().  For mkstemp, this is not an issue.  But guess which one is
more predictable, and thus makes for a less secure mktemp (even though we
already have a compiler warning that mktemp is insecure)?

Maybe it would be worth pushing the arc4random approach to newlib?

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpOWa0ACgkQ84KuGfSFAYBqogCfbq969nRymTzsqvHbkOYHB3mL
4RgAmQF1Qw5L8z35YWhi44s6eJArhNYi
=wxDh
-----END PGP SIGNATURE-----
