Return-Path: <cygwin-patches-return-4344-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21623 invoked by alias); 6 Nov 2003 17:01:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21593 invoked from network); 6 Nov 2003 17:01:35 -0000
Message-ID: <3FAA7D7F.9080408@fangorn.ca>
Date: Thu, 06 Nov 2003 17:01:00 -0000
From: Mark Blackburn <marklist@fangorn.ca>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] : make cygpath use multiple filename arguments
Content-Type: multipart/mixed;
 boundary="------------080707090402090309010305"
X-SW-Source: 2003-q4/txt/msg00063.txt.bz2

This is a multi-part message in MIME format.
--------------080707090402090309010305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 303

This patch will allow you to do this.

$ ./cygpath.exe -w -a cygpath.cc cygpath.exe
E:\cygwin\usr\src\cygwin-cvs\src\winsup\utils\cygpath.cc
E:\cygwin\usr\src\cygwin-cvs\src\winsup\utils\cygpath.exe

I don't know if this is desired behaviour or not. Personally, I would
find it useful.

Mark Blackburn


--------------080707090402090309010305
Content-Type: text/plain;
 name="cygpath.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygpath.patch"
Content-length: 673

Index: src/winsup/utils/cygpath.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
retrieving revision 1.31
diff -u -p -r1.31 cygpath.cc
--- src/winsup/utils/cygpath.cc	17 Oct 2003 17:20:06 -0000	1.31
+++ src/winsup/utils/cygpath.cc	6 Nov 2003 15:36:05 -0000
@@ -675,11 +675,13 @@ main (int argc, char **argv)
       if (output_flag)
 	dowin (o);
 
-      if (optind != argc - 1)
+      if (optind > argc - 1)
 	usage (stderr, 1);
 
-      filename = argv[optind];
-      doit (filename);
+      for (int i=optind; argv[i]; i++) {
+	filename = argv[i];
+	doit (filename);
+      }
     }
   else
     {


--------------080707090402090309010305--
