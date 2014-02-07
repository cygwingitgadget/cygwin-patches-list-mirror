Return-Path: <cygwin-patches-return-7960-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1645 invoked by alias); 7 Feb 2014 19:18:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1631 invoked by uid 89); 7 Feb 2014 19:18:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Feb 2014 19:18:28 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 31A4952082E; Fri,  7 Feb 2014 20:18:26 +0100 (CET)
Date: Fri, 07 Feb 2014 19:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add minidump write utility
Message-ID: <20140207191826.GA20749@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52F50B71.8030608@dronecode.org.uk> <20140207174431.GA1640@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20140207174431.GA1640@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2014-q1/txt/msg00033.txt.bz2


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1289

On Feb  7 12:44, Christopher Faylor wrote:
> On Fri, Feb 07, 2014 at 04:36:01PM +0000, Jon TURNEY wrote:
> >
> >This patch adds a 'minidumper' utility, which functions identically to
> >'dumper' except it writes a Windows minidump, rather than a core file.
> >=09
> >I'm not sure if this is of use to anyone but me, but since I've had the =
patch
> >sitting around for a couple of years, here it is...
> >
> >2014-02-07  Jon TURNEY  <jon.turney@dronecode.org.uk>
> >
> >	* minidumper.cc: New file.
> >	* Makefile.in (CYGWIN_BINS): Add minidumper.
> >	* utils.xml (minidumper): New section.
>=20
> This is awesome.  Thanks.
>=20
> Could you add Red Hat as the copyright holder, like dumper.cc?
>=20
> You can feel free to check this in and update it as you see fit.
>=20
> Thanks for doing this.

I agree, but, like some other parts of our utils, you don't have to put
the Red Hat copyright in there if you go with a BSD-style license, Jon.
Look at the header of ldd.cc.  This is fine for new Cygin utils.

Just one, really important point:  Would you mind to add documentation
for the tool and its usage to utils.xml?


Thanks a lot,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS9TGCAAoJEPU2Bp2uRE+gYnYP/3GR7vudc6+qKpPXW8sIW1iQ
AvZJ0x3EmSFJ6GC+1ypjTTAepbH4zukeElbk0Wtrzwz8gz1Nqv1zuPo/2ItvsJXe
Xrdfi9MPcuSL9Fd8MgymI8gZN4S1a+B8826U1kMNNLSLCqnB35nrnbBVYgWA5FSg
2ChNTO170cKLl98APP/K1dPZuR5MNJAU77U4DHjQulsLKk3zo/VUmYb+kS+Di3NU
2q9ue7clhH3Zz1ddzPSQs0y8noCdazoJhSWaIylGmMG6xS9KKxPJRVhjGMuNLMIZ
/60mCRUS/ep8byuc3j/W5dNj4A+8PPF19Tne7KxOVAzsrYGBvOjXPC0zi8YR3oSy
yGECcxuur5WMfQRUm3ZqqlQPsoew0OOgV4Hx7wGGKIerjtUUxcHSW3LI4AvCeCRE
cEB0vIOSUjaR/AFqo4N4jtB4NbRg2tR+CDGSWXSGjYTmD4qBH3B6JD7HQuIgYPhS
KJidbR2ScsePdswm9RRJGraYVJycbRrVBK4r6rcR1XCvBP/MaYufom9ofMM7aDwo
94M4uH1kHuoaEmMVYR5Bt+IuqidjgwMcP772j3RETxwXvRHnxz83+4H3sLcpBGkC
2FES494hXEY/yZf3je7ggX6AlpkUNHQApjDzrVSRgx/ZHbYkQ8OlIKueBrdcfSoi
/tTNDIfqrKuROFfBH2ik
=h9XX
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
