Return-Path: <cygwin-patches-return-9242-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98881 invoked by alias); 27 Mar 2019 09:16:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98575 invoked by uid 89); 27 Mar 2019 09:16:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=complaints, DLL, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 Mar 2019 09:16:43 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mw8cU-1gsmHE33Js-00s9QP for <cygwin-patches@cygwin.com>; Wed, 27 Mar 2019 10:16:40 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4A880A80554; Wed, 27 Mar 2019 10:16:40 +0100 (CET)
Date: Wed, 27 Mar 2019 09:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190327091640.GE4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00052.txt.bz2


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3282

Hi Michael,

On Mar 27 09:26, Michael Haubenwallner wrote:
> Hi Corinna,
>=20
> On 3/26/19 7:28 PM, Corinna Vinschen wrote:
> > On Mar 26 19:25, Corinna Vinschen wrote:
> >> Hi Michael,
> >>
> >>
> >> Redirected to cygwin-patches...
> >>
> >>
> >> On Mar 26 18:10, Michael Haubenwallner wrote:
> >>> Hi Corinna,
> >>>
> >>> as I do still encounter fork errors (address space needed by <dll> is
> >>> already occupied) with dynamically loaded dlls (but unrelated to
> >>> replaced dlls), one of them repeating even upon multiple retries,
> >>
> >> Why didn't rebase fix that?
>=20
> As far as I understand, rebasing is about touching already installed
> dlls as well, which would require to restart all Cygwin processes.
> As the problem is about some dll built during a larger build job,
> this is not something that feels useful to me.

Wait, let me understand what's going on.  IIUC you're building DLLs
which are then used during the build job itself, right?

> > Btw., is that 32 or 64 bit?  Both?
>=20
> I'm on 64bit only, can't say for 32bit.  And while in theory possible,
> I'm not after supporting 32bit Cygwin in Gento Prefix at all...

If so, then I'm really curious how many DLLs are affected and why this
occurs on 64 bit.

As you know, 64 bit has a defined memory layout.  Binutils ld is
supposed to base the DLLs to a pseudo-random address in the area between
0x4:00000000 and 0x6:00000000.  This area is occupied by un-rebased DLLs
only.  8 Gigs is a *lot* of space for DLLs.

That also means that the DLLs should not at all collide with windows
objects (typically reserved in the lesser 2 Gigs area), unless they
collide with themselves.  At least that's the idea.

Can you check what addresses the freshly built DLLs are based on by LD?
Is there a chance that the algorithm used in LD is too dumb?

Or, hmm.  Is there a chance that newer Windows loads dynamically loaded
DLLs whereever it likes, ignoring the base address, ASLR-like, even
if the DLL is marked as non-ASLR-aware?  But then again, we should have
a lot more complaints on the list...

> >>>  I'm
> >>> coming up with attached patch.
> >>>
> >>> What do you think about it?
> >>
> >> I'm not opposed to this patch but I don't quite follow the description.
> >> threadinterface->Init only creates three event objects.  From what I c=
an
> >> tell, Events are stored in Paged and Nonpaged Pools, so they don't
> >> affect the processes VM.  What am I missing?
>=20
> Honestly, I'm not completely sure whether this patch really does help:
> Beyond the Events, there also is CreateNamedPipe and CreateFile used
> in fhandler_pipe::create via sigproc_init, and these causing the address
> conflicts with some dll actually is nothing more than a wild guess:
> While their returned handles are below the conflicting dll address,
> who can tell what these API calls do allocate internally?

The handles are not addresses.  If the sigproc_init stuff collides,
I only see two chances for that, the process-local read/write buffers
of the signal pipe, and the stack of the read_sig thread.

If this patch helps your situation, we can pull it in and test it,
but I think your situation asks for more debugging along the lines
of the DLL rebasing above.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlybP3gACgkQ9TYGna5E
T6BNiA/9GkUoDBGNPehBzUVlSxuJb1K2UUC11FWEr7rFvJ1rNZY8vqKP/YIXrZTe
PLCmdqKSsDqPBz9+q5t3rOi0xod8+GM2OfvfOm2RsAJ3G7YJOgeEjFuWIR+Sn9PT
YQw/HkoVyFx955EkgGOm9vZRRZOSRNJDu5v/S9owIKNXL4FxfH3zZH+2mq00/Phb
OBh50+QChOStguwEYT27I24YZqyfukfWOCMk5zss5XjVaidz+if79NXvMaOSwJpI
wHR3GfFOIe0tQJmGBFytKkLzK+8N+46zBKlee1+8Z2xVqIftCbVUvbFWc2iP93bO
oU5rKQyM9TWg1dt0a+YS1+tHOS3PAk9CC1kZoGHQJddlaqTwkN9x9Q3JqwkJVwMf
fpK67jWPl6Y9uDz66Nyp9q54uoxOUwxpxHm7Ugm7CjorfzXp4YwoLIN2FwmkOnkc
RHJPnwJeN6ovN6R8+95SKCXNJ48s5nG+7K7A1dEge8qsKzm5XDpLTHxR7gMPl+Ze
Qadvz5ZbGFIsEJB2dfKgNE55uKa926y3AoEU0ZrP6vh0W9FQfDDfMQ33FzYhJG1q
Pz3mRcmLJU3vwsmeAvYGskI5/kBPSaxvQYgrrflR7xic/9Mc8IT/wInfSu608W9I
dMitO5M813QqfVrCcmnZ97QnMJu8gCNZPRfEwGpD/PLTamW/qt0=
=vxhh
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
