Return-Path: <cygwin-patches-return-9475-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8218 invoked by alias); 27 Jun 2019 07:13:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7941 invoked by uid 89); 27 Jun 2019 07:13:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 27 Jun 2019 07:13:08 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MplPh-1iLTaO2Fu1-00qAM0 for <cygwin-patches@cygwin.com>; Thu, 27 Jun 2019 09:13:05 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 36201A807DB; Thu, 27 Jun 2019 09:13:05 +0200 (CEST)
Date: Thu, 27 Jun 2019 07:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: Fix return value of sched_getaffinity
Message-ID: <20190627071305.GB5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190626091641.GS5738@calimero.vinschen.de> <20190626094456.57224-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="aQ0PHH3iiKbaMI5N"
Content-Disposition: inline
In-Reply-To: <20190626094456.57224-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00182.txt.bz2


--aQ0PHH3iiKbaMI5N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 546

On Jun 26 02:44, Mark Geisert wrote:
> Have sched_getaffinity() interface like glibc's, and provide an
> undocumented internal interface __sched_getaffinity_sys() like the Linux
> kernel's sched_getaffinity() for benefit of taskset(1).

I put this patch on hold until the problems with using the
RTEMS headers are fixed.  Basically the patch is fine, but
*if* we introduce our own headers, it might be a good idea
to move the definition of __sched_getaffinity_sys into our
own headers.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--aQ0PHH3iiKbaMI5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0UbIEACgkQ9TYGna5E
T6B6/w//fzW6RwsXy780tyvl7S5V6+Zkavo7Dzy7UHY6cCKDL4+IHpm4hYCyZYiq
vMApr2EZ4VNQsWE2eY8dGlcNkRtm7wk2ZxYiwETUR8/IAFRudMxinHbsPOWw0aQ3
lLlTUst9qi2Lqzkd6gdG847j8dYIrDgcyZF93S9KdJ+hceV8VGCposRwk5pZj4/9
2ynYONUx45mlm40OwqipgyN2c+Ki55K4NEfFxRYpg8Rw5i5RRtQWliwRz+R/w8MN
vdaFSbvq+Zl1ayOJ2V/Z3Pj2huJNIYOGiZ6M2GZOWLwuaptulR/Db1RGTcFYtmSo
A8QygLDXpUULxozNENhgf05WLU7FypNeoGyzUhWrcNHT3LVd39ZojCJ+dKc85zBK
0SC7PieCn+C2JaAXWeGuJskOkYN6B/ZB7bBTItzEf0KCrW7aH4lij8mg+0UvGFlN
f0hqyxAHilXWB3spGBhVeV+633v2EJdt9ZXWv91loVaGAPdtWwVsbZk8FInag4p8
2wXUeZdppEmHso9fnLK2o/c8k8F7ATVK6ygbuyV2/u0KIMwY+BMhWyReufqZyxqf
J2+z7NgpH52HjmnSedn8r8g/J61LONfa/SS8KgT+Ppy5mNOauD9lAny+FvMP4/QE
SBSXfZRfdkL6VaY6tfp90FHNEQFdCSHt65H3+NCeFhdXIs3NTW4=
=ByiM
-----END PGP SIGNATURE-----

--aQ0PHH3iiKbaMI5N--
