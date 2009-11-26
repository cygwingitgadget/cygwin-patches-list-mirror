Return-Path: <cygwin-patches-return-6856-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15623 invoked by alias); 26 Nov 2009 12:22:01 -0000
Received: (qmail 15595 invoked by uid 22791); 26 Nov 2009 12:22:00 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta15.emeryville.ca.mail.comcast.net (HELO QMTA15.emeryville.ca.mail.comcast.net) (76.96.27.228)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Nov 2009 12:21:55 +0000
Received: from OMTA04.emeryville.ca.mail.comcast.net ([76.96.30.35]) 	by QMTA15.emeryville.ca.mail.comcast.net with comcast 	id 9oKt1d0010lTkoCAFoMvWg; Thu, 26 Nov 2009 12:21:55 +0000
Received: from [192.168.0.104] ([24.10.247.15]) 	by OMTA04.emeryville.ca.mail.comcast.net with comcast 	id 9oMt1d0010Lg2Gw8QoMuxj; Thu, 26 Nov 2009 12:21:54 +0000
Message-ID: <4B0E72E2.4000805@byu.net>
Date: Thu, 26 Nov 2009 12:22:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: patch: sleep/nanosleep bug
References: <4B045581.4040301@byu.net>  <20091118204709.GA3461@ednor.casa.cgf.cx>  <4B06A48C.5050904@byu.net>  <4B0D2CE5.4000000@byu.net> <20091126112121.GP29173@calimero.vinschen.de>
In-Reply-To: <20091126112121.GP29173@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00187.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 11/26/2009 4:21 AM:
>>> How about the following, then?  Same changelog.
>> Ping.
> 
> Do you think we need it in 1.7.1?

I suppose I can camp on it until after the release.  It's not very likely
that someone does 'sleep 50d', and the 100% CPU utilization bug in that
case is not a regression since cygwin 1.5 did the same.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAksOcuIACgkQ84KuGfSFAYBA4gCfWVfYgYv5YO5subCMtWwQWx/r
V4kAniilOEpnZcX314OLraYqRK/7mTFZ
=pOU5
-----END PGP SIGNATURE-----
