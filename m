Return-Path: <cygwin-patches-return-7903-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6242 invoked by alias); 25 Sep 2013 23:26:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6226 invoked by uid 89); 25 Sep 2013 23:26:29 -0000
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Sep 2013 23:26:29 +0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPAM_SUBJECT autolearn=no version=3.3.2
X-HELO: mx1.redhat.com
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8PNQQrU020703	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Wed, 25 Sep 2013 19:26:26 -0400
Received: from [10.3.113.164] (ovpn-113-164.phx2.redhat.com [10.3.113.164])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r8PNQPLo006665	for <cygwin-patches@cygwin.com>; Wed, 25 Sep 2013 19:26:26 -0400
Message-ID: <52437121.1070507@redhat.com>
Date: Wed, 25 Sep 2013 23:26:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: fix off-by-one in dup2
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="oSJlRaGVc8KdwdI5AJM9kl14RFhK4MLJD"
X-IsSubscribed: yes
X-SW-Source: 2013-q3/txt/msg00010.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oSJlRaGVc8KdwdI5AJM9kl14RFhK4MLJD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 3040

Solves the segfault here: http://cygwin.com/ml/cygwin/2013-09/msg00397.html
but does not address the fact that we are still screwy with regards to
rlimit.

=3D=3D=3D=3D=3D=3D
Ultimately, based on my understanding of POSIX and glibc, my goal is to
have a number of changes (this patch only scratches the surface; there's
more to go):

dtable.h tracks soft and hard limits, inherited over fork and preserved
across exec

hard limit starts at OPEN_MAX_MAX and can only be reduced
soft limit starts at hard limit, and can be reduced to _POSIX_OPEN_MAX (8)
dtable.size starts at MAX(32, fork/exec size)

getdtablesize() and sysconf(_SC_OPEN_MAX) always returns the soft limit,
as in glibc and permitted by POSIX (_SC_OPEN_MAX is the only sysconf
variable that can be runtime dynamic)

dtable.size is decoupled from soft limit, and is guaranteed to be <=3D
hard limit.  It can grow up to current soft limit; but soft limit can
later be reduced lower than dtable.size (glibc does this); on fork and
exec, we are careful to still allow fds beyond the current soft limit.

getrlimit(RLIMIT_NOFILE, &r) =3D> returns soft and hard limits from dtable
rather than hard limit as a constant and soft limit as current dtable.size

setrlimit(RLIMIT_NOFILE, &r) =3D> cannot set hard limit to unlimited; soft
limit of unlimited is translated to current hard limit; hard limit
cannot be increased (EPERM) or reduced below dtable.size (EINVAL); soft
limit can be reduced arbitrarily (including below OPEN_MAX of 256)

setdtablesize() =3D> guarantees that dtable.size is at least that large
(must be <=3D soft limit), but does not lower dtable.size or change limits
=3D=3D=3D=3D=3D

2013-09-25  Eric Blake  <eblake@redhat.com>

	dup2: fix off-by-one crash
	* dtable.cc (dup3): Fix off-by-one.
	(find_unused_handle): Reduce time spent expanding during dup.
	* syscalls.cc (setdtablesize): Report error on invalid value.

diff --git i/winsup/cygwin/dtable.cc w/winsup/cygwin/dtable.cc
index 2501a26..c2982a8 100644
--- i/winsup/cygwin/dtable.cc
+++ w/winsup/cygwin/dtable.cc
@@ -233,7 +233,7 @@ dtable::find_unused_handle (int start)
 	if (fds[i] =3D=3D NULL)
 	  return i;
     }
-  while (extend (NOFILE_INCR));
+  while (extend (MAX (NOFILE_INCR, start - size)));
   return -1;
 }

@@ -754,7 +754,7 @@ dtable::dup3 (int oldfd, int newfd, int flags)

   if (!not_open (newfd))
     close (newfd);
-  else if ((size_t) newfd > size
+  else if ((size_t) newfd >=3D size
 	   && find_unused_handle (newfd) < 0)
     /* couldn't extend fdtab */
     {
diff --git i/winsup/cygwin/syscalls.cc w/winsup/cygwin/syscalls.cc
index e1886e6..8c1c70a 100644
--- i/winsup/cygwin/syscalls.cc
+++ w/winsup/cygwin/syscalls.cc
@@ -2578,6 +2578,9 @@ system (const char *cmdstring)
 extern "C" int
 setdtablesize (int size)
 {
+  if (size < 0)
+    return -1;
+
   if (size <=3D (int)cygheap->fdtab.size || cygheap->fdtab.extend (size -
cygheap->fdtab.size))
     return 0;

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oSJlRaGVc8KdwdI5AJM9kl14RFhK4MLJD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 621

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSQ3EhAAoJEKeha0olJ0NqkkgH/34mzNfnTCsDuZhY1vsSbi90
q/fHG/UcaVPo+vQ8Ex1yy1uTqbml2jAU17yK9b1Fg2BYT+xpdlrnvCFed//csXiA
lxKCGRjuIFnYDG9Hm7JoeJqfYuE9BZZNki7dXG8fGUccnyXaXfGQB8qZ2ThnDshp
wkiyqBO/xap/Xq88m4l+9piFQ+Ju7mIfvfjSc2msBVtZh9IP1GKTY33Ixfcd+ioW
U1imIG24LY7HnlQYK65MdvId27i/KhArcBB747eEf+TnfruKbqjvMvVUg4cXoqiM
G79KZrcHF0mPqDvLUr+GdQaoq86nugPi9x4O2g+je++49Wf5pFaiXT1U3rWviR0=
=l95y
-----END PGP SIGNATURE-----

--oSJlRaGVc8KdwdI5AJM9kl14RFhK4MLJD--
