Return-Path: <cygwin-patches-return-3969-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7526 invoked by alias); 18 Jun 2003 02:05:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7456 invoked from network); 18 Jun 2003 02:05:40 -0000
Message-Id: <3.0.5.32.20030617220548.00805780@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Wed, 18 Jun 2003 02:05:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: getdomainname
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1055916348==_"
X-SW-Source: 2003-q2/txt/msg00196.txt.bz2

--=====================_1055916348==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 597

In the course of working on minires I noticed that Cygwin had
a getdomainname() function, but that it was not fully functional.
Here is a fix.

Note that I have used strncpy to comform to a man page I found
<http://www.freebsd.org/cgi/man.cgi?query=getdomainname&apropos=0&sektion=0&
manpath=NetBSD+1.6.1&format=html>
(alternatives are to return an error if name too long, or use
 strlcpy).

Pierre

2003-06-18  Pierre Humblet  <pierre.humblet@ieee.org>

	* autoload.cc (GetNetworkParams): Add.
	* net.cc (getdomainname): Call GetNetworkParams and read the
	DhcpDomain registry value if warranted.
--=====================_1055916348==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="domain.diff"
Content-length: 2683

Index: autoload.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.70
diff -u -p -r1.70 autoload.cc
--- autoload.cc	25 May 2003 09:18:43 -0000	1.70
+++ autoload.cc	17 Jun 2003 23:41:37 -0000
@@ -492,6 +492,7 @@ LoadDLLfuncEx (WSAEnumNetworkEvents, 12,
 LoadDLLfuncEx (GetIfTable, 12, iphlpapi, 1)
 LoadDLLfuncEx (GetIfEntry, 4, iphlpapi, 1)
 LoadDLLfuncEx (GetIpAddrTable, 12, iphlpapi, 1)
+LoadDLLfuncEx (GetNetworkParams, 8, iphlpapi, 1)

 LoadDLLfunc (CoInitialize, 4, ole32)
 LoadDLLfunc (CoUninitialize, 0, ole32)
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.145
diff -u -p -r1.145 net.cc
--- net.cc	16 Jun 2003 03:24:11 -0000	1.145
+++ net.cc	17 Jun 2003 23:41:41 -0000
@@ -1291,20 +1291,39 @@ getdomainname (char *domain, size_t len)
   if (__check_null_invalid_struct_errno (domain, len))
     return -1;

+  PFIXED_INFO info =3D NULL;
+  ULONG size =3D 0;
+
+  if (GetNetworkParams(info, &size) =3D=3D ERROR_BUFFER_OVERFLOW
+      && (info =3D (PFIXED_INFO) alloca(size))
+      && GetNetworkParams(info, &size) =3D=3D ERROR_SUCCESS)
+    {
+      strncpy(domain, info->DomainName, len);
+      return 0;
+    }
+
+  /* This is only used by Win95 and NT <=3D  4.0.
+     FIXME: Are the registry names language dependent?
+     FIXME: Handle DHCP on Win95. The DhcpDomain(s) may be available
+     in ..VxD\DHCP\DhcpInfoXX\OptionInfo, RFC 1533 format */
+
   reg_key r (HKEY_LOCAL_MACHINE, KEY_READ,
 	     (!wincap.is_winnt ()) ? "System" : "SYSTEM",
 	     "CurrentControlSet", "Services",
 	     (!wincap.is_winnt ()) ? "VxD" : "Tcpip",
 	     (!wincap.is_winnt ()) ? "MSTCP" : "Parameters", NULL);

-  /* FIXME: Are registry keys case sensitive? */
-  if (r.error () || r.get_string ("Domain", domain, len, "") !=3D ERROR_SU=
CCESS)
+  if (!r.error ())
     {
-      __seterrno ();
-      return -1;
+      int res1, res2 =3D 0; /* Suppress compiler warning */
+      res1 =3D r.get_string ("Domain", domain, len, "");
+      if (res1 !=3D ERROR_SUCCESS || !domain[0])
+	res2 =3D r.get_string ("DhcpDomain", domain, len, "");
+      if (res1 =3D=3D ERROR_SUCCESS || res2 =3D=3D ERROR_SUCCESS)
+	return 0;
     }
-
-  return 0;
+  __seterrno ();
+  return -1;
 }

 /* Fill out an ifconf struct. */

--=====================_1055916348==_--
