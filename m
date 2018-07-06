Return-Path: <cygwin-patches-return-9114-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66541 invoked by alias); 6 Jul 2018 08:44:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56414 invoked by uid 89); 6 Jul 2018 08:43:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=died
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Jul 2018 08:43:39 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Lh0F9-1fvYOF2T1L-00oTmW for <cygwin-patches@cygwin.com>; Fri, 06 Jul 2018 10:43:36 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2DFFCA80394; Fri,  6 Jul 2018 10:43:35 +0200 (CEST)
Date: Fri, 06 Jul 2018 08:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Why /dev/kmsg was deleted from cygwin1.dll in git?
Message-ID: <20180706084335.GB3111@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180704044424.813ee03eff360d6bcb58446b@nifty.ne.jp> <20180704105420.GN3111@calimero.vinschen.de> <20180704220138.26b42dc96fb1b49a9dc693d2@nifty.ne.jp> <20180704145247.GS3111@calimero.vinschen.de> <20180706002924.1b29830bd08668a067509508@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ONmcTkPhtkbQYSLg"
Content-Disposition: inline
In-Reply-To: <20180706002924.1b29830bd08668a067509508@nifty.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00009.txt.bz2


--ONmcTkPhtkbQYSLg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2877

On Jul  6 00:29, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Wed, 4 Jul 2018 16:52:47 +0200
> Corinna Vinschen wrote:
> > Hang on.  /dev/kmsg was implemented using a mailslot and it was never
> > accessible via the syslog(3) interface.  The code you removed has
> > nothing to do with /dev/kmsg.
>=20
> First of all, /dev/kmsg was not guilty. The real culprit is the code
> I had removed by the previous patch.
>=20
> However, the patch I posted was based on mis-understanding regarding
> AF_UNIX implementation. I had checked fhandler_socket_unix.cc and
> thought cygwin AF_UNIX socket is implemented not using AF_INET socket.
> On the other hand, the code, I removed, checks existence of UDP socket
> to determine whether syslogd is activated. So I thought this is no
> longer correct and should be removed.
>=20
> As a matter of fact, cygwin AF_UNIX socket usually use fhandler_socket_
> local.cc, in which AF_UNIX socket is implemented using AF_INET socket.
> That is, the obove understanding was incorrect.
>=20
> > What the code does is to check if we have a listener on the /dev/msg UDP
> > socket, otherwise log data may get lost or, IIRC, the syslog call may
> > even hang.  So removing this code sounds like a bad idea.
>=20
> In the case of syslogd is not activated, /dev/log does not exist.
> So connect() results in an error. Therefore log data is directed to=20
> windows event logging mechanism even without the removed code. In
> usual case, no problem happens. However if syslogd is killed by signal
> 9 or died accidently, /dev/log remains without listener. In this case,
> the problem you mentioned may happen.
>=20
> > Can you please explain *why* removing this code helps and what happens
> > if syslogd is not running after removing the code?
>=20
> OK. First, connect_syslogd() tries to connect to syslogd via /dev/log
> which is created by syslogd. However, the code which I removed can not
> perform checking existence of syslogd as expected.
> Previously, get_inet_addr() is used to get name information of the socket
> opened by syslogd. This was working correctly at that time. Currently,
> getsockname() is used instead. This does not return name infomation of
> the socket on syslogd side but returns that of client side. Since no
> listener exists for this socket, it is not listed in the table returned
> by GetUdpTable(). Therefore this check results in false.
>=20
> As a result, current connect_syslogd() code gives up to connect to syslog=
d.
>=20
> To fix this, I made a new patch attached. In this patch, get_inet_addr_lo=
cal()
> is used instead of getsockname() as in the past.
>=20
> I will appreciate any comments.

Thanks a lot for the detailed analysis.  Patch pushed.


Thanks
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ONmcTkPhtkbQYSLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAls/K7YACgkQ9TYGna5E
T6DyVw/+JW8LFsq83oKoCF9Fb7QPPZIW+392gs+9Gg5L2i3yu44wI9VTHdV10SxS
6hyZyf4j4uWvIihzkgposd2MpMyCh1YYDrZ+zIVPsRFEBYp+gpREdCrSB4aqedfP
aaIF9ZueIdnAMwTLe5Ek6rTOyaYhGLBu75bMRUlsN588Sn2lJWpYGxm2Y3Yiylgf
Dy53H2UQ8cLe254da/SrUXFODAfYjWvCf3rFeXx6sDwdLJwycKbAB8jQNa6GqD1Q
DjdxAkc+W3VqCrEiYP0z2KhuWSj/K6rDkubRlUZcP19gg7DX8BqnEjtDnsRHOH9/
qBfBP9XwHbYnSw8j6gwBd/2P+m7ItJF/yI4oWbYsSoSSKXuta/D48tyzlsGXlv+T
Fiq84CNWbPzEsWBcXg+/M9UasxDXswmGW0P83aYPlUNdtsL/fzDvYdXgNx7NWr1A
HDElaarlbNap/QFT1ekfZnbmQ2v9OFgC9ea+q6nSPrbPEWa0IQRIJ1SLv9T4jc7I
buv+nwitA5ymFUvbmqiZu0bl9cfMnlNxsec9VlcZqJwR7wF5DllodIvBLjI62e1Q
A/Xqjv19/cAz2FsvxWEDnSjRmQqYesFEJedmkFyLmvJo7EhkCeMWWlheufti7vRF
AV1NRxA24mK+hI6LRJyQ1p6Wi6B+6Y6gf0l+0Z46srvj7qMHBN4=
=+73K
-----END PGP SIGNATURE-----

--ONmcTkPhtkbQYSLg--
