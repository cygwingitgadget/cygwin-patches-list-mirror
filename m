Return-Path: <cygwin-patches-return-3608-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19005 invoked by alias); 20 Feb 2003 22:29:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18996 invoked from network); 20 Feb 2003 22:29:49 -0000
Date: Thu, 20 Feb 2003 22:29:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Silent some more warnings.
Message-ID: <20030220230012.I26596-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=1.1 required=6.0
	tests=CARRIAGE_RETURNS,SPAM_PHRASE_00_01
	version=2.44
X-Spam-Level: *
X-SW-Source: 2003-q1/txt/msg00257.txt.bz2


Hi,
this patch silents warnings about strict-aliasing rules breach.
There are also two hunks that remove obviously always true assert().

Vaclav Haisman


2003-02-20  Vaclav Haisman  <V.Haisman@sh.cvut.cz>

	* libc/stdio/vfprintf.c (cvt): Fix strict-aliasing rules
	breach warning.
	* libc/stdlib/ldtoa.c (_ldtoa_r): Ditto.
	(_strtold): Ditto.

2003-02-20  Vaclav Haisman  <V.Haisman@sh.cvut.cz>

	* cygserver_transport_sockets.cc (transport_layer_sockets::read):
	Remove obvously always true assert.
	(transport_layer_sockets::write): Ditto

2003-02-20  Vaclav Haisman  <V.Haisman@sh.cvut.cz>

	* mingwex/math/powl.c (LOG2EA): Fix strict-aliasing rules breach
	warning.

2003-02-20  Vaclav Haisman  <V.Haisman@sh.cvut.cz>

	* mkgroup.c (enum_local_users): Silent strict-aliasing rules breach
	warning.
	(enum_local_groups): Ditto.
	(enum_users): Ditto.
	(enum_groups): Ditto.
	(main): Ditto.
	* mkpasswd.c (enum_users): Ditto.
	(enum_local_groups): Ditto.
	(main): Ditto.
	* passwd.c (GetPW): Ditto.
	(PrintPW): Ditto.
	(SetModals): Ditto.

Index: newlib/libc/stdio/vfprintf.c
===================================================================
RCS file: /cvs/src/src/newlib/libc/stdio/vfprintf.c,v
retrieving revision 1.18
diff -u -p -r1.18 vfprintf.c
--- newlib/libc/stdio/vfprintf.c	7 Jan 2003 20:02:33 -0000	1.18
+++ newlib/libc/stdio/vfprintf.c	20 Feb 2003 21:54:44 -0000
@@ -1158,7 +1158,7 @@ cvt(data, value, ndigits, flags, sign, d

 	digits = _dtoa_r(data, value, mode, ndigits, decpt, &dsgn, &rve);
 #else /* !_NO_LONGDBL */
-	ldptr = (struct ldieee *)&value;
+	ldptr = (struct ldieee *)(void *)&value;
 	if (ldptr->sign) { /* this will check for < 0 and -0.0 */
 		value = -value;
 		*sign = '-';
Index: newlib/libc/stdlib/ldtoa.c
===================================================================
RCS file: /cvs/src/src/newlib/libc/stdlib/ldtoa.c,v
retrieving revision 1.8
diff -u -p -r1.8 ldtoa.c
--- newlib/libc/stdlib/ldtoa.c	3 Feb 2003 21:29:45 -0000	1.8
+++ newlib/libc/stdlib/ldtoa.c	20 Feb 2003 21:54:47 -0000
@@ -2729,13 +2729,13 @@ if (_REENT_MP_RESULT(ptr))
   }

 #if LDBL_MANT_DIG == 24
-e24toe( (unsigned short *)&d, e, ldp );
+e24toe( (unsigned short *)(void *)&d, e, ldp );
 #elif LDBL_MANT_DIG == 53
-e53toe( (unsigned short *)&d, e, ldp );
+e53toe( (unsigned short *)(void *)&d, e, ldp );
 #elif LDBL_MANT_DIG == 64
-e64toe( (unsigned short *)&d, e, ldp );
+e64toe( (unsigned short *)(void *)&d, e, ldp );
 #else
-e113toe( (unsigned short *)&d, e, ldp );
+e113toe( (unsigned short *)(void *)&d, e, ldp );
 #endif

 if( eisneg(e) )
@@ -3228,7 +3228,7 @@ long double _strtold (char *s, char **se
   rnd.rlast = -1;
   rnd.rndprc = NBITS;

-  lenldstr = asctoeg( s, (unsigned short *)&x, LDBL_MANT_DIG, ldp );
+  lenldstr = asctoeg( s, (unsigned short *)(void *)&x, LDBL_MANT_DIG, ldp );
   if (se)
     *se = s + lenldstr;
   return x;
Index: winsup/cygwin/cygserver_transport_sockets.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygserver_transport_sockets.cc,v
retrieving revision 1.4
diff -u -p -r1.4 cygserver_transport_sockets.cc
--- winsup/cygwin/cygserver_transport_sockets.cc	22 Sep 2002 12:04:15 -0000	1.4
+++ winsup/cygwin/cygserver_transport_sockets.cc	20 Feb 2003 21:55:04 -0000
@@ -269,8 +269,6 @@ transport_layer_sockets::read (void *con
     {
       read_buf += res;
       read_buf_len -= res;
-
-      assert (read_buf_len >= 0);
     }

   if (res != -1)
@@ -315,8 +313,6 @@ transport_layer_sockets::write (void *co
     {
       write_buf += res;
       write_buf_len -= res;
-
-      assert (write_buf_len >= 0);
     }

   if (res != -1)
Index: winsup/mingw/mingwex/math/powl.c
===================================================================
RCS file: /cvs/src/src/winsup/mingw/mingwex/math/powl.c,v
retrieving revision 1.2
diff -u -p -r1.2 powl.c
--- winsup/mingw/mingwex/math/powl.c	6 Oct 2002 23:26:43 -0000	1.2
+++ winsup/mingw/mingwex/math/powl.c	20 Feb 2003 21:55:12 -0000
@@ -270,7 +270,7 @@ static const unsigned short R[] = {
 #define MNEXP (-NXT*16384.0L)
 #endif
 static const unsigned short L[] = {0xc2ef,0x705f,0xeca5,0xe2a8,0x3ffd, XPD};
-#define LOG2EA (*(long double *)(&L[0]))
+#define LOG2EA (*(long double *)(void *)(&L[0]))
 #endif

 #ifdef MIEEE
@@ -359,7 +359,7 @@ static long R[] = {
 #define MNEXP (-NXT*16382.0L)
 #endif
 static long L[3] = {0x3ffd0000,0xe2a8eca5,0x705fc2ef};
-#define LOG2EA (*(long double *)(&L[0]))
+#define LOG2EA (*(long double *)(void *)(&L[0]))
 #endif


Index: winsup/utils/mkgroup.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/mkgroup.c,v
retrieving revision 1.19
diff -u -p -r1.19 mkgroup.c
--- winsup/utils/mkgroup.c	15 Jan 2003 10:08:37 -0000	1.19
+++ winsup/utils/mkgroup.c	20 Feb 2003 21:55:17 -0000
@@ -136,7 +136,7 @@ enum_local_users (LPWSTR groupname)
   DWORD reshdl = 0;

   if (!netlocalgroupgetmembers (NULL, groupname,
-				1, (LPBYTE *) &buf1,
+				1, (LPBYTE *)(void *) &buf1,
 				MAX_PREFERRED_LENGTH,
 				&entries, &total, &reshdl))
     {
@@ -170,7 +170,7 @@ enum_local_groups (int print_sids, int p
     {
       DWORD i;

-      rc = netlocalgroupenum (NULL, 0, (LPBYTE *) &buffer, 1024,
+      rc = netlocalgroupenum (NULL, 0, (LPBYTE *)(void *) &buffer, 1024,
 			      &entriesread, &totalentries, &resume_handle);
       switch (rc)
 	{
@@ -255,7 +255,7 @@ enum_users (LPWSTR servername, LPWSTR gr
   DWORD reshdl = 0;

   if (!netgroupgetusers (servername, groupname,
-			 0, (LPBYTE *) &buf1,
+			 0, (LPBYTE *)(void *) &buf1,
 			 MAX_PREFERRED_LENGTH,
 			 &entries, &total, &reshdl))
     {
@@ -292,7 +292,7 @@ enum_groups (LPWSTR servername, int prin
     {
       DWORD i;

-      rc = netgroupenum (servername, 2, (LPBYTE *) & buffer, 1024,
+      rc = netgroupenum (servername, 2, (LPBYTE *)(void *) &buffer, 1024,
 		         &entriesread, &totalentries, &resume_handle);
       switch (rc)
 	{
@@ -670,7 +670,7 @@ main (int argc, char **argv)
 	    {
 	      ret = lsaqueryinformationpolicy (lsa,
 					       PolicyPrimaryDomainInformation,
-					       (PVOID *) &pdi);
+					       (void *) &pdi);
 	      if (ret == STATUS_SUCCESS)
 	        {
 		  if (pdi->Sid)
@@ -701,10 +701,10 @@ main (int argc, char **argv)
   if (print_domain)
     {
       if (domain_specified)
-	rc = netgetdcname (NULL, domain_name, (LPBYTE *) & servername);
+	rc = netgetdcname (NULL, domain_name, (LPBYTE *)(void *) &servername);

       else
-	rc = netgetdcname (NULL, NULL, (LPBYTE *) & servername);
+	rc = netgetdcname (NULL, NULL, (LPBYTE *)(void *) &servername);

       if (rc != ERROR_SUCCESS)
 	{
Index: winsup/utils/mkpasswd.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/mkpasswd.c,v
retrieving revision 1.28
diff -u -p -r1.28 mkpasswd.c
--- winsup/utils/mkpasswd.c	15 Jan 2003 10:08:37 -0000	1.28
+++ winsup/utils/mkpasswd.c	20 Feb 2003 21:55:17 -0000
@@ -237,12 +237,12 @@ enum_users (LPWSTR servername, int print
       {
 	MultiByteToWideChar (CP_ACP, 0, disp_username, -1, uni_name, 512 );
 	rc = netusergetinfo(servername, (LPWSTR) & uni_name, 3,
-			    (LPBYTE *) &buffer );
+			    (LPBYTE *)(void *) &buffer );
 	entriesread=1;
       }
     else
       rc = netuserenum (servername, 3, FILTER_NORMAL_ACCOUNT,
-			(LPBYTE *) & buffer, 1024,
+			(LPBYTE *)(void *) &buffer, 1024,
 			&entriesread, &totalentries, &resume_handle);
       switch (rc)
 	{
@@ -370,7 +370,7 @@ enum_local_groups (int print_sids)
     {
       DWORD i;

-      rc = netlocalgroupenum (NULL, 0, (LPBYTE *) & buffer, 1024,
+      rc = netlocalgroupenum (NULL, 0, (LPBYTE *)(void *) &buffer, 1024,
 			      &entriesread, &totalentries, &resume_handle);
       switch (rc)
 	{
@@ -702,10 +702,10 @@ main (int argc, char **argv)
   if (print_domain)
     {
       if (domain_name_specified)
-	rc = netgetdcname (NULL, domain_name, (LPBYTE *) & servername);
+	rc = netgetdcname (NULL, domain_name, (LPBYTE *)(void *) &servername);

       else
-	rc = netgetdcname (NULL, NULL, (LPBYTE *) & servername);
+	rc = netgetdcname (NULL, NULL, (LPBYTE *)(void *) &servername);

       if (rc != ERROR_SUCCESS)
 	{
Index: winsup/utils/passwd.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/passwd.c,v
retrieving revision 1.7
diff -u -p -r1.7 passwd.c
--- winsup/utils/passwd.c	15 Sep 2002 19:24:36 -0000	1.7
+++ winsup/utils/passwd.c	20 Feb 2003 21:55:20 -0000
@@ -129,7 +129,7 @@ GetPW (char *user, int print_win_name)
 	}
     }
   MultiByteToWideChar (CP_ACP, 0, user, -1, name, 2 * (UNLEN + 1));
-  ret = NetUserGetInfo (NULL, name, 3, (LPBYTE *) &ui);
+  ret = NetUserGetInfo (NULL, name, 3, (LPBYTE *)(void *) &ui);
   return EvalRet (ret, user) ? NULL : ui;
 }

@@ -176,7 +176,7 @@ PrintPW (PUSER_INFO_3 ui)
   printf ("Password expired : %s", (ui->usri3_password_expired)
                                 ? "yes\n" : "no\n");
   printf ("Password changed : %s", ctime(&t));
-  ret = NetUserModalsGet (NULL, 0, (LPBYTE *) &mi);
+  ret = NetUserModalsGet (NULL, 0, (LPBYTE *)(void *) &mi);
   if (! ret)
     {
       if (mi->usrmod0_max_passwd_age == TIMEQ_FOREVER
@@ -207,7 +207,7 @@ SetModals (int xarg, int narg, int iarg,
   int ret;
   PUSER_MODALS_INFO_0 mi;

-  ret = NetUserModalsGet (NULL, 0, (LPBYTE *) &mi);
+  ret = NetUserModalsGet (NULL, 0, (LPBYTE *)(void *) &mi);
   if (! ret)
     {
       if (xarg == 0)
