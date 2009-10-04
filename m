Return-Path: <cygwin-patches-return-6684-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31219 invoked by alias); 4 Oct 2009 12:55:13 -0000
Received: (qmail 31206 invoked by uid 22791); 4 Oct 2009 12:55:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Oct 2009 12:55:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 55AB26D5598; Sun,  4 Oct 2009 14:54:55 +0200 (CEST)
Date: Sun, 04 Oct 2009 12:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20091004125455.GG4563@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de> <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091004123006.GF4563@calimero.vinschen.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00015.txt.bz2

On Oct  4 14:30, Corinna Vinschen wrote:
> [...]
> Patch attached.  For simplicity I just applied the patch to the w32api
> winbase.h header file which defines CreateRestrictedToken and
> IsTokenRestricted.
> 
> 
> Thanks,
> Corinna
> 
> 
> 	* autoload.cc (IsTokenRestricted): Define.
> 	* syscalls.cc (seteuid32): Create special case for restricted
> 	external tokens to switch to a restricted token for the current
> 	user.

New patch attached.  I made the test a bit more foolproof, hopefully.
And a restricted token does not require to load the user's registry hive,
nor should Cygwin try to enable the backup/restore permissions in the
new token.  That spoils the idea of a restricted token a bit...


Corinna


Index: autoload.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.165
diff -u -p -r1.165 autoload.cc
--- autoload.cc	22 Sep 2009 14:27:57 -0000	1.165
+++ autoload.cc	4 Oct 2009 12:54:15 -0000
@@ -422,6 +422,8 @@ LoadDLLfuncEx (GetSystemDEPPolicy, 0, ke
 LoadDLLfuncEx (GetProcessDEPPolicy, 12, kernel32, 1)
 LoadDLLfuncEx (SetProcessDEPPolicy, 4, kernel32, 1)
 
+LoadDLLfunc (IsTokenRestricted, 4, advapi32)
+
 LoadDLLfunc (SHGetDesktopFolder, 4, shell32)
 
 LoadDLLfuncEx (waveOutGetNumDevs, 0, winmm, 1)
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.540
diff -u -p -r1.540 syscalls.cc
--- syscalls.cc	4 Oct 2009 11:32:07 -0000	1.540
+++ syscalls.cc	4 Oct 2009 12:54:17 -0000
@@ -2664,7 +2664,31 @@ seteuid32 (__uid32_t uid)
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
+       cygwin_set_impersonation_token (restricted_token);
+       setuid (getuid ());
+       [...do stuff with restricted rights...]
+       cygwin_set_impersonation_token (INVALID_HANDLE_VALUE);
+       setuid (getuid ());
+
+    Note that using the current uid is a requirement!  Starting with Windows
+    Vista, we have restricted tokens galore (UAC), so this is really just
+    a special case to restict your own processes to lesser rights. */
+  bool request_restricted_uid_switch =
+     uid == myself->uid
+     && (   (cygheap->user.external_token != NO_IMPERSONATION
+	     && IsTokenRestricted (cygheap->user.external_token))
+	 || (cygheap->user.external_token == NO_IMPERSONATION
+	     && cygheap->user.issetuid ()
+	     && IsTokenRestricted (cygheap->user.curr_primary_token)));
+  if (uid == myself->uid && !cygheap->user.groups.ischanged
+      && !request_restricted_uid_switch)
     {
       debug_printf ("Nothing happens");
       return 0;
@@ -2686,6 +2710,21 @@ seteuid32 (__uid32_t uid)
   cygheap->user.deimpersonate ();
 
   /* Verify if the process token is suitable. */
+  /* First of all, skip all checks if a switch to a restricted token has been
+     requested, or if trying to switch back from it. */
+  if (request_restricted_uid_switch)
+    {
+      if (cygheap->user.external_token != NO_IMPERSONATION)
+      	{
+	  debug_printf ("Switch to restricted token");
+	  new_token = cygheap->user.external_token;
+	}
+      else
+      	{
+	  debug_printf ("Switch back from restricted token");
+	  new_token = hProcToken;
+	}
+    }
   /* TODO, CV 2008-11-25: The check against saved_sid is a kludge and a
      shortcut.  We must check if it's really feasible in the long run.
      The reason to add this shortcut is this:  sshd switches back to the
@@ -2763,9 +2802,12 @@ seteuid32 (__uid32_t uid)
 
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
@@ -2805,7 +2847,8 @@ seteuid32 (__uid32_t uid)
 	  cygheap->user.curr_primary_token = NO_IMPERSONATION;
 	  return -1;
 	}
-      set_cygwin_privileges (cygheap->user.curr_imp_token);
+      if (!request_restricted_uid_switch)
+	set_cygwin_privileges (cygheap->user.curr_imp_token);
     }
   if (!cygheap->user.reimpersonate ())
     {

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
