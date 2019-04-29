Return-Path: <cygwin-patches-return-9386-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64120 invoked by alias); 29 Apr 2019 09:42:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64111 invoked by uid 89); 29 Apr 2019 09:42:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=hacked, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Apr 2019 09:42:24 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N3bb1-1gcb9W16v5-010ZuD; Mon, 29 Apr 2019 11:41:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D649FA80784; Mon, 29 Apr 2019 11:41:34 +0200 (CEST)
Date: Mon, 29 Apr 2019 09:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Implement sched_[gs]etaffinity()
Message-ID: <20190429094134.GH3383@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20190429053809.1095-1-mark@maxrnd.com> <20190429082040.GA3383@calimero.vinschen.de> <c5a11465-b5a6-1ccc-219a-313f1c06c642@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <c5a11465-b5a6-1ccc-219a-313f1c06c642@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00093.txt.bz2


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3258

On Apr 29 01:54, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > Hi Mark,
> >=20
>=20
> Howdy!  FTR Here's the intro paragraph left out of my patch submission:
>=20
> Second version of CPU affinity patch set.  Attempts to mimic operation
> of Linux affinity functions, both the sched_* and pthread_* varieties.
> This v2 version assumes Windows processor groups always have 64 logical
> processors.  I'm just trying to get the control structures laid out.  A
> later version will deal with smaller-sized processor groups.
> [...]
> > > +#ifdef __CYGWIN__
> >=20
> > I don't think we really need that extra ifdef.  #if __GNU_VISIBLE
> > bracketing is sufficient.
>=20
> This mod is to newlib but I figured it's not relevant to non-Cygwin
> platforms. Could you please confirm the __CYGWIN__ bracketing can be
> removed?

Confirmed.

> OK on 32 vs 64.  This XXX comment is to remind me to support the smaller
> processor groups before final patch submission.  We have been discussing
> this but I don't think I made it clear I'm considering the "big bitmask" =
set
> (like Linux uses) and how processor groups subdivide it.  It's an array of
> cpu_set_t (=3D=3D uint64_t) but when subscripted by group number, it's an=
 array
> of G-bit quantities, where G can be 48 or 36 or ...  Ergo, some bit-align=
ed
> reads and stores will be needed.

Sure.

> > > +	    // There is no way to assemble the complete process affinity ma=
sk
> > > +	    // without querying at least one thread per group in grouparray,
> > > +	    // and we don't know which group a thread is in without querying
> > > +	    // it, so must query all threads.  I'd call that a heroic measu=
re.
> >=20
> > I don't understand.  GetProcessAffinityMask() exists.  Am I missing
> > something?  Also, if you don't like GetProcessAffinityMask(), there's an
> > equivalent NT function to NtQueryInformationThread:
>=20
> It exists, but if the process you're querying is a multi-group process, t=
he
> mask is returned as all zeroes.  The func only works for single-group
> processes.  I even use it for such a little earlier in this code.

Uh, ok.

> That doc I referenced in my last submission talks about how support for >=
64
> logical processors was hacked into Windows to allow pre-existing code to
> continue to work.  The down-side of the hackwork is that one has to manua=
lly
> place threads into processor groups other than the one selected by Windows
> to run the primary thread.  You can't change the processor group of the
> process.

Yeah, you have to use SetThreadGroupAffinity() to set the process
affinity.  That even *kind of* makes sense, in a twisted way...

But afaiu, the process affinity is not a bitmask but a group mask.  As
soon as a thread gets an affinity mask that adds a group, the entire
group is added to the process affinity.

That would mean calling GetProcessGroupAffinity() is sufficient to get
the process mask.

If you want to be bit-exact, defining the process affinity mask over all
groups as or'ed mask of all thread affinities, you'd have to fetch a
list of all threads of a process and then GetThreadGroupAffinity() for
each of them.  That should work without having to call
SetThreadGroupAffinity().


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlzGxs4ACgkQ9TYGna5E
T6AdRhAApIgMYv5CSQr30qfmloN0Z0PxnrEGHS3kbnIuvJcjWFeho31n3MpdJGek
Wc/HmClGgcmG3mRru10WFfOHKY4mkt0Yi+TV2MzcjvisrP5gO+wYbRYiUoLJS6IC
VjOv6uVqf/DLywDoiSAuxMW5yTOcXroFY9mwlAJ3WMyBGAN49az4EiPOFdfQDgS1
XA9ex4OI4Yb0Qu+WBDd/BhvssjGrCebWFCkZ7R/igdE661A07DSktEf4Xo5MREpc
y6vatTbOzb3PggLRpMwjc/BUhoeRyb0X4nfNmBPy80P43b4JRlo2138u+SQKnzSE
wgaUnxDJAItkcYZB+PuJQwTVTix9EF+kzylEDkOThLZ8ym04Mke6ERaDG7Ei+FK4
hR9SkTOeAm+eW8cD9AKo80RQfp5Hgz86e6z6QnUj20o+QmFNUKJAtfZQflJJdEsV
260g870PQgWn6kLNltENoSIjDQ+/LW6ypu3UFI3wAx+KILuUcQJgFPbh/nKtKiSR
DHcdRFDxsboRnXBvM69EduruY05CCrswHKz1V3oAu2VD/J8wyNCU2C0MwuGBdfSZ
i4AzyEP/wPdrySA7EXhXGo47zmtLhZ3A4Iebxr5vFHYS3zwyVt/Q4VFTS5/m5MaG
IjV9445NfpHaYqinzqSbdhegASzCiPMUq+nXGgEReoRhYDNbGxc=
=//GB
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
