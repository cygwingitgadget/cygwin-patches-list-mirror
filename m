Return-Path: <cygwin-patches-return-1587-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17737 invoked by alias); 14 Dec 2001 17:13:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17709 invoked from network); 14 Dec 2001 17:13:07 -0000
Date: Sun, 04 Nov 2001 11:59:00 -0000
From: Jason Tishler <jason@tishler.net>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Minor mkpasswd patch
Message-ID: <20011214121658.A2348@dothill.com>
Mail-Followup-To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R3+LpfmxQKPrwX9V"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-SW-Source: 2001-q4/txt/msg00119.txt.bz2


--R3+LpfmxQKPrwX9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 115

The attached fixes a SEGV caused by using the '-p' option:

    $ mkpasswd -d -u jtishler -p /home/jtishler

Jason

--R3+LpfmxQKPrwX9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mkpasswd.c.diff"
Content-length: 446

Index: mkpasswd.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/mkpasswd.c,v
retrieving revision 1.16
diff -u -p -r1.16 mkpasswd.c
--- mkpasswd.c	2001/11/21 10:39:43	1.16
+++ mkpasswd.c	2001/12/14 17:00:52
@@ -415,7 +415,7 @@ struct option longopts[] = {
   {0, no_argument, NULL, 0}
 };
 
-char opts[] = "ldo:gsmhpu:";
+char opts[] = "ldo:gsmhp:u:";
 
 int
 main (int argc, char **argv)

--R3+LpfmxQKPrwX9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mkpasswd.c.ChangeLog"
Content-length: 139

Fri Dec 14 12:10:39 2001  Jason Tishler <jason@tishler.net>

	* mkpasswd.c (opts): Add indication that '-p' option requires an
	argument.


--R3+LpfmxQKPrwX9V--
