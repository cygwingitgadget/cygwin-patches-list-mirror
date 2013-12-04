Return-Path: <cygwin-patches-return-7918-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29693 invoked by alias); 4 Dec 2013 19:44:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29653 invoked by uid 89); 4 Dec 2013 19:44:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,RDNS_NONE autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from Unknown (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Dec 2013 19:44:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3D58F1A0685; Wed,  4 Dec 2013 20:44:41 +0100 (CET)
Date: Wed, 04 Dec 2013 19:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
Message-ID: <20131204194441.GB16301@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52437121.1070507@redhat.com> <20131204093238.GA28314@calimero.vinschen.de> <20131204113626.GB29444@calimero.vinschen.de> <20131204120408.GC29444@calimero.vinschen.de> <20131204170028.GA2590@ednor.casa.cgf.cx> <20131204172324.GA13448@calimero.vinschen.de> <20131204175108.GB2590@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20131204175108.GB2590@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q4/txt/msg00014.txt.bz2


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1964

On Dec  4 12:51, Christopher Faylor wrote:
> On Wed, Dec 04, 2013 at 06:23:24PM +0100, Corinna Vinschen wrote:
> >On Dec  4 12:00, Christopher Faylor wrote:
> >> On Wed, Dec 04, 2013 at 01:04:08PM +0100, Corinna Vinschen wrote:
> >> >On Dec  4 12:36, Corinna Vinschen wrote:
> >> >> On Dec  4 10:32, Corinna Vinschen wrote:
> >> >> > Hi guys,
> >> >> > [...etc...]
> >> >> > The problem is still present in the current sources.
> >> >> > [...]
> >> >
> >> >Ouch, ouch, ouch!  I tested the wrong DLL.  Actually current CVS fixes
> >> >this problem.  Duh.  Sorry for the confusion.
> >> >
> >> >One question, though.  Assuming start is =3D=3D size, then the curren=
t code
> >> >in CVS extends the fd table by only 1.  If that happens often, the
> >> >current code would have to call ccalloc/memcpy/cfree a lot.  Wouldn't
> >> >it in fact be better to extend always by at least NOFILE_INCR, and to
> >> >extend by (1 + start - size) only if start is > size + NOFILE_INCR?
> >> >Something like
> >> >
> >> >  size_t extendby =3D (start >=3D size + NOFILE_INCR) ? 1 + start - s=
ize : NOFILE_INCR;
> >> >
> >> >?
> >> >
> >> >Sorry again.  Fortunately it's my WJM week...
> >>=20
> >> I don't think it is a common occurrence for start >=3D size.  It is
> >> usually done when something like bash dup2's stdin/stdout/stderr to a
> >> high fd.  Howeer, I'll check in something which guarantees that there =
is
> >> always a NOFILE_INCR entries free after start.
> >
> >That might be helpful.  Tcsh, for instance, always dup's it's std
> >descriptors to the new fds 15-19.  If it does so in this order, it would
> >have to call extend 5 times.
>=20
> dtable.h:#define NOFILE_INCR    32
>=20
> It shouldn't extend in that scenario.  The table starts with 32
> elements.

Right.  I just thought it's a good example.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature
Content-length: 836

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSn4YpAAoJEPU2Bp2uRE+gl2oP/0DJ9T2k2/W99cYx8hYKd5ma
GB2EEvLeIC8ShjyrR+vVMlbuh8R02dcw9yBal4RT39QV6QD58F2qLJyMrYqoDlUt
RAU4RaNW2ttFqXHLJT44aKN7N1eeKPv7D1i76vvl911vqJQo+d+G0ng1mKgkGAKn
I8Q9XS9b3Ig8jTjswWK3+3dh+P7zTA0yAugefSsL8Cix/T6nN1GeBAqKUQVIsRxf
DyqlTZbplrdkP4kca5UTN7E6sJTjpHsnZ1pdA8FMLuPES3n/gZ7b7o89HZXHZLVd
UTPDK2dn5CxrRdVGPlqKmQY5KWDnTcVALjcgU9NzPWmbdDlajZQZqQ9f/Epab+tI
xA79pRV1CMZpZPgoE7xZ/IoN4ZiNX7hoIEzlp49bT1MBTrlcB7ByAX+f37V0+aaC
J9e31IktlnyWslsjHVIeeYGlAzF1eCXTT3gVOXzhCmkgwzji9+tUtftRxYL5JGKZ
xVLzESpyCD9g3mxwrQ9muj5/bqTofRAzIRxpCvcu2ZDZIcLHEwGM08JcisAOaAai
3amUvsMfr3YcKvlr8Jx5KgZTew/k7nvrMmZUdilVCmZQhTfdgLfNuHu3u797By9r
G3RrlXUNFHI7IQ3bqHWI9z1vbifnWVSdRjcb4Sr/m/fk6bxI8s0SKGZ5Q4Od+YEP
GY4/vFjOsx+YNoxaMHK7
=qOXw
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
