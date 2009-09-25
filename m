Return-Path: <cygwin-patches-return-6638-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30784 invoked by alias); 25 Sep 2009 03:45:16 -0000
Received: (qmail 30770 invoked by uid 22791); 25 Sep 2009 03:45:15 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta06.emeryville.ca.mail.comcast.net (HELO QMTA06.emeryville.ca.mail.comcast.net) (76.96.30.56)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 03:45:11 +0000
Received: from OMTA22.emeryville.ca.mail.comcast.net ([76.96.30.89]) 	by QMTA06.emeryville.ca.mail.comcast.net with comcast 	id kqbW1c0021vN32cA6rlADG; Fri, 25 Sep 2009 03:45:10 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA22.emeryville.ca.mail.comcast.net with comcast 	id krqu1c00J0Lg2Gw8irqvqn; Fri, 25 Sep 2009 03:50:55 +0000
Message-ID: <4ABC3CBC.7000502@byu.net>
Date: Fri, 25 Sep 2009 03:45:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] Support for CJK Character Sets
References: <20090403173212.51916.qmail@web4102.mail.ogk.yahoo.co.jp> <20090406110457.GA4134@calimero.vinschen.de>
In-Reply-To: <20090406110457.GA4134@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------050909000709020808000907"
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
X-SW-Source: 2009-q3/txt/msg00092.txt.bz2

This is a multi-part message in MIME format.
--------------050909000709020808000907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1160

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 4/6/2009 5:04 AM:
> Please note that eucJP does not work by default on Windows XP and
> earlier OSes!  At least not on the so-called "western languages"
> installations, US, French, Italian, whatever.  The reason is that the
> codepage 20932 is not installed by default.  You can easily install it,
> though, in the "Regional and Language Options" control panel -> Advanced
> -> Code page conversion tables.  Just click on codepage "20932 (JIS X
> 0208-1990 & 0212-1990)" and have your XP installation disk ready.

Let's document this.

2009-09-24  Eric Blake  <ebb9@byu.net>

	* setup2.sgml (setup-locale-problems): Document how to install
	non-default charsets.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq8PLwACgkQ84KuGfSFAYCYUACaA4WGn+8uQKJLHNDldRREjdV3
J6IAn0IKdS6rHCjagUGZq+B5y0F41mgm
=F0GE
-----END PGP SIGNATURE-----

--------------050909000709020808000907
Content-Type: text/plain;
 name="cygwin.patch24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch24"
Content-length: 816

diff --git a/winsup/doc/setup2.sgml b/winsup/doc/setup2.sgml
index fa63a9e..3420990 100644
--- a/winsup/doc/setup2.sgml
+++ b/winsup/doc/setup2.sgml
@@ -367,6 +367,13 @@ worked all these years before, maybe it's because you switched to
 another character set.  This doesn't occur with symlinks created with
 Cygwin 1.7 or later.  </para>

+<para>Another problem you might encounter is that older versions of
+Windows did not install all charsets by default.  If you are running
+Windows XP or older, and want to use the eucJP codepage, you must open
+the "Regional and Language Options" portion of the Control Panel,
+select the "Advanced" tab, and select entry 20932 in the "Code page
+conversion tables" list.</para>
+
 </sect2>

 <sect2 id="setup-locale-missing"><title>What does not work?</title>
-- 
1.6.5.rc1


--------------050909000709020808000907--
