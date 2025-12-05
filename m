Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AE0E04CCCA31; Fri,  5 Dec 2025 19:42:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AE0E04CCCA31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764963722;
	bh=+ajUqcUU7errnw4oOQ3Ot4Hrtfs0Uqh424mv+XP0TNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wHLu8fu4kbSgN8KlNG4BG10pYAapudQ5kydaz2g4zBSFU7sS5xaUjMInDvbvPTg2t
	 47ToYclx/dy8jAvN83PDIY0x4PzNmHNZ36Wh1iVi4e8SVVyt3o5sAprHy4rOPa0ZJS
	 sg5NNOqxJHHPN/lNbYWpWVe5WJgo89XizfsLsR1E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CDFC4A80F16; Fri, 05 Dec 2025 20:42:00 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Marco Atzeri <marco.atzeri@gmail.com>
Subject: [PATCH 2/3] Cygwin: doc: utils.xml: improve newgrp(1) documentation
Date: Fri,  5 Dec 2025 20:41:59 +0100
Message-ID: <20251205194200.4011206-3-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
References: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Especially document -l as primary option and - just for Linux
compatibility.  Note that a command on the commandline is a
Cygwin extension and incompatible with POSIX and Linux.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/doc/utils.xml | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 6a55b3a0e790..31106f36e45f 100644
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
@@ -2124,22 +2124,24 @@ D: on /d type fat (binary,user,noumount)
 
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
+      <para> If a group has been given as argument, a command and its
+	arguments can be specified on the command line.  Note that this
+	usage is Cygwin-only and incompatible with POSIX and Linux.</para>
 
       <para>The new primary group must be either the old primary group, or
         it must be part of the supplementary group list.  Setting the primary
-- 
2.51.1

