Return-Path: <cygwin-patches-return-1865-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25993 invoked by alias); 13 Feb 2002 02:36:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25961 invoked from network); 13 Feb 2002 02:36:09 -0000
Message-ID: <004601c1b437$4c883380$2801a8c0@dcuthbert2k>
From: "Dylan Cuthbert" <dylan@q-games.com>
To: <cygwin-patches@cygwin.com>
Subject: addition to faq regarding directX + RCS 5.7 (tentatively)
Date: Tue, 12 Feb 2002 18:46:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0043_01C1B482.BC68AF90"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00222.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0043_01C1B482.BC68AF90
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-length: 1019


Hello there,

I've mirrored Peter Puck's directx 8 libs and dlls on my own site -
http://www.q-games.com/personal/utils

and I've also created this section that I hope the FAQ maintainer will
insert into the how-programming.texinfo file. I've never edited a texinfo
file before so I simply copied one of the other sections as a template -
hopefully thats ok.

Also on my page is the tgz'd distribution of RCS 5.7 for cygwin - I'm not
sure if I did the right thing when I "fixed" this to work for Cygwin which
is why I'm not attempting to get it included in the cygwin distribution as a
package.  If some other people could try it and confirm its working fine
then I'll think about making it a package.

The reason I went to the bother of getting RCS to work is that viewcvs uses
it and now viewcvs works fine, and combined with apache for cygwin makes for
a great cvs repository browser.

Regards

---------------------------------
Q-Games, Dylan Cuthbert.
http://www.q-games.com
http://www.q-games.com/personal/utils

------=_NextPart_000_0043_01C1B482.BC68AF90
Content-Type: application/octet-stream;
	name="howto-directx.texinfo"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="howto-directx.texinfo"
Content-length: 536

=0A=
@subsection Can I use DirectX/Input/Draw/Sound/Show with Cygwin?=0A=
=0A=
The simple and quick answer is, yes to all apart from DirectShow. The versi=
on of the DirectX libraries supplied with Cygwin by default are old. Howeve=
r, Peter Puck has ported version 8 and it is available at one of the follow=
ing locations:=0A=
=0A=
@file{http://sites.netscape.net/ptrpck/directx.htm} (down at time of writin=
g)=0A=
@file{http://rain.prohosting.com/urebel/download.html}=0A=
@file{http://www.q-games.com/personal/utils}=0A=
=0A=
=0A=

------=_NextPart_000_0043_01C1B482.BC68AF90--
