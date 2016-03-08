Return-Path: <cygwin-patches-return-8378-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121126 invoked by alias); 8 Mar 2016 11:14:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119872 invoked by uid 89); 8 Mar 2016 11:14:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.8 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,TBC autolearn=no version=3.3.2 spammy=symantec, Symantec, Doctor, mechanic
X-HELO: rgout0404.bt.lon5.cpcloud.co.uk
Received: from rgout0404.bt.lon5.cpcloud.co.uk (HELO rgout0404.bt.lon5.cpcloud.co.uk) (65.20.0.217) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 08 Mar 2016 11:14:33 +0000
X-OWM-Source-IP: 86.179.112.186 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090201.56DEB417.0024,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.3.8.100017:17:27.888,ip=86.179.112.186,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, URI_ENDS_IN_HTML, __MAL_TELEKOM_URI, __URI_NO_WWW, __CP_URI_IN_BODY, __RUS_OBFU_PHONE, __INT_PROD_COMP, __URI_IN_BODY, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[186.112.179.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, __SINGLE_URI_TEXT, SINGLE_URI_IN_BODY, RDNS_SUSP
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.112.186) by rgout04.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 56D827260087F122; Tue, 8 Mar 2016 11:13:34 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] faq: Sort BLODA list and update advice on fixing fork failures
Date: Tue, 08 Mar 2016 11:14:00 -0000
Message-Id: <1457435653-8152-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q1/txt/msg00084.txt.bz2

	* faq-using.xml(bloda): Alphabetically sort BLODA list for ease of
	finding things in it.  (fixing-fork-failures) Update to suggest
	rebase-trigger rather than running rebaseall via dash yourself.
	Mention detect_bloda CYGWIN token.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/faq-using.xml | 88 ++++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index ae72145..9194677 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -1286,39 +1286,39 @@ behaviour which affect the operation of other programs, such as Cygwin.
 </para>
 <para>Among the software that has been found to cause difficulties are:</para>
 <para><itemizedlist>
-<listitem><para>Sonic Solutions burning software containing DLA component (when DLA disabled)</para></listitem>
-<listitem><para>Norton/McAfee/Symantec antivirus or antispyware</para></listitem>
-<listitem><para>Logitech webcam software with "Logitech process monitor" service</para></listitem>
-<listitem><para>Kerio, Agnitum or ZoneAlarm Personal Firewall</para></listitem>
-<listitem><para>Iolo System Mechanic/AntiVirus/Firewall</para></listitem>
-<listitem><para>LanDesk</para></listitem>
-<listitem><para>Windows Defender </para></listitem>
-<listitem><para>Various programs by Wave Systems Corp using wxvault.dll, including Embassy Trust Suite and Embassy Security Center</para></listitem>
-<listitem><para>NOD32 Antivirus</para></listitem>
-<listitem><para>ByteMobile laptop optimization client</para></listitem>
-<listitem><para>Earthlink Total-Access</para></listitem>
-<listitem><para>Spybot S&amp;D TeaTimer</para></listitem>
 <listitem><para>AR Soft RAM Disk</para></listitem>
 <listitem><para>ATI Catalyst (some versions)</para></listitem>
-<listitem><para>NVIDIA GeForce (some versions)</para></listitem>
-<listitem><para>Windows LiveOneCare</para></listitem>
-<listitem><para>Webroot Spy Sweeper with Antivirus</para></listitem>
-<listitem><para>COMODO Firewall Pro</para></listitem>
-<listitem><para>PC Tools Spyware Doctor</para></listitem>
+<listitem><para>AVAST (disable FILESYSTEM and BEHAVIOR realtime shields)</para></listitem>
 <listitem><para>Avira AntiVir</para></listitem>
-<listitem><para>Panda Internet Security</para></listitem>
 <listitem><para>BitDefender</para></listitem>
-<listitem><para>Google Desktop</para></listitem>
-<listitem><para>Sophos Anti-Virus 7</para></listitem>
 <listitem><para>Bufferzone from Trustware</para></listitem>
-<listitem><para>Lenovo IPS Core Service (ipssvc)</para></listitem>
-<listitem><para>Lenovo RapidBoot Shield</para></listitem>
-<listitem><para>Credant Guardian Shield</para></listitem>
-<listitem><para>AVAST (disable FILESYSTEM and BEHAVIOR realtime shields)</para></listitem>
+<listitem><para>ByteMobile laptop optimization client</para></listitem>
+<listitem><para>COMODO Firewall Pro</para></listitem>
 <listitem><para>Citrix Metaframe Presentation Server/XenApp (see <ulink url="http://support.citrix.com/article/CTX107825">Citrix Support page</ulink>)</para></listitem>
-<listitem><para>Lavasoft Web Companion</para></listitem>
+<listitem><para>Credant Guardian Shield</para></listitem>
+<listitem><para>Earthlink Total-Access</para></listitem>
 <listitem><para>Forefront TMG</para></listitem>
+<listitem><para>Google Desktop</para></listitem>
+<listitem><para>Iolo System Mechanic/AntiVirus/Firewall</para></listitem>
+<listitem><para>Kerio, Agnitum or ZoneAlarm Personal Firewall</para></listitem>
+<listitem><para>LanDesk</para></listitem>
+<listitem><para>Lavasoft Web Companion</para></listitem>
+<listitem><para>Lenovo IPS Core Service (ipssvc)</para></listitem>
+<listitem><para>Lenovo RapidBoot Shield</para></listitem>
+<listitem><para>Logitech webcam software with "Logitech process monitor" service</para></listitem>
 <listitem><para>MacType</para></listitem>
+<listitem><para>NOD32 Antivirus</para></listitem>
+<listitem><para>NVIDIA GeForce (some versions)</para></listitem>
+<listitem><para>Norton/McAfee/Symantec antivirus or antispyware</para></listitem>
+<listitem><para>PC Tools Spyware Doctor</para></listitem>
+<listitem><para>Panda Internet Security</para></listitem>
+<listitem><para>Sonic Solutions burning software containing DLA component (when DLA disabled)</para></listitem>
+<listitem><para>Sophos Anti-Virus 7</para></listitem>
+<listitem><para>Spybot S&amp;D TeaTimer</para></listitem>
+<listitem><para>Various programs by Wave Systems Corp using wxvault.dll, including Embassy Trust Suite and Embassy Security Center</para></listitem>
+<listitem><para>Webroot Spy Sweeper with Antivirus</para></listitem>
+<listitem><para>Windows Defender </para></listitem>
+<listitem><para>Windows LiveOneCare</para></listitem>
 </itemizedlist></para>
 <para>Sometimes these problems can be worked around, by temporarily or partially
 disabling the offending software.  For instance, it may be possible to disable
@@ -1398,14 +1398,38 @@ such as virtual memory paging and file caching.</para>
     <listitem>Ensure that you have eliminated (not just disabled) all
     software on the <xref linkend="faq.using.bloda"/>.
     </listitem>
-    <listitem>Read the 'rebase' package README in
-    <literal>/usr/share/doc/rebase/</literal>, and follow the
-    instructions there to run 'rebaseall'.</listitem>
+    <listitem>
+      <para>
+      Try setting the environment variable CYGWIN to "detect_bloda", which
+      enables some extra debugging, which may indicate what other software is
+      causing the problem.
+      </para>
+      <para>
+      See <ulink url="https://cygwin.com/ml/cygwin/2012-02/msg00797.html">this
+      mail</ulink> for more information.
+      </para>
+    </listitem>
+    <listitem>
+      <para>
+	Force a full rebase: Run <command>rebase-trigger fullrebase</command>,
+	exit all Cygwin programs and run Cygwin setup.
+      </para>
+      <para>
+	By default, Cygwin's setup program automatically performs an incremental
+	rebase of newly installed files.  Forcing a full rebase causes the
+	rebase map to be cleared before doing the rebase.
+      </para>
+      <para>
+	See <literal>/usr/share/doc/rebase/README</literal> and
+	<literal>/usr/share/doc/Cygwin/_autorebase.README</literal> for more
+	details.
+      </para>
+      <para>Please note that installing new packages or updating existing
+      ones undoes the effects of rebase and often causes fork() failures to
+      reappear.
+      </para>
+    </listitem>
     </itemizedlist></para>
-  <para>Please note that installing new packages or updating existing
-  ones undoes the effects of rebaseall and often causes fork() failures
-  to reappear. If so, just run rebaseall again.
-  </para>
   <para>See the <ulink url="https://cygwin.com/cygwin-ug-net/highlights.html#ov-hi-process">
   process creation</ulink> section of the User's Guide for the technical reasons it is so
   difficult to make <literal>fork()</literal> work reliably.</para>
-- 
2.7.0
