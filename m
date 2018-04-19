Return-Path: <cygwin-patches-return-9053-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123465 invoked by alias); 19 Apr 2018 12:11:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123452 invoked by uid 89); 19 Apr 2018 12:11:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Updates
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Apr 2018 12:11:14 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MHYWy-1f82TL1eYu-003LO2 for <cygwin-patches@cygwin.com>; Thu, 19 Apr 2018 14:11:11 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 002E3A81EE7; Thu, 19 Apr 2018 14:11:09 +0200 (CEST)
Date: Thu, 19 Apr 2018 12:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] Posix asynchronous I/O support: other files
Message-ID: <20180419121109.GN15911@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180419080402.10932-1-mark@maxrnd.com> <20180419080402.10932-4-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
In-Reply-To: <20180419080402.10932-4-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:x0j+PaziaIM=:Gb/VXJJ3c8ceUgIzwQjkM7 fMEMoOb0KrRKZmZhNVYirEXd2o0lLnI+fw00BudGiUzb3jb6rdzSlllsuMAWAQ0omkx7w2BMt RRIJ4qVlkOdrvhUP+PZuc3OZ4dv3gTvsWh0B9QSDIriQgg7PYCFyVMWIkGCbG2sQWd68msp9K iLJkuqcN5mbm1VeUHpYk4QH7DmE5Cup4cLaNBT2Qpc3SzP28etmG7lm7nKDDS2risA8q22gkB eiidkhwAm3rRoVExKniArJ3ppk8XirfwdVT9X/RarjGcmIyGzTvAmgq5shALvtlZme9Am0lTk MfY3X9/DienirpwA3rSNdEFff2c+p5JT2DRI9PA3i5DvCyujGZF5R8g+Er8susuBh7Uez0oJt KOO1Swx4LsHbXlCHSUN7zZYDpY3WlEbHKi6B36TEBamFFbwt5lBwlfLj+ETukefG3+5MFkWIy +AZ6J6nt7moC+XkOxpABxT3uA3+Rz3/i6/82C9k+BIez5h4b28DYTf/iD8S8ZUIRrhoq0Rt52 vNufw2VYB7l3cGEJ3RyfGBfauj/nEXmhXMy7H/qoVnCkQwWv0pgxLA3+I9gYxiKqtFZSc2qdN R8CsXXwhsCQusLmYcopSJg5mxMcei33qUcJAFNVQ272loYMWRYXAopa29ySh6GoOnsQhUYvON ztxbkaJvRWukGjoM5vz43DeW2PhxcivaAUiTLFgp5E/LFQzcvMp3vPlq5mPoFE1V6bWJ1hLsk +cv3U148FuPTX7xuG9zxL6cOB/t2HGEhNk52fw==
X-SW-Source: 2018-q2/txt/msg00010.txt.bz2


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3333

On Apr 19 01:04, Mark Geisert wrote:
> Updates to misc files to integrate AIO into the Cygwin source tree.
> Much of it has to be done when adding any new syscalls.  There are
> some updates to limits.h for AIO-specific limits.  And some doc mods.
>=20
> This is the 2nd WIP patch set for AIO.  The string XXX marks issues
> I'm specifically requesting comments on, but feel free to comment or
> suggest changes on any of this code.

A few notes:


> ---
>  winsup/cygwin/Makefile.in              |  1 +
>  winsup/cygwin/common.din               |  8 ++++++++
>  winsup/cygwin/include/cygwin/version.h |  4 +++-
>  winsup/cygwin/include/limits.h         | 12 ++++++------
>  winsup/cygwin/thread.cc                |  4 ++--
>  winsup/doc/posix.xml                   | 16 ++++++++--------
>  6 files changed, 28 insertions(+), 17 deletions(-)
> [...]
> diff --git a/winsup/cygwin/include/limits.h b/winsup/cygwin/include/limit=
s.h
> index fe1b8b493..b52ca11f2 100644
> --- a/winsup/cygwin/include/limits.h
> +++ b/winsup/cygwin/include/limits.h
> @@ -147,7 +147,7 @@ details. */
>=20=20
>  /* Runtime Invariant Values */
>=20=20
> -/* Please note that symbolic names shall be ommited, on specific
> +/* Please note that symbolic names shall be omitted, on specific
>     implementations where the corresponding value is equal to or greater
>     than the stated minimum, but is unspecified.  This indetermination
>     might depend on the amount of available memory space on a specific
> @@ -155,17 +155,17 @@ details. */
>     a specific instance shall be provided by the sysconf() function. */
>=20=20
>  /* Maximum number of I/O operations in a single list I/O call supported =
by
> -   the implementation.  Not yet implemented. */
> -#undef AIO_LISTIO_MAX
> +   the implementation. */
> +#define AIO_LISTIO_MAX 32
>  /* #define AIO_LISTIO_MAX >=3D _POSIX_AIO_LISTIO_MAX */
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   Please remove this comment, it's as outdated as the one preceeding the
   macro.

>  /* Maximum number of outstanding asynchronous I/O operations supported by
> -   the implementation.  Not yet implemented. */
> -#undef AIO_MAX
> +   the implementation. */
> +#define AIO_MAX 8
>  /*  #define AIO_MAX >=3D _POSIX_AIO_MAX */
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   Ditto.

Btw., this isn't quite enough to be POSIX compliant.  You'll have to
fix the return value of sysconf(2) for _SC_AIO_LISTIO_MAX and
_SC_AIO_MAX as well.

>  /* The maximum amount by which a process can decrease its asynchronous I=
/O
> -   priority level from its own scheduling priority. */
> +   priority level from its own scheduling priority. Not yet implemented.=
 */
>  #undef AIO_PRIO_DELTA_MAX
>  /* #define AIO_PRIO_DELTA_MAX >=3D 0 */

Wouldn't it make sense to set AIO_PRIO_DELTA_MAX (_SC_AIO_PRIO_DELTA_MAX)
to 0 now?  As soon as aio is implemented, we have a aio_reqprio field
and that may be filled with some value.  The value is supposed to be
between 0 and AIO_PRIO_DELTA_MAX.  Given there's no POSIX requirement
for a minimum value, 0 is as much valid as any value > 0.

This could be revisited later, if we ever allow different prios.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlrYh10ACgkQ9TYGna5E
T6BBKg//RuIhNH21zooVX9eaqC7NIRCU9MC5YKf9dokNusZfXdg6RKln0bCKtNDw
wLMpaCOzfLebEbtn6a1w8Qyipr6RFJSsF42lY7o4odycFL5A/fG4ZcbFyxGwac8M
lcF4n6aV+Doaqr5pt4eVL0UopeYxgcGHMeltFcpJyp+nxXU5cW5FscKFv+WRPDGg
TPM+Bw4/53gG/+kK27VmP+zz582QQI+iKSxuUgH80r/7CQSoL0ugQvU0rJx0fhVI
Daah4DipfBHEaUV1uN/dQt71ILsxFsBr6mC7BlmAl3978DARWKb/Hf9maboj8CM8
8jD9RH9JR/nPIJF1Oi6lAXYXuLo6E+lKUbU12AHMfBhHfSgUW57cUqy+97vpEbTV
2cxskqsqvAt24mBPVRjsWOLCxGogJkh4LebH0u3aGVe/Wr0E3zhc5981RtxLjD8+
IKpcMe9YL4oOLAKJ+LrLyYotZdpRoJIY3fJk6xfG9ZBpdE80QPhzkmZQ3TevEW9l
hyo2OPdGQwen3jQ5BF6t7G0EPk00eUiUI01qD2dO92dRw5XJ5yxH8rCdHVRsGdxV
ETvbkXvw/A4TFIDRcPYRIv0hveRn3La5cDWf2SNqdwJW4jB9NsklS7IoVFy1Vnfh
ladJpkTYMZfEfpmqwvjmlmYU0U7LWgq9x0f3zjparOa9cF4F/NY=
=T3Qd
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
