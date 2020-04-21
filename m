Return-Path: <david.macek.0@gmail.com>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by sourceware.org (Postfix) with ESMTPS id D9875384B0C1
 for <cygwin-patches@cygwin.com>; Tue, 21 Apr 2020 18:31:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D9875384B0C1
Received: by mail-wr1-x444.google.com with SMTP id s10so8539470wrr.0
 for <cygwin-patches@cygwin.com>; Tue, 21 Apr 2020 11:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=HzgMnJlBwuxNU5QMln7LDrwnDOGqP13Nn9Ul1aoJuTY=;
 b=ApIMCpvTrfEInSkbHfIW94S7wEitXBgS2jWwGuvi3iEj+CzPDtUvrdNY9NL8Q5ZoHz
 GOcQlZgYVMDqF1T04eLZYMnqHOpmAAyPryRPlyZ0zgkSr1hkGJeLbcvPnZOU0kmsUISz
 Y5mfopFLikiBvDNvN3VkBegveOmJg13SE6vhYHpaF7GX/Dqa41Tgwgwnf4Ea+mOvbbal
 hIs7eP3puWNOD4uItCS1d4HvmD2oRhYp9/B7toyhIZyTXiYmRIm++7gje1a2IppvCBEN
 EFdgyQbmxZ4/eq3Z8Tr+YaGmJAs6XbMK2YulcigDjY0iSuVuczESn4idnlOMDNdNjUix
 LU/A==
X-Gm-Message-State: AGi0PuaKsLdviGY6c4Z4fopA5j2/GjdLThMGfkgZTovuTW2A6o+r0iqz
 JAJecQSIXzRvzAOXyiLGpTogPVYPHD0=
X-Google-Smtp-Source: APiQypIVFcI+YJFluK78WnGNZvoqA24hkBExajng3JUDXaQH6fv9f3rkVKWR+/YmcVXA2njV/9+5fA==
X-Received: by 2002:adf:db41:: with SMTP id f1mr24208715wrj.13.1587493873400; 
 Tue, 21 Apr 2020 11:31:13 -0700 (PDT)
Received: from localhost ([193.165.97.202])
 by smtp.gmail.com with ESMTPSA id s14sm4479228wme.33.2020.04.21.11.31.12
 for <cygwin-patches@cygwin.com>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 21 Apr 2020 11:31:12 -0700 (PDT)
Date: Tue, 21 Apr 2020 20:31:09 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3 v3] Cygwin: accounts: Unify nsswitch.conf db_* defaults
Message-ID: <20200421203106.00002fd7@gmail.com>
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, GIT_PATCH_0, GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 21 Apr 2020 18:31:18 -0000

Signed-off-by: David Macek <david.macek.0@gmail.com>
---
 winsup/cygwin/uinfo.cc | 11 +----------
 winsup/doc/ntsec.xml   | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 57d90189d3..2d5fc488bb 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -626,15 +626,12 @@ cygheap_pwdgrp::init ()
   grp_cache.cygserver.init_grp ();
   grp_cache.file.init_grp ();
   grp_cache.win.init_grp ();
-  /* Default settings:
+  /* Default settings (excluding fallbacks):
 
      passwd: files db
      group:  files db
      db_prefix: auto		DISABLED
      db_separator: +		DISABLED
-     db_home: cygwin desc
-     db_shell: cygwin desc
-     db_gecos: cygwin desc
      db_enum: cache builtin
   */
   pwd_src = (NSS_SRC_FILES | NSS_SRC_DB);
@@ -831,12 +828,6 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 		  c += strspn (c, " \t");
 		  ++idx;
 		}
-	      /* If nothing has been set, revert to default. */
-	      if (scheme[0].method == NSS_SCHEME_FALLBACK)
-		{
-		  scheme[0].method = NSS_SCHEME_CYGWIN;
-		  scheme[1].method = NSS_SCHEME_DESC;
-		}
 	    }
 	}
       break;
diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index 5287845686..a4c253098d 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -1507,19 +1507,16 @@ of each schema when used with <literal>db_home:</literal>
 </variablelist>
 
 <para>
-As has been briefly mentioned before, the default setting for
-<literal>db_home:</literal> is
+<literal>db_home:</literal> defines no default schemata.  If this setting is not
+present in <filename>/etc/nsswitch.conf</filename>, the aforementioned fallback
+takes over, which is equivalent to a <filename>/etc/nsswitch.conf</filename>
+settting of
 </para>
 
 <screen>
   db_home: /home/%U
 </screen>
 
-<para>
-So by default, Cygwin just sets the home dir to
-<filename>/home/$USERNAME</filename>.
-</para>
-
 </sect4>
 
 <sect4 id="ntsec-mapping-nsswitch-shell">
@@ -1590,8 +1587,10 @@ when used with <literal>db_shell:</literal>
 </variablelist>
 
 <para>
-As for <literal>db_home:</literal>, the default setting for
-<literal>db_shell:</literal> is pretty much a constant
+<literal>db_shell:</literal> defines no default schemata.  If this setting is
+not present in <filename>/etc/nsswitch.conf</filename>, the aforementioned
+fallback takes over, which is equivalent to a
+<filename>/etc/nsswitch.conf</filename> settting of
 </para>
 
 <screen>
@@ -1664,13 +1663,13 @@ The following list describes the meaning of each schema when used with
   <varlistentry>
     <term>Fallback</term>
     <listitem>If none of the schemes given for <literal>db_gecos:</literal>
-	      define a non-empty pathname, nothing is added to
+	      define a non-empty string, nothing is added to
 	      <literal>pw_gecos</literal>.</listitem>
   </varlistentry>
 </variablelist>
 
 <para>
-The default setting for <literal>db_gecos:</literal> is the empty string.
+<literal>db_gecos:</literal> defines no default schemata.
 </para>
 
 </sect4>
-- 
2.26.1.windows.1

