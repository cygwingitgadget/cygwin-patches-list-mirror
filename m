Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D67674BA2E21; Wed, 10 Dec 2025 17:32:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D67674BA2E21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765387923;
	bh=DnSx7/Dm4diRxDNs9HyArFTelvl0WQtWVuCOUnxjZ4g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RFW9riUEN0xDpxCduQirAQOqka3tv6y3usa3mr8DK6fek7UAPQz90C0vwov7Q/m8B
	 8bhzc2nAtQBMH0NysZFGhgoPiNpLsN2tk2QQSATZJGuqqL4D7cYMQ6tEjpYnjpcLWF
	 QgT4wblcYQhKZ5JaYUWWKAr0ROb1Y/q2QIg4H8IM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C21CFA80D22; Wed, 10 Dec 2025 18:32:01 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/3] Cygwin: doc: utils.xml: improve newgrp(1) documentation
Date: Wed, 10 Dec 2025 18:32:00 +0100
Message-ID: <20251210173201.193740-3-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
References: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Especially document -l as primary option and - just for Linux
compatibility.  Note that a command on the commandline is a
Cygwin extension and incompatible with POSIX and Linux.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/doc/utils.xml | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 6a55b3a0e790..5db1d630d56e 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -2108,13 +2108,13 @@ D: on /d type fat (binary,user,noumount)
 
     <refnamediv>
       <refname>newgrp</refname>
-      <refpurpose>change primary group for a command</refpurpose>
+      <refpurpose>change to a new primary group</refpurpose>
     </refnamediv>
 
     <refsynopsisdiv>
       <cmdsynopsis>
 	<command>newgrp</command>
-	<arg choice="opt">-</arg>
+	<arg choice="opt">-l</arg>
 	<arg choice="opt"><replaceable>group</replaceable></arg>
 	<arg><replaceable>command</replaceable>
 	<arg rep="repeat"><replaceable>args</replaceable></arg>
@@ -2124,22 +2124,27 @@ D: on /d type fat (binary,user,noumount)
 
     <refsect1 id="newgrp-desc">
       <title>Description</title>
-      <para><command>newgrp</command> changes the primary group for a
-        command.</para>
+      <para><command>newgrp</command> starts a new shell environment under
+      a new primary group.</para>
 
-      <para>If the <option>-</option> flag is given as first argument, the
+      <para>If the <option>-l</option> flag is given as first argument, the
 	user's environment will be reinitialized as though the user had logged
 	in, otherwise the current environment, including current working
-	directory, remains unchanged.</para>
+	directory, remains unchanged.  For Linux compatibility, the flag
+	<option>-</option> is allowed as well.</para>
 
       <para><command>newgrp</command> changes the current primary group to the
         named group, or to the default group listed in /etc/passwd if no group
-	name is given.</para>
+	name is given.  The user's standard shell is started, called as login
+        shell if the <option>-l</option> or <option>-</option> flag has been
+	specified.</para>
 
-      <para>By default, the user's standard shell is started, called as login
-        shell if the <option>-</option> flag has been specified.  If a group
-	has been given as argument, a command and its arguments can be
-	specified on the command line.</para>
+      <para>The group argument can be specified as group name from the
+      group database or a non-negative numeric group ID.</para>
+
+      <para> If a group has been given as argument, a command and its
+	arguments can be specified on the command line.  Note that this
+	usage is Cygwin-only and incompatible with POSIX and Linux.</para>
 
       <para>The new primary group must be either the old primary group, or
         it must be part of the supplementary group list.  Setting the primary
-- 
2.52.0

