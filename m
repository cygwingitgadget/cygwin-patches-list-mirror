Return-Path: <cygwin-patches-return-2578-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14746 invoked by alias); 2 Jul 2002 03:23:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14732 invoked from network); 2 Jul 2002 03:23:14 -0000
Message-Id: <3.0.5.32.20020701231704.0080f800@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 01 Jul 2002 20:23:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Windows username in get_group_sidlist
In-Reply-To: <20020630151013.H1247@cygbert.vinschen.de>
References: <3.0.5.32.20020629191915.0080d930@mail.attbi.com>
 <3D1726E7.4EC19839@ieee.org>
 <3.0.5.32.20020623235117.008008f0@mail.attbi.com>
 <20020624120506.Z22705@cygbert.vinschen.de>
 <20020624130226.GA19789@redhat.com>
 <20020624151450.G22705@cygbert.vinschen.de>
 <3D1726E7.4EC19839@ieee.org>
 <3.0.5.32.20020629191915.0080d930@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00026.txt.bz2

At 03:10 PM 6/30/2002 +0200, Corinna Vinschen wrote:
>> 	(get_group_sidlist): Obtain the domain and user by calling 
>> 	extract_nt_dom_user instead of LookupAccountSid.
>
>Thanks, Pierre.  I've applied the "soft" version.

Corinna,

To make use of the "soft" nature of extract_nt_dom_user,
get_logon_server () must interpret domain == ""
as the local domain. This is done in the patch below.

There is another change in verify_token. A token is now
accepted if the requested primary group is the token user,
even if the requested primary group is not in the token groups.

That makes sense from an access control point of view, and it's 
also helpful for SYSTEM:
I belatedly discovered that the groups of the SYSTEM token
(when running a service) are "everyone" and "administrators" 
(but NOT "system" !) on NT. On Win2000, there is also
"authenticated users".

To imitate Windows, line 495 in security.cc       
grp_list += well_known_system_sid;
should thus be replaced by 
grp_list += well_known_authenticated_users_sid;

(just do it if you like it, it's not in the patch).

Pierre

2002-07-01  Pierre Humblet <pierre.humblet@ieee.org>

	* security.cc (get_logon_server): Interpret a zero length
	domain as the local domain.
	(verify_token): Accept the primary group sid if it equals
	the token user sid.

--- security.cc.orig    2002-06-30 12:18:58.000000000 -0400
+++ security.cc 2002-06-30 21:30:08.000000000 -0400
@@ -246,6 +246,8 @@
 }
 #endif
 
+/* domain == "" means the local domain. 
+   wserver can be NULL */
 BOOL
 get_logon_server (const char *domain, char *server, WCHAR *wserver)
 {
@@ -255,7 +257,7 @@
   DWORD size = INTERNET_MAX_HOST_NAME_LENGTH + 1;
 
   if ((GetComputerName (server + 2, &size)) &&
-      strcasematch (domain, server + 2))
+      (strcasematch (domain, server + 2) || !domain[0]))
     {
       server[0] = server[1] = '\\';
       if (wserver)
@@ -698,10 +700,12 @@
           debug_printf ("GetSecurityDescriptorGroup(): %E");
        if (well_known_null_sid != gsid) return pgrpsid == gsid;
     }
-  /* See if the pgrpsid is in the token groups */
+  /* See if the pgrpsid is the tok_usersid or in the token groups */
   PTOKEN_GROUPS my_grps = NULL;
   BOOL ret = FALSE;
 
+  if ( pgrpsid == tok_usersid) 
+    return TRUE;
   if (!GetTokenInformation (token, TokenGroups, NULL, 0, &size) &&
       GetLastError () != ERROR_INSUFFICIENT_BUFFER)
     debug_printf ("GetTokenInformation(token, TokenGroups): %E\n");
