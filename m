Return-Path: <cygwin-patches-return-2075-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8428 invoked by alias); 18 Apr 2002 21:32:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8414 invoked from network); 18 Apr 2002 21:32:48 -0000
Message-ID: <008701c1e720$8a724980$2000a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]setup.exe mklink2.cc some function arguments need to be pointers
Date: Thu, 18 Apr 2002 14:32:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0050_01C1E6E5.049509A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00059.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0050_01C1E6E5.049509A0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-length: 2028

I couldn't get mklink2.cc to compile until I made the attached changes.

It appears that CoCreateInstance() and sl->lpVtbl->QueryInterface() are
looking for pointers to values in certain arguments instead of the values.
Almost the exact same code is used in src/winsup/cygwin/shortcut.c except
for the '&'s and it compiles cleanly.  Both functions defined in mklink2.cc
are declared extern "C" so the function calls should work the same.

Here are the relevant pieces of code.

src/winsup/cinstall/mklink2.cc (make_link_2):
23:   CoCreateInstance (CLSID_ShellLink, NULL,
24:             CLSCTX_INPROC_SERVER, IID_IShellLink, (LPVOID *) & sl);
25:   sl->lpVtbl->QueryInterface (sl, IID_IPersistFile, (void **) &pf);

src/winsup/cygwin/shortcut.c (check_shortcut):
85:   hres = CoCreateInstance (&CLSID_ShellLink, NULL, CLSCTX_INPROC_SERVER,
86:                &IID_IShellLink, (void **)&psl);
87:   if (FAILED (hres))
88:     goto close_it;
89:   /* Get a pointer to the IPersistFile interface. */
90:   hres = psl->lpVtbl->QueryInterface (psl, &IID_IPersistFile, (void
**)&ppf);

src/winsup/w32api/include/objidl.h:
640: EXTERN_C const IID IID_IPersistFile;

src/winsup/w32api/include/olectlid.h:
76: extern const GUID IID_IPersistFile;

src/winsup/w32api/include/shlguid.h:
13: extern const GUID CLSID_ShellLink;
28: extern const GUID IID_IShellLinkA;
68: #define IID_IShellLink  IID_IShellLinkA

src/winsup/w32api/lib/shell32.c:
 6: DEFINE_SHLGUID(CLSID_ShellLink,0x00021401L,0,0);
21: DEFINE_SHLGUID(IID_IShellLinkA,0x000214EEL,0,0);

src/winsup/w32api/lib/uuid.c:
226: DEFINE_GUID(IID_IPersistFile,0x10b,0,0,0xc0,0,0,0,0,0,0,0x46);

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.html
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

ChangeLog:

2002-04-18  Michael A Chase <mchase@ix.netcom.com>

    * mklink2.cc (check_shortcut): Change arguments from values to pointers.

------=_NextPart_000_0050_01C1E6E5.049509A0
Content-Type: application/octet-stream;
	name="cinstall-mac-020418-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cinstall-mac-020418-1.patch"
Content-length: 693

--- mklink2.cc-0	Thu Apr 18 14:00:33 2002=0A=
+++ mklink2.cc	Thu Apr 18 14:00:07 2002=0A=
@@ -20,9 +20,9 @@ make_link_2 (char const *exepath, char c=0A=
   IPersistFile *pf;=0A=
   WCHAR widepath[_MAX_PATH];=0A=
=20=0A=
-  CoCreateInstance (CLSID_ShellLink, NULL,=0A=
-		    CLSCTX_INPROC_SERVER, IID_IShellLink, (LPVOID *) & sl);=0A=
-  sl->lpVtbl->QueryInterface (sl, IID_IPersistFile, (void **) &pf);=0A=
+  CoCreateInstance (&CLSID_ShellLink, NULL,=0A=
+		    CLSCTX_INPROC_SERVER, &IID_IShellLink, (LPVOID *) & sl);=0A=
+  sl->lpVtbl->QueryInterface (sl, &IID_IPersistFile, (void **) &pf);=0A=
=20=0A=
   sl->lpVtbl->SetPath (sl, exepath);=0A=
   sl->lpVtbl->SetArguments (sl, args);=0A=

------=_NextPart_000_0050_01C1E6E5.049509A0--
