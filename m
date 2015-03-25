Return-Path: <cygwin-patches-return-8075-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95837 invoked by alias); 25 Mar 2015 15:04:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95769 invoked by uid 89); 25 Mar 2015 15:04:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Mar 2015 15:04:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 314B0A8092F; Wed, 25 Mar 2015 16:04:28 +0100 (CET)
Date: Wed, 25 Mar 2015 15:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: TIOCPKT mode of PTY is broken if ONLCR bit is cleared.
Message-ID: <20150325150428.GD3017@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20150228143653.ab0a6bf854db294105e1d5f3@nifty.ne.jp> <20150228135947.GZ11124@calimero.vinschen.de> <20150302210508.1be5c1ed4753508431842913@nifty.ne.jp> <20150318145854.GC2368@calimero.vinschen.de> <20150319074942.6c18c8fe0199037f028687dd@nifty.ne.jp> <20150319083451.GA8398@calimero.vinschen.de> <20150320191232.GJ2368@calimero.vinschen.de> <20150321104031.9dc198eb8aa4e7652e0a7a51@nifty.ne.jp> <20150323100823.GE3017@calimero.vinschen.de> <20150325204238.fb2ca1b538c35be7cc636d00@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="Ng9nCnWcMXS7n1y7"
Content-Disposition: inline
In-Reply-To: <20150325204238.fb2ca1b538c35be7cc636d00@nifty.ne.jp>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00030.txt.bz2


--Ng9nCnWcMXS7n1y7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 443

On Mar 25 20:42, Takashi Yano wrote:
> Dear cygwin developers,
>=20
> Regarding this (http://cygwin.com/ml/cygwin/2015-02/msg00929.html)
> problem, I made a patch attached.

Patch applied, thank you.  Btw., there's a Freenode IRC channel
#cygwin-developers.  Feel free to join.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Ng9nCnWcMXS7n1y7
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVEs58AAoJEPU2Bp2uRE+gyukP/R++l0dMtrlUAV3GloN4UkiT
4LhC/wX8EJWAHyp0kBakgAqYI3XZ6QF8SZLO438VUW4zSomSiut3KDVtHljHSAR7
iDFsx2fVIn1X++KcdlARSiAHaiNHJhpTNpZaaeCIU67ZqE2PtlLsDPLsaAOpefDE
Fl8uueEYNkQpuvUTkGn2kRWIFX3RB0pyf+KyCPKoqOwi80id0JcahPi5suEWC8NB
3lkM/dhOm6wkPSdSoelpz1cjgRWVZcUIPSK19vUKKoID+1Q70l1VrYfcD0Z1quni
9BQI8ux99CbgEZYKvl0JDkBGn699vGMxqIzFnoVeDFx0/xRF6gNVMgREY/gfBmhN
zjY7W6tRaVyGAiuU5BsKFojMDKCwBvXwMydNUzmbW8OlbBL3LvJMWdqTHeE8EfVv
OQ+ID/ykExUsqpkfWxrmtGGrJPKqK8n2DaaeHgxBFIFNs/H6GaXwuXrYNlxD5vZ2
s2sPoNEAxR1bRoty6Jx1P/9fdbOvkTevJrnqJvSG9XY9QJE6VX/lbs+n6heFhVQ9
YFY/887HkYPfJ0/JZIAajVO6zKKnrUU3AgvUneN8bFch5bCRaubBjFmQpRPOAWcV
5jniE3OeDH9ZHvGIiRr7QOzM37WiwE68diL9ITkFncfWzmKGaZDiaRzZGn2MKt0E
co8If+3UQ6/xe8WhnSDD
=srDq
-----END PGP SIGNATURE-----

--Ng9nCnWcMXS7n1y7--
