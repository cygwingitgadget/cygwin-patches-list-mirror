Return-Path: <cygwin-patches-return-7963-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5401 invoked by alias); 8 Feb 2014 17:18:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5389 invoked by uid 89); 8 Feb 2014 17:18:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 08 Feb 2014 17:18:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4066C52085D; Sat,  8 Feb 2014 18:18:03 +0100 (CET)
Date: Sat, 08 Feb 2014 17:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add minidump write utility
Message-ID: <20140208171803.GW2821@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52F50B71.8030608@dronecode.org.uk> <20140207174431.GA1640@ednor.casa.cgf.cx> <20140207191826.GA20749@calimero.vinschen.de> <52F64694.9060102@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="vk2EvGhio7iZz8DU"
Content-Disposition: inline
In-Reply-To: <52F64694.9060102@dronecode.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2014-q1/txt/msg00036.txt.bz2


--vk2EvGhio7iZz8DU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1612

On Feb  8 15:00, Jon TURNEY wrote:
> On 07/02/2014 19:18, Corinna Vinschen wrote:
> > On Feb  7 12:44, Christopher Faylor wrote:
> >> On Fri, Feb 07, 2014 at 04:36:01PM +0000, Jon TURNEY wrote:
> >>>
> >>> This patch adds a 'minidumper' utility, which functions identically to
> >>> 'dumper' except it writes a Windows minidump, rather than a core file.
> >>>=20=09
> >>> I'm not sure if this is of use to anyone but me, but since I've had t=
he patch
> >>> sitting around for a couple of years, here it is...
> >>>
> >>> 2014-02-07  Jon TURNEY  <jon.turney@dronecode.org.uk>
> >>>
> >>> 	* minidumper.cc: New file.
> >>> 	* Makefile.in (CYGWIN_BINS): Add minidumper.
> >>> 	* utils.xml (minidumper): New section.
> >>
> >> This is awesome.  Thanks.
> >>
> >> Could you add Red Hat as the copyright holder, like dumper.cc?
> >>
> >> You can feel free to check this in and update it as you see fit.
> >>
> >> Thanks for doing this.
> >=20
> > I agree, but, like some other parts of our utils, you don't have to put
> > the Red Hat copyright in there if you go with a BSD-style license, Jon.
> > Look at the header of ldd.cc.  This is fine for new Cygin utils.
>=20
> I prefer the GPL.  I will adjust the copyright holder as requested.

Ok, no worries at all.

> > Just one, really important point:  Would you mind to add documentation
> > for the tool and its usage to utils.xml?
>=20
> Um, I already did?

Oh, *blush*.  No idea how I missed that.  Sorry!


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--vk2EvGhio7iZz8DU
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS9mbLAAoJEPU2Bp2uRE+gDiUP/RD8dfulrJRw3ayUFhezN75o
6VQtZQKFynmE/6AfBmrEw6oXFEXk/CHQ1g+B8e+46SIPcbyLosQ8/tto+42CoT5v
F73a8EF7m1esofv5N8gU4WxSF+u9iM3pKUxzii/dP75P/Dw71jljtfmIr9mQc98y
WmC+BW0wj+5G8FxRaabfDgBaxU8rVkyJSCT7/AMBM+BsNXM6Ov9bsJ5Z5rfcFwKB
2KZ8OV00kS6MrnfB1zr+RBSKcZOFDq8IdvLp49Q8JBflNuwDGAdmlbmpZY6bmbs8
EKNtTUgzmX3TKD/LzpbPLYdWymIIE0q8o4ne+PeLNPvSGGMRpOluR40QEOMtI6mr
lCqC1R7Om4/4aAL360h30crQM9uVweaViRyfV+AKAdYxTzq9073h9YBhpGBO68gu
5zDgnW82zASgJ/KTh7rE67eGnfEWBaoy/in++kPVQdl8dBxR+Kmu2HL7KDIdyoWT
qrf/Z9RXZaKc1XjYkvPHUZjKnISLZY+xq75OrvTIcJih023k18bMuDr7b2SSWHmJ
yI/7nYCmutbpsODt1UCpdfaXlZo0+e3QFzlJtePeC9U7dyXiMVyV7mMGL1AxtLTK
6v0yjg68Sy6jIhGiM39Pl0BH4X+67Ts3+W7ujvoOcYTVMc7zl34cVjjRExLcWWeR
ynBj/uI8GiMUDCq3JMes
=yzZC
-----END PGP SIGNATURE-----

--vk2EvGhio7iZz8DU--
