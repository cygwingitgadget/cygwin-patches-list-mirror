Return-Path: <cygwin-patches-return-3621-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7659 invoked by alias); 25 Feb 2003 04:30:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7648 invoked from network); 25 Feb 2003 04:30:01 -0000
Message-Id: <3.0.5.32.20030224232915.007f5530@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Tue, 25 Feb 2003 04:30:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: mkpasswd & mkgroup
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1046165355==_"
X-SW-Source: 2003-q1/txt/msg00270.txt.bz2

--=====================_1046165355==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1278

Corinna,

Earlier I have added a -c switch to mkpasswd & mkgroup. 
It prints the current user (if a domain account), without 
contacting the PDC. 
That was meant for use in postinstall scripts.

However until setup.exe is upgraded, only mkpasswd -l will
be run by passwd-grp.bat, which causes recurring problems with
domain users. 

Thus, at least until setup.exe is upgraded, I suggest that
-c be implied by -l, unless -d is also specified.
This is implemented by the attached patch.
It pretty much insure that the main users will have proper entries.
 
Also, to support arbitrary uid's on Win95, mkpasswd prints both
a default line with uid 500, and a line for the current user 
with a pseudorandom uid. Other users can be added with -u.
Cygwin uses the default line for users that do not have an entry.

I will update the documentation if you apply this patch.

Pierre
 
2003-02-25  Pierre Humblet  <pierre.humblet@ieee.org>

	* mkpasswd.cc (usage): Explain -l, remove -c.
	(main): -c behavior is implied by -l without -d.
	On Win95, output both a default line and a line for the current
	user with a pseudorandom uid.
	* mkgroup.cc (usage): Explain -l, remove -c.
	(main): -c behavior is implied by -l without -d.
	On Win95 change the group name from "unknown" to "all". 

 
--=====================_1046165355==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pwdgrp.diff"
Content-length: 4664

Index: mkpasswd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/utils/mkpasswd.c,v
retrieving revision 1.28
diff -u -p -r1.28 mkpasswd.c
--- mkpasswd.c	15 Jan 2003 10:08:37 -0000	1.28
+++ mkpasswd.c	25 Feb 2003 02:16:43 -0000
@@ -491,8 +491,8 @@ usage (FILE * stream, int isNT)
 	           "This program prints a /etc/passwd file to stdout\n\n"
 	           "Options:\n");
   if (isNT)
-    fprintf (stream, "   -l,--local              print local user accounts=
\n"
-	             "   -c,--current            print current account, if a doma=
in account\n"
+    fprintf (stream, "   -l,--local              print local user accounts=
 and the current\n"
+	             "                           account, if a domain account and=
 -d is absent\n"
                      "   -d,--domain             print domain accounts (fr=
om current domain\n"
                      "                           if no domain specified)\n"
                      "   -o,--id-offset offset   change the default offset=
 (10000) added to uids\n"
@@ -632,21 +632,32 @@ main (int argc, char **argv)
   if (!isNT)
     {
       /* This takes Windows 9x/ME into account. */
+      unsigned long uid =3D 0;
+      int i;
+
+      if (passed_home_path[0] =3D=3D '\0')
+	strcpy (passed_home_path, "/home/");
       if (!disp_username)
         {
+	  printf ("Administrator:*:%lu:%lu:Administrator:%sAdministrator:/bin/bas=
h\n",
+		  DOMAIN_USER_RID_ADMIN,
+		  DOMAIN_ALIAS_RID_ADMINS,
+		  passed_home_path);
 	  if (GetUserName (name, (len =3D 256, &len)))
 	    disp_username =3D name;
 	  else
 	    /* Same behaviour as in cygwin/shared.cc (memory_init). */
 	    disp_username =3D (char *) "unknown";
 	}
-
-      if (passed_home_path[0] =3D=3D '\0')
-	strcpy (passed_home_path, "/home/");
-
-      printf ("%s:*:%ld:%ld:%s:%s%s:/bin/bash\n", disp_username,
-					        DOMAIN_USER_RID_ADMIN,
-					        DOMAIN_ALIAS_RID_ADMINS,
+      /* Create a pseudo random uid */
+      for (i =3D 0; disp_username[i]; i++)
+	uid +=3D tolower (disp_username[i]) << ((7 * i) % 25);
+      uid =3D (uid % (65535 - DOMAIN_USER_RID_ADMIN - 1))
+	+ DOMAIN_USER_RID_ADMIN + 1;
+
+      printf ("%s:*:%lu:%lu:%s:%s%s:/bin/bash\n", disp_username,
+	                                        uid,
+	                                        DOMAIN_ALIAS_RID_ADMINS,
 	                                        disp_username,
 					        passed_home_path,
 					        disp_username);
@@ -721,7 +732,7 @@ main (int argc, char **argv)
     enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0,
     		disp_username);

-  if (print_current && !print_domain)
+  if (print_local && !print_domain)
     current_user(print_sids, print_cygpath, passed_home_path,
 		 id_offset, disp_username);

Index: mkgroup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/utils/mkgroup.c,v
retrieving revision 1.19
diff -u -p -r1.19 mkgroup.c
--- mkgroup.c	15 Jan 2003 10:08:37 -0000	1.19
+++ mkgroup.c	25 Feb 2003 02:27:01 -0000
@@ -488,8 +488,8 @@ usage (FILE * stream, int isNT)
 	           "This program prints a /etc/group file to stdout\n\n"
 	           "Options:\n");
   if (isNT)
-    fprintf (stream, "   -l,--local             print local group informat=
ion\n"
-	             "   -c,--current           print current group, if a domain =
account\n"
+    fprintf (stream, "   -l,--local             print local group informat=
ion and the group of the\n"
+	             "                          current account, if a domain acco=
unt and -d is absent\n"
 		     "   -d,--domain            print global group information from the =
domain\n"
 		     "                          specified (or from the current domain if=
 there is\n"
 		     "                          no domain specified)\n"
@@ -612,7 +612,7 @@ main (int argc, char **argv)
   /* This takes Windows 9x/ME into account. */
   if (!isNT)
     {
-      printf ("unknown::%ld:\n", DOMAIN_ALIAS_RID_ADMINS);
+      printf ("all::%ld:\n", DOMAIN_ALIAS_RID_ADMINS);
       return 0;
     }

@@ -718,7 +718,7 @@ main (int argc, char **argv)
   if (print_local)
     enum_local_groups (print_sids, print_users);

-  if (print_current && !print_domain)
+  if (print_local && !print_domain)
     current_group (print_sids, print_users, id_offset);

   return 0;

--=====================_1046165355==_--
