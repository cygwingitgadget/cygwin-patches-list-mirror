Return-Path: <cygwin-patches-return-10067-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111961 invoked by alias); 11 Feb 2020 11:50:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111952 invoked by uid 89); 11 Feb 2020 11:50:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 11 Feb 2020 11:50:48 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MirX2-1jg1TO1pS8-00ewaD for <cygwin-patches@cygwin.com>; Tue, 11 Feb 2020 12:50:46 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D0AFAA80CFA; Tue, 11 Feb 2020 12:50:45 +0100 (CET)
Date: Tue, 11 Feb 2020 11:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Add error handling in setup_pseudoconsole().
Message-ID: <20200211115045.GI4442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200210153811.GF4442@calimero.vinschen.de> <20200210174514.1164-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20200210174514.1164-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00173.txt


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 347

On Feb 11 02:45, Takashi Yano wrote:
> - In setup_pseudoconsole(), many error handling was omitted. This
>   patch adds missing error handling.
> ---
>  winsup/cygwin/fhandler_tty.cc | 179 +++++++++++++++++++++-------------
>  1 file changed, 111 insertions(+), 68 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ClRUACgkQ9TYGna5E
T6ArSA/5Aa8X4ng3g8d2jl8XpVjn+z4UTUBF0MVPmpqzDnqTUfccdLXYE2/AKY2S
7GVe8zOV2WZ9YeZtZNk4n6jHas00+Qjl9Yz8oX6UHnyVZUDXlmsCe8oD4/yLSxnS
77nv4OI/l5RCJ53TPHVIWCc5q4ewEcdBVaDzgcurYY34H7ehb0n1OOsCHmBLuIGI
KfhTcCw1kpiEENXP2cCLdE6fVVtgd49Io8HgKtdGPNb6O9AW5cw/arQKVoqQV06U
EB7KYI3V+XRH6yI8o9h3u3KmKWzKWYX8dQxSUNeyN2a+lqVuBu3Klt80GAh2pXzi
SptC0ichHIB6q4dW5Z5qi5fZjUtM7M9nqUKkZNlGPuoN7AjMWaUnkaG161YX0STx
nLGY545sABiMkjM8XV+wcWZ1zCX9mtwLMUIoEPCT8Sv0lbdQXX2VpTlesrsiTVYR
k9m44qWhrbEL6Elto1Sa/eL7KBGu2tjY0sKg/fi1vionGT5O3kyi8KvgwFnyCZm0
M7lZnjJFynyaGzZfw/4VnN/42RPC+jXqbebRmtOAQfQudjukgpxCfQxYxecapd6+
45mNjYqAWrQxcps+8D0eRzEqq4hEA76IDYeWjKfnvTslkNq1qq12fki7Ma1Grwgd
YXl0WfvLQyhCUD3uXHtvrIhUdZJ+NwdK1mqMJyrZLwR1Hcdf43E=
=ZyiQ
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
