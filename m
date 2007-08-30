Return-Path: <cygwin-patches-return-6136-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14703 invoked by alias); 30 Aug 2007 16:44:46 -0000
Received: (qmail 14692 invoked by uid 22791); 30 Aug 2007 16:44:46 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 30 Aug 2007 16:44:41 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Thu, 30 Aug 2007 17:44:39 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: "Cygwin patches" <cygwin-patches@cygwin.com>
Subject: FW: mkgroup (366): [2123] The API return buffer is too small.
Date: Thu, 30 Aug 2007 16:44:00 -0000
Message-ID: <007b01c7eb25$0e8716c0$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----=_NextPart_000_007C_01C7EB2D.704B7EC0"
X-Mailer: Microsoft Office Outlook 11
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00011.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_007C_01C7EB2D.704B7EC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 845

On 30 August 2007 01:35, Brian Egge wrote:

> When running mkgroup after installing cygwin I receive the following
> error:
> 
> $ mkgroup  -l -d > /etc/group
> mkgroup (366): [2123] The API return buffer is too small.
> 
> I suspect this is due to the large number of groups our organization
> has.

  Very strange.  All the other netenum* calls use MAX_PREFERRED_LENGTH.  Can't
see why this one would be omitted, but the fix is basically obvious.

  Tested by turning down the size to 128 so I could reproduce the error on my
system here, then using MAX_PREFERRED_LENGTH and watching it no longer fail.


winsup/utils/ChangeLog:

	* mkgroup.c (enum_groups):  Use MAX_PREFERRED_LENGTH in netgroupenum
	call so that it will automatically size returned buffer sufficiently.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_007C_01C7EB2D.704B7EC0
Content-Type: application/octet-stream;
	name="mkgroup-bufsize-patch.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mkgroup-bufsize-patch.diff"
Content-length: 835

Index: winsup/utils/mkgroup.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/mkgroup.c,v=0A=
retrieving revision 1.27=0A=
diff -p -u -r1.27 mkgroup.c=0A=
--- winsup/utils/mkgroup.c	18 Jan 2006 15:57:56 -0000	1.27=0A=
+++ winsup/utils/mkgroup.c	30 Aug 2007 16:42:29 -0000=0A=
@@ -350,7 +350,7 @@ enum_groups (LPWSTR servername, int prin=0A=
 	  entriesread=3D1;=0A=
 	}=0A=
       else=20=0A=
-	rc =3D netgroupenum (servername, 2, (void *) & buffer, 1024,=0A=
+	rc =3D netgroupenum (servername, 2, (void *) & buffer, MAX_PREFERRED_LENG=
TH,=0A=
 			   &entriesread, &totalentries, &resume_handle);=0A=
       switch (rc)=0A=
 	{=0A=

------=_NextPart_000_007C_01C7EB2D.704B7EC0--
