Return-Path: <cygwin-patches-return-9449-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105953 invoked by alias); 11 Jun 2019 08:48:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105882 invoked by uid 89); 11 Jun 2019 08:48:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE,UNSUBSCRIBE_BODY autolearn=ham version=3.3.1 spammy=cleaning, Ken, drawing, pipe
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 11 Jun 2019 08:48:19 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mgebs-1gts6y2DEK-00h2pC; Tue, 11 Jun 2019 10:48:12 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 67544A8071D; Tue, 11 Jun 2019 10:48:11 +0200 (CEST)
Date: Tue, 11 Jun 2019 08:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, Ken Brown <kbrown@cornell.edu>
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
Message-ID: <20190611084811.GB3520@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, Ken Brown <kbrown@cornell.edu>,	Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
References: <20190526151019.2187-1-kbrown@cornell.edu> <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu> <20190603163519.GJ3437@calimero.vinschen.de> <dac74739-7b66-56cb-ca8a-acbca7877eba@cornell.edu> <874l51p7rt.fsf@Rainer.invalid> <d3a6fcad-69c3-e6e6-07fa-3311ec833c69@cornell.edu> <b5a2e878-0282-d94e-92de-c4605dea4000@cornell.edu> <798cfd05-a12d-4f42-0a8a-f74750e78547@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <798cfd05-a12d-4f42-0a8a-f74750e78547@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00156.txt.bz2


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2589

Hi Ken,

On Jun  8 12:20, Ken Brown wrote:
> On 6/7/2019 5:43 PM, Ken Brown wrote:
> > On 6/7/2019 3:13 PM, Ken Brown wrote:
> >> On 6/7/2019 2:31 PM, Achim Gratz wrote:
> >>> Ken Brown writes:
> >>>> I think I've found the problem.  I was mishandling signals that arri=
ved during a
> >>>> read.  But after I fix that, there's still one nagging issue involvi=
ng timerfd
> >>>> code.  I'll write to the main list with details.  I *think* it's a t=
imerfd bug,
> >>>> but it's puzzling that I only see it when testing my new pipe implem=
entation.
> >>>
> >>> Anything triggering a race or deadlock will depend on so many other
> >>> things that it really is no surprise to see seemingly unrelated chang=
es
> >>> making the bug appear or disappear.  There are certainly races left in
> >>> Cygwin, I see them from time to time in various Perl modules, just ne=
ver
> >>> reproducible enough to give anyone an idea of where to look.
> >>
> >> That makes sense.
> >>
> >> In the meantime, I've already discovered another problem, within an ho=
ur of
> >> posting my claim that everything was working fine: If I start emacs-X1=
1 with
> >> cygserver running, I can't fork any subprocesses within emacs.  I get
> >>
> >> 0 [main] emacs 2689 dofork: child 2693 - died waiting for dll loading,=
 errno 11
> >>
> >> Back to the drawing board....  I've never looked at the cygserver code=
, but
> >> maybe it will turn out to be something easy.
> >=20
> > Good news (for me): This isn't related to my pipe code.  The same probl=
em occurs
> > if I build the master branch.  I'll bisect when I get a chance (probably
> > tomorrow).  In the meantime, all I can say is that strace shows a
> > STATUS_ACCESS_VIOLATION at shm.cc:125.
>=20
> A bisection shows that the problem starts with the following commit:

Thanks for bisecting!

> commit f03ea8e1c57bd5cea83f6cd47fa02870bdfeb1c5
> Author: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
> Date:   Thu May 2 12:12:44 2019 +0200
>=20
>      Cygwin: fork: Remember child not before success.
>=20
>      Do not remember the child before it was successfully initialized, or=
 we
>      would need more sophisticated cleanup on child initialization failur=
e,
>      like cleaning up the process table and suppressing SIGCHILD delivery
>      with multiple threads ("waitproc") involved.  Compared to that, the
>      potential slowdown due to an extra yield () call should be negligibl=
e.

Please revert the patch for the time being.  Michael, this needs some
more work, apparently.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz/assACgkQ9TYGna5E
T6CqEQ/+PFc4SbvGNKLP3p+4Uc8AXUZYOWAkUYnpoYms5wnoAC23GYHYwwMGNnhm
vLv7+dL+20uPctjyajMR2EUeN4evAQ3PeFkMJ6Am0CoTHdJ7s1AND1i9k20PyGDe
hgynAvWuLPy0q5dRX0kwP4DzKdYsFj/neL201aLO5RIz5I2527LGhVYrjYefY6nc
PO3T+/QOA4ho9bZ2oW7FeCA/LpVZ5szizODSdmcTUHnu2E5RX07Io1PaAzwHXSM8
9hq/Wp1NzIHvmdeXkmy0CVOZoKmfOUrvhTDDH1j/f6FyB9hGq8+F0HuOhfismZta
/XV+N2im9AzSiu1etA8pNIiOYCPjH7THk67yMN9B72MsJvltdgafLDgwkeWGLa/o
CVQ1HFo+dlE4gljFZkIqoIJoj3P+rlf2WYgnLiplEVJ8UQdLtZN7TRdQE+3YGuaf
vX1zjPk44YMhIZofckego14ed2/M1Yr9xkTWp/EYv/C9/nJ3gKA4XH5BbYphdkVY
XoBBz87+/K62XgjMo28+sXXv6UEK7SBJExcYB5nnkNY9BqKfpu0ECpeuLHYY7jup
e9/Ngc7regZMoqSbxTk1NuEdJvyalCeLeASs7F9pUxtjJDmbSvX7M/R4JJEKqZBD
30O4HXVPsU44nsusLh5ZEsGCI1VmLbSupdivUII0TYwr4uG7I5Y=
=5xIQ
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
