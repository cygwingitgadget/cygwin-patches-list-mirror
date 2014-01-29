Return-Path: <cygwin-patches-return-7955-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30149 invoked by alias); 29 Jan 2014 16:46:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30133 invoked by uid 89); 29 Jan 2014 16:46:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.2
X-HELO: northrend.tastycake.net
Received: from northrend.tastycake.net (HELO northrend.tastycake.net) (212.13.201.165) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Wed, 29 Jan 2014 16:46:13 +0000
Received: from adam by northrend.tastycake.net with local (Exim 4.80)	(envelope-from <adam@dinwoodie.org>)	id 1W8YHB-00043J-Vb	for cygwin-patches@cygwin.com; Wed, 29 Jan 2014 16:46:10 +0000
Date: Wed, 29 Jan 2014 16:46:00 -0000
From: Adam Dinwoodie <adam@dinwoodie.org>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Snapshot install instructions use bz2, not xz
Message-ID: <20140129164607.GA14239@tastycake.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00028.txt.bz2


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 450

All,

I've attached a minor correction to the FAQ entry on installing
snapshots, to note that snapshots are now .xz archives, rather than
.bz2.

I've not been able to build this: the docs build requires "fop", which
isn't available in the main Cygwin repositories, and I don't
particularly want to set up this machine to start pulling packages from
Cygwin Ports.

2014-01-29  Adam Dinwoodie

	* faq-setup.xml (faq.setup.snapshots): Use .xz not .bz2.

--PNTmBPCT7hxwcZjr
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="faq-patch.diff"
Content-length: 1396

Index: doc/faq-setup.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-setup.xml,v
retrieving revision 1.32
diff -u -p -r1.32 faq-setup.xml
--- doc/faq-setup.xml	12 Nov 2013 22:21:32 -0000	1.32
+++ doc/faq-setup.xml	29 Jan 2014 15:36:23 -0000
@@ -539,7 +539,7 @@ bugfix that you need to try, and you are
 problems, or at the request of a Cygwin developer.
 </para>
 <para>You should generally install the full
-<literal>cygwin-inst-YYYYMMDD.tar.bz2</literal> update, rather than just the DLL,
+<literal>cygwin-inst-YYYYMMDD.tar.xz</literal> update, rather than just the DLL,
 otherwise some components may be out of sync.
 </para>
 <para>You cannot use Cygwin Setup to install a snapshot.
@@ -561,8 +561,8 @@ you are only installing the DLL snapshot
 a <literal>bash</literal> shell (it should be the only running Cygwin process) and issue
 the following commands:
 <screen>
-	/bin/tar -C/ -jxvf /posix/path/to/cygwin-inst-YYYYMMDD.tar.bz2 --exclude=usr/bin/cygwin1.dll
-	/bin/tar -C/tmp -jxvf /posix/path/to/cygwin-inst-YYYYMMDD.tar.bz2 usr/bin/cygwin1.dll
+	/bin/tar -C/ -Jxvf /posix/path/to/cygwin-inst-YYYYMMDD.tar.xz --exclude=usr/bin/cygwin1.dll
+	/bin/tar -C/tmp -Jxvf /posix/path/to/cygwin-inst-YYYYMMDD.tar.xz usr/bin/cygwin1.dll
 </screen>
 </para>
 <para>Exit the bash shell, and use Explorer or the Windows command shell to

--PNTmBPCT7hxwcZjr--
