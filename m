Return-Path: <cygwin-patches-return-6498-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 873 invoked by alias); 7 Apr 2009 19:05:56 -0000
Received: (qmail 854 invoked by uid 22791); 7 Apr 2009 19:05:54 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta12.emeryville.ca.mail.comcast.net (HELO QMTA12.emeryville.ca.mail.comcast.net) (76.96.27.227)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 19:05:49 +0000
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11]) 	by QMTA12.emeryville.ca.mail.comcast.net with comcast 	id ceS01b0090EPchoACj5o1y; Tue, 07 Apr 2009 19:05:48 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA01.emeryville.ca.mail.comcast.net with comcast 	id cj5n1b0090Lg2Gw8Mj5oRZ; Tue, 07 Apr 2009 19:05:48 +0000
Message-ID: <49DBA417.1030707@byu.net>
Date: Tue, 07 Apr 2009 19:05:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm> <20090407131534.GY852@calimero.vinschen.de>
In-Reply-To: <20090407131534.GY852@calimero.vinschen.de>
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
X-SW-Source: 2009-q2/txt/msg00040.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 4/7/2009 7:15 AM:
> Good point, I guess.  So, if we all agree on that, I'd suggest to
> change Dave's patch to the one below.
> 
> 
> Corinna
> 
> 
> 	* include/stdint.h (int_least32_t): Define as int.

Are there any corresponding patches needed to <inttypes.h>?  I haven't
checked yet, but we should make absolutely sure that we are consistent
across all uses of these types.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknbpBcACgkQ84KuGfSFAYC8HACgpSu3RGr3n8VTGPfflpc/pY8i
/3QAn3iPmPDCk9iFNOOXU4rP34ijTfR1
=XNoy
-----END PGP SIGNATURE-----
