Return-Path: <cygwin-patches-return-6757-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14821 invoked by alias); 11 Oct 2009 20:45:48 -0000
Received: (qmail 14805 invoked by uid 22791); 11 Oct 2009 20:45:45 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mailout02.t-online.de (HELO mailout02.t-online.de) (194.25.134.17)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 11 Oct 2009 20:45:37 +0000
Received: from fwd06.aul.t-online.de  	by mailout02.t-online.de with smtp  	id 1Mx5IM-0002pu-06; Sun, 11 Oct 2009 22:45:34 +0200
Received: from [10.3.2.2] (GuTqwBZDYhUgXmzmNmF8gEWIZlJqENeEhKZRBx16abTFkBMXREpfTwPYUKHhRQUZeM@[217.235.188.168]) by fwd06.aul.t-online.de 	with esmtp id 1Mx5IK-08g8i80; Sun, 11 Oct 2009 22:45:32 +0200
Message-ID: <4AD243ED.6080505@t-online.de>
Date: Sun, 11 Oct 2009 20:45:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090825 SeaMonkey/1.1.18
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de>
In-Reply-To: <20091010100831.GA13581@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------080109010309060806050301"
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
X-SW-Source: 2009-q4/txt/msg00088.txt.bz2

This is a multi-part message in MIME format.
--------------080109010309060806050301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 3984

Corinna Vinschen wrote:
> Thanks for the patch.  You did check that the normal setuid/seteuid
> cases still work, didn't you?
>
>   

Yes.

>> I would suggest to add another cygwin_internal() call to check if current 
>> process is considered 'equivalent root'. This could be used e.g. by shells 
>> to set the root prompt properly.
>> http://sourceware.org/ml/cygwin/2009-09/msg00138.html
>>     
>
> What's wrong with:
>
>   for i in $(id -G);
>   do
>     [ $i -eq 544 ] && PS1='# '
>   done
>
>   

Is OK, except if admin group is mapped to other gid (0?) in /etc/group.


A function that checks the token instead would IMO be helpful, e.g.:

#ifdef __CYGWIN__
  if (cygwin_internal (CW_IS_ROOT_EQUIV, flags?))
#else
  if (geteuid () == 0)
#endif



> The patch looks pretty good.  I have a few remarks, though.
>
>   

Thanks. New patch below.


> I would like it better to have the actual functionality concentrated in
> a function in sec_auth.cc.  A function `set_imp_token (HANDLE, int)'
> which is called from cygwin_internal and from cygwin_set_impersonation_token,
> for instance.  The debug output in cygwin_set_impersonation_token should
> be moved into set_imp_token, too.  What do you think?
>
>   

Good idea. Done.

>> -  cygheap->user.reimpersonate ();
>> +
>> +  if (!cygheap->user.reimpersonate ())
>> +    /* User possibly set an external token without HANDLE_FLAG_INHERIT.  */
>> +    api_fatal ("reimpersonate after fork failed (%d)", (int)GetLastError());
>>     
>
> This bugs me.  Wouldn't it be better if we call DuplicateHandleEx
> on the external token to make sure it's inheritable?  This would also
> require to call CloseHandle on an existing external token if
> a process calls cygwin_set_impersonation_token (INVALID_HANDLE_VALUE) or
> INVALID_HANDLE_VALUE (NULL), but that's not really much extra code to
> worry about.  Dropping any chance that fork or exec fail sounds worth
> it, IMHO.  I'm still blushing that this never occured to me before.
>
>   

I removed the error check and set HANDLE_FLAG_INHERIT in seteuid32().


>> @@ -2835,7 +2877,11 @@ setuid32 (__uid32_t uid)
>>  {
>>    int ret = seteuid32 (uid);
>>    if (!ret)
>> -    cygheap->user.real_uid = myself->uid;
>> +    {
>> +      cygheap->user.real_uid = myself->uid;
>> +      /* If restricted token, forget original privileges on exec ().  */
>> +      cygheap->user.setuid_to_restricted = cygheap->user.curr_token_is_restricted;
>> +    }
>>     
>
> Do I miss something or is the setuid_to_restricted flag equivalent to
> the curr_token_is_restricted flag anyway, and as such redundant?  If so,
> it would look nice to make setuid_to_restricted an inline method instead:
>
>   bool setuid_to_restricted () const { return curr_token_is_restricted; }
>
>   

setuid_to_restricted is only set in setuid32, not in seteuid32. If 
seteuid(geteuid()) is called, the behaviour is similar to the ruid != 
euid case: The exec()ed process can revert to the original token.

Christian

2009-10-11  Christian Franke  <franke@computer.org>
            Corinna Vinschen  <corinna@vinschen.de>

	* include/sys/cygwin.h: Add new cygwin_getinfo_type
	CW_SET_EXTERNAL_TOKEN.
	Add new enum CW_TOKEN_IMPERSONATION, CW_TOKEN_RESTRICTED.
	* cygheap.h (cyguser): New flags ext_token_is_restricted,
	curr_token_is_restricted and setuid_to_restricted.
	* external.cc (cygwin_internal): Add CW_SET_EXTERNAL_TOKEN.
	* sec_auth.cc (set_imp_token): New function.
	(cygwin_set_impersonation_token): Call set_imp_token ().
	* security.h (set_imp_token): New prototype.
	* spawn.cc (spawn_guts): Use CreateProcessAsUserW if
	restricted token was enabled by setuid ().
	Do not create new window station in this case.
	* syscalls.cc (seteuid32): Add handling of restricted
	external tokens. Set HANDLE_FLAG_INHERIT for primary token.
	(setuid32): Set setuid_to_restricted flag.
	* uinfo.cc (uinfo_init): Do not reimpersonate if
	restricted token was enabled by setuid ().
	Initialize user.*_restricted flags.



--------------080109010309060806050301
Content-Type: text/x-diff;
 name="cygwin-1.7-restricted-token-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.7-restricted-token-2.patch"
Content-length: 10568

diff --git a/winsup/cygwin/cygheap.h b/winsup/cygwin/cygheap.h
index 7a39de6..b8ffd3f 100644
--- a/winsup/cygwin/cygheap.h
+++ b/winsup/cygwin/cygheap.h
@@ -108,6 +108,9 @@ public:
   HANDLE internal_token;
   HANDLE curr_primary_token;
   HANDLE curr_imp_token;
+  bool ext_token_is_restricted;  /* external_token is restricted token */
+  bool curr_token_is_restricted; /* curr_primary_token is restricted token */
+  bool setuid_to_restricted;     /* switch to restricted token by setuid () */
 
   /* CGF 2002-06-27.  I removed the initializaton from this constructor
      since this class is always allocated statically.  That means that everything
diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
index 38b8c71..b099205 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -413,6 +413,13 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	  int useTerminateProcess = va_arg (arg, int);
 	  exit_process (status, !!useTerminateProcess); /* no return */
 	}
+      case CW_SET_EXTERNAL_TOKEN:
+	{
+	  HANDLE token = va_arg (arg, HANDLE);
+	  int type = va_arg (arg, int);
+	  set_imp_token (token, type);
+	  return 0;
+	}
 
       default:
 	break;
diff --git a/winsup/cygwin/include/sys/cygwin.h b/winsup/cygwin/include/sys/cygwin.h
index 5f38278..ce9bebf 100644
--- a/winsup/cygwin/include/sys/cygwin.h
+++ b/winsup/cygwin/include/sys/cygwin.h
@@ -143,9 +143,17 @@ typedef enum
     CW_SET_DOS_FILE_WARNING,
     CW_SET_PRIV_KEY,
     CW_SETERRNO,
-    CW_EXIT_PROCESS
+    CW_EXIT_PROCESS,
+    CW_SET_EXTERNAL_TOKEN
   } cygwin_getinfo_types;
 
+/* Token type for CW_SET_EXTERNAL_TOKEN */
+enum
+{
+  CW_TOKEN_IMPERSONATION = 0,
+  CW_TOKEN_RESTRICTED    = 1
+};
+
 #define CW_NEXTPID	0x80000000	/* or with pid to get next one */
 unsigned long cygwin_internal (cygwin_getinfo_types, ...);
 
diff --git a/winsup/cygwin/sec_auth.cc b/winsup/cygwin/sec_auth.cc
index 028b5a8..34e571f 100644
--- a/winsup/cygwin/sec_auth.cc
+++ b/winsup/cygwin/sec_auth.cc
@@ -30,11 +30,19 @@ details. */
 #include "cygserver_setpwd.h"
 #include <cygwin/version.h>
 
+void
+set_imp_token (HANDLE token, int type)
+{
+  debug_printf ("set_imp_token (%d, %d)", token, type);
+  cygheap->user.external_token = (token == INVALID_HANDLE_VALUE
+				  ? NO_IMPERSONATION : token);
+  cygheap->user.ext_token_is_restricted = (type == CW_TOKEN_RESTRICTED);
+}
+
 extern "C" void
 cygwin_set_impersonation_token (const HANDLE hToken)
 {
-  debug_printf ("set_impersonation_token (%d)", hToken);
-  cygheap->user.external_token = hToken == INVALID_HANDLE_VALUE ? NO_IMPERSONATION : hToken;
+  set_imp_token (hToken, CW_TOKEN_IMPERSONATION);
 }
 
 void
diff --git a/winsup/cygwin/security.h b/winsup/cygwin/security.h
index 781def9..d0cb226 100644
--- a/winsup/cygwin/security.h
+++ b/winsup/cygwin/security.h
@@ -366,6 +366,8 @@ extern "C" int acl32 (const char *, int, int, __acl32 *);
 int getacl (HANDLE, path_conv &, int, __acl32 *);
 int setacl (HANDLE, path_conv &, int, __acl32 *, bool &);
 
+/* Set impersonation or restricted token.  */
+void set_imp_token (HANDLE token, int type);
 /* Function creating a token by calling NtCreateToken. */
 HANDLE create_token (cygsid &usersid, user_groups &groups, struct passwd * pw);
 /* LSA authentication function. */
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 5c86c4b..a6ac9f0 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -537,7 +537,8 @@ loop:
   if (!cygheap->user.issetuid ()
       || (cygheap->user.saved_uid == cygheap->user.real_uid
 	  && cygheap->user.saved_gid == cygheap->user.real_gid
-	  && !cygheap->user.groups.issetgroups ()))
+	  && !cygheap->user.groups.issetgroups ()
+	  && !cygheap->user.setuid_to_restricted))
     {
       rc = CreateProcessW (runpath,	  /* image name - with full path */
 			   wone_line,	  /* what was passed to exec */
@@ -571,7 +572,8 @@ loop:
 	 risk, but we don't want to disable this behaviour for older
 	 OSes because it's still heavily used by some users.  They have
 	 been warned. */
-      if (wcscasecmp (wstname, L"WinSta0") != 0)
+      if (!cygheap->user.setuid_to_restricted
+	  && wcscasecmp (wstname, L"WinSta0") != 0)
 	{
 	  WCHAR sid[128];
 
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 1529cb6..aa112c4 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -2664,7 +2664,28 @@ seteuid32 (__uid32_t uid)
   debug_printf ("uid: %u myself->uid: %u myself->gid: %u",
 		uid, myself->uid, myself->gid);
 
-  if (uid == myself->uid && !cygheap->user.groups.ischanged)
+  /* Same uid as we're just running under is usually a no-op.
+
+     Except we have an external token which is a restricted token.  Or,
+     the external token is NULL, but the current impersonation token is
+     a restricted token.  This allows to restrict user rights temporarily
+     like this:
+
+       cygwin_internal(CW_SET_EXTERNAL_TOKEN, restricted_token,
+                       CW_TOKEN_RESTRICTED);
+       setuid (getuid ());
+       [...do stuff with restricted rights...]
+       cygwin_internal(CW_SET_EXTERNAL_TOKEN, INVALID_HANDLE_VALUE,
+                       CW_TOKEN_RESTRICTED);
+       setuid (getuid ());
+
+    Note that using the current uid is a requirement!  Starting with Windows
+    Vista, we have restricted tokens galore (UAC), so this is really just
+    a special case to restict your own processes to lesser rights. */
+  bool request_restricted_uid_switch = (uid == myself->uid
+      && cygheap->user.ext_token_is_restricted);
+  if (uid == myself->uid && !cygheap->user.groups.ischanged
+      && !request_restricted_uid_switch)
     {
       debug_printf ("Nothing happens");
       return 0;
@@ -2686,6 +2707,22 @@ seteuid32 (__uid32_t uid)
   cygheap->user.deimpersonate ();
 
   /* Verify if the process token is suitable. */
+  /* First of all, skip all checks if a switch to a restricted token has been
+     requested, or if trying to switch back from it. */
+  if (request_restricted_uid_switch)
+    {
+      if (cygheap->user.external_token != NO_IMPERSONATION)
+	{
+	  debug_printf ("Switch to restricted token");
+	  new_token = cygheap->user.external_token;
+	}
+      else
+	{
+	  debug_printf ("Switch back from restricted token");
+	  new_token = hProcToken;
+	  cygheap->user.ext_token_is_restricted = false;
+	}
+    }
   /* TODO, CV 2008-11-25: The check against saved_sid is a kludge and a
      shortcut.  We must check if it's really feasible in the long run.
      The reason to add this shortcut is this:  sshd switches back to the
@@ -2701,8 +2738,9 @@ seteuid32 (__uid32_t uid)
      Therefore we try this shortcut now.  When switching back to the
      privileged user, we probably always want a correct (aka original)
      user token for this privileged user, not only in sshd. */
-  if ((uid == cygheap->user.saved_uid && usersid == cygheap->user.saved_sid ())
-      || verify_token (hProcToken, usersid, groups))
+  else if ((uid == cygheap->user.saved_uid
+	   && usersid == cygheap->user.saved_sid ())
+	   || verify_token (hProcToken, usersid, groups))
     new_token = hProcToken;
   /* Verify if the external token is suitable */
   else if (cygheap->user.external_token != NO_IMPERSONATION
@@ -2763,9 +2801,12 @@ seteuid32 (__uid32_t uid)
 
   if (new_token != hProcToken)
     {
-      /* Avoid having HKCU use default user */
-      WCHAR name[128];
-      load_registry_hive (usersid.string (name));
+      if (!request_restricted_uid_switch)
+	{
+	  /* Avoid having HKCU use default user */
+	  WCHAR name[128];
+	  load_registry_hive (usersid.string (name));
+	}
 
       /* Try setting owner to same value as user. */
       if (!SetTokenInformation (new_token, TokenOwner,
@@ -2790,6 +2831,8 @@ seteuid32 (__uid32_t uid)
   cygheap->user.set_sid (usersid);
   cygheap->user.curr_primary_token = new_token == hProcToken ? NO_IMPERSONATION
 							: new_token;
+  cygheap->user.curr_token_is_restricted = false;
+  cygheap->user.setuid_to_restricted = false;
   if (cygheap->user.curr_imp_token != NO_IMPERSONATION)
     {
       CloseHandle (cygheap->user.curr_imp_token);
@@ -2797,14 +2840,19 @@ seteuid32 (__uid32_t uid)
     }
   if (cygheap->user.curr_primary_token != NO_IMPERSONATION)
     {
-      if (!DuplicateTokenEx (cygheap->user.curr_primary_token, MAXIMUM_ALLOWED,
-			     &sec_none, SecurityImpersonation,
-			     TokenImpersonation, &cygheap->user.curr_imp_token))
+      /* HANDLE_FLAG_INHERIT may be missing in external token.  */
+      if (!SetHandleInformation (cygheap->user.curr_primary_token,
+				 HANDLE_FLAG_INHERIT, HANDLE_FLAG_INHERIT)
+	  || !DuplicateTokenEx (cygheap->user.curr_primary_token,
+				MAXIMUM_ALLOWED, &sec_none,
+				SecurityImpersonation, TokenImpersonation,
+				&cygheap->user.curr_imp_token))
 	{
 	  __seterrno ();
 	  cygheap->user.curr_primary_token = NO_IMPERSONATION;
 	  return -1;
 	}
+      cygheap->user.curr_token_is_restricted = request_restricted_uid_switch;
       set_cygwin_privileges (cygheap->user.curr_primary_token);
       set_cygwin_privileges (cygheap->user.curr_imp_token);
     }
@@ -2835,7 +2883,11 @@ setuid32 (__uid32_t uid)
 {
   int ret = seteuid32 (uid);
   if (!ret)
-    cygheap->user.real_uid = myself->uid;
+    {
+      cygheap->user.real_uid = myself->uid;
+      /* If restricted token, forget original privileges on exec ().  */
+      cygheap->user.setuid_to_restricted = cygheap->user.curr_token_is_restricted;
+    }
   debug_printf ("real: %d, effective: %d", cygheap->user.real_uid, myself->uid);
   return ret;
 }
diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 8adfd37..a480f99 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -136,7 +136,8 @@ uinfo_init ()
   else if (cygheap->user.issetuid ()
 	   && cygheap->user.saved_uid == cygheap->user.real_uid
 	   && cygheap->user.saved_gid == cygheap->user.real_gid
-	   && !cygheap->user.groups.issetgroups ())
+	   && !cygheap->user.groups.issetgroups ()
+	   && !cygheap->user.setuid_to_restricted)
     {
       cygheap->user.reimpersonate ();
       return;
@@ -150,6 +151,9 @@ uinfo_init ()
   cygheap->user.internal_token = NO_IMPERSONATION;
   cygheap->user.curr_primary_token = NO_IMPERSONATION;
   cygheap->user.curr_imp_token = NO_IMPERSONATION;
+  cygheap->user.ext_token_is_restricted = false;
+  cygheap->user.curr_token_is_restricted = false;
+  cygheap->user.setuid_to_restricted = false;
   cygheap->user.set_saved_sid ();	/* Update the original sid */
   cygheap->user.reimpersonate ();
 }

--------------080109010309060806050301--
