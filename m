Return-Path: <cygwin-patches-return-6487-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18489 invoked by alias); 7 Apr 2009 12:56:51 -0000
Received: (qmail 18478 invoked by uid 22791); 7 Apr 2009 12:56:50 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta08.emeryville.ca.mail.comcast.net (HELO QMTA08.emeryville.ca.mail.comcast.net) (76.96.30.80)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 12:56:44 +0000
Received: from OMTA05.emeryville.ca.mail.comcast.net ([76.96.30.43]) 	by QMTA08.emeryville.ca.mail.comcast.net with comcast 	id ccwY1b0030vp7WLA8cwkqX; Tue, 07 Apr 2009 12:56:44 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA05.emeryville.ca.mail.comcast.net with comcast 	id ccwi1b00H0Lg2Gw8RcwjE8; Tue, 07 Apr 2009 12:56:43 +0000
Message-ID: <49DB4D95.7000903@byu.net>
Date: Tue, 07 Apr 2009 12:56:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx>
In-Reply-To: <20090404062459.GB22452@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00029.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 4/4/2009 12:24 AM:
>> Because our stdint.h types are divergent from Linux, and changing them
>> instead could cause yet another ABI break.
> 
> Why would changing uint32_t from 'unsigned long' to 'unsigned int' break
> anything?  It looks to me like that is a disaster waiting to happen if
> we ever provide a 64-bit port.

If we ever provide a 64-bit port, then we are free to use #ifdef magic to
select a different underlying type on 64-bit compiles than on 32-bit
compiles.  In one sense, using a different type between the two builds
will flush out coding bugs where the wrong type specifiers are used (for
example, printf("%ld", (int32_t)val) should have been written
printf("%"PRI32d, (int32_t)val).

On the other hand, the fact that cygwin differs from Linux is already
flushing out these types of coding bugs.  Making the ABI change now (which
probably won't affect C apps, but will definitely affect any C++ code that
used uint32_t and friends in mangled names) will mean that cygwin no
longer trips true bugs in apps originally written on Linux by people not
aware of the issue.  It means easier porting jobs to cygwin, but also that
lurking bugs are that much harder to find when porting to yet another system.

I'm not sure we need the ABI change.  But I'm with Dave that IF we decide
the ABI change is the right thing to do, then NOW is the only time worth
doing it.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknbTSwACgkQ84KuGfSFAYDP8ACgsENCESTjm6ANnyiBKPcTLr3E
zWcAniczYlqVaN5WiEH82riv3aKkZg9b
=YaqT
-----END PGP SIGNATURE-----
