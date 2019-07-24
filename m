Return-Path: <cygwin-patches-return-9517-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110607 invoked by alias); 24 Jul 2019 15:14:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110593 invoked by uid 89); 24 Jul 2019 15:14:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:03431b8, H*i:sk:03431b8
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Jul 2019 15:14:55 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MvJs9-1ihRYz3KV7-00rJGN for <cygwin-patches@cygwin.com>; Wed, 24 Jul 2019 17:14:52 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4F53DA80871; Wed, 24 Jul 2019 17:14:52 +0200 (CEST)
Date: Wed, 24 Jul 2019 15:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: don't allow getpgrp() to fail
Message-ID: <20190724151452.GX21169@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190723161100.1045-1-kbrown@cornell.edu> <20190723161100.1045-2-kbrown@cornell.edu> <20190723165458.GM21169@calimero.vinschen.de> <59c6529d-b411-fcf5-fa82-8a681d5b6378@dronecode.org.uk> <20190723191648.GP21169@calimero.vinschen.de> <03431b8b-22aa-d288-aa11-87a9feedfb44@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yypaS3FvPkEUiGyo"
Content-Disposition: inline
In-Reply-To: <03431b8b-22aa-d288-aa11-87a9feedfb44@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00037.txt.bz2


--yypaS3FvPkEUiGyo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2274

On Jul 24 15:04, Ken Brown wrote:
> On 7/23/2019 3:16 PM, Corinna Vinschen wrote:
> > On Jul 23 19:07, Jon Turney wrote:
> >> On 23/07/2019 17:54, Corinna Vinschen wrote:
> >>> Hi Ken,
> >>>
> >>> On Jul 23 16:12, Ken Brown wrote:
> >>>> According to POSIX, "The getpgrp() function shall always be successf=
ul
> >>>> and no return value is reserved to indicate an error."  Cygwin's
> >>>> getpgrp() is defined in terms of getpgid(), which is allowed to fail.
> >>>
> >>> But it shouldn't fail for the current process.  Why should pinfo::init
> >>> fail for myself if it begins like this?
> >>>
> >>>     if (myself && n =3D=3D myself->pid)
> >>>       {
> >>>         procinfo =3D myself;
> >>>         destroy =3D 0;
> >>>         return;
> >>>       }
> >>>
> >>> I fear this patch would only cover up the problem still persisting
> >>> under the hood.
> >>
> >> I agree.
> >>
> >> There is presumably a class of programs which require getpgrp() to ret=
urn
> >> the correct value for correct operation, which cannot be 0 (since that
> >> cannot be a pid).
> >=20
> > However, did we ever see this problem outside of GDB?
>=20
> I think I've found the problem, as I just reported on the main cygwin lis=
t.  And=20
> I agree that my patch was misguided.
>=20
> But I still think getpgrp() should be changed, perhaps by having it just =
return=20
> myself->pgid as you suggested earlier.  There's no point in having getpgr=
p()=20
> call getpgid(), which does error checking, when POSIX specifically says "=
no=20
> return value [of getpgrp()] is reserved to indicate an error".  POSIX-com=
patible=20
> applications should call getpgid(0) instead of getpgrp() if they want to =
do=20
> error checking.
>=20
> I'll send a couple of patches, one for this issue and one for the tcsetpg=
rp()=20
> problem, so that we can discuss it further.
>=20
> Ken

I have a very puzzeling result debugging this.  I just outlined this to
Jon on the #cygwin-developers Freenode IRC channel.  Hopefully your
patch to tcsetpgrp clears this up.

I also found a problem in pinfo::this_proc / pinfo_init while debugging
the above.  I'll post the patch to this list since I would very much
like that you and/or Jon take a close look.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--yypaS3FvPkEUiGyo
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl04dewACgkQ9TYGna5E
T6DIYw/+K1UptwzW626fyuOMVYG6lrfNXkW/qGgE1VtPCqxJAi1zp5V8fV82BI7n
e+CGHij5xcl9aYGJkSk3hjQRfLlBe1G2VluP5pkc18x7fooBY51vW6SefMmbV4jw
Y1eeUdex3lvvHA71Icp7JkvHFmVD++6uhkAcETOBNvxW00YqDtveW9GP6Ku57JrP
gkbiGdmYUDQMihK1MbO/KX5mJYmZ4PiLcKZh05zV/jMzTBVakuy1882o6KzMQhJq
FqelfnFeTpdD8QKBXE3wYkat9iTY2EuQUN8P3phLDseRHuSWuhTDIUs2wlrXKdI5
3J+Ch4R4ri/ZVnUp8Q+/ksCVE7WbAZoMJUHyP5T/L/RnHRTiimYE/u6hjQK5SJ94
h6UnJNN4zpzUqYPy20lMX147c3XGgNHBojwYruTdCc14R686jk1WoNNPXg8bMEo7
k1k9CZJwk9WLh9hZIid71AdxKpvYwO9kXCeqogiECOGIL/mje3e0i1MPYOk2KqoW
LdSGVJRuKrueQtQ5b/Rtw06pzmBuPa7ep/nWuPneYbVsRbi4nx+7LDR7ouAoT7cM
B4MmyofoR9Nph6Wm5z+OiKdctQfkY6buLwEaLOPVvAteQzKOJGGd1GLLZwR51gCx
KPEnj0JpCnO7RWk1Qkjwi4lZdgp1wwSsTGW2cqkm0Ti5XJRp3d8=
=X749
-----END PGP SIGNATURE-----

--yypaS3FvPkEUiGyo--
