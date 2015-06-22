Return-Path: <cygwin-patches-return-8215-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47720 invoked by alias); 22 Jun 2015 18:37:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47705 invoked by uid 89); 22 Jun 2015 18:37:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.7 required=5.0 tests=AWL,BAYES_05,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 18:37:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D038CA8094D; Mon, 22 Jun 2015 20:37:15 +0200 (CEST)
Date: Mon, 22 Jun 2015 18:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/5] winsup/doc: Add intro man pages from cygwin-doc
Message-ID: <20150622183715.GM28301@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55884387.90405@dronecode.org.uk> <1434995222-7256-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <1434995222-7256-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00116.txt.bz2


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 657

On Jun 22 18:47, Jon TURNEY wrote:
> v2:
> intro.1 and cygwin.1 are identical. Make cygwin.1 a link to intro.1
> Update dates in static man pages
>=20
> v3:
> Use doclifter to convert intro.[13] to DocBook XML
> Clean up markup and fix a couple of spelling mistakes.
> Build and install manpages from XML
>=20
> v4:
> Update to refer to GPLv3+, SUSv4
>=20
> 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
>=20
> 	* Makefile.in (intro2man.stamp): Add.
> 	* intro.xml: New file.

GTG :)


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViFXbAAoJEPU2Bp2uRE+g8A8P/jIAVzTY47PBtvzJiKIHlxAl
kdkpXZ9C4FkQmjFVQ15M2Cm12QDLismlMMVtlheamtYXJP4qjTPcmyjSek7NpjJl
3+Ok+tgAW0kSoBH/7wj9G1ThRIA/r2a4m3ma0steXo4X5+te5v0UVi9XJuIgXtnB
IsxjsoCekKGPUj6koMtD5AODdI2jvm1TnDWHPF5pcOGQ5hbGwwPAl1fzXinbTQV0
frryZMb9e8h/yo7+1g7uxnL54HKeLJ2srGHcgjsw6ysPXzNttJEpASmF6QU+5hjK
rxvehebKf49y5fJYHGdSHtc7dm/pWOvQGHi21oX8a+nHkHohMtPCmFY2632LBvyV
wjf1kaMFqEtc8jaNpAacCbTlJvVNPugOkoE7CDHUKhctd/oeuB7hbunSBh2U1T/J
AZPYSPT/86P6hrHZ0ThJYxpIAMVmDV5XzXM8sfW1kGQO7I4f4FgPUdnUlFZhYF1F
Mvkz7ivNj4K3VEtRaQklWkqqte+PB4c2Xat+QxdYd/hdQQmgjok4CB7rOQe19G2G
jRm/+3pNTecdwGRkuvuRMvBo2WozuINGl0PcY470LcpMoZ+aO/3smsdacLSirFFa
QLYwuLHe1jBRXUWeAxkwTtwcDN3cMjFh8iUh9UEx/pSLvBKbjsVkd52jOnxHit5L
y5SOYUFyT43S0DRXFLhO
=JR4a
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
