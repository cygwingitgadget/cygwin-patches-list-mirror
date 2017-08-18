Return-Path: <cygwin-patches-return-8818-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 84505 invoked by alias); 7 Aug 2017 09:36:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84423 invoked by uid 89); 7 Aug 2017 09:36:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=urgent, dear, Dear, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Aug 2017 09:36:01 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 8F636721E281A	for <cygwin-patches@cygwin.com>; Mon,  7 Aug 2017 11:35:58 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id D745C5E041E	for <cygwin-patches@cygwin.com>; Mon,  7 Aug 2017 11:35:57 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B6507A8056F; Mon,  7 Aug 2017 11:35:57 +0200 (CEST)
Date: Fri, 18 Aug 2017 14:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: rmdir: improvement for emptiness check
Message-ID: <20170807093557.GS25551@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <35088024.20170806155704@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Content-Disposition: inline
In-Reply-To: <35088024.20170806155704@web.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00020.txt.bz2


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1293

Hi Simon,

On Aug  6 15:57, Simon wrote:
> Dear list,
>=20
> when deleting a directory, cygwin checks if the directory is empty.
> When doing so, it skipped every second file found in that directory
> (note the repetition of the line "pfni =3D ...NextEntryOffset"). This is
> a problem when, e.g., there are two files in that directory and the
> first one is in a PENDING_DELETE state. The second one will not be
> tested, so the directory is considered empty.
>=20
> This is not an urgent patch, but fixing this should lower the
> probability of an accidentally, temporarily "deleted" directory (i.e.
> 1. think it is empty; 2. move to recycle bin; 3. check again; 4.
> notice the error and move back to its old location).

Good catch!  Can you create a `git format-patch' style patch
with a nice log message, please?

> NB.: The whole move-to-bin strategy is broken and maybe even
> unfounded. I don't know why cygwin is trying to move an empty
> directory to a recycle.bin folder. The inherent race condition seems
> avoidable to me. Is there a discussion regarding that behaviour?

  $ mkdir dir
  $ cd dir
  $ rmdir ../dir


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZiDR9AAoJEPU2Bp2uRE+gh7oP/3ns5PSNATSH7echM8nSZH3e
JTz7LVJ1aMaUaoA8H9iScmo/wn19reC4YoPcBB43Y6yuEyLu9clfaVEm3/7PrtQo
dbliStOYJ7JV9YS/eP9AP5ZJHVUu2DY3Sl7F9K5xjbsbgEnZ9Sdq1kg6C9U9NjcS
P1EaSYmWtos8VSmTpsrDorEd1Gc+u6zlX+Qi+o7Wv3wRTPrD8r2ijHJuF9pKI0O1
p76neTIn5D/TfAYMu4jXLIyr0vzT5xVxFxmw7vcaOxwCO2WzWroxu/wLv7GEyRkM
KLWErmOLlzVNhMVEZIQANAaHoEoEPxXlqTfO1wb1eaF5VlatmuujFw0fdkjLrFCI
+5HoOz4hPzslH9mxpqM+C213FCPo99i6gZqFkzPGRubBECY0c1XlUBxjggJGa0rG
m6HmiZlgckpJ5ATeaEpswvI0Jb+Nkh8layfHv60mP7y6MfBGaL7PuZ32B869znaU
FcWprkxAw0oSAxEEtGBZisP49hZglHWK4Ht9YMwyvtrH+W0nwE+DAbY+IEQgVuxJ
0tKLUMvXkfcArSCDFLiP1EkIT2f8JQvvlhn+mmxpTnT8RtEx9enE+gJuOHno6TCg
+oj7parI4vEbCx4/46KG7YRgWbmLqs85yq23qA96n95FfjVmMjWSvzsyCVuv8D5+
lVXINYE1R66cSTD6gTaa
=xaSF
-----END PGP SIGNATURE-----

--Qgd2S+2VS1hsWwXW--
