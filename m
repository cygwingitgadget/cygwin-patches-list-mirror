Return-Path: <cygwin-patches-return-8271-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106912 invoked by alias); 18 Nov 2015 09:44:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106900 invoked by uid 89); 18 Nov 2015 09:44:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Nov 2015 09:44:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CB5BFA806A4; Wed, 18 Nov 2015 10:44:46 +0100 (CET)
Date: Wed, 18 Nov 2015 09:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: export rpmatch(3)
Message-ID: <20151118094446.GR6402@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1447784925-9024-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <1447784925-9024-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00024.txt.bz2


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 942

On Nov 17 12:28, Yaakov Selkowitz wrote:
> winsup/cygwin/
> * common.din (rpmatch): Export.
> * include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
>=20
> winsup/doc/
> * new-features.xml (ov-new2.4): New section. Document rpmatch.
> * posix.xml (std-bsd): Add rpmatch.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
> This depends on the newlib patch sent to their list.
>=20
>  winsup/cygwin/ChangeLog                |  5 +++++
>  winsup/cygwin/common.din               |  1 +
>  winsup/cygwin/include/cygwin/version.h |  3 ++-
>  winsup/doc/ChangeLog                   |  5 +++++
>  winsup/doc/new-features.xml            | 12 ++++++++++++
>  winsup/doc/posix.xml                   |  1 +
>  6 files changed, 26 insertions(+), 1 deletion(-)

ACK, thanks.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWTEiOAAoJEPU2Bp2uRE+g8ckQAIEAGx8L2EMqHCuEkGOrt9jo
9r+mESUeIvUmFdN2MPWxGIsLJ0h2jSj13bcICOzsmIViGCNlvvtK0lwDI38U0K7q
zTQwxOZgs3MI8YWW1aYjUHsj/JoMvE+ApCn3WFisU8XqM/XgW+pFhM9x6WzV4KRS
PaS/zAZAi9p9QFi7y4SGMKyoHRks2GoBhs0rogx4fgBJQm0opeCTAMDzt+K6rwXw
NONX7R5LWUewP9tyBZYODETjmQ1Z9pHMxf/3DrjtmSOkC3hkcSQs46PxkujkKnOJ
lKuZLI2h7ifIQ64eKrhM6OZfeKREUlHlxsnNgzeNs9TkYH6nW7MB3d5+wRPjUAxZ
Git0FwWGW8Rc1ree2l6Bicl5nYsEjAFPuFSo/6401aRj45g7bPExcKtcEatKb98+
ckf0BtnIIBJmbCpFI8C/POROKFWud5rXDnuVL2n4XLvWp4mjXdYrdA2AuFlgmtlJ
AOGcCjXeK6+qmnAwNMLUiGqK0yZV5DEDbxWO6UShHaYsCGxoaEjlsuW608jeTD70
ZqfXmHduwgyHxeVwP+PXVOx4vHNdNG3OuAxID4Bkxxx6gZBWSaFxjW+7jxt7D20R
51SdGCsMYU6J6+QkZ19298IoQuwIgajMdGZzz+jI97Haqv//Q/msy8QqS5JLK/xn
tnRb3alT5+aZ1hB9FnT4
=KIDU
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
