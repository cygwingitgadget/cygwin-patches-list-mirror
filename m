Return-Path: <cygwin-patches-return-8030-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17997 invoked by alias); 13 Oct 2014 09:05:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17985 invoked by uid 89); 13 Oct 2014 09:05:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Oct 2014 09:05:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 827628E1516; Mon, 13 Oct 2014 11:05:08 +0200 (CEST)
Date: Mon, 13 Oct 2014 09:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
Message-ID: <20141013090508.GA24654@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54240D45.6080104@t-online.de> <20141009175956.GF2681@calimero.vinschen.de> <5436D241.3070104@t-online.de> <20141010110752.GA14455@calimero.vinschen.de> <54380B0E.7020803@t-online.de> <20141010180429.GO2681@calimero.vinschen.de> <20141011183644.GS2681@calimero.vinschen.de> <543B6533.807@t-online.de> <20141013082034.GZ2681@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20141013082034.GZ2681@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00009.txt.bz2


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2109

On Oct 13 10:20, Corinna Vinschen wrote:
> On Oct 13 07:37, Christian Franke wrote:
> > Corinna Vinschen wrote:
> > >On Oct 10 20:04, Corinna Vinschen wrote:
> > >>In short, the whole code is written under the assumption that any sane
> > >>application calling nonblocking connect would always call select/poll=
 to
> > >>check if connect succeeded in the first place.  Obviously, as postfix
> > >>shows, this is a wrong assumption.
> > >>
> > >>I'm not yet sure how to fix this, but I'll look into this next week.
> > >I applied a fix which, I think, is much more elegant than the former
> > >solution.  The af_local_connect call is now called as soon as an
> > >FD_CONNECT event is generated and read by a call to wait_event.  It
> > >worked for me, so I have tender hopes that I didn't miss something.
> > >
> > >I also applied your patch on top of this new stuff and I'm just buildi=
ng
> > >a new developer snapshot for testing.
> >=20
> > A quick test of current postfix draft with the snapshot works as expect=
ed.
> > Thanks.
>=20
> Did you run other network-related tools, too, in the meantime?  Any
> fallout which could be a result my change?
>=20
> > >   In setsockopt I added a check for
> > >socket family and type so setsockopt(SO_PEERCRED) only works for
> > >AF_LOCAL/SOCK_STREAM sockets, just as the entire handshake stuff.
> >=20
> > Probably not needed because this check was already in
> > af_local_set_no_getpeereid() itself.
>=20
> Doh!  I reverted this part of my change.  I completely missed the
> redundancy here, sorry.
>=20
> > >   I
> > >also added a comment to explain why we do this and a FIXME comment so =
we
> > >don't forget we're still looking for a more generic solution for the
> > >SO_PEERCRED exchange.
> >=20
> > Definitely, at least because the current AF_LOCAL emulation has some
> > security issues.
>=20
> -v?

Btw., I'd be grateful if we could discuss this on cygwin-developers,
if you don't mind.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUO5XEAAoJEPU2Bp2uRE+gqpgP/0dgbaKQ+uAtm1008XoaFpVO
gN7YAK2qBWa+l0tbt5ilGVbX6HVDdx1x/SKDVzKcWkU2G88lPunHQzmv8u549WwA
3OdFwRmP23K1Xd9E/WacnNiJFcJvNNbMDT1T1cQhCedrmTQ/Mo4kCCIBvNDbVJzG
Ers7V6Vk+kYWbCfdH5fWtDtvBIe+TQSH7tKQRWC+YRJ0dc7QZxrNTFfKnJGRyU60
hbDaNYAZ5eEBFArtMiufpKKbbOWnnWkq4tykshzDfTXOo5WSFaKEhFiN0Q5GHEyY
5+f+4OEiK0MPtnDZmNEdW2YfDLHw7pPxRyX2+AX8TH74TsGKRRD8VfDK2gVLZ2xL
aMI2NPn+Fi3TdNixC9Dau5WNaoKDgRmtFxkG/nFK8YYABUEsCXtrEb4t4ypmE6Tt
XmbhPCIIvNMQOgVFpD6gVViJPsTq341vnF9/DSJW+pWYMY3o2Y6rPfKrtoPtvVli
kQsKJJGB3U/GGtLTX1QiKhSbWo42ZE7jAUPM5kCjHmGSkG4Rebe9FiIPSSoc6lSY
8yWR69ItHO3LQC/4MVypRs690MayZgMMBjoKxyGjAMBUVGhxwEtTSMh43cDk/voo
uQcSOg/ZJFpahH8szDPlGtSLKauw+FxUEFXQV0CYGBObJ3EnABr9bw3ZBF29QU1h
iA0o/08s2Bt9hF28xQRY
=UDka
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
