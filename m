Return-Path: <cygwin-patches-return-8256-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81011 invoked by alias); 21 Oct 2015 18:48:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81000 invoked by uid 89); 21 Oct 2015 18:48:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Oct 2015 18:48:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 269E6A803D5; Wed, 21 Oct 2015 20:48:01 +0200 (CEST)
Date: Wed, 21 Oct 2015 18:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add ability to use NTFS native directory symlinks without admin rights on XP and later
Message-ID: <20151021184801.GG17374@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <766021443021831@web4g.yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <766021443021831@web4g.yandex.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00009.txt.bz2


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1167

Hi Evgeny,

Preliminaries: we need a copyright assignment from you before being able
to include your patches.  Please see https://cygwin.com/assign.txt.

On Sep 23 18:23, Evgeny Grin wrote:
> This patch will add ability to create directory junction which are
> supported from Windows 2000 and not require any special rights (unlike
> file/directory symbolic links).
> New three modes for symbolic links creation added: "safenative",
> "safenativestrict" and "safenativeonly". First two allow fallback to
> "native" and "nativesctrict",

I'm not opposed to add functionality to create directory junctions
as symlinks, but I am opposed to adding lots of even more confusing
settings to the CYGWIN=3Dwinsymlinks option.

I'm ok to fallback from native symlink to dir junction in both
winsymlinks:native and nativestrict modes.  We could even always use dir
junctions for dirs in the first place and only try to create a symlink
if that fails.  The difference is negligible from a user perspective
anyway.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWJ93hAAoJEPU2Bp2uRE+gkk8P/3NCc740gWAcU8h4+iPhomcz
Q/fhNtP/g3Il8X8qm3VMM2ahgisVkzjT/kuSCT4LGAUs0ICS0/bkjaz5nfZm+EVB
KLpfsH19FNz/ikj5Hyu8bYO/YLmbpnkJSgesevmKezyAhH/oAspkP2KgGof6kQqJ
Vqrnmds9imxrc/oCBoJxwthuigLChb8QwVxYpKpvqjISmdMppSATxO95dXH02Vz7
lTS9XRvyyAE2B42qO682b0NazKREQ3lF7+dP+a1Wlgi8kTX5fTkFEyaCoGKoPj0p
QKQrk8A0RkBgBtRh5Mx41++Yh056JoNmWOs/BPVECjiuU3mtVNp/gOQ0HhWDWVPL
NrC9yUxP9wwo2fGaP/yVyYFaqvDjsToUBciENJFfvC6bTc+KXloCwuSsU/A1WbKE
75fN8ZlD+7OOg/bPNR9s2LgJSzhVcBBAzqteAu3wZ+HVrMD/DeYC3XYSK5JV3fIP
VN5D7bRWiPXYlb4hUzD0QLDMFtJScpOPoAsvYKE02XVq9lPHCPbR4uEraMCf12DR
QiMLCwUQKe/uaGGRwjMZaeQx2etEmvbmooTDg8f9xZ1CBg3nu5WV5+sBA4zK2AsL
9qcEygnh2wq/glxgi5HcA55VyeSScVGGGEpYGxbRRfNRKF/H3JCUQbpHuG/9Efux
I2Ho+c6wxrrxCrzqAg3b
=smYZ
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
