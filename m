Return-Path: <cygwin-patches-return-3250-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31161 invoked by alias); 1 Dec 2002 05:06:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31152 invoked from network); 1 Dec 2002 05:06:40 -0000
Message-Id: <3.0.5.32.20021201000321.0082b440@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Sat, 30 Nov 2002 21:06:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Internal get{pw,gr}XX calls
In-Reply-To: <20021129190611.F1398@cygbert.vinschen.de>
References: <20021129184501.E1398@cygbert.vinschen.de>
 <3.0.5.32.20021126000911.00833190@mail.attbi.com>
 <3.0.5.32.20021126000911.00833190@mail.attbi.com>
 <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com>
 <20021129184501.E1398@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1038737001==_"
X-SW-Source: 2002-q4/txt/msg00201.txt.bz2

--=====================_1038737001==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1353

Corinna,

The attached patch includes the changes to grab_int and parse_grp.
I like your initial idea (a little simplified) better because it 
leaves uid = -1 as a usable value. That may prove useful one day 
(I have some ideas). It also makes parse_pwd somewhat simpler.

strtoul replaces strtol. I have verified that both strtoul("-2",..)
and strtoul("4294967294",..) return 0xFFFFFFFE.

I have kept updating the state to loaded in read_etc_{passwd,group}.

This patch replaces what I sent on Friday. It is incremental over
the earlier big patch involving 9 files.

Pierre

2002-11-30  Pierre Humblet <pierre.humblet@ieee.org>

	* pwdgrp.h (pwdgrp_check::pwdgrp_state): Replace by 
	pwdgrp_check::isinitializing ().
	(pwdgrp_check::isinitializing): Create.
	* passwd.cc (grab_int): Change type to unsigned, use strtoul and 
	set the pointer content to 0 if the field is invalid.
	(parse_pwd): Move validity test after getting pw_gid.
	(read_etc_passwd): Replace "passwd_state <= " by 
	passwd_state::isinitializing ().	
	(internal_getpwuid): Ditto.
	(internal_getpwnam): Ditto.
	(getpwent): Ditto.
	(getpass): Ditto.
	* grp.cc (parse_grp): Use strtoul for gr_gid and verify the validity.
	(read_etc_group): Replace "group_state <= " by 
	group_state::isinitializing (). 
	(internal_getgrgid): Ditto.
	(getgrent32): Ditto.
	(internal_getgrent): Ditto.

--=====================_1038737001==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pwd2.diff"
Content-length: 5064

--- pwdgrp.h.new	2002-11-28 23:17:54.000000000 -0500
+++ pwdgrp.h	2002-11-30 16:40:34.000000000 -0500
@@ -34,21 +34,28 @@ class pwdgrp_check {

 public:
   pwdgrp_check () : state (uninitialized) {}
-  operator pwdgrp_state ()
+  BOOL isinitializing ()
     {
-      if (state !=3D uninitialized && file_w32[0] && cygheap->etc_changed =
())
-	{
-	  HANDLE h;
-	  WIN32_FIND_DATA data;
-
-	  if ((h =3D FindFirstFile (file_w32, &data)) !=3D INVALID_HANDLE_VALUE)
+      if (state <=3D initializing)
+	state =3D initializing;
+      else if (cygheap->etc_changed ())
+        {
+	  if (!file_w32[0])
+	    state =3D initializing;
+	  else
 	    {
-	      if (CompareFileTime (&data.ftLastWriteTime, &last_modified) > 0)
-		state =3D initializing;
-	      FindClose (h);
+	      HANDLE h;
+	      WIN32_FIND_DATA data;
+
+	      if ((h =3D FindFirstFile (file_w32, &data)) !=3D INVALID_HANDLE_VAL=
UE)
+	        {
+		  if (CompareFileTime (&data.ftLastWriteTime, &last_modified) > 0)
+		    state =3D initializing;
+		  FindClose (h);
+		}
 	    }
 	}
-      return state;
+      return state =3D=3D initializing;
     }
   void operator =3D (pwdgrp_state nstate)
     {
--- passwd.cc.new	2002-11-28 23:26:28.000000000 -0500
+++ passwd.cc	2002-11-30 23:26:42.000000000 -0500
@@ -60,16 +60,12 @@ grab_string (char **p)
 }

 /* same, for ints */
-static int
+static unsigned int
 grab_int (char **p)
 {
   char *src =3D *p;
-  int val =3D strtol (src, NULL, 10);
-  while (*src && *src !=3D ':')
-    src++;
-  if (*src =3D=3D ':')
-    src++;
-  *p =3D src;
+  unsigned int val =3D strtoul (src, p, 10);
+  *p =3D (*p =3D=3D src || **p !=3D ':') ? almost_null : *p + 1;
   return val;
 }

@@ -82,9 +78,9 @@ parse_pwd (struct passwd &res, char *buf
   res.pw_name =3D grab_string (&buf);
   res.pw_passwd =3D grab_string (&buf);
   res.pw_uid =3D grab_int (&buf);
+  res.pw_gid =3D grab_int (&buf);
   if (!*buf)
     return 0;
-  res.pw_gid =3D grab_int (&buf);
   res.pw_comment =3D 0;
   res.pw_gecos =3D grab_string (&buf);
   res.pw_dir =3D  grab_string (&buf);
@@ -140,7 +136,7 @@ read_etc_passwd ()
   passwd_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_passwd may have been process=
ed */
-  if (passwd_state <=3D initializing)
+  if (passwd_state.isinitializing ())
     {
       curr_lines =3D 0;
       if (pr.open ("/etc/passwd"))
@@ -216,7 +212,7 @@ struct passwd *
 internal_getpwuid (__uid32_t uid, BOOL check)
 {
   if (passwd_state.isuninitialized ()
-      || (check && passwd_state  <=3D initializing))
+      || (check && passwd_state.isinitializing ()))
     read_etc_passwd ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -229,7 +225,7 @@ struct passwd *
 internal_getpwnam (const char *name, BOOL check)
 {
   if (passwd_state.isuninitialized ()
-      || (check && passwd_state  <=3D initializing))
+      || (check && passwd_state.isinitializing ()))
     read_etc_passwd ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -351,7 +347,7 @@ getpwnam_r (const char *nam, struct pass
 extern "C" struct passwd *
 getpwent (void)
 {
-  if (passwd_state  <=3D initializing)
+  if (passwd_state.isinitializing ())
     read_etc_passwd ();

   if (pw_pos < curr_lines)
@@ -394,7 +390,7 @@ getpass (const char * prompt)
 #endif
   struct termios ti, newti;

-  if (passwd_state  <=3D initializing)
+  if (passwd_state.isinitializing ())
     read_etc_passwd ();

   cygheap_fdget fhstdin (0);
--- grp.cc.new	2002-11-28 23:30:04.000000000 -0500
+++ grp.cc	2002-11-30 16:48:24.000000000 -0500
@@ -59,9 +59,8 @@ parse_grp (struct __group32 &grp, char *
   if (dp)
     {
       *dp++ =3D '\0';
-      grp.gr_gid =3D strtol (dp, NULL, 10);
-      dp =3D strchr (dp, ':');
-      if (dp)
+      grp.gr_gid =3D strtoul (line =3D dp, &dp, 10);
+      if (dp !=3D line && *dp =3D=3D ':')
 	{
 	  grp.gr_mem =3D &null_ptr;
 	  if (*++dp)
@@ -135,7 +134,7 @@ read_etc_group ()
   group_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_group may have been processe=
d */
-  if (group_state <=3D initializing)
+  if (group_state.isinitializing ())
     {
       for (int i =3D 0; i < curr_lines; i++)
 	if ((group_buf + i)->gr_mem !=3D &null_ptr)
@@ -199,7 +198,7 @@ internal_getgrgid (__gid32_t gid, BOOL c
   struct __group32 * default_grp =3D NULL;

   if (group_state.isuninitialized ()
-      || (check && group_state  <=3D initializing))
+      || (check && group_state.isinitializing ()))
     read_etc_group ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -216,7 +215,7 @@ struct __group32 *
 internal_getgrnam (const char *name, BOOL check)
 {
   if (group_state.isuninitialized ()
-      || (check && group_state  <=3D initializing))
+      || (check && group_state.isinitializing ()))
     read_etc_group ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -281,7 +280,7 @@ endgrent ()
 extern "C" struct __group32 *
 getgrent32 ()
 {
-  if (group_state  <=3D initializing)
+  if (group_state.isinitializing ())
     read_etc_group ();

   if (grp_pos < curr_lines)

--=====================_1038737001==_--
