Return-Path: <cygwin-patches-return-4565-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11775 invoked by alias); 9 Feb 2004 01:46:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11667 invoked from network); 9 Feb 2004 01:46:29 -0000
Message-ID: <4026E66F.9030207@scytek.de>
Date: Mon, 09 Feb 2004 01:46:00 -0000
From: Volker Quetschke <quetschke@scytek.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: DEBUGGING guards in winsup/cygwin/exceptions.cc are missing
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7E792209994C7EB5959819AB"
X-SW-Source: 2004-q1/txt/msg00055.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E792209994C7EB5959819AB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1040

When compiling the cygwin dll from cvs, without --enable-debugging
the build fails in winsup/cygwin/exceptions.cc because console_printf
has no prototype defined without DEBUGGING set.

Something like the following fixes this:

diff -u -r1.201 exceptions.cc
--- src/winsup/cygwin/exceptions.cc	8 Feb 2004 19:59:27 -0000	1.201
+++ src/winsup/cygwin/exceptions.cc	9 Feb 2004 01:38:53 -0000
@@ -361,8 +361,11 @@
  	}
      }

+#ifdef DEBUGGING
    console_printf ("*** starting debugger for pid %u\n",
  		  cygwin_pid (GetCurrentProcessId ()));
+#endif
+
    BOOL dbg;
    dbg = CreateProcess (NULL,
  		       debugger_command,
@@ -387,8 +390,10 @@
        Sleep (2000);
      }

+#ifdef DEBUGGING
    console_printf ("*** continuing pid %u from debugger call (%d)\n",
  		  cygwin_pid (GetCurrentProcessId ()), dbg);
+#endif

    SetThreadPriority (GetCurrentThread (), prio);
    return dbg;

Volker

-- 
PGP/GPG key  (ID: 0x9F8A785D)  available  from  wwwkeys.de.pgp.net
key-fingerprint 550D F17E B082 A3E9 F913  9E53 3D35 C9BA 9F8A 785D

--------------enig7E792209994C7EB5959819AB
Content-Type: application/pgp-signature
Content-length: 254

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAJuZ1PTXJup+KeF0RAhYsAKC0LO6+zAqFRyQXzWCx/qMcnRHNlQCgwQCZ
YzlCxklgQALfo891qEmP1rc=
=+gEP
-----END PGP SIGNATURE-----

--------------enig7E792209994C7EB5959819AB--
