Return-Path: <cygwin-patches-return-1672-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19677 invoked by alias); 12 Jan 2002 01:59:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19656 invoked from network); 12 Jan 2002 01:59:48 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D29E6@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] mkpasswd.c - allows selection of specific user
Date: Fri, 11 Jan 2002 17:59:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C19B0C.D0184990"
X-SW-Source: 2002-q1/txt/msg00029.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C19B0C.D0184990
Content-Type: text/plain;
	charset="iso-8859-1"
Content-length: 6397

Corinna,
  You probably don't remember this, but I had volunteered back in December
to make the error messages in mkpasswd a bit more user friendly.  Well, I
finally took a few free moments to take a stab at it.  I sprinkled a liberal
dose of FormatMessage wherever error reporting was going on.  So before,
where there'd be a message that basically said, "You got error number
12345", now it'll print out the corresponding text.

When I pulled my network cable and tried to get a user from the domain I
got...
$ ./mkpasswd -d -u bradshaw
mkpasswd: error 2453.
Could not find domain controller for this domain.

Asking for a bogus user...
$ ./mkpasswd -d -u bradshaj
mkpasswd: error 2221.
The user name could not be found.

------------------------------------------

2002-01-11  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

      * mkpasswd.c: (enum_users): Use FormatMessage to print text error
messages.
                    (enum_local_groups): Use FormatMessage to print text
error messages.
                    (main): Use FormatMessage to print text error messages.

------------------------------------------

--- mkpasswd.c	Fri Jan 11 19:40:57 2002
+++ mkpasswd.new.c	Fri Jan 11 20:34:18 2002
@@ -114,9 +114,10 @@ enum_users (LPWSTR servername, int print
   DWORD entriesread = 0;
   DWORD totalentries = 0;
   DWORD resume_handle = 0;
-  DWORD rc;
+  DWORD rc, er;
   char ansi_srvname[256];
   WCHAR uni_name[512];
+  char buf[4096];
 
   if (servername)
     uni2ansi (servername, ansi_srvname, sizeof (ansi_srvname));
@@ -147,9 +148,14 @@ enum_users (LPWSTR servername, int print
 	  break;
 
 	default:
-	  fprintf (stderr, "NetUserEnum() failed with error %ld.\n", rc);
-	  if (rc == NERR_UserNotFound) 
-	    fprintf (stderr, "That user doesn't exist.\n");
+	  fprintf (stderr, "mkpasswd: error %ld.\n", rc);
+	  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
+			      NULL,
+			      rc,
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
+			      (LPTSTR) buf, sizeof (buf), NULL))
+	    fprintf (stderr, "%s", buf);
 	  exit (1);
 	}
 
@@ -206,7 +212,14 @@ enum_users (LPWSTR servername, int print
 			   "LookupAccountName(%s,%s) failed with error
%ld\n",
 			   servername ? ansi_srvname : "NULL",
 			   username,
-			   GetLastError ());
+			   er = GetLastError ());
+		  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
+			      NULL,
+			      er,
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
+			      (LPTSTR) buf, sizeof (buf), NULL))
+		    fprintf (stderr, "%s", buf);
 		  continue;
 		}
 	      else if (acc_type == SidTypeDomain)
@@ -228,7 +241,14 @@ enum_users (LPWSTR servername, int print
 			       "LookupAccountName(%s,%s) failed with error
%ld\n",
 			       servername ? ansi_srvname : "NULL",
 			       domname,
-			       GetLastError ());
+			       er = GetLastError ());
+		      if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
+			      NULL,
+			      er,
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
+			      (LPTSTR) buf, sizeof (buf), NULL))
+		        fprintf (stderr, "%s", buf);
 		      continue;
 		    }
 		}
@@ -266,7 +286,8 @@ enum_local_groups (int print_sids)
   DWORD entriesread = 0;
   DWORD totalentries = 0;
   DWORD resume_handle = 0;
-  DWORD rc ;
+  DWORD rc, er;
+  char buf[4096];
 
   do
     {
@@ -285,7 +306,14 @@ enum_local_groups (int print_sids)
 	  break;
 
 	default:
-	  fprintf (stderr, "NetLocalGroupEnum() failed with %ld\n", rc);
+	  fprintf (stderr, "mkpasswd: error %ld.\n", rc);
+	  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
+			      NULL,
+			      rc,
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
+			      (LPTSTR) buf, sizeof (buf), NULL))
+	    fprintf (stderr, "%s", buf);
 	  exit (1);
 	}
 
@@ -306,7 +334,14 @@ enum_local_groups (int print_sids)
 				  &acc_type))
 	    {
 	      fprintf (stderr, "LookupAccountName(%s) failed with %ld\n",
-		       localgroup_name, GetLastError ());
+		       localgroup_name, er = GetLastError ());
+	      if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
+			      NULL,
+			      er,
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
+			      (LPTSTR) buf, sizeof (buf), NULL))
+	        fprintf (stderr, "%s", buf);
 	      continue;
 	    }
 	  else if (acc_type == SidTypeDomain)
@@ -325,7 +360,14 @@ enum_local_groups (int print_sids)
 		{
 		  fprintf (stderr,
 			   "LookupAccountName(%s) failed with error %ld\n",
-			   localgroup_name, GetLastError ());
+			   localgroup_name, er = GetLastError ());
+		  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
+			      NULL,
+			      er,
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
+			      (LPTSTR) buf, sizeof (buf), NULL))
+		    fprintf (stderr, "%s", buf);
 		  continue;
 		}
 	    }
@@ -432,6 +474,7 @@ main (int argc, char **argv)
 {
   LPWSTR servername = NULL;
   DWORD rc = ERROR_SUCCESS;
+  DWORD er;
   WCHAR domain_name[200];
   int print_local = 0;
   int print_domain = 0;
@@ -442,6 +485,7 @@ main (int argc, char **argv)
   int id_offset = 10000;
   int i;
   char *disp_username = NULL;
+  char buf[4096];
 
   char name[256], passed_home_path[MAX_PATH];
   DWORD len;
@@ -534,7 +578,14 @@ main (int argc, char **argv)
   if (!load_netapi ())
     {
       fprintf (stderr, "Failed loading symbols from netapi32.dll "
-		       "with error %lu\n", GetLastError ());
+		       "with error %lu\n", er = GetLastError ());
+      if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
+			      NULL,
+			      er,
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
+			      (LPTSTR) buf, sizeof (buf), NULL))
+        fprintf (stderr, "%s", buf);
       return 1;
     }
 
@@ -571,7 +622,14 @@ main (int argc, char **argv)
 
       if (rc != ERROR_SUCCESS)
 	{
-	  fprintf (stderr, "Cannot get DC, code = %ld\n", rc);
+	  fprintf (stderr, "mkpasswd: error %ld.\n", rc);
+	  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
+			      NULL,
+			      rc,
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
+			      (LPTSTR) buf, sizeof (buf), NULL))
+	    fprintf (stderr, "%s", buf);
 	  exit (1);
 	}
 


------_=_NextPart_000_01C19B0C.D0184990
Content-Type: application/octet-stream;
	name="mkpasswd.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mkpasswd.c.diff"
Content-length: 6029

--- mkpasswd.c	Fri Jan 11 19:40:57 2002=0A=
+++ mkpasswd.new.c	Fri Jan 11 20:34:18 2002=0A=
@@ -114,9 +114,10 @@ enum_users (LPWSTR servername, int print=0A=
   DWORD entriesread =3D 0;=0A=
   DWORD totalentries =3D 0;=0A=
   DWORD resume_handle =3D 0;=0A=
-  DWORD rc;=0A=
+  DWORD rc, er;=0A=
   char ansi_srvname[256];=0A=
   WCHAR uni_name[512];=0A=
+  char buf[4096];=0A=
=20=0A=
   if (servername)=0A=
     uni2ansi (servername, ansi_srvname, sizeof (ansi_srvname));=0A=
@@ -147,9 +148,14 @@ enum_users (LPWSTR servername, int print=0A=
 	  break;=0A=
=20=0A=
 	default:=0A=
-	  fprintf (stderr, "NetUserEnum() failed with error %ld.\n", rc);=0A=
-	  if (rc =3D=3D NERR_UserNotFound)=20=0A=
-	    fprintf (stderr, "That user doesn't exist.\n");=0A=
+	  fprintf (stderr, "mkpasswd: error %ld.\n", rc);=0A=
+	  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM=0A=
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,=0A=
+			      NULL,=0A=
+			      rc,=0A=
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),=0A=
+			      (LPTSTR) buf, sizeof (buf), NULL))=0A=
+	    fprintf (stderr, "%s", buf);=0A=
 	  exit (1);=0A=
 	}=0A=
=20=0A=
@@ -206,7 +212,14 @@ enum_users (LPWSTR servername, int print=0A=
 			   "LookupAccountName(%s,%s) failed with error %ld\n",=0A=
 			   servername ? ansi_srvname : "NULL",=0A=
 			   username,=0A=
-			   GetLastError ());=0A=
+			   er =3D GetLastError ());=0A=
+		  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM=0A=
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,=0A=
+			      NULL,=0A=
+			      er,=0A=
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),=0A=
+			      (LPTSTR) buf, sizeof (buf), NULL))=0A=
+		    fprintf (stderr, "%s", buf);=0A=
 		  continue;=0A=
 		}=0A=
 	      else if (acc_type =3D=3D SidTypeDomain)=0A=
@@ -228,7 +241,14 @@ enum_users (LPWSTR servername, int print=0A=
 			       "LookupAccountName(%s,%s) failed with error %ld\n",=0A=
 			       servername ? ansi_srvname : "NULL",=0A=
 			       domname,=0A=
-			       GetLastError ());=0A=
+			       er =3D GetLastError ());=0A=
+		      if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM=0A=
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,=0A=
+			      NULL,=0A=
+			      er,=0A=
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),=0A=
+			      (LPTSTR) buf, sizeof (buf), NULL))=0A=
+		        fprintf (stderr, "%s", buf);=0A=
 		      continue;=0A=
 		    }=0A=
 		}=0A=
@@ -266,7 +286,8 @@ enum_local_groups (int print_sids)=0A=
   DWORD entriesread =3D 0;=0A=
   DWORD totalentries =3D 0;=0A=
   DWORD resume_handle =3D 0;=0A=
-  DWORD rc ;=0A=
+  DWORD rc, er;=0A=
+  char buf[4096];=0A=
=20=0A=
   do=0A=
     {=0A=
@@ -285,7 +306,14 @@ enum_local_groups (int print_sids)=0A=
 	  break;=0A=
=20=0A=
 	default:=0A=
-	  fprintf (stderr, "NetLocalGroupEnum() failed with %ld\n", rc);=0A=
+	  fprintf (stderr, "mkpasswd: error %ld.\n", rc);=0A=
+	  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM=0A=
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,=0A=
+			      NULL,=0A=
+			      rc,=0A=
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),=0A=
+			      (LPTSTR) buf, sizeof (buf), NULL))=0A=
+	    fprintf (stderr, "%s", buf);=0A=
 	  exit (1);=0A=
 	}=0A=
=20=0A=
@@ -306,7 +334,14 @@ enum_local_groups (int print_sids)=0A=
 				  &acc_type))=0A=
 	    {=0A=
 	      fprintf (stderr, "LookupAccountName(%s) failed with %ld\n",=0A=
-		       localgroup_name, GetLastError ());=0A=
+		       localgroup_name, er =3D GetLastError ());=0A=
+	      if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM=0A=
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,=0A=
+			      NULL,=0A=
+			      er,=0A=
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),=0A=
+			      (LPTSTR) buf, sizeof (buf), NULL))=0A=
+	        fprintf (stderr, "%s", buf);=0A=
 	      continue;=0A=
 	    }=0A=
 	  else if (acc_type =3D=3D SidTypeDomain)=0A=
@@ -325,7 +360,14 @@ enum_local_groups (int print_sids)=0A=
 		{=0A=
 		  fprintf (stderr,=0A=
 			   "LookupAccountName(%s) failed with error %ld\n",=0A=
-			   localgroup_name, GetLastError ());=0A=
+			   localgroup_name, er =3D GetLastError ());=0A=
+		  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM=0A=
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,=0A=
+			      NULL,=0A=
+			      er,=0A=
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),=0A=
+			      (LPTSTR) buf, sizeof (buf), NULL))=0A=
+		    fprintf (stderr, "%s", buf);=0A=
 		  continue;=0A=
 		}=0A=
 	    }=0A=
@@ -432,6 +474,7 @@ main (int argc, char **argv)=0A=
 {=0A=
   LPWSTR servername =3D NULL;=0A=
   DWORD rc =3D ERROR_SUCCESS;=0A=
+  DWORD er;=0A=
   WCHAR domain_name[200];=0A=
   int print_local =3D 0;=0A=
   int print_domain =3D 0;=0A=
@@ -442,6 +485,7 @@ main (int argc, char **argv)=0A=
   int id_offset =3D 10000;=0A=
   int i;=0A=
   char *disp_username =3D NULL;=0A=
+  char buf[4096];=0A=
=20=0A=
   char name[256], passed_home_path[MAX_PATH];=0A=
   DWORD len;=0A=
@@ -534,7 +578,14 @@ main (int argc, char **argv)=0A=
   if (!load_netapi ())=0A=
     {=0A=
       fprintf (stderr, "Failed loading symbols from netapi32.dll "=0A=
-		       "with error %lu\n", GetLastError ());=0A=
+		       "with error %lu\n", er =3D GetLastError ());=0A=
+      if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM=0A=
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,=0A=
+			      NULL,=0A=
+			      er,=0A=
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),=0A=
+			      (LPTSTR) buf, sizeof (buf), NULL))=0A=
+        fprintf (stderr, "%s", buf);=0A=
       return 1;=0A=
     }=0A=
=20=0A=
@@ -571,7 +622,14 @@ main (int argc, char **argv)=0A=
=20=0A=
       if (rc !=3D ERROR_SUCCESS)=0A=
 	{=0A=
-	  fprintf (stderr, "Cannot get DC, code =3D %ld\n", rc);=0A=
+	  fprintf (stderr, "mkpasswd: error %ld.\n", rc);=0A=
+	  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM=0A=
+			      | FORMAT_MESSAGE_IGNORE_INSERTS,=0A=
+			      NULL,=0A=
+			      rc,=0A=
+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),=0A=
+			      (LPTSTR) buf, sizeof (buf), NULL))=0A=
+	    fprintf (stderr, "%s", buf);=0A=
 	  exit (1);=0A=
 	}=0A=
=20=0A=

------_=_NextPart_000_01C19B0C.D0184990--
