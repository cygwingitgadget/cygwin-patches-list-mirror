Return-Path: <cygwin-patches-return-8149-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97408 invoked by alias); 10 Jun 2015 17:23:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 97392 invoked by uid 89); 10 Jun 2015 17:23:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Jun 2015 17:23:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A203BA8093B; Wed, 10 Jun 2015 19:23:29 +0200 (CEST)
Date: Wed, 10 Jun 2015 17:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Improve strace to log most Windows debug events
Message-ID: <20150610172329.GJ31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1433937922-16492-1-git-send-email-jon.turney@dronecode.org.uk> <20150610141120.GG31537@calimero.vinschen.de> <20150610141827.GH31537@calimero.vinschen.de> <20150610154400.GI31537@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <20150610154400.GI31537@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00050.txt.bz2


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3657

On Jun 10 17:44, Corinna Vinschen wrote:
> On Jun 10 16:18, Corinna Vinschen wrote:
> > On Jun 10 16:11, Corinna Vinschen wrote:
> > > Hi Jon,
> > >=20
> > > On Jun 10 13:05, Jon TURNEY wrote:
> > > > Not sure if this is wanted, but on a couple of occasions recently I=
 have been
> > > > presented with strace output which contains an exception at an addr=
ess in an
> > > > unknown module (i.e. not in the cygwin DLL or the main executable),=
 so here is a
> > > > patch which adds some more information, including DLL load addresse=
s, to help
> > > > interpret such straces.
> > >=20
> > > That's a nice addition.  Two points, though:
> > >=20
> > > - Do we *always* want that output or do we want a way to switch it on
> > >   and off?  If the latter, we can simply add another _STRACE_foo opti=
on
> > >   for it.=20=20
> > >=20
> > > - The GetFileNameFromHandle function could be much simpler.  Rather t=
han
> > >   opening a mapping object for ev.u.LoadDll.hFile, just use the exist=
ing
> > >   mapping object from ev.u.LoadDll.lpBaseOfDll.
> >=20
> >     ...with the process handle taken from get_child(ev.dwProcessId).
>=20
> And since I'm generally fuzzy and unclear in my first reply:
>=20
> Of course, ev.u.LoadDll.lpBaseOfDll is not the mapping *object*, but the
> mapping *address*.  So you neither have to call CreateFileMapping nor
> MapViewOfFile.  Just call GetMappedFileNameW (get_child (ev.dwProcessId),
> ev.u.LoadDll.lpBaseOfDll, ...)

This works for me resulting in Win32 pathnames.  These are only the
affected diff hunks, I omited the rest.  Does that work for you?

Btw., I don't like using MAX_PATH as maximum path length, but I think
DLL paths can't be longer anyway, so that should be ok...


diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
index 73096ab..0661e17 100644
--- a/winsup/utils/strace.cc
+++ b/winsup/utils/strace.cc
@@ -54,6 +54,8 @@ static BOOL close_handle (HANDLE h, DWORD ok);
=20
 #define CloseHandle(h) close_handle(h, 0)
=20
+static void *drive_map;
+
 struct child_list
 {
   DWORD id;
@@ -637,6 +639,30 @@ handle_output_debug_string (DWORD id, LPVOID p, unsign=
ed mask, FILE *ofile)
     fflush (ofile);
 }
=20
+static BOOL
+GetFileNameFromHandle(HANDLE hFile, WCHAR pszFilename[MAX_PATH+1])
+{
+  BOOL result =3D FALSE;
+  ULONG len =3D 0;
+  OBJECT_NAME_INFORMATION *ntfn =3D (OBJECT_NAME_INFORMATION *) alloca (65=
536);
+  NTSTATUS status =3D NtQueryObject (hFile, ObjectNameInformation,
+				   ntfn, 65536, &len);
+  if (NT_SUCCESS (status))
+    {
+      PWCHAR win32path =3D ntfn->Name.Buffer;
+      win32path[ntfn->Name.Length / sizeof (WCHAR)] =3D L'\0';
+
+      /* NtQueryObject returns a native NT path.  (Try to) convert to Win3=
2. */
+      if (drive_map)
+	win32path =3D (PWCHAR) cygwin_internal (CW_MAP_DRIVE_MAP, drive_map,
+					      win32path);
+      pszFilename[0] =3D L'\0';
+      wcsncat (pszFilename, win32path, MAX_PATH);
+      result =3D TRUE;
+    }
+  return result;
+}
+
 static DWORD
 proc_child (unsigned mask, FILE *ofile, pid_t pid)
 {
@@ -1090,7 +1143,13 @@ character #%d.\n", optarg, (int) (endptr - optarg), =
endptr);
   if (toggle)
     dotoggle (pid);
   else
-    ExitProcess (dostrace (mask, ofile, pid, argv + optind));
+    {
+      drive_map =3D (void *) cygwin_internal (CW_ALLOC_DRIVE_MAP);
+      DWORD ret =3D dostrace (mask, ofile, pid, argv + optind);
+      if (drive_map)
+	cygwin_internal (CW_FREE_DRIVE_MAP, drive_map);
+      ExitProcess (ret);
+    }
   return 0;
 }
=20

Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeHKRAAoJEPU2Bp2uRE+goJwP/iygfCcIhb5qdm0XsVtHhcvu
FixGmtAJzz+RZfWF3qwTnsiTQS8KQA38zn3ogdjHU+fma04XFezl31T0WJKOR/xs
Go10bUQHlIFFBr+EYQzSZwCGHopyuhUaf8vag3bnJvQR/qCRh51BCZUJDYUV0vGh
LPcvv7YK53sX5iblwtgS1LyHa9VQbRIVwkF15fL0FLiQsyuqa5KgdQLOzYsoa1Yw
6vc0q88qn6ySKXN/xP2PZa1MC/7RFtxPPosaqqA+YJzULT+oLCy8vTU+NQONPrpt
P44Jo/4BzrILby8USWZ4hy+Dqzn6rC2YTMfhwSeP7XFRNmxGzxY8hdGKGkQpNdLb
kIthbqV8/05StKPlADlgw3nlddF58O1nfvV380qvWFYXiiqbS9Xk9JmEhdU9UrWx
FszueTiShN3WUgRZxbYIoJdkf+8KjSb+S8LNhYekJJyrrcNINjwST8MSJh+XWR3G
LKP8zwMABwB/VrJWnNcSvXC04iljRHenpKMDQZ3kfwBvmr5C0DKobzlQ/gzV6NzJ
Ea5SW8R7YBG3eGqpR9usEMWDc+QZuzDME4F5ResEDrX2JtAeorrGiHA8hWerMBtI
eBkHj8EwQ6OpoNCfnYevWVHH0ZEnXEMs8tyWcb8+bB91+7GkNHeUUYEfDXcWJnv7
rC9qoA/BMiL5orguz1v/
=h77Y
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
