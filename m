Return-Path: <cygwin-patches-return-2683-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26801 invoked by alias); 23 Jul 2002 12:55:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26715 invoked from network); 23 Jul 2002 12:55:13 -0000
Date: Tue, 23 Jul 2002 05:55:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Cc: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Corinna or Pierre please comment? [jason@tishler.net: Re: setuid
Message-ID: <20020723145510.C13588@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>,
	"Pierre A. Humblet" <Pierre.Humblet@ieee.org>
References: <3.0.5.32.20020718211250.0080a5e0@mail.attbi.com> <20020719102328.E6932@cygbert.vinschen.de> <3D382572.5BEF1C2C@ieee.org> <20020719170639.R6932@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719170639.R6932@cygbert.vinschen.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00131.txt.bz2

Pierre,

since your patch is applied, Cygwin handles user switches even when
the DC isn't available.  Now, in another thread in the cygwin ml,
there's a report of a situation, where the DC *is* available but
it doesn't allow anonymous access to request the group list.
NetUserGetGroups() returns ERROR_ACCESS_DENIED.  This can happen
on 2K and .NET servers according to 

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/netmgmt/ntlmapi2_10xf.asp

(see the Remarks section).

So we still have a problem, even if the DC is accessible.  We could
solve that by not failing silently if the get_user_groups() function
fails:

Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.115
diff -u -p -r1.115 security.cc
--- security.cc	19 Jul 2002 23:48:17 -0000	1.115
+++ security.cc	23 Jul 2002 12:52:41 -0000
@@ -526,9 +526,8 @@ get_group_sidlist (cygsidlist &grp_list,
 	}
       extract_nt_dom_user (pw, domain, user);
       /* Fail silently if DC is not reachable */
-      if (get_logon_server (domain, server, wserver) &&
-	  !get_user_groups (wserver, grp_list, user, domain))
-	return FALSE;
+      if (get_logon_server (domain, server, wserver))
+	get_user_groups (wserver, grp_list, user, domain);
       get_unix_group_sidlist (pw, grp_list);
       if (!get_user_local_groups (grp_list, usersid))
 	return FALSE;

What do you think?  Somehow I hate to soften the behaviour but it
seems to be inescapable...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
