Return-Path: <cygwin-patches-return-8345-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83804 invoked by alias); 19 Feb 2016 11:08:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83782 invoked by uid 89); 19 Feb 2016 11:08:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, H*R:U*cygwin-patches, H*F:U*corinna-cygwin, you!
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Feb 2016 11:08:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6CD57A80306; Fri, 19 Feb 2016 12:08:41 +0100 (CET)
Date: Fri, 19 Feb 2016 11:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Multiple timer issues + new [PATCH]
Message-ID: <20160219110841.GD5574@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAJCedbifwNgza6nUfSX6QH8ovnEy85bRJ=vH8SGuA_hNYdW5bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <CAJCedbifwNgza6nUfSX6QH8ovnEy85bRJ=vH8SGuA_hNYdW5bw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00051.txt.bz2


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1413

On Feb 19 00:39, Ir=C3=A1nyossy Knoblauch Art=C3=BAr wrote:
> Hi,
>=20
> On Thu, Feb 18, 2016 at 12:28 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
>=20
> > Would you mind terribly to send a copyright assignment per
> > https://cygwin.com/contrib.html?  If you send it as PDF by mail it takes
> > usually just a few days to be countersigned.
>=20
> OK, I will try my best. :-)

It's really simple, trust me :)

> I could not find any information regarding what the names 'gtod' and
> 'ntod' are supposed to mean, and their type names, hires_ms and
> hires_ns, respectively, aren't conveying that 'ntod' is monotonic
> while 'gtod' isn't.

Yeah, right.  Keep in mind that the original times.cc is from pre-2000
and hires.h is from 2002.  Way back when, source comments were
unnecessary because, as we all well know, source is self-documenting...

These days, I think what we should do here is

a) ignore the names and maybe even bulk-rename variables and types
   to something more speaking (rel_timer, abs_timer or whatever)

b) add comments, comments, comments.

> Also, as I have been writing this mail, I have noticed that there is
> still a data race left in the prime() function, so I have made a patch
> for that, too.

Cool, thank you!


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxve5AAoJEPU2Bp2uRE+gLA8QAJIImZj7ax9y1JtOFvtgWEUH
kArIhlPPMHiIflK++HMsyYQ8WyTbPo7dTOQzC+q/IE8pnbbvoVMEdK0SB5WVQKCj
TTZUpRYm91Qga4uQIKKGZna8F32FNSE+XfR4gfnmA4hK5ZuQ7WSmNm6jsR8+RFzq
hidRZ5jhH4ZKS/lVRReKT71TRlVHML11+2Xn1WSNS1IXjuhd/eWPCcHD3S17qcwO
lZxfbFjuTzyoEwZwVt8K8SDjNhCjkAkqGsu+kJE7kaDkpOfRXGOOy5m6B0uFJmHA
D+sSuFtkbr5Bx4OcHzem2c+gcqM1MbUd2P2zaYzzRjBJAppW3Ich4EgpYPMYG41r
nONO3ukS7jW/ZcVv7mXXL/Z8yjG6YQG17JAQ0qg6oLt+OEJK5oGIqSr36nISC8S9
45zALkUPgVhhyO2Q7x7XtBEs9PjbMRmOpsMPjBkG1JBwji4FrKHxz8lhNRt0/CEs
uRrE/xBrklQkUZ/SYhk70rA3Em4gq9454bYNQV76JN5LEt5OJlDLusYtW4kozsXV
KiiIi9IUq3K9Ipks519hrzBQnTt09V5mxHpvL5OmDzgDm54XcU5tsu5QlpVh53Zn
feDfRF+U1ZcB0YzhWZecwk50bEkRbYSMD4hhtc0IJv+tE0uBE6NdIVshY/IuEFeF
BO02VljOMqdDIXham1x0
=O5cA
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
