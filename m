Return-Path: <cygwin-patches-return-7137-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32343 invoked by alias); 10 Dec 2010 22:05:28 -0000
Received: (qmail 32328 invoked by uid 22791); 10 Dec 2010 22:05:26 -0000
X-SWARE-Spam-Status: No, hits=0.5 required=5.0	tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 10 Dec 2010 22:05:20 +0000
Received: from fwd09.aul.t-online.de (fwd09.aul.t-online.de )	by mailout09.t-online.de with smtp 	id 1PRB5Y-0000w5-JV; Fri, 10 Dec 2010 23:05:16 +0100
Received: from [192.168.2.100] (T58JvgZLwhjkDpomU0+OOjCMQbwWD6SquLCZyZJSNQPuWlyYIjJWiLo0TYnNQ1xQO8@[79.224.122.47]) by fwd09.aul.t-online.de	with esmtp id 1PRB5Y-1u3krg0; Fri, 10 Dec 2010 23:05:16 +0100
Message-ID: <4D02A41C.8030406@t-online.de>
Date: Sat, 11 Dec 2010 20:47:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.15) Gecko/20101027 SeaMonkey/2.0.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Ensure that the default ACL contains the standard entries
Content-Type: multipart/mixed; boundary="------------080406010901010300040109"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q4/txt/msg00016.txt.bz2

This is a multi-part message in MIME format.
--------------080406010901010300040109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 390

The ACL from Cygwin always contains the three (USER|GROUP|OTHER)_OBJ 
entries. It might be existing practice elsewhere to return these entries 
also in the default ACL. The attached patch adds these entries with 
empty permissions if necessary.

The patch would fix this rsync issue: 
http://cygwin.com/ml/cygwin/2010-11/msg00429.html

The logic for DEF_CLASS_OBJ is unchanged.

Christian


--------------080406010901010300040109
Content-Type: text/x-diff;
 name="sec_acl-default.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sec_acl-default.patch"
Content-length: 2320

2010-12-10  Christian Franke  <franke@computer.org>

	* sec_acl.cc (getacl): Ensure that the default acl contains
	at least DEF_(USER|GROUP|OTHER)_OBJ entries.


diff --git a/winsup/cygwin/sec_acl.cc b/winsup/cygwin/sec_acl.cc
index 24f2468..34424a8 100644
--- a/winsup/cygwin/sec_acl.cc
+++ b/winsup/cygwin/sec_acl.cc
@@ -357,11 +357,13 @@ getacl (HANDLE handle, path_conv &pc, int nentries, __aclent32_t *aclbufp)
 	  else if (ace_sid == well_known_creator_group_sid)
 	    {
 	      type = GROUP_OBJ | ACL_DEFAULT;
+	      types_def |= type;
 	      id = ILLEGAL_GID;
 	    }
 	  else if (ace_sid == well_known_creator_owner_sid)
 	    {
 	      type = USER_OBJ | ACL_DEFAULT;
+	      types_def |= type;
 	      id = ILLEGAL_GID;
 	    }
 	  else
@@ -388,13 +390,38 @@ getacl (HANDLE handle, path_conv &pc, int nentries, __aclent32_t *aclbufp)
 		getace (lacl[pos], type, id, ace->Mask, ace->Header.AceType);
 	    }
 	}
-      /* Include DEF_CLASS_OBJ if any default ace exists */
-      if ((types_def & (USER|GROUP))
-	  && ((pos = searchace (lacl, MAX_ACL_ENTRIES, DEF_CLASS_OBJ)) >= 0))
+      if (types_def && (pos = searchace (lacl, MAX_ACL_ENTRIES, 0)) >= 0)
 	{
-	  lacl[pos].a_type = DEF_CLASS_OBJ;
-	  lacl[pos].a_id = ILLEGAL_GID;
-	  lacl[pos].a_perm = S_IROTH | S_IWOTH | S_IXOTH;
+	  /* Ensure that the default acl contains at
+	     least DEF_(USER|GROUP|OTHER)_OBJ entries.  */
+	  if (!(types_def & USER_OBJ))
+	    {
+	      lacl[pos].a_type = DEF_USER_OBJ;
+	      lacl[pos].a_id = uid;
+	      /* lacl[pos].a_perm = 0; */
+	      pos++;
+	    }
+	  if (!(types_def & GROUP_OBJ) && pos < MAX_ACL_ENTRIES)
+	    {
+	      lacl[pos].a_type = DEF_GROUP_OBJ;
+	      lacl[pos].a_id = gid;
+	      /* lacl[pos].a_perm = 0; */
+	      pos++;
+	    }
+	  if (!(types_def & OTHER_OBJ) && pos < MAX_ACL_ENTRIES)
+	    {
+	      lacl[pos].a_type = DEF_OTHER_OBJ;
+	      lacl[pos].a_id = ILLEGAL_GID;
+	      /* lacl[pos].a_perm = 0; */
+	      pos++;
+	    }
+	  /* Include DEF_CLASS_OBJ if any named default ace exists.  */
+	  if ((types_def & (USER|GROUP)) && pos < MAX_ACL_ENTRIES)
+	    {
+	      lacl[pos].a_type = DEF_CLASS_OBJ;
+	      lacl[pos].a_id = ILLEGAL_GID;
+	      lacl[pos].a_perm = S_IROTH | S_IWOTH | S_IXOTH;
+	    }
 	}
     }
   if ((pos = searchace (lacl, MAX_ACL_ENTRIES, 0)) < 0)

--------------080406010901010300040109--
