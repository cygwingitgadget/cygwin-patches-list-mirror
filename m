Return-Path: <cygwin-patches-return-9093-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10518 invoked by alias); 7 Jun 2018 09:00:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10183 invoked by uid 89); 7 Jun 2018 09:00:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-110.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Hx-languages-length:1693, developer
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 07 Jun 2018 09:00:23 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LehC6-1g3iR93ZgU-00qSbJ for <cygwin-patches@cygwin.com>; Thu, 07 Jun 2018 11:00:05 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 91BB2A804D8; Thu,  7 Jun 2018 11:00:04 +0200 (CEST)
Date: Thu, 07 Jun 2018 09:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/6] Implement clearenv
Message-ID: <20180607090004.GC30775@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180606154559.6828-1-kbrown@cornell.edu> <20180607081544.GA30775@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <20180607081544.GA30775@calimero.vinschen.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00050.txt.bz2


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1857

On Jun  7 10:15, Corinna Vinschen wrote:
> On Jun  6 11:45, Ken Brown wrote:
> > This is a followup to https://cygwin.com/ml/cygwin/2018-05/msg00334.htm=
l.
> >=20
> > In this patch series I attempt to implement the glibc extension
> > clearenv(). I also implement glibc's notion of environ=3D=3DNULL being
> > shorthand for an empty environment.
> >=20
> > v2: In patch 2 I've tried harder to fix all the cases in which
> > environ=3D=3DNULL could be a problem.  I did this by grepping the sourc=
es
> > for 'cur_environ' and '__cygwin_environ', but it's still possible that
> > I missed something.
> >=20
> > I've also incorporated the changes suggested by Corinna and Yaakov.
> >=20
> > Ken Brown (6):
> >   Cygwin: Clarify some code in environ.cc
> >   Cygwin: Allow the environment pointer to be NULL
> >   Cygwin: Implement the GNU extension clearenv
> >   Cygwin: Remove workaround in environ.cc
> >   Cygwin: Document clearenv and bump API minor
> >   Bump Cygwin DLL version to 2.11.0
> >=20
> >  winsup/cygwin/common.din                 |  1 +
> >  winsup/cygwin/environ.cc                 | 56 +++++++++++++++++++-----
> >  winsup/cygwin/include/cygwin/stdlib.h    |  3 ++
> >  winsup/cygwin/include/cygwin/version.h   |  7 +--
> >  winsup/cygwin/pinfo.cc                   |  7 +--
> >  winsup/cygwin/release/{2.10.1 =3D> 2.11.0} |  1 +
> >  winsup/doc/new-features.xml              | 20 +++++++++
> >  winsup/doc/posix.xml                     |  1 +
> >  8 files changed, 80 insertions(+), 16 deletions(-)
> >  rename winsup/cygwin/release/{2.10.1 =3D> 2.11.0} (97%)
> >=20
> > --=20
> > 2.17.0
>=20
> Good job.  Pushed.
>=20
>=20
> Thanks,
> Corinna

I created new developer snapshots.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsY9BQACgkQ9TYGna5E
T6AcdQ/7BWAB3cIn5+iccxVOxYss69nlmpYVUQObzvkhU173xcSaBsS0yvIkPuIX
Rnwc56ONJfDrezDJREFb2rOMhocYqOGHa6k7Rrh71KSqfqLyGl8c+LhG46Ds4JvE
pKm4xed/LJzCYDCcP+KaWo5Zpzgh9EWr6ET7FYIVwcxnxNNTg7LMQ8pAWmzuc1TW
DZuH6GP5h5toOVKQ0neYlYuHotNoKQHSD0HoGHKqtPKUgbqJa81taKRytJanE+my
agUOgnagFSfwE97qQHYx5EGUB+8dBL/oBWytoclC+fIuf3/RIo2g3yJ2XObPUahC
HqTflRHYwe1fvLryG3WcJWAixOvWm4/nbmW4C1b7+Jl5u/Lspqr0ItPWYXabsHXV
SdptFs7uiarkqE1dR6MtkPBNrzLtwyJtMQGR7Sm8gYlE7DQb9b/5Yu3864cfIuw4
ikm2UVRYby1ui6KhpvZ0+nUXO1I14L3Uslkn8NWokPuR8BjqIWwVMOx0STpPsIFD
XUVN7F4HRhWlEKNWfu9WyfifadSli2grELA+i6DYowhLJz/TmTn8+9PSHhoWbO/w
kF9Yr91/72Erg5e1FQaoB6cX05SUketPLZfjDaD9UkE655YY3vksCG25vBBZr60+
4TMEkfSYCsMEz35Uu///Yabx4wg3Zwd79NKlW1fxuwU2sX6yDm4=
=VyO+
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
