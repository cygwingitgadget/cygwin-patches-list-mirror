Return-Path: <cygwin-patches-return-4964-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 542 invoked by alias); 15 Sep 2004 02:31:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 529 invoked from network); 15 Sep 2004 02:31:34 -0000
Message-ID: <n2m-g.ci8g43.3vvdv5l.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] getfacl -n layout not upto spec.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Wed, 15 Sep 2004 02:31:00 -0000
X-SW-Source: 2004-q3/txt/msg00116.txt.bz2

Hi,

I noticed, getfacl -n ... returns badly formatted
output like:

...
group:544
rwx
..

instead of:

...
group:544:rwx
...

This (trivial, I think) patch fixes that.

--- src/winsup/utils/getfacl.c	11 Sep 2003 07:55:51 -0000	1.11
+++ src/winsup/utils/getfacl.c	14 Sep 2004 21:21:45 -0000
@@ -229,7 +229,7 @@ main (int argc, char **argv)
 	      break;
 	    case USER:
 	      if (nopt)
-		printf ("user:%lu\n", (unsigned long)acls[i].a_id);
+		printf ("user:%lu:", (unsigned long)acls[i].a_id);
 	      else
 		printf ("user:%s:", username (acls[i].a_id));
 	      break;
@@ -238,7 +238,7 @@ main (int argc, char **argv)
 	      break;
 	    case GROUP:
 	      if (nopt)
-		printf ("group:%lu\n", (unsigned long)acls[i].a_id);
+		printf ("group:%lu:", (unsigned long)acls[i].a_id);
 	      else
 		printf ("group:%s:", groupname (acls[i].a_id));
 	      break;


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
