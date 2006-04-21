Return-Path: <cygwin-patches-return-5832-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9848 invoked by alias); 21 Apr 2006 18:53:39 -0000
Received: (qmail 9838 invoked by uid 22791); 21 Apr 2006 18:53:39 -0000
X-Spam-Check-By: sourceware.org
Received: from vms044pub.verizon.net (HELO vms044pub.verizon.net) (206.46.252.44)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Apr 2006 18:53:36 +0000
Received: from PHUMBLETXP ([12.6.244.2])  by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep  9 2005)) with ESMTPA id <0IY300GRO5T6R9Q2@vms044.mailsrvcs.net> for  cygwin-patches@cygwin.com; Fri, 21 Apr 2006 13:53:30 -0500 (CDT)
Date: Fri, 21 Apr 2006 18:53:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
To: <cygwin-patches@cygwin.com>
Message-id: <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-transfer-encoding: 7bit
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com>  <20060421172328.GD7685@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00020.txt.bz2


----- Original Message ----- 
From: "Corinna Vinschen"
To: <cygwin-patches@cygwin.com>
Sent: Friday, April 21, 2006 1:23 PM
Subject: Re: [Patch] Make getenv() functional before the environment is 
initialized


> On Apr  6 12:35, Pierre A. Humblet wrote:
>>        * environ.cc (getearly): New function.
>>           (getenv) : Call getearly if needed.
>
> Thanks for the patch and sorry for the loooong delay.  I've applied a
> slightly tweaked version of your patch, which uses a function pointer in
> getenv, instead of adding a conditional.
>

Corinna,

Thanks! Since sending the patch, I have found some issues with it :(

In particular GetEnvironmentStrings returns a big block of
storage that should be free (which we can't do), and that is
going to be lost on a fork, potentially leading to trouble.

Thus I have another implementation using GetEnvironmentValue
and cmalloc. (with HEAP_1_MAX, so that it will be released
on the next exec).
I also take advantage of spawn_info, whose existence I had forgotten.
Overall it's also simpler.

Here is another patch, sorry for not sending this earlier.

Pierre

2006-04-21 Pierre Humblet Pierre.Humblet@ieee.org

        * environ.cc (getearly): Use GetEnvironmentVariable and cmalloc
        instead of GetEnvironmentStrings.

Index: environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.140
diff -u -p -b -r1.140 environ.cc
--- environ.cc  21 Apr 2006 17:21:41 -0000      1.140
+++ environ.cc  21 Apr 2006 18:37:55 -0000
@@ -231,28 +231,21 @@ my_findenv (const char *name, int *offse
 static char * __stdcall
 getearly (const char * name, int *offset __attribute__ ((unused)))
 {
-  int s = strlen (name);
-  char * rawenv;
-  char ** ptr;
-  child_info *get_cygwin_startup_info ();
-  child_info_spawn *ci = (child_info_spawn *) get_cygwin_startup_info ();
+  int s;
+  char ** ptr, * ret;

-  if (ci && (ptr = ci->moreinfo->envp))
+  if (spawn_info && (ptr = spawn_info->moreinfo->envp))
     {
+      s = strlen (name);
       for (; *ptr; ptr++)
        if (strncasematch (name, *ptr, s)
            && (*(*ptr + s) == '='))
          return *ptr + s + 1;
     }
-  else if ((rawenv = GetEnvironmentStrings ()))
-    {
-      while (*rawenv)
-       if (strncasematch (name, rawenv, s)
-           && (*(rawenv + s) == '='))
-         return rawenv + s + 1;
-       else
-         rawenv = strchr (rawenv, 0) + 1;
-    }
+  else if ((s = GetEnvironmentVariable (name, NULL, 0))
+          && (ret = (char *) cmalloc (HEAP_1_MAX, s))
+          && GetEnvironmentVariable (name, ret, s))
+    return ret;
   return NULL;
 }


