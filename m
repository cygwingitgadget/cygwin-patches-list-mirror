Return-Path: <cygwin-patches-return-8047-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16259 invoked by alias); 16 Jan 2015 15:56:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16179 invoked by uid 89); 16 Jan 2015 15:56:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 16 Jan 2015 15:56:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E1F6B8E1421; Fri, 16 Jan 2015 16:56:01 +0100 (CET)
Date: Fri, 16 Jan 2015 15:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: tracing malloc/free call
Message-ID: <20150116155601.GH3122@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54B6EE1F.60705@gmail.com> <20150115093451.GB10242@calimero.vinschen.de> <54B91EFD.80302@gmail.com> <20150116154425.GG3122@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <20150116154425.GG3122@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00002.txt.bz2


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 793

On Jan 16 16:44, Corinna Vinschen wrote:
> Hi Marco,
>=20
> On Jan 16 15:23, Marco Atzeri wrote:
> > On 1/15/2015 10:34 AM, Corinna Vinschen wrote:
> > >Bottom line, you should be able to fetch the original return address by
> > >printing the value at
> > >
> > >   *(void*)_my_tls->stackptr
> > >
> > >which points to the uppermost entry on the stack.
> >=20
> > Hi Corinna,
> >=20
> > in reality I found it is "*(_my_tls.stackptr-1)"
>=20
> Oh, right!  Sorry about that.  I missed to take the behavior of xadd
> into account.

Worse, I missed the fact that _my_tls.retaddr() already provides the
correct return address.  Sorry again.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUuTSRAAoJEPU2Bp2uRE+gaxkP/jnqU8MQ6jIu5BUw5nT/KEyk
veLXnGyF4LuDM8hN1i0t8c3pAgFrsbI9l3FP1IqDmUCQgWVjXUzy/Re7igPKfoFg
5okE9q9+27BzXGUgQzMVPWdSAylsRNKlPS+ucDtWP0ZQvRUEXmFaiOvnwswn7g9A
53cue6O3adsoienOGSqhfxdXf/Y4Yc/b9GFfWiJbO3NVzHA9DbMlSWSwUT/5cLbK
SfXx58zbuQ74svj+sszAP3VD6ueF4TbyDi61jKRwv4xMfoYjtKeO5V0K4oD4chpw
cfai0FZzMH5X2dI3Nw2kyY4iqfu6+wSRM1DR1Y5ghMQDgRIi4aJr21Xx63DsJKlM
/sqqSCRbN04pV//mFFGnCcueCs5B+Hdj5XCuiF+c4zFDggMNCpPtRC/edHZSNLVu
F2Twy+2NvGfKnRM0eTwzU0BGdNcgV1PxYL0dmVVFdid1u3xC+1tPT/j849sFSB1D
G0Kf7pIwz0F49yJe4ueL8R8I3vdiMB4K9avCFDDFhrNiIRWl4hcKndWKAhmYgPvC
/89UAR2pCHwHQDbfzydmHEAQQeukgix76S1Ii6J/9dv+pwblyMSF2mx8JyWFTxla
3Dt1NY4hQQbJaAUUo6CDq6SaoM2yo5WX5oRSHDJx1W0veNF0MnMcqsnrV6wda3Su
N3rNd1MSdHSgF8+emR5b
=9eHW
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
