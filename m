Return-Path: <cygwin-patches-return-6909-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31322 invoked by alias); 14 Jan 2010 13:11:55 -0000
Received: (qmail 31220 invoked by uid 22791); 14 Jan 2010 13:11:54 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta05.emeryville.ca.mail.comcast.net (HELO qmta05.emeryville.ca.mail.comcast.net) (76.96.30.48)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 13:11:40 +0000
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71]) 	by qmta05.emeryville.ca.mail.comcast.net with comcast 	id VRAw1d0091Y3wxoA5RBf48; Thu, 14 Jan 2010 13:11:39 +0000
Received: from [192.168.0.106] ([24.10.244.244]) 	by omta15.emeryville.ca.mail.comcast.net with comcast 	id VRBd1d0085H651C8bRBeEg; Thu, 14 Jan 2010 13:11:39 +0000
Message-ID: <4B4F1805.9000806@byu.net>
Date: Thu, 14 Jan 2010 13:11:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net> <20100114102557.GB3428@calimero.vinschen.de>
In-Reply-To: <20100114102557.GB3428@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1;  protocol="application/pgp-signature";  boundary="------------enig7F51EE0C40A56783776E0015"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00025.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F51EE0C40A56783776E0015
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 2833

According to Corinna Vinschen on 1/14/2010 3:25 AM:
>>> +	  if (flags & O_CLOEXEC)
>>> +	    newfh->set_close_on_exec (true);
>> Is that a typo?
>>
>>> +	  else
>>> +	    newfh->close_on_exec (false);
>> If not, why not just newfh->close_on_exec (!!(flags & O_CLOEXEC)), inste=
ad
>> of the if-else?
>=20
> There's a difference.  set_close_on_exec() calls SetHandleInformation()
> via one or more intermediate calls to fhandler_base::set_no_inheritance().
> close_on_exec() only sets the flag in the fhandler status flags.  The
> if-else avoids two or more unnecessary function calls in the dup/dup2 cas=
e.

Is there a window here where a newly created HANDLE is inheritable even
though it will later be marked cloexec?  The whole point of O_CLOEXEC in
POSIX is that the action is atomic, and that no other thread can ever win
the race to leak the handle into an exec'd child process.  Which implies
that anywhere possible, we should be requesting noinherit as part of
creating the HANDLE, rather than changing it after the fact.  Most of your
patch appeared to be doing that (with the sec_none_nih vs. sec_none
conditionals), but calling set_close_on_exec seems like it is too late.

>>                 (cmd =3D=3D F_DUPFD_CLOEXEC) * O_CLOEXEC);
>=20
> Ouch, no, thanks.  I'd rather ?: it.

No problem - that's just style, and a good compiler will (hopefully) emit
the same code for that.

>> According to spec, Linux dup3(-1,-1,0) can fail with either EBADF or
>> EINVAL; I haven't tested that on Linux yet, but am assuming that your
>> choice of EBADF for this condition was intentional?
>=20
> Erm... EINVAL, and yes, it was intentional, per the Linux man page:
>=20
>   ERRORS
>     [...]
>     EINVAL (dup3()) flags contain an invalid value.  Or, oldfd was equal =
to
> 	   newfd.

The Linux man page did not give a preference between EINVAL and EBADF.
dup3(-1,-1,0) and dup3(1000000,1000000,0) are instances where both errors
are equally applicable to the situation, but EINVAL is probably less
computing power to determine.  But your code picked different errnos for
the two cases.  Unfortunately, the gnulib unit test that I posted did not
test those two conditions to see which errno Linux preferred (and whether
it was the same errno for both calls).  But since Linux is the only
platform with dup3, it would be nice to guarantee the same errno for both
of those calls.  I guess that means I should take some time to actually
compile a simple app on Linux to test that behavior.

> That's very easy to answer:  Because http://cygwin.com/acronyms/#SHTDI
> and I have only so much time.  I'm just trying to lay the groundwork
> here.  I'm not at all opposed to patches adding the still missing
> functionality.

Fair enough.

--=20
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net


--------------enig7F51EE0C40A56783776E0015
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 320

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAktPGAgACgkQ84KuGfSFAYB5GwCfajzi6XAqjhLBEoC21dbeOvoz
OR8An11DBRbpnNBW+nNBbx2k8OPrSDGg
=9kW9
-----END PGP SIGNATURE-----

--------------enig7F51EE0C40A56783776E0015--
