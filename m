Return-Path: <cygwin-patches-return-1997-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18441 invoked by alias); 23 Mar 2002 06:52:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18409 invoked from network); 23 Mar 2002 06:52:45 -0000
Message-ID: <035701c1d237$0fdf4810$5b46fea9@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Cc: "Robert Collins" <robert.collins@itdomain.com.au>,
	"Pavel Tsekov" <ptsekov@gmx.net>,
	"Seitz, Matt" <mseitz@snapserver.com>
References: <FC169E059D1A0442A04C40F86D9BA76008AB7D@itdomain003.itdomain.net.au>
Subject: [PATCH]Setup.Exe causes Application Error at 0x78001750
Date: Tue, 26 Mar 2002 02:14:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_033C_01C1D1F3.7E5C97A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00354.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_033C_01C1D1F3.7E5C97A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1411

From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Pavel Tsekov" <ptsekov@gmx.net>; <cygwin-apps@cygwin.com>
Cc: "Seitz, Matt" <mseitz@snapserver.com>; <cygwin@cygwin.com>
Sent: Friday, March 22, 2002 20:33
Subject: RE: [Possible BUG and a fix] Re[2]: Setup.Exe causes Application
Error at 0x78001750


> From: Pavel Tsekov [mailto:ptsekov@gmx.net]
> Sent: Saturday, March 23, 2002 11:03 AM

>   strcpy (dp, dots);
>   delete[] dots;
>   key = String (dp);
>
> LOOK HERE - This is not right - we should delete at the base
> of the block, not somewhere in the middle of it.
>   delete[] dp;
>
> We can do something like that
> char *dp = ....
> char *dp_save = dp;
>
>  ....
>
>  delete[] dp_save;

] Huh? delete[]dp; is the last reference to dp. delete[]dots; is the last
] reference to dots. Whats the problem?

dp is modified so doesn't point to the base of the allocated area by the
time delete[] dp is called.  A separate working variable should be used
rather than modifying the allocation pointer.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.html
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

Changelog:

2002-03-22  Michael A Chase <mchase@ix.netcom.com>

    * site.cc (site_list_type::init): Preserve allocation pointer for key
buffer.


------=_NextPart_000_033C_01C1D1F3.7E5C97A0
Content-Type: application/octet-stream;
	name="cinstall-mac-020322-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cinstall-mac-020322-1.patch"
Content-length: 683

--- site.cc-0	Mon Feb 18 11:19:25 2002=0A=
+++ site.cc	Fri Mar 22 22:34:51 2002=0A=
@@ -64,7 +64,8 @@ site_list_type::init (String const &newu=0A=
=20=0A=
=20=20=20=0A=
   dot =3D dots + strlen (dots);=0A=
-  char *dp =3D new char[2 * newurl.size() + 3];=0A=
+  char *dp0 =3D new char[2 * newurl.size() + 3];=0A=
+  char *dp =3D dp0;=0A=
   while (dot !=3D dots)=0A=
     {=0A=
       if (*dot =3D=3D '.' || *dot =3D=3D '/')=0A=
@@ -82,7 +83,7 @@ site_list_type::init (String const &newu=0A=
   strcpy (dp, dots);=0A=
   delete[] dots;=0A=
   key =3D String (dp);=0A=
-  delete[] dp;=0A=
+  delete[] dp0;=0A=
 }=0A=
=20=0A=
 site_list_type::site_list_type (String const &newurl)=0A=

------=_NextPart_000_033C_01C1D1F3.7E5C97A0--
