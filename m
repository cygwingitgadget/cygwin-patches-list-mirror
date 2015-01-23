Return-Path: <cygwin-patches-return-8054-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10022 invoked by alias); 23 Jan 2015 15:00:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9967 invoked by uid 89); 23 Jan 2015 15:00:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.7 required=5.0 tests=AWL,BAYES_00,URIBL_DBL_ABUSE_BOTCC autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 23 Jan 2015 15:00:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 406058E0089; Fri, 23 Jan 2015 16:00:01 +0100 (CET)
Date: Fri, 23 Jan 2015 15:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add-on to gethostbyname2
Message-ID: <20150123150001.GA12362@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0NIL00E86XTQH2L1@vms173013.mailsrvcs.net> <20150123104758.GB5612@calimero.vinschen.de> <010c01d03719$1c312fc0$54938f40$@phumblet.no-ip.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <010c01d03719$1c312fc0$54938f40$@phumblet.no-ip.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00009.txt.bz2


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 658

On Jan 23 09:30, phumblet@phumblet.no-ip.org wrote:
> > From: Corinna Vinschen
> > Sent: Friday, January 23, 2015 5:48 AM
> >=20=09
> > On Jan 22 21:05, Pierre A. Humblet wrote:
> > > Add-on to gethostbyname2, as discussed previously on main list.
> > > The diff is also attached.
> > >
> >=20
> > Do you have some wording for the release info in the docs, please?
> >=20
> Make gethostbyname2 handle numerical host addresses as well as the reserv=
ed domain names "localhost" and "invalid".

Thanks!


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUwmHxAAoJEPU2Bp2uRE+g7/8P/2Rjso4bKlUxkaO+Iq4r0PGT
I1DGwVHfWnurHkOWvvnMDA/A8cl2dTE65eWYi2eWJWlwEw8QTjFhIYHFEdEEXMzJ
faHaY40/IsblD26kDpP26Vo/5NLfq5CbPJvfrG+xz586bWpCWtDuifJvb9rD4rVK
yrsfvVEIiK16pkJbVyz8+ZQbdU4ctsB+IEmB4hbLYJrQupX/9DIdGiStyrxPW/lV
DgIc8E31wU9Tp0bbK3ByafrOBsddrdUBcK7NDtZWBv13JYaUd45p9hhlNj9Z8Tsg
qJa4BDk8in1gjW3nBDI051WGaZICQ4EGVrQVoT/3ULq2ZW4xNHogDAnPlD/7MNe7
D1FCeHicfB0ulRYvxFgL1CWNvsJukGG8BYYl5AStTlhFnlhZzIz8OX8k+Bw3MVnz
V6qf3G3k+vq6FVjN5qa+biBW58eVUGjpF8YMAXaBc9k6uLnTc3NRjxJXTO9Xn1/W
DRNgN0Ki0GOE2DHggUOFTqgX2NYVJKM14SBy2keW5C3dQ9pcKUPKcmE2ViZ9SeA9
tta2RcKxc+n8p2oW0qmPKTUlpoC6uEXhgaq9etLq+YhQMDNzcM4ldJRH3wapVklt
i3zoR27Y/ETNBajhcW5VdVil9XLaGS7/XdHUqUCJjdk3/tBFb+uwasYdurRi8aUI
7P1xZnF61VgJdSOP4AWT
=3j2B
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
