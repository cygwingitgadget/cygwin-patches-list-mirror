Return-Path: <cygwin-patches-return-8611-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61846 invoked by alias); 29 Jul 2016 13:58:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61831 invoked by uid 89); 29 Jul 2016 13:58:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-95.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0190b.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.25.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 29 Jul 2016 13:57:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F1791A806D8; Fri, 29 Jul 2016 15:57:51 +0200 (CEST)
Date: Fri, 29 Jul 2016 13:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Send thread names to debugger
Message-ID: <20160729135751.GA11909@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160728114341.1728-1-jon.turney@dronecode.org.uk> <20160728114341.1728-3-jon.turney@dronecode.org.uk> <20160728193458.GB26311@calimero.vinschen.de> <226278ea-2c1a-2476-4a7a-324ae48d8e3b@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <226278ea-2c1a-2476-4a7a-324ae48d8e3b@dronecode.org.uk>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-SW-Source: 2016-q3/txt/msg00019.txt.bz2


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1317

On Jul 29 14:17, Jon Turney wrote:
> On 28/07/2016 20:34, Corinna Vinschen wrote:
> > On Jul 28 12:43, Jon Turney wrote:
> > > GDB with the patch from [1] can report and use these names.
> >=20
> > This is still WIP, right?
>=20
> Yes, that's right.
>=20
> > > --- a/winsup/cygwin/cygthread.cc
> > > +++ b/winsup/cygwin/cygthread.cc
> > > @@ -213,6 +213,8 @@ cygthread::create ()
> > >  			    this, 0, &id);
> > >        if (!htobe)
> > >  	api_fatal ("CreateThread failed for %s - %p<%y>, %E", __name, h, id=
);
> > > +      else
> > > +	SetThreadName(GetThreadId(htobe), __name);
> >                     ^^^         ^^^
> >                    space?      space?
> >=20
> > Just wondering: Wouldn't it make sense to rename the internal threads
> > so they either always start with "cyg_" or with double underscore or
> > something like that to mark them as internal?  E.g.
>=20
> Yeah, I wanted to do something like that.
>=20
> But messing with the thread names may have other consequences (See
> fhandler_tty.cc:109), and I was a bit wary of introducing a malloc/free to
> into cygthread::create() to dynamically make the name with a "__" prepend=
ed

Ok.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXm2DfAAoJEPU2Bp2uRE+gbHMQAIBA/+Xn7Tq0FX5C4HrbWBE1
clIEKzgzVverEkdoTQtwpPf08xnEVZmDbY/x/486fgOqXkxafGkaDvwf75J/M0ip
cAlmj4Y6rz98csafSKIeuYiXB5Y3OhhAgxdmyC3aOdT8H47YtKu7F379vuAdqaG5
lsIgS7z41tGV+OO6DPzLh3TLYgKcYL0tGzvEUqaern7GsIj1Vz0RZq4skxnwYVnC
dvzlDVVgJocCWprsEKl8sGKjsiondCydHJYLGubl7paJC9jeDlGVdeyc71D54PWN
O24QPcGNvGrIIg+t9kUlKzhSygogn/SgFdbI185pakq9JD6fGNnqlf0OiDfW5CFR
4yiRVaXwbupgyzYD/fgnrMnd1zfccWlTyV8+TPwNrN8V2tHbgyygzN9lzpN9ioCF
aU4AR6fe+VgZZyIaqdEcFiQSbB+CqLgOEr2rx287rz5lPMQfOP6F/2qYWkm3lEKM
WjSzzzDmmbZ9qKYcgkBa35hpHVFM7O6Gydcyu35YkJB64gc+TAAEpEdAPrDvgdh4
b8AsWzkE74o9vaR3V+4NASO/7NkL1XLu3C6sZOHTKUYocGeFZu3qctKQHH3uJbx9
pGrk9OfrRbTJhPRQeb3UrRlWAo/zbkhqD2Y9y9W/p0Wq2vOfb2s2FjWs7mo61ku5
5xUhbBv6/Hi0V11IbHqH
=tSdc
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
