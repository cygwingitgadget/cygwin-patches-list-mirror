From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: patch to mkpasswd.c - allows selection of specific user
Date: Sat, 10 Nov 2001 20:08:00 -0000
Message-id: <911C684A29ACD311921800508B7293BA010A8FFF@cnmail>
X-SW-Source: 2001-q4/msg00194.html
Content-type: multipart/mixed; boundary="----------=_1583532850-65438-113"

This is a multi-part message in MIME format...

------------=_1583532850-65438-113
Content-length: 6613

Well, after a little thought I decided not to split things up.  Easier that
way.  Scrap that last patch.  Here's the final patch.  This patch adds a -u
option that allows for specifying that only info on a particular user should
be displayed.  All calls to enum_users now includes an additional username
parameter.  If the username is NULL enum_users functions as it had in the
past.  If it's not NULL (a user has been specified) then instead of calling
NetUserEnum it calls NetUserGetInfo, which targets just a particular user
and displays that user's info.  Also, if -u is specified then the display of
the three special users/groups are suppressed.

Since only one lookup is done when a user is supplied via -u, this should
make it very fast for those with LARGE domains.  This patch was tested on
Win2k Pro (not in a domain), Win2k Server (in a domain), and NT 4.0 (BDC).
It worked fine on all three.  I've mailed my assignment, so it should be
getting to you....sometime.  Do I need to resubmit the patch at a later
date, i.e. after the assignment's been processed?

==============================

2001-11-10  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

	* mkpasswd.c (main): New -u option to allow specifying a 
	specific user.  If specified, groups aren't displayed and
	output is limited to only the specified user.
	(enum_users): If specific user is specified, via -u option, 
	display only that user's record.  With -u use NetUserGetInfo
	instead of NetUserEnum.
	(load_netapi): Added netusergetinfo.

===============================

--- mkpasswd.c.orig	Sat Nov 10 22:50:08 2001
+++ mkpasswd.c	Sat Nov 10 22:52:45 2001
@@ -27,6 +27,7 @@ NET_API_STATUS WINAPI (*netapibufferfree
 NET_API_STATUS WINAPI
(*netuserenum)(LPWSTR,DWORD,DWORD,PBYTE*,DWORD,PDWORD,PDWORD,PDWORD);
 NET_API_STATUS WINAPI
(*netlocalgroupenum)(LPWSTR,DWORD,PBYTE*,DWORD,PDWORD,PDWORD,PDWORD);
 NET_API_STATUS WINAPI (*netgetdcname)(LPWSTR,LPWSTR,PBYTE*);
+NET_API_STATUS WINAPI (*netusergetinfo)(LPWSTR,LPWSTR,DWORD,PBYTE*);
 
 #ifndef min
 #define min(a,b) (((a)<(b))?(a):(b))
@@ -48,6 +49,8 @@ load_netapi ()
     return FALSE;
   if (!(netgetdcname = (void *) GetProcAddress (h, "NetGetDCName")))
     return FALSE;
+  if (!(netusergetinfo = (void *) GetProcAddress (h, "NetUserGetInfo")))
+    return FALSE;
 
   return TRUE;
 }
@@ -104,7 +107,7 @@ uni2ansi (LPWSTR wcs, char *mbs, int siz
 
 int
 enum_users (LPWSTR servername, int print_sids, int print_cygpath,
-	    const char * passed_home_path, int id_offset)
+	    const char * passed_home_path, int id_offset, char
*disp_username)
 {
   USER_INFO_3 *buffer;
   DWORD entriesread = 0;
@@ -112,6 +115,7 @@ enum_users (LPWSTR servername, int print
   DWORD resume_handle = 0;
   DWORD rc;
   char ansi_srvname[256];
+  WCHAR uni_name[512];
 
   if (servername)
     uni2ansi (servername, ansi_srvname, sizeof (ansi_srvname));
@@ -120,6 +124,12 @@ enum_users (LPWSTR servername, int print
     {
       DWORD i;
 
+    if (disp_username != NULL) {
+      MultiByteToWideChar (CP_ACP, 0, disp_username, -1, uni_name, 512 );
+      rc = netusergetinfo(servername, (LPWSTR) & uni_name, 3, (LPBYTE *)
&buffer );
+      entriesread=1;
+    }
+    else 
       rc = netuserenum (servername, 3, FILTER_NORMAL_ACCOUNT,
 			(LPBYTE *) & buffer, 1024,
 			&entriesread, &totalentries, &resume_handle);
@@ -135,6 +145,7 @@ enum_users (LPWSTR servername, int print
 
 	default:
 	  fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
+	  if ( rc == 2221 ) printf("That user doesn't appear to exist.\n");
 	  exit (1);
 	}
 
@@ -381,6 +392,7 @@ usage ()
   fprintf (stderr, "                           (this affects ntsec)\n");
   fprintf (stderr, "   -p,--path-to-home path  if user account has no home
dir, use\n");
   fprintf (stderr, "                           path instead of /home/\n");
+  fprintf (stderr, "   -u,--username username  only return information for
the specified user\n");
   fprintf (stderr, "   -?,--help               displays this message\n\n");
   fprintf (stderr, "One of `-l', `-d' or `-g' must be given on NT/W2K.\n");
   return 1;
@@ -394,11 +406,12 @@ struct option longopts[] = {
   {"no-mount", no_argument, NULL, 'm'},
   {"no-sids", no_argument, NULL, 's'},
   {"path-to-home",required_argument, NULL, 'p'},
+  {"username",required_argument, NULL, 'u'},
   {"help", no_argument, NULL, 'h'},
   {0, no_argument, NULL, 0}
 };
 
-char opts[] = "ldo:gsmhp:";
+char opts[] = "ldo:gsmhpu:";
 
 int
 main (int argc, char **argv)
@@ -414,6 +427,7 @@ main (int argc, char **argv)
   int print_cygpath = 1;
   int id_offset = 10000;
   int i;
+  char *disp_username = NULL;
 
   char name[256], passed_home_path[MAX_PATH];
   DWORD len;
@@ -459,6 +473,9 @@ main (int argc, char **argv)
 		if (optarg[strlen (optarg)-1] != '/')
 		  strcat (passed_home_path, "/");
 		break;
+	      case 'u':
+		disp_username = optarg;
+	      break;
 	      case 'h':
 		return usage ();
 	      default:
@@ -513,19 +530,21 @@ main (int argc, char **argv)
   /*
    * Get `Everyone' group
   */
-  print_special (print_sids, &sid_world_auth, 1, SECURITY_WORLD_RID, 0, 0,
0, 0, 0, 0, 0);
-  /*
-   * Get `system' group
-  */
-  print_special (print_sids, &sid_nt_auth, 1, SECURITY_LOCAL_SYSTEM_RID, 0,
0, 0, 0, 0, 0, 0);
-  /*
-   * Get `administrators' group
-  */
-  if (!print_local_groups)
-    print_special (print_sids, &sid_nt_auth, 2,
SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0);
-
-  if (print_local_groups)
-    enum_local_groups (print_sids);
+  if ( disp_username == NULL ) {
+    print_special (print_sids, &sid_world_auth, 1, SECURITY_WORLD_RID, 0,
0, 0, 0, 0, 0, 0);
+    /*
+     * Get `system' group
+    */
+    print_special (print_sids, &sid_nt_auth, 1, SECURITY_LOCAL_SYSTEM_RID,
0, 0, 0, 0, 0, 0, 0);
+    /*
+     * Get `administrators' group
+    */
+    if (!print_local_groups)
+      print_special (print_sids, &sid_nt_auth, 2,
SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0);
+
+    if (print_local_groups)
+      enum_local_groups (print_sids);
+  }
 
   if (print_domain)
     {
@@ -541,11 +560,11 @@ main (int argc, char **argv)
 	  exit (1);
 	}
 
-      enum_users (servername, print_sids, print_cygpath, passed_home_path,
id_offset);
+      enum_users (servername, print_sids, print_cygpath, passed_home_path,
id_offset, disp_username);
     }
 
   if (print_local)
-    enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0);
+    enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0,
disp_username);
 
   if (servername)
     netapibufferfree (servername);


------------=_1583532850-65438-113
Content-Type: text/x-diff; charset=us-ascii; name="mkpasswd.c.diff"
Content-Disposition: inline; filename="mkpasswd.c.diff"
Content-Transfer-Encoding: base64
Content-Length: 6865

LS0tIG1rcGFzc3dkLmMub3JpZwlTYXQgTm92IDEwIDIyOjUwOjA4IDIwMDEK
KysrIG1rcGFzc3dkLmMJU2F0IE5vdiAxMCAyMjo1Mjo0NSAyMDAxCkBAIC0y
Nyw2ICsyNyw3IEBAIE5FVF9BUElfU1RBVFVTIFdJTkFQSSAoKm5ldGFwaWJ1
ZmZlcmZyZWUKIE5FVF9BUElfU1RBVFVTIFdJTkFQSSAoKm5ldHVzZXJlbnVt
KShMUFdTVFIsRFdPUkQsRFdPUkQsUEJZVEUqLERXT1JELFBEV09SRCxQRFdP
UkQsUERXT1JEKTsKIE5FVF9BUElfU1RBVFVTIFdJTkFQSSAoKm5ldGxvY2Fs
Z3JvdXBlbnVtKShMUFdTVFIsRFdPUkQsUEJZVEUqLERXT1JELFBEV09SRCxQ
RFdPUkQsUERXT1JEKTsKIE5FVF9BUElfU1RBVFVTIFdJTkFQSSAoKm5ldGdl
dGRjbmFtZSkoTFBXU1RSLExQV1NUUixQQllURSopOworTkVUX0FQSV9TVEFU
VVMgV0lOQVBJICgqbmV0dXNlcmdldGluZm8pKExQV1NUUixMUFdTVFIsRFdP
UkQsUEJZVEUqKTsKIAogI2lmbmRlZiBtaW4KICNkZWZpbmUgbWluKGEsYikg
KCgoYSk8KGIpKT8oYSk6KGIpKQpAQCAtNDgsNiArNDksOCBAQCBsb2FkX25l
dGFwaSAoKQogICAgIHJldHVybiBGQUxTRTsKICAgaWYgKCEobmV0Z2V0ZGNu
YW1lID0gKHZvaWQgKikgR2V0UHJvY0FkZHJlc3MgKGgsICJOZXRHZXREQ05h
bWUiKSkpCiAgICAgcmV0dXJuIEZBTFNFOworICBpZiAoIShuZXR1c2VyZ2V0
aW5mbyA9ICh2b2lkICopIEdldFByb2NBZGRyZXNzIChoLCAiTmV0VXNlckdl
dEluZm8iKSkpCisgICAgcmV0dXJuIEZBTFNFOwogCiAgIHJldHVybiBUUlVF
OwogfQpAQCAtMTA0LDcgKzEwNyw3IEBAIHVuaTJhbnNpIChMUFdTVFIgd2Nz
LCBjaGFyICptYnMsIGludCBzaXoKIAogaW50CiBlbnVtX3VzZXJzIChMUFdT
VFIgc2VydmVybmFtZSwgaW50IHByaW50X3NpZHMsIGludCBwcmludF9jeWdw
YXRoLAotCSAgICBjb25zdCBjaGFyICogcGFzc2VkX2hvbWVfcGF0aCwgaW50
IGlkX29mZnNldCkKKwkgICAgY29uc3QgY2hhciAqIHBhc3NlZF9ob21lX3Bh
dGgsIGludCBpZF9vZmZzZXQsIGNoYXIgKmRpc3BfdXNlcm5hbWUpCiB7CiAg
IFVTRVJfSU5GT18zICpidWZmZXI7CiAgIERXT1JEIGVudHJpZXNyZWFkID0g
MDsKQEAgLTExMiw2ICsxMTUsNyBAQCBlbnVtX3VzZXJzIChMUFdTVFIgc2Vy
dmVybmFtZSwgaW50IHByaW50CiAgIERXT1JEIHJlc3VtZV9oYW5kbGUgPSAw
OwogICBEV09SRCByYzsKICAgY2hhciBhbnNpX3Nydm5hbWVbMjU2XTsKKyAg
V0NIQVIgdW5pX25hbWVbNTEyXTsKIAogICBpZiAoc2VydmVybmFtZSkKICAg
ICB1bmkyYW5zaSAoc2VydmVybmFtZSwgYW5zaV9zcnZuYW1lLCBzaXplb2Yg
KGFuc2lfc3J2bmFtZSkpOwpAQCAtMTIwLDYgKzEyNCwxMiBAQCBlbnVtX3Vz
ZXJzIChMUFdTVFIgc2VydmVybmFtZSwgaW50IHByaW50CiAgICAgewogICAg
ICAgRFdPUkQgaTsKIAorICAgIGlmIChkaXNwX3VzZXJuYW1lICE9IE5VTEwp
IHsKKyAgICAgIE11bHRpQnl0ZVRvV2lkZUNoYXIgKENQX0FDUCwgMCwgZGlz
cF91c2VybmFtZSwgLTEsIHVuaV9uYW1lLCA1MTIgKTsKKyAgICAgIHJjID0g
bmV0dXNlcmdldGluZm8oc2VydmVybmFtZSwgKExQV1NUUikgJiB1bmlfbmFt
ZSwgMywgKExQQllURSAqKSAmYnVmZmVyICk7CisgICAgICBlbnRyaWVzcmVh
ZD0xOworICAgIH0KKyAgICBlbHNlIAogICAgICAgcmMgPSBuZXR1c2VyZW51
bSAoc2VydmVybmFtZSwgMywgRklMVEVSX05PUk1BTF9BQ0NPVU5ULAogCQkJ
KExQQllURSAqKSAmIGJ1ZmZlciwgMTAyNCwKIAkJCSZlbnRyaWVzcmVhZCwg
JnRvdGFsZW50cmllcywgJnJlc3VtZV9oYW5kbGUpOwpAQCAtMTM1LDYgKzE0
NSw3IEBAIGVudW1fdXNlcnMgKExQV1NUUiBzZXJ2ZXJuYW1lLCBpbnQgcHJp
bnQKIAogCWRlZmF1bHQ6CiAJICBmcHJpbnRmIChzdGRlcnIsICJOZXRVc2Vy
RW51bSgpIGZhaWxlZCB3aXRoICVsZFxuIiwgcmMpOworCSAgaWYgKCByYyA9
PSAyMjIxICkgcHJpbnRmKCJUaGF0IHVzZXIgZG9lc24ndCBhcHBlYXIgdG8g
ZXhpc3QuXG4iKTsKIAkgIGV4aXQgKDEpOwogCX0KIApAQCAtMzgxLDYgKzM5
Miw3IEBAIHVzYWdlICgpCiAgIGZwcmludGYgKHN0ZGVyciwgIiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICh0aGlzIGFmZmVjdHMgbnRzZWMpXG4iKTsK
ICAgZnByaW50ZiAoc3RkZXJyLCAiICAgLXAsLS1wYXRoLXRvLWhvbWUgcGF0
aCAgaWYgdXNlciBhY2NvdW50IGhhcyBubyBob21lIGRpciwgdXNlXG4iKTsK
ICAgZnByaW50ZiAoc3RkZXJyLCAiICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcGF0aCBpbnN0ZWFkIG9mIC9ob21lL1xuIik7CisgIGZwcmludGYgKHN0
ZGVyciwgIiAgIC11LC0tdXNlcm5hbWUgdXNlcm5hbWUgIG9ubHkgcmV0dXJu
IGluZm9ybWF0aW9uIGZvciB0aGUgc3BlY2lmaWVkIHVzZXJcbiIpOwogICBm
cHJpbnRmIChzdGRlcnIsICIgICAtPywtLWhlbHAgICAgICAgICAgICAgICBk
aXNwbGF5cyB0aGlzIG1lc3NhZ2VcblxuIik7CiAgIGZwcmludGYgKHN0ZGVy
ciwgIk9uZSBvZiBgLWwnLCBgLWQnIG9yIGAtZycgbXVzdCBiZSBnaXZlbiBv
biBOVC9XMksuXG4iKTsKICAgcmV0dXJuIDE7CkBAIC0zOTQsMTEgKzQwNiwx
MiBAQCBzdHJ1Y3Qgb3B0aW9uIGxvbmdvcHRzW10gPSB7CiAgIHsibm8tbW91
bnQiLCBub19hcmd1bWVudCwgTlVMTCwgJ20nfSwKICAgeyJuby1zaWRzIiwg
bm9fYXJndW1lbnQsIE5VTEwsICdzJ30sCiAgIHsicGF0aC10by1ob21lIixy
ZXF1aXJlZF9hcmd1bWVudCwgTlVMTCwgJ3AnfSwKKyAgeyJ1c2VybmFtZSIs
cmVxdWlyZWRfYXJndW1lbnQsIE5VTEwsICd1J30sCiAgIHsiaGVscCIsIG5v
X2FyZ3VtZW50LCBOVUxMLCAnaCd9LAogICB7MCwgbm9fYXJndW1lbnQsIE5V
TEwsIDB9CiB9OwogCi1jaGFyIG9wdHNbXSA9ICJsZG86Z3NtaHA6IjsKK2No
YXIgb3B0c1tdID0gImxkbzpnc21ocHU6IjsKIAogaW50CiBtYWluIChpbnQg
YXJnYywgY2hhciAqKmFyZ3YpCkBAIC00MTQsNiArNDI3LDcgQEAgbWFpbiAo
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQogICBpbnQgcHJpbnRfY3lncGF0aCA9
IDE7CiAgIGludCBpZF9vZmZzZXQgPSAxMDAwMDsKICAgaW50IGk7CisgIGNo
YXIgKmRpc3BfdXNlcm5hbWUgPSBOVUxMOwogCiAgIGNoYXIgbmFtZVsyNTZd
LCBwYXNzZWRfaG9tZV9wYXRoW01BWF9QQVRIXTsKICAgRFdPUkQgbGVuOwpA
QCAtNDU5LDYgKzQ3Myw5IEBAIG1haW4gKGludCBhcmdjLCBjaGFyICoqYXJn
dikKIAkJaWYgKG9wdGFyZ1tzdHJsZW4gKG9wdGFyZyktMV0gIT0gJy8nKQog
CQkgIHN0cmNhdCAocGFzc2VkX2hvbWVfcGF0aCwgIi8iKTsKIAkJYnJlYWs7
CisJICAgICAgY2FzZSAndSc6CisJCWRpc3BfdXNlcm5hbWUgPSBvcHRhcmc7
CisJICAgICAgYnJlYWs7CiAJICAgICAgY2FzZSAnaCc6CiAJCXJldHVybiB1
c2FnZSAoKTsKIAkgICAgICBkZWZhdWx0OgpAQCAtNTEzLDE5ICs1MzAsMjEg
QEAgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogICAvKgogICAgKiBH
ZXQgYEV2ZXJ5b25lJyBncm91cAogICAqLwotICBwcmludF9zcGVjaWFsIChw
cmludF9zaWRzLCAmc2lkX3dvcmxkX2F1dGgsIDEsIFNFQ1VSSVRZX1dPUkxE
X1JJRCwgMCwgMCwgMCwgMCwgMCwgMCwgMCk7Ci0gIC8qCi0gICAqIEdldCBg
c3lzdGVtJyBncm91cAotICAqLwotICBwcmludF9zcGVjaWFsIChwcmludF9z
aWRzLCAmc2lkX250X2F1dGgsIDEsIFNFQ1VSSVRZX0xPQ0FMX1NZU1RFTV9S
SUQsIDAsIDAsIDAsIDAsIDAsIDAsIDApOwotICAvKgotICAgKiBHZXQgYGFk
bWluaXN0cmF0b3JzJyBncm91cAotICAqLwotICBpZiAoIXByaW50X2xvY2Fs
X2dyb3VwcykKLSAgICBwcmludF9zcGVjaWFsIChwcmludF9zaWRzLCAmc2lk
X250X2F1dGgsIDIsIFNFQ1VSSVRZX0JVSUxUSU5fRE9NQUlOX1JJRCwgRE9N
QUlOX0FMSUFTX1JJRF9BRE1JTlMsIDAsIDAsIDAsIDAsIDAsIDApOwotCi0g
IGlmIChwcmludF9sb2NhbF9ncm91cHMpCi0gICAgZW51bV9sb2NhbF9ncm91
cHMgKHByaW50X3NpZHMpOworICBpZiAoIGRpc3BfdXNlcm5hbWUgPT0gTlVM
TCApIHsKKyAgICBwcmludF9zcGVjaWFsIChwcmludF9zaWRzLCAmc2lkX3dv
cmxkX2F1dGgsIDEsIFNFQ1VSSVRZX1dPUkxEX1JJRCwgMCwgMCwgMCwgMCwg
MCwgMCwgMCk7CisgICAgLyoKKyAgICAgKiBHZXQgYHN5c3RlbScgZ3JvdXAK
KyAgICAqLworICAgIHByaW50X3NwZWNpYWwgKHByaW50X3NpZHMsICZzaWRf
bnRfYXV0aCwgMSwgU0VDVVJJVFlfTE9DQUxfU1lTVEVNX1JJRCwgMCwgMCwg
MCwgMCwgMCwgMCwgMCk7CisgICAgLyoKKyAgICAgKiBHZXQgYGFkbWluaXN0
cmF0b3JzJyBncm91cAorICAgICovCisgICAgaWYgKCFwcmludF9sb2NhbF9n
cm91cHMpCisgICAgICBwcmludF9zcGVjaWFsIChwcmludF9zaWRzLCAmc2lk
X250X2F1dGgsIDIsIFNFQ1VSSVRZX0JVSUxUSU5fRE9NQUlOX1JJRCwgRE9N
QUlOX0FMSUFTX1JJRF9BRE1JTlMsIDAsIDAsIDAsIDAsIDAsIDApOworCisg
ICAgaWYgKHByaW50X2xvY2FsX2dyb3VwcykKKyAgICAgIGVudW1fbG9jYWxf
Z3JvdXBzIChwcmludF9zaWRzKTsKKyAgfQogCiAgIGlmIChwcmludF9kb21h
aW4pCiAgICAgewpAQCAtNTQxLDExICs1NjAsMTEgQEAgbWFpbiAoaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQogCSAgZXhpdCAoMSk7CiAJfQogCi0gICAgICBl
bnVtX3VzZXJzIChzZXJ2ZXJuYW1lLCBwcmludF9zaWRzLCBwcmludF9jeWdw
YXRoLCBwYXNzZWRfaG9tZV9wYXRoLCBpZF9vZmZzZXQpOworICAgICAgZW51
bV91c2VycyAoc2VydmVybmFtZSwgcHJpbnRfc2lkcywgcHJpbnRfY3lncGF0
aCwgcGFzc2VkX2hvbWVfcGF0aCwgaWRfb2Zmc2V0LCBkaXNwX3VzZXJuYW1l
KTsKICAgICB9CiAKICAgaWYgKHByaW50X2xvY2FsKQotICAgIGVudW1fdXNl
cnMgKE5VTEwsIHByaW50X3NpZHMsIHByaW50X2N5Z3BhdGgsIHBhc3NlZF9o
b21lX3BhdGgsIDApOworICAgIGVudW1fdXNlcnMgKE5VTEwsIHByaW50X3Np
ZHMsIHByaW50X2N5Z3BhdGgsIHBhc3NlZF9ob21lX3BhdGgsIDAsIGRpc3Bf
dXNlcm5hbWUpOwogCiAgIGlmIChzZXJ2ZXJuYW1lKQogICAgIG5ldGFwaWJ1
ZmZlcmZyZWUgKHNlcnZlcm5hbWUpOwo=

------------=_1583532850-65438-113--
