Return-Path: <cygwin-patches-return-1692-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24233 invoked by alias); 14 Jan 2002 08:30:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24219 invoked from network); 14 Jan 2002 08:30:30 -0000
Message-ID: <C2D7D58DBFE9D111B0480060086E96350689B752@mail_server.gft.com>
From: "Schaible, Jorg" <Joerg.Schaible@gft.com>
To: cygwin-patches@cygwin.com
Subject: RE: A few fixes to winsup/utils/cygpath.cc
Date: Mon, 14 Jan 2002 00:30:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C19CD5.B8474490"
X-SW-Source: 2002-q1/txt/msg00049.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C19CD5.B8474490
Content-Type: text/plain
Content-length: 1364

Hi Chris,

just an additional minor patch for Jonathtan's change in cygpath.cc, that
keeps some consistency for -i option:

/src/winsup/utils> cygpath -w > /dev/null 2>&1; echo $?
1
/src/winsup/utils> cygpath -wi > /dev/null 2>&1; echo $?
0
/src/winsup/utils> cygpath -w "" > /dev/null 2>&1; echo $?
1
/src/winsup/utils> cygpath -wi "" > /dev/null 2>&1; echo $?
1    <========== should be 0, too.
/src/winsup/utils> cygpath -wp > /dev/null 2>&1; echo $?
1
/src/winsup/utils> cygpath -wpi > /dev/null 2>&1; echo $?
0
/src/winsup/utils> cygpath -wp "" > /dev/null 2>&1; echo $?
0
/src/winsup/utils> cygpath -wpi "" > /dev/null 2>&1; echo $?
0


========

2002-01-14  Joerg Schaible <joerg.schaible@gmx.de>

	* cygpath.cc (doit): Empty file ignored using option -i

========

Regards,
Jorg

>-----Original Message-----
>From: Christopher Faylor [mailto:cgf@redhat.com]
>Sent: Wednesday, December 26, 2001 6:46 PM
>To: cygwin-patches@cygwin.com
>Subject: Re: A few fixes to winsup/utils/cygpath.cc
>
>
>On Wed, Dec 26, 2001 at 12:40:12PM -0500, Jonathan Kamens wrote:
>>2001-12-26  Jonathan Kamens  <jik@curl.com>
>>
>>	* cygpath.cc (doit): Detect and warn about an empty 
>path.  Detect
>>	and warn about errors converting a path.
>>	(main): Set prog_name correctly -- don't leave an extra slash or
>>	backslash at the beginning of it.
>
>Applied.  Thanks.
>
>cgf
>


------_=_NextPart_000_01C19CD5.B8474490
Content-Type: application/octet-stream;
	name="cygpath.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygpath.cc-patch"
Content-length: 363

164,170c164,165=0A=
<           if (!ignore_flag)=0A=
<           {=0A=
<             fprintf(stderr, "%s: can't convert empty path\n", prog_name);=
=0A=
<             exit (1);=0A=
<           }=0A=
<           else=0A=
<             exit (0);=0A=
---=0A=
>           fprintf(stderr, "%s: can't convert empty path\n", prog_name);=
=0A=
>           exit (1);=0A=

------_=_NextPart_000_01C19CD5.B8474490--
