Return-Path: <cygwin-patches-return-1509-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 30419 invoked by alias); 21 Nov 2001 03:34:33 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 30405 invoked from network); 21 Nov 2001 03:34:31 -0000
Date: Mon, 15 Oct 2001 16:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
Message-ID: <20011121033444.GA16959@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <911C684A29ACD311921800508B7293BA037D2793@cnmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911C684A29ACD311921800508B7293BA037D2793@cnmail>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00041.txt.bz2

The code looks good to me, but it seems like you you're using K&R
formatting rather than GNU formatting, i.e., the curly braces don't
match the rest of the code.

This is pretty minor, and normally I would just apply the patch, fix the
couple of formatting glitches, and check this in, however, since
mkpasswd.c is sort of owned by Corinna, I'll let her have final
approval.

Btw, the ChangeLog entry looks fine.

Thanks for this patch.  I'm looking forward to getting it into the
main distribution.

cgf

On Tue, Nov 20, 2001 at 10:02:24PM -0500, Mark Bradshaw wrote:
>Here's the mkpasswd.c patch again, with some fixes suggested by Mathew.  I
>added an include for lmerr.h, but wasn't sure how to note that (or if to
>note that) in the Changelog.  Hope I did that right...
>
>This patch adds a -u option that allows for specifying that only info on a
>particular user should be displayed.  All calls to enum_users now includes
>an additional username parameter.  If the username is NULL enum_users
>functions as it had in the past.  If a username is passed in then instead of
>calling NetUserEnum it calls NetUserGetInfo, which targets just a particular
>user, and displays that user's info.  
>
>Also, if -u is specified then the display of the three special users/groups
>are suppressed.  I did this because I assumed the -u option would be most
>used for spot additions to passwd, not complete replacements.  In this case
>it would be appended (>>) to passwd, and shouldn't display the groups.
>
>I wanted to add a -c option (current user), a la Mathew's patch, but he
>seems to be incommunicado.  Of course, as he rightly points out, you can
>just do mkpasswd -u %USER% if you want that.
>
>Since only one lookup is done when a user is supplied via -u, this should
>make it very fast for those with LARGE domains.  This patch was tested on
>Win2k Pro (not in a domain), Win2k Server (in a domain), and NT 4.0 (BDC).
>It worked fine on all three.  
>
>==============================
>
>2001-11-20  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
>
>	* mkpasswd.c: include lmerr.h
>	(main): New -u option to allow specifying a 
>	specific user.  If specified, groups aren't displayed and
>	output is limited to only the specified user.
>	(enum_users): If specific user is specified, via -u option, 
>	display only that user's record.  With -u use NetUserGetInfo
>	instead of NetUserEnum.
>	(load_netapi): Added netusergetinfo.
>
>===============================
>
>--- mkpasswd.c.cvs	Sat Oct 20 09:56:09 2001
>+++ mkpasswd.c	Tue Nov 20 21:43:14 2001
>@@ -19,6 +19,7 @@
> #include <lmaccess.h>
> #include <lmapibuf.h>
> #include <sys/fcntl.h>
>+#include <lmerr.h>
> 
> SID_IDENTIFIER_AUTHORITY sid_world_auth = {SECURITY_WORLD_SID_AUTHORITY};
> SID_IDENTIFIER_AUTHORITY sid_nt_auth = {SECURITY_NT_AUTHORITY};
>@@ -27,6 +28,7 @@ NET_API_STATUS WINAPI (*netapibufferfree
> NET_API_STATUS WINAPI
>(*netuserenum)(LPWSTR,DWORD,DWORD,PBYTE*,DWORD,PDWORD,PDWORD,PDWORD);
> NET_API_STATUS WINAPI
>(*netlocalgroupenum)(LPWSTR,DWORD,PBYTE*,DWORD,PDWORD,PDWORD,PDWORD);
> NET_API_STATUS WINAPI (*netgetdcname)(LPWSTR,LPWSTR,PBYTE*);
>+NET_API_STATUS WINAPI (*netusergetinfo)(LPWSTR,LPWSTR,DWORD,PBYTE*);
> 
> #ifndef min
> #define min(a,b) (((a)<(b))?(a):(b))
>@@ -48,6 +50,8 @@ load_netapi ()
>     return FALSE;
>   if (!(netgetdcname = (void *) GetProcAddress (h, "NetGetDCName")))
>     return FALSE;
>+  if (!(netusergetinfo = (void *) GetProcAddress (h, "NetUserGetInfo")))
>+    return FALSE;
> 
>   return TRUE;
> }
>@@ -104,7 +108,7 @@ uni2ansi (LPWSTR wcs, char *mbs, int siz
> 
> int
> enum_users (LPWSTR servername, int print_sids, int print_cygpath,
>-	    const char * passed_home_path, int id_offset)
>+	    const char * passed_home_path, int id_offset, char
>*disp_username)
> {
>   USER_INFO_3 *buffer;
>   DWORD entriesread = 0;
>@@ -112,6 +116,7 @@ enum_users (LPWSTR servername, int print
>   DWORD resume_handle = 0;
>   DWORD rc;
>   char ansi_srvname[256];
>+  WCHAR uni_name[512];
> 
>   if (servername)
>     uni2ansi (servername, ansi_srvname, sizeof (ansi_srvname));
>@@ -120,6 +125,12 @@ enum_users (LPWSTR servername, int print
>     {
>       DWORD i;
> 
>+    if (disp_username != NULL) {
>+      MultiByteToWideChar (CP_ACP, 0, disp_username, -1, uni_name, 512 );
>+      rc = netusergetinfo(servername, (LPWSTR) & uni_name, 3, (LPBYTE *)
>&buffer );
>+      entriesread=1;
>+    }
>+    else 
>       rc = netuserenum (servername, 3, FILTER_NORMAL_ACCOUNT,
> 			(LPBYTE *) & buffer, 1024,
> 			&entriesread, &totalentries, &resume_handle);
>@@ -134,7 +145,9 @@ enum_users (LPWSTR servername, int print
> 	  break;
> 
> 	default:
>-	  fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
>+	  fprintf (stderr, "NetUserEnum() failed with error %ld.\n", rc);
>+	  if ( rc == NERR_UserNotFound ) 
>+	    fprintf (stderr, "That user doesn't exist.\n");
> 	  exit (1);
> 	}
> 
>@@ -381,6 +394,7 @@ usage ()
>   fprintf (stderr, "                           (this affects ntsec)\n");
>   fprintf (stderr, "   -p,--path-to-home path  if user account has no home
>dir, use\n");
>   fprintf (stderr, "                           path instead of /home/\n");
>+  fprintf (stderr, "   -u,--username username  only return information for
>the specified user\n");
>   fprintf (stderr, "   -?,--help               displays this message\n\n");
>   fprintf (stderr, "One of `-l', `-d' or `-g' must be given on NT/W2K.\n");
>   return 1;
>@@ -394,11 +408,12 @@ struct option longopts[] = {
>   {"no-mount", no_argument, NULL, 'm'},
>   {"no-sids", no_argument, NULL, 's'},
>   {"path-to-home",required_argument, NULL, 'p'},
>+  {"username",required_argument, NULL, 'u'},
>   {"help", no_argument, NULL, 'h'},
>   {0, no_argument, NULL, 0}
> };
> 
>-char opts[] = "ldo:gsmhp:";
>+char opts[] = "ldo:gsmhpu:";
> 
> int
> main (int argc, char **argv)
>@@ -414,6 +429,7 @@ main (int argc, char **argv)
>   int print_cygpath = 1;
>   int id_offset = 10000;
>   int i;
>+  char *disp_username = NULL;
> 
>   char name[256], passed_home_path[MAX_PATH];
>   DWORD len;
>@@ -459,6 +475,9 @@ main (int argc, char **argv)
> 		if (optarg[strlen (optarg)-1] != '/')
> 		  strcat (passed_home_path, "/");
> 		break;
>+	      case 'u':
>+		disp_username = optarg;
>+	      break;
> 	      case 'h':
> 		return usage ();
> 	      default:
>@@ -513,6 +532,7 @@ main (int argc, char **argv)
>   /*
>    * Get `Everyone' group
>   */
>+  if ( disp_username == NULL ) {
>   print_special (print_sids, &sid_world_auth, 1, SECURITY_WORLD_RID, 0, 0,
>0, 0, 0, 0, 0);
>   /*
>    * Get `system' group
>@@ -526,6 +546,7 @@ main (int argc, char **argv)
> 
>   if (print_local_groups)
>     enum_local_groups (print_sids);
>+  }
> 
>   if (print_domain)
>     {
>@@ -541,11 +562,11 @@ main (int argc, char **argv)
> 	  exit (1);
> 	}
> 
>-      enum_users (servername, print_sids, print_cygpath, passed_home_path,
>id_offset);
>+      enum_users (servername, print_sids, print_cygpath, passed_home_path,
>id_offset, disp_username);
>     }
> 
>   if (print_local)
>-    enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0);
>+    enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0,
>disp_username);
> 
>   if (servername)
>     netapibufferfree (servername);
>

>--- mkpasswd.c.cvs	Sat Oct 20 09:56:09 2001
>+++ mkpasswd.c	Tue Nov 20 21:43:14 2001
>@@ -19,6 +19,7 @@
> #include <lmaccess.h>
> #include <lmapibuf.h>
> #include <sys/fcntl.h>
>+#include <lmerr.h>
> 
> SID_IDENTIFIER_AUTHORITY sid_world_auth = {SECURITY_WORLD_SID_AUTHORITY};
> SID_IDENTIFIER_AUTHORITY sid_nt_auth = {SECURITY_NT_AUTHORITY};
>@@ -27,6 +28,7 @@ NET_API_STATUS WINAPI (*netapibufferfree
> NET_API_STATUS WINAPI (*netuserenum)(LPWSTR,DWORD,DWORD,PBYTE*,DWORD,PDWORD,PDWORD,PDWORD);
> NET_API_STATUS WINAPI (*netlocalgroupenum)(LPWSTR,DWORD,PBYTE*,DWORD,PDWORD,PDWORD,PDWORD);
> NET_API_STATUS WINAPI (*netgetdcname)(LPWSTR,LPWSTR,PBYTE*);
>+NET_API_STATUS WINAPI (*netusergetinfo)(LPWSTR,LPWSTR,DWORD,PBYTE*);
> 
> #ifndef min
> #define min(a,b) (((a)<(b))?(a):(b))
>@@ -48,6 +50,8 @@ load_netapi ()
>     return FALSE;
>   if (!(netgetdcname = (void *) GetProcAddress (h, "NetGetDCName")))
>     return FALSE;
>+  if (!(netusergetinfo = (void *) GetProcAddress (h, "NetUserGetInfo")))
>+    return FALSE;
> 
>   return TRUE;
> }
>@@ -104,7 +108,7 @@ uni2ansi (LPWSTR wcs, char *mbs, int siz
> 
> int
> enum_users (LPWSTR servername, int print_sids, int print_cygpath,
>-	    const char * passed_home_path, int id_offset)
>+	    const char * passed_home_path, int id_offset, char *disp_username)
> {
>   USER_INFO_3 *buffer;
>   DWORD entriesread = 0;
>@@ -112,6 +116,7 @@ enum_users (LPWSTR servername, int print
>   DWORD resume_handle = 0;
>   DWORD rc;
>   char ansi_srvname[256];
>+  WCHAR uni_name[512];
> 
>   if (servername)
>     uni2ansi (servername, ansi_srvname, sizeof (ansi_srvname));
>@@ -120,6 +125,12 @@ enum_users (LPWSTR servername, int print
>     {
>       DWORD i;
> 
>+    if (disp_username != NULL) {
>+      MultiByteToWideChar (CP_ACP, 0, disp_username, -1, uni_name, 512 );
>+      rc = netusergetinfo(servername, (LPWSTR) & uni_name, 3, (LPBYTE *) &buffer );
>+      entriesread=1;
>+    }
>+    else 
>       rc = netuserenum (servername, 3, FILTER_NORMAL_ACCOUNT,
> 			(LPBYTE *) & buffer, 1024,
> 			&entriesread, &totalentries, &resume_handle);
>@@ -134,7 +145,9 @@ enum_users (LPWSTR servername, int print
> 	  break;
> 
> 	default:
>-	  fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
>+	  fprintf (stderr, "NetUserEnum() failed with error %ld.\n", rc);
>+	  if ( rc == NERR_UserNotFound ) 
>+	    fprintf (stderr, "That user doesn't exist.\n");
> 	  exit (1);
> 	}
> 
>@@ -381,6 +394,7 @@ usage ()
>   fprintf (stderr, "                           (this affects ntsec)\n");
>   fprintf (stderr, "   -p,--path-to-home path  if user account has no home dir, use\n");
>   fprintf (stderr, "                           path instead of /home/\n");
>+  fprintf (stderr, "   -u,--username username  only return information for the specified user\n");
>   fprintf (stderr, "   -?,--help               displays this message\n\n");
>   fprintf (stderr, "One of `-l', `-d' or `-g' must be given on NT/W2K.\n");
>   return 1;
>@@ -394,11 +408,12 @@ struct option longopts[] = {
>   {"no-mount", no_argument, NULL, 'm'},
>   {"no-sids", no_argument, NULL, 's'},
>   {"path-to-home",required_argument, NULL, 'p'},
>+  {"username",required_argument, NULL, 'u'},
>   {"help", no_argument, NULL, 'h'},
>   {0, no_argument, NULL, 0}
> };
> 
>-char opts[] = "ldo:gsmhp:";
>+char opts[] = "ldo:gsmhpu:";
> 
> int
> main (int argc, char **argv)
>@@ -414,6 +429,7 @@ main (int argc, char **argv)
>   int print_cygpath = 1;
>   int id_offset = 10000;
>   int i;
>+  char *disp_username = NULL;
> 
>   char name[256], passed_home_path[MAX_PATH];
>   DWORD len;
>@@ -459,6 +475,9 @@ main (int argc, char **argv)
> 		if (optarg[strlen (optarg)-1] != '/')
> 		  strcat (passed_home_path, "/");
> 		break;
>+	      case 'u':
>+		disp_username = optarg;
>+	      break;
> 	      case 'h':
> 		return usage ();
> 	      default:
>@@ -513,6 +532,7 @@ main (int argc, char **argv)
>   /*
>    * Get `Everyone' group
>   */
>+  if ( disp_username == NULL ) {
>   print_special (print_sids, &sid_world_auth, 1, SECURITY_WORLD_RID, 0, 0, 0, 0, 0, 0, 0);
>   /*
>    * Get `system' group
>@@ -526,6 +546,7 @@ main (int argc, char **argv)
> 
>   if (print_local_groups)
>     enum_local_groups (print_sids);
>+  }
> 
>   if (print_domain)
>     {
>@@ -541,11 +562,11 @@ main (int argc, char **argv)
> 	  exit (1);
> 	}
> 
>-      enum_users (servername, print_sids, print_cygpath, passed_home_path, id_offset);
>+      enum_users (servername, print_sids, print_cygpath, passed_home_path, id_offset, disp_username);
>     }
> 
>   if (print_local)
>-    enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0);
>+    enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0, disp_username);
> 
>   if (servername)
>     netapibufferfree (servername);
