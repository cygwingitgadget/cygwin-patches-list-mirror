Return-Path: <cygwin-patches-return-4090-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17848 invoked by alias); 16 Aug 2003 02:08:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17820 invoked from network); 16 Aug 2003 02:08:10 -0000
From: David Rothenberger <daveroth@acm.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cHo9JBqub8"
Content-Transfer-Encoding: 7bit
Message-ID: <16189.37381.740000.619089@gargle.gargle.HOWL>
Date: Sat, 16 Aug 2003 02:08:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Package content search and listing functionality for cygcheck
In-Reply-To: <20030815202621.GG3101@cygbert.vinschen.de>
References: <20030815091732.GA3101@cygbert.vinschen.de>
	<Pine.GSO.4.44.0308151532550.1848-200000@slinky.cs.nyu.edu>
	<20030815202621.GG3101@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
X-SW-Source: 2003-q3/txt/msg00106.txt.bz2


--cHo9JBqub8
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit
Content-length: 548

Corinna Vinschen wrote:
> Thanks for the patch, it's really cool,

I agree, very cool, Igor.

Any chance the return in package_find() could be changed to
continue?  I went to try it out for /bin/ssh and found it didn't
work because diffutils is missing the package list.  I didn't think
to even try verbose until I read the code.

Here's the ridiculously small patch if you agree.

Dave
==============================
2003-08-15  David Rothenberger  <daveroth@acm.org>

	* dump_setup.cc (package_find): Don't stop searching on missing
	file list.


--cHo9JBqub8
Content-Type: text/plain
Content-Disposition: attachment;
	filename="cygcheck-find-continue.patch"
Content-Transfer-Encoding: 7bit
Content-length: 551

Index: dump_setup.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/dump_setup.cc,v
retrieving revision 1.10
diff -u -p -r1.10 dump_setup.cc
--- dump_setup.cc	15 Aug 2003 20:26:11 -0000	1.10
+++ dump_setup.cc	16 Aug 2003 02:03:17 -0000
@@ -454,7 +454,7 @@ package_find (int verbose, char **argv)
 	if (verbose)
 	  printf ("Can't open file list /etc/setup/%s.lst.gz for package %s\n",
 	      packages[i].name, packages[i].name);
-	return;
+	continue;
       }
 
       char buf[MAX_PATH + 2];

--cHo9JBqub8--

