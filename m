Return-Path: <cygwin-patches-return-3877-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16045 invoked by alias); 23 May 2003 22:24:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16007 invoked from network); 23 May 2003 22:24:17 -0000
Message-ID: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001>
From: "Bill C. Riemers" <cygwin@docbill.net>
To: <cygwin-patches@cygwin.com>
Subject: Proposed change for Win9x file permissions...
Date: Fri, 23 May 2003 22:24:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_053C_01C3214C.FCA3CC10"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-SW-Source: 2003-q2/txt/msg00104.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_053C_01C3214C.FCA3CC10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 947

Actually there are two patches.  The first one is to fhandler_disk_file.cc.
This changes the fstat()
function to show Win9x permissions masked by the "umask".  This is the same
thing early versions of
the Linux FAT driver did, before "umask" was added as a mount option.
Obviously that would be the better solution for Cygwin as well.  However, I
decided try the simpler option of just using the normal umask first.

This allows utilities like sshd to work as expected simply by wrapping them
in a script like:

    #!/bin/bash
    umask 0077;exec /usr/sbin/sshd "$@"

Of course there will be unexpected side effects if someone doesn't realize
that umask is used this way...   But it will probably be less problematic
than having completely unchangeable permissions
under Win9x.

The second patch corrects an obvious typo in winusers.h that prevents the
current CVS code from compiling.

                                                      Bill

------=_NextPart_000_053C_01C3214C.FCA3CC10
Content-Type: application/octet-stream;
	name="cygwin.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin.patch"
Content-length: 2314

? cygwin.patch=0A=
Index: winsup/cygwin/fhandler_disk_file.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v=0A=
retrieving revision 1.50=0A=
diff -c -r1.50 fhandler_disk_file.cc=0A=
*** winsup/cygwin/fhandler_disk_file.cc	11 May 2003 21:52:09 -0000	1.50=0A=
--- winsup/cygwin/fhandler_disk_file.cc	23 May 2003 20:34:10 -0000=0A=
***************=0A=
*** 345,350 ****=0A=
--- 345,353 ----=0A=
=20=20=0A=
        if (pc->exec_state () =3D=3D is_executable)=0A=
  	buf->st_mode |=3D STD_XBITS;=0A=
+=20=0A=
+       /* This fakes the permissions of all files to match the current uma=
sk. */=0A=
+       buf->st_mode &=3D ~(cygheap->umask);=0A=
      }=0A=
=20=20=0A=
    /* The number of links to a directory includes the=0A=
Index: winsup/w32api/include/winuser.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/winuser.h,v=0A=
retrieving revision 1.36=0A=
diff -c -r1.36 winuser.h=0A=
*** winsup/w32api/include/winuser.h	23 May 2003 08:07:05 -0000	1.36=0A=
--- winsup/w32api/include/winuser.h	23 May 2003 20:34:41 -0000=0A=
***************=0A=
*** 2960,2966 ****=0A=
  BOOL WINAPI EnumDisplaySettingsA(LPCSTR,DWORD,PDEVMODEA);=0A=
  BOOL WINAPI EnumDisplaySettingsW(LPCWSTR,DWORD,PDEVMODEW);=0A=
  BOOL WINAPI EnumDisplayDevicesA(LPCSTR,DWORD,PDISPLAY_DEVICEA,DWORD);=0A=
! BOOL WINAPI EnumDisplayDevicesA(LPCWSTR,DWORD,PDISPLAY_DEVICEW,DWORD);=0A=
  #endif=0A=
  int WINAPI EnumPropsA(HWND,PROPENUMPROCA);=0A=
  int WINAPI EnumPropsW(HWND,PROPENUMPROCW);=0A=
--- 2960,2966 ----=0A=
  BOOL WINAPI EnumDisplaySettingsA(LPCSTR,DWORD,PDEVMODEA);=0A=
  BOOL WINAPI EnumDisplaySettingsW(LPCWSTR,DWORD,PDEVMODEW);=0A=
  BOOL WINAPI EnumDisplayDevicesA(LPCSTR,DWORD,PDISPLAY_DEVICEA,DWORD);=0A=
! BOOL WINAPI EnumDisplayDevicesW(LPCWSTR,DWORD,PDISPLAY_DEVICEW,DWORD);=0A=
  #endif=0A=
  int WINAPI EnumPropsA(HWND,PROPENUMPROCA);=0A=
  int WINAPI EnumPropsW(HWND,PROPENUMPROCW);=0A=

------=_NextPart_000_053C_01C3214C.FCA3CC10--

