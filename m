Return-Path: <cygwin-patches-return-6850-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32742 invoked by alias); 25 Nov 2009 14:03:54 -0000
Received: (qmail 32293 invoked by uid 22791); 25 Nov 2009 14:03:52 -0000
X-SWARE-Spam-Status: No, hits=-0.2 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mail16.tpgi.com.au (HELO mail16.tpgi.com.au) (203.12.160.231)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 25 Nov 2009 14:03:47 +0000
X-TPG-Junk-Checked: Yes
X-TPG-Junk-Status: Message not scanned because user authenticated using SMTP AUTH
X-TPG-Abuse: host=123-243-74-63.tpgi.com.au; ip=123.243.74.63; date=Thu, 26 Nov 2009 01:03:44 +1100; auth=a/dd58RmThMRQbJLhdmDwr/fcSovfa0vOzWc399V3Kc=
Received: from [10.1.1.3] (123-243-74-63.tpgi.com.au [123.243.74.63]) 	(authenticated bits=0) 	by mail16.tpgi.com.au (envelope-from helium@shaddybaddah.name) (8.14.3/8.14.3) with ESMTP id nAPE3gV8003695 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2009 01:03:44 +1100
Message-ID: <4B0D3920.3020907@shaddybaddah.name>
Date: Wed, 25 Nov 2009 14:03:00 -0000
From: Shaddy Baddah <helium@shaddybaddah.name>
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] override-able installation_root
Content-Type: multipart/mixed;  boundary="------------020902060002010802040201"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00181.txt.bz2

This is a multi-part message in MIME format.
--------------020902060002010802040201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2952

Hi,

Please find attached a patch to allow for override-able 
installation_root. I actually wrote this patch for release 1.7.0-52 
motivated by the thread I started " [1.7] Alternative root directory. 
Sort of a regression." 
[http://cygwin.com/ml/cygwin/2009-07/msg00904.html]. I have forward 
ported it.

The idea behind this patch is as follows. Presently, the 
installation_root is fixed to be based off of the path to the cygwin 
dll. This also means that the /etc/fstab must be located exactly at 
..\etc\fstab relative path to the path of the folder containing the 
cygwin dll.

I wished/qwish to shared a single Cygwin installation on my host, with 
my guest Windows in VirtualBox. However, I need and wanted a) a 
different path to home directories (because I wanted to ensure read-only 
sharing) b) generally alternative configuration from /etc. This is why I 
needed both an alternative /etc/fstab and /etc directory in general. 
These both imply an alternative installation_root, as this is how these 
"bootstrap" locations are determined.

The patch works by checking for a supplementary, manually added registry 
entry, which indicates that the rootdir set by the Cygwin setup 
application should be considered the installation_root. The idea is that 
on the Cygwin installation "client", the administrator would manually 
setup both .../Cygwin/Setup/rootdir and 
.../Cygwin/Setup/rootdir_is_installation_dir.

Note, in forward porting, I had to discard a change I made to reg_key 
(registry.{h,cc}) in deference to a change Corinna made that partly 
mirrored my own. I am talking about the addition of the following method 
(and its associates):

  int get_string (const PWCHAR, PWCHAR, size_t, const PWCHAR);

However, I have found this to be slightly problematic. It resulted in me 
having to explicitly cast as in:

      && (setup_reg.get_string ((const PWCHAR)L"rootdir",
                setup_installation_root, PATH_MAX,
                (const PWCHAR)L"") == ERROR_SUCCESS))

When faced with the same situation, to avoid the cast, I had to alter 
the method to look like this:

  int get_string (PCWCH, PWCHAR buf, size_t len, PCWCH def);

To be honest, I don't totally understand why it was necessary, even 
though I am aware of the difference between const positioning. Perhaps 
this needs a second look at? By the way, this problem pricked my 
curiosity leading me to ask about "regtool/registry interfacing and 
charset support" [http://cygwin.com/ml/cygwin/2009-07/msg00930.html].

winsup/cygwin/ChangeLog

2009-11-25  Shaddy Baddah  <helium@shaddybaddah.name>

    * include/cygwin/version.h: Added CYGWIN_INFO_SETUP_NAME registry
    name for consistency
    * shared.cc (init_installation_root): Switches in the setup
    rootdir as the installation_root when a boolean registry entry
    "rootdir_is_installation_root" is set true.


Thanks in advance for (fingers crossed, thoughtfully) considering this 
patch,
Shaddy


--------------020902060002010802040201
Content-Type: text/plain;
 name="override-able_installation_root.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="override-able_installation_root.diff"
Content-length: 2863

diff -r b073827c578e -r 7754c52b6400 winsup/cygwin/include/cygwin/version.h
--- a/winsup/cygwin/include/cygwin/version.h	Mon Nov 23 14:53:41 2009 +1100
+++ b/winsup/cygwin/include/cygwin/version.h	Thu Nov 26 00:59:34 2009 +1100
@@ -413,6 +413,7 @@
 #define CYGWIN_INFO_CYGWIN_REGISTRY_NAME "Cygwin"
 #define CYGWIN_INFO_PROGRAM_OPTIONS_NAME "Program Options"
 #define CYGWIN_INFO_INSTALLATIONS_NAME   "Installations"
+#define CYGWIN_INFO_SETUP_NAME           "setup"
 
      /* The default cygdrive prefix. */
 
diff -r b073827c578e -r 7754c52b6400 winsup/cygwin/shared.cc
--- a/winsup/cygwin/shared.cc	Mon Nov 23 14:53:41 2009 +1100
+++ b/winsup/cygwin/shared.cc	Thu Nov 26 00:59:34 2009 +1100
@@ -91,16 +91,59 @@
   RtlInt64ToHexUnicodeString (hash_path_name (0, installation_root),
 			      &installation_key, FALSE);
 
-  PWCHAR w = wcsrchr (installation_root, L'\\');
-  if (w)
+  reg_key setup_reg (true, KEY_READ, CYGWIN_INFO_SETUP_NAME, NULL);
+  WCHAR setup_installation_root[PATH_MAX];
+  if (setup_reg.get_int ("rootdir_is_installation_root", 0)
+      && (setup_reg.get_string ((const PWCHAR)L"rootdir",
+				setup_installation_root, PATH_MAX,
+				(const PWCHAR)L"") == ERROR_SUCCESS))
     {
+      DWORD attr = GetFileAttributesW(setup_installation_root);
+      if ((attr == INVALID_FILE_ATTRIBUTES)
+	  || (! (attr & FILE_ATTRIBUTE_DIRECTORY)))
+	{
+	  api_fatal ("Can't initialize Cygwin installation root dir.\n"
+		     "GetFileAttributesW(%p), %d",
+		     setup_installation_root, attr);
+	}
+      /* lop of any trailing slash, to be consistent with the dll handling */
+      size_t last_wchr_idx = wcslen(setup_installation_root) - 1;
+      system_printf("last_wchr_idx %d\n", last_wchr_idx);
+      if ((last_wchr_idx >= 0)
+	  && (setup_installation_root[last_wchr_idx] == L'\\'))
+	setup_installation_root[last_wchr_idx] = L'\0';
+
+      wcscpy(installation_root, setup_installation_root);
+      p = installation_root;
+      if (wcsncmp (p, L"\\\\?\\", 4))	/* No long path prefix. */
+	{
+	  if (!wcsncasecmp (p, L"\\\\", 2))	/* UNC */
+	    {
+	      p = wcpcpy (p, L"\\??\\UN");
+	      wcsncat (p, setup_installation_root, PATH_MAX - 6);
+	      *p = L'C';
+	    }
+	  else
+	    {
+	      p = wcpcpy (p, L"\\??\\");
+	      wcsncat (p, setup_installation_root, PATH_MAX - 4);
+	    }
+	}
+      installation_root[1] = L'?';
+    }
+  else
+    {
+      PWCHAR w = wcsrchr (installation_root, L'\\');
+      if (w)
+	{
+	  *w = L'\0';
+	  w = wcsrchr (installation_root, L'\\');
+	}
+      if (!w)
+	api_fatal ("Can't initialize Cygwin installation root dir.\n"
+		   "Invalid DLL path");
       *w = L'\0';
-      w = wcsrchr (installation_root, L'\\');
     }
-  if (!w)
-    api_fatal ("Can't initialize Cygwin installation root dir.\n"
-	       "Invalid DLL path");
-  *w = L'\0';
 
   for (int i = 1; i >= 0; --i)
     {


--------------020902060002010802040201--
