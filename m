Return-Path: <cygwin-patches-return-8247-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102686 invoked by alias); 6 Oct 2015 20:41:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102672 invoked by uid 89); 6 Oct 2015 20:41:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS,SPF_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 06 Oct 2015 20:41:48 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id t96KfkSf028550	for <cygwin-patches@cygwin.com>; Tue, 6 Oct 2015 16:41:46 -0400
Received: from [192.168.1.5] (cpe-67-249-176-138.twcny.res.rr.com [67.249.176.138])	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id t96KfjEF009814	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Tue, 6 Oct 2015 16:41:46 -0400
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: New FAQ entry about permissions since Cygwin 1.7.34
Message-ID: <56143209.6060201@cornell.edu>
Date: Tue, 06 Oct 2015 20:41:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00000.txt.bz2

There have been several recent threads on the cygwin list stemming from 
the permissions change in 1.7.34.  I've pointed people to the FAQ about 
ssh public key authentication, which is not the first place where 
someone with this problem is likely to look.  The following patch 
attempts to remedy this:

---
  winsup/doc/ChangeLog     |  4 ++++
  winsup/doc/faq-using.xml | 42 ++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 46 insertions(+)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 35935be..7e85a76 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,7 @@
+2015-10-06  Ken Brown  <kbrown@cornell.edu>
+
+       * faq-using.xml (faq.using.same-with-permissions): New entry.
+
  2015-09-07  Brian Inglis  <Brian.Inglis@SystematicSw.ab.ca>

         * faq-using.xml (faq.using.man): Replace makewhatis with mandb.
diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index 7656880..0564504 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -1183,6 +1183,48 @@ Users</computeroutput> group instead.</para>

  </answer></qandaentry>

+<qandaentry id="faq.using.same-with-permissions">
+<question><para>Why do my files have extra permissions after updating 
to Cygwin 1.7.34?</para></question>
+<answer>
+
+<para>The problem is exactly the same as with the key files of SSH.  See
+<xref linkend="faq.using.ssh-pubkey-stops-working"/>.</para>
+
+<para>The solution is the same:</para>
+
+<screen>
+  $ ls -l *
+  -rw-rwxr--+ 1 user group 42 Nov 12  2010 file1
+  -rw-rwxr--+ 1 user group 42 Nov 12  2010 file2
+  $ setfacl -b *
+  $ ls -l *
+  -rw-r--r--  1 user group 42 Nov 12  2010 file1
+  -rw-r--r--  1 user group 42 Nov 12  2010 file2
+</screen>
+
+<para>You may find that newly-created files also have unexpected
+permissions:</para>
+
+<screen>
+  $ touch foo
+  $ ls -l foo
+  -rw-rwxr--+ 1 user group 42 Nov 12  2010 foo
+</screen>
+
+<para>This probably means that the directory in which you're creating
+the files has unwanted default ACL entries that are inherited by
+newly-created files and subdirectories.  The solution is again the
+same:</para>
+
+<screen>
+  $ setfacl -b .
+  $ touch bar
+  $ ls -l bar
+  -rw-r--r--  1 user group 42 Nov 12  2010 bar
+</screen>
+
+</answer></qandaentry>
+
  <qandaentry id="faq.using.tcl-tk">
  <question><para>Why do my Tk programs not work anymore?</para></question>
  <answer>
--
2.5.3

Ken
