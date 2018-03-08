Return-Path: <cygwin-patches-return-9039-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31003 invoked by alias); 8 Mar 2018 07:56:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30989 invoked by uid 89); 8 Mar 2018 07:56:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-113.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=para, H*Ad:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 08 Mar 2018 07:56:41 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPA (Nemesis) id 0LkUcJ-1eNWnt3ffH-00cS5x for <cygwin-patches@cygwin.com>; Thu, 08 Mar 2018 08:56:38 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 14713A80994; Thu,  8 Mar 2018 08:56:38 +0100 (CET)
Date: Thu, 08 Mar 2018 07:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] describe new locale modifier @cjkwide for user guide
Message-ID: <20180308075638.GD32523@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <b02fed2c-095c-e689-d7df-e9802b75b1fa@towo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <b02fed2c-095c-e689-d7df-e9802b75b1fa@towo.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:TFTvaFPAE68=:yYnrZsrOzM3V6RDhVha79t q0cE3LbUsu3c1YePWFPiaLEyWC+6Y+YTNzsg39mQmgduXJ1oOUxfEQYvnxT+BzG6BwXnSwfej z8zllHS3UUOaNqBXUFFWtbDmqn05yzEv6Ukia0eARIPsL+cPJZBnNQ2fHrotQB2lAC29bEHcO 0qqGGPdO313tp0ipjnkglXk/usPSjJVDAQWlpPoUQKTIparmbOS9pEqLkvKmzhN9pXVAoQNvE C5zArLZfYszbyHtuEcARNa3ITFo0xhFLGZt1YTWrJV9P034+ZGbyIyMHgbGhsKLEdK8Iqqy1B qY3yrIFvqsyePzIUoSrhuWosI7RhupLc2vqkzpxuYcNVJ0sZW/Khsa90vegJ6j32p8RxdMGPw /QU+hTj6qIDRuw+u0btAhuZK6v5PbZPqA2CVnzs6cIamfcd812tO7VLXp4JHLU/imn+w848BP o8aUciiDVnoVJGp0jIRcgluLnSBGtTzoZtA2plMILAiLkSPNsQ1R0UMnxFmNwR7mlo52dV0J4 yuvZ8wRoHJDGdD7medFcmLmLRvso8eutKblWpDFdUQ2bqK8bjjjG0km4t76jvRjXpRZlPGDpT kOBx6pEe3KWBwWOt8A7LqI8SNIxZOxOuYtfvjk/ADkV9OhiWN5sQJ9TnshXkWeH/1EX1yypMx 3BVFRiH7CUHGVDrykoMd9TFKmMnTn4hFaCYSgEher8JBtEd0jHq4XmMHSQ9J/yFNL/vb66v+t YQw0XthA/yz/cjqRBnULLqZLhr48ZOgPHvv2Ng==
X-SW-Source: 2018-q1/txt/msg00047.txt.bz2


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2770

On Mar  8 00:30, Thomas Wolff wrote:
> From 725e49a16c7867512635e6ade0f1ff1e01f8e7c5 Mon Sep 17 00:00:00 2001
> From: Thomas Wolff <towo@towo.net>
> Date: Thu, 8 Mar 2018 00:29:25 +0100
> Subject: [PATCH] describe new locale modifier @cjkwide for user guide
>=20
> ---
>  winsup/doc/setup-locale.xml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/winsup/doc/setup-locale.xml b/winsup/doc/setup-locale.xml
> index 29502a2..249c125 100644
> --- a/winsup/doc/setup-locale.xml
> +++ b/winsup/doc/setup-locale.xml
> @@ -166,6 +166,19 @@ can be used to force wcwidth/wcswidth to return 1 fo=
r the ambiguous width
>  characters.
>  </para></listitem>
>=20=20
> +<listitem><para>
> +For the same class of "CJK Ambiguous Width" characters, it may be=20
> +desirable to handle them as double-width even when a non-CJK language=20
> +setting is selected.  This supports e.g. certain graphic symbols used=20
> +by "Powerline" and provided by "Powerline fonts".  Some terminals have=20
> +options to enforce this width handling (xterm -cjk_width,=20
> +mintty -o Charwidth=3Dambig-wide, putty configuration) but that alone=20
> +makes character rendering and locale information inconsistent for those=
=20
> +characters.  The locale modifier "@cjkwide" supports consistent locale=20
> +response with this option; it forces wcwidth/wcswidth to return 2 for th=
e=20
> +ambiguous width characters.
> +</para></listitem>
> +
>  </itemizedlist>
>=20=20
>  </sect2>
> --=20
> 2.16.2

The patch introduces lots of whitespace errors.  Check for yourself.
Remove the patch from your repo and reapply it, e.g., assuming this
patch is HEAD:

  $ git reset --hard HEAD~1
  $ git am 0001-describe-new-locale-modifier-cjkwide-for-user-guide.patch
  Applying: describe new locale modifier @cjkwide for user guide
  .git/rebase-apply/patch:14: trailing whitespace.
  For the same class of "CJK Ambiguous Width" characters, it may be
  .git/rebase-apply/patch:15: trailing whitespace.
  desirable to handle them as double-width even when a non-CJK language
  .git/rebase-apply/patch:16: trailing whitespace.
  setting is selected.  This supports e.g. certain graphic symbols used
  .git/rebase-apply/patch:17: trailing whitespace.
  by "Powerline" and provided by "Powerline fonts".  Some terminals have
  .git/rebase-apply/patch:18: trailing whitespace.
  options to enforce this width handling (xterm -cjk_width,
  warning: squelched 4 whitespace errors
  warning: 9 lines add whitespace errors.
  $ git show

I fixed this locally before pushing, so this is just a friendly hint for
next time.

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlqg7LUACgkQ9TYGna5E
T6Crrw/+N61WCXJx20PHFlk2mm9X0u8CMqHQLHvaYe440AVePa/HrEM0o8Bx21U8
ygrKDRgAppDhPzrM5o5kNl4CNGtldZyUQjYfScZ3ouTHJN9lH/AvMCD0qc309HQg
P8ONdKpo2biNuByaUciYfL6kfPmGdrSROTq7GlZBNxKupSX74eMbb6Qy09mTYKHN
59fzBahyHyML2bKXN+5w+xZVkqmmaY20FcIfOCL6S1MHhXv3I/BNGgQlBVntYKUW
mYihsP7EWQikzG43mJ3M9xw3qQ7mAWssgXtnC7zMwjFZImgidwDNarLuoltuLXQy
NoFLmHnEfzz0PfqYFq5SY/DBL1SkE+4y0mJ8jM7b6iV6jOPv1oboTVRQCIfhP/A6
ALu2G25M4y3MKgAZKgnLuVIoFGYWrqTpiGuGWt6p1oIzUYnDvmDL6mTEqgSf6kHf
K8KyPc30dv1Bj7S5kWoCNfrGP0kae8WhFohnouKombKp2kSYf6fal4Z5TWzSHB7f
lbUjBFfdAqYMowqRkg1+4JXWyn6Avr/0k9iARlzhoesZRccPlhg/YPQibRD1p/sw
hEFkeSmveJjfxseTo4v4bmflsgGb37ggEprLOBQ/gRTHcSfZaTgvq3k6cnV5Puob
emH985y0Lq6cPHwZ3pOr1Zsoj96Za3seimkrITQ+5HXkyOnrDec=
=/PGy
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
