Return-Path: <cygwin-patches-return-3314-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19685 invoked by alias); 13 Dec 2002 14:59:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19653 invoked from network); 13 Dec 2002 14:59:46 -0000
Message-ID: <3DF9F616.F1511B8D@ieee.org>
Date: Fri, 13 Dec 2002 06:59:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Small security patches
References: <3DF76981.86674258@ieee.org> <20021211192211.GD29798@redhat.com> <3DF7A670.E7BA1862@ieee.org> <20021211210349.GB31049@redhat.com> <3DF8BA7A.37C82FE5@ieee.org> <20021213133801.A17831@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00265.txt.bz2


Corinna,

Until the initialization issue is settled, here is a patch covering
only the internationalization of security.cc
It should go in the next cygwin, and I always prefer when there
is a sufficiently long bake time.

Pierre

2002/12/13  Pierre Humblet  <pierre.humblet@ieee.org>

        * security.cc (get_user_local_groups): Use LookupAccountSid to find the
        local equivalent of BUILTIN.


Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.128
diff -u -p -r1.128 security.cc
--- security.cc	10 Dec 2002 12:43:49 -0000	1.128
+++ security.cc	13 Dec 2002 02:35:32 -0000
@@ -389,16 +389,19 @@ get_user_local_groups (cygsidlist &grp_l
       return FALSE;
     }
 
-  char bgroup[sizeof ("BUILTIN\\") + GNLEN] = "BUILTIN\\";
+  char bgroup[INTERNET_MAX_HOST_NAME_LENGTH + GNLEN + 2];
   char lgroup[INTERNET_MAX_HOST_NAME_LENGTH + GNLEN + 2];
-  const DWORD blen = sizeof ("BUILTIN\\") - 1;
-  DWORD llen = INTERNET_MAX_HOST_NAME_LENGTH + 1;
-  if (!GetComputerNameA (lgroup, &llen))
+  DWORD blen, llen;
+  SID_NAME_USE use;
+
+  blen = llen = INTERNET_MAX_HOST_NAME_LENGTH + 1;
+  if (!LookupAccountSid (NULL, well_known_admins_sid, lgroup, &llen, bgroup, &blen, &use)
+      || !GetComputerNameA (lgroup, &(llen = INTERNET_MAX_HOST_NAME_LENGTH + 1)))
     {
       __seterrno ();
       return FALSE;
     }
-  lgroup[llen++] = '\\';
+  bgroup[blen++] = lgroup[llen++] = '\\';
 
   for (DWORD i = 0; i < cnt; ++i)
     if (is_group_member (buf[i].lgrpi0_name, pusersid, grp_list))
@@ -407,8 +410,8 @@ get_user_local_groups (cygsidlist &grp_l
 	DWORD glen = sizeof (gsid);
 	char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
 	DWORD dlen = sizeof (domain);
-	SID_NAME_USE use = SidTypeInvalid;
 
+	use = SidTypeInvalid;
 	sys_wcstombs (bgroup + blen, buf[i].lgrpi0_name, GNLEN + 1);
 	if (!LookupAccountName (NULL, bgroup, gsid, &glen, domain, &dlen, &use))
 	  {
