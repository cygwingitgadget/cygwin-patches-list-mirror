Return-Path: <cygwin-patches-return-3239-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9102 invoked by alias); 29 Nov 2002 06:04:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9092 invoked from network); 29 Nov 2002 06:04:07 -0000
Message-Id: <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Thu, 28 Nov 2002 22:04:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Internal get{pw,gr}XX calls
In-Reply-To: <20021128191909.Y1398@cygbert.vinschen.de>
References: <3.0.5.32.20021126000911.00833190@mail.attbi.com>
 <3.0.5.32.20021126000911.00833190@mail.attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1038567577==_"
X-SW-Source: 2002-q4/txt/msg00190.txt.bz2

--=====================_1038567577==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 4573

Hi Corinna,

At 07:19 PM 11/28/2002 +0100, Corinna Vinschen wrote:
>>      }
>> +  BOOL isuninitialized () const { return state == uninitialized; }
>
>I don't see a need to define isuninitialized().  Or we should also
>define other similar methods.  What we currently have is the operator
>pwdgrp_state() so that we always use conditionals like

I am not an expert on C++ classes. I thought that invoking the
isuninitialized() method would simply return "state == uninitialized"
whereas using  passwd_state <= initializing
would run the code of "operator pwdgrp_state ()". It calls 
etc_changed () and WaitForSingleObject (), which is completely useless
in the context of internal calls that don't reread the files.

>instead, as before.  But if you're more happy with using additional
>methods, feel free to use them, but then define all methods needed as
>
>    passwd_state.isuninitialized()
>    passwd_state.isloaded()

Yes, that's the right way. I will do that.

>> Index: passwd.cc
>> ===================================================================
>>    res.pw_name = grab_string (&buf);
>>    res.pw_passwd = grab_string (&buf);
>>    res.pw_uid = grab_int (&buf);
>> +  if (!*buf)
>> +    return 0;
>>    res.pw_gid = grab_int (&buf);
>>    res.pw_comment = 0;
>>    res.pw_gecos = grab_string (&buf);
>> @@ -129,28 +125,6 @@ class passwd_lock
>
>You said that you did it in a relaxed fashion.  Hmm.  Long hmmmmmm.
>Your implementation allows for passwd entries to be cut (or mutilated)
>after the gid.  That should be ok.  I'm just thinking that we should
>perhaps change grab_int so that we know it got a well formed uid and
>gid field, isn't it?  Shouldn't we check for the stop character like this:
>
>  static int
>  grab_int (char **p)
>  {
>    char *src = *p, *stp;
>    int val = strtol (src, &stp, 10);
>    if (stp == src || !isdigit (*stp))   << *stp WON'T EVER BE A DIGIT,
AFAIK. 
>      while (*src)                       
>	src++;
>    else
>      while (*src && *src != ':')   << DO YOU MEAN stp?
>	src++;
>    if (*src == ':')
>      src++;
>    *p = src;
>    return val;
>  }
>
>That would p move to the trailing \0 as soon as the digit string is invalid
>and so more or less immediately stop to evaluate the passwd string.  The
>
>  if (!*buf)
>
>in parse_pwd should then be moved behind grabbing the gid.  What do you
>think?  (Same for parse_grp, btw.)


I understand your idea, but not the details. See comments in the code above.

Currently parse_pwd doesn't perform any check at all, while
parse_grp does some. As far as I know neither approach has ever led
to complaints.

I was afraid that badly formed passwd entries (e.g. comments) in the file 
could lead to internal pw_passwd fields being empty, and thus to 
security holes. The fields following the gid are less important.

Besides that I am not sure if there is much value in being strict. Also
is there a standard? For example can there be blank spaces between 
the uid digits and the delimiting ":"?  
Feel free to go ahead with more checks. 


>> @@ -166,12 +140,8 @@ read_etc_passwd ()
>>    passwd_lock here (cygwin_finished_initializing);
>> 

>> @@ -183,6 +153,7 @@ read_etc_passwd ()
>>  	  pr.close ();
>>  	  debug_printf ("Read /etc/passwd, %d lines", curr_lines);
>>  	}
>> +      passwd_state = loaded;
>
>Uhm?  That looks incorrect.  It shouldn't enter the initializing state
>if the state is already set to initializing which means another thread
>is currently initializing. (Same in read_etc_group())

I think it's OK. 
However with your previous suggestions the line can be completely removed.
Good style leads to simplicity :)


Instead of sending you patches of all 9 files, I am enclosing incremental
ChangeLog and patches, on top of the previous ones.

Pierre

2002-11-29  Pierre Humblet <pierre.humblet@ieee.org>

	* pwdgrp.h: enum pwdgrp_state, remove initializing, add initialized.
	(pwdgrp_check::pwdgrp_state) Replace by pwdgrp_check::ismustread ().
	(pwdgrp_check::ismustread) Create.
 	(pwdgrp_check::operator =) Delete.
	* passwd.cc (read_etc_passwd): Replace "passwd_state <= " by 
	passwd_state::ismustread (). Remove update of passwd_state.	
	(internal_getpwuid): Replace "passwd_state <= " by 
	passwd_state::ismustread ().
	(internal_getpwnam): Ditto.
	(getpwent): Ditto.
	(getpass): Ditto.
	* grp.cc (read_etc_group): Replace "group_state <= " by 
	group_state::ismustread (). Remove update of group_state.	
	(internal_getgrgid): Replace "group_state <= " by 
	group_state::ismustread ().
	(getgrent32): Ditto.
	(internal_getgrent): Ditto.


--=====================_1038567577==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pwd2.diff"
Content-length: 4707

--- pwdgrp.h.new	2002-11-28 23:17:54.000000000 -0500
+++ pwdgrp.h	2002-11-29 00:37:38.000000000 -0500
@@ -23,8 +23,7 @@ int internal_getgroups (int, __gid32_t *

 enum pwdgrp_state {
   uninitialized =3D 0,
-  initializing,
-  loaded
+  initialized,
 };

 class pwdgrp_check {
@@ -34,25 +33,31 @@ class pwdgrp_check {

 public:
   pwdgrp_check () : state (uninitialized) {}
-  operator pwdgrp_state ()
+  BOOL ismustread ()
     {
-      if (state !=3D uninitialized && file_w32[0] && cygheap->etc_changed =
())
-	{
-	  HANDLE h;
-	  WIN32_FIND_DATA data;
-
-	  if ((h =3D FindFirstFile (file_w32, &data)) !=3D INVALID_HANDLE_VALUE)
+      BOOL res =3D FALSE;
+      if (state =3D=3D uninitialized)
+        {
+	  state =3D initialized;
+	  res =3D TRUE;
+	}
+      else if (cygheap->etc_changed ())
+        {
+	  if (!file_w32[0])
+	    res =3D TRUE;
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
+		  res =3D (CompareFileTime (&data.ftLastWriteTime, &last_modified) > 0);
+		  FindClose (h);
+		}
 	    }
 	}
-      return state;
-    }
-  void operator =3D (pwdgrp_state nstate)
-    {
-      state =3D nstate;
+      return res;
     }
   BOOL isuninitialized () const { return state =3D=3D uninitialized; }
   void set_last_modified (HANDLE fh, const char *name)
--- passwd.cc.new	2002-11-28 23:26:28.000000000 -0500
+++ passwd.cc	2002-11-29 00:38:12.000000000 -0500
@@ -140,7 +140,7 @@ read_etc_passwd ()
   passwd_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_passwd may have been process=
ed */
-  if (passwd_state <=3D initializing)
+  if (passwd_state.ismustread ())
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
+      || (check && passwd_state.ismustread ()))
     read_etc_passwd ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -229,7 +228,7 @@ struct passwd *
 internal_getpwnam (const char *name, BOOL check)
 {
   if (passwd_state.isuninitialized ()
-      || (check && passwd_state  <=3D initializing))
+      || (check && passwd_state.ismustread ()))
     read_etc_passwd ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -351,7 +350,7 @@ getpwnam_r (const char *nam, struct pass
 extern "C" struct passwd *
 getpwent (void)
 {
-  if (passwd_state  <=3D initializing)
+  if (passwd_state.ismustread ())
     read_etc_passwd ();

   if (pw_pos < curr_lines)
@@ -394,7 +393,7 @@ getpass (const char * prompt)
 #endif
   struct termios ti, newti;

-  if (passwd_state  <=3D initializing)
+  if (passwd_state.ismustread ())
     read_etc_passwd ();

   cygheap_fdget fhstdin (0);
--- grp.cc.new	2002-11-28 23:30:04.000000000 -0500
+++ grp.cc	2002-11-29 00:44:56.000000000 -0500
@@ -135,7 +135,7 @@ read_etc_group ()
   group_lock here (cygwin_finished_initializing);

   /* if we got blocked by the mutex, then etc_group may have been processe=
d */
-  if (group_state <=3D initializing)
+  if (group_state.ismustread ())
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
+      || (check && group_state.ismustread ()))
     read_etc_group ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -216,7 +215,7 @@ struct __group32 *
 internal_getgrnam (const char *name, BOOL check)
 {
   if (group_state.isuninitialized ()
-      || (check && group_state  <=3D initializing))
+      || (check && group_state.ismustread ()))
     read_etc_group ();

   for (int i =3D 0; i < curr_lines; i++)
@@ -281,7 +280,7 @@ endgrent ()
 extern "C" struct __group32 *
 getgrent32 ()
 {
-  if (group_state  <=3D initializing)
+  if (group_state.ismustread ())
     read_etc_group ();

   if (grp_pos < curr_lines)

--=====================_1038567577==_--
