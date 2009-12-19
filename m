Return-Path: <cygwin-patches-return-6879-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17457 invoked by alias); 19 Dec 2009 00:57:49 -0000
Received: (qmail 17440 invoked by uid 22791); 19 Dec 2009 00:57:47 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta09.emeryville.ca.mail.comcast.net (HELO QMTA09.emeryville.ca.mail.comcast.net) (76.96.30.96)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 19 Dec 2009 00:57:43 +0000
Received: from OMTA19.emeryville.ca.mail.comcast.net ([76.96.30.76]) 	by QMTA09.emeryville.ca.mail.comcast.net with comcast 	id JotF1d00A1eYJf8A9oxiMs; Sat, 19 Dec 2009 00:57:42 +0000
Received: from [192.168.0.104] ([24.10.244.244]) 	by OMTA19.emeryville.ca.mail.comcast.net with comcast 	id Joxg1d00L5H651C01oxhJs; Sat, 19 Dec 2009 00:57:42 +0000
Message-ID: <4B2C250C.8020504@byu.net>
Date: Sat, 19 Dec 2009 00:57:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: patch: sleep/nanosleep bug
References: <4B045581.4040301@byu.net>  <20091118204709.GA3461@ednor.casa.cgf.cx>  <4B06A48C.5050904@byu.net> <20091216160851.GB31219@ednor.casa.cgf.cx> <4B2A3A64.2010005@byu.net>
In-Reply-To: <4B2A3A64.2010005@byu.net>
Content-Type: multipart/mixed;  boundary="------------080303080107040707070903"
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
X-SW-Source: 2009-q4/txt/msg00210.txt.bz2

This is a multi-part message in MIME format.
--------------080303080107040707070903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1058

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 12/17/2009 7:04 AM:
> According to Christopher Faylor on 12/16/2009 9:08 AM:
>>> How about the following, then?  Same changelog.
>> It wonder if your while (!done) loop could be expressed as a for loop but
>> it isn't enough of an issue to block inclusion of this patch.
> 
>> So, thanks for the patch and please check in.  This will then go into 1.7.2.
> 
> Thanks; committed now.

And I botched it.  I'm pushing this followup as obvious (HIRES_DELAY_MAX
is in ms, not s).

2009-12-18  Eric Blake  <ebb9@byu.net>

	* signal.cc (nanosleep): Fix bug in previous patch.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkssJQwACgkQ84KuGfSFAYACYwCgx4ae754jxdms7BBIkNTPiK2O
o4wAnRkd86VviazT0jqQJleUjvTZ5Ti8
=epx6
-----END PGP SIGNATURE-----

--------------080303080107040707070903
Content-Type: text/plain;
 name="cygwin.patch34"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch34"
Content-length: 798

Index: signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.89
diff -u -p -r1.89 signal.cc
--- signal.cc	17 Dec 2009 14:04:04 -0000	1.89
+++ signal.cc	19 Dec 2009 00:56:36 -0000
@@ -102,11 +102,11 @@ nanosleep (const struct timespec *rqtp, 
     {
       /* Divide user's input into transactions no larger than 49.7
          days at a time.  */
-      if (sec > HIRES_DELAY_MAX)
+      if (sec > HIRES_DELAY_MAX / 1000)
         {
-          req = ((HIRES_DELAY_MAX * 1000 + resolution - 1)
+          req = ((HIRES_DELAY_MAX + resolution - 1)
                  / resolution * resolution);
-          sec -= HIRES_DELAY_MAX;
+          sec -= HIRES_DELAY_MAX / 1000;
         }
       else
         {

--------------080303080107040707070903--
