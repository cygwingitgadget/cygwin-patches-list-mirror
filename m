Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta23-re.btinternet.com
 [213.120.69.116])
 by sourceware.org (Postfix) with ESMTPS id CC4463985456
 for <cygwin-patches@cygwin.com>; Wed, 16 Jun 2021 16:20:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CC4463985456
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20210616162016.OAUD11727.re-prd-fep-042.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 16 Jun 2021 17:20:16 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9C0CC37B36E4E
X-Originating-IP: [86.139.156.26]
X-OWM-Source-IP: 86.139.156.26 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddufeelrdduheeirddvieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheeirddviedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.156.26) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC37B36E4E; Wed, 16 Jun 2021 17:20:16 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Cygwin: Use cmdsynopsis element in utils documentation
Date: Wed, 16 Jun 2021 17:19:18 +0100
Message-Id: <20210616161918.41015-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616161918.41015-1-jon.turney@dronecode.org.uk>
References: <20210616161918.41015-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 16 Jun 2021 16:20:19 -0000

Use <cmdsynopsis> element markup in utils docbook documentation, rather
than some preformatted text inside <screen>.

(This didn't happen as part of 646745cb, when we first started using
refentry elements to make it possible to generate manpages)

This helps produce better looking manpages:

* uses bold (for command names) and italic (for replaceable items)
* different output formats inconsistently treat tabs inside <screen>
(so we have to be careful to not use them in that preformatted text)

Also clean up various issues:

* Replace '[OPTIONS]' with a real synopsis of the options
* Consistently use 'ITEM...' rather than 'ITEM1 [ITEM2...]' for an item
which should appear 1 or more times (cygcheck -f, getfacl, kill)
* Consistently document the '-h | -V' invocation form
* Since replaceable items are now marked up so they have some formatting
indicating they are replaceable, we can drop wrapping them in angle
brackets, as is done in some places
* Add missing '-W' and '-p PID' options to ps synopsis
* Adjust cygpath synopsis to show that only one 'System information'
option is allowed, possibly modified by -A

Future work:
* Sync up the actual help emitted by the util, where it's been improved
* Also don't use <screen> for formatting 'OPTIONS' section of manpage
* pldd inconsistently uses '-?' rather than '-h'!
---
 winsup/doc/utils.xml | 658 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 567 insertions(+), 91 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 55594ef5f..1d9b8488c 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -26,9 +26,26 @@
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-chattr [-RVfHv] [+-=mode]... [file]...
-      </screen>
+      <cmdsynopsis>
+	<command>chattr</command>
+	<arg>-RVf</arg>
+	<arg rep="repeat">
+	  <group choice="req">
+	    <arg choice="plain">+</arg>
+	    <arg choice="plain">-</arg>
+	    <arg choice="plain">=</arg>
+	  </group>
+	  <replaceable>MODE</replaceable>
+	</arg>
+	<arg rep="repeat"><replaceable>FILE</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>chattr</command>
+	<group choice="plain">
+	  <arg choice="plain">-H</arg>
+	  <arg choice="plain">-v</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="chattr-options">
@@ -91,17 +108,54 @@ chattr [-RVfHv] [+-=mode]... [file]...
       </refnamediv>
 
       <refsynopsisdiv>
-	<screen>
-cygcheck [-v] [-h] PROGRAM
-cygcheck -c [-d] [PACKAGE]
-cygcheck -s [-r] [-v] [-h]
-cygcheck -k
-cygcheck -f FILE [FILE]...
-cygcheck -l [PACKAGE]...
-cygcheck -p REGEXP
-cygcheck --delete-orphaned-installation-keys
-cygcheck -h
-	</screen>
+	<cmdsynopsis>
+	  <command>cygcheck</command>
+	  <arg>-v</arg>
+	  <arg>-h</arg>
+	  <arg choice="plain"><replaceable>PROGRAM</replaceable></arg>
+	</cmdsynopsis>
+	<cmdsynopsis>
+	  <command>cygcheck</command>
+	  <arg choice="plain">-c</arg>
+	  <arg>-d</arg>
+	  <arg><replaceable>PACKAGE</replaceable></arg>
+	</cmdsynopsis>
+	<cmdsynopsis>
+	  <command>cygcheck</command>
+	  <arg choice="plain">-s</arg>
+	  <arg>-r</arg>
+	  <arg>-v</arg>
+	  <arg>-h</arg>
+	</cmdsynopsis>
+	<cmdsynopsis>
+	  <command>cygcheck</command>
+	  <arg choice="plain">-k</arg>
+	</cmdsynopsis>
+	<cmdsynopsis>
+	  <command>cygcheck</command>
+	  <arg choice="plain">-f</arg>
+	  <arg choice="plain" rep="repeat"><replaceable>FILE</replaceable></arg>
+	</cmdsynopsis>
+	<cmdsynopsis>
+	  <command>cygcheck</command>
+	  <arg choice="plain">-l</arg>
+	  <arg rep="repeat"><replaceable>PACKAGE</replaceable></arg>
+	</cmdsynopsis>
+	<cmdsynopsis>
+	  <command>cygcheck</command>
+	  <arg choice="plain">-p <replaceable>REGEXP</replaceable></arg>
+	</cmdsynopsis>
+	<cmdsynopsis>
+	  <command>cygcheck</command>
+	  <arg choice="plain">--delete-orphaned-installation-keys</arg>
+	</cmdsynopsis>
+	<cmdsynopsis>
+	  <command>cygcheck</command>
+	  <group choice="plain">
+	    <arg choice="plain">-h</arg>
+	    <arg choice="plain">-V</arg>
+	  </group>
+	</cmdsynopsis>
       </refsynopsisdiv>
 
       <refsect1 id="cygcheck-options">
@@ -302,12 +356,44 @@ coreutils-5.3.0-6         GNU core utilities (includes fileutils, sh-utils and t
     </refnamediv>
 
     <refsynopsisdiv>
-    <screen>
-cygpath (-d|-m|-u|-w|-t TYPE) [-f FILE] [OPTION]... NAME...
-cygpath [-c HANDLE]
-cygpath [-ADHOPSW]
-cygpath [-F ID]
-    </screen>
+      <cmdsynopsis>
+	<command>cygpath</command>
+	<group choice="req">
+	  <arg choice="plain">-d</arg>
+	  <arg choice="plain">-m</arg>
+	  <arg choice="plain">-u</arg>
+	  <arg choice="plain">-w</arg>
+	  <arg choice="plain">-t <replaceable>TYPE</replaceable></arg>
+	</group>
+	<arg>-f <replaceable>FILE</replaceable></arg>
+	<arg>-i</arg>
+	<arg rep="repeat"><replaceable>CONVERSION_OPTION</replaceable></arg>
+	<arg rep="repeat" choice="plain"><replaceable>NAME</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>cygpath</command>
+	<arg>-c <replaceable>HANDLE</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>cygpath</command>
+	<arg>-A</arg>
+	<group choice="req">
+	  <arg choice="plain">-D</arg>
+	  <arg choice="plain">-H</arg>
+	  <arg choice="plain">-O</arg>
+	  <arg choice="plain">-P</arg>
+	  <arg choice="plain">-S</arg>
+	  <arg choice="plain">-W</arg>
+	  <arg choice="plain">-F <replaceable>ID</replaceable></arg>
+	</group>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>cygpath</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="cygpath-options">
@@ -489,9 +575,21 @@ explorer $XPATH &
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-dumper [OPTION] FILENAME WIN32PID
-      </screen>
+      <cmdsynopsis>
+	<command>dumper</command>
+	<arg>-n</arg>
+	<arg>-d</arg>
+	<arg>-q</arg>
+	<arg choice="plain"><replaceable>FILENAME</replaceable></arg>
+	<arg choice="plain"><replaceable>WIN32PID</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>dumper</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="dumper-options">
@@ -553,10 +651,24 @@ error_start=x:\path\to\dumper.exe
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-getconf [-v specification] variable_name [pathname]
-getconf -a [pathname]
-      </screen>
+      <cmdsynopsis>
+	<command>getconf</command>
+	<arg>-v <replaceable>specification</replaceable></arg>
+	<arg choice="plain"><replaceable>variable_name</replaceable></arg>
+	<arg><replaceable>pathname</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>getconf</command>
+	<arg choice="plain">-a</arg>
+	<arg><replaceable>pathname</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>getconf</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="getconf-options">
@@ -617,9 +729,18 @@ Other options:
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-getfacl [-adceEn] FILE [FILE2...]
-      </screen>
+      <cmdsynopsis>
+	<command>getfacl</command>
+	<arg>-adceEn</arg>
+	<arg choice="plain" rep="repeat"><replaceable>FILE</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>getfacl</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="getfacl-options">
@@ -685,10 +806,26 @@ line separates the ACLs for each file.
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-kill [-f] [-signal] [-s signal] pid1 [pid2 ...]
-kill -l [signal]
-      </screen>
+      <cmdsynopsis>
+	<command>kill</command>
+	<arg>-f</arg>
+	<arg>-signal</arg>
+	<arg>-s <replaceable>signal</replaceable></arg>
+	<arg choice="plain" rep="repeat"><replaceable>pid</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>kill</command>
+	<arg choice="plain">-l</arg>
+	<arg choice="repeat"><replaceable>signal</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>kill</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
+
     </refsynopsisdiv>
 
     <refsect1 id="kill-options">
@@ -811,9 +948,18 @@ SIGUSR2     31    user defined signal 2
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-ldd [OPTION]... FILE...
-      </screen>
+      <cmdsynopsis>
+	<command>ldd</command>
+	<arg>-ruv</arg>
+	<arg rep="repeat" choice="plain"><replaceable>FILE</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>ldd</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="ldd-options">
@@ -861,11 +1007,27 @@ ldd [OPTION]... FILE...
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-locale [-amvhV]
-locale [-ck] NAME
-locale [-iusfnU]
-      </screen>
+      <cmdsynopsis>
+	<command>locale</command>
+	<arg>-amvhV</arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>locale</command>
+	<arg>-ck</arg>
+	<arg choice="plain"><replaceable>NAME</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>locale</command>
+	<arg>-iusfnU</arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>locale</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
+
     </refsynopsisdiv>
 
     <refsect1  id="locale-options">
@@ -1041,9 +1203,18 @@ bash$ locale noexpr
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-lsattr [-RVadhln] [file]...
-      </screen>
+      <cmdsynopsis>
+	<command>lsattr</command>
+	<arg>-Radln</arg>
+	<arg rep="repeat"><replaceable>FILE</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>lsattr</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="lsattr-options">
@@ -1106,9 +1277,22 @@ lsattr [-RVadhln] [file]...
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-minidumper [OPTION] FILENAME WIN32PID
-      </screen>
+      <cmdsynopsis>
+	<command>minidumper</command>
+	<arg>-d</arg>
+	<arg>-n</arg>
+	<arg>-q</arg>
+	<arg>-t <replaceable>TYPE</replaceable></arg>
+	<arg choice="plain"><replaceable>FILENAME</replaceable></arg>
+	<arg choice="plain"><replaceable>WIN32PID</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>minidumper</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="minidumper-options">
@@ -1159,9 +1343,30 @@ minidumper [OPTION] FILENAME WIN32PID
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-mkgroup [OPTION]...
-      </screen>
+      <cmdsynopsis>
+	<command>mkgroup</command>
+	<arg>
+	  <group choice="plain">
+	    <arg choice="plain">-l</arg>
+	    <arg choice="plain">-L</arg>
+	  </group>
+	  <arg><replaceable>MACHINE</replaceable></arg>
+	</arg>
+	<arg>-d <arg><replaceable>DOMAIN</replaceable></arg></arg>
+	<arg>-c</arg>
+	<arg>-S <replaceable>CHAR</replaceable></arg>
+	<arg>-o <replaceable>OFFSET</replaceable></arg>
+	<arg>-g <replaceable>GROUPNAME</replaceable></arg>
+	<arg>-b</arg>
+	<arg>-U  <replaceable>GROUPLIST</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>mkgroup</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="mkgroup-options">
@@ -1261,9 +1466,30 @@ groups on domain controllers and domain member machines.
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-mkpasswd [OPTIONS]...
-      </screen>
+      <cmdsynopsis>
+	<command>mkpasswd</command>
+	<arg>
+	  <group choice="plain">
+	    <arg choice="plain">-l</arg>
+	    <arg choice="plain">-L</arg>
+	  </group>
+	  <arg><replaceable>MACHINE</replaceable></arg>
+	</arg>
+	<arg>-d <arg><replaceable>DOMAIN</replaceable></arg></arg>
+	<arg>-c</arg>
+	<arg>-S <replaceable>CHAR</replaceable></arg>
+	<arg>-o <replaceable>OFFSET</replaceable></arg>
+	<arg>-u <replaceable>USERNAME</replaceable></arg>
+	<arg>-b</arg>
+	<arg>-U  <replaceable>USERLIST</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>mkpassword</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="mkpasswd-options">
@@ -1371,11 +1597,41 @@ on domain controllers and domain member machines.
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-mount [OPTION] [&lt;win32path&gt; &lt;posixpath&gt;]
-mount -a
-mount &lt;posixpath&gt;
-      </screen>
+      <cmdsynopsis>
+	<command>mount</command>
+	<arg>-f</arg>
+	<arg>-o <arg choice="plain" rep="repeat"><replaceable>MOUNT_OPTION,</replaceable></arg></arg>
+	<arg choice="plain">
+	  <replaceable>WIN32PATH</replaceable>
+	  <replaceable>POSIXPATH</replaceable>
+	</arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>mount</command>
+	<arg choice="plain">-a</arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>mount</command>
+	<arg choice="plain"><replaceable>POSIXPATH</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>mount</command>
+	<arg>-m</arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>mount</command>
+	<group choice="plain">
+	  <arg choice="plain">-c <replaceable>POSIXPATH</replaceable></arg>
+	  <arg choice="plain">-p</arg>
+	</group>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>mount</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
      </refsynopsisdiv>
 
     <refsect1 id="mount-options">
@@ -1637,9 +1893,52 @@ D: on /d type fat (binary,user,noumount)
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-passwd [OPTION] [USER]
-      </screen>
+      <cmdsynopsis>
+	<command>passwd</command>
+	<group choice="plain">
+	  <arg>-S</arg>
+	  <arg choice="req">
+	    <group>
+	      <arg choice="plain">-l</arg>
+	      <arg choice="plain">-u</arg>
+	    </group>
+	    <group>
+	      <arg choice="plain">-c</arg>
+	      <arg choice="plain">-C</arg>
+	    </group>
+	    <group>
+	      <arg choice="plain">-e</arg>
+	      <arg choice="plain">-E</arg>
+	    </group>
+	    <group>
+	      <arg choice="plain">-p</arg>
+	      <arg choice="plain">-P</arg>
+	    </group>
+	  </arg>
+	</group>
+	<arg>-d <replaceable>SERVER</replaceable></arg>
+	<arg><replaceable>USER</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>passwd</command>
+	<arg choice="plain">-R</arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+      <command>passwd</command>
+      <group choice="plain">
+	<arg choice="plain">-i <replaceable>NUM</replaceable></arg>
+	<arg choice="plain">-n <replaceable>MINDAYS</replaceable></arg>
+	<arg choice="plain">-x <replaceable>MAXDAYS</replaceable></arg>
+	<arg choice="plain">-L <replaceable>LEN</replaceable></arg>
+      </group>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>passwd</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="passwd-options">
@@ -1798,9 +2097,18 @@ specifying an empty password.
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-pldd [OPTION...] PID
-      </screen>
+      <cmdsynopsis>
+	<command>pldd</command>
+	<arg choice="plain"><replaceable>PID</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>pldd</command>
+	<group choice="plain">
+	  <arg choice="plain">-?</arg>
+	  <arg choice="plain">--usage</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="pldd-options">
@@ -1832,9 +2140,19 @@ pldd [OPTION...] PID
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-ps [-aefls] [-u UID]
-      </screen>
+      <cmdsynopsis>
+	<command>ps</command>
+	<arg>-aeflsW</arg>
+	<arg>-u <replaceable>UID</replaceable></arg>
+	<arg>-p <replaceable>PID</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>ps</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="ps-options">
@@ -1905,9 +2223,87 @@ With no options, ps outputs the long format by default
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-regtool [OPTION] (add|check|get|list|remove|unset|load|unload|save) KEY
-      </screen>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg>-qvwW</arg>
+	<arg choice="plain">add|check|get|list|remove|unset|load|unload|save</arg>
+	<arg choice="plain"><replaceable>KEY</replaceable></arg>
+	<group>
+	  <arg choice="plain"><replaceable>PATH</replaceable></arg>
+	  <arg choice="plain" rep="repeat"><replaceable>DATA</replaceable></arg>
+	</group>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg choice="plain">add</arg>
+	<arg choice="plain"><replaceable>KEY\SUBKEY</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg choice="plain">check</arg>
+	<arg choice="plain"><replaceable>KEY</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg>-bnx</arg>
+	<arg choice="plain">get</arg>
+	<arg choice="plain"><replaceable>KEY</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg>-klp</arg>
+	<arg choice="plain">list</arg>
+	<arg choice="plain"><replaceable>KEY</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg choice="plain">remove</arg>
+	<arg choice="plain"><replaceable>KEY</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg>-bDeimnQsf</arg>
+	<arg choice="plain">set</arg>
+	<arg choice="plain"><replaceable>KEY\VALUE</replaceable></arg>
+	<arg rep="repeat"><replaceable>DATA</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg>-f</arg>
+	<arg choice="plain">unset</arg>
+	<arg choice="plain"><replaceable>KEY\VALUE</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg choice="plain">load</arg>
+	<arg choice="plain"><replaceable>KEY\SUBKEY</replaceable></arg>
+	<arg choice="plain"><replaceable>PATH</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg choice="plain">unload</arg>
+	<arg choice="plain"><replaceable>KEY\SUBKEY</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg choice="plain">save</arg>
+	<arg choice="plain"><replaceable>KEY\SUBKEY</replaceable></arg>
+	<arg choice="plain"><replaceable>PATH</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<arg>-f</arg>
+	<arg choice="plain">restore</arg>
+	<arg choice="plain"><replaceable>KEY/SUBKEY</replaceable></arg>
+	<arg choice="plain"><replaceable>PATH</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>regtool</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="regtool-options">
@@ -2098,10 +2494,34 @@ Example:
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-setfacl [-n] {-f ACL_FILE | -s acl_entries} FILE...
-setfacl [-n] {[-bk]|[-x acl_entries] [-m acl_entries]} FILE...
-      </screen>
+      <cmdsynopsis>
+	<command>setfacl</command>
+	<arg>-n</arg>
+	<group choice="req">
+	  <arg choice="plain">-f <replaceable>ACL_FILE</replaceable></arg>
+	  <arg choice="plain">-s <replaceable>acl_entries</replaceable></arg>
+	</group>
+	<arg choice="plain" rep="repeat"><replaceable>FILE</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>setfacl</command>
+	<arg>-n</arg>
+	<arg choice="req">
+	  <group choice="plain">
+	    <arg>-bk</arg>
+	    <arg>-x <replaceable>acl_entries</replaceable></arg>
+	  </group>
+	  <arg>-m <replaceable>acl_entries</replaceable></arg>
+	</arg>
+	<arg choice="plain" rep="repeat"><replaceable>FILE</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>setfacl</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
      </refsynopsisdiv>
 
     <refsect1 id="setfacl-options">
@@ -2247,9 +2667,20 @@ $ getfacl source_file | setfacl -f - target_file
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-setmetamode [metabit|escprefix]
-      </screen>
+      <cmdsynopsis>
+	<command>setmetamode</command>
+	<group>
+	  <arg choice="plain">metabit</arg>
+	  <arg choice="plain">escprefix</arg>
+	</group>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>setmetamode</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="setmetamode-options">
@@ -2295,9 +2726,20 @@ Other options:
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-ssp [options] low_pc high_pc command...
-      </screen>
+      <cmdsynopsis>
+	<command>ssp</command>
+	<arg>-cdelstv</arg>
+	<arg choice="plain"><replaceable>low_pc</replaceable></arg>
+	<arg choice="plain"><replaceable>high_pc</replaceable></arg>
+	<arg choice="plain" rep="repeat"><replaceable>command</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>ssp</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="ssp-options">
@@ -2466,10 +2908,28 @@ $ ssp <literal>-v</literal> <literal>-s</literal> <literal>-l</literal> <literal
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-strace [OPTIONS] &lt;command-line&gt;
-strace [OPTIONS] -p &lt;pid&gt;
-      </screen>
+      <cmdsynopsis>
+	<command>strace</command>
+	<arg>-defnqtuw</arg>
+	<arg>-b <replaceable>SIZE</replaceable></arg>
+	<arg>-m <replaceable>MASK</replaceable></arg>
+	<arg>-o <replaceable>FILENAME</replaceable></arg>
+	<arg>-f <replaceable>PERIOD</replaceable></arg>
+	<group choice="req">
+	  <arg choice="plain" rep="repeat"><replaceable>command-line</replaceable></arg>
+	  <arg choice="plain">
+	    <arg>-T</arg>
+	    <arg choice="plain">-p <replaceable>pid</replaceable></arg>
+	  </arg>
+	</group>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>strace</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1  id="strace-options">
@@ -2561,9 +3021,13 @@ $ strace -o tracing_output -w sh -c 'while true; do echo "tracing..."; done' &am
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-tzset [OPTION]
-      </screen>
+      <cmdsynopsis>
+	<command>tzset</command>
+	<group>
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="tzset-options">
@@ -2609,9 +3073,21 @@ setenv TZ `tzset`
     </refnamediv>
 
     <refsynopsisdiv>
-      <screen>
-umount [OPTION] [&lt;posixpath&gt;]
-      </screen>
+      <cmdsynopsis>
+	<command>umount</command>
+	<arg choice="plain"><replaceable>POSIXPATH</replaceable></arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>umount</command>
+	<arg choice="plain">-U</arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>umount</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="umount-options">
-- 
2.31.1

