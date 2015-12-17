Return-Path: <cygwin-patches-return-8288-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125617 invoked by alias); 17 Dec 2015 18:05:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125606 invoked by uid 89); 17 Dec 2015 18:05:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=BAYES_05,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=cygheap, deriving, 1100,7, 11007
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.19) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 17 Dec 2015 18:05:21 +0000
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MXI5V-1Zg5Q91ZrR-00WGFq for <cygwin-patches@cygwin.com>; Thu, 17 Dec 2015 19:05:16 +0100
Date: Thu, 17 Dec 2015 18:05:00 -0000
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/2] Support deriving the current user's home directory via HOME
In-Reply-To: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com>
Message-ID: <cover.1450375424.git.johannes.schindelin@gmx.de>
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:h7mJfl/l4yE=:W1aTdGLP61ZkzdsEACvJzQ A0+tYybAGcP9SEVNwbFXizJQLJ2FM2nLh2qsg/dlaHHRTiByf88qxoalGGQaxD841tS5OP0+9 ewX/y7cB9hB0DEfIEMJyigiRYHToqSE+hpknZdsZZCdf3y+AcmycHkLfjDHRMXm//GZ/YNHgZ KFENHYJBR7F10z1HI7Uw28cmbzDi59AaZzlBBPi60ehw4qZ233TBHHTB4VO5rzyYO93EYJEfi K6N2Bk7rqXwZ78dOchTdvc9PVLnHYncKQu6HsAn2LrWBYjFzve1bA9wSzjfKFOX4FwFddHzY1 IYO33Iio5bi74oSBBtq8jkM+Pos4bmmHivFXchMrUvdfa3IIIB6wRBTo4M/2xqtF44nBFoKCb 4ty0GhCfXekIZDeVILkW/MQbZ/y4qtStq759X1/MGHUFmwBAmrmRklHJJ9MBEhqBGvAwmu94P 0f+MzU7m9qUXrn4iIMBcIkXBvgAKvfoXOD7ZXjRPOfGzjLvM245QwmC8XW6JlmeWCcJsF6AC3 8UExFV03YiFwf8fXGoWTzWEhAlkBRMqPeHSy2ofkRdfiUSw7uPpl9mv3PZ1vwmCCK7Rcx6oe7 hGpkKv7+RwhOMPiiDNnGR9egtrAhLb8Mfx5SSijD2M2XsKIphp56gEh1oQQhLZs3KOQG1j0Ww XJtwFZvXHorrIRoiF8bPP/fQdIgiOqDgAGg1eVRMMp9hQZqRHrUInbs3sXA47gF/OXPRLQAO+ OnzRIM8M+LvwLFhRpG25KG4b4sV+hGgA6GJZGkTpFd2XNNUWJsBtWOdNUHQ7oHY/Ty+We+eT0 ilABJFK
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00041.txt.bz2

This patch mini-series supports Git for Windows' main strategy to
determine the current user's home directory by looking at the
environment variable HOME, falling back to HOMEDRIVE and HOMEPATH, and
if these variables are also unset, to USERPROFILE.

This strategy is a quick method to determine the home directory, and it
also allows users to override the home directory easily (e.g. in case
that their real home directory is a network share that is not all that
well handled by some commands such as cmd.exe's cd command).

Sorry for sending out v2 so late...!


Johannes Schindelin (2):
  Allow deriving the current user's home directory via the HOME variable
  Respect `db_home` setting even for the SYSTEM account

 winsup/cygwin/cygheap.h |  3 ++-
 winsup/cygwin/uinfo.cc  | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-
 winsup/doc/ntsec.xml    | 20 ++++++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)

Interdiff vs v1:

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 525a90e..8c51b82 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -1066,7 +1066,8 @@ cygheap_pwdgrp::get_home (cyg_ldap *pldap, cygpsid &sid, PCWSTR dom,
 	    }
 	  break;
 	case NSS_SCHEME_ENV:
-	  home = fetch_home_env ();
+	  if (RtlEqualSid (sid, cygheap->user.sid ()))
+	    home = fetch_home_env ();
 	  break;
 	}
     }
@@ -1100,7 +1101,8 @@ cygheap_pwdgrp::get_home (PUSER_INFO_3 ui, cygpsid &sid, PCWSTR dom,
 				  dom, NULL, name, full_qualified);
 	  break;
 	case NSS_SCHEME_ENV:
-	  home = fetch_home_env ();
+	  if (RtlEqualSid (sid, cygheap->user.sid ()))
+	    home = fetch_home_env ();
 	  break;
 	}
     }
@@ -2127,7 +2129,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t &arg, cyg_ldap *pldap)
 	 it to a well-known group here. */
       if (acc_type == SidTypeUser
 	  && (sid_sub_auth_count (sid) <= 3 || sid_id_auth (sid) == 11))
-	acc_type = SidTypeWellKnownGroup;
+	{
+	  acc_type = SidTypeWellKnownGroup;
+	  home = cygheap->pg.get_home (pldap, sid, dom, domain, name,
+				       fully_qualified_name);
+	}
       switch (acc_type)
       	{
 	case SidTypeUser:
diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index 9cee58c..14c37c5 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -1356,8 +1356,8 @@ schemata are the following:
   </varlistentry>
   <varlistentry>
     <term><literal>env</literal></term>
-    <listitem>Derives the home directory from the environment variable
-	      <literal>HOME</literal> (falling back to
+    <listitem>Derives the home directory of the current user from the
+	      environment variable <literal>HOME</literal> (falling back to
 	      <literal>HOMEDRIVE\HOMEPATH</literal> and
 	      <literal>USERPROFILE</literal>, in that order).  This is faster
 	      than the <term><literal>windows</literal></term> schema at the
@@ -1498,8 +1498,8 @@ of each schema when used with <literal>db_home:</literal>
   </varlistentry>
   <varlistentry>
     <term><literal>env</literal></term>
-    <listitem>Derives the home directory from the environment variable
-	      <literal>HOME</literal> (falling back to
+    <listitem>Derives the home directory of the current user from the
+	      environment variable <literal>HOME</literal> (falling back to
 	      <literal>HOMEDRIVE\HOMEPATH</literal> and
 	      <literal>USERPROFILE</literal>, in that order).  This is faster
 	      than the <term><literal>windows</literal></term> schema at the

-- 
2.6.3.windows.1.300.g1c25e49
