Return-Path: <cygwin-patches-return-6644-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10736 invoked by alias); 25 Sep 2009 12:28:02 -0000
Received: (qmail 10725 invoked by uid 22791); 25 Sep 2009 12:28:01 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta02.emeryville.ca.mail.comcast.net (HELO QMTA02.emeryville.ca.mail.comcast.net) (76.96.30.24)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 12:27:55 +0000
Received: from OMTA03.emeryville.ca.mail.comcast.net ([76.96.30.27]) 	by QMTA02.emeryville.ca.mail.comcast.net with comcast 	id l0511c0090b6N64A20Tua0; Fri, 25 Sep 2009 12:27:54 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA03.emeryville.ca.mail.comcast.net with comcast 	id l0Tt1c0010Lg2Gw8P0TutR; Fri, 25 Sep 2009 12:27:54 +0000
Message-ID: <4ABCB741.60307@byu.net>
Date: Fri, 25 Sep 2009 12:28:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] Support for CJK Character Sets
References: <20090403173212.51916.qmail@web4102.mail.ogk.yahoo.co.jp> <20090406110457.GA4134@calimero.vinschen.de> <4ABC3CBC.7000502@byu.net> <20090925083658.GD26348@calimero.vinschen.de> <20090925100600.GA29048@calimero.vinschen.de>
In-Reply-To: <20090925100600.GA29048@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00098.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 9/25/2009 4:06 AM:
>>> 2009-09-24  Eric Blake  <ebb9@byu.net>
>>>
>>> 	* setup2.sgml (setup-locale-problems): Document how to install
>>> 	non-default charsets.
>> Shoot.
> 
> Btw., it's not only 20932/EUC-JP.  The full list is 932/SJIS,
> 936/EUC-KR, 949/GBK, 950/Big5, 20932/EUC-JP.  Probably it makes sense
> to note all of them.

Reworded to mention all of those (although on my XP box, 932, 936, 949,
and 950 were selected by default and shaded to prevent unselecting, only
20932 was missing).  Now in CVS.

+<para>Another problem you might encounter is that older versions of
+Windows did not install all charsets by default.  If you are running
+Windows XP or older, you can open the "Regional and Language Options"
+portion of the Control Panel, select the "Advanced" tab, and select
+entries from the "Code page conversion tables" list.  The following
+entries are useful to cygwin: 932/SJIS, 936/EUC-KR, 949/GBK, 950/Big5,
+20932/EUC-JP.</para>

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq8t0EACgkQ84KuGfSFAYCwdACfTP4TGGojdh+lkzmY6m0z4t0q
CHsAn18du554P9Z3ozwp0Ctfj78XKTeX
=XeZd
-----END PGP SIGNATURE-----
