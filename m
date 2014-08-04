Return-Path: <cygwin-patches-return-8011-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4514 invoked by alias); 4 Aug 2014 09:14:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4498 invoked by uid 89); 4 Aug 2014 09:14:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Aug 2014 09:14:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ED25D8E0773; Mon,  4 Aug 2014 11:14:39 +0200 (CEST)
Date: Mon, 04 Aug 2014 09:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: docs: improve package maintainer instructions
Message-ID: <20140804091439.GE2578@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53DCE738.3090406@redhat.com> <1407117639.2942.3.camel@yselkowitz.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline
In-Reply-To: <1407117639.2942.3.camel@yselkowitz.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q3/txt/msg00006.txt.bz2


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1535

On Aug  3 21:00, Yaakov Selkowitz wrote:
> On Sat, 2014-08-02 at 07:27 -0600, Eric Blake wrote:
> > I noticed that the main link on the cygwin.com left navbar
> > (https://cygwin.com/setup.html#submitting) has outdated instructions;
> > rather than duplicate things, I'd rather have a link to the more
> > up-to-date page
> > (https://sourceware.org/cygwin-apps/package-upload.html).  Okay to push?
>=20
> A few minor nits:
>=20
> > +  would be 4.5.13-1, etc). Some packages also use a YYMMDD format for
>                                                        ^^^^^^
> YYYYMMDD
>=20
>=20
> > -boffo-1.0-1.tar.bz2  boffo-1.0-1-src.tar.bz2  setup.hint
> > +boffo-1.0-1.tar.xz  boffo-1.0-1-src.tar.z  setup.hint
>                                       ^^^^^^
> .tar.xz
>=20
> Corinna will have to give the final ack.

I'm fine with the changes, barring Yaakov's nits.

However, while we're at it shouldn't we change from "cygport is the
accepted way to make Cygwin packages" to "cygport is the required way to
make new Cygwin packages and the (strongly) recommended way for package
updates"?  I for one think it's time to switch to a single packaging
method.  After all, you don't have rpm packages in Debian or apt
packages in Fedora.  This will also greatly simplify to set up an
automated build system for Cygwin packages at one point.

(yada, yada, git package DB, yada yada)


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT307/AAoJEPU2Bp2uRE+gi8QQAINyz2gmA+mvw9eX40yvfqGR
dhCzmwTcTeWDEc8DY5XWmWIcrn4xM7JjGekFxY4euy2infhXF5/IowfTK/9JAvJz
XfF6clW2tgXKuBxLZsFLV16T3eJnDDZqlwTTL5TQ/3gcVsmapF5dvyf48tLCLMSh
ruAFYNCHNLqGlhRluvttu6Dr0+IJLSY//tf7DToMEK9CUV47M12BgCBLat6rJnAC
aRUeUSDQy781hDfXVPHP63+tTE8vatFeUCCHm7pIWsW+VyueFvlr/uQqCuMCsywD
2V+nkm5hlmOvR2uB/GRzZ5038+DA5rJmCEU7p6iObRFrvJ/nii2Gt1eq1Va52RYh
zSdaUtvtgk1fFV5DlAePJsRIf5wDKx/uly8r/XFeTef44cVwhT9SI33kkGhCxQZd
uduSMCqglndr6GppmlnlPXOTfREBzoNII1HHROgoya0MnQozR7l9SSRt8PduWqnn
2RTalpSY+oq2zMmbkpBjkOXBdstIn6GZtznjYLPowwG4zCB3081fSFP9CcBrIyI5
uWMF6K+CgZLgbmwz+i6GxOvLja1ItXuDySJX6lsaQiRfq4PNlfMyAs2P1KiXcEyr
2jjYuxLd3mn4IEFCjxa/vssX7MVfycF9BgwrHy6cdL500rOjwITDmO+uuYO/+Aof
8kNz9nFx7zDSJ6WqjGZ0
=CvDe
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
