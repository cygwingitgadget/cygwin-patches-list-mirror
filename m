Return-Path: <cygwin-patches-return-6330-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23131 invoked by alias); 24 Apr 2008 05:09:35 -0000
Received: (qmail 23116 invoked by uid 22791); 24 Apr 2008 05:09:32 -0000
X-Spam-Check-By: sourceware.org
Received: from service1.sh.cvut.cz (HELO service1.sh.cvut.cz) (147.32.127.214)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 24 Apr 2008 05:09:12 +0000
Received: from localhost (localhost [127.0.0.1]) 	by service1.sh.cvut.cz (Postfix) with ESMTP id 85CA7123A4F; 	Thu, 24 Apr 2008 07:09:10 +0200 (CEST)
X-Spam-Score: -0.1
Received: from service1.sh.cvut.cz ([127.0.0.1]) 	by localhost (service1.sh.cvut.cz [127.0.0.1]) (amavisd-new, port 10024) 	with ESMTP id OKrXTrmNssgH; Thu, 24 Apr 2008 07:09:02 +0200 (CEST)
Received: from [192.168.1.2] (r4v24.net.upc.cz [84.42.149.24]) 	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) 	(No client certificate requested) 	by service1.sh.cvut.cz (Postfix) with ESMTP id 5871E123A42; 	Thu, 24 Apr 2008 07:09:02 +0200 (CEST)
Message-ID: <481015FE.8010508@sh.cvut.cz>
Date: Thu, 24 Apr 2008 05:09:00 -0000
From: =?UTF-8?B?VsOhY2xhdiBIYWlzbWFu?= <v.haisman@sh.cvut.cz>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To: "Yaakov (Cygwin Ports)" <yselkowitz@users.sourceforge.net>
CC: cygwin-patches@cygwin.com
Subject: Re: wait.h
References: <480F8B7D.5080908@users.sourceforge.net>
In-Reply-To: <480F8B7D.5080908@users.sourceforge.net>
Content-Type: multipart/signed; micalg=pgp-sha256;  protocol="application/pgp-signature";  boundary="------------enigA14AD50C8C8F2EC944E10EE8"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q2/txt/msg00001.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA14AD50C8C8F2EC944E10EE8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-length: 517

Yaakov (Cygwin Ports) wrote, On 23.4.2008 21:18:
> glibc ships a <wait.h> which contains only one line:
>=20
> #include <sys/wait.h>
>=20
> I know of at least three packages that #include <wait.h> instead of
> <sys/wait.h>.  Could such a header please be added to Cygwin (preferably
> to both branches)?
>=20
> Patch attached; I presume this is trivial enough to not require a
> copyright assignment.
>=20
>=20
> Yaakov
I strongly think you should fix the packages and send the patches upstream=
=20
instead.

--
VH


--------------enigA14AD50C8C8F2EC944E10EE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 250

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIEBYFoUFWwtEPkHIRCCvYAJ4qdx+5eU0vAmvy1mHSrRlmOhL+2QCbB1o9
BgzDBPfcc4BhLRTmawWb5ho=
=bbAQ
-----END PGP SIGNATURE-----

--------------enigA14AD50C8C8F2EC944E10EE8--
