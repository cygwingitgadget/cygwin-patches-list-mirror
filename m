Return-Path: <cygwin-patches-return-2685-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24966 invoked by alias); 23 Jul 2002 13:58:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24943 invoked from network); 23 Jul 2002 13:58:51 -0000
Message-ID: <3D3D6113.5090104@netscape.net>
Date: Tue, 23 Jul 2002 06:58:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 'Cygwin-Patches' <cygwin-patches@sources.redhat.com>
Subject: Website Patch for "lists.html"
Content-Type: multipart/mixed;
 boundary="------------010903030505060609000600"
X-SW-Source: 2002-q3/txt/msg00133.txt.bz2


--------------010903030505060609000600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 151

Hi,

I noticed a small misspelling of "Internet" on the mailing-list web 
page.  Here is a patch, against the cvs htdocs for Cygwin.

Cheers,
Nicholas

--------------010903030505060609000600
Content-Type: text/plain;
 name="lists-spelling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lists-spelling.diff"
Content-length: 868

Index: lists.html
===================================================================
RCS file: /cvs/cygwin/htdocs/lists.html,v
retrieving revision 1.101
diff -u -3 -p -u -r1.101 lists.html
--- lists.html  12 May 2002 05:52:02 -0000  1.101
+++ lists.html  23 Jul 2002 13:54:43 -0000
@@ -73,7 +73,7 @@ considered "off topic".</p>
 <p>Why do we make this distinction?  For two reasons:  1) as mentioned,
 the email traffic is very high so, by keeping things "on topic" we
 can cut down on some list traffic and 2) there are usually much better
-places on the intenet where you can get definitive answers for your
+places on the Internet where you can get definitive answers for your
 off-topic-for-cygwin question.  It doesn't make sense to ask non-experts to teach you about
 C or bash.</p>
 <p>Unfortunately, we can't tell you exactly where to go with your non-cygwin

--------------010903030505060609000600--
