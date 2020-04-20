Return-Path: <david.macek.0@gmail.com>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by sourceware.org (Postfix) with ESMTPS id 517B13858D31
 for <cygwin-patches@cygwin.com>; Mon, 20 Apr 2020 17:20:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 517B13858D31
Received: by mail-wr1-x441.google.com with SMTP id f13so13147437wrm.13
 for <cygwin-patches@cygwin.com>; Mon, 20 Apr 2020 10:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=/CoMO5n/A1BR6L3RDL4iSfveFRIYZW8SqDv0wl/GX1g=;
 b=o9fAjSx1dYkjP/tNE9uM+jRLmWXL6+0kBUHhvMWzL/7MO0iDHKSHduXwdOrfHUosnk
 /S96DLh7KTByd87/cIM1qw449YaV8o7LlxgdfCURMi7NFO010gbtN6lj9H1/SUB2lwHj
 onuOhXLNuDZ34CNhcSuYue6tlqOGLBVQO2+hvu/8nF0dc2TZGaeogPsBBYBotIE+A71R
 RYFVQ0w38d8tTQNBM1RwzQfumlHogd8lnFuQacQOWdy6D8QjgzdpVjSaHa4tG4QUG6Yv
 lvLwLI0XkmRaqdIq1HNkivWPCqLgOqzwDPmow5vsY+TYVuwlWxcC4W/SJfFYwqrvMZhD
 99IQ==
X-Gm-Message-State: AGi0PuZaoz3E0QcdZSEZBrD+obMpbPde9Gmw1rwk7znXk6n3fKIYFOis
 Ny77JPAMErt6e8U0UM2m5dc/JxQy8eY=
X-Google-Smtp-Source: APiQypK53uae6URUiveLZzna6hAECoT9L/a7+nGMGbC0uBUvCc8o6QuvphTsCQ5ii81U0tL3z4BmCQ==
X-Received: by 2002:a5d:4dd1:: with SMTP id f17mr18910232wru.383.1587403251874; 
 Mon, 20 Apr 2020 10:20:51 -0700 (PDT)
Received: from localhost ([193.165.97.202])
 by smtp.gmail.com with ESMTPSA id f23sm128284wml.4.2020.04.20.10.20.50
 for <cygwin-patches@cygwin.com>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 20 Apr 2020 10:20:51 -0700 (PDT)
Date: Mon, 20 Apr 2020 19:20:47 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3 v2] Cygwin: accounts: Unify nsswitch.conf db_* defaults
Message-ID: <20200420192047.000069a0@gmail.com>
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 20 Apr 2020 17:20:54 -0000

Signed-off-by: David Macek <david.macek.0@gmail.com>
---
 winsup/cygwin/uinfo.cc | 11 +----------
 winsup/doc/ntsec.xml   | 27 +++++++--------------------
 2 files changed, 8 insertions(+), 30 deletions(-)

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
index 5287845686..032bebe4dc 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -874,9 +874,6 @@ set up to all default values:
   db_prefix:    auto
   db_separator: + -->
   db_enum:  cache builtin
-  db_home:  /home/%U
-  db_shell: /bin/bash
-  db_gecos: &lt;empty&gt;
 </screen>
 
 <sect4 id="ntsec-mapping-nsswitch-syntax"><title id="ntsec-mapping-nsswitch-syntax.title">The <filename>/etc/nsswitch.conf</filename> syntax</title>
@@ -1508,15 +1505,8 @@ of each schema when used with <literal>db_home:</literal>
 
 <para>
 As has been briefly mentioned before, the default setting for
-<literal>db_home:</literal> is
-</para>
-
-<screen>
-  db_home: /home/%U
-</screen>
-
-<para>
-So by default, Cygwin just sets the home dir to
+<literal>db_home:</literal> defines no schemata, which means only the fallback
+option is used, so by default, Cygwin just sets the home dir to
 <filename>/home/$USERNAME</filename>.
 </para>
 
@@ -1591,14 +1581,11 @@ when used with <literal>db_shell:</literal>
 
 <para>
 As for <literal>db_home:</literal>, the default setting for
-<literal>db_shell:</literal> is pretty much a constant
+<literal>db_shell:</literal> defines no schemata, which means only the fallback
+option is used, so by default, Cygwin just sets the home dir to
+<filename>/bin/bash</filename>.
 </para>
 
-<screen>
-  db_shell: /bin/bash
-</screen>
-
-
 </sect4>
 
 <sect4 id="ntsec-mapping-nsswitch-gecos">
@@ -1664,13 +1651,13 @@ The following list describes the meaning of each schema when used with
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
+The default setting for <literal>db_gecos:</literal> defines no schemata.
 </para>
 
 </sect4>
-- 
2.26.1.windows.1

