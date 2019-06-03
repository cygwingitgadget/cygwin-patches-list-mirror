Return-Path: <cygwin-patches-return-9422-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87519 invoked by alias); 3 Jun 2019 16:37:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87510 invoked by uid 89); 3 Jun 2019 16:37:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=cygwinapps, cygwin-apps, anybody, traffic
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 16:37:34 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MFKbB-1hMbhN17H7-00FiGi for <cygwin-patches@cygwin.com>; Mon, 03 Jun 2019 18:37:32 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 88EE6A80653; Mon,  3 Jun 2019 18:37:31 +0200 (CEST)
Date: Mon, 03 Jun 2019 16:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [rebase PATCH] Introduce --merge-files (-M) flag (WAS: Introduce --no-rebase flag)
Message-ID: <20190603163731.GK3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190412180302.GF4248@calimero.vinschen.de> <319c9949-6e00-2c18-f1d0-a88a7f02fdab@ssi-schaefer.com> <ae7bce9f-b1d6-440b-f6d6-fdca1040d56f@SystematicSw.ab.ca> <6d8331f7-d3f5-53e6-5e55-863f8eb01693@ssi-schaefer.com> <20190603163041.GH3437@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
In-Reply-To: <20190603163041.GH3437@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00129.txt.bz2


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1585

On Jun  3 18:30, Corinna Vinschen wrote:
> On May  6 10:31, Michael Haubenwallner wrote:
> >=20
> > On 5/4/19 4:33 PM, Brian Inglis wrote:
> > > On 2019-05-03 09:32, Michael Haubenwallner wrote:
> > >> On 4/12/19 8:03 PM, Corinna Vinschen wrote:
> > >>> On Apr 12 15:52, Michael Haubenwallner wrote:
> > >>>> The --no-rebase flag is to update the database for new files, with=
out
> > >>> Wouldn't something like --merge-files be more descriptive?
> > >> What about --recognize ?
> > >=20
> > > "The --recognize flag is to update the database for new files, without
> > > performing a rebase.  The file names provided should have been rebased
> > > using the --oblivious flag just before."
> > >=20
> > > Recognize does not mean record or update in English but see, identify=
, or
> > > acknowledge.
> > >=20
> > > Your earlier suggestion of --record, the verb used in the comment quo=
ted above
> > > --update, or CV's suggestion --merge-files would make sense and be mo=
re
> > > descriptive.
> >=20
> > On a first thought, "merge files" does have a different meaning in the =
Gentoo
> > context already, as in "merge files from staging directory into the liv=
e file
> > system".
> > However, on a second thought, "rebase --merge-files" is performed after=
wards,
> > but still part of that "merge files" phase, so the name does actually f=
it.
> >=20
> > Patch updated.
>=20
> Pushed.

Just a FYI for the future, patches to Cygwin-specific tools should
usually go to cygwin-apps.  Not that the traffic here overwhelms
anybody...


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz1TMsACgkQ9TYGna5E
T6DO0Q/+LrkjcpwHPxkbf/dKQt4Gr5K7pzlMDhEJS17Z/l2kIwV9qZnMBHusCpFw
RKy2ka5/vIcGrqAGU2Rm1XxlCJOclq0sfHAF+GcuCv7vaRPdmvDUaGwCJFWdh6Jx
d3+SzZ3L+g++G7AIBnR1KnLOMCSfC7bxhbWrBiIHXCT8RIVANH83N7cMgczp0Nak
t5QoNn8mE+QfWwRCtYwiWPKCkqovEeLdpXZ0NQUcHPOwvwCBSiVWHV4N5HolekOJ
3fE6826S/8bd/g0msaJKE+Y4sSdlGEOjSotKUN5vCwMoggFg89wCBGZ77GaA3Kny
QQlLa/uv3nt+shKBhdfEFv6HGqO5XfdR1vWYSWXTCX0e5+AWYrin2DH4DNrVegZS
/ALzweWmFHPTl7NeSY716GHITDIXAFPe7KoJWACmdnBZ85x8oRXZzM3fBBTNemhB
Cb3tzfFK2UJ+x1QZbW7PQr1k9ynQOGeSTecSG+0gKfOVgH68aSaKBH9mHGD0opwa
M3EGZCxodKGRgYvj7sJZ+ZFhNhDT3pCGIIGRr8eHCfzdmcIERwMhK81b/uY3E09i
ZJnpMiSMcAcw5wIMUyznIn0FcMl6qIsWuRTfmGUs7GPQPakeKs1TGPFI1a/AMi9O
J/aeiKA+rYhBs5U1G2qHNDGH9CPBxLlgUAi4N72X616oqNYlc4g=
=VW0A
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
