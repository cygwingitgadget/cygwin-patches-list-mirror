Return-Path: <cygwin-patches-return-9786-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14676 invoked by alias); 22 Oct 2019 17:41:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14650 invoked by uid 89); 22 Oct 2019 17:41:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*i:sk:87d0eo6, H*MI:sk:87d0eo6, H*f:sk:87d0eo6, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 17:41:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mzhf5-1i9gR43OAT-00viEb for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 19:41:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 60382A80746; Tue, 22 Oct 2019 19:41:51 +0200 (CEST)
Date: Tue, 22 Oct 2019 17:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
Message-ID: <20191022174151.GV16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87mudvwnrl.fsf@Rainer.invalid> <20191021081844.GH16240@calimero.vinschen.de> <87pniq7yvm.fsf@Rainer.invalid> <20191022071622.GM16240@calimero.vinschen.de> <87d0eo65s5.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="4ECF1u7dKBoUGhe3"
Content-Disposition: inline
In-Reply-To: <87d0eo65s5.fsf@Rainer.invalid>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00057.txt.bz2


--4ECF1u7dKBoUGhe3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 917

On Oct 22 19:36, Achim Gratz wrote:
> Corinna Vinschen writes:
> >> So how about we only do this on 64bit as an added bonus for folks who
> >> "get it"?
> >
> > I'm not hot on doing that, and I'm not sure shilka likes ifdef's
> > inside the %% block.
>=20
> OK, then let's forget about that.
>=20
> >> One particular machine I've recently worked on presented me
> >> with COM144 to connect to, but I consider this to be an anomaly.  But
> >> COM port numbers in the 70=E2=80=A680 range are pretty common on some =
of the
> >> more heavily used development machines.
> >
> > I just checked and changing ttyS%(0-63) to ttyS%(0-127) raises
> > the size of .text and .rdata by 6.5K and the size of the final DLL
> > by 7.6K.  That should be ok.  Just provide the patch so there's your
> > name on it.
>=20
> You mean just the patch to change device.in?  Can do.


WFM.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--4ECF1u7dKBoUGhe3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2vP18ACgkQ9TYGna5E
T6B+xg//bJSJ0DMIr7JlWbveLKYFFKUEoilLapKHtLJ+PFWCuXqFkI2oYval3dLI
90VLPdpfeFQAwhHj89zxA0xd24avZtg6XUXx+qp05NwSvZaBMZvkQJ7raYi5Ij/2
Wdqa0tGKRujyv4AzcAVNhpECoM7XPFn7fTu68cu7fTzmH8l43CSdww30Bwbc5VJz
jWgGBLmf+bucvQTrxKhYSBaDrwBHeeCFPGfA7MgRauvf9N6/bMo4Evj4UPrqPsxF
MsYuhbHYpcP1z50SWWuSxLnKmCJ8qhrcI7FMsvticVIDksVdt7iyKx8PSa421wbO
FqOCf513zMpf55CVwxXMal4yZ8TTwAVSVW3EVwJGORQ1CkR1G7A9Ax1vRUXwVw1D
YDGfqsoiaTNWCY/bQGHCWGUJUE7uv+aDdyPahNYvawu3fVs3pa3W6v9cnDMz7j2C
95IJWkWC/n1X0m8l9NXNozCUHhgoLvASLXxSuU05B+Gpx0dyrl/+qPUC7pNRcE9Q
7fZKUQgPaG9bJCZzoKWtpA7aIkar0Kz7lCCZKIgk9VQ1zizyveBqMnDvwvy1y2Et
NXFfQILPfauJxpNIwPbq7cW0D/t5kExdJ/HON2DFFHVvnRmYcBExIuDkD1WzpVdc
qzITmnEYUr10qLcS27rOTafWfxVl4Wn4uhgY4QovzLQPeWK1Mw0=
=iwyB
-----END PGP SIGNATURE-----

--4ECF1u7dKBoUGhe3--
