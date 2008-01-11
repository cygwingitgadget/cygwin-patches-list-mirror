Return-Path: <cygwin-patches-return-6236-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24557 invoked by alias); 11 Jan 2008 04:20:58 -0000
Received: (qmail 24546 invoked by uid 22791); 11 Jan 2008 04:20:57 -0000
X-Spam-Check-By: sourceware.org
Received: from qmta10.westchester.pa.mail.comcast.net (HELO QMTA10.westchester.pa.mail.comcast.net) (76.96.62.17)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 11 Jan 2008 04:20:31 +0000
Received: from OMTA08.westchester.pa.mail.comcast.net ([76.96.62.12]) 	by QMTA10.westchester.pa.mail.comcast.net with comcast 	id beHg1Y0090Fqzac5A03R00; Fri, 11 Jan 2008 04:20:29 +0000
Received: from [192.168.0.103] ([67.166.125.73]) 	by OMTA08.westchester.pa.mail.comcast.net with comcast 	id bgLJ1Y00D1b8C2B3U00000; Fri, 11 Jan 2008 04:20:20 +0000
X-Authority-Analysis: v=1.0 c=1 a=8pif782wAAAA:8 a=xe8BsctaAAAA:8 a=P2X5m5OF_xagNPvobr0A:9 a=krs4BHp-VAExEEFJBbkJh3mkdokA:4 a=eDFNAWYWrCwA:10 a=rPt6xJ-oxjAA:10
Message-ID: <4786EEA5.1070700@byu.net>
Date: Fri, 11 Jan 2008 04:20:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: memmem issues
References: <loom.20071219T210928-910@post.gmane.org> <4769E90D.5090908@byu.net> <20071220101143.GA8291@calimero.vinschen.de>
In-Reply-To: <20071220101143.GA8291@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2008-q1/txt/msg00010.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 12/20/2007 3:11 AM:
|> +  /* FIXME - this algorithm is worst-case O(l_len*s_len)...
|
| or what about Boyer-Moore instead:
|
|   http://de.wikipedia.org/wiki/Boyer-Moore-Algorithmus (in German)
|
| Using one of them is certainly not a licensing violation since all code
| examples are more or less the published examples from well-known
| textbooks (Knuth, Sedgewick, et al.).  Given that, I don't think you're
| actually "tainted".  An actual implementation would be much better than
| a forlorn comment in an unimpressive file in some subdirectory.

I took you up on that, and submitted an even better implementation to the
newlib list, shared among memmem, strstr, and strcasestr
(Knuth-Morris-Pratt and Boyer-Moore both require memory allocation, but
not Two-Way).  If Jeff gives the go-ahead for newlib, then we'll need to
delete cygwin's copy of memmem.cc.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHhu6l84KuGfSFAYARAg4WAJ9+8FkRcJlFaFYG/ouvK+4x/VQIlQCeJ03y
e9u22aTS92xNaLELTW+otK4=
=9rXA
-----END PGP SIGNATURE-----
