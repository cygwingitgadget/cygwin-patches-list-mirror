Return-Path: <cygwin-patches-return-8243-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9322 invoked by alias); 16 Sep 2015 13:06:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9295 invoked by uid 89); 16 Sep 2015 13:06:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_20,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.15) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 16 Sep 2015 13:06:28 +0000
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LymHf-1YZdTS0QEh-016B4G for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2015 15:06:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Sep 2015 13:06:00 -0000
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Allow overriding the home directory via the HOME variable
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
Message-ID: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com>
X-UI-Out-Filterresults: notjunk:1;V01:K0:LpDDUVMIkk8=:ks3/ubw9xrh0vXL9W9j9oN TMkggROg3b0AlE0q6mI256ubyac/S3MwOoniOtdExsKrIRQzNf1UuY+P/khWxJ94B8ybiqMzm CT1423iBu3J3rz0ODx4ZNx5qf950wVSQPrParfO35U+ry0joRaFOAOkQrXe7A8tZssb0XITVD kfcEKLJbnX6HQamWl2xtFHR93RuwmZZbIEkvXY0PbJWGmwVaTkKsIwC4emYsbNJdkEQd/Bxwm MnJ5mGi254zA1D9QX72G+eMw/9SyXTV7KAP2rLFJyMzON8ublZ9eqezv1RUSSOFCC8ebaBJgx 9D+ttCg0QbsaV0NGw16HXWQ2wA4X0egMYwJCIs8Uh1KwbIJH1dbe4b7K6E1vaDq4neaQfJB9i /nYMN8lEO0SHrKHwb1aIhBMeOGNLKhQsSPYLClF+9qHSdRUSVGwVF5sLBbAp0eq3ZG+Wt4YR3 ZSlLXOzye63/baK0BF4ge41O/jrcVvBtuWb54sNZgqjzlDHmh3Z/EGKkXd4s9ircWvuLyos3/ HJzRckvzhCieg8XW6novClMW+c0IR27QP4YWCDSH5+0Ys5XJkQGel38OrksluOljPnJ+vqveJ yNBrgbjEEoxaGF+UERIQKQSXD1pKe44zdJPAk4UZnVWVMsR6dhoCuYZ0kna2Tg4VdPEmOwOag rIkuOwBVbiPzj7hObmaFsCE7YPlLNQxxI0sF/pG04NJhuOrstgeS+IBVlgBa1ESk3oBLqmMoJ IZCoybjMEVdq2ozpj8BuGrfFokFn03hIHq4aoA==
X-IsSubscribed: yes
X-SW-Source: 2015-q3/txt/msg00025.txt.bz2

	* uinfo.cc (cygheap_pwdgrp::get_home): Offer an option in
	nsswitch.conf that let's the environment variable HOME (or
	HOMEDRIVE & HOMEPATH, or USERPROFILE) define the home
	directory.

	* ntsec.xml: Document the `env` schema.

Detailed comments:

In the context of Git for Windows, it is a well-established technique
to let the `$HOME` variable define where the current user's home
directory is, falling back to `$HOMEDRIVE$HOMEPATH` and `$USERPROFILE`.

The idea is that we want to share user-specific settings between
programs, whether they be Cygwin, MSys2 or not.  Unfortunately, we
cannot blindly activate the "db_home: windows" setting because in some
setups, the user's home directory is set to a hidden directory via an
UNC path (\\share\some\hidden\folder$) -- something many programs
cannot handle correctly.

The established technique is to allow setting the user's home directory
via the environment variables mentioned above.  This has the additional
advantage that it is much faster than querying the Windows user database.

Of course this scheme needs to be opt-in.  For that reason, it needs
to be activated explicitly via `db_home: env` in `/etc/nsswitch.conf`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/cygheap.h |  3 ++-
 winsup/cygwin/uinfo.cc  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 winsup/doc/ntsec.xml    | 20 ++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/cygheap.h b/winsup/cygwin/cygheap.h
index fd84814..097d50f 100644
--- a/winsup/cygwin/cygheap.h
+++ b/winsup/cygwin/cygheap.h
@@ -414,7 +414,8 @@ public:
     NSS_SCHEME_UNIX,
     NSS_SCHEME_DESC,
     NSS_SCHEME_PATH,
-    NSS_SCHEME_FREEATTR
+    NSS_SCHEME_FREEATTR,
+    NSS_SCHEME_ENV
   };
   struct nss_scheme_t {
     nss_scheme_method	method;
diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index da5809f..c74954a 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -780,6 +780,8 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 		    scheme[idx].method = NSS_SCHEME_UNIX;
 		  else if (NSS_CMP ("desc"))
 		    scheme[idx].method = NSS_SCHEME_DESC;
+		  else if (NSS_CMP ("env"))
+		    scheme[idx].method = NSS_SCHEME_ENV;
 		  else if (NSS_NCMP ("/"))
 		    {
 		      const char *e = c + strcspn (c, " \t");
@@ -970,6 +972,40 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cygpsid &sid, PCWSTR str,
   return ret;
 }
 
+static size_t
+fetch_env(LPCWSTR key, char *buf, size_t size)
+{
+  WCHAR wbuf[32767];
+  DWORD max = sizeof wbuf / sizeof *wbuf;
+  DWORD len = GetEnvironmentVariableW (key, wbuf, max);
+
+  if (!len || len >= max)
+    return 0;
+
+  len = sys_wcstombs (buf, size, wbuf);
+  return len && len < size ? len : 0;
+}
+
+static char *
+fetch_home_env (void)
+{
+  char home[32767];
+  size_t max = sizeof home / sizeof *home, len;
+
+  if (fetch_env (L"HOME", home, max)
+      || ((len = fetch_env (L"HOMEDRIVE", home, max))
+        && fetch_env (L"HOMEPATH", home + len, max - len))
+      || fetch_env (L"USERPROFILE", home, max))
+    {
+      tmp_pathbuf tp;
+      cygwin_conv_path (CCP_WIN_A_TO_POSIX | CCP_ABSOLUTE,
+	  home, tp.c_get(), NT_MAX_PATH);
+      return strdup(tp.c_get());
+    }
+
+  return NULL;
+}
+
 char *
 cygheap_pwdgrp::get_home (cyg_ldap *pldap, cygpsid &sid, PCWSTR dom,
 			  PCWSTR dnsdomain, PCWSTR name, bool full_qualified)
@@ -1029,6 +1065,9 @@ cygheap_pwdgrp::get_home (cyg_ldap *pldap, cygpsid &sid, PCWSTR dom,
 		}
 	    }
 	  break;
+	case NSS_SCHEME_ENV:
+	  home = fetch_home_env ();
+	  break;
 	}
     }
   return home;
@@ -1060,6 +1099,9 @@ cygheap_pwdgrp::get_home (PUSER_INFO_3 ui, cygpsid &sid, PCWSTR dom,
 	  home = fetch_from_path (NULL, ui, sid, home_scheme[idx].attrib,
 				  dom, NULL, name, full_qualified);
 	  break;
+	case NSS_SCHEME_ENV:
+	  home = fetch_home_env ();
+	  break;
 	}
     }
   return home;
@@ -1079,6 +1121,7 @@ cygheap_pwdgrp::get_shell (cyg_ldap *pldap, cygpsid &sid, PCWSTR dom,
 	case NSS_SCHEME_FALLBACK:
 	  return NULL;
 	case NSS_SCHEME_WINDOWS:
+	case NSS_SCHEME_ENV:
 	  break;
 	case NSS_SCHEME_CYGWIN:
 	  if (pldap->fetch_ad_account (sid, false, dnsdomain))
@@ -1143,6 +1186,7 @@ cygheap_pwdgrp::get_shell (PUSER_INFO_3 ui, cygpsid &sid, PCWSTR dom,
 	case NSS_SCHEME_CYGWIN:
 	case NSS_SCHEME_UNIX:
 	case NSS_SCHEME_FREEATTR:
+	case NSS_SCHEME_ENV:
 	  break;
 	case NSS_SCHEME_DESC:
 	  shell = fetch_from_description (ui->usri3_comment, L"shell=\"", 7);
@@ -1223,6 +1267,8 @@ cygheap_pwdgrp::get_gecos (cyg_ldap *pldap, cygpsid &sid, PCWSTR dom,
 		sys_wcstombs_alloc (&gecos, HEAP_NOTHEAP, val);
 	    }
 	  break;
+	case NSS_SCHEME_ENV:
+	  break;
 	}
     }
   if (gecos)
@@ -1249,6 +1295,7 @@ cygheap_pwdgrp::get_gecos (PUSER_INFO_3 ui, cygpsid &sid, PCWSTR dom,
 	case NSS_SCHEME_CYGWIN:
 	case NSS_SCHEME_UNIX:
 	case NSS_SCHEME_FREEATTR:
+	case NSS_SCHEME_ENV:
 	  break;
 	case NSS_SCHEME_DESC:
 	  gecos = fetch_from_description (ui->usri3_comment, L"gecos=\"", 7);
diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index ae0a119..9cee58c 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -1354,6 +1354,16 @@ schemata are the following:
 	      See <xref linkend="ntsec-mapping-nsswitch-desc"></xref>
 	      for a more detailed description.</listitem>
   </varlistentry>
+  <varlistentry>
+    <term><literal>env</literal></term>
+    <listitem>Derives the home directory from the environment variable
+	      <literal>HOME</literal> (falling back to
+	      <literal>HOMEDRIVE\HOMEPATH</literal> and
+	      <literal>USERPROFILE</literal>, in that order).  This is faster
+	      than the <term><literal>windows</literal></term> schema at the
+	      expense of determining only the current user's home directory
+	      correctly.</listitem>
+  </varlistentry>
 </variablelist>
 
 <para>
@@ -1487,6 +1497,16 @@ of each schema when used with <literal>db_home:</literal>
 	      for a detailed description.</listitem>
   </varlistentry>
   <varlistentry>
+    <term><literal>env</literal></term>
+    <listitem>Derives the home directory from the environment variable
+	      <literal>HOME</literal> (falling back to
+	      <literal>HOMEDRIVE\HOMEPATH</literal> and
+	      <literal>USERPROFILE</literal>, in that order).  This is faster
+	      than the <term><literal>windows</literal></term> schema at the
+	      expense of determining only the current user's home directory
+	      correctly.</listitem>
+  </varlistentry>
+  <varlistentry>
     <term><literal>@ad_attribute</literal></term>
     <listitem>AD only: The user's home directory is set to the path given
 	      in the <literal>ad_attribute</literal> attribute.  The path
-- 
2.5.2.windows.2

