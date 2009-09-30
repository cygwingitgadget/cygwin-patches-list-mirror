Return-Path: <cygwin-patches-return-6667-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30335 invoked by alias); 30 Sep 2009 19:04:38 -0000
Received: (qmail 30177 invoked by uid 22791); 30 Sep 2009 19:04:37 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta07.emeryville.ca.mail.comcast.net (HELO QMTA07.emeryville.ca.mail.comcast.net) (76.96.30.64)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 19:04:25 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60]) 	by QMTA07.emeryville.ca.mail.comcast.net with comcast 	id n2YG1c0031HpZEsA774R5q; Wed, 30 Sep 2009 19:04:25 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA14.emeryville.ca.mail.comcast.net with comcast 	id n74P1c00C0Lg2Gw8a74QK4; Wed, 30 Sep 2009 19:04:24 +0000
Message-ID: <4AC3ABA4.9090905@byu.net>
Date: Wed, 30 Sep 2009 19:04:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: detect . in a/.//
References: <4AC34A01.4070509@byu.net>  <20090930152438.GA11977@ednor.casa.cgf.cx> <20090930153451.GA12182@ednor.casa.cgf.cx>
In-Reply-To: <20090930153451.GA12182@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00121.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/30/2009 9:34 AM:
>> Is this function supposed to detect just "." or "*/."?

Both.

>   /* SUSv3: . and .. are not allowed as last components in various system
>      calls.  Don't test for backslash path separator since that's a Win32
>      path following Win32 rules. */
>   const char *last_comp = strrchr (dir, '\0');

Looked like a decent rewrite to me, except why did you use strrchr instead
of strchr to find the end of the string?

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrDq6QACgkQ84KuGfSFAYDkEQCgt4wpQPmooB5IhJgPDI/jLJjI
ScEAoIc9OlvPD8CYUVYt6r1QABYn8tyD
=CEG6
-----END PGP SIGNATURE-----
