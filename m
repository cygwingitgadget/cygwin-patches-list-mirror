Return-Path: <cygwin-patches-return-2690-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17220 invoked by alias); 23 Jul 2002 16:24:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17196 invoked from network); 23 Jul 2002 16:24:18 -0000
Message-ID: <3D3D8310.9020708@netscape.net>
Date: Tue, 23 Jul 2002 09:24:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 'Cygwin-Patches' <cygwin-patches@sources.redhat.com>
Subject: patch to export fcloseall and fcloseall_r
Content-Type: multipart/mixed;
 boundary="------------080400040800070100050201"
X-SW-Source: 2002-q3/txt/msg00138.txt.bz2


--------------080400040800070100050201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 585

Hi,

Earlier I had posted on the main list regarding the exporting of 
fcloseall and fcloseall_r from the cygwin dll.  Well I have gone ahead 
and built a new cygwin dll with those functions exported.  I tested the 
functionality by modifying this test program slightly for cygwin:

http://www.phanderson.com/C/fileread.html

It worked fine, FWICT, and it seems like the addition isn't causing any 
adverse affects on the system.  So I figured that it would be a good 
idea to back up my suggestions with a patch to the cygwin.din and 
calls.texi.  So here they are.

Cheers,
Nicholas

--------------080400040800070100050201
Content-Type: text/plain;
 name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.txt"
Content-length: 132

2002-07-23  Nicholas Wourms  <nwourms@netscape.net>

    * cygwin.din (fcloseall): Add symbol for export.
    (fcloseall_r): Ditto.

--------------080400040800070100050201
Content-Type: text/plain;
 name="fcloseall.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fcloseall.diff"
Content-length: 487

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.37.2.10
diff -u -3 -p -u -p -r1.37.2.10 cygwin.din
--- cygwin.din  13 Jul 2002 20:39:24 -0000  1.37.2.10
+++ cygwin.din  23 Jul 2002 16:08:58 -0000
@@ -213,6 +249,10 @@ _fchown = fchown
 fchown32
 fclose
 _fclose = fclose
+fcloseall
+_fcloseall = fcloseall
+_fcloseall_r
+fcloseall_r = _fcloseall_r
 _fcntl
 fcntl = _fcntl
 fcvt

--------------080400040800070100050201
Content-Type: text/plain;
 name="fcloseall-calls.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fcloseall-calls.diff"
Content-length: 484

Index: calls.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/calls.texinfo,v
retrieving revision 1.4
diff -u -3 -p -u -p -r1.4 calls.texinfo
--- calls.texinfo   14 Jun 2002 11:33:30 -0000  1.4
+++ calls.texinfo   23 Jul 2002 16:08:25 -0000
@@ -616,6 +616,8 @@ in MS IP stack but may not be implemente
 @item endgrent
 @item endhostent
 @item facl
+@item fcloseall
+@item fcloseall_r
 @item ffs
 @item fstatfs
 @item ftime

--------------080400040800070100050201--
