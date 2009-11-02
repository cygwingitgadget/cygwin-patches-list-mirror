Return-Path: <cygwin-patches-return-6809-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3347 invoked by alias); 2 Nov 2009 16:33:00 -0000
Received: (qmail 3328 invoked by uid 22791); 2 Nov 2009 16:32:58 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0 	tests=AWL,BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-pz0-f173.google.com (HELO mail-pz0-f173.google.com) (209.85.222.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Nov 2009 16:32:53 +0000
Received: by pzk3 with SMTP id 3so3165106pzk.20         for <cygwin-patches@cygwin.com>; Mon, 02 Nov 2009 08:32:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.114.253.14 with SMTP id a14mr9067147wai.160.1257179568074;  	Mon, 02 Nov 2009 08:32:48 -0800 (PST)
In-Reply-To: <51e5f6120911020831p61107af8u4193cbd1d81cb38c@mail.gmail.com>
References: <51e5f6120911020821h3c3f1273sffa9107e22099eaa@mail.gmail.com>  	<51e5f6120911020831p61107af8u4193cbd1d81cb38c@mail.gmail.com>
From: Jeremy Elson <jelson@gmail.com>
Date: Mon, 02 Nov 2009 16:33:00 -0000
Message-ID: <51e5f6120911020832g715ce5c7v2bb0d60d8e662698@mail.gmail.com>
Subject: patch: Protect tcsh init scripts against home dirs with spaces in  	them
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00140.txt.bz2

Hi,
I'm not sure if this is a cygwin bug or an upstream bug, but I've
found a bug in the latest
cygwin 1.7 beta that prevents tcsh from initializing correctly in home
directories with spaces
in them. =A0A Windows username with a space (e.g., "John Doe") produces
a home directory
with a space, so this is a pretty common case.

The patch below uses double-quotes to protect a filename with a space
from becoming two
arguments in /etc/profile.d/complete.tcsh. =A0Most of that script is
already similarly protected
but this one was overlooked. =A0Starting tcsh without this patch on a
home directory that
contains a space just generates an error of "if: Expression syntax",
and the rest of the init
scripts fail.

Thanks,
Jeremy Elson

--- /etc/profile.d/complete.tcsh~ =A0 =A0 =A0 2009-09-13 00:42:57.289250000=
 -0700
+++ /etc/profile.d/complete.tcsh =A0 =A0 =A0 =A02009-11-02 08:12:26.2786085=
00 -0800
@@ -39,7 +39,7 @@ if ($?_complete) then
=A0=A0 =A0 set noglob
=A0=A0 =A0 if ( ! $?hosts ) set hosts
=A0=A0 =A0 foreach f ("$HOME/.hosts" /usr/local/etc/csh.hosts
"$HOME/.rhosts" /etc/hosts.equiv)
- =A0 =A0 =A0 =A0if ( -r $f ) then
+ =A0 =A0 =A0 =A0if ( -r "$f" ) then
=A0=A0 =A0 =A0 =A0 =A0 =A0set hosts =3D ($hosts `grep -v "+" $f | grep -E -=
v "^#" | tr
-s " " " " | cut -f 1`)
=A0=A0 =A0 =A0 =A0endif
=A0=A0 =A0 end
