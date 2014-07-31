Return-Path: <cygwin-patches-return-8007-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25649 invoked by alias); 31 Jul 2014 16:07:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25630 invoked by uid 89); 31 Jul 2014 16:07:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 31 Jul 2014 16:07:45 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6VG7ivL026467	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2014 12:07:44 -0400
Received: from [10.3.113.61] (ovpn-113-61.phx2.redhat.com [10.3.113.61])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s6VG7h8X030260	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2014 12:07:43 -0400
Message-ID: <53DA69CF.3010201@redhat.com>
Date: Thu, 31 Jul 2014 16:07:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: namespace safety with attributes
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="XvjPqLkLuO8uvVKgN5EcTU0qc6XhAD9iA"
X-IsSubscribed: yes
X-SW-Source: 2014-q3/txt/msg00002.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XvjPqLkLuO8uvVKgN5EcTU0qc6XhAD9iA
Content-Type: multipart/mixed;
 boundary="------------070700070705060408030604"

This is a multi-part message in MIME format.
--------------070700070705060408030604
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 803

As pointed out here:
https://cygwin.com/ml/cygwin/2014-07/msg00371.html

any use of __attribute__ in a header that can be included by a user
should be namespace-safe, by decorating the attribute arguments with __
(while gcc does a lousy job at documenting it, ALL attributes have a __
counterpart, precisely so that public headers can use attributes without
risk of collision with macros belonging to user namespace).

2014-07-31  Eric Blake  <eblake@redhat.com>

	* include/pthread.h: Decorate attribute names with __, for
	namespace safety.
	* include/cygwin/core_dump.h: Likewise.
	* include/cygwin/cygwin_dll.h: Likewise.
	* include/sys/cygwin.h: Likewise.
	* include/sys/strace.h: Likewise.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org

--------------070700070705060408030604
Content-Type: text/x-patch;
 name="decorate.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="decorate.patch"
Content-length: 8157

Index: include/pthread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.41
diff -u -p -r1.41 pthread.h
--- include/pthread.h	16 Jul 2014 10:21:18 -0000	1.41
+++ include/pthread.h	31 Jul 2014 16:04:05 -0000
@@ -76,7 +76,7 @@ int pthread_attr_getschedpolicy (const p
 int pthread_attr_getscope (const pthread_attr_t *, int *);
 int pthread_attr_getstack (const pthread_attr_t *, void **, size_t *);
 int pthread_attr_getstackaddr (const pthread_attr_t *, void **)
-    __attribute__ ((deprecated));
+    __attribute__ ((__deprecated__));
 int pthread_attr_init (pthread_attr_t *);
 int pthread_attr_setdetachstate (pthread_attr_t *, int);
 int pthread_attr_setguardsize (pthread_attr_t *, size_t);
@@ -88,7 +88,7 @@ int pthread_attr_setscope (pthread_attr_
 #ifdef _POSIX_THREAD_ATTR_STACKADDR
 int pthread_attr_setstack (pthread_attr_t *, void *, size_t);
 int pthread_attr_setstackaddr (pthread_attr_t *, void *)
-    __attribute__ ((deprecated));
+    __attribute__ ((__deprecated__));
 #endif
=20
 #ifdef _POSIX_THREAD_ATTR_STACKSIZE
@@ -137,7 +137,7 @@ int pthread_create (pthread_t *, const p
 		    void *(*)(void *), void *);
 int pthread_detach (pthread_t);
 int pthread_equal (pthread_t, pthread_t);
-void pthread_exit (void *) __attribute__ ((noreturn));
+void pthread_exit (void *) __attribute__ ((__noreturn__));
 int pthread_getcpuclockid (pthread_t, clockid_t *);
 int pthread_getschedparam (pthread_t, int *, struct sched_param *);
 void *pthread_getspecific (pthread_key_t);
Index: include/cygwin/core_dump.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/core_dump.h,v
retrieving revision 1.2
diff -u -p -r1.2 core_dump.h
--- include/cygwin/core_dump.h	11 Sep 2001 20:01:01 -0000	1.2
+++ include/cygwin/core_dump.h	31 Jul 2014 16:04:05 -0000
@@ -1,6 +1,6 @@
 /* core_dump.h
=20
-   Copyright 1999, 2000, 2001 Red Hat, Inc.
+   Copyright 1999, 2000, 2001, 2014 Red Hat, Inc.
=20
    Written by Egor Duda <deo@logos-m.ru>
=20
@@ -27,7 +27,7 @@ struct win32_core_process_info
   char command_line[1];
 }
 #ifdef __GNUC__
-  __attribute__ ((packed))
+  __attribute__ ((__packed__))
 #endif
 ;
=20
@@ -38,7 +38,7 @@ struct win32_core_thread_info
   CONTEXT thread_context;
 }
 #ifdef __GNUC__
-  __attribute__ ((packed))
+  __attribute__ ((__packed__))
 #endif
 ;
=20
@@ -49,7 +49,7 @@ struct win32_core_module_info
   char module_name[1];
 }
 #ifdef __GNUC__
-  __attribute__ ((packed))
+  __attribute__ ((__packed__))
 #endif
 ;
=20
@@ -64,7 +64,7 @@ struct win32_pstatus
     } data ;
 }
 #ifdef __GNUC__
-  __attribute__ ((packed))
+  __attribute__ ((__packed__))
 #endif
 ;
=20
Index: include/cygwin/cygwin_dll.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/cygwin_dll.h,v
retrieving revision 1.12
diff -u -p -r1.12 cygwin_dll.h
--- include/cygwin/cygwin_dll.h	23 Apr 2013 09:44:35 -0000	1.12
+++ include/cygwin/cygwin_dll.h	31 Jul 2014 16:04:05 -0000
@@ -1,6 +1,6 @@
 /* cygwin_dll.h
=20
-   Copyright 1998, 1999, 2000, 2001, 2009, 2011, 2012, 2013 Red Hat, Inc.
+   Copyright 1998, 1999, 2000, 2001, 2009, 2011, 2012, 2013, 2014 Red Hat,=
 Inc.
=20
 This file is part of Cygwin.
=20
@@ -35,9 +35,9 @@ static DWORD storedReason;						      \
 static void* storedPtr;							      \
 int __dynamically_loaded;						      \
 									      \
-static int __dllMain (int a __attribute__ ((unused)),			      \
-		      char **b __attribute__ ((unused)),		      \
-		      char **c __attribute__ ((unused)))		      \
+static int __dllMain (int a __attribute__ ((__unused__)),		      \
+		      char **b __attribute__ ((__unused__)),		      \
+		      char **c __attribute__ ((__unused__)))		      \
 {									      \
   return Entry (storedHandle, storedReason, storedPtr);		              \
 }									      \
Index: include/sys/cygwin.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/include/sys/cygwin.h,v
retrieving revision 1.108
diff -u -p -r1.108 cygwin.h
--- include/sys/cygwin.h	15 May 2014 11:16:28 -0000	1.108
+++ include/sys/cygwin.h	31 Jul 2014 16:04:05 -0000
@@ -26,21 +26,21 @@ extern "C" {
 /* DEPRECATED INTERFACES.  These are restricted to MAX_PATH length.
    Don't use in modern applications.  They don't exist on x86_64. */
 extern int cygwin_win32_to_posix_path_list (const char *, char *)
-  __attribute__ ((deprecated));
+  __attribute__ ((__deprecated__));
 extern int cygwin_win32_to_posix_path_list_buf_size (const char *)
-  __attribute__ ((deprecated));
+  __attribute__ ((__deprecated__));
 extern int cygwin_posix_to_win32_path_list (const char *, char *)
-  __attribute__ ((deprecated));
+  __attribute__ ((__deprecated__));
 extern int cygwin_posix_to_win32_path_list_buf_size (const char *)
-  __attribute__ ((deprecated));
+  __attribute__ ((__deprecated__));
 extern int cygwin_conv_to_win32_path (const char *, char *)
-  __attribute__ ((deprecated));
+  __attribute__ ((__deprecated__));
 extern int cygwin_conv_to_full_win32_path (const char *, char *)
-  __attribute__ ((deprecated));
+  __attribute__ ((__deprecated__));
 extern int cygwin_conv_to_posix_path (const char *, char *)
-  __attribute__ ((deprecated));
+  __attribute__ ((__deprecated__));
 extern int cygwin_conv_to_full_posix_path (const char *, char *)
-  __attribute__ ((deprecated));
+  __attribute__ ((__deprecated__));
 #endif /* !__x86_64__ */
=20
 /* Use these interfaces in favor of the above. */
Index: include/sys/strace.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/include/sys/strace.h,v
retrieving revision 1.33
diff -u -p -r1.33 strace.h
--- include/sys/strace.h	23 Apr 2013 09:44:35 -0000	1.33
+++ include/sys/strace.h	31 Jul 2014 16:04:05 -0000
@@ -1,7 +1,7 @@
 /* sys/strace.h
=20
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2=
008,
-   2010, 2011, 2012 Red Hat, Inc.
+   2010, 2011, 2012, 2014 Red Hat, Inc.
=20
 This file is part of Cygwin.
=20
@@ -40,17 +40,17 @@ class strace
   void write (unsigned category, const char *buf, int count);
   unsigned char _active;
 public:
-  void activate (bool) __attribute__ ((regparm (2)));;
+  void activate (bool) __attribute__ ((__regparm__ (2)));;
   strace () {}
   int microseconds ();
   int version;
   int lmicrosec;
   bool execing;
-  void dll_info () __attribute__ ((regparm (1)));
-  void prntf (unsigned, const char *func, const char *, ...) /*__attribute=
__ ((regparm(3)))*/;
-  void vprntf (unsigned, const char *func, const char *, va_list ap) /*__a=
ttribute__ ((regparm(3)))*/;
-  void wm (int message, int word, int lon) __attribute__ ((regparm(3)));
-  void write_childpid (pid_t) __attribute__ ((regparm (3)));
+  void dll_info () __attribute__ ((__regparm__ (1)));
+  void prntf (unsigned, const char *func, const char *, ...) /*__attribute=
__ ((__regparm__(3)))*/;
+  void vprntf (unsigned, const char *func, const char *, va_list ap) /*__a=
ttribute__ ((__regparm__(3)))*/;
+  void wm (int message, int word, int lon) __attribute__ ((__regparm__(3))=
);
+  void write_childpid (pid_t) __attribute__ ((__regparm__ (3)));
   bool attached () const {return _active =3D=3D 3;}
   bool active () const {return _active & 1;}
   unsigned char& active_val () {return _active;}

--------------070700070705060408030604--

--XvjPqLkLuO8uvVKgN5EcTU0qc6XhAD9iA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 539

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJT2mnPAAoJEKeha0olJ0NqnxAH/AgJVzpLinsdAL5oToDDT5Q2
voZ385k7IHy9Jsa/GZQEHAUR/HNVBFep2RccEhLavdaaafnIciwq+DnTG2wTvZ+1
2V1kL0+oY+Q+hp7Np3SocOagGK996vZX1ILpmM0l4/RgFMVTqmohMt862v8LuIcj
6LlueQwPhfQa1km/9chLEkbzJqcsisPNMr5KQApTXqGOcv11riNCzec77zCsiJ2f
FR6QJKRIBIoVwWc9OpKotP3w6LC4ugX91Hv5e/Q4fTMp973Rseq7/EaiIYQKe6On
qzudwUkkr0mOpRZ1fP28crpWSlCQnmGAtS0H20SWQU8xHf+KA4A5qajTWmU2LfI=
=GXUA
-----END PGP SIGNATURE-----

--XvjPqLkLuO8uvVKgN5EcTU0qc6XhAD9iA--
