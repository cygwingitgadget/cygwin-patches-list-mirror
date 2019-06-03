Return-Path: <cygwin-patches-return-9423-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92638 invoked by alias); 3 Jun 2019 16:39:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92624 invoked by uid 89); 3 Jun 2019 16:39:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 16:39:04 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MjSPq-1gskvv1QYE-00kwsT; Mon, 03 Jun 2019 18:39:01 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 02CE8A80653; Mon,  3 Jun 2019 18:39:01 +0200 (CEST)
Date: Mon, 03 Jun 2019 16:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dll_list: stat_real_file_once with ntname
Message-ID: <20190603163900.GL3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	cygwin-patches@cygwin.com
References: <4e4cb543-f808-61f1-57be-06db527c57b3@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Content-Disposition: inline
In-Reply-To: <4e4cb543-f808-61f1-57be-06db527c57b3@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00130.txt.bz2


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 929

On May  3 16:14, Michael Haubenwallner wrote:
> NtQueryVirtualMemory for MemorySectionName may return some old path even
> if the process was just started, for when some directory in between was
> renamed - maybe because the NT file cache is hot for the old path still.
> This was seen during gcc bootstrap, returning a MemorySectionName of
> ".../gcc/xgcc.exe" even if started as ".../prev-gcc/xgcc.exe", where the
> directory rename from "gcc" to "prev-gcc" was done the moment before.
> As we stat the module's real file right after loading now, there is no
> point in using NtQueryVirtualMemory with MemorySectionName any more, and
> we can use what GetModuleFileName returned instead.
> ---
>  winsup/cygwin/dll_init.cc |  2 +-
>  winsup/cygwin/forkable.cc | 40 +++++++--------------------------------
>  2 files changed, 8 insertions(+), 34 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz1TSQACgkQ9TYGna5E
T6Dt4A//ccx56WdH9q0hHmbwNUfzVzVFpEvZy1JxfTw8Ctrx9/z5CQVw0icncNoi
km278Nw4WwjgAOdb4eRo3mrk71GMfecvxvoy663QGrhVbRnc5Br2zWLzaQ4eWdXI
NzsYn+b8DAvLjYwFZ6TYqwUHWkYYhy1RNtaHS6HKM7PliSIfmrIqESGhfFzAD8jc
64UttaYX6du82pluIBPTymupieIqredfDMv1l3DQ7ORdwW8u1fdwet2JnQ+wK2vS
/xavXrVCIU7gisZ20zbRSMGaaZvRJ9Krh2mM/w7U1vViBMQBqD+85KZ/s2o9rC2+
cc6+Zw2CoEnVHI/SBojVGojoXBV00vOroIRSEpTsZU89KhP+axG05RkFvPAhGB6P
iYfv15LJzTFG8b60ekWSIPKCHGDZTwxTcjOo2w2UBhPM3vMYh+nJNMK036oex55M
Kqux5Q5Rn0BUfAGgiN4zbHpXzAhLRv99rM9rwVRzbg0bJWWi8Y2+mUZ6MFA1sZL8
p8Of4gLCNf5CpGmsfHeWJNquGzS956Q+27Hy6LlcZgbF9Dla7LOQW5KKKblELaNO
2VJeQHljHzxuZT4swelrR7pv07eWk78XJFGHN5IZyj2Ohrwq4P1VleFjF2Cmlewy
aTSjNQWfBB2wfbQh00cBrjprlXVXQIztT5jmsUpXGLa2PmO3tmY=
=37DM
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
