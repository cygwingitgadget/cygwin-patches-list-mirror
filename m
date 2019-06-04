Return-Path: <cygwin-patches-return-9432-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32779 invoked by alias); 4 Jun 2019 07:42:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32770 invoked by uid 89); 4 Jun 2019 07:42:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-102.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Jun 2019 07:42:16 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N4hex-1gXGxm1ksZ-011mNm for <cygwin-patches@cygwin.com>; Tue, 04 Jun 2019 09:42:13 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 18032A8061B; Tue,  4 Jun 2019 09:42:13 +0200 (CEST)
Date: Tue, 04 Jun 2019 07:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygcheck: expand common_apps list
Message-ID: <20190604074213.GR3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190523170532.64113-1-yselkowi@redhat.com> <20190603221948.30538-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="WZLuFERxa6Y0cbOt"
Content-Disposition: inline
In-Reply-To: <20190603221948.30538-1-yselkowi@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00139.txt.bz2


--WZLuFERxa6Y0cbOt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 418

Hi Yaakov,

On Jun  3 18:19, Yaakov Selkowitz wrote:
> An increasing number of tools are being included in Windows which have the
> same names as those included in Cygwin packages.  Indicating which one is
> first in PATH can be helpful in diagnosing behavioural discrepencies
> between them.
>=20
> Also, fix the alphabetization of ssh.

Sure, please push.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--WZLuFERxa6Y0cbOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz2INQACgkQ9TYGna5E
T6BvpQ//fXDHrLbgycL5CqB5d/EEJ9zOfLU2dvVex1DZbIAHT0ML7sn3maoFiSnK
PYDfMmpGmuWuFjvIebtpMjAvYVQ4MFxEfCz9oJUd+gbORDqbcT+FuZLYOUZeH19e
x5EsgoXo+JGrgt7bw8FkMAq1KBBjT80FEVsk7oFtTGXxEPwwm3uUoZQI75VlH6Nk
3RlgE5kfcqcw3jtMn+Th3c5wLd4KTMZ6hAVMYIaz0WBphq2/iIsc9wQ3rU+137PY
w7NOApkNpyt5U4gEncYb5ewBX+vWmIuX1WOkViShyr7G/4CdueH+h5zi1TA1RCZX
QPF1g648iAGA5J/TxfvirTPalbJMcEHJUWnNGBGXUQhqgliRs6orFAJcKAtXLGZ6
LevjKZRV+UIjqXtMFp3oVr4lk8JvQiB8AjbVx+Z2tFDoKaxI0bz/lr8s/1KXlN6c
rv8T+4BESSjDXycSUPz+W+Vn9aXOiDb6ljksMBN3yNnyo1vVPUzz8y0jtkXLcjYf
cwTjv/BW78Dn1Ej+1kBUvKa9GlmjNey0K5YQ9NM6Zx+f5o5+fiPcuHVV/1l9ZM01
OMlqVRAH6Bg4i7YubgJJDUwj/ANKNzsxTpUkdDZQrbfmpwrNi46aNwNdAIIxdIBl
qe3xFsvAB4+Wxa2rVUBW+6dZ3aeinoxFXxpLJdqVGYF2dClFKOw=
=S10+
-----END PGP SIGNATURE-----

--WZLuFERxa6Y0cbOt--
