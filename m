Return-Path: <cygwin-patches-return-2088-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21240 invoked by alias); 19 Apr 2002 21:07:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21188 invoked from network); 19 Apr 2002 21:07:28 -0000
Subject: patch to prevent cc1 warnings
From: Thomas Fitzsimmons <fitzsim@redhat.com>
To: newlib@sources.redhat.com
Cc: cygwin-patches@sources.redhat.com
Content-Type: multipart/mixed; boundary="=-pu09Pss5BhuiFg0U2ip8"
Date: Fri, 19 Apr 2002 14:07:00 -0000
Message-Id: <1019250448.28936.32.camel@toggle>
Mime-Version: 1.0
X-SW-Source: 2002-q2/txt/msg00072.txt.bz2


--=-pu09Pss5BhuiFg0U2ip8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-length: 1243


This patch + regenerating newlib configuration files prevents cc1
warnings like:

cc1: warning: changing search order for system directory
"/notnfs/fitzsim/src-newlib-cygwin/i686-pc-cygwin/newlib/targ-include"
cc1: warning:   as it is the same as non-system directory
"../../targ-include"
cc1: warning: changing search order for system directory
"/home/fitzsim/sources/src-gcc-devel/gcc/newlib/libc/include"
cc1: warning:   as it has already been specified as a non-system
directory

cc1: warning: changing search order for system directory
"/home/fitzsim/sources/src-gcc-devel/gcc/winsup/cygwin/include"
cc1: warning:   as it has already been specified as a non-system
directory
cc1: warning: changing search order for system directory
"/home/fitzsim/sources/src-gcc-devel/gcc/winsup/w32api/include"
cc1: warning:   as it has already been specified as a non-system
directory

Previously, these includes were specified as -isystem's in the top-level
configure.in's FLAGS_FOR_TARGET, AND as -I's in newlib_cflags in
newlib's acinclude.m4.  This patch removes the -I flags from
newlib_cflags.

Any objections?

Tom

-- 
Thomas Fitzsimmons
Red Hat Canada Limited        e-mail: fitzsim@redhat.com
2323 Yonge Street, Suite 300
Toronto, ON M4P2C9

--=-pu09Pss5BhuiFg0U2ip8
Content-Disposition: attachment; filename=newlib-cc1-warnings-patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1
Content-length: 1116

Index: acinclude.m4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/newlib/acinclude.m4,v
retrieving revision 1.6
diff -c -r1.6 acinclude.m4
*** acinclude.m4	27 Feb 2002 23:55:40 -0000	1.6
--- acinclude.m4	19 Apr 2002 20:55:43 -0000
***************
*** 141,158 ****
=20=20
  . [$]{newlib_basedir}/configure.host
=20=20
- case [$]{newlib_basedir} in
- /* | [A-Za-z]:[/\\]*) newlib_flagbasedir=3D[$]{newlib_basedir} ;;
- *) newlib_flagbasedir=3D'[$](top_builddir)/'[$]{newlib_basedir} ;;
- esac
-=20
- newlib_cflags=3D"[$]{newlib_cflags} -I"'[$](top_builddir)'"/$1/targ-inclu=
de -I[$]{newlib_flagbasedir}/libc/include"
- case "${host}" in
-   *-*-cygwin*)
-     newlib_cflags=3D"[$]{newlib_cflags} -I[$]{newlib_flagbasedir}/../wins=
up/cygwin/include  -I[$]{newlib_flagbasedir}/../winsup/w32api/include"
-     ;;
- esac
-=20
  newlib_cflags=3D"[$]{newlib_cflags} -fno-builtin"
=20=20
  NEWLIB_CFLAGS=3D${newlib_cflags}
--- 141,146 ----

--=-pu09Pss5BhuiFg0U2ip8--
