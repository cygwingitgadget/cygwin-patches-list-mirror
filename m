Return-Path: <cygwin-patches-return-9265-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108988 invoked by alias); 28 Mar 2019 20:16:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108557 invoked by uid 89); 28 Mar 2019 20:16:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 20:16:18 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MLiTI-1hRGqw3nRA-00Hgi4 for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 21:16:10 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9174BA8054D; Thu, 28 Mar 2019 21:16:10 +0100 (CET)
Date: Thu, 28 Mar 2019 20:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Message-ID: <20190328201610.GA4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190325230556.2219-1-kbrown@cornell.edu> <20190326083620.GI3471@calimero.vinschen.de> <1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu> <20190326190136.GC4096@calimero.vinschen.de> <20190327133059.GG4096@calimero.vinschen.de> <87k1gi3mle.fsf@Rainer.invalid> <20190328201317.GZ4096@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NOl3kBTBh+CNLogO"
Content-Disposition: inline
In-Reply-To: <20190328201317.GZ4096@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00075.txt.bz2


--NOl3kBTBh+CNLogO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1268

On Mar 28 21:13, Corinna Vinschen wrote:
> On Mar 28 19:01, Achim Gratz wrote:
> > Corinna Vinschen writes:
> > > Done.  I also pushed out new dev snapshots.
> >=20
> > No good deed goes unpunished=E2=80=A6
> >=20
> > Whith the 20190327 snapshot our main data processing application is
> > broken.  It looks like it should almost work, it doesn't crash or
> > anything, but the pipe that delivers a script+data into gnuplot seems to
> > either skip or overwrite data and then gnuplot bails with a syntax
> > error.  Depending on exactly which data I try to plot I get the first or
> > first few plots out through the whole processing pipe (that ends in a
> > PDF file), albeit sometimes with incomplete data.  Doing each of the
> > steps manually (i.e. writing the gnuplot script into a file, then feed
> > that into gnuplot, then the output from gnuplot inth ghostscript) does
> > work correctly.  I have not yet been able to reduce this down to some
> > simpler test case, so I had to roll back to the previous snapshot.  I
> > still have it installed on the development system, though.
>=20
> I'm pretty sure Ken would be happy about an STC.

Btw., the 3.1 release isn't due soon, so there's no reason to stress.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--NOl3kBTBh+CNLogO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlydK4oACgkQ9TYGna5E
T6CdCQ//bzIbpK0Dr0Mx0GDfQntszKA/DHgh961KzohSJGfuHgv5/yHWPewWoV4+
xnWE6uV8LqOTTr1+prvNK+fgHVJ5OjFEyBN2rlOBIW58oWV+Ek43OgnHZp83OF1H
BHIex//WxQiItglCQVpR7X3TH7m5cOtsJWhlFH6whxClDyKK3jJLpZMfENOdpQLk
7W1tg5EVckcIYcFs2n6/9qD473oRHVTTP2cqk7+uWEz/3Gmg0wNEHSG8KmMX6HJV
QiUYLjI6UNC9M2IKYKKDveeEPgze9I5Tylh+eal8Ho40Ueo5/nJjAYRkPYjEYxnE
wJLg+7ckSEQW/P3Rt4RBqaIy1MrnMsC/tn7VwG9frD6+73TZHrBFZJ2gyIW29aYS
s+18ZrBqnwHoXuTd9HonJ+Hx7ch1IFc8gMg6EhPn/OPLWKvAcIwQjMLTcXmeFbig
v2GvpCE82X4bULzJDm65z81kcIrGh6K8WUgFTYFxS6WR9K2spEFc+df7Ozseih5p
PaCIERaUFYrinRT3tzQCpIDCdM6/j3OAJcihHyVZb2crajyZ+CVffUvVIBKV+zCz
fSFuYfs53orxWctY8sRJiVbjsaoG7Pxt5WQokQ7Th1jCfNkX+pHr/UU47NtLkcpQ
QaTXrg2UygnIeGfCgcRYrCMUyZFJ1pQZp9USxqKF+KxH9CZPkUM=
=AGmx
-----END PGP SIGNATURE-----

--NOl3kBTBh+CNLogO--
