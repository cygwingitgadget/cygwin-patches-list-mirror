Return-Path: <cygwin-patches-return-7020-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17847 invoked by alias); 27 Apr 2010 15:18:10 -0000
Received: (qmail 17828 invoked by uid 22791); 27 Apr 2010 15:18:08 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_FAIL,TW_CG,T_FRT_SLUT
X-Spam-Check-By: sourceware.org
Received: from qmta01.emeryville.ca.mail.comcast.net (HELO qmta01.emeryville.ca.mail.comcast.net) (76.96.30.16)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 27 Apr 2010 15:18:04 +0000
Received: from omta19.emeryville.ca.mail.comcast.net ([76.96.30.76]) 	by qmta01.emeryville.ca.mail.comcast.net with comcast 	id AcZQ1e0071eYJf8A1fJ3gY; Tue, 27 Apr 2010 15:18:03 +0000
Received: from [192.168.0.5] ([98.202.176.54]) 	by omta19.emeryville.ca.mail.comcast.net with comcast 	id AfJ11e00E1Anwcq01fJ2Jc; Tue, 27 Apr 2010 15:18:03 +0000
Message-ID: <4BD7001C.8080303@redhat.com>
Date: Tue, 27 Apr 2010 15:18:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: work around gcc bug in signal.h
Content-Type: multipart/signed; micalg=pgp-sha1;  protocol="application/pgp-signature";  boundary="------------enigF533DA74E8F6FB1348605F3D"
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
X-SW-Source: 2010-q2/txt/msg00003.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF533DA74E8F6FB1348605F3D
Content-Type: multipart/mixed;
 boundary="------------010301070105000307030608"

This is a multi-part message in MIME format.
--------------010301070105000307030608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 824

I had already written this patch, and was in the process of testing it,
before cgf voted it down.  I'm still posting it for the record, as it
would allow us to be source-compatible with Linux while we wait for the
gcc bug to be fixed.

For that matter, even if this patch is not applied, we might still want to
consider simplifying things in siginfo_t - an anonymous union containing a
single anonymous struct containing a single anonymous union seems
wasteful, and we can prune two of those scopes whether or not we also name
the outer union.

2010-04-27  Eric Blake  <eblake@redhat.com>

	* include/cygwin/signal.h (siginfo_t, sigaction): Work around gcc
	bug with member initialization of anonymous union members.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org

--------------010301070105000307030608
Content-Type: text/plain;
 name="cygwin.patch36"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="cygwin.patch36"
Content-length: 3119

---
 winsup/cygwin/ChangeLog               |    5 +++
 winsup/cygwin/include/cygwin/signal.h |   62 ++++++++++++++++++-----------=
---
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/=
cygwin/signal.h
index 25d501d..4fcfd33 100644
--- a/winsup/cygwin/include/cygwin/signal.h
+++ b/winsup/cygwin/include/cygwin/signal.h
@@ -1,6 +1,6 @@
 /* signal.h

-  Copyright 2004, 2005, 2006 Red Hat, Inc.
+  Copyright 2004, 2005, 2006, 2010 Red Hat, Inc.

   This file is part of Cygwin.

@@ -97,40 +97,46 @@ typedef struct
   uid_t si_uid;				/* sender's uid */
   int si_errno;				/* errno associated with signal */

-  __extension__ union
+  /* GCC bug 10676: we must use macros instead of anonymous unions,
+     to allow member initialization syntax to work.  */
+  union
   {
     __uint32_t __pad[32];		/* plan for future growth */
-    struct _sigcommune _si_commune;	/* cygwin ipc */
-    __extension__ union
+    struct _sigcommune __si_commune;	/* cygwin ipc */
+    union
     {
       /* timers */
       struct
       {
-	union
-	{
-	  struct
-	  {
-	    timer_t si_tid;		/* timer id */
-	    unsigned int si_overrun;	/* overrun count */
-	  };
-	  sigval_t si_sigval;		/* signal value */
-	  sigval_t si_value;		/* signal value */
-	};
-      };
-    };
+	timer_t __si_tid;		/* timer id */
+	unsigned int __si_overrun;	/* overrun count */
+      } __timer;
+      sigval_t __si_sigval;		/* signal value */
+      sigval_t __si_value;		/* signal value */
+    } __value;

     /* SIGCHLD */
-    __extension__ struct
+    struct
     {
-      int si_status;			/* exit code */
-      clock_t si_utime;			/* user time */
-      clock_t si_stime;			/* system time */
-    };
+      int __si_status;			/* exit code */
+      clock_t __si_utime;		/* user time */
+      clock_t __si_stime;		/* system time */
+    } __child;

     /* core dumping signals */
-    void *si_addr;			/* faulting address */
-  };
+    void *__si_addr;			/* faulting address */
+  } __si;
 } siginfo_t;
+#define _si_commune	__si.__si_commune
+#define si_tid		__si.__value.__timer.__si_tid
+#define si_overrun	__si.__value.__timer.__si_overrun
+#define si_sigval	__si.__value.__si_sigval
+#define si_value	__si.__value.__si_value
+#define si_status	__si.__child.__si_status
+#define si_utime	__si.__child.__si_utime
+#define si_stime	__si.__child.__si_stime
+#define si_addr		__si.__si_addr
+
 #pragma pack(pop)

 enum
@@ -194,14 +200,16 @@ typedef void (*_sig_func_ptr)(int);

 struct sigaction
 {
-  __extension__ union
+  union
   {
-    _sig_func_ptr sa_handler;  		/* SIG_DFL, SIG_IGN, or pointer to a func=
tion */
-    void  (*sa_sigaction) ( int, siginfo_t *, void * );
-  };
+    _sig_func_ptr __sa_handler;  		/* SIG_DFL, SIG_IGN, or pointer to a fu=
nction */
+    void  (*__sa_sigaction) ( int, siginfo_t *, void * );
+  } __sa;
   sigset_t sa_mask;
   int sa_flags;
 };
+#define sa_handler	__sa.__sa_handler
+#define sa_sigaction	__sa.__sa_sigaction

 #define SA_NOCLDSTOP 1   		/* Do not generate SIGCHLD when children
 					   stop */
--=20
1.7.0.4


--------------010301070105000307030608--

--------------enigF533DA74E8F6FB1348605F3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 320

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkvXACkACgkQ84KuGfSFAYCYXQCfZnp7H9/j0+hJZbxehCY6YgE3
1aAAn00KXfG66nhPSDGZadSMp3eACrTi
=gyyz
-----END PGP SIGNATURE-----

--------------enigF533DA74E8F6FB1348605F3D--
