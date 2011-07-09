Return-Path: <cygwin-patches-return-7424-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29980 invoked by alias); 9 Jul 2011 13:19:56 -0000
Received: (qmail 29967 invoked by uid 22791); 9 Jul 2011 13:19:54 -0000
X-SWARE-Spam-Status: No, hits=-6.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jul 2011 13:19:37 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p69DJaGP000445	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Sat, 9 Jul 2011 09:19:36 -0400
Received: from [10.3.113.151] (ovpn-113-151.phx2.redhat.com [10.3.113.151])	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p69DJanE002783	for <cygwin-patches@cygwin.com>; Sat, 9 Jul 2011 09:19:36 -0400
Message-ID: <4E185567.2090001@redhat.com>
Date: Sat, 09 Jul 2011 13:19:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: pthread_sigmask bug
References: <4E178FD6.5010101@redhat.com> <20110709065855.GB29867@calimero.vinschen.de>
In-Reply-To: <20110709065855.GB29867@calimero.vinschen.de>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig6A4101428ECFE4948E820ED8"
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
X-SW-Source: 2011-q3/txt/msg00000.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A4101428ECFE4948E820ED8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1518

On 07/09/2011 12:58 AM, Corinna Vinschen wrote:
> On Jul  8 17:16, Eric Blake wrote:
>> The current implementation of pthread_sigmask violates POSIX:
>=20
> PTC?

 winsup/cygwin/ChangeLog |    6 ++++++
 winsup/cygwin/signal.cc |   10 ++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

2011-07-09  Eric Blake  <eblake@redhat.com>

	* signal.cc (handle_sigprocmask): Return error rather than
	setting errno, for pthread_sigmask.
	(sigprocmask): Adjust caller.

diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index 9c920d0..4c472fd 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -174,7 +174,10 @@ usleep (useconds_t useconds)
 extern "C" int
 sigprocmask (int how, const sigset_t *set, sigset_t *oldset)
 {
-  return handle_sigprocmask (how, set, oldset, _my_tls.sigmask);
+  int res =3D handle_sigprocmask (how, set, oldset, _my_tls.sigmask);
+  if (res)
+    set_errno (res);
+  return res ? -1 : 0;
 }

 int __stdcall
@@ -184,13 +187,12 @@ handle_sigprocmask (int how, const sigset_t *set,
sigset_t *oldset, sigset_t& op
   if (how !=3D SIG_BLOCK && how !=3D SIG_UNBLOCK && how !=3D SIG_SETMASK)
     {
       syscall_printf ("Invalid how value %d", how);
-      set_errno (EINVAL);
-      return -1;
+      return EINVAL;
     }

   myfault efault;
   if (efault.faulted (EFAULT))
-    return -1;
+    return EFAULT;

   if (oldset)
     *oldset =3D opmask;

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig6A4101428ECFE4948E820ED8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJOGFVoAAoJEKeha0olJ0NqV5MH/0Eqv6+4X+/zD+TTCr31tAAT
VQyxN5HBrcXQbBNUIMbzCS+31nVKBzNARNFkq6tbkdvnZZXJzCtIsF/vz+7m1+LM
WSUR8DGUonzegChu20xsxhmdJYD4HYq3IOzy/2wkZfCG6SnbzlFnPGXxP+3cYX4t
Q+yqwipI1yOt4mTUJ3oJh4VECf88+EG5534JRmAkDTaFhzQQ5NfQM8qB9BIDGev6
jF98dQ70gon990fnMVpsSd6FAz2npSG3G9maDI/xZNmslZ8Fm0boQ06NGeUyXv1F
DyjNfFAQXZx4QngHw63nKb3MrFSemh0gOaYOCe07gIqRnWgcNt8tfWRB+iatqVw=
=Rno9
-----END PGP SIGNATURE-----

--------------enig6A4101428ECFE4948E820ED8--
