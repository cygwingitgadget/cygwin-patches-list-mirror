Return-Path: <cygwin-patches-return-3617-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10554 invoked by alias); 22 Feb 2003 04:34:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10545 invoked from network); 22 Feb 2003 04:34:46 -0000
Message-Id: <3.0.5.32.20030221233251.007fb4f0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Sat, 22 Feb 2003 04:34:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: syslog
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1045906371==_"
X-SW-Source: 2003-q1/txt/msg00266.txt.bz2

--=====================_1045906371==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 239


2003-02-22  Pierre Humblet  <pierre.humblet@ieee.org>

	* syslog.cc (syslog): Do not print the Windows pid. Print the Cygwin
	pid as an unsigned decimal. On Win95 print a timestamp and attempt
	to lock the file up to four times in 3 ms. 

--=====================_1045906371==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="syslog.diff"
Content-length: 2193

Index: syslog.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syslog.cc,v
retrieving revision 1.21
diff -u -p -r1.21 syslog.cc
--- syslog.cc	22 Sep 2002 03:38:57 -0000	1.21
+++ syslog.cc	22 Feb 2003 04:11:55 -0000
@@ -302,8 +302,7 @@ syslog (int priority, const char *messag
 	  }
 	if (process_logopt & LOG_PID)
 	  {
-	    if (pass.print ("Win32 Process Id =3D 0x%X : Cygwin Process Id =3D 0x=
%X : ",
-			GetCurrentProcessId (),  getpid ()) =3D=3D -1)
+	    if (pass.print ("Cygwin PID =3D %u : ", getpid ()) =3D=3D -1)
 	      return;
 	  }

@@ -375,6 +374,8 @@ syslog (int priority, const char *messag
     else
       {
 	/* Under Windows 95, append the message to the log file */
+	char timestamp[24];
+	time_t ctime;
 	FILE *fp =3D fopen (get_win95_event_log_path (), "a");
 	if (fp =3D=3D NULL)
 	  {
@@ -382,24 +383,32 @@ syslog (int priority, const char *messag
 			  get_win95_event_log_path ());
 	    return;
 	  }
+	strftime (timestamp, sizeof timestamp, "%Y-%m-%d %H:%M:%S : ",
+		  localtime (&(ctime =3D time (NULL))));
+
 	/* Now to prevent several syslog messages from being
 	   interleaved, we must lock the first byte of the file
 	   This works on Win32 even if we created the file above.
 	*/
 	HANDLE fHandle =3D cygheap->fdtab[fileno (fp)]->get_handle ();
-	if (LockFile (fHandle, 0, 0, 1, 0) =3D=3D FALSE)
-	  {
-	    debug_printf ("failed to lock file %s", get_win95_event_log_path ());
-	    fclose (fp);
-	    return;
-	  }
+	for (int i =3D 0;; i++)
+	  if (LockFile (fHandle, 0, 0, 1, 0) =3D=3D FALSE)
+	    if (i =3D=3D 3)
+	      {
+		debug_printf ("failed to lock file %s", get_win95_event_log_path ());
+		fclose (fp);
+		return;
+	      }
+	    else
+	      usleep (1000);
+	  else
+	    break;
+	fputs (timestamp, fp);
 	fputs (msg_strings[0], fp);
 	fputc ('\n', fp);
 	UnlockFile (fHandle, 0, 0, 1, 0);
 	if (ferror (fp))
-	  {
-	    debug_printf ("error in writing syslog");
-	  }
+	  debug_printf ("error in writing syslog");
 	fclose (fp);
       }
 }

--=====================_1045906371==_--
