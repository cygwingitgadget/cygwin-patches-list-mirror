Return-Path: <cygwin-patches-return-6683-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24460 invoked by alias); 4 Oct 2009 12:30:24 -0000
Received: (qmail 24440 invoked by uid 22791); 4 Oct 2009 12:30:21 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Oct 2009 12:30:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id BC8A46D5598; Sun,  4 Oct 2009 14:30:06 +0200 (CEST)
Date: Sun, 04 Oct 2009 12:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20091004123006.GF4563@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de> <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090901183209.GA14650@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00014.txt.bz2

Hi Christian,

On Sep  1 20:32, Corinna Vinschen wrote:
> On Aug 30 21:38, Christian Franke wrote:
> > Corinna Vinschen wrote:
> >> If you plan to run a Cygwin application with restricted rights from your
> >> administrative account, the IMHO right way would be to start the Cygwin
> >> application through another application which creates a *really*
> >> restricted user token using the Win32 function CreateRestrictedToken and
> >> then call cygwin_set_impersonation_token/execv to start the restricted
> >> process.  A Cygwin tool which accomplishes that would be much more
> >> useful and much more generic than this patch, IMHO.
> >>
> >>   
> > I agree, let's forget the patch.
> >
> > But I'm not sure how cygwin_set_impersonation_token() could be of any  
> > help here. This function sets user.external_token which is only used in  
> > seteuid32(). Setuid/seteuid() cannot be used because the restricted  
> > token is not related to another user id.
> 
> I had a quick look into the seteuid code and I see the problem.  I don't
> see a quick way around it, unfortunately.  I'll have a deeper look into
> it when I'm back from vacation.

It took some time, but today it occured to me how we could solve this
issue.

The functionality we're talking about is not creating a new token from
scratch, like an external call to LogonUser would create.  It's just
creating a restricted token for the same user, and fortunately there's a
function IsTokenRestricted() in the Win32 API, available since Windows
2000.

However, we can't just simply test for a restricted token since
restricted tokens are used a lot under UAC starting with Windows Vista.
Therefore the idea is that a restricted token is only recogized as a
special case if you call setuid(getuid()) or seteuid(geteuid()).

So, to use a restricted token, you call code along these lines:

  restricted_token = CreateRestrictedToken();
  /* Switch to restricted token. */
  cygwin_set_impersonation_token (restricted_token);
  setuid (getuid ());
  /* Do stuff with restricted rights */
  [...]
  /* Revert process to original token. */
  cygwin_set_impersonation_token (INVALID_HANDLE_VALUE);
  setuid (getuid ());

I created a patch to seteuid32 which compiles fine.  It just needs
testing.  Since you're interested in this functionality in the first
place, I thought you might consider to give this a nice, thorough test.

Patch attached.  For simplicity I just applied the patch to the w32api
winbase.h header file which defines CreateRestrictedToken and
IsTokenRestricted.


Thanks,
Corinna


	* autoload.cc (IsTokenRestricted): Define.
	* syscalls.cc (seteuid32): Create special case for restricted
	external tokens to switch to a restricted token for the current
	user.


Index: autoload.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.165
diff -u -p -r1.165 autoload.cc
--- autoload.cc	22 Sep 2009 14:27:57 -0000	1.165
+++ autoload.cc	4 Oct 2009 12:24:56 -0000
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
+++ syscalls.cc	4 Oct 2009 12:24:57 -0000
@@ -2664,7 +2664,30 @@ seteuid32 (__uid32_t uid)
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
+	     && IsTokenRestricted (cygheap->user.curr_primary_token)));
+  if (uid == myself->uid && !cygheap->user.groups.ischanged
+      && !request_restricted_uid_switch)
     {
       debug_printf ("Nothing happens");
       return 0;
@@ -2686,6 +2709,21 @@ seteuid32 (__uid32_t uid)
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


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
