Return-Path: <cygwin-patches-return-8094-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59164 invoked by alias); 31 Mar 2015 19:02:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59150 invoked by uid 89); 31 Mar 2015 19:02:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 19:02:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F3999A80A3F; Tue, 31 Mar 2015 21:02:17 +0200 (CEST)
Date: Tue, 31 Mar 2015 19:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Make detailled exception information available to signal handlers
Message-ID: <20150331190217.GC15852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00049.txt.bz2


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 640

On Mar 31 18:46, Jon TURNEY wrote:
> Thanks for your help so far.  Here's another attempt at this.
>=20
> Questions:
>=20
> The ContextFlags member of the CONTEXT type is named cr2 in struct __mcon=
text. I=20
> don't understand how that can be right.

It isn't.  Please rename cr2 to ctx_flags and add a uint64_t resp.
uint32_t value called "cr2" as last member after "oldmask" to struct
__mcontext.  We're discussing filling cr2 later, it's certainly not
a pressing issue.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGu85AAoJEPU2Bp2uRE+g8HgP/jgmK2iHXTeFKQyeXuyvZ5iA
fIta0CnozmHavCoGCWZZ+FzZHEMj0OmOhOOI7EaKafIOkFYU9P+m3zNdQRym+zyk
d1Vd9FPoJCmO/k/xdvSmyptT/DbSjrOIpl1O7X3s+XJDLt7bkzlGn0GKMmeRBHB4
mz/hOnHXiTnNZqiIInJLcETWpfN8cyMm0QdvcHLXX58fWJ7cmDyuGhPTO5rjmcM8
yVZbh3JLmS/WWKjXPviT8w2mj2ZiIB+E3wJh0eW92++RGw68IiFDLR//YONaCgR2
M+zxwWixefXNQPHEVWYSM4SMP8ItHcD+lksIV3sTg47GpnbNrg2hl9DdnFrkuIs3
GmozxtkZeJ2jOD5quwmhQwa984VUUjaEYLYTbn8HszBLUbvZDa22yccsNuUs1/Zm
uWKM8HxyAfcLqNVE4sG0NYcBTjmDoPgjNyzfm/gZpLjc9/ODplTA12U8DxwL9qEC
7zg5ac5+hXL4KT12l6jbhbxx4pFLzLS2uDv9CkHX2MWICgSXITj0SNneUkWOLm5p
zo09Q6KNe62UdxRbRXiJ2JmR7w9fZrS4EIZOFp0GZEFLLvQLe7COkYzlL0RmPr5e
BcS/jKgYD7ZUkYEdeB6qKVuCTOpNUHm6voiUz7+57mHpMYEMmefayzhnjGqxMd9O
uu8CrIM0mSIZUd84o7eS
=Ai+M
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
