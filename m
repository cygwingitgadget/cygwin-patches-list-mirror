Return-Path: <cygwin-patches-return-2221-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16144 invoked by alias); 25 May 2002 01:51:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16129 invoked from network); 25 May 2002 01:51:44 -0000
Message-Id: <3.0.5.32.20020524214852.007f86b0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Fri, 24 May 2002 18:51:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: lsa string translation in security.cc, on NT.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00205.txt.bz2

Here is a partial output of what "buf" contains after the 
sys_wcstombs() call on line  634 of security.cc, on NT.

 9132 2103447 [main] a 705 get_priv_list: Group 8 found SeSecurityPrivilege
  600 2106857 [main] a 705 get_priv_list: Group 8 found SeBackupPrivilege
  622 2109275 [main] a 705 get_priv_list: Group 8 found
SeRestorePrivilegeSeSystemtimePrivilege
 1713 2110988 [main] a 705 get_priv_list: Group 8 found SeSystemtimePrivilege
  620 2113653 [main] a 705 get_priv_list: Group 8 found SeShutdownPrivilege
 1761 2115414 [main] a 705 get_priv_list: Group 8 found
SeRemoteShutdownPrivilege
  570 2117873 [main] a 705 get_priv_list: Group 8 found
SeTakeOwnershipPrivilegeSeDebugPrivilegeSeSystemEnvironmentPrivilegeSeSystem
ProfilePrivilegeSeProfileSingleProcessPrivilege
 1798 2119671 [main] a 705 get_priv_list: Group 8 found
SeDebugPrivilegeSeSystemEnvironmentPrivilegeSeSystemProfilePrivilegeSeProfil
eSingleProcessPrivilege
 1889 2121560 [main] a 705 get_priv_list: Group 8 found
SeSystemEnvironmentPrivilegeSeSystemProfilePrivilegeSeProfileSingleProcessPr
ivilege
 2071 2123631 [main] a 705 get_priv_list: Group 8 found
SeSystemProfilePrivilegeSeProfileSingleProcessPrivilege
 1873 2125504 [main] a 705 get_priv_list: Group 8 found
SeProfileSingleProcessPrivilege
  567 2127962 [main] a 705 get_priv_list: Group 8 found
SeIncreaseBasePriorityPrivilege
  563 2130277 [main] a 705 get_priv_list: Group 8 found SeLoadDriverPrivilege
  835 2132864 [main] a 705 get_priv_list: Group 8 found
SeCreatePagefilePrivilege
  568 2135186 [main] a 705 get_priv_list: Group 8 found
SeIncreaseQuotaPrivilegeSeInteractiveLogonRight
 1767 2136953 [main] a 705 get_priv_list: Group 8 found
SeInteractiveLogonRight
 1879 2138832 [main] a 705 get_priv_list: Group 8 found SeNetworkLogonRight

It is apparent that the even length lsa strings are not zero terminated. 
The subsequent call to LookupPrivilegeValue() fails in that case.
The following patch fixes that.

Pierre


2002/05/24  Pierre Humblet <Pierre.Humblet@ieee.org>

	* security.cc (lsau2str): Create.
	(get_priv_list): Call lsau2str instead of sys_wcstombs.


--- security.cc.orig    2002-05-24 18:26:26.000000000 -0400
+++ security.cc 2002-05-24 18:48:12.000000000 -0400
@@ -176,6 +176,15 @@
   tgt[size] = 0;
 }
 
+static void
+lsau2str (char *dest, PLSA_UNICODE_STRING src, int size)
+{
+  if (src->Length/2 < size)
+    size = src->Length/2;
+  sys_wcstombs(dest, src->Buffer, size);
+  dest[size] = 0;
+}
+
 static LSA_HANDLE
 open_local_policy ()
 {
@@ -631,8 +640,7 @@
          PTOKEN_PRIVILEGES tmp;
          DWORD tmp_count;
 
-         sys_wcstombs (buf, privstrs[i].Buffer,
-                       INTERNET_MAX_HOST_NAME_LENGTH + 1);
+         lsau2str (buf, &privstrs[i], sizeof(buf) - 1);
          if (!LookupPrivilegeValue (NULL, buf, &priv))
            continue;
