Return-Path: <cygwin-patches-return-2070-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6268 invoked by alias); 17 Apr 2002 15:33:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6245 invoked from network); 17 Apr 2002 15:33:34 -0000
Date: Wed, 17 Apr 2002 08:33:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: get_lsa_srv_inf() NT Domain Patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20020417153937.GB1344@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_q0KWT16GhkXCjTVHVdjjaQ)"
User-Agent: Mutt/1.3.24i
X-SW-Source: 2002-q2/txt/msg00054.txt.bz2


--Boundary_(ID_q0KWT16GhkXCjTVHVdjjaQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 339

The attached patch prevents extraneous backslashes from being prepended
to the logon server name.  See the following for more details:

    http://cygwin.com/ml/cygwin/2002-04/msg00890.html

Note that there is more than one way to achieve the desired functionality.
Feel free to reorganize to prevent code duplication, etc.

Thanks,
Jason

--Boundary_(ID_q0KWT16GhkXCjTVHVdjjaQ)
Content-type: text/plain; charset=us-ascii; NAME=security.cc.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=security.cc.diff
Content-length: 1028

Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.86
diff -u -p -r1.86 security.cc
--- security.cc	7 Mar 2002 14:32:53 -0000	1.86
+++ security.cc	17 Apr 2002 14:35:03 -0000
@@ -230,19 +230,20 @@ get_lsa_srv_inf (LSA_HANDLE lsa, char *l
       (ret = NetGetDCName(NULL, primary, (LPBYTE *) &buf)) == STATUS_SUCCESS)
     {
       sys_wcstombs (name, buf, INTERNET_MAX_HOST_NAME_LENGTH + 1);
+      strcpy (logonserver, name);
       if (domain)
 	sys_wcstombs (domain, primary, INTERNET_MAX_HOST_NAME_LENGTH + 1);
     }
   else
     {
       sys_wcstombs (name, account, INTERNET_MAX_HOST_NAME_LENGTH + 1);
+      strcpy (logonserver, "\\\\");
+      strcat (logonserver, name);
       if (domain)
 	sys_wcstombs (domain, account, INTERNET_MAX_HOST_NAME_LENGTH + 1);
     }
   if (ret == STATUS_SUCCESS)
     NetApiBufferFree (buf);
-  strcpy (logonserver, "\\\\");
-  strcat (logonserver, name);
   return TRUE;
 }
 

--Boundary_(ID_q0KWT16GhkXCjTVHVdjjaQ)
Content-type: text/plain; charset=us-ascii; NAME=security.cc.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=security.cc.ChangeLog
Content-length: 151

Wed Apr 17 11:27:04 2002  Jason Tishler <jason@tishler.net>

	* security.cc (get_lsa_srv_inf): Prevent extraneous backslashes for
	the NT Domain case.

--Boundary_(ID_q0KWT16GhkXCjTVHVdjjaQ)--
