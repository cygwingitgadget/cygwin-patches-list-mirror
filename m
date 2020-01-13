Return-Path: <cygwin-patches-return-9926-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76868 invoked by alias); 13 Jan 2020 18:39:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76855 invoked by uid 89); 13 Jan 2020 18:39:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 18:39:56 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MHoAg-1iusVI0aJC-00Eush for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 19:39:54 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 712E6A80410; Mon, 13 Jan 2020 19:39:52 +0100 (CET)
Date: Mon, 13 Jan 2020 18:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Message-ID: <20200113183952.GS5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191229175637.1050-1-kbrown@cornell.edu> <20200113152809.GE5858@calimero.vinschen.de> <9f83d272-2dad-f652-d0c8-f3eb3b425ac2@cornell.edu> <20200113183430.GR5858@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="31zvzas5NXT9fief"
Content-Disposition: inline
In-Reply-To: <20200113183430.GR5858@calimero.vinschen.de>
X-SW-Source: 2020-q1/txt/msg00032.txt


--31zvzas5NXT9fief
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2983

On Jan 13 19:34, Corinna Vinschen wrote:
> On Jan 13 16:53, Ken Brown wrote:
> > On 1/13/2020 10:28 AM, Corinna Vinschen wrote:
> > > On Dec 29 17:56, Ken Brown wrote:
> > >> [...]
> > >> Note: The man page mentions fchownat and linkat also.  linkat already
> > >> supports the AT_EMPTY_PATH flag, so nothing needs to be done.  But I
> > >> don't understand how this could work for fchownat, because fchown
> > >> fails with EBADF if its fd argument was opened with O_PATH.  So I
> > >> haven't touched fchownat.
> > >=20
> > > It was never supposed to work that way.  We can make fchownat work
> > > with AT_EMPTY_PATH, but using it on a file opened with O_PATH
> > > contradicts the Linux open(2) man page, afaics:
> > >=20
> > >   O_PATH (since Linux 2.6.39)
> > >    Obtain a file descriptor that can be used for two  purposes:  to
> > >    indicate a location in the filesystem tree and to perform opera=E2=
=80=90
> > >    tions that act purely at the file descriptor  level.   The  file
> > >    itself  is not opened, and other file operations (e.g., read(2),
> > >    write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2), mmap(2))
> > >                         ^^^^^^^^^
> > >    fail with the error EBADF.
> > >    ^^^^^^^^^           ^^^^^
> > >=20
> > > That'd from the current F31 man pages.
> > >=20
> > >> Am I missing something?
> > >=20
> > > Good question.  Let me ask in return, did *I* now miss something?
> >=20
> > I don't think so.  I think we agree, although maybe I didn't express my=
self=20
> > clearly enough for that to be obvious.  What confused me was the follow=
ing=20
> > paragraph further down in the open(2) man page (still discussing O_PATH=
):
> >=20
> >    If pathname is a symbolic link and the O_NOFOLLOW flag is also
> >    specified, then the call returns a file descriptor referring
> >    to the symbolic link.  This file descriptor can be used as the
> >    dirfd argument in calls to fchownat(2), fstatat(2), linkat(2),
> >                               ^^^^^^^^^^^
> >    and readlinkat(2) with an empty pathname to have the calls
> >    operate on the symbolic link.
>=20
> That's the part I missed, apparently.  Implementing fchownat like this
> may be a bit upside down.  The problem is that open(O_PATH) opens the
> file with query_read_attributes (aka READ_CONTROL | FILE_READ_ATTRIBUTES),
> to make sure the calls mentioned in the snippet I pasted don't succeed.=
=20=20
>=20
> If fchownat is supposed to work on a symlink like this, the easiest
> approach may be checking for this scenario in fchownat and calling
> lchown on the pathname instead.  Or something along these lines.

The alternative would be to open the sylink with more permissions, i.e.,
query_write_control, aka READ_CONTROL | WRITE_OWNER | WRITE_DAC |
FILE_WRITE_ATTRIBUTES.  I'm just hesitant to open up the descriptor
like this.  It probably allows too many actions on the descriptor
from user space...


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--31zvzas5NXT9fief
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4cuXgACgkQ9TYGna5E
T6DeKw//V9mRYrZkFSBnBvXJRhpC74w86iFiDVOrdSu/AL+KsA8Xh/mEi7ixWyVb
fnp6LbyNM8IRU5MaNIXHsMnRwGPtNarpCJkf0MT2e41D3MF4zvf0pDQhIUHd9z5Y
THfGbTj9NDmmUXyPCX9cA180OkR0ZdIZ3UhcCpno8ClxiEmfKtwepqAeuWi5FjEB
vUoxy+3tsl5J3hTg5UA+kRcoL5Bc2isVTxLWuZC/3heGX9I7/b7hm/ee8xXQHmZu
j2qJYYniyrWdC+xTjD8pLOIX3YukH2x7sSZQ5JXTVBO0KUB6xX3iJOIjA0S4FNAX
dr7TA4CNDPeX3fmvNdkBQoEBBwKVlYoXLP2p3x/NOOVX1xDgXj2kGFIoF8MXlHoL
uzWjR9C1OTILR7e3ptNkYWoU9RoZx8sDeL0EpLhGcPWJrcPmkhDEMaFAxDonymP2
eAjsCGgDR4YMfd1bBq6DcJ7rKXfZEQMKNaj8ad3acXdOawPNQoPKygrRXC6bH+x3
NiFRsVI+5QUPCOUTkjPeakHxifVmo5qDZM6cwZc/eGLZGbhlVtYmHHF0UsThFBsP
bsHa0/yvk0bTUptcpwQEDw054jchwoXApx4rlN9LJreup0f+flYS9fpC0ZRisI/G
SCCJQGhqWM9TdQTNWAfm1fVK2yv3/on8vzyZ7r6LZGhf2y/0VE8=
=vTBg
-----END PGP SIGNATURE-----

--31zvzas5NXT9fief--
