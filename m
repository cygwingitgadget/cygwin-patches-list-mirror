Return-Path: <cygwin-patches-return-7135-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 876 invoked by alias); 7 Dec 2010 20:54:10 -0000
Received: (qmail 866 invoked by uid 22791); 7 Dec 2010 20:54:09 -0000
X-SWARE-Spam-Status: No, hits=-0.1 required=5.0	tests=AWL,BAYES_05,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout02.t-online.de (HELO mailout02.t-online.de) (194.25.134.17)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Dec 2010 20:54:02 +0000
Received: from fwd11.aul.t-online.de (fwd11.aul.t-online.de )	by mailout02.t-online.de with smtp 	id 1PQ4Xx-0008Fp-Sr; Tue, 07 Dec 2010 21:54:01 +0100
Received: from [192.168.2.100] (SafGggZVgh8ByvQ-fE+zb7GSVn7YOpz4Vxzi2mC5fALv5ekWo9tsGy6Bdw+yz8ZZYB@[79.224.126.145]) by fwd11.aul.t-online.de	with esmtp id 1PQ4Xu-1Lhk1o0; Tue, 7 Dec 2010 21:53:58 +0100
Message-ID: <4CFE9EE6.8010902@t-online.de>
Date: Wed, 08 Dec 2010 10:25:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.15) Gecko/20101027 SeaMonkey/2.0.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix permissions of DEF_CLASS_OBJ ACL entry
Content-Type: multipart/mixed; boundary="------------010001080009060106070705"
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
X-SW-Source: 2010-q4/txt/msg00014.txt.bz2

This is a multi-part message in MIME format.
--------------010001080009060106070705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 435

Cygwin returns permissions 0777 in the DEF_CLASS_OBJ ("default:mask:") 
ACL entry. This patch changes this to 07. The upper bits 0770 probably 
do not make any sense here.

The value 0777 is one reason why rsync may set bogus permissions.
(The other reason is that rsync always expects a DEF_OTHER_OBJ entry. 
This is likely a rsync bug which should be fixed upstream)
See http://cygwin.com/ml/cygwin/2010-11/msg00429.html

Christian


--------------010001080009060106070705
Content-Type: text/x-patch;
 name="sec_acl-def_class-perm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sec_acl-def_class-perm.patch"
Content-length: 633

2010-12-07  Christian Franke  <franke@computer.org>

	* sec_acl.cc (getacl): Set DEF_CLASS_OBJ permissions
	to 07 instead of 0777.


diff --git a/winsup/cygwin/sec_acl.cc b/winsup/cygwin/sec_acl.cc
index 0c6586b..24f2468 100644
--- a/winsup/cygwin/sec_acl.cc
+++ b/winsup/cygwin/sec_acl.cc
@@ -394,7 +394,7 @@ getacl (HANDLE handle, path_conv &pc, int nentries, __aclent32_t *aclbufp)
 	{
 	  lacl[pos].a_type = DEF_CLASS_OBJ;
 	  lacl[pos].a_id = ILLEGAL_GID;
-	  lacl[pos].a_perm = S_IRWXU | S_IRWXG | S_IRWXO;
+	  lacl[pos].a_perm = S_IROTH | S_IWOTH | S_IXOTH;
 	}
     }
   if ((pos = searchace (lacl, MAX_ACL_ENTRIES, 0)) < 0)

--------------010001080009060106070705--
