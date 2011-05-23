Return-Path: <cygwin-patches-return-7391-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7834 invoked by alias); 23 May 2011 20:52:28 -0000
Received: (qmail 7807 invoked by uid 22791); 23 May 2011 20:52:27 -0000
X-SWARE-Spam-Status: No, hits=-6.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 23 May 2011 20:52:13 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4NKqDOc008438	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Mon, 23 May 2011 16:52:13 -0400
Received: from [10.3.113.142] (ovpn-113-142.phx2.redhat.com [10.3.113.142])	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p4NKqC0I004489	for <cygwin-patches@cygwin.com>; Mon, 23 May 2011 16:52:13 -0400
Message-ID: <4DDAC8FC.5000508@redhat.com>
Date: Mon, 23 May 2011 20:52:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: __xpg_strerror_r should not clobber strerror buffer
References: <4DD8664D.2000407@redhat.com> <20110522013514.GA16516@ednor.casa.cgf.cx> <4DDAC777.5030205@redhat.com>
In-Reply-To: <4DDAC777.5030205@redhat.com>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig57B37640CFB8A1E97E8949D5"
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
X-SW-Source: 2011-q2/txt/msg00157.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57B37640CFB8A1E97E8949D5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 1407

On 05/23/2011 02:45 PM, Eric Blake wrote:
> On 05/21/2011 07:35 PM, Christopher Faylor wrote:
>> On Sat, May 21, 2011 at 07:26:37PM -0600, Eric Blake wrote:
>>> POSIX says that no other function in the standard should clobber the
>>> strerror buffer.  Our strerror_r is a GNU extension, so it can get away
>>> with clobbering the buffer (but if we wanted to fix it, we would have to
>>> separate _my_tls.locals.strerror_buf into two different buffers).

Shoot.  This introduced an off-by-one buffer overrun.  I'm pushing this
followup.  Meanwhile, do we want a second buffer, so that the GNU
strerror_r won't clobber the strerror buffer?

+++ b/winsup/cygwin/ChangeLog
@@ -2,6 +2,7 @@

 	* errno.cc (strerror): Print unknown errno as int.
 	(__xpg_strerror_r): Likewise, and don't clobber strerror buffer.
+	* cygtls.h (strerror_buf): Resize to allow '-'.

 2011-05-23  Corinna Vinschen  <corinna@vinschen.de>

diff --git a/winsup/cygwin/cygtls.h b/winsup/cygwin/cygtls.h
index 4d4306b..f911a6c 100644
--- a/winsup/cygwin/cygtls.h
+++ b/winsup/cygwin/cygtls.h
@@ -109,7 +109,7 @@ struct _local_storage
   } select;

   /* strerror */
-  char strerror_buf[sizeof ("Unknown error 4294967295")];
+  char strerror_buf[sizeof ("Unknown error -2147483648")];

   /* times.cc */
   char timezone_buf[20];


--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig57B37640CFB8A1E97E8949D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJN2sj8AAoJEKeha0olJ0NqkSkH/2spoXq4snqlIwz6QpzMSPV0
EjH3UoTN1d2JYCjd7UUI22uj7+WXWyICqw0oKUHyFhCPg2l9V0oHWlVkwnKr7tD7
F0hNNhlGFXgjb3iPYoEU264QJ4P1lWKHAWEDmc4/gs05T/PkxLL3jP3OAvE5qVBU
L0CZQkSQ/yWop3wiRKFZyzVIctaVRRNRfLRVF1odWVVp14qvXGs4xdx8KcotHPvV
ibmyE2D6YmDxVNsz0DMUuu8sFq7JDEEFciLZo8E39+ZFBxC1Wq26mtyYBJ3KoXxq
fKpEp4oUegNFMOZotdrzaf4sPEn0Oox28/RHf8lHsSILJe90vbiLGoL8mK3Jcbw=
=/1it
-----END PGP SIGNATURE-----

--------------enig57B37640CFB8A1E97E8949D5--
