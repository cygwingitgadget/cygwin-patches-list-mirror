Return-Path: <cygwin-patches-return-7568-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14798 invoked by alias); 19 Dec 2011 19:32:58 -0000
Received: (qmail 14785 invoked by uid 22791); 19 Dec 2011 19:32:58 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from dancol.org (HELO dancol.org) (96.126.100.184)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 19 Dec 2011 19:32:45 +0000
Received: from c-24-18-179-193.hsd1.wa.comcast.net ([24.18.179.193] helo=[192.168.1.2])	by dancol.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)	(Exim 4.72)	(envelope-from <dancol@dancol.org>)	id 1Rcix3-0000MH-9S	for cygwin-patches@cygwin.com; Mon, 19 Dec 2011 11:32:45 -0800
Message-ID: <4EEF914C.9090707@dancol.org>
Date: Mon, 19 Dec 2011 19:32:00 -0000
From: Daniel Colascione <dancol@dancol.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add support for creating native windows symlinks
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>	<20111205101715.GA13067@calimero.vinschen.de>	<CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com>	<CAL-4N9v8QU-mZfE-4gtpjtybD8A1BYt8QJNGAHOOHv25fkF0Mg@mail.gmail.com>	<20111219155948.GA7148@calimero.vinschen.de> <CAL-4N9tALgoad1K+BKH3UoC4_viooeyt9KNHAxm1kwHWw8KcEw@mail.gmail.com>
In-Reply-To: <CAL-4N9tALgoad1K+BKH3UoC4_viooeyt9KNHAxm1kwHWw8KcEw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig8FAB08746194A149B68A5C86"
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
X-SW-Source: 2011-q4/txt/msg00058.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8FAB08746194A149B68A5C86
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 580

On 12/19/11 11:31 AM, Russell Davis wrote:
>> I don't think it's the right approach to let Cygwin create symlinks
>> which are only partially usable in the POSIX environment...
>=20
> Huh? I think you're not fully understanding my suggested approach. As
> I pointed out in my previous message, it should be 100%, fully usable
> in the POSIX environment. Again: any path that might be problematic as
> a Win32 path can just be stored as a POSIX path, and would fall into
> the bucket of "works inside cygwin but not outside".
>=20

That's only true until the mount table changes.


--------------enig8FAB08746194A149B68A5C86
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 235

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAk7vkVoACgkQ17c2LVA10VviZACeKInpIGSHV31fqay2sW6iEWUC
CuIAoI82T51i7SrEvn0ajcUDmYx3TZ5i
=H+bX
-----END PGP SIGNATURE-----

--------------enig8FAB08746194A149B68A5C86--
