Return-Path: <cygwin-patches-return-9640-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76155 invoked by alias); 5 Sep 2019 12:14:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76139 invoked by uid 89); 5 Sep 2019 12:14:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=he'll
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 12:14:25 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MEmIl-1hvcJd2my3-00GLfJ; Thu, 05 Sep 2019 14:14:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EE203A80666; Thu,  5 Sep 2019 14:14:17 +0200 (CEST)
Date: Thu, 05 Sep 2019 12:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Ken Brown <kbrown@cornell.edu>
Subject: Re: [PATCH 1/1] Cygwin: pty: Fix potential state mismatch regarding pseudo console.
Message-ID: <20190905121417.GE4136@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, Ken Brown <kbrown@cornell.edu>
References: <20190905104441.2075-1-takashi.yano@nifty.ne.jp> <20190905104441.2075-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <20190905104441.2075-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00160.txt.bz2


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1504

On Sep  5 19:44, Takashi Yano wrote:
> - PTY with pseudo console support sitll has problem which potentially
>   cause state mismatch between state variable and real console state.
>   This patch fixes this issue.
> ---
>  winsup/cygwin/dtable.cc | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index 4e9b6ed56..7b2e52005 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -159,14 +159,19 @@ dtable::stdio_init ()
>  	    {
>  	      bool attached =3D !!fhandler_console::get_console_process_id
>  		(ptys->getHelperProcessId (), true);
> -	      if (!attached)
> +	      if (attached)
> +		break;
> +	      else
>  		{
>  		  /* Not attached to pseudo console in fork() or spawn()
>  		     by some reason. This happens if the executable is
>  		     a windows GUI binary, such as mintty. */
>  		  FreeConsole ();
>  		  if (AttachConsole (ptys->getHelperProcessId ()))
> -		    break;
> +		    {
> +		      ptys->fixup_after_attach (false);
> +		      break;
> +		    }
>  		}
>  	    }
>  	}
> --=20
> 2.21.0

Pushed.

FYI, Ken Brown is taking over from here as temporary co-maintainer for
Cygwin.  He'll build and upload Cygwin test releases during my absence.
Please don't hesitate to send more patches as required, Ken will review
and eventually push them.

Ken, if you like, please generate a new Cygwin test release now.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1w/BkACgkQ9TYGna5E
T6AUpQ/+K6RYj9TJ9qdrzVdpXV2RDAeGwOpkwlbXGt7+SxawbGKr7WgEZuS0uts5
wyOqO8P9U8vWvwqsB+GXcap/ZpACGUg/ShYGdRuobrXmreXA8p7JTsxiUlpL1yti
RQC2EUBp3/NgqpWGaflzkHXGRSzdh9wWIZMNYAJ0ylXG4F5zcIKJIRrk1LVt62gW
V67W6IdtuOftSkOC7ESi3qrJ9B7yyIpEmKIe7pE8k0W93k7T0C5hUww1P/39x5wM
1XbLdKgi1ponkayr4o7mt4k2o3gX74q7M9N6RtkBc55U/oLLGe24yUjN/M/pC6Y9
sT8ENEUU9ftS3P9tLbAcWogMPNr8kj9z7b1SmDqAEUFNr1o6xfWqr+N+Dh7NJcvV
QI3IflpKeYjHJgY2sj4pasO6L9o2l0A55VfMq0DlRcmAVx+C4eYyl5+jpwR03RHy
OhhWjK0AD1Aeeq7O63zecHoJqQ/rOreOfGFFrm8qlgCEQZBLNN97h2/5BYoUNPad
YZQjDOTfp4CJpK95kwHmoq9SQSul8zz/AKDVzQOBGL0wyew/apRyEInQsDBXgM68
wzsrngmfuOwawC0PYStEnf6Hy1LzRRC7oSHI3G+3d2ypk4U/hgczlXH82is2hnaG
9InOL8pIHjrnbsRkDWLGnU03BLIAlAtNNkdpNcREREVPekoVppo=
=wcOn
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
