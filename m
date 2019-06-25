Return-Path: <cygwin-patches-return-9465-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28529 invoked by alias); 25 Jun 2019 18:43:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28515 invoked by uid 89); 25 Jun 2019 18:43:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 18:43:01 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N3Gok-1ievIm3fHu-010OKp for <cygwin-patches@cygwin.com>; Tue, 25 Jun 2019 20:42:58 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2DC43A80762; Tue, 25 Jun 2019 20:42:58 +0200 (CEST)
Date: Tue, 25 Jun 2019 18:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: timerfd: avoid a deadlock
Message-ID: <20190625184258.GR5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190625142502.46350-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Xsn3knLL3qrmRbVI"
Content-Disposition: inline
In-Reply-To: <20190625142502.46350-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00172.txt.bz2


--Xsn3knLL3qrmRbVI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 726

On Jun 25 14:25, Ken Brown wrote:
> Add a function timerfd_tracker::enter_critical_section_cancelable,
> which is like enter_critical_section but honors a cancel event.  Call
> this when a timer expires while the timerfd thread is in its inner
> loop.  This avoids a deadlock if timerfd_tracker::dtor has entered its
> critical section and is trying to cancel the thread.  See
> http://www.cygwin.org/ml/cygwin/2019-06/msg00096.html.
> ---
>  winsup/cygwin/timerfd.cc | 24 +++++++++++++++++++++++-
>  winsup/cygwin/timerfd.h  |  2 ++
>  2 files changed, 25 insertions(+), 1 deletion(-)

LGTM.  Please push.  Can you add a bugfix release msg to release/3.10,
please?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Xsn3knLL3qrmRbVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0SazEACgkQ9TYGna5E
T6DuOxAAlca3jDoV5aJeaSxcWL9xltK4LiQ6OPYCHCpvBlYlhpZ9UNIoQnfLVsrv
f5YdduCfVavOlWoXhjPXm5zJHVgwKPAq283ITT81JY2eUJHBM/OtCVR0y6YjbMvA
46cMpw8/JOVCsr87dUXzkGDT/KE5khhr8biT8FCgv4P998pMSEH7L/Ma27Zqn9Lk
RAwzhybAoOeayOHEfZcEhIbbm1YmrTjSpFOMD001WyUWgTXnuSeJDymftwlbmbLm
9YKDDD/eriCJ3kWb6f/eZWbWZHWJf619qGq05vllVPGE8Mz+U2fOd5WOJAL4Tm4O
jVHywnqnWtpxZQpyStIia5TnD8Ux3yd0wrY6RiKO258UM8knVGpJJJ5CMhP9UmEc
CvrpGtj3TkpKLZBitjxlVmbEvuDHzDzOniXFdAmj+51zJ2jxeIDTm6DGo3OIYWOY
gd76AMyQe8An63d8T682y7Bvg01USDiDQ1MelCy7JMRq1mDFshndrTRtxRd6wjx6
FMEIGoiaP2zIgV1JLZVp/x1+t5xBVbgjMzce8yO3VQPG0T6h08bgKnQTbIzIBU8Q
g00I/gFP/RGC3rMUF1SA6o5FwW5UdigeQPZ4uXd+LuTGTZ9Y8+xue9YK/RzXpji5
BOo5oWk6wAJqFsxveFjstbA8kYpp34+4oEVg4bwL9GnPaeOBOCc=
=fEtY
-----END PGP SIGNATURE-----

--Xsn3knLL3qrmRbVI--
