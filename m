Return-Path: <cygwin-patches-return-2857-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2866 invoked by alias); 24 Aug 2002 21:18:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2852 invoked from network); 24 Aug 2002 21:18:38 -0000
Message-Id: <3.0.5.32.20020824171457.00811b80@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sat, 24 Aug 2002 14:18:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: More more Everyone
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00305.txt.bz2

It just occurs to me that one could also chown a file to Everyone,
with results similar as with chgrp.
The patch below takes care of both cases (forget the previous one).

Pierre

2002-08-24 Pierre Humblet <Pierre.Humblet@ieee.org>
	
	* sec_acl.cc (getacl): Check ace_sid == well_known_world_sid
	before owner_sid and group_sid so that well_known_world_sid 
	means "other" even when owner_sid and/or group_sid are Everyone. 
	* security.cc (get_nt_attribute): Ditto.


--- sec_acl.cc.orig	2002-07-02 20:29:16.000000000 -0400
+++ sec_acl.cc	2002-08-24 17:01:02.000000000 -0400
@@ -314,7 +314,12 @@
       int id;
       int type = 0;
 
-      if (ace_sid == owner_sid)
+      if (ace_sid == well_known_world_sid)
+	{
+	  type = OTHER_OBJ;
+	  id = 0;
+	}
+      else if (ace_sid == owner_sid)
 	{
 	  type = USER_OBJ;
 	  id = uid;
@@ -324,11 +329,6 @@
 	  type = GROUP_OBJ;
 	  id = gid;
 	}
-      else if (ace_sid == well_known_world_sid)
-	{
-	  type = OTHER_OBJ;
-	  id = 0;
-	}
       else
 	{
 	  id = ace_sid.get_id (FALSE, &type);
--- security.cc.orig	2002-08-23 18:37:10.000000000 -0400
+++ security.cc	2002-08-24 16:59:38.000000000 -0400
@@ -1291,28 +1291,7 @@
 	}
 
       cygsid ace_sid ((PSID) &ace->SidStart);
-      if (owner_sid && ace_sid == owner_sid)
-	{
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |= S_IRUSR;
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |= S_IWUSR;
-	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |= S_IXUSR;
-	}
-      else if (group_sid && ace_sid == group_sid)
-	{
-	  if (ace->Mask & FILE_READ_DATA)
-	    *flags |= S_IRGRP
-		      | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);
-	  if (ace->Mask & FILE_WRITE_DATA)
-	    *flags |= S_IWGRP
-		      | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);
-	  if (ace->Mask & FILE_EXECUTE)
-	    *flags |= S_IXGRP
-		      | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);
-	}
-      else if (ace_sid == well_known_world_sid)
+      if (ace_sid == well_known_world_sid)
 	{
 	  if (ace->Mask & FILE_READ_DATA)
 	    *flags |= S_IROTH
@@ -1343,6 +1322,27 @@
 	  if (ace->Mask & FILE_APPEND_DATA)
 	    *flags |= S_ISUID;
 	}
+      else if (owner_sid && ace_sid == owner_sid)
+	{
+	  if (ace->Mask & FILE_READ_DATA)
+	    *flags |= S_IRUSR;
+	  if (ace->Mask & FILE_WRITE_DATA)
+	    *flags |= S_IWUSR;
+	  if (ace->Mask & FILE_EXECUTE)
+	    *flags |= S_IXUSR;
+	}
+      else if (group_sid && ace_sid == group_sid)
+	{
+	  if (ace->Mask & FILE_READ_DATA)
+	    *flags |= S_IRGRP
+		      | ((grp_member && !(*anti & S_IRUSR)) ? S_IRUSR : 0);
+	  if (ace->Mask & FILE_WRITE_DATA)
+	    *flags |= S_IWGRP
+		      | ((grp_member && !(*anti & S_IWUSR)) ? S_IWUSR : 0);
+	  if (ace->Mask & FILE_EXECUTE)
+	    *flags |= S_IXGRP
+		      | ((grp_member && !(*anti & S_IXUSR)) ? S_IXUSR : 0);
+	}
     }
   *attribute &= ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_ISUID);
   *attribute |= allow;
