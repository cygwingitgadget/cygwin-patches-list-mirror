Return-Path: <cygwin-patches-return-6755-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3761 invoked by alias); 9 Oct 2009 21:42:51 -0000
Received: (qmail 3740 invoked by uid 22791); 9 Oct 2009 21:42:49 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 09 Oct 2009 21:42:44 +0000
Received: from fwd03.aul.t-online.de  	by mailout09.t-online.de with smtp  	id 1MwNEX-00021S-00; Fri, 09 Oct 2009 23:42:41 +0200
Received: from [10.3.2.2] (bKCQFZZX8hxC2-dPPWkw9pkv6tE--i0qN7JDfYgOWbD0acbga62Di5+eQ41PzMSgXJ@[217.235.234.183]) by fwd03.aul.t-online.de 	with esmtp id 1MwNEU-0JGnVA0; Fri, 9 Oct 2009 23:42:38 +0200
Message-ID: <4ACFAE4D.90502@t-online.de>
Date: Fri, 09 Oct 2009 21:42:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090825 SeaMonkey/1.1.18
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de> <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de>
In-Reply-To: <20091004200843.GK4563@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------020000050809080008020700"
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
X-SW-Source: 2009-q4/txt/msg00086.txt.bz2

This is a multi-part message in MIME format.
--------------020000050809080008020700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2885

Corinna Vinschen wrote:
> ...and maybe it's time to create a cygwin_internal call which replaces
> cygwin_set_impersonation_token and deprecate cygwin_set_impersonation_token
> in the long run.  So, instead of the above we could have this call
> taking a HANDLE and a BOOL value:
>
>   cygwin_internal (CW_SET_EXTERNAL_TOKEN, token_handle, restricted?);
>
>
>   

Attached a patch (based on your patch) which works for me on XP SP3.

Note that unlike with setuid(other_uid), fork() and exec() do not fail 
for non-system processes.


A simple Testcase: Exec with most privileges removed:

int main(int argc, char **argv)
{
  if (argc < 2) {
    printf("Usage: %s command args ...\n", argv[0]); return 1;
  }

  HANDLE pt, rt;
  if (!OpenProcessToken(GetCurrentProcess (), TOKEN_ALL_ACCESS, &pt)) {
    printf("OpenProcessToken failed\n"); return 1;
  }
  if (!CreateRestrictedToken(pt, DISABLE_MAX_PRIVILEGE,
      0, (PSID_AND_ATTRIBUTES)0, 0, (PLUID_AND_ATTRIBUTES)0,
      0, (PSID_AND_ATTRIBUTES)0, &rt)) {
    printf("CreateRestrictedToken failed\n"); return 1;
  }
  if (!SetHandleInformation(rt, HANDLE_FLAG_INHERIT,
      HANDLE_FLAG_INHERIT)) {
    printf("SetHandleInformation failed\n"); return 1;
  }

  cygwin_internal(CW_SET_EXTERNAL_TOKEN, rt, CW_TOKEN_RESTRICTED);

  // seteuid(getuid()) would allow child to revert to original privileges.
  setuid(getuid());

  execvp(argv[1], argv+1);
  perror("exec");
  return 1;
}

Running e.g. 'ls /proc/registry/HKEY_LOCAL_MACHINE/SECURITY' from an 
admin with and without the above program shows the difference.
(The process is not really restricted because the admin group is not 
removed :-)


I would suggest to add another cygwin_internal() call to check if 
current process is considered 'equivalent root'. This could be used e.g. 
by shells to set the root prompt properly.
http://sourceware.org/ml/cygwin/2009-09/msg00138.html

Christian

2009-10-09  Christian Franke  <franke@computer.org>
            Corinna Vinschen  <corinna@vinschen.de>

	* include/sys/cygwin.h: Add new cygwin_getinfo_type
	CW_SET_EXTERNAL_TOKEN.
	Add new enum CW_TOKEN_IMPERSONATION, CW_TOKEN_RESTRICTED.
	* cygheap.h (cyguser): New flags ext_token_is_restricted,
	curr_token_is_restricted and setuid_to_restricted.
	* external.cc (cygwin_internal): Add CW_SET_EXTERNAL_TOKEN.
	* fork.cc (frok::child): Abort if reimpersonate fails.
	* sec_auth.cc (cygwin_set_impersonation_token): Set
	ext_token_is_restricted flag.
	* spawn.cc (spawn_guts): Use CreateProcessAsUserW if
	restricted token was enabled by setuid ().
	Do not create new window station in this case.
	* syscalls.cc (seteuid32): Add handling of restricted
	external tokens.
	(setuid32): Set setuid_to_restricted flag.
	* uinfo.cc (uinfo_init): Do not reimpersonate if
	restricted token was enabled by setuid ().
	Abort if reimpersonate fails.
	Initialize user.*_restricted flags.



--------------020000050809080008020700
Content-Type: text/x-diff;
 name="cygwin-1.7-restricted-token.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.7-restricted-token.patch"
Content-length: 9688

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
index 38b8c71..9b030c9 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -413,6 +413,15 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	  int useTerminateProcess = va_arg (arg, int);
 	  exit_process (status, !!useTerminateProcess); /* no return */
 	}
+      case CW_SET_EXTERNAL_TOKEN:
+	{
+	  HANDLE token = va_arg (arg, HANDLE);
+	  int type = va_arg (arg, int);
+	  cygheap->user.external_token = (token == INVALID_HANDLE_VALUE
+	      ? NO_IMPERSONATION : token);
+	  cygheap->user.ext_token_is_restricted = (type == CW_TOKEN_RESTRICTED);
+	}
+	break;
 
       default:
 	break;
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 49ff2e1..5ae69c7 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -188,7 +188,10 @@ frok::child (volatile char * volatile here)
 
   set_cygwin_privileges (hProcToken);
   clear_procimptoken ();
-  cygheap->user.reimpersonate ();
+
+  if (!cygheap->user.reimpersonate ())
+    /* User possibly set an external token without HANDLE_FLAG_INHERIT.  */
+    api_fatal ("reimpersonate after fork failed (%d)", (int)GetLastError());
 
 #ifdef DEBUGGING
   if (GetEnvironmentVariableA ("FORKDEBUG", NULL, 0))
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
index 028b5a8..c84a7e5 100644
--- a/winsup/cygwin/sec_auth.cc
+++ b/winsup/cygwin/sec_auth.cc
@@ -35,6 +35,7 @@ cygwin_set_impersonation_token (const HANDLE hToken)
 {
   debug_printf ("set_impersonation_token (%d)", hToken);
   cygheap->user.external_token = hToken == INVALID_HANDLE_VALUE ? NO_IMPERSONATION : hToken;
+  cygheap->user.ext_token_is_restricted = false;
 }
 
 void
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
index 1529cb6..5cfad3b 100644
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
@@ -2686,6 +2707,21 @@ seteuid32 (__uid32_t uid)
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
+	}
+    }
   /* TODO, CV 2008-11-25: The check against saved_sid is a kludge and a
      shortcut.  We must check if it's really feasible in the long run.
      The reason to add this shortcut is this:  sshd switches back to the
@@ -2701,7 +2737,7 @@ seteuid32 (__uid32_t uid)
      Therefore we try this shortcut now.  When switching back to the
      privileged user, we probably always want a correct (aka original)
      user token for this privileged user, not only in sshd. */
-  if ((uid == cygheap->user.saved_uid && usersid == cygheap->user.saved_sid ())
+  else if ((uid == cygheap->user.saved_uid && usersid == cygheap->user.saved_sid ())
       || verify_token (hProcToken, usersid, groups))
     new_token = hProcToken;
   /* Verify if the external token is suitable */
@@ -2763,9 +2799,12 @@ seteuid32 (__uid32_t uid)
 
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
@@ -2790,6 +2829,8 @@ seteuid32 (__uid32_t uid)
   cygheap->user.set_sid (usersid);
   cygheap->user.curr_primary_token = new_token == hProcToken ? NO_IMPERSONATION
 							: new_token;
+  cygheap->user.curr_token_is_restricted = false;
+  cygheap->user.setuid_to_restricted = false;
   if (cygheap->user.curr_imp_token != NO_IMPERSONATION)
     {
       CloseHandle (cygheap->user.curr_imp_token);
@@ -2805,6 +2846,7 @@ seteuid32 (__uid32_t uid)
 	  cygheap->user.curr_primary_token = NO_IMPERSONATION;
 	  return -1;
 	}
+      cygheap->user.curr_token_is_restricted = request_restricted_uid_switch;
       set_cygwin_privileges (cygheap->user.curr_primary_token);
       set_cygwin_privileges (cygheap->user.curr_imp_token);
     }
@@ -2835,7 +2877,11 @@ setuid32 (__uid32_t uid)
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
index 8adfd37..56c2f47 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -136,9 +136,12 @@ uinfo_init ()
   else if (cygheap->user.issetuid ()
 	   && cygheap->user.saved_uid == cygheap->user.real_uid
 	   && cygheap->user.saved_gid == cygheap->user.real_gid
-	   && !cygheap->user.groups.issetgroups ())
+	   && !cygheap->user.groups.issetgroups ()
+	   && !cygheap->user.setuid_to_restricted)
     {
-      cygheap->user.reimpersonate ();
+      if (!cygheap->user.reimpersonate ())
+	/* User possibly set an external token without HANDLE_FLAG_INHERIT.  */
+	api_fatal ("reimpersonate after exec failed (%d)", (int)GetLastError());
       return;
     }
   else
@@ -150,6 +153,9 @@ uinfo_init ()
   cygheap->user.internal_token = NO_IMPERSONATION;
   cygheap->user.curr_primary_token = NO_IMPERSONATION;
   cygheap->user.curr_imp_token = NO_IMPERSONATION;
+  cygheap->user.ext_token_is_restricted = false;
+  cygheap->user.curr_token_is_restricted = false;
+  cygheap->user.setuid_to_restricted = false;
   cygheap->user.set_saved_sid ();	/* Update the original sid */
   cygheap->user.reimpersonate ();
 }

--------------020000050809080008020700--
