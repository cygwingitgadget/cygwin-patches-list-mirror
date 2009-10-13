Return-Path: <cygwin-patches-return-6764-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5471 invoked by alias); 13 Oct 2009 12:21:29 -0000
Received: (qmail 5460 invoked by uid 22791); 13 Oct 2009 12:21:28 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta05.emeryville.ca.mail.comcast.net (HELO QMTA05.emeryville.ca.mail.comcast.net) (76.96.30.48)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Oct 2009 12:21:24 +0000
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11]) 	by QMTA05.emeryville.ca.mail.comcast.net with comcast 	id sCCa1c0060EPchoA5CMQCt; Tue, 13 Oct 2009 12:21:24 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA01.emeryville.ca.mail.comcast.net with comcast 	id sCMN1c0070Lg2Gw8MCMPhL; Tue, 13 Oct 2009 12:21:23 +0000
Message-ID: <4AD470C3.2070502@byu.net>
Date: Tue, 13 Oct 2009 12:21:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de> <4AD46C1F.7080902@byu.net> <20091013121752.GA9571@calimero.vinschen.de>
In-Reply-To: <20091013121752.GA9571@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00095.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 10/13/2009 6:17 AM:
>> Not the first time this is done in this function.  But generally,
>> shouldn't we follow the good practice of using va_end any time we used
>> va_arg, in case cygwin is ever ported to a system where va_end is more
>> than a no-op?  [At least, I'm assuming that __builtin_va_end() is a no-op
>> for x86?]
> 
> That's probably a good idea, given that POSIX requires the usage of
> va_end.  PTC?

Sure, I'll do an audit.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrUcMMACgkQ84KuGfSFAYCrngCfbAYGeGsmatSNZVyKkBSOqotl
cY0An3rGFaS2cQ1RErZsbKDVJUutE1xF
=F1oq
-----END PGP SIGNATURE-----
