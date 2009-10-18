Return-Path: <cygwin-patches-return-6782-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17688 invoked by alias); 18 Oct 2009 15:24:27 -0000
Received: (qmail 17674 invoked by uid 22791); 18 Oct 2009 15:24:26 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta13.emeryville.ca.mail.comcast.net (HELO QMTA13.emeryville.ca.mail.comcast.net) (76.96.27.243)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 15:24:22 +0000
Received: from OMTA09.emeryville.ca.mail.comcast.net ([76.96.30.20]) 	by QMTA13.emeryville.ca.mail.comcast.net with comcast 	id uETM1c0020S2fkCADFQMBP; Sun, 18 Oct 2009 15:24:21 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA09.emeryville.ca.mail.comcast.net with comcast 	id uFQL1c0060Lg2Gw8VFQMmF; Sun, 18 Oct 2009 15:24:21 +0000
Message-ID: <4ADB3334.2080502@byu.net>
Date: Sun, 18 Oct 2009 15:24:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm> <4AD8DE16.3030506@cwilson.fastmail.fm> <20091018084824.GA25560@calimero.vinschen.de> <4ADB22B8.5060108@cwilson.fastmail.fm>
In-Reply-To: <4ADB22B8.5060108@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00113.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Charles Wilson on 10/18/2009 8:14 AM:
> IMO, Keith is being unreasonable about "if DESTDIR doesn't work on
> win32, we shouldn't add support for it even for those platforms where it
> will work".  He's graciously allowed that this patch could go in, IF I
> convince the automake and autoconf developers to completely redesign the
>  way DESTDIR works so that it accommodates X: paths.

Well, that won't happen unless Keith starts a thread on the autoconf list
giving suggestions on how he thinks it can be fixed.  Complaining on the
subscriber-only mingw is the wrong approach to get autoconf to even be
aware of his complaint or ideas for improvement (not that me replying on
the cygwin-patches list is any better ;)

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrbMzQACgkQ84KuGfSFAYBC3wCfST0/iPF1HAXW0u/72dV+wXrg
/u8An06bosGnlxTB8qaaHKwF1VLDjj9F
=cuXn
-----END PGP SIGNATURE-----
