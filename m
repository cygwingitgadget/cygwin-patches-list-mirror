Return-Path: <cygwin-patches-return-7916-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3134 invoked by alias); 4 Dec 2013 17:23:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3119 invoked by uid 89); 4 Dec 2013 17:23:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,RDNS_NONE autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from Unknown (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Dec 2013 17:23:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C2F251A0677; Wed,  4 Dec 2013 18:23:24 +0100 (CET)
Date: Wed, 04 Dec 2013 17:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
Message-ID: <20131204172324.GA13448@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52437121.1070507@redhat.com> <20131204093238.GA28314@calimero.vinschen.de> <20131204113626.GB29444@calimero.vinschen.de> <20131204120408.GC29444@calimero.vinschen.de> <20131204170028.GA2590@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20131204170028.GA2590@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q4/txt/msg00012.txt.bz2


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1582

On Dec  4 12:00, Christopher Faylor wrote:
> On Wed, Dec 04, 2013 at 01:04:08PM +0100, Corinna Vinschen wrote:
> >On Dec  4 12:36, Corinna Vinschen wrote:
> >> On Dec  4 10:32, Corinna Vinschen wrote:
> >> > Hi guys,
> >> > [...etc...]
> >> > The problem is still present in the current sources.
> >> > [...]
> >
> >Ouch, ouch, ouch!  I tested the wrong DLL.  Actually current CVS fixes
> >this problem.  Duh.  Sorry for the confusion.
> >
> >One question, though.  Assuming start is =3D=3D size, then the current c=
ode
> >in CVS extends the fd table by only 1.  If that happens often, the
> >current code would have to call ccalloc/memcpy/cfree a lot.  Wouldn't
> >it in fact be better to extend always by at least NOFILE_INCR, and to
> >extend by (1 + start - size) only if start is > size + NOFILE_INCR?
> >Something like
> >
> >  size_t extendby =3D (start >=3D size + NOFILE_INCR) ? 1 + start - size=
 : NOFILE_INCR;
> >
> >?
> >
> >Sorry again.  Fortunately it's my WJM week...
>=20
> I don't think it is a common occurrence for start >=3D size.  It is
> usually done when something like bash dup2's stdin/stdout/stderr to a
> high fd.  Howeer, I'll check in something which guarantees that there is
> always a NOFILE_INCR entries free after start.

That might be helpful.  Tcsh, for instance, always dup's it's std
descriptors to the new fds 15-19.  If it does so in this order, it would
have to call extend 5 times.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-length: 836

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSn2UMAAoJEPU2Bp2uRE+ghpAQAIfrEPXJxfFOxEd6g+aZStKI
T/yUqwlTv+0G4sF9ouAoBkrQtJ3hMzYcG7ZR5a8Db86fqMJzRo9jNFfRjGkrlahD
6Fw5CNXt0t63g7f8faC9CwS5pN9mjpWOswvg+R/NfO6QfM7dzCMDtnd2LsLyJbBU
cXI1sNPrse/c3peifFi98foQHF3DIFfIvxOPjdBBrOwBd90vCK7cAGouqQgXxXep
6Fzm1xYMXXyHwx4I2WpZT++FCf2iR0kaA/YDp+x8nkACFhyDHv5gQbrG0AyAQAvu
/gFJzChgfXkPJX6psu9YUUB9SRJe4TatOP4+VIOU7IWN4vuleX/n3mNeUTagz0Yr
DQgwXIOeLqvXVSwFnLgM6ig8tgP9waIFSotxLXr6WF/vJLqmHcwiEAIRjKYHOKKc
KVXi4UslCiSVVhghc8W7joiwXA1skjJ9NWo7iEBontH8o5zQumfM8A10D7CUD37s
FYAaBMKoGoE9O+gcIuvwjgJCWsMY/Urri+q1ZwxKzNTaQpyzYIaMt30NrAnHJ8RE
uEwglXG6ydyfg7kA3EsVrjB4k/j0NTvNZt00pEPMHJD3uZoWo9yYEgsyvP+sfq0h
aCH5FsfT/RHBfecjlpq1D8kB1YxtEVu5XJZbRLtSb2Rb8m3exDJlKvvxZ58RU20x
To4nw8Y5LrWfaZrh6Qmv
=gzbX
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
