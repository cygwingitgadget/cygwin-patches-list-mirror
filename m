Return-Path: <cygwin-patches-return-8018-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11842 invoked by alias); 14 Aug 2014 08:41:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11826 invoked by uid 89); 14 Aug 2014 08:41:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Aug 2014 08:41:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D1C3B8E0773; Thu, 14 Aug 2014 10:41:01 +0200 (CEST)
Date: Thu, 14 Aug 2014 08:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -m, --check-mtimes option
Message-ID: <20140814084101.GA17683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53E3DE5D.10302@t-online.de> <20140808103139.GX13601@calimero.vinschen.de> <20140808125135.GA13601@calimero.vinschen.de> <53EBC873.2020904@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <53EBC873.2020904@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q3/txt/msg00013.txt.bz2


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2621

On Aug 13 22:20, Christian Franke wrote:
> Hi Corinna,
>=20
> Corinna Vinschen wrote:
> >On Aug  8 12:31, Corinna Vinschen wrote:
> >>Hi Christian,
> >>
> >>On Aug  7 22:15, Christian Franke wrote:
> >>>Attached is an experimental patch which adds -m, --check-mtimes[=3DSEC=
ONDS]
> >>>option to cygcheck. It provides an IMO useful heuristics to find files
> >>>possibly modified after installation.
> >>>
> >>>"cygcheck -c -m" prints the number of files with st_mtime >
> >>>INSTALL_TIME+SECONDS. INSTALL_TIME is the st_mtime of the
> >>>/etc/setup/PACKAGE.lst.gz file.
> >>>
> >>>With -v, the affected path names are printed. The optional parameter S=
ECONDS
> >>>defaults to 600 to hide files modified by postinstall scripts.
> >>That's an interesting idea.  I just gave it a try.  I think this might
> >>be useful,
> >On second thought, the modification date isn't very meaningful all by
> >itself, is it?  In theory it's only meaningful if the file has changed
> >as well.
>=20
> That's why I called it "heuristics" :-)
>=20
>=20
> >   Consider, what is the user supposed to do with the information
> >that the file modification date has changed?  Where does the user go
> >from there?
>=20
> The info is IMO useful to find changed config files, forgotten hot fixed
> scripts or other files you possibly want to save before a package is
> updated.
>=20
> It also sometimes exposes package collisions (e.g. libgnutls26/28 provide
> different versions of cyggnutls-openssl-27.dll or libsasl2/2_3 provide
> different version of /usr/sbin/saslauthd).
>=20
>=20
> >So I'm wondering if the st_mtime check isn't just a starting
> >point for a test for a file change.  OTOH, we have a problem there.
> >The rudimentary package database in /etc/setup is not very helpful.
> >It only contains filenames, but no other information on the files.
> >
> >What would be really cool:  Setup generates the package info files in
> >/etc/setup with additional file size and md5 (sha1, sha256, you name it)
> >checksum.  Then cygcheck could test if st_mtime, st_size and the
> >checksum match.  Or, in a first step, just store and check the file
> >size.
>=20
> Yes, this is an obvious missing feature of the Cygwin package management.=
 I
> didn't suggest it because my open source spare time is too limited to
> implement it :-)

That's unfortunate.  But, anyway, what about the other points I raised
in my first reply?  We could improve the -m handling as we go along.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT7HYdAAoJEPU2Bp2uRE+g+s4P/jUmGOvxjkDzl7BwkbZnpsme
Tk9n6GFgS3/I9iL7s0TrYuwsG6UjNqpiL4W41HFZUcuvUiS1/m2iJQrsWuy3lBTO
P6g2vS2Fdm4Xzd87cnAa8HLaunFg+G3SpH18VgQa9PrdP1VnZQ1qpHbNs95saQtd
RKhuiwKULufpqPdaOn/PAChSlT6Jpq7+bq/iGfreBMQgAgmHC5yZP4aysXBsVPRF
TlX5yqZrf7g9KhON3eI7knUABrIyd55b/Iar2Vva0C4bZmCIQEKC3glA9mKwh/bn
8EqTjTrMQc/TMfLQvfjiLQCfOiykhIJ583YNGTmQmo1wCLYMBb4yOvUb72kfDn/l
Wbh1xEdZ2tTszGypZepU9/tmUVU7IoMmp8QW/HnA4A2ssH4QM/+kWR4lvfQpabG8
8HZFof54Vn3UaIgUg17VAEYxSj1KXNj9loA5x7be+OerHxTdzp0YS9FUHiAFpS7S
42gIece33ZVvkH8AxB5qsocM9d2IzD9x172td+DgdWHzSZqsb++/Foi6Q4WA2kVP
/71Ji7Qqj3/GC0z6OlEHOGvmgl6dJfBydtWQ6p0AfGC+Ge0BrXmUw3x6G615jDIc
pN0JhNAIORFL8J8DWzIbC/3FbZkKk9hjIS0FN/2ipKbO4xk4I8QIrU1dWw7xSCh6
SzEV/zTvgx9iUEmGxLof
=5077
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
