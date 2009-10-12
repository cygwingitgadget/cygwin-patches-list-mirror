Return-Path: <cygwin-patches-return-6758-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29632 invoked by alias); 12 Oct 2009 12:50:17 -0000
Received: (qmail 29617 invoked by uid 22791); 12 Oct 2009 12:50:16 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta14.emeryville.ca.mail.comcast.net (HELO QMTA14.emeryville.ca.mail.comcast.net) (76.96.27.212)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 12 Oct 2009 12:50:12 +0000
Received: from OMTA19.emeryville.ca.mail.comcast.net ([76.96.30.76]) 	by QMTA14.emeryville.ca.mail.comcast.net with comcast 	id ronm1c0081eYJf8AEoqBB6; Mon, 12 Oct 2009 12:50:11 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA19.emeryville.ca.mail.comcast.net with comcast 	id roqA1c0010Lg2Gw01oqB4h; Mon, 12 Oct 2009 12:50:11 +0000
Message-ID: <4AD32603.3050307@byu.net>
Date: Mon, 12 Oct 2009 12:50:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: utimensat UTIME_NOW granularity bug
References: <loom.20091008T221131-292@post.gmane.org>  <20091008212425.GB2068@ednor.casa.cgf.cx>  <4ACEACBA.4030904@byu.net> <20091009045800.GA17335@ednor.casa.cgf.cx> <4ACF307F.1040604@byu.net>
In-Reply-To: <4ACF307F.1040604@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00089.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 10/9/2009 6:45 AM:
> OK, here's the respin without the churn.
> 
>> It looks like you either don't need the systime() call or it should
>> call systime_ns.
> 
> Done.  hires_us still uses systime().

Ping.  Also, POSIX 2008 added _PC_TIMESTAMP_RESOLUTION; we should consider
making fpathconf(fd,_PC_TIMESTAMP_RESOLUTION) return 100 on NTFS, and
2000000000 on FAT.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrTJgMACgkQ84KuGfSFAYAfoQCfZSEQDSeZ05zE/DInsgGNf1FS
oBMAnjJZnJu9kSL3vU/B5VUN1oUKJYte
=QeRq
-----END PGP SIGNATURE-----
