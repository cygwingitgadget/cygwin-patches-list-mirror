Return-Path: <cygwin-patches-return-9043-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36940 invoked by alias); 4 Apr 2018 08:39:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36930 invoked by uid 89); 4 Apr 2018 08:39:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-99.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Apr 2018 08:39:12 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LjJqJ-1eWDXG3Rsd-00dXs0 for <cygwin-patches@cygwin.com>; Wed, 04 Apr 2018 10:39:09 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EE1B2A818CB; Wed,  4 Apr 2018 10:39:08 +0200 (CEST)
Date: Wed, 04 Apr 2018 08:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Posix asynchronous I/O support, part 1
Message-ID: <20180404083908.GI2833@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180329053050.6696-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20180329053050.6696-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:GnN25VaAvO8=:q1SKqqYrKqeuyVm4d2ThhP VS95JLuAldnopDslzN4y459O9Aa2inJ7weURGelvCIlOl4fHAf44dwkPXU/kMIbTPVGrK5gWl aDPmWTc1HqcDfAJqLYDG17xxl+T3jcE8bbCNdvFseTGTCEqGfvuCDk8QBeX8uSgo65qcYrh+3 T38xEZ74npZvIc4iCzp6ayaWrnuq+tSqiE/xaesk//9AwtMyxH//tQwriLln8CWAbXxso9dWF uqBbB1XzsTSSk36QhxGSsXw/1muc0F83FpA+uO+c54pbfaH7gWgpCGn5rgP1iA8fDr+QBLRFS PPNBzX7AmG9OmTNWUPqs86to3IE83Rapukd3CoQoWs5fRqNLSymxySYuQe7MtGSKz9VcAQtOT +kAfiVfnsNnKvrD3epZgZngoeSLV2b1jOUOn99CdHZReEaFLWmrgIc6FJYGV/ub0rb0Xvc6wp awn0yDEDOVdGl6BUvRmuHXztazOkog0oTani6dCWma6/sj3/xSaIw4drztbXq3wQVjLxZnWJf 7p63kgbhld8JiGL30VwUZT9a6VhXAHpbdrf0mnc8mU4dXO1Mf7sIZQvbuC/SVwUJVX6fQyYpp xBo4vMrq+/QkJVLbLihzVdXA5NUXrtTyjTHvkVJhzUr06RNPrVx+1dNfTGvRYzE4wRQtLLT6L ByseJurvq2AkwukLeX8ppas6F3YbTsyX7XJRO1YzUvLqYkyXmKRQHX8D6d5CIsu6nstQrcwiu +AiPSTnB7TjU7+5hglA7maz/Xo9JRiHIQWQl7Q==
X-SW-Source: 2018-q2/txt/msg00000.txt.bz2


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 713

On Mar 28 22:30, Mark Geisert wrote:
> ---
>  winsup/cygwin/Makefile.in              |  1 +
>  winsup/cygwin/common.din               |  8 ++++++++
>  winsup/cygwin/include/cygwin/version.h |  4 +++-
>  winsup/cygwin/include/limits.h         | 12 ++++++------
>  winsup/doc/posix.xml                   | 16 ++++++++--------
>  5 files changed, 26 insertions(+), 15 deletions(-)

This one looks good.  You may want to send the patches as a series in
future, though, so they are combined in a single mail thread.  Check the
usage of `git send-email'


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlrEjywACgkQ9TYGna5E
T6A90A//Q+LIwGA8027vNKAyzU8NvWlM0/xnWHnPn3h2uOrRGgodXuTa1WiXDJlE
nRN82nLls++WURHsk/iifyIC5O9ALpnAztT2QSs3qZo8JrjtiTubH/WHeBOObnqi
I/uxbINZ+ObDB1TLgaFQwJq34RpLsc7awsbT30uUuYROPZowy9pWoNvPXZfPaTzv
0cBOpshruFlLE7f1lTF6Z3LnYaTlRcHmm9kLRH+d9LEbvTswmEuHHmemTkrBNp5V
FHVFhDP0dEXfDT9EE/GUMcPf5uGF9hAcgO66AMQoqXP5uCivIdeN4B1czsRqswVH
6ZNZ/LxJzn8f5T/axgA65B3l0N/qZ8RcCifjM9k7z/1919jPiQtUiJVU0isLJjwH
WU5OAYAYrwOo2TSdCe3XxSgTbNZs6Mejef8CCbE+SM9UbXTH5IbN38oqKkaaPp7H
PbWEC+Rl4gpnAhSwZ7p76m1CpLI+6y3lGEEoF1B7pW67yhyN4tlss1hUuyC1lWHp
YWQNP8f+rIol5Tfh5255p6Y9VImBInggYPNNSKvQrW4xldKOq46ttQalDKE2f9Yw
fvlC3arRrnKsWg5QlvTKZlad6eXkmv38L+GGndMUcxPEegNjhBP+eucO38GEHeQx
1QaKnh3lMX+7HxU2gr+0sJFgFap+dkDllz493v+zR/2y7MubTDc=
=xmt+
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
