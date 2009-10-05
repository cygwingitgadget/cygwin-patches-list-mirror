Return-Path: <cygwin-patches-return-6690-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30365 invoked by alias); 5 Oct 2009 00:28:46 -0000
Received: (qmail 30355 invoked by uid 22791); 5 Oct 2009 00:28:46 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta15.emeryville.ca.mail.comcast.net (HELO QMTA15.emeryville.ca.mail.comcast.net) (76.96.27.228)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 00:28:40 +0000
Received: from OMTA02.emeryville.ca.mail.comcast.net ([76.96.30.19]) 	by QMTA15.emeryville.ca.mail.comcast.net with comcast 	id oo6m1c01q0QkzPwAFoUgPL; Mon, 05 Oct 2009 00:28:40 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA02.emeryville.ca.mail.comcast.net with comcast 	id ooUe1c00N0Lg2Gw8NoUf6n; Mon, 05 Oct 2009 00:28:40 +0000
Message-ID: <4AC93DB5.5020303@byu.net>
Date: Mon, 05 Oct 2009 00:28:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
References: <4AC66C72.7070102@gmail.com>
In-Reply-To: <4AC66C72.7070102@gmail.com>
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
X-SW-Source: 2009-q4/txt/msg00021.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Dave Korn on 10/2/2009 3:11 PM:
>   So, nobody did ask for a compiler version check(*), so here's the patch plus
> changelog, and I'd like to get separate OKs from both cgf and cv to say that
> you've each either updated your cross-build environments or don't mind
> patching the flag back out locally until you can.

I just noticed that the gcc-4 available on 1.5 is no longer sufficient to
do a self-hosted build of 1.7.  Not a show-stopper, since I have
successfully built self-hosted under 1.7 using the latest patch, but it
was kind of kind of convenient being able to build under 1.5, as it meant
fewer cygwin 1.7 processes to stop before installing a just-built dll.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrJPbUACgkQ84KuGfSFAYA2AACguMNRRTlBF8Xr13GFuXYIXGY2
ys8AniPju+xmh4U7FcDNGA4kR7y9cG7b
=4LaJ
-----END PGP SIGNATURE-----
