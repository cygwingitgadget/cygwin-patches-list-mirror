Return-Path: <cygwin-patches-return-2196-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4777 invoked by alias); 19 May 2002 17:31:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4762 invoked from network); 19 May 2002 17:31:31 -0000
Message-Id: <3.0.5.32.20020519132851.007f2b80@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 19 May 2002 10:31:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: lsa handle in security.cc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00180.txt.bz2

The invalid value for an lsa handle in security.cc
is inconsistent. It is initially NULL, but in 
close_local_policy () it is INVALID_HANDLE_VALUE.
Calling LsaClose(NULL) causes a fault, at least in gdb.

The patch uses INVALID_HANDLE_VALUE uniformly, instead of 
NULL. The converse would probably work as well, not sure
which is better.

Pierre

2002-05-19  Pierre Humblet <pierre.humblet@ieee.org>

	* security.cc (open_local_policy): Initialize lsa to	INVALID_HANDLE_VALUE
instead of NULL.
 	(get_logon_server_and_user_domain): Test for
	INVALID_HANDLE_VALUE instead of NULL.
	(create_token): Both of the above. 


--- security.cc.orig    2002-05-17 05:32:46.000000000 -0400
+++ security.cc 2002-05-19 12:07:10.000000000 -0400
@@ -180,7 +180,7 @@
 open_local_policy ()
 {
   LSA_OBJECT_ATTRIBUTES oa = { 0, 0, 0, 0, 0, 0 };
-  LSA_HANDLE lsa = NULL;
+  LSA_HANDLE lsa = INVALID_HANDLE_VALUE;
 
   NTSTATUS ret = LsaOpenPolicy(NULL, &oa, POLICY_EXECUTE, &lsa);
   if (ret != STATUS_SUCCESS)
@@ -258,7 +258,7 @@
 {
   BOOL ret = FALSE;
   LSA_HANDLE lsa = open_local_policy ();
-  if (lsa)
+  if (lsa != INVALID_HANDLE_VALUE)
     {
       ret = get_lsa_srv_inf (lsa, logonserver, userdomain);
       close_local_policy (lsa);
@@ -723,7 +723,7 @@
 create_token (cygsid &usersid, cygsid &pgrpsid)
 {
   NTSTATUS ret;
-  LSA_HANDLE lsa = NULL;
+  LSA_HANDLE lsa = INVALID_HANDLE_VALUE;
   char logonserver[INTERNET_MAX_HOST_NAME_LENGTH + 1];
   int old_priv_state;
 
@@ -764,7 +764,7 @@
     goto out;
 
   /* Open policy object. */
-  if (!(lsa = open_local_policy ()))
+  if ((lsa = open_local_policy ()) == INVALID_HANDLE_VALUE)
     goto out;
 
   /* Get logon server. */
