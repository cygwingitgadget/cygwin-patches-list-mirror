Return-Path: <cygwin-patches-return-5715-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10297 invoked by alias); 18 Jan 2006 12:30:26 -0000
Received: (qmail 10280 invoked by uid 22791); 18 Jan 2006 12:30:25 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 18 Jan 2006 12:30:20 +0000
Received: from espanola ([192.168.1.110]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 18 Jan 2006 12:30:17 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: Remove debug printf from cygpath.cc
Date: Wed, 18 Jan 2006 12:30:00 -0000
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <SERRANOAeys8FSA4Ale000001a5@SERRANO.CAM.ARTIMI.COM>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00024.txt.bz2



  Obvious fix for stray debug-printf, as mentioned on the main list.
http://cygwin.com/ml/cygwin/2006-01/msg00792.html

  (Am about to see if I have perms to check it in.)


2006-01-18  Dave Korn  <dave.korn@artimi.com>

	* cygpath.cc (dowin):  Remove stray debugging printf statement.

Index: cygpath.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
retrieving revision 1.40
diff -p -u -r1.40 cygpath.cc
--- cygpath.cc  22 Nov 2005 17:19:17 -0000      1.40
+++ cygpath.cc  18 Jan 2006 12:27:25 -0000
@@ -379,7 +379,6 @@ dowin (char option)
          GetWindowsDirectory (buf, MAX_PATH);
          strcat (buf, "\\Profiles");
        }
-fprintf (stderr, "************** buf %s\n", buf);
       break;

     case 'S':


    cheers, 
      DaveK
-- 
Can't think of a witty .sigline today....
 
