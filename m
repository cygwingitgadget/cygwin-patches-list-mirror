Return-Path: <cygwin-patches-return-8016-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29722 invoked by alias); 8 Aug 2014 12:51:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29709 invoked by uid 89); 8 Aug 2014 12:51:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Aug 2014 12:51:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 320CB8E0773; Fri,  8 Aug 2014 14:51:35 +0200 (CEST)
Date: Fri, 08 Aug 2014 12:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -m, --check-mtimes option
Message-ID: <20140808125135.GA13601@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53E3DE5D.10302@t-online.de> <20140808103139.GX13601@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="7Rldj+JZnTQmDdGi"
Content-Disposition: inline
In-Reply-To: <20140808103139.GX13601@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q3/txt/msg00011.txt.bz2


--7Rldj+JZnTQmDdGi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1741

On Aug  8 12:31, Corinna Vinschen wrote:
> Hi Christian,
>=20
> On Aug  7 22:15, Christian Franke wrote:
> > Attached is an experimental patch which adds -m, --check-mtimes[=3DSECO=
NDS]
> > option to cygcheck. It provides an IMO useful heuristics to find files
> > possibly modified after installation.
> >=20
> > "cygcheck -c -m" prints the number of files with st_mtime >
> > INSTALL_TIME+SECONDS. INSTALL_TIME is the st_mtime of the
> > /etc/setup/PACKAGE.lst.gz file.
> >=20
> > With -v, the affected path names are printed. The optional parameter SE=
CONDS
> > defaults to 600 to hide files modified by postinstall scripts.
>=20
> That's an interesting idea.  I just gave it a try.  I think this might
> be useful,

On second thought, the modification date isn't very meaningful all by
itself, is it?  In theory it's only meaningful if the file has changed
as well.  Consider, what is the user supposed to do with the information
that the file modification date has changed?  Where does the user go
from there?

So I'm wondering if the st_mtime check isn't just a starting
point for a test for a file change.  OTOH, we have a problem there.
The rudimentary package database in /etc/setup is not very helpful.
It only contains filenames, but no other information on the files.

What would be really cool:  Setup generates the package info files in
/etc/setup with additional file size and md5 (sha1, sha256, you name it)
checksum.  Then cygcheck could test if st_mtime, st_size and the
checksum match.  Or, in a first step, just store and check the file
size.


What do you think?
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7Rldj+JZnTQmDdGi
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT5MfXAAoJEPU2Bp2uRE+gngoP/2+ql1JNjbw/pyoL23osR+Ot
N9rtnzZJ+f4U/lgBBaSFRyj92GcXUo1qoI106toXVgGBIKNtV6wTpri48jae7D31
u8s0ACoiz0QDZZiyPd+vCyZVh1oWeP4uig4qiWRxotm4+0TK02QMsDv2Nn0ZI8iW
eykuOvjWY9KMkxxgE5xS47j9zOktoQqtlGhe8BxTgpl45aqDU60Osh/vleR6EfLa
W/uMQKK37WLTrt7EzcXVzBOjer3ZOxvxk4JyYN+CBE/SJ/TBoJnpgcSejfmOeuuE
BTA7yC2hDzRO8MuPln0PEHLl7aTIEb8CeGBtf9qsffpVbyhEby2EfgUFQzdQMQbQ
IA6rKksVy7qqwdz/rtxS5vhMPgKB7k/oB6FcjrotvtX00XyEfg1A/NK9ulFzeZeE
gLi58KLAXrmnNmirB7c6M4Ot+3eVCXARnRKmDgs/QxzUNEYKVIZtqZ0sPg45JvqX
+RzmZ3pYBFVFR6smed6z7cDDothhiXNdgMwEalIQ2PxfhiT+GvyMgUNycm6A2UfL
aR+L6jC89jgtN2+Q5/N8x8wgew111s1/Ydzk5TDAk/Bsnt16TFQOyyZ/+pUEFhBv
cxVDsQVej5ITNjhNYLvbK2VRFPpdVZ2YGVXvoSAUjb9b0BcPaIhI9hlfoRXCo5Nk
Q54m0jZfUVA42dR1UTD/
=2Bif
-----END PGP SIGNATURE-----

--7Rldj+JZnTQmDdGi--
