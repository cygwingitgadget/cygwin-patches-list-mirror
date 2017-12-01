Return-Path: <cygwin-patches-return-8956-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52297 invoked by alias); 1 Dec 2017 09:37:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52287 invoked by uid 89); 1 Dec 2017 09:37:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-102.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*MI:sk:2017120, H*i:sk:2017120, H*f:sk:2017120, Ouch
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Dec 2017 09:37:58 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 443B7721BBD2E	for <cygwin-patches@cygwin.com>; Fri,  1 Dec 2017 10:37:55 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 515BD5E0291	for <cygwin-patches@cygwin.com>; Fri,  1 Dec 2017 10:37:52 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B6A64A81810; Fri,  1 Dec 2017 10:37:54 +0100 (CET)
Date: Fri, 01 Dec 2017 09:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171201093754.GB25276@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <20171130103440.GA14313@calimero.vinschen.de> <Pine.BSF.4.63.1712010030250.24559@m0.truegem.net> <20171201093007.GA25276@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20171201093007.GA25276@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00086.txt.bz2


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1842

On Dec  1 10:30, Corinna Vinschen wrote:
> On Dec  1 00:44, Mark Geisert wrote:
> > [...]
> > I'd better take this info back to "the lab" and do some more digging. T=
hanks
> > very much for these details and your earlier replies.  When I saw
> > FILE_SYNCHRONOUS_IO_NONALERT in your reply, I remembered that I'm not u=
sing
> > a Cygwin-supplied handle but rather a handle returned by Win32 CreateFi=
le().
> > Not only that, but using cygwin_attach_handle_to_fd() to get an fd to w=
ork
> > with.
>=20
> Ouch.
>=20
> > And then pwrite() creates its own handle (or reuses one (!)) to avoid
> > messing up the seek pointer of the fd passed in.
>=20
> Wait.  Not "re-use", but "re-open".  If you're more familiar with POSIX
> terms, this is along the lines of the fdopen(3) call, just on the NT
> API level.  There's an equivalent Win32 function since Windows 2003
> called ReOpenFile.
>=20
> In terms of pread/pwrite, the new handle shares the same settings with
> the original handle.  However, if you use cygwin_attach_handle_to_fd,
> there's a chance information got lost.  Nobody actually uses this call ;)
>=20
> In terms of FILE_SYNCHRONOUS_IO_NONALERT, this is stored in
> fhandler_base::options, utilizing the get_options/set_options methods.
> I have a hunch that cygwin_attach_handle_to_fd fails to call set_options,
> thus options is 0 when you call pwrite, thus the new handle is opened
> without FILE_SYNCHRONOUS_IO_NONALERT and all the other option flags
> we use by default.

It's more than a hunch.  Of course the info gets lost since=20
none of the functions called by cygwin_attach_handle_to_fd calls
NtQueryInformationFile(FileModeInformation) to fetch the options.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaISLyAAoJEPU2Bp2uRE+gjGEP/jD5V3cXh5v1INVhoe+SuCnk
4VP5PSHOz6OSD/I5B0hkB66/P7PT+iseyDXqAtRuth6dnqMmgBZZfnNYfAEuYX3L
Pbk+qlTXx83emKPCLV4VXAcHBXGO+xh2a9UkMue6CN75KtNahGiFys7KxubtF7a8
P+R9pKoBv7yNae66P+hgjMQIL17Z8eHvA19qP06uvba1Le1Wb9O1vVbzfKP2tb7y
VNpOoeHHvH9Fq83DL2Bu0jhKTogoa44n0Y9I7YNqMCprpFNSceAsiHXcUCK7bXvz
kRJrEYvSzoZoYm+GLM1/DXeK1SPoO36c/CpcRNhvRb/JUmFbj5yFVD4BR0HdIM06
tMmC0FZInyzi283dXsDXK8sW7BUfdNCzQpeCV/SdBUVe7KtjiUCEMfqHcKYM0pxR
kEVn/3MICD3+gcvLMOk1p8TmdvxTNtxJznSHHfwQDrUx6n6dMp8qPjLl2ikDvOqJ
sFVRLB7mFTTJVXkGwK3kZKTxt43VpKGRGmKAaJi3zJdgOGSpoPJFVCRYeDmzCDhe
lGjQabanebgDHV0/+7MMfQsId4L0nPQicX34IL2GoWosRHRGxoEj+ne7VsPSBg4E
sGFgfmeg7PKi93UprybwRGD41ARC6+UKdiS4mklNTCclZWbbm5UVCFspPVo+S7kr
wdkWv0sXeOlFxc0F/Asx
=yWda
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
