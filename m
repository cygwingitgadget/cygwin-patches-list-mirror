Return-Path: <cygwin-patches-return-2076-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22191 invoked by alias); 18 Apr 2002 21:59:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22177 invoked from network); 18 Apr 2002 21:59:49 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH]setup.exe mklink2.cc some function arguments need to be pointers
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2002 14:59:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5E68@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00060.txt.bz2

Update your win32api - And it should not need the patch,

Rob

> -----Original Message-----
> From: Michael A Chase [mailto:mchase@ix.netcom.com]=20
> Sent: Friday, April 19, 2002 7:26 AM
> To: cygwin-patches@cygwin.com
> Subject: [PATCH]setup.exe mklink2.cc some function arguments=20
> need to be pointers
>=20
>=20
> I couldn't get mklink2.cc to compile until I made the=20
> attached changes.
>=20
> It appears that CoCreateInstance() and=20
> sl->lpVtbl->QueryInterface() are looking for pointers to=20
> values in certain arguments instead of the values. Almost the=20
> exact same code is used in src/winsup/cygwin/shortcut.c=20
> except for the '&'s and it compiles cleanly.  Both functions=20
> defined in mklink2.cc are declared extern "C" so the function=20
> calls should work the same.
>=20
> Here are the relevant pieces of code.
>=20
> src/winsup/cinstall/mklink2.cc (make_link_2):
> 23:   CoCreateInstance (CLSID_ShellLink, NULL,
> 24:             CLSCTX_INPROC_SERVER, IID_IShellLink, (LPVOID=20
> *) & sl);
> 25:   sl->lpVtbl->QueryInterface (sl, IID_IPersistFile, (void=20
> **) &pf);
>=20
> src/winsup/cygwin/shortcut.c (check_shortcut):
> 85:   hres =3D CoCreateInstance (&CLSID_ShellLink, NULL,=20
> CLSCTX_INPROC_SERVER,
> 86:                &IID_IShellLink, (void **)&psl);
> 87:   if (FAILED (hres))
> 88:     goto close_it;
> 89:   /* Get a pointer to the IPersistFile interface. */
> 90:   hres =3D psl->lpVtbl->QueryInterface (psl,=20
> &IID_IPersistFile, (void
> **)&ppf);
>=20
> src/winsup/w32api/include/objidl.h:
> 640: EXTERN_C const IID IID_IPersistFile;
>=20
> src/winsup/w32api/include/olectlid.h:
> 76: extern const GUID IID_IPersistFile;
>=20
> src/winsup/w32api/include/shlguid.h:
> 13: extern const GUID CLSID_ShellLink;
> 28: extern const GUID IID_IShellLinkA;
> 68: #define IID_IShellLink  IID_IShellLinkA
>=20
> src/winsup/w32api/lib/shell32.c:
>  6: DEFINE_SHLGUID(CLSID_ShellLink,0x00021401L,0,0);
> 21: DEFINE_SHLGUID(IID_IShellLinkA,0x000214EEL,0,0);
>=20
> src/winsup/w32api/lib/uuid.c:
> 226: DEFINE_GUID(IID_IPersistFile,0x10b,0,0,0xc0,0,0,0,0,0,0,0x46);
>=20
> --
> Mac :})
> ** I normally forward private questions to the appropriate=20
> mail list. ** Ask Smarter:=20
> http://www.tuxedo.org/~esr/faqs/smart-> questions.html
> Give a=20
> hobbit a fish and he eats fish for a=20
> day.
> Give a hobbit a ring and he eats fish for an age.
>=20
> ChangeLog:
>=20
> 2002-04-18  Michael A Chase <mchase@ix.netcom.com>
>=20
>     * mklink2.cc (check_shortcut): Change arguments from=20
> values to pointers.
>=20
