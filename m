Return-Path: <cygwin-patches-return-3242-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31718 invoked by alias); 29 Nov 2002 15:54:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31613 invoked from network); 29 Nov 2002 15:54:08 -0000
Message-Id: <3.0.5.32.20021129104925.0084b470@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Fri, 29 Nov 2002 07:54:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Internal get{pw,gr}XX calls
In-Reply-To: <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.
 attbi.com>
References: <20021128191909.Y1398@cygbert.vinschen.de>
 <3.0.5.32.20021126000911.00833190@mail.attbi.com>
 <3.0.5.32.20021126000911.00833190@mail.attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1038602965==_"
X-SW-Source: 2002-q4/txt/msg00193.txt.bz2

--=====================_1038602965==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 981

Hello Corinna,

Don't program when you are tired, my mom used to say.
This replaces what I sent last night. The discussion
in the message is still OK.

Pierre

2002-11-29  Pierre Humblet <pierre.humblet@ieee.org>

	* pwdgrp.h (pwdgrp_check::pwdgrp_state): Replace by 
	pwdgrp_check::isinitializing ().
	(pwdgrp_check::isinitializing): Create.
 	(pwdgrp_check::operator =): Delete.
	((pwdgrp_check::set_last_modified): Set state to loaded.
	* passwd.cc (read_etc_passwd): Replace "passwd_state <= " by 
	passwd_state::isinitializing (). Remove update of passwd_state.	
	(internal_getpwuid): Replace "passwd_state <= " by 
	passwd_state::isinitializing ().
	(internal_getpwnam): Ditto.
	(getpwent): Ditto.
	(getpass): Ditto.
	* grp.cc (read_etc_group): Replace "group_state <= " by 
	group_state::isinitializing (). Remove update of group_state.	
	(internal_getgrgid): Replace "group_state <= " by 
	group_state::isinitializing ().
	(getgrent32): Ditto.
	(internal_getgrent): Ditto.

--=====================_1038602965==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pwd2.diff"
Content-length: 4733

--- pwdgrp.h.new	2002-11-28 23:17:54.000000000 -0500
+++ pwdgrp.h	2002-11-29 10:41:56.000000000 -0500
@@ -34,25 +34,28 @@ class pwdgrp_check {

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
-    }
-  void operator =3D (pwdgrp_state nstate)
-    {
-      state =3D nstate;
+      return state =3D=3D initializing;
     }
   BOOL isuninitialized () const { return state =3D=3D uninitialized; }
   void set_last_modified (HANDLE fh, const char *name)
@@ -60,6 +63,7 @@ public:
       if (!file_w32[0])
 	strcpy (file_w32, name);
       GetFileTime (fh, NULL, NULL, &last_modified);
+      state =3D loaded;
     }
 };

--- passwd.cc.new	2002-11-28 23:26:28.000000000 -0500
+++ passwd.cc	2002-11-29 10:42:36.000000000 -0500
@@ -140,7 +140,7 @@ read_etc_passwd ()
   passwd_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_passwd may have been process=
ed */
-  if (passwd_state <=3D initializing)
+  if (passwd_state.isinitializing ())
     {
       curr_lines =3D 0;
       if (pr.open ("/etc/passwd"))
@@ -153,7 +153,6 @@ read_etc_passwd ()
 	  pr.close ();
 	  debug_printf ("Read /etc/passwd, %d lines", curr_lines);
 	}
-      passwd_state =3D loaded;

       static char linebuf[1024];
       char strbuf[128] =3D "";
@@ -216,7 +215,7 @@ struct passwd *
 internal_getpwuid (__uid32_t uid, BOOL check)
 {
   if (passwd_state.isuninitialized ()
-      || (check && passwd_state  <=3D initializing))
+      || (check && passwd_state.isinitializing ()))
     read_etc_passwd ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -229,7 +228,7 @@ struct passwd *
 internal_getpwnam (const char *name, BOOL check)
 {
   if (passwd_state.isuninitialized ()
-      || (check && passwd_state  <=3D initializing))
+      || (check && passwd_state.isinitializing ()))
     read_etc_passwd ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -351,7 +350,7 @@ getpwnam_r (const char *nam, struct pass
 extern "C" struct passwd *
 getpwent (void)
 {
-  if (passwd_state  <=3D initializing)
+  if (passwd_state.isinitializing ())
     read_etc_passwd ();

   if (pw_pos < curr_lines)
@@ -394,7 +393,7 @@ getpass (const char * prompt)
 #endif
   struct termios ti, newti;

-  if (passwd_state  <=3D initializing)
+  if (passwd_state.isinitializing ())
     read_etc_passwd ();

   cygheap_fdget fhstdin (0);
--- grp.cc.new	2002-11-28 23:30:04.000000000 -0500
+++ grp.cc	2002-11-29 10:43:12.000000000 -0500
@@ -135,7 +135,7 @@ read_etc_group ()
   group_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_group may have been processe=
d */
-  if (group_state <=3D initializing)
+  if (group_state.isinitializing ())
     {
       for (int i =3D 0; i < curr_lines; i++)
 	if ((group_buf + i)->gr_mem !=3D &null_ptr)
@@ -152,7 +152,6 @@ read_etc_group ()
 	  gr.close ();
 	  debug_printf ("Read /etc/group, %d lines", curr_lines);
 	}
-      group_state =3D loaded;

       /* Complete /etc/group in memory if needed */
       if (!internal_getgrgid (myself->gid))
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

--=====================_1038602965==_--
