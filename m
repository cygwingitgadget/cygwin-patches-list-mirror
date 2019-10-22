Return-Path: <cygwin-patches-return-9776-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126796 invoked by alias); 22 Oct 2019 07:16:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126786 invoked by uid 89); 22 Oct 2019 07:16:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*MI:sk:87pniq7, H*i:sk:87pniq7, H*f:sk:87pniq7, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 07:16:26 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MEFnP-1iD9Mo3HrZ-00AHcT for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 09:16:23 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B30C6A806A2; Tue, 22 Oct 2019 09:16:22 +0200 (CEST)
Date: Tue, 22 Oct 2019 07:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
Message-ID: <20191022071622.GM16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87mudvwnrl.fsf@Rainer.invalid> <20191021081844.GH16240@calimero.vinschen.de> <87pniq7yvm.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Content-Disposition: inline
In-Reply-To: <87pniq7yvm.fsf@Rainer.invalid>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00047.txt.bz2


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1359

On Oct 21 20:10, Achim Gratz wrote:
> Corinna Vinschen writes:
> > That's not the right way to patch this.  devices.cc gets generated from
> > devices.in by the gendevices script which in turn calls shilka from the
> > cocom package.
>=20
> Now that you mention it I remember=E2=80=A6  :-(
>=20
> > Apart from the struct members you added here, it will
> > also add some code.  Which, unfortunately, raise the size of devices.cc,
> > especially troubling the 32 bit version.
>=20
> So how about we only do this on 64bit as an added bonus for folks who
> "get it"?

I'm not hot on doing that, and I'm not sure shilka likes ifdef's
inside the %% block.

> One particular machine I've recently worked on presented me
> with COM144 to connect to, but I consider this to be an anomaly.  But
> COM port numbers in the 70=E2=80=A680 range are pretty common on some of =
the
> more heavily used development machines.

I just checked and changing ttyS%(0-63) to ttyS%(0-127) raises
the size of .text and .rdata by 6.5K and the size of the final DLL
by 7.6K.  That should be ok.  Just provide the patch so there's your
name on it.

ttyS%(0-255) takes another 23K btw.  Even that should be ok, if
the need arises.  Alternatively we could shortcut shilka as for
/dev/sd*, but that involved much bigger numbers.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2urMYACgkQ9TYGna5E
T6DNeQ/+Mx9iJT01YoUII7Q+MMCH9HBhZJGIoLMFxBWXIQvAAVog/cmGjw5yv4Zt
h5UZcbh0u+/0rkWacfXi0T0xxWDPBXjlPgq5fxfHURetlFsIwQ41teyBeoawtjqC
BJOUgxslAjwYSwWYTPgjg/HbOjwzaVasXuIz+bFJ+n+ONnWSB+dpzsj+MhwmuPEy
VzYlR+csNActsb3OuElkbhtZo6TDcg16NvORfMnrbbxi6iEJ0zZ92mSVF8KObYYI
Xsu2/x4QIV0q+uX7/zxpuJjoM5naUDOe0IQbZLbCWuo+wgGv9qBg8uJIZejqafOq
Cj4EZEnvKfU2E1+Yk+N7/HIaHWBOMcDMrTUgcTMX37Lg9Dub/f6J5hJpTqQvHrm3
Y28Z1JzTaohwvWhRA5s3nnlFvlYyVhPkLsw1YUJNhCNBH8kVWj6f9EernuGSMqdz
Z20o4eu55tAq2iOgzfMrO5ZnMvdaCC4/iLL5Ig5WD2tMhPB7TFCVfRVT4MlnX0Io
NI3L70VUve3nwCWWvXjqfcRHiikbHBQkBImTBZqH06d0JzACrnuTI6CzdahglDdU
fx7NA790d/CX/e0YLiJqFv05rQ68VcufvCqzsaC/YBqAEqNul0p+UJYwIi3IoV+V
4cB1EJsFX5qudHtlhHm8iWxgwgqzXOpLgrgoRpcjPQgN9M7OXr4=
=8f9d
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
