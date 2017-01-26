Return-Path: <cygwin-patches-return-8687-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66472 invoked by alias); 26 Jan 2017 20:20:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66449 invoked by uid 89); 26 Jan 2017 20:19:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-100.3 required=5.0 tests=AWL,BAYES_05,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=tcp, TCP, recommendations, Cool
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Jan 2017 20:19:57 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 838CE721E280C;	Thu, 26 Jan 2017 21:19:53 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id BB9B95E01E6;	Thu, 26 Jan 2017 21:19:52 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9E641A8058D; Thu, 26 Jan 2017 21:19:52 +0100 (CET)
Date: Thu, 26 Jan 2017 20:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, Daniel Havey <dhavey@gmail.com>
Subject: Re: Limited Internet speeds caused by inappropriate socket buffering in function fdsock (winsup/net.cc)
Message-ID: <20170126201952.GA2613@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Daniel Havey <dhavey@gmail.com>
References: <CAO1c0ATh9aD-zbHcpna76EXr-Lavrbk5rnnnJC+bAtehe2xXHQ@mail.gmail.com> <CAO1c0ARd7smeWLDpqHVyBSvcAZMSAKA4uDc3e2nKHpT73PiWBQ@mail.gmail.com> <20170114151721.GA919@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20170114151721.GA919@calimero.vinschen.de>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00028.txt.bz2


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1821

Hi Daniel,

any news?


Thanks,
Corinna


On Jan 14 16:17, Corinna Vinschen wrote:
> On Jan 11 16:38, Daniel Havey wrote:
> > Hi Corinna,
> > I can see your email on the archive, but, I never received it in my
> > gmail account (not even in a spam folder).  I think the Internet ate
> > your message.
>=20
> No, I only sent the reply to the list.  It's customary in the Cygwin
> mailing lists not to CC the original poster, unless the poster requests
> it.  I CCed you now, of course.
>=20
> > Yes Windows :).  I'm the Program Manager for Windows 10 transports and
> > IP.  Anything in layers 4 or 3.
>=20
> Cool.  I'm glad for any input from "upstream" :)
>=20
> > We can help you with network stack in
> > the current release of Windows 10.  Downlevel is more difficult.  I'm
> > not sure about the answer to your question on the size of wmem.  I
> > don't think that there is a static value that will work in all cases
> > since Windows TCP will send 1 BDP worth of data per RTT.  If the BDP
> > is large then the static value could easily be too small and if the
> > BDP is small then the static value could easily be too large.  It will
> > take some digging to figure out what the best practice is.  I will do
> > some digging and let you know the results.
>=20
> I'm really looking forward to it!
>=20
> > In the mean time I will apply your recommendations to my patch and repo=
st it.
>=20
> Same here.   Thanks a lot for fixing another of those pesky "Cygwin is
> slow" problems :)))
>=20
>=20
> Corinna
>=20
> --=20
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat



--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYilnoAAoJEPU2Bp2uRE+gWQkQAIaMKtX7CulJh1NOKlFpwweU
GC20VzCGQs0y/8Hd+ApyOXqiabCJ2nJfopoCqV+EebhJhSwIdS3Xw+FavWBh3SFI
wyKE7slkzjb+FnBuF6L663EKDK6TcitwUyTxwZ1n+GnN/pW0186bgcWyhfCHwxD7
V28bUfA/xKbr2F2lnZrDojEW306T42GF1JpQJhUO5KQbblpZjd5xhjfVAWBBNZX7
jxKYUeyWhlUcwfgRfSgKUeoiKkpmSux8+a48PpLXpMTWN5gG3Om5ycSg3GfX5PMy
JzHbmksESE0rXAWNkSgjyV94YhI5nEn84PrW6T8Fv8mCaqH1vuLZ053wjpKhUBFK
BahMeKYiI77pKMGrVzgpupX1JJgHurFPS6y+cgkGYrd24Rtu3Vxi6tow21IIztqM
SX0c+UFqp50qyoQz+iWGL6e/I+RiWQn7KWEGPp+mQov9qnTwTM7GLSvKwKa/Veoo
8CVCpW5ebA1AJjOvT4S5haF20B8boUlz7/1Oe80n8p4ZyvHLkulgOnexFCGXxATZ
9Sr+fTxzLbsJL/i0edm2jjd+rVX/Ia6Iw7J2Nw4FhCTtRKtZ+M0Ij826ycvIheog
z4WGL47jUTuxiQI6HpT7qlNtM9X29YSKNvOCkgyU2ETe8/vMytdOfUlvBYSsMKHE
iNgAoJ3wCwX69Nehhwk9
=sA1y
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
