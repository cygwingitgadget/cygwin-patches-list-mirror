Return-Path: <cygwin-patches-return-1673-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23060 invoked by alias); 12 Jan 2002 05:09:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23029 invoked from network); 12 Jan 2002 05:09:01 -0000
Date: Fri, 11 Jan 2002 21:09:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
Message-ID: <20020112031851.GA5052@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <911C684A29ACD311921800508B7293BA037D29E6@cnmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911C684A29ACD311921800508B7293BA037D29E6@cnmail>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00030.txt.bz2

On Fri, Jan 11, 2002 at 08:59:47PM -0500, Mark Bradshaw wrote:
>Corinna,
>  You probably don't remember this, but I had volunteered back in December
>to make the error messages in mkpasswd a bit more user friendly.  Well, I
>finally took a few free moments to take a stab at it.  I sprinkled a liberal
>dose of FormatMessage wherever error reporting was going on.  So before,
>where there'd be a message that basically said, "You got error number
>12345", now it'll print out the corresponding text.

These are nice changes, but I have a few observations:

1) The ChangeLog needs work.  See http://cygwin.com/contrib.html .

2) I don't think there is any reason to report the number if you
   are translating the text, so, I'd prefer:

   mkpasswd: The user name could not be found

3) Rather than sprinkle FormatMessage throughout the code, couldn't
   a single function be used instead.  It looks like mkpasswd just
   needs some kind of generic error function which takes an argument
   indicating whether to translate the Windows error or not.

I look forward to getting these into cygwin.  Translating the errors
will reduce a lot of user confusion.

Btw, do you have an assignment on file with Red Hat?  I can't remember.
If not, you'll need to send in an assignment as referenced in the above
URL.

cgf

>When I pulled my network cable and tried to get a user from the domain I
>got...
>$ ./mkpasswd -d -u bradshaw
>mkpasswd: error 2453.
>Could not find domain controller for this domain.
>
>Asking for a bogus user...
>$ ./mkpasswd -d -u bradshaj
>mkpasswd: error 2221.
>The user name could not be found.
>
>------------------------------------------
>
>2002-01-11  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
>
>      * mkpasswd.c: (enum_users): Use FormatMessage to print text error
>messages.
>                    (enum_local_groups): Use FormatMessage to print text
>error messages.
>                    (main): Use FormatMessage to print text error messages.
>
>------------------------------------------
>
>--- mkpasswd.c	Fri Jan 11 19:40:57 2002
>+++ mkpasswd.new.c	Fri Jan 11 20:34:18 2002
>@@ -114,9 +114,10 @@ enum_users (LPWSTR servername, int print
>   DWORD entriesread = 0;
>   DWORD totalentries = 0;
>   DWORD resume_handle = 0;
>-  DWORD rc;
>+  DWORD rc, er;
>   char ansi_srvname[256];
>   WCHAR uni_name[512];
>+  char buf[4096];
> 
>   if (servername)
>     uni2ansi (servername, ansi_srvname, sizeof (ansi_srvname));
>@@ -147,9 +148,14 @@ enum_users (LPWSTR servername, int print
> 	  break;
> 
> 	default:
>-	  fprintf (stderr, "NetUserEnum() failed with error %ld.\n", rc);
>-	  if (rc == NERR_UserNotFound) 
>-	    fprintf (stderr, "That user doesn't exist.\n");
>+	  fprintf (stderr, "mkpasswd: error %ld.\n", rc);
>+	  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
>+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
>+			      NULL,
>+			      rc,
>+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
>+			      (LPTSTR) buf, sizeof (buf), NULL))
>+	    fprintf (stderr, "%s", buf);
> 	  exit (1);
> 	}
> 
>@@ -206,7 +212,14 @@ enum_users (LPWSTR servername, int print
> 			   "LookupAccountName(%s,%s) failed with error
>%ld\n",
> 			   servername ? ansi_srvname : "NULL",
> 			   username,
>-			   GetLastError ());
>+			   er = GetLastError ());
>+		  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
>+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
>+			      NULL,
>+			      er,
>+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
>+			      (LPTSTR) buf, sizeof (buf), NULL))
>+		    fprintf (stderr, "%s", buf);
> 		  continue;
> 		}
> 	      else if (acc_type == SidTypeDomain)
>@@ -228,7 +241,14 @@ enum_users (LPWSTR servername, int print
> 			       "LookupAccountName(%s,%s) failed with error
>%ld\n",
> 			       servername ? ansi_srvname : "NULL",
> 			       domname,
>-			       GetLastError ());
>+			       er = GetLastError ());
>+		      if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
>+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
>+			      NULL,
>+			      er,
>+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
>+			      (LPTSTR) buf, sizeof (buf), NULL))
>+		        fprintf (stderr, "%s", buf);
> 		      continue;
> 		    }
> 		}
>@@ -266,7 +286,8 @@ enum_local_groups (int print_sids)
>   DWORD entriesread = 0;
>   DWORD totalentries = 0;
>   DWORD resume_handle = 0;
>-  DWORD rc ;
>+  DWORD rc, er;
>+  char buf[4096];
> 
>   do
>     {
>@@ -285,7 +306,14 @@ enum_local_groups (int print_sids)
> 	  break;
> 
> 	default:
>-	  fprintf (stderr, "NetLocalGroupEnum() failed with %ld\n", rc);
>+	  fprintf (stderr, "mkpasswd: error %ld.\n", rc);
>+	  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
>+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
>+			      NULL,
>+			      rc,
>+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
>+			      (LPTSTR) buf, sizeof (buf), NULL))
>+	    fprintf (stderr, "%s", buf);
> 	  exit (1);
> 	}
> 
>@@ -306,7 +334,14 @@ enum_local_groups (int print_sids)
> 				  &acc_type))
> 	    {
> 	      fprintf (stderr, "LookupAccountName(%s) failed with %ld\n",
>-		       localgroup_name, GetLastError ());
>+		       localgroup_name, er = GetLastError ());
>+	      if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
>+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
>+			      NULL,
>+			      er,
>+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
>+			      (LPTSTR) buf, sizeof (buf), NULL))
>+	        fprintf (stderr, "%s", buf);
> 	      continue;
> 	    }
> 	  else if (acc_type == SidTypeDomain)
>@@ -325,7 +360,14 @@ enum_local_groups (int print_sids)
> 		{
> 		  fprintf (stderr,
> 			   "LookupAccountName(%s) failed with error %ld\n",
>-			   localgroup_name, GetLastError ());
>+			   localgroup_name, er = GetLastError ());
>+		  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
>+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
>+			      NULL,
>+			      er,
>+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
>+			      (LPTSTR) buf, sizeof (buf), NULL))
>+		    fprintf (stderr, "%s", buf);
> 		  continue;
> 		}
> 	    }
>@@ -432,6 +474,7 @@ main (int argc, char **argv)
> {
>   LPWSTR servername = NULL;
>   DWORD rc = ERROR_SUCCESS;
>+  DWORD er;
>   WCHAR domain_name[200];
>   int print_local = 0;
>   int print_domain = 0;
>@@ -442,6 +485,7 @@ main (int argc, char **argv)
>   int id_offset = 10000;
>   int i;
>   char *disp_username = NULL;
>+  char buf[4096];
> 
>   char name[256], passed_home_path[MAX_PATH];
>   DWORD len;
>@@ -534,7 +578,14 @@ main (int argc, char **argv)
>   if (!load_netapi ())
>     {
>       fprintf (stderr, "Failed loading symbols from netapi32.dll "
>-		       "with error %lu\n", GetLastError ());
>+		       "with error %lu\n", er = GetLastError ());
>+      if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
>+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
>+			      NULL,
>+			      er,
>+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
>+			      (LPTSTR) buf, sizeof (buf), NULL))
>+        fprintf (stderr, "%s", buf);
>       return 1;
>     }
> 
>@@ -571,7 +622,14 @@ main (int argc, char **argv)
> 
>       if (rc != ERROR_SUCCESS)
> 	{
>-	  fprintf (stderr, "Cannot get DC, code = %ld\n", rc);
>+	  fprintf (stderr, "mkpasswd: error %ld.\n", rc);
>+	  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
>+			      | FORMAT_MESSAGE_IGNORE_INSERTS,
>+			      NULL,
>+			      rc,
>+			      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
>+			      (LPTSTR) buf, sizeof (buf), NULL))
>+	    fprintf (stderr, "%s", buf);
> 	  exit (1);
> 	}
> 
>



-- 
cgf@redhat.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
