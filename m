Return-Path: <cygwin-patches-return-6762-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21722 invoked by alias); 13 Oct 2009 12:01:42 -0000
Received: (qmail 21449 invoked by uid 22791); 13 Oct 2009 12:01:41 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta07.emeryville.ca.mail.comcast.net (HELO QMTA07.emeryville.ca.mail.comcast.net) (76.96.30.64)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Oct 2009 12:01:35 +0000
Received: from OMTA05.emeryville.ca.mail.comcast.net ([76.96.30.43]) 	by QMTA07.emeryville.ca.mail.comcast.net with comcast 	id sBdG1c0050vp7WLA7C1bLB; Tue, 13 Oct 2009 12:01:35 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA05.emeryville.ca.mail.comcast.net with comcast 	id sC1Z1c0050Lg2Gw8RC1aKF; Tue, 13 Oct 2009 12:01:35 +0000
Message-ID: <4AD46C1F.7080902@byu.net>
Date: Tue, 13 Oct 2009 12:01:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de>
In-Reply-To: <4AD243ED.6080505@t-online.de>
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
X-SW-Source: 2009-q4/txt/msg00093.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christian Franke on 10/11/2009 2:45 PM:
> 2009-10-11  Christian Franke  <franke@computer.org>
>            Corinna Vinschen  <corinna@vinschen.de>
> 
>     * include/sys/cygwin.h: Add new cygwin_getinfo_type
>     CW_SET_EXTERNAL_TOKEN.
>     Add new enum CW_TOKEN_IMPERSONATION, CW_TOKEN_RESTRICTED.

Shouldn't we also bump version.h when adding new CW_ flags?

> +      case CW_SET_EXTERNAL_TOKEN:
> +	{
> +	  HANDLE token = va_arg (arg, HANDLE);
> +	  int type = va_arg (arg, int);
> +	  set_imp_token (token, type);
> +	  return 0;
> +	}

Not the first time this is done in this function.  But generally,
shouldn't we follow the good practice of using va_end any time we used
va_arg, in case cygwin is ever ported to a system where va_end is more
than a no-op?  [At least, I'm assuming that __builtin_va_end() is a no-op
for x86?]

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrUbB4ACgkQ84KuGfSFAYAHOQCgt+MI1ALkqnMMwPX6QlJ7VwJZ
mYMAn37mvgvZDZzBw27vXcKutLGwilpW
=8hvQ
-----END PGP SIGNATURE-----
