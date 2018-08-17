Return-Path: <cygwin-patches-return-9183-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85140 invoked by alias); 17 Aug 2018 09:39:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84223 invoked by uid 89); 17 Aug 2018 09:39:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-110.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=mails
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Aug 2018 09:39:21 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M7sZ6-1g3iCN0Wsy-00vOmi for <cygwin-patches@cygwin.com>; Fri, 17 Aug 2018 11:39:19 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 811E1A81F25; Fri, 17 Aug 2018 11:39:18 +0200 (CEST)
Date: Fri, 17 Aug 2018 09:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setfacl: Rename the option --file to --set-file, as on Linux
Message-ID: <20180817093918.GP3747@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180816185528.11200-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZOBTspFzEMOlPevk"
Content-Disposition: inline
In-Reply-To: <20180816185528.11200-1-kbrown@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00078.txt.bz2


--ZOBTspFzEMOlPevk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 511

On Aug 16 14:55, Ken Brown wrote:
> Retain --file as an undocumented option for backwards compatibility.
> ---
>  winsup/cygwin/release/2.11.0 | 2 ++
>  winsup/doc/new-features.xml  | 4 ++++
>  winsup/doc/utils.xml         | 4 ++--
>  winsup/utils/setfacl.c       | 5 +++--
>  4 files changed, 11 insertions(+), 4 deletions(-)

Perfect, thanks!  Pushed.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ZOBTspFzEMOlPevk
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlt2l8YACgkQ9TYGna5E
T6C42hAAmMYsrUgXJarsRY/+ehXl22mwT+gZTnyFV9XTI2sl/vKFculOyeToDlFx
XxpJxg+nUldpCfNKvGTSK5732zscBOXfRzr+I+8AqSPMAM+vcvlkDciXzl4cG6Q0
vUeeDqUk4eCa7cr3WjwofBkD6ctomrRjEkfJCnuoqTlbqZFsW974ejYPJ90SvHDr
qI8V1CCpzr5497Wokb2UrF42ooz2XAvwBkpU8d9TriGql3w1gaXGZsxZ8eebcqmb
a5rPSC2dng1RldVuKkNFAJ2wWPN/6T5epu/E7dedcCB6TyP3ql3S4CutKlc+9RcE
x0PESO0QCowwYFCHQlapzl8ZjTY3ckXipmKPFHhNuSvhaWikl5hdGSv+yGXF84WX
xM4/cL222j056ywAHQ8ZZx03q8s/hjl3qzRM1avY3XUW1AnB/74Skk3oz/TR7bau
rcnEygNHhLh33xfKk60UIoRcvun27xnWdTXPbsTFqttpy2xTAAdL8Sk/wxjgQ4nJ
ZoN0C//dqcwmzBIPXkMuXSMasiU2MFjls9+TXrCsFREseNtSc+Iy2jJ/fXVJ/y+n
6oSlyL2lnaxCJ6IIuBlfojwaHJLricRxijOqE2eOBaOI1WMN+CZVtVxJnUIad6rE
zjy/5RJ1pRoFZs5kvnHkMICW3NBsZxGGtx4D2W923y2FkVYyl0U=
=GEDC
-----END PGP SIGNATURE-----

--ZOBTspFzEMOlPevk--
