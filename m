Return-Path: <cygwin-patches-return-8133-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26107 invoked by alias); 23 Apr 2015 15:32:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26091 invoked by uid 89); 23 Apr 2015 15:32:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Apr 2015 15:32:29 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 03CFBA80973; Thu, 23 Apr 2015 17:32:27 +0200 (CEST)
Date: Thu, 23 Apr 2015 15:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Provide ucontext to signal handlers
Message-ID: <20150423153226.GM3657@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk> <20150401142219.GY13285@calimero.vinschen.de> <551C2CB7.4@dronecode.org.uk> <5538F94A.3080402@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="Fc4/uDQsB6b9dq2q"
Content-Disposition: inline
In-Reply-To: <5538F94A.3080402@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00034.txt.bz2


--Fc4/uDQsB6b9dq2q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1112

Hi Jon,

On Apr 23 14:53, Jon TURNEY wrote:
> On 01/04/2015 18:36, Jon TURNEY wrote:
> >On 01/04/2015 15:22, Corinna Vinschen wrote:
> >>It would be better to call RtlCaptureContext
> >>before calling call_signal_handler.  But this requires a change in how
> >>call_signal_handler is called.
> >>
> >>We should discuss this at one point, I think.
>=20
> I noticed that we already prepare a context for continuing after the sign=
al
> for the debugger, so perhaps this is not quite as complex as I thought and
> something like the attached is needed.

signal_debugger() is (basically) called for all signals, but in case
there's no GDB attached, only signals for which a signal handler
function is called need the context.  Isn't it a bit heavyweight to
suspend and capture the context for all signals then, perhaps?

> It's very hard to reason about if this is doing the right thing when the
> signal is delivered across threads, though.

Indeed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Fc4/uDQsB6b9dq2q
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVORCKAAoJEPU2Bp2uRE+gGMEQAIBlCN0QAJzAEd74GJPIzQr1
mV7P+pWwXh8nNXFqgr3DmcZQdSME+lDXoqEcJl0h36z8BHDDN4mGNhM3JnELx0Sl
zSrSN4IO8VBQ4gvudnQ8yNAdoHQWPrlSrRCD3v8fkrfI7J29Xj0HWZGoMnDr6IvL
41tAAcBynSdVnTl4BVEFT52T7ojqCa2gyirVTAm6pVM4rka+6j0dgoKOzz2x+Aaf
mTHBYwWqXqY8OxNd1qCC4LSjB8/KEvOSnyV1UXYDMX4o1+F8XRZijWwI/GyTsEwm
wLeUYuiweuNWPaMwrzDXJEgeW9cN93nIOGNNdfBx+eXQoen2xxg2i8GfiTBfBJqx
6QpSzjiJBNNmvULVt5eO88DqYg2pvDd5BfNvhq2nbU+mKE30y7IBVMPDdW/DrJto
jFvn0v8TrRAjFFg8/OrT3NmyslXVlGP92FtSg4Z0PiEVNDuKLfUdK3/b4u5O3UYF
RMJzVxj3jndd0xfGJWMvWPmu5m2khhLtjN1ue/+It6uw9tJ8twVHQ4KVLsRb6kf4
4AyBsUxL/KfBlxndQrNIKoUOBcKcsUam8psRA6n93BfJRiESLOihCGqDK4lbq2YG
ruMVJnEejLHahP9XSmeH+1iFyq3RqgDmUR0MKHpuu29l3nrx7Al+AoswVamannhy
ojAPZWD79ASTFizP1LRA
=DsrP
-----END PGP SIGNATURE-----

--Fc4/uDQsB6b9dq2q--
