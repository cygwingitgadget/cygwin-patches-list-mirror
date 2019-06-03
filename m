Return-Path: <cygwin-patches-return-9419-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81365 invoked by alias); 3 Jun 2019 16:30:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81354 invoked by uid 89); 3 Jun 2019 16:30:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=English, acknowledge, HX-Languages-Length:1394, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 16:30:45 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MKKhF-1hHXGH3cml-00LjqR for <cygwin-patches@cygwin.com>; Mon, 03 Jun 2019 18:30:42 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EDD08A80653; Mon,  3 Jun 2019 18:30:41 +0200 (CEST)
Date: Mon, 03 Jun 2019 16:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [rebase PATCH] Introduce --merge-files (-M) flag (WAS: Introduce --no-rebase flag)
Message-ID: <20190603163041.GH3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190412180302.GF4248@calimero.vinschen.de> <319c9949-6e00-2c18-f1d0-a88a7f02fdab@ssi-schaefer.com> <ae7bce9f-b1d6-440b-f6d6-fdca1040d56f@SystematicSw.ab.ca> <6d8331f7-d3f5-53e6-5e55-863f8eb01693@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <6d8331f7-d3f5-53e6-5e55-863f8eb01693@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00126.txt.bz2


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1340

On May  6 10:31, Michael Haubenwallner wrote:
>=20
> On 5/4/19 4:33 PM, Brian Inglis wrote:
> > On 2019-05-03 09:32, Michael Haubenwallner wrote:
> >> On 4/12/19 8:03 PM, Corinna Vinschen wrote:
> >>> On Apr 12 15:52, Michael Haubenwallner wrote:
> >>>> The --no-rebase flag is to update the database for new files, without
> >>> Wouldn't something like --merge-files be more descriptive?
> >> What about --recognize ?
> >=20
> > "The --recognize flag is to update the database for new files, without
> > performing a rebase.  The file names provided should have been rebased
> > using the --oblivious flag just before."
> >=20
> > Recognize does not mean record or update in English but see, identify, =
or
> > acknowledge.
> >=20
> > Your earlier suggestion of --record, the verb used in the comment quote=
d above
> > --update, or CV's suggestion --merge-files would make sense and be more
> > descriptive.
>=20
> On a first thought, "merge files" does have a different meaning in the Ge=
ntoo
> context already, as in "merge files from staging directory into the live =
file
> system".
> However, on a second thought, "rebase --merge-files" is performed afterwa=
rds,
> but still part of that "merge files" phase, so the name does actually fit.
>=20
> Patch updated.

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz1SzEACgkQ9TYGna5E
T6D5XQ//bMjmh4KX3+5xhU9YcFCP0XV0rxH94ixeLIVpMqF46r2yg1iXJnsifNPO
cLoWn0tJo8WCDb82cyARYSrdP7LvvXJWvnotnD7PVO3zN4lA93FnU5BaCgurcVv4
i98BXEqd5voXs45twoL7NLBBnmkdHUVanwWFBUnfGXFU7QXQtY8X7ZI3zQCdW1DT
DESOMPksuPqHWnKkZHuQk1PGVmGiZSPWCbyfrqsrqna6aKlSna77RUuqMfdLef32
dKo6ujYUL3GxNI8yH19l0/gIBqdnEewUWlQW2l0F/u8SVLB52bHN7MHaOTMqf9Nw
k0tIzjR1N+Oo8D9CYjudJjOhAYvxMf7tM6NBoQJ0x1yt5h8naioZHTADSBSXr97d
BCVuYMbt9TiIhokmgpP9FdoBBgF6DxdNlc6Mavnz1pxUHzr1AKt7zJ4mC6NQNtaa
iJDoMcNRMG+tPHVitei+uhBe08UylYh3XEm3RAdG9BXW1DVm8cl/KX6Uxr+LxPFL
D5MYURDDqV15gu2G6/suXzIlbQ8ZzYSAF9MCxZNsFklc5Ckz9JqKRZpQ0UxkZpYC
wB2GsXlYOo1+iMOCqvhYEO9ozrqQFA72Y5ADM1gPb/YW4zNWKvE9TPuJG4ellPVg
L7Sg1I4yqdNPAUzy//eT4rRQVPSP4ZQBhskyuQNqAusbHe5dMQQ=
=NI1V
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
