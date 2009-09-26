Return-Path: <cygwin-patches-return-6653-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14649 invoked by alias); 26 Sep 2009 21:02:01 -0000
Received: (qmail 14426 invoked by uid 22791); 26 Sep 2009 21:02:00 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta03.emeryville.ca.mail.comcast.net (HELO QMTA03.emeryville.ca.mail.comcast.net) (76.96.30.32)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 26 Sep 2009 21:01:55 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60]) 	by QMTA03.emeryville.ca.mail.comcast.net with comcast 	id lYYg1c0071HpZEsA3Z1uqk; Sat, 26 Sep 2009 21:01:55 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA14.emeryville.ca.mail.comcast.net with comcast 	id lZ1s1c0030Lg2Gw8aZ1tbg; Sat, 26 Sep 2009 21:01:53 +0000
Message-ID: <4ABE813F.7050001@byu.net>
Date: Sat, 26 Sep 2009 21:02:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: fexecve, execvpe
References: <4ABE76F8.1050601@byu.net> <20090926203740.GA17538@ednor.casa.cgf.cx>
In-Reply-To: <20090926203740.GA17538@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00107.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/26/2009 2:37 PM:
> Yes, thanks.

Done.

>> P.S Any reason that "dtable.h" and "cygheap.h" aren't self-contained?
> 
> Since I don't know exactly what you're talking about I'll say "Yes".

When I added just #include "cygheap.h" to exec.cc, I still got compiler
errors.  There were incomplete/undefined types until I also added "sync.h"
and "fhandler.h" prior to "cygheap.h".  I'm just wondering whether
cygheap.h should include these files itself, so that clients don't have to
do it.  But I'm not too worried - there aren't that many clients.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq+gT8ACgkQ84KuGfSFAYC03gCgrk+53fmwKkX4l5U0Harij92K
CKEAoIwMBsZUhcF34gJzN2a9SvDu35zY
=zObR
-----END PGP SIGNATURE-----
