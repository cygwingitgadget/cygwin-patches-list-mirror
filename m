Return-Path: <cygwin-patches-return-6849-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5735 invoked by alias); 25 Nov 2009 13:11:17 -0000
Received: (qmail 5724 invoked by uid 22791); 25 Nov 2009 13:11:16 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta07.emeryville.ca.mail.comcast.net (HELO QMTA07.emeryville.ca.mail.comcast.net) (76.96.30.64)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 25 Nov 2009 13:11:08 +0000
Received: from OMTA17.emeryville.ca.mail.comcast.net ([76.96.30.73]) 	by QMTA07.emeryville.ca.mail.comcast.net with comcast 	id 9R5i1d0021afHeLA7RB8Pk; Wed, 25 Nov 2009 13:11:08 +0000
Received: from [192.168.0.104] ([24.10.247.15]) 	by OMTA17.emeryville.ca.mail.comcast.net with comcast 	id 9RAx1d00D0Lg2Gw8dRB7Pe; Wed, 25 Nov 2009 13:11:08 +0000
Message-ID: <4B0D2CE5.4000000@byu.net>
Date: Wed, 25 Nov 2009 13:11:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: patch: sleep/nanosleep bug
References: <4B045581.4040301@byu.net> <20091118204709.GA3461@ednor.casa.cgf.cx> <4B06A48C.5050904@byu.net>
In-Reply-To: <4B06A48C.5050904@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00180.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 11/20/2009 7:15 AM:
>>> 	* signal.cc (nanosleep): Support 'infinite' sleep times.
>>> 	(sleep): Avoid uninitialized memory.
>> Sorry but, while I agree with the basic idea, this seems like
>> unnecessary use of recursion.  It seems like you could accomplish the
>> same thing by just putting the cancelable_wait in a for loop.  I think
>> adding recursion here obfuscates the function unnecesarily.
> 
> How about the following, then?  Same changelog.

Ping.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAksNLOUACgkQ84KuGfSFAYDjkACfSUKXFSAi2jMS2GNAAqDhfpbT
NRUAoMkRUmS/WGUU45Z6OgCNbgXiocYe
=ttYg
-----END PGP SIGNATURE-----
