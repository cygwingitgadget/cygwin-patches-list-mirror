Return-Path: <cygwin-patches-return-9511-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16966 invoked by alias); 23 Jul 2019 16:55:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16957 invoked by uid 89); 23 Jul 2019 16:55:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=begins
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Jul 2019 16:55:11 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MkHEH-1iINr843qb-00kfMn; Tue, 23 Jul 2019 18:55:00 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B7ACEA8076F; Tue, 23 Jul 2019 18:54:58 +0200 (CEST)
Date: Tue, 23 Jul 2019 16:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>,	Jon TURNEY <jon.turney@dronecode.org.uk>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 1/1] Cygwin: don't allow getpgrp() to fail
Message-ID: <20190723165458.GM21169@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	Jon TURNEY <jon.turney@dronecode.org.uk>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190723161100.1045-1-kbrown@cornell.edu> <20190723161100.1045-2-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="L/Qt9NZ8t00Dhfad"
Content-Disposition: inline
In-Reply-To: <20190723161100.1045-2-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00031.txt.bz2


--L/Qt9NZ8t00Dhfad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 796

Hi Ken,

On Jul 23 16:12, Ken Brown wrote:
> According to POSIX, "The getpgrp() function shall always be successful
> and no return value is reserved to indicate an error."  Cygwin's
> getpgrp() is defined in terms of getpgid(), which is allowed to fail.

But it shouldn't fail for the current process.  Why should pinfo::init
fail for myself if it begins like this?

  if (myself && n =3D=3D myself->pid)
    {
      procinfo =3D myself;
      destroy =3D 0;
      return;
    }

I fear this patch would only cover up the problem still persisting
under the hood.

> Change getpgrp() so that it doesn't fail even if getpgid() fails.

Instead of calling getpgid(0), we could just as well return
myself->pgid.  This never fails for sure.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--L/Qt9NZ8t00Dhfad
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl03O+IACgkQ9TYGna5E
T6DrPBAAnGiNtJMwstomwX8XciowZIU1lu8/YhIhnImr2eb/1fAZZpD7wJ+0XZ+6
i9j+Rcq3z4loOWWz/BTaXD7yVLpaFHe3JIB5mkDFbE68H5y0p2R0q0bLDu4Eqv1P
wQCdRAH1IOpF85yQtmRXIP6ZseeaoMNK/UAbEgUfbxzikw58vEOF7E2sfMFgMoeK
AXacWaekiPvwQKkecRekSi9/9ki9hrlM4HvGkPXBfYgYJR4+L57Yhv5lJWnw4DxZ
pgTxqFzr7SPXfQaHOq6VccK62nkIbM6QbA8NehCdKAHvTOhIvCRSzjNMFhUkKaGs
HNFKcwck8+NEJr1npzsc2YCfi5FJT0a/7Lp4dnwl26hGm7tdqjPa4KEx6yrPmC5J
C82dxHGXUkY2cRReOMw7jixnXkwfz1KhgRtU+FlzyrRDePO8cO5mKwfjUI83HwKy
Ozbr7xbdOZrXbagTVNfnVFoO5acU2dkFay618pj3UNjFYX3PbIGyj3I/RQcS+G3Q
xY/qcEThXp6P8eXOroT0hMrvZZ39TF40GFg6sgPGLBZdKbG5HwD3/NmsndZwMkac
oGNThj+fe7wYBhCcgmmWJIVJ23DA73gKYiCrddvUUqkbaN5sREjLEzQUWFs0+GnC
bBoL50tgwxQEuoojOgIQ6IfGG5zS0M52/bFBrwInQjYBUh52HZk=
=MPdD
-----END PGP SIGNATURE-----

--L/Qt9NZ8t00Dhfad--
