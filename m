Return-Path: <cygwin-patches-return-9240-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39408 invoked by alias); 26 Mar 2019 19:01:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39390 invoked by uid 89); 26 Mar 2019 19:01:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, tomorrow
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 26 Mar 2019 19:01:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mf0Jg-1gSdgZ1Z0M-00gXN7 for <cygwin-patches@cygwin.com>; Tue, 26 Mar 2019 20:01:37 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EB9A5A8054E; Tue, 26 Mar 2019 20:01:36 +0100 (CET)
Date: Tue, 26 Mar 2019 19:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Message-ID: <20190326190136.GC4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190325230556.2219-1-kbrown@cornell.edu> <20190326083620.GI3471@calimero.vinschen.de> <1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00050.txt.bz2


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1039

On Mar 26 17:24, Ken Brown wrote:
> Hi Corinna,
>=20
> On 3/26/2019 4:36 AM, Corinna Vinschen wrote:
> > Hi Ken,
> >=20
> > On Mar 25 23:06, Ken Brown wrote:
> >> The second patch in this series enables opening a FIFO with O_RDWR
> >> access.  The underlying Windows named pipe is creted with duplex
> >> access, and its handle is made the I/O handle of the first client.
> >>
> >> While testing this, I had some mysterious crashes, which are fixed by
> >> the first patch.
> >=20
> > I rebased the topic/fifo branch on top of master and force-pushed with
> > your patches.  Make sure to reset your working tree to origin/topic/fifo
> > and add any further patches on top.
>=20
> I'm comfortable now with merging topic/fifo into master.  I've tested the=
 new=20
> select and fork code [*], and they seem to work as expected.  That was th=
e last=20
> thing holding me up.
>=20
> As soon as the merge is done, ...

Will do tomorrow.

> ..., I'll send a patch with release notes.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyadxAACgkQ9TYGna5E
T6BD8A/9Hiji7t6Raf0D2+3Wawtx5QFUp5e38nhThDd+Os8ySD2+QzLWj3Ya2+ig
PqtnlrwmF3LHaUddvrSSNLBVL/SkxpRZMH6r22sUWyfHsKPrC899z3eLUNDvl11J
0qeqV/qveGcvpmB9EVPuWWhC4bmI0zGO35NHM8OkNKJXjcT5q4dovv28C2kezko0
5GAM7DQl0LObCTMBwr3drvT74gwyuJvx/HkP6JLGYgP+hk62tJFGo9xiT7NAkEaQ
7+cYFHXIExmNCSAJjaJ5yojAA6ObjA7PrN4H9sNPglXYMAl/HJ0o2q08dSdQI4cj
mRkZBQVbd+jGD2iyU46px5rRXDtFkUFQvr3/sxs9cgQo3cubCZ2hlac5tvGlmAjJ
qPnPHSK0c9a5byAML9PAvQJibQo+H0BYWNK9RzfI892qehtZNHz1l2j3vAjPu4LU
cgwAoJ2wQMaspypo6pXXSLZS6QVVK8Q56kuUL8tbBK/A6oFOO0vA/9FMbxLo8fJb
3wBBp7AsfOPTDeK97ROrrW+nhjXIiTJfZgPDWwMJRqbl/rWLMreHW4OHupV9sPXb
hSOEB5XHkHyDktNDApKpm9jBcrLCRH6FDDa7Su9EjeZCdILBD1kGdMnlN+8IfB5y
fPpPbmPIXIMGQfEZTtXjGIyGSEHNkqsLwvq1aKkcnhzEpaAmsqM=
=LyoE
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
