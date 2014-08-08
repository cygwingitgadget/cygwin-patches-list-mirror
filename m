Return-Path: <cygwin-patches-return-8015-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19401 invoked by alias); 8 Aug 2014 10:31:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19382 invoked by uid 89); 8 Aug 2014 10:31:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Aug 2014 10:31:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F1F7E8E0773; Fri,  8 Aug 2014 12:31:39 +0200 (CEST)
Date: Fri, 08 Aug 2014 10:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -m, --check-mtimes option
Message-ID: <20140808103139.GX13601@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53E3DE5D.10302@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="cxMSjUqMQBJIqbX5"
Content-Disposition: inline
In-Reply-To: <53E3DE5D.10302@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q3/txt/msg00010.txt.bz2


--cxMSjUqMQBJIqbX5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2177

Hi Christian,

On Aug  7 22:15, Christian Franke wrote:
> Attached is an experimental patch which adds -m, --check-mtimes[=3DSECOND=
S]
> option to cygcheck. It provides an IMO useful heuristics to find files
> possibly modified after installation.
>=20
> "cygcheck -c -m" prints the number of files with st_mtime >
> INSTALL_TIME+SECONDS. INSTALL_TIME is the st_mtime of the
> /etc/setup/PACKAGE.lst.gz file.
>=20
> With -v, the affected path names are printed. The optional parameter SECO=
NDS
> defaults to 600 to hide files modified by postinstall scripts.

That's an interesting idea.  I just gave it a try.  I think this might
be useful, but from a user perspective I'm not very happy with the
presentation:

Newer file: /usr/bin/which.exe from package which (written 146 days after i=
nstallation)
which                               2.20-2                 OK          (1 n=
ewer)

Three points:

- The "(1 newer)" is too far to the right.  If more than 9 files are
  newer the line gets longer than 80 chars.  To avoid collision with
  the "Incomplete" status, let's move the status 2 chars to the left,
  too.

- The verbose text should be printed after the affected package, not before.
  It's simple to see why it's printed before, but this could be worked
  around by storing the affected files in a list and printing the list
  after the non-verbose package info.

- Along these lines, the verbose "Newer file %s from package %s (...)"
  is a bit... verbose.  Assuming it gets printed after the package name,
  it might be easier on the eyes to use a simpler, indented format.
  Just as a first suggestion, what about something like:

which                               2.20-2                 OK        (1 new=
er)
  /usr/bin/which.exe (changed 146 days after install)

or (uh oh!):

which                               2.20-2                 OK        (1 new=
er)
  /usr/bin/which.exe (changed 71 days ago)

> Documentation update and changelog entry are still missing.

Sure, no worries for now.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--cxMSjUqMQBJIqbX5
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT5KcLAAoJEPU2Bp2uRE+gjqEP/j8v2x7PyshlhH2OlcSL4iHY
2qQURlkG3iS2HzlF7vOD3bFZf+7Zn0TYu68fb/Q3UCJop36iPE/M7xnTRP3iF+5p
IAlzPD+saBjXTITo1XmxwCNR+sguDn37tHpiBhGIZSptbWYWNNPAsq4IN0UhAsT1
aiRXFbVRGkPZfo3nsMp99tpJn9la8QXLcErIW1/KiBgcFBcSssLQAAeZPIaJGl8G
6tE0cT8SDAXByxYchDnnGI4X9D5Z201an85rBHiOInBsblOtaUBpEEzizL7or4U5
xjTNkWRgsvlWMAkMVoGKmA0hOH995tqQYzhn05Hi7Aw0Qt3ex9ol34I2PpRADxw9
SFdyd6hp86DOzcJTHdmlp9/gD/VGiV1tT2O5dIL30joQQrg39Xk/aK1eYIqWFIDn
QbPU+VfXhNXDYlhSzh4EA/aq8exjrmqPySaIhei225qbfzf7IValdhfB7uwm9SY5
ei+vLFffOiXztbAaFtCi724EjE4bdimBu8wDCCuCzCsHUzDxU6lGq8OpQiVeZjOc
V1hBSE+79e5sfFZv28Q0LexzkQ/BdWeabbRBI1NL58VVlzlSd9szl5SXxKYL3Tym
6DwrnybS4Dqv67OjLc2C20Rrq46PkdCIFk9sBSIeFewQe9m0L0PdvDuqLPaoQlTu
snt9hzAXYe/1IjWmSB4z
=DFtw
-----END PGP SIGNATURE-----

--cxMSjUqMQBJIqbX5--
