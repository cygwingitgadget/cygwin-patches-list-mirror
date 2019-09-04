Return-Path: <cygwin-patches-return-9608-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 71175 invoked by alias); 4 Sep 2019 10:03:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71163 invoked by uid 89); 4 Sep 2019 10:03:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1012
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 10:03:55 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MRmsE-1hcOyQ3r2o-00TH7X for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 12:03:52 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 04820A80659; Wed,  4 Sep 2019 12:03:52 +0200 (CEST)
Date: Wed, 04 Sep 2019 10:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/4] Cygwin: pty: Limit API hook to the program linked with the APIs.
Message-ID: <20190904100351.GM4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904014426.1284-1-takashi.yano@nifty.ne.jp> <20190904014426.1284-5-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Content-Disposition: inline
In-Reply-To: <20190904014426.1284-5-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00128.txt.bz2


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 950

Hi Takashi,

On Sep  4 10:44, Takashi Yano wrote:
> - API hook used for pseudo console support causes slow down.
>   This patch limits API hook to only program which is linked
>   with the corresponding APIs. Normal cygwin program is not
>   linked with such APIs (such as WriteFile, etc...) directly,
>   therefore, no slow down occurs. However, console access by
>   cygwin.dll itself cannot switch the r/w pipe to pseudo console
>   side. Therefore, the code to switch it forcely to pseudo
>   console side is added to smallprint.cc and strace.cc.

I'll push the other 3 patches from this series.  For this patch,
I wonder why you create set_ishybrid_and_switch_to_pcon while
at the same time define a macro CHK_CONSOLE_ACCESS with identical
functionality.

Suggestion: Only define set_ishybrid_and_switch_to_pcon() as
inline function (probably in winsup.h) and use only this througout.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1vjAcACgkQ9TYGna5E
T6DYexAAmy/tw7nA7/MBhkKQZ8xx1dmoAexPF6f/ec+3+mOTs3FmF4usQnGQ2C/t
biD61Ngx9oKRgFRhCmzijOrltc/zTHmw5NTmvuq3h1HW49snIg15q9P+G9ASfbX2
TM86lRm46YHKzWm5wVF5xIyrsvrhAaQuag89XKS6kv1ZGeLRFGOabFB2TsVzdYmf
UMhRSluAaFi9Ql0cF5crERRbvCXLtTMmXfFkUEPvZmZWlyaK0ZSKWaSY9y18hODf
e3g7prKlS7SaBwYuEkAtYzUzF1HN7waQd9xj5VUIo0n6rdRLAwV13o4k5w46Quvn
Up92Bu27upypIzKO7oe3d3hsRapuwNaoLDA8s+sOS25LpnvJY7gQwNvo0N8INPDM
bWbIFHlxFiOoervK+yBFEjHPDclbgKs2Itks+U6Om2kxZfdCvbUhZurQaq+Aj4/K
ZIJ5nVdgFAZDAr4atXTVG+n+H9RU6JYQaVFh+C+rafMxVnNhcEccYJ9UDygqgV/x
rvBj08xHznTUeMEG3n6vRx3TiRRWfl4eZr3R6tmt8l0BTCjv8xZQz4DCdkPhz/X+
IoBVzK8KvexWVMNtcww6hqVuAkk+wDgQSoQD0ylIRrR9qS9OPduPlhY8qP4Rkl6P
HSgLNZ0390OmSwsAdZXoCY3ANBpjVv2Qzg4tEIia0JnUREajLzw=
=PYel
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--
