Return-Path: <cygwin-patches-return-9969-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126240 invoked by alias); 21 Jan 2020 13:25:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126230 invoked by uid 89); 21 Jan 2020 13:25:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=para, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 21 Jan 2020 13:25:31 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-02.nifty.com with ESMTP id 00LDPLii013678;	Tue, 21 Jan 2020 22:25:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com 00LDPLii013678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579613126;	bh=3tRg3+yDtn/iXgGzAFW1GxKi1HEfZhRw0VumXfon028=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=SU460oSGeVt6LLIiwsLOPUbPPadENyvR3FZWsKgkRoEaEmSAGQjwAg7/wOj8tAh3R	 Dhx8M4MtGSBSzYRGa7JqtRp1BtqZnwRsNW/nJaX22eyjTVujdisM1uE7V0lSXVIVSz	 6R/wDRgKmnKXD4EkUVF0t5kqYCk0lPHb5dkOBQIQtK5ka+AOToFPr6aGPor/7HcUHo	 IxOJ2Pkfogoj+yMW4Nw80NbQVzjsx5iZ9U8SBME3o0jDswOAn9gnyNYAfMIQQ683y3	 kyqjNiD2+l8IlfPgrnbo7EFbriqkOuC0v6JBtiT6hQvgJzgDWOMnRz3vR2Z5Fyweaq	 SBVjLJ+NbbKhQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
Date: Tue, 21 Jan 2020 13:25:00 -0000
Message-Id: <20200121132513.3654-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200121222329.69f71c847e97da78955735a7@nifty.ne.jp>
References: <20200121222329.69f71c847e97da78955735a7@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00075.txt

- For programs which does not work properly with pseudo console,
  disable_pcon in environment CYGWIN is introduced. If disable_pcon
  is set, pseudo console support is disabled.
---
 winsup/cygwin/environ.cc      | 1 +
 winsup/cygwin/fhandler_tty.cc | 2 ++
 winsup/cygwin/globals.cc      | 1 +
 winsup/doc/cygwinenv.xml      | 6 ++++++
 4 files changed, 10 insertions(+)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 8c5ce64e1..7eb4780a8 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -120,6 +120,7 @@ static struct parse_thing
   {"reset_com", {&reset_com}, setbool, NULL, {{false}, {true}}},
   {"wincmdln", {&wincmdln}, setbool, NULL, {{false}, {true}}},
   {"winsymlinks", {func: set_winsymlinks}, isfunc, NULL, {{0}, {0}}},
+  {"disable_pcon", {&disable_pcon}, setbool, NULL, {{false}, {true}}},
   {NULL, {0}, setdword, 0, {{0}, {0}}}
 };
 
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index fff5bebe3..a5db0967b 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3132,6 +3132,8 @@ is_running_as_service (void)
 bool
 fhandler_pty_master::setup_pseudoconsole ()
 {
+  if (disable_pcon)
+    return false;
   /* If the legacy console mode is enabled, pseudo console seems
      not to work as expected. To determine console mode, registry
      key ForceV2 in HKEY_CURRENT_USER\Console is checked. */
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index ebe8b569f..a9648fe6a 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -71,6 +71,7 @@ bool pipe_byte;
 bool reset_com;
 bool wincmdln;
 winsym_t allow_winsymlinks = WSYM_sysfile;
+bool disable_pcon;
 
 bool NO_COPY in_forkee;
 
diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index 6f67cb95d..1bc02f986 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -99,6 +99,12 @@ system call will immediately fail.</para>
 <xref linkend="pathnames-symlinks"></xref>.</para>
 </listitem>
 
+<listitem>
+<para><envar>disable_pcon</envar> - if set, pseudo console support in
+pty will be disabled. This is for programs which does not work properly
+under pty with pseudo console enabled. Defaults to not set.
+</listitem>
+
 </itemizedlist>
 
 </sect2>
-- 
2.21.0
