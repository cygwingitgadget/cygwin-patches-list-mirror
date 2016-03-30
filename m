Return-Path: <cygwin-patches-return-8499-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92868 invoked by alias); 30 Mar 2016 11:24:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92789 invoked by uid 89); 30 Mar 2016 11:24:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=514,7, 5147, audio, 5027
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 30 Mar 2016 11:24:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5AFB1A80851; Wed, 30 Mar 2016 13:24:34 +0200 (CEST)
Date: Wed, 30 Mar 2016 11:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 06/11] Remove always true nonnull check on "this" pointer.
Message-ID: <20160330112434.GG3793@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-6-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-6-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00205.txt.bz2


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2572

Hi Peter,

On Mar 19 13:45, Peter Foley wrote:
> G++ 6.0 can assert that the this pointer is non-null for member functions.

Maybe, but if it compains, it's bound to find false positives...

> @@ -502,7 +502,7 @@ fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info=
 *p,
>  				       int rate, int bits, int channels)
>  {
>    p->fragstotal =3D MAX_BLOCKS;
> -  if (this && dev_)
> +  if (dev_)
>      {
>        /* If the device is running we use the internal values,
>  	 possibly set from the wave file. */

This is wrong.  fhandler_dev_dsp::Audio_out::buf_info is called from
fhandler_dev_dsp::_ioctl.  An application can call ioctl without
an open audio channel.  If so, audio_out_ may be NULL and the
Audio_out::buf_info method is called with a NULL this pointer..

> @@ -959,7 +959,7 @@ fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info =
*p,
>  {
>    p->fragstotal =3D MAX_BLOCKS;
>    p->fragsize =3D blockSize (rate, bits, channels);
> -  if (this && dev_)
> +  if (dev_)

Ditto.

>      {
>        p->fragments =3D Qisr2app_->query ();
>        if (pHdr_ !=3D NULL)
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 20391bf..df09d70 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -3937,7 +3937,7 @@ fcwd_access_t::Free (PVOID heap)
>  {
>    /* Decrement the reference count.  If it's down to 0, free
>       structure from heap. */
> -  if (this && InterlockedDecrement (&ReferenceCount ()) =3D=3D 0)
> +  if (InterlockedDecrement (&ReferenceCount ()) =3D=3D 0)

Very unlikely, but *fast_cwd_ptr *might be NULL.  Better save than sorry.

>      {
>        /* In contrast to pre-Vista, the handle on init is always a
>  	 fresh one and not the handle inherited from the parent
> diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
> index be32cfd..409a0b7 100644
> --- a/winsup/cygwin/pinfo.cc
> +++ b/winsup/cygwin/pinfo.cc
> @@ -514,7 +514,7 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
>  bool __reg1
>  _pinfo::exists ()
>  {
> -  return this && process_state && !(process_state & (PID_EXITED | PID_RE=
APED | PID_EXECED));
> +  return process_state && !(process_state & (PID_EXITED | PID_REAPED | P=
ID_EXECED));

Assuming a pinfo constructor called like this:

  pinfo p (non_existent_pid);

then p->_procinfo is NULL.  Calling p->exists then calls _pinfo::exists
with a NULL this pointer.  Analog for the other _pinfo methods.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW+7dyAAoJEPU2Bp2uRE+gkukP/27WWrQswnDCZPqdLW6IKz00
Gd1sD4a0s/63nw1a36Bi8nR3jMUSsG8BvcuwGQ7pNbfCnGMDRXfZ6o9M86B1+IJV
bhMpmdzpgSPrmr1MBV2hR7Z+dmb7zeysjcJjm3mw0AVGoGdjIoTPxu6+EMatrJzd
vA1gSL6a94PHRdHbHY+uUaeOD/1oWHnVMSsm5SVJmpug99y0n+tiN/6XLrzZ7+Y4
GMVNN01ITvv5C81p0AYwNAcJnBaCDL2aLmeYVSw3tIaxMy3CvUnqpDuS1fz56vIo
RMATrCFUvLkDKLu/hR8J9niZwO1apf/8gVOHL9+2GyBsi1JByncMMQGmqUzSuBxd
JBws+CrjK03qAmHnm38vE2UKIiyyQPkY3xILvNrkRbzyBl/VRHXYWBDbYZeO6zz4
zVZU+NlSEf2xD6VbAQ6/ld2gaFZRq7qRRGHtSXQe2x0Vlpu+BsJsclI1YrGodjNu
/Q4jY7+zozM/UNQUFTyKnn2asbb2DuVUPBPpOAaIhUn0FdbiK6H53soMPRUu1W1n
rko4fQHXC0WIJF2kBt4RsQovfdJCspeWcZviNZHXQMhC5AoL2ku4fbeo7jUhUAy3
ovx2p1F9Kb8Hxr0ewD9RFK3IGyQHLKIKoy3Ah6/w+1c7aXqXFcFYv6bPRQ3kjw/C
9DNzoWMQ9I8KY4oyFgNN
=+UEq
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
