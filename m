Return-Path: <cygwin-patches-return-6351-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30919 invoked by alias); 15 Sep 2008 21:32:30 -0000
Received: (qmail 30901 invoked by uid 22791); 15 Sep 2008 21:32:29 -0000
X-Spam-Check-By: sourceware.org
Received: from smtprelay0130.hostedemail.com (HELO smtprelay.hostedemail.com) (216.40.44.130)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 15 Sep 2008 21:31:42 +0000
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254]) 	by smtprelay03.hostedemail.com (Postfix) with SMTP id F08AE3E96CC 	for <cygwin-patches@cygwin.com>; Mon, 15 Sep 2008 21:31:34 +0000 (UTC)
X-SpamScore: 1
X-Spam-Summary: 2,0,0,c02e990bb00634b9,fa7ca027ad91787c,cygwin@jason-gouger.com,,RULES_HIT:10:355:379:541:542:945:960:967:973:982:988:989:1155:1160:1261:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1766:1792:2393:2525:2553:2559:2563:2682:2685:2693:2857:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3352:3636:3865:3866:3868:3869:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:4250:4321:4362:4605:5007:6117:6119:7679:7688:7875:7904:8957:8985:9025,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:none,DNSBL:none
Received: from FISION1330 (nat-wv.mentorg.com [192.94.38.34]) 	(Authenticated sender: mail@jason-gouger.com) 	by omf08.hostedemail.com (Postfix) with ESMTP 	for <cygwin-patches@cygwin.com>; Mon, 15 Sep 2008 21:31:34 +0000 (UTC)
From: "Jason" <cygwin@jason-gouger.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] fix unlink for Cygwin 1.5.25-15 -- unintended data loss with symbolic file links
Date: Mon, 15 Sep 2008 21:32:00 -0000
Message-ID: <003801c9177a$5debc030$19c34090$@com>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-us
X-session-marker: 6D61696C406A61736F6E2D676F756765722E636F6D
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00014.txt.bz2

Please consider the patch below for inclusion in the Cygwin 1.5 branch which
corrects the deletion of symbolic link file types (Vista file reparse
points).

The problem is that CreateFile will open the target and not the link.  See
the MSDN page
http://msdn.microsoft.com/en-us/library/aa365682(VS.85).aspx#CreateFile for
a more detailed description of Vista's symbolic link handling.
 
Thanks, 
  Jason

---

2008-09-15  Jason Gouger <cygwin at jason-gouger.com>

	* syscalls.cc: Fix 'unlink' so that it will delete the symbolic link
	and not the target file for Vista's file reparse points.

Index: cygwin/syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.403.4.3
diff -b -u -p -r1.403.4.3 syscalls.cc
--- cygwin/syscalls.cc	12 Nov 2007 15:30:20 -0000	1.403.4.3
+++ cygwin/syscalls.cc	15 Sep 2008 21:06:10 -0000
@@ -207,7 +207,7 @@ unlink (const char *ourname)
     {
       HANDLE h;
       h = CreateFile (win32_name, 0, FILE_SHARE_READ, &sec_none_nih,
-		      OPEN_EXISTING, FILE_FLAG_DELETE_ON_CLOSE, 0);
+		      OPEN_EXISTING, FILE_FLAG_OPEN_REPARSE_POINT |
FILE_FLAG_DELETE_ON_CLOSE, 0);
       if (h != INVALID_HANDLE_VALUE)
 	{
 	  if (wincap.has_hard_links () && setattrs)
