Return-Path: <cygwin-patches-return-6456-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9896 invoked by alias); 27 Mar 2009 07:51:19 -0000
Received: (qmail 9883 invoked by uid 22791); 27 Mar 2009 07:51:18 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_66,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.147)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 27 Mar 2009 07:51:13 +0000
Received: by qw-out-1920.google.com with SMTP id 9so660197qwj.20         for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2009 00:51:11 -0700 (PDT)
Received: by 10.224.80.208 with SMTP id u16mr2373932qak.357.1238140271061;         Fri, 27 Mar 2009 00:51:11 -0700 (PDT)
Received: from ?192.168.0.101? (S0106001346f94b85.wp.shawcable.net [24.76.249.6])         by mx.google.com with ESMTPS id 4sm3227978yxj.21.2009.03.27.00.51.10         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Fri, 27 Mar 2009 00:51:10 -0700 (PDT)
Message-ID: <49CC856D.2080803@users.sourceforge.net>
Date: Fri, 27 Mar 2009 07:51:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] remove references to CYGWIN="server"
Content-Type: multipart/mixed;  boundary="------------000101040704030800040001"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00054.txt.bz2

This is a multi-part message in MIME format.
--------------000101040704030800040001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 412

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I found a few more references to the recently removed CYGWIN="server"
option.  Patches attached.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAknMhW0ACgkQpiWmPGlmQSOo0gCcD9oAZI2S2StIBVLiFb/ZRhwo
bSAAniaveKzFNc8S0Zp3X+EZyfKjJDAF
=n1P8
-----END PGP SIGNATURE-----

--------------000101040704030800040001
Content-Type: text/x-patch;
 name="utils-passwd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="utils-passwd.patch"
Content-length: 1591

2009-03-26  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* utils.sgml (passwd -R): Remove references to CYGWIN="server".


Index: utils/utils.sgml
===================================================================
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v
retrieving revision 1.74
diff -u -r1.74 utils.sgml
--- utils/utils.sgml	23 Mar 2009 20:40:17 -0000	1.74
+++ utils/utils.sgml	27 Mar 2009 07:44:16 -0000
@@ -933,8 +933,7 @@
 operations.  Don't specify a USER when triggering a system operation. 
 
 Don't specify a user or any other option together with the -R option.
-Non-Admin users can only store their password if cygserver is running and
-the CYGWIN environment variable is set to contain the word 'server'.
+Non-Admin users can only store their password if cygserver is running.
 Note that storing even obfuscated passwords in the registry is not overly
 secure.  Use this feature only if the machine is adequately locked down.
 Don't use this feature if you don't need network access within a remote
@@ -1029,9 +1028,7 @@
 do.  If normal, non-admin users should be allowed to enter their
 passwords using <command>passwd -R</command>, it's required to run
 <command>cygserver</command> as a service under the LocalSystem account
-and the environment variable CYGWIN
-(see <xref linkend="using-cygwinenv"></xref>)
-must be set to contain the "server" setting before running
+before running
 <command>passwd -R</command>.  This only affects storing passwords.
 Using passwords in privileged processes does not require
 <command>cygserver</command> to run.</para>

--------------000101040704030800040001
Content-Type: text/x-patch;
 name="cygserver-readme.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygserver-readme.patch"
Content-length: 2063

2009-03-26  Yaakov Selkowitz  <yselkowitz@cygwin.com>

	* README: Remove "How to use" section, as CYGWIN="server" is
	no longer required. 


Index: cygserver/README
===================================================================
RCS file: /cvs/src/src/winsup/cygserver/README,v
retrieving revision 1.4
diff -u -r1.4 README
--- cygserver/README	26 Nov 2008 10:18:53 -0000	1.4
+++ cygserver/README	27 Mar 2009 07:44:14 -0000
@@ -159,38 +159,6 @@
   /usr/bin/cygserver-config script.
 
 
-How to use the Cygserver services:
-
-  The Cygserver services are used by Cygwin applications only if you
-  set the environment variable CYGWIN to contain the string "server".
-  You must do this before starting the application.
-
-  Typically, you don't need any other option, so it's ok to set CYGWIN
-  just to "server".  It is not necessary to set the CYGWIN environment
-  variable prior to starting the Cygserver process itself, but it won't
-  hurt to do so.
-
-  The easiest way is to set the environment variable CYGWIN to the values
-  you want in the Windows system environment and to reboot the machine.
-  This is advisable, since it allows you to set the variable once and
-  then forget about it.  It also ensures that services as well as desktop
-  applications have the same setting.
-
-  If you don't want that for whatever reason, you can set the
-  variable in the /cygwin.bat file which is used in the net distribution,
-  to start a Cygwin bash from the desktop.  In that file, you can set
-  the CYGWIN variable using Windows command line interpreter syntax, e. g.:
-
-    set CYGWIN=server
-
-  If you don't set CYGWIN in the system environment, but you're running
-  other Cygwin services, these services need to get that CYGWIN value by
-  setting the environment using the appropriate cygrunsrv option '-e' when
-  installing the service.  Example installing a service 'foo':
-
-    cygrunsrv -I foo -p /usr/sbin/foo -e "CYGWIN=server"
-
-
 The Cygserver configuration file:
 
   Cygserver has many options, which allow to customize the server

--------------000101040704030800040001--
