Return-Path: <cygwin-patches-return-8495-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23299 invoked by alias); 29 Mar 2016 08:11:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23284 invoked by uid 89); 29 Mar 2016 08:11:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*r:500, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 29 Mar 2016 08:11:24 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0BEDBA807C8; Tue, 29 Mar 2016 10:11:22 +0200 (CEST)
Date: Tue, 29 Mar 2016 08:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: export __getpagesize
Message-ID: <20160329081122.GA4043@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459187300-8800-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1459187300-8800-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00201.txt.bz2


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 961

On Mar 28 12:48, Yaakov Selkowitz wrote:
> The inclusion of <sys/cygwin.h> by <sys/shm.h>, besides causing namespace
> pollution, also makes it very difficult to get the WINVER-dependent parts
> of the former.  This affects code (such as x11vnc -unixpw_nis) which use
> both SysV shared memory (e.g. the X11 MIT-SHM extension) and user password
> authentication.
>=20
> getpagesize is the simplest function to retreive this information, but it
> is a legacy function and would also pollute the global namespace. The LSB
> lists another form which is in the implementation-reserved namespace:
>=20
> http://refspecs.linuxfoundation.org/LSB_3.1.0/LSB-Core-generic/LSB-Core-g=
eneric/baselib---getpagesize.html
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>

Looks good, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW+jipAAoJEPU2Bp2uRE+gJjYP/3LWts8FjKeoE/Fs2XR0JHrQ
HmFlvJ5QkLxkYkiL6Hh3QBD9Cqcq+PinKDTXQs3DsjAPNyz2ZjKCzMBLZTrMdAlg
L0KOOfV9HEjFWofJDPN0y5SIq5rviLX8txgutlYkgs5Gcdrp/zDWUMaPl0hAze3Y
gfQ2z4OWS3QIoWz0trJ/LJOTmkhSC4hfpbmMFKHZq2cKHQQTdOkJtmFpu6UXmU5V
Yjb/jfiLZJh8eOGairwOCgfynMl9FtsEUOudfoDY5aCvMf4c77/ARazdOUSNeJps
SxvDsnT2S13jeEIrGDWda7fsXagRiQ+xIFqUn+PdPCcXjc3xgYkwm31L4onXVBCr
FaSgJmJsKqoCUcc/JmVNtKtH2POf0TDKJXnSHBIAOTkG+VbEVPZIjULniG6DhXok
gmdqpG23Y08xVqqjDpuXCMsdEUB3Im6OTITC5/vvj4Hp7GU3+5RwhWD6NKbsO/RT
Ao+CPQD5XRubaxf2VTWWO77BH3BHGsexDFllU7gufqJjeabyQ13x39lyP5jATMgT
ySluFI84xWNfQRrEBde+5fVxlF9C+I1e59bYNQu/Xeo3uXwjG3ty6x708NVK+BQ8
BkOJ+hNZGd259c1HMEu/2TR1KrJ6wAsPYBAo57QEPp3l0xiDFmLrYafKDKfhguAB
8GlaDHek+jpg4DSUQlxO
=6g1l
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
