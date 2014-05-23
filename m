Return-Path: <cygwin-patches-return-7984-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15267 invoked by alias); 23 May 2014 14:05:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15250 invoked by uid 89); 23 May 2014 14:05:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 23 May 2014 14:05:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 85BE08E0089; Fri, 23 May 2014 16:05:34 +0200 (CEST)
Date: Fri, 23 May 2014 14:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Rename detached debug info as cygwin1.dll.dbg
Message-ID: <20140523140534.GB750@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <537F4FD9.8050203@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <537F4FD9.8050203@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q2/txt/msg00007.txt.bz2


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 861

On May 23 14:40, Jon TURNEY wrote:
>=20
> Not sure if this is wanted, and it obviously has some knock on effects on
> package and snapshot generation.
>=20
> But, cygport names detached debug info files by appending the .dbg suffix.
> This is 'obviously correct' as it means that both a foo.exe and foo.dll c=
an
> exist and have detached debug info.
>=20
> For consistency, the attached patch changes the name of the detached debug
> info file for cygwin1.dll from cygwin1.dbg to cygwin1.dll.dbg

As far as releases go, this is ok.  I'll just have to tweak the next
cygport file slightly.

Chris might have to tweak the snapshot generation script as well, so
he probably wants to chime in, too.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTf1WuAAoJEPU2Bp2uRE+gA/kQAIPpRK2G0iRE4jIYih8Jzq0g
QTcPbBAPu0o23wqIfp9RewA/Z+B57Nd/f/U9R2cfrfYADYy0Nk3MW8C2MFeVMfSF
NzFGAvwr0rgtxUUN6GBfBlae4u/syjvUsL5IjdGQOXz6GMpKH8TUzql4IUYPMqw+
zFiNojB/FnbRAmB47ORrTO217N8jVgBB5fqwjpNOYfWSFlicb6K9X8epAt6uaHqh
LuHytjOhzGEE2flyDIOxSIZqq51vp+wb2nFLKTO+lJswkc4fyFKBPnpNKZMrYIZU
Z6PPoQ7Ug0H5mBI5GQsx51Yxg+LjIMztKR191/sqKiDtiITtykryUXUp8aPZTiN6
h9I/rDbKnRC3XqPZlILNd4p19p2Y5Ex745U25MgLpuDK/8USqQXTT8G1OXUnYp0k
LApwg7nOatABpXBFPmai2IHpJbearvSGeAaP7D5xN5DTNBAa0LHNdfayvIU0b4iq
N8gxxBgt4rZkUB2WxdaU4bWi4gP/V2KwaF49O9xCJ9piztqlJuAiTINKuoiWv9KQ
ZInKwRV9EcVrcr7ZkMZXIhHiDuKmzs/59tWPCNP2IOh3eXet5k9m319jJ5QucH4N
q3zmY7ivHR3CZl+pA9XdJFSIesBv0k9Ggs12cBwmrlSuNxn9qFRwWOREUdJqXG7v
JF7V4lOJuinc2mU3ZgMK
=LDGr
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
