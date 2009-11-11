Return-Path: <cygwin-patches-return-6830-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27149 invoked by alias); 11 Nov 2009 12:55:13 -0000
Received: (qmail 27129 invoked by uid 22791); 11 Nov 2009 12:55:12 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta08.emeryville.ca.mail.comcast.net (HELO QMTA08.emeryville.ca.mail.comcast.net) (76.96.30.80)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Nov 2009 12:55:08 +0000
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36]) 	by QMTA08.emeryville.ca.mail.comcast.net with comcast 	id 3ofl1d0040mlR8UA8ov8X4; Wed, 11 Nov 2009 12:55:08 +0000
Received: from [192.168.0.104] ([24.10.247.15]) 	by OMTA11.emeryville.ca.mail.comcast.net with comcast 	id 3ov71d0010Lg2Gw8Xov7lS; Wed, 11 Nov 2009 12:55:08 +0000
Message-ID: <4AFAB42C.1020404@byu.net>
Date: Wed, 11 Nov 2009 12:55:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
References: <4AFA6675.6070408@users.sourceforge.net> <20091111094119.GA3564@calimero.vinschen.de> <4AFA907E.1050408@users.sourceforge.net>
In-Reply-To: <4AFA907E.1050408@users.sourceforge.net>
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
X-SW-Source: 2009-q4/txt/msg00161.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Yaakov (Cygwin/X) on 11/11/2009 3:22 AM:
> On 11/11/2009 03:41, Corinna Vinschen wrote:
>> Thanks, but, wouldn't it be simpler to implement them as macros in
>> sys/sysinfo.h?
> 
> Implementing them as macros won't help an autoconf AC_CHECK_FUNC or
> cmake CHECK_FUNCTION_EXISTS test.

Also, the upcomining coreutils 8.1 will be adding nproc(1), to make
scripting for parallel jobs easier by exposing these functions to shell
users.  +1 on the concept from me, although why does sys/sysinfo.h have to
forward to cygwin/sysinfo.h, rather than directly declaring the two functions?

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkr6tCwACgkQ84KuGfSFAYBciACfS1e4O0xVJkoN2n/6aVFb4yB0
y38AoLL2u+5iI/UXEfumS6w/XLyyU2KU
=JFbr
-----END PGP SIGNATURE-----
