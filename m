Return-Path: <cygwin-patches-return-6402-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7364 invoked by alias); 5 Jan 2009 15:20:13 -0000
Received: (qmail 7354 invoked by uid 22791); 5 Jan 2009 15:20:12 -0000
X-SWARE-Spam-Status: No, hits=4.8 required=5.0 	tests=AWL,BAYES_50,BOTNET,HK_OBFDOM,J_CHICKENPOX_82
X-Spam-Check-By: sourceware.org
Received: from vms173007pub.verizon.net (HELO vms173007pub.verizon.net) (206.46.173.7)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Jan 2009 15:20:08 +0000
Received: from PHUMBLETLAPXP ([70.88.219.194]) by vms173007.mailsrvcs.net  (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))  with ESMTPA id <0KD000DZN7V2VAF0@vms173007.mailsrvcs.net> for  cygwin-patches@cygwin.com; Mon, 05 Jan 2009 09:18:44 -0600 (CST)
Date: Mon, 05 Jan 2009 15:20:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Make cygcheck handle Windows paths with spaces
To: <cygwin-patches@cygwin.com>
Message-id: <00eb01c96f49$163ecd00$640410ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
References: <00ad01c96abb$3ccee370$640410ac@wirelessworld.airvananet.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00000.txt.bz2

Oops, I didn't notice that one line required a double fix.

Pierre

2009-01-05  Pierre Humblet  <Pierre.Humblet@ieee.org>
 
        * cygcheck.cc (dump_sysinfo_services): Quote the path for popen.

Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.106
diff -u -p -r1.106 cygcheck.cc
--- cygcheck.cc 31 Dec 2008 01:44:36 -0000      1.106
+++ cygcheck.cc 5 Jan 2009 15:05:56 -0000
@@ -1137,7 +1137,7 @@ dump_sysinfo_services ()
   /* For verbose mode, just run cygrunsrv --list --verbose and copy output
      verbatim; otherwise run cygrunsrv --list and then cygrunsrv --query for
      each service.  */
-  snprintf (buf, sizeof (buf), (verbose ? "\"%s\" --list --verbose" : "%s --list"),
+  snprintf (buf, sizeof (buf), (verbose ? "\"%s\" --list --verbose" : "\"%s\" --list"),
            cygrunsrv);
   if ((f = popen (buf, "rt")) == NULL)
     {

----- Original Message ----- 
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
Sent: Tuesday, December 30, 2008 3:14 PM
Subject: [Patch] Make cygcheck handle Window paths with spaces


| Formatting is more likely to be preserved in the attached files.
| 
| Pierre 
| 
| 2008-12-30  Pierre Humblet  <Pierre.Humblet@ieee.org>
| 
|        * cygcheck.cc (pretty_id): Quote the path for popen.
|        (dump_sysinfo_services): Ditto.
| 
| 
| Index: cygcheck.cc
| ===================================================================
| RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
| retrieving revision 1.105
| diff -u -p -r1.105 cygcheck.cc
| --- cygcheck.cc 12 Sep 2008 22:43:10 -0000 1.105
| +++ cygcheck.cc 30 Dec 2008 19:20:32 -0000
| @@ -1032,9 +1032,10 @@ pretty_id (const char *s, char *cygwin, 
|       return;
|     }
| 
| -  FILE *f = popen (id, "rt");
| -
|   char buf[16384];
| +  snprintf (buf, sizeof (buf), "\"%s\"", id);
| +  FILE *f = popen (buf, "rt");
| +
|   buf[0] = '\0';
|   fgets (buf, sizeof (buf), f);
|   pclose (f);
| @@ -1118,7 +1119,7 @@ dump_sysinfo_services ()
|     }
| 
|   /* check for a recent cygrunsrv */
| -  snprintf (buf, sizeof (buf), "%s --version", cygrunsrv);
| +  snprintf (buf, sizeof (buf), "\"%s\" --version", cygrunsrv);
|   if ((f = popen (buf, "rt")) == NULL)
|     {
|       printf ("Failed to execute '%s', skipping services check.\n", buf);
| @@ -1136,7 +1137,7 @@ dump_sysinfo_services ()
|   /* For verbose mode, just run cygrunsrv --list --verbose and copy output
|      verbatim; otherwise run cygrunsrv --list and then cygrunsrv --query for
|      each service.  */
| -  snprintf (buf, sizeof (buf), (verbose ? "%s --list --verbose" : "%s --list"),
| +  snprintf (buf, sizeof (buf), (verbose ? "\"%s\" --list --verbose" : "%s --list"),
|      cygrunsrv);
|   if ((f = popen (buf, "rt")) == NULL)
|     {
| @@ -1167,7 +1168,7 @@ dump_sysinfo_services ()
|       if (nchars > 0)
|  for (char *srv = strtok (buf, "\n"); srv; srv = strtok (NULL, "\n"))
|    {
| -     snprintf (buf2, sizeof (buf2), "%s --query %s", cygrunsrv, srv);
| +     snprintf (buf2, sizeof (buf2), "\"%s\" --query %s", cygrunsrv, srv);
|      if ((f = popen (buf2, "rt")) == NULL)
|        {
|   printf ("Failed to execute '%s', skipping services check.\n", buf2);
|
