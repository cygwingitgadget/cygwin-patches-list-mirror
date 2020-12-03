Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 2C3E43858C27
 for <cygwin-patches@cygwin.com>; Thu,  3 Dec 2020 21:21:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2C3E43858C27
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 2D24ECB81
 for <cygwin-patches@cygwin.com>; Thu,  3 Dec 2020 16:21:38 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 2B7E4CB56
 for <cygwin-patches@cygwin.com>; Thu,  3 Dec 2020 16:21:38 -0500 (EST)
Date: Thu, 3 Dec 2020 13:21:38 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/1] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn
Message-ID: <alpine.BSO.2.21.2012031317260.9707@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-14.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_LOW,
 SPF_HELO_PASS, SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 03 Dec 2020 21:21:41 -0000

if a new CYGWIN/MSYS environment option `winjitdebug` is true, allowing
native subprocesses to get Windows-default error handling behavior (such
as invoking the registered JIT debugger).  Cygwin processes will quickly
set their error mode on start, so getting JIT debugging for them will
still require setting `error_start`.

This patch was previously submitted to MSYS2
(https://github.com/msys2/msys2-runtime/pull/18) but it was suggested I
should try sending it upstream.

---
 winsup/cygwin/environ.cc | 1 +
 winsup/cygwin/globals.cc | 1 +
 winsup/cygwin/spawn.cc   | 2 ++
 winsup/doc/cygwinenv.xml | 9 +++++++++
 4 files changed, 13 insertions(+)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 3a03657db..fa47f4b31 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -120,6 +120,7 @@ static struct parse_thing
   {"wincmdln", {&wincmdln}, setbool, NULL, {{false}, {true}}},
   {"winsymlinks", {func: set_winsymlinks}, isfunc, NULL, {{0}, {0}}},
   {"disable_pcon", {&disable_pcon}, setbool, NULL, {{false}, {true}}},
+  {"winjitdebug", {&spawn_default_errmode}, setbool, NULL, {{false}, {true}}},
   {NULL, {0}, setdword, 0, {{0}, {0}}}
 };

diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index 942bd1c83..2d2ac0949 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -71,6 +71,7 @@ bool reset_com;
 bool wincmdln;
 winsym_t allow_winsymlinks = WSYM_sysfile;
 bool disable_pcon;
+bool spawn_default_errmode;

 bool NO_COPY in_forkee;

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 92d190d1a..6239e3539 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -430,6 +430,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       sigproc_printf ("priority class %d", c_flags);

       c_flags |= CREATE_SEPARATE_WOW_VDM | CREATE_UNICODE_ENVIRONMENT;
+      if (spawn_default_errmode)
+	c_flags |= CREATE_DEFAULT_ERROR_MODE;

       /* We're adding the CREATE_BREAKAWAY_FROM_JOB flag here to workaround
 	 issues with the "Program Compatibility Assistant (PCA) Service".
diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index a52b6ac19..7137edcb9 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -103,6 +103,15 @@ pty will be disabled.  This is for programs which do not work properly
 under pty with pseudo console enabled.  Defaults to not set.</para>
 </listitem>

+<listitem>
+<para><envar>winjitdebug</envar> - if set, the
+<literal>CREATE_DEFAULT_ERROR_MODE</literal> flag is passed to
+<literal>CreateProcess</literal> in <literal>spawn</literal>.  This prevents
+cygwin-set error mode flags from being inherited by the new process, allowing
+native processes to invoke any system-registered JIT debugger, and/or invoke
+Windows Error Reporting.  Defaults to not set.</para>
+</listitem>
+
 </itemizedlist>

 </sect2>
-- 
2.29.2.windows.2


