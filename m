Return-Path: <cygwin-patches-return-8539-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98926 invoked by alias); 1 Apr 2016 16:24:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98522 invoked by uid 89); 1 Apr 2016 16:24:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Apr 2016 16:24:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 44316A8060E; Fri,  1 Apr 2016 18:24:31 +0200 (CEST)
Date: Fri, 01 Apr 2016 16:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH v3] Refactor to avoid nonnull checks on "this" pointer.
Message-ID: <20160401162431.GD23707@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459525365-21482-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <1459525365-21482-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00014.txt.bz2


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1389

On Apr  1 11:42, Peter Foley wrote:
> G++ 6.0 asserts that the "this" pointer is non-null for member
> functions.
> Refactor methods that check if this is non-null to resolve this.
>=20
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
> Just wanted to make sure that this approach looked good before I fix
> all the problematic files.

Looks good to me, except for a style issue:

> -	audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
> -	debug_printf ("buf=3D%p frags=3D%d fragsize=3D%d bytes=3D%d",
> -		      buf, p->fragments, p->fragsize, p->bytes);
> +        if (audio_out_) {
> +            audio_out_->buf_info (p, audiofreq_, audiobits_, audiochanne=
ls_);
> +        } else {
> +            Audio_out::default_buf_info(p, audiofreq_, audiobits_, audio=
channels_);
> +        }

I guess this was just a result of speed-typing :) but that should be

  if (audio_out_)
    {
      ...
    }
  else
    {
      ...
    }

OTOH, single-line statements shouldn't use braces at all:

   if (audio_out_)
     audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
   else
     Audio_out::default_buf_info(p, audiofreq_, audiobits_, audiochannels_);

Other than that, please go ahead.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/qC/AAoJEPU2Bp2uRE+gLnQP+wV5xx64M2kWPpmwyLiupVKR
Grp3fyHnRMfZCzwf+5pI2Nf9MC+VzSw6eV8Tbd9uQcaIYGTpZ+0AHMpEI9GSP22C
K5JgUVoMxqsXAVzADn6mPNKUuwTwXZ4lwhH/4hlhDAxDPIe7baZmU9Q9MFDRc0UW
ypUuX7qAjOS3h+lJgHqWcMZvLRstmf/iT7n4/nBzFxjrRyHi+DIwVgDVeqRlPGmP
YphYKwFWhWRB8PgGPDpsTYQJnDvcu50rdNmuQqIEyWVN/O40krupy91pjIpPLfVF
n1w/HyVfzF7HzcrQ+YVECY7tn0lU55K3/H3FFXEgyd6WuOhoh9Cv/orw0FdE8/Ld
sfliGAmUaa5Ziicyx3FEZRIQwFCJ7OD8aRq6ez938xz7Zoxy/+saClaPUWmfWcd5
jfuf9BAIGqdjL7EauaL3XbWOc/f7bTPyMQblkCKIHjG2mx50CUYSfbA8HLb/iy8n
UEHXGhVHJGrIzS6p0a+mVYtWyKW7yMnq/CZ1wGmnCM373I35J74qTZw0mOZpf60Z
aFTVqhFA50HrISRbUOh40dWnnZJ1njBCJ48Dq4CDnv/cDraXR9NCpbJVU+Fy9l+K
pXxAZ3Mlf97iXD4T25GKS7hWPNG1M/rzUNxml7HLM8SHmxKxcuMGmi90lcwb9xPd
yfjKsTbEwphM2lBJYVbq
=obAI
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
