Return-Path: <cygwin-patches-return-8468-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126812 invoked by alias); 21 Mar 2016 19:55:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126798 invoked by uid 89); 21 Mar 2016 19:55:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:55:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 62DC1A803F7; Mon, 21 Mar 2016 20:55:24 +0100 (CET)
Date: Mon, 21 Mar 2016 19:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 09/11] Add c++14 sized deallocation operator
Message-ID: <20160321195524.GK14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-9-git-send-email-pefoley2@pefoley.com> <20160320112837.GO25241@calimero.vinschen.de> <CAOFdcFPP79BaO=KTpF5oB3ewdYCh6GmfaxoJr03kKY7dSOjrKw@mail.gmail.com> <20160321171314.GA14892@calimero.vinschen.de> <CAOFdcFM1D17HSiLdeNv=S6zim6wOcqY41Ud-iTtiDLrN_YRYOg@mail.gmail.com> <20160321180903.GB14892@calimero.vinschen.de> <CAOFdcFN4wkv40M-BJPhhHwjaDxh7YD7iXDhLaUcnW6qw=pwnYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="k18oBAwMkTg3OUap"
Content-Disposition: inline
In-Reply-To: <CAOFdcFN4wkv40M-BJPhhHwjaDxh7YD7iXDhLaUcnW6qw=pwnYg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00174.txt.bz2


--k18oBAwMkTg3OUap
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1305

On Mar 21 15:34, Peter Foley wrote:
> On Mon, Mar 21, 2016 at 2:09 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > I realized that your orignal patch isn't invalidated by this so I tried
> > to apply it and we could then add the other stuff later.  However, it
> > doesn't compile due to a warning, and since we're always building with
> > -Werror...
> >
> > [...]/cxx.cc:33:1: error: =E2=80=98void operator delete(void*, size_t)=
=E2=80=99 is a usual (non-placement) deallocation function in C++14 (or wit=
h -fsized-deallocation) [-Werror=3Dc++14-compat]
> >  operator delete (void *p, size_t)
> >  ^
> > cc1plus: all warnings being treated as errors
> >
> > I'm not sure it's the right thing to switch to C++14 by default using
> > gcc 5.3 yet.
>=20
> Ah, in that case, a better solution might be to drop this patch and
> add an explicit -std=3D to the Makefile.
> In that case, Cygwin won't have any issues when the default changes to
> c++14 in gcc 6.0

But using -std=3D when building Cygwin wouldn't change the fact that we
might need this delete anyway for applications built with -std=3Dc++14
or do I miss something?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--k18oBAwMkTg3OUap
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8FGsAAoJEPU2Bp2uRE+gu1sP/A10KKYcqdBmmBLi0JPhoAcy
C6n9UIv3+zY1EF6sCqp2OVpLcsUTI0Ltg2c5dZrUDkqRMI9t+NZvMdohvhXU9IaF
CGAli5qI3y5dwtrbsZmsGs2y1wxL7gPCdoMOa88+BMAKFArflWFstWYsE/IWdhsb
hYUK/U47aQwCDyHw4mwScUqQGlzW5y+oq1nsnFzqHFrxygV0M/Vq5zZcD91zcTii
zv706qKQ5QKOVBm9C6JKEtJUOqDqG9GmmxyBG/k51NaByACZUVS386vi2nUr6JCG
asXEnov7ZgBWyn7vOwLwzffi5FpAjLC/PTz0oEvb+pefGDW6d2s0E8f0WLNGwLr2
kslrqjPY3m7tOTGW8StoJpXA3DX6IBWRGBYI1w75etTr3wnyuDjzLFgm+N8KRIUC
wXumua6EvIU2Z0ozE0VhMQMLIDtpEmBQD1FSHvhPC6H3w8xZsvTggHgeSr6W8tdk
Zft73rPtSckOi3xrb61sBOsM/XP0q2EBXYnny8mgvGTSjGuKa1OzptDYiu6vcowm
R5EufUNkjX1k7O2taHKI78EWZvVR4uzr8u0T7YPeIognswVu3iV4DyS+UbzYDayK
RyadrKPgq/waOe+CheKg2fEMLu+H1qqQTc2hJCbzyOiqM2fWnNkBTz7+/HjUoob3
/7gIQdfXYvJIDKlcZt8d
=N4nC
-----END PGP SIGNATURE-----

--k18oBAwMkTg3OUap--
