Return-Path: <cygwin-patches-return-10063-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90378 invoked by alias); 10 Feb 2020 15:38:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90365 invoked by uid 89); 10 Feb 2020 15:38:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 15:38:15 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M5x9B-1j81y206nb-007QsM for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2020 16:38:13 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3098AA80CFA; Mon, 10 Feb 2020 16:38:11 +0100 (CET)
Date: Mon, 10 Feb 2020 15:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add error handling in setup_pseudoconsoe().
Message-ID: <20200210153811.GF4442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200210151214.39-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20200210151214.39-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00169.txt


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1274

On Feb 11 00:12, Takashi Yano wrote:
> - In setup_pseudoconsole(), many error handling was omitted. This
>   patch adds missing error handling.
> ---
>  winsup/cygwin/fhandler_tty.cc | 94 +++++++++++++++++++++++++----------
>  1 file changed, 68 insertions(+), 26 deletions(-)

Uhm... please, no.  There's no problem adding goto labels per se, but
jumping back to numbered error labels is quite confusing.

Error labels should ideally be at the end of the function and in reverse
order of the potentially failing code.  For more than one error label,
the label names ideally reflect the problem they are solving.  For
example:

  function()
  {
    <do something>

    if (<something failed>)
      goto err_something;

    <do something else>

    if (<something else failed>)
      goto err_something_else;

    <do some other stuff>

    if (<some other stuff failed>)
      goto err_some_other;
    [...]

    return true;

  err_some_other:
    <cleanup some other stuff>

  err_something_else:
    <cleanup something else>

  err_something:
    <cleanup something>

    return false;
  }

I wouldn't expect that all functions in Cygwin follow this approach yet,
but for new code I'd rather see it like this.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5BeOMACgkQ9TYGna5E
T6C9pw/9FIexdVb7yx85bqPhpa0P5Y4qhHcD0+UY5zm1L4+rFVovLCIvCgvRW7d7
bWTSDC0IJ6riPvu7GIUN4bXgi/4Za8CqHgAD6uLclo051DngqCnJYJXBsfkqKOTU
AQexLLFsut3QWJSsoXYf7pzp12oN0agsLPF4wXjE7z52OkuDLw2VJKkkmUi/LnS1
n76WsYPDxTpAfGkR59sA3MCqLaTMqA+RKVN2B+Ez7k76iYkeHm91rnJIswJxw/W6
2DB9yVi6Xv2OxF7PY+Li13GCb55mP0xpjtESRSWaJQYt2Gvbbx+H5uro1eAp7uyP
qBSWhQzXy++Fxx4iwbBW8PcxA7bW7HA1luUQAfbq62PcRK9Z8lEArQVTiyF/NzVE
1fwEC4MRXU00I46aS6y/n3tYFB1ZB3QB+5mnuWf/FF9I3ft8DlJFmOSuTcRwV221
uKLDOk9ELSUiImb/uBIcax5vb7iyRqKPlUTUnAxwqN7SVhGMtAZ62SyhLvUQPng+
sQBoIljhaZ3aAtda+Q5t6X73YNeJkht+3F+NloLRn7kvcppf6wLzqEpNs4qBrq1O
XI0rV5Kzjb3/TATjK3iWEIR2UQdgV1yegJ499AG46rI+yov8ovL7U/RvrIhHOMvV
E7Xa0jLHt3J0+LBobu8jaKPHmMqeLgYItfuNz7Bq8jhX/As4484=
=45hk
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
