Return-Path: <cygwin-patches-return-2801-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15776 invoked by alias); 8 Aug 2002 13:47:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15762 invoked from network); 8 Aug 2002 13:47:07 -0000
Message-ID: <3D52765A.5000507@hekimian.com>
Date: Thu, 08 Aug 2002 06:47:00 -0000
X-Sybari-Trust: c8eb526c b923d9bf 4738785c 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  joseph.buehler@spirentcom.com
Organization: Spirent Communications
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: minor patch to printf
Content-Type: multipart/mixed;
 boundary="------------060207000904040803030906"
X-SW-Source: 2002-q3/txt/msg00249.txt.bz2

This is a multi-part message in MIME format.
--------------060207000904040803030906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 68

A minor patch for a printf format problem is attached.

Joe Buehler

--------------060207000904040803030906
Content-Type: text/plain;
 name="temp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="temp.patch"
Content-length: 682

Index: src/winsup/cygwin/sec_helper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.23
diff -u -r1.23 sec_helper.cc
--- src/winsup/cygwin/sec_helper.cc	3 Jul 2002 03:20:50 -0000	1.23
+++ src/winsup/cygwin/sec_helper.cc	8 Aug 2002 13:41:27 -0000
@@ -432,8 +442,8 @@
   if (sid1)
     if (!AddAccessAllowedAce (acl, ACL_REVISION,
 			      GENERIC_ALL, sid1))
-      debug_printf ("AddAccessAllowedAce(sid1) %E", sid1);
+      debug_printf ("AddAccessAllowedAce(sid1) %E");
   if (admins)
     if (!AddAccessAllowedAce (acl, ACL_REVISION,
 			      GENERIC_ALL, well_known_admins_sid))

--------------060207000904040803030906--
