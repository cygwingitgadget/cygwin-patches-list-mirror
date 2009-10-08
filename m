Return-Path: <cygwin-patches-return-6747-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5257 invoked by alias); 8 Oct 2009 03:18:05 -0000
Received: (qmail 5243 invoked by uid 22791); 8 Oct 2009 03:18:04 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta12.emeryville.ca.mail.comcast.net (HELO QMTA12.emeryville.ca.mail.comcast.net) (76.96.27.227)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 08 Oct 2009 03:18:01 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60]) 	by QMTA12.emeryville.ca.mail.comcast.net with comcast 	id q0MW1c00A1HpZEsAC3J0Y3; Thu, 08 Oct 2009 03:18:00 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA14.emeryville.ca.mail.comcast.net with comcast 	id q3Hy1c00B0Lg2Gw8a3HzwH; Thu, 08 Oct 2009 03:18:00 +0000
Message-ID: <4ACD59D2.6010302@byu.net>
Date: Thu, 08 Oct 2009 03:18:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: fd leak in utimensat
References: <4ACD56AF.7080905@byu.net>
In-Reply-To: <4ACD56AF.7080905@byu.net>
Content-Type: multipart/mixed;  boundary="------------010006000600020106000701"
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
X-SW-Source: 2009-q4/txt/msg00078.txt.bz2

This is a multi-part message in MIME format.
--------------010006000600020106000701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1003

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 10/7/2009 9:04 PM:
> I haven't spent time trying to locate where the leak is happening, but
> process explorer confirms that this STC leaves a handle open to the file,
> preventing further re-creation of a new file by the same name.

Found it.  OK to apply?  In case it wasn't obvious, the leak only happens
on invalid timestamps; this was from a gnulib test validating that
1000000000 is rejected with EINVAL.

2009-10-08  Eric Blake  <ebb9@byu.net>

	* fhandler_disk_file.cc (utimens_fs): Plug leak for EINVAL.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrNWc8ACgkQ84KuGfSFAYAnBgCfQqJPnnxb6sustsi4rISH35km
CCsAoJpr9V8YcWPn7ijsQzPmeuM9Sl2g
=Q+ks
-----END PGP SIGNATURE-----

--------------010006000600020106000701
Content-Type: text/plain;
 name="cygwin.patch29"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch29"
Content-length: 500

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 99bbf8b..1e6a781 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1310,6 +1310,8 @@ fhandler_base::utimens_fs (const struct timespec *tvp)
       if ((tvp[0].tv_nsec < UTIME_NOW || tvp[0].tv_nsec > 999999999L)
 	  || (tvp[1].tv_nsec < UTIME_NOW || tvp[1].tv_nsec > 999999999L))
 	{
+	  if (closeit)
+	    close_fs ();
 	  set_errno (EINVAL);
 	  return -1;
 	}

--------------010006000600020106000701--
