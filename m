Return-Path: <cygwin-patches-return-1589-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23411 invoked by alias); 14 Dec 2001 19:21:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23377 invoked from network); 14 Dec 2001 19:21:30 -0000
Date: Sun, 04 Nov 2001 21:05:00 -0000
From: Jason Tishler <jason@tishler.net>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: mkpasswd --path-to-home patch
Message-ID: <20011214142521.C2348@dothill.com>
Mail-Followup-To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hMfqPm6rhv8NkJzA"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-SW-Source: 2001-q4/txt/msg00121.txt.bz2


--hMfqPm6rhv8NkJzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 136

The attached implements the funtionality discussed in:

    http://cygwin.com/ml/cygwin-developers/2001-12/msg00029.html

Thanks,
Jason

--hMfqPm6rhv8NkJzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mkpasswd.c.diff"
Content-length: 2361

Index: mkpasswd.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/mkpasswd.c,v
retrieving revision 1.17
diff -u -p -r1.17 mkpasswd.c
--- mkpasswd.c	2001/12/14 17:15:37	1.17
+++ mkpasswd.c	2001/12/14 18:58:27
@@ -171,15 +171,26 @@ enum_users (LPWSTR servername, int print
 	  uni2ansi (buffer[i].usri3_name, username, sizeof (username));
 	  uni2ansi (buffer[i].usri3_full_name, fullname, sizeof (fullname));
 	  homedir_w32[0] = homedir_psx[0] = '\0';
-	  uni2ansi (buffer[i].usri3_home_dir, homedir_w32, sizeof (homedir_w32));
-	  if (print_cygpath)
-	    cygwin_conv_to_posix_path (homedir_w32, homedir_psx);
+	  if (passed_home_path[0] == '\0')
+	    {
+	      uni2ansi (buffer[i].usri3_home_dir, homedir_w32,
+			sizeof (homedir_w32));
+	      if (homedir_w32[0] != '\0')
+		{
+		  if (print_cygpath)
+		    cygwin_conv_to_posix_path (homedir_w32, homedir_psx);
+		  else
+		    psx_dir (homedir_w32, homedir_psx);
+		}
+	      else
+		{
+		  strcpy (homedir_psx, "/home/");
+		  strcat (homedir_psx, username);
+		}
+	    }
 	  else
-	    psx_dir (homedir_w32, homedir_psx);
-
-	  if (homedir_psx[0] == '\0')
 	    {
-	      strcat (homedir_psx, passed_home_path);
+	      strcpy (homedir_psx, passed_home_path);
 	      strcat (homedir_psx, username);
 	    }
 
@@ -394,8 +405,7 @@ usage ()
   fprintf (stderr, "   -m,--no-mount           don't use mount points for home dir\n");
   fprintf (stderr, "   -s,--no-sids            don't print SIDs in GCOS field\n");
   fprintf (stderr, "                           (this affects ntsec)\n");
-  fprintf (stderr, "   -p,--path-to-home path  if user account has no home dir, use\n");
-  fprintf (stderr, "                           path instead of /home/\n");
+  fprintf (stderr, "   -p,--path-to-home path  use specified path instead of user account home dir\n");
   fprintf (stderr, "   -u,--username username  only return information for the specified user\n");
   fprintf (stderr, "   -?,--help               displays this message\n\n");
   fprintf (stderr, "One of `-l', `-d' or `-g' must be given on NT/W2K.\n");
@@ -504,9 +514,6 @@ main (int argc, char **argv)
 	    }
 	}
     }
-
-  if (passed_home_path[0] == '\0')
-      strcpy (passed_home_path, "/home/");
 
   /* This takes Windows 9x/ME into account. */
   if (GetVersion () >= 0x80000000)

--hMfqPm6rhv8NkJzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mkpasswd.c.ChangeLog"
Content-length: 348

Fri Dec 14 14:04:37 2001  Jason Tishler <jason@tishler.net>

	* mkpasswd.c (enum_users): Change to unconditionally use
	the --path-to-home option, if supplied by the user.  Use default
	--path-to-home option value, if appropriate.
	(usage): Change usage statement to reflect new semantics.
	(main): Remove defaulting of the --path-to-home option.


--hMfqPm6rhv8NkJzA--
