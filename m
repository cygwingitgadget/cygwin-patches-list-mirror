Return-Path: <cygwin-patches-return-3116-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7086 invoked by alias); 5 Nov 2002 09:38:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7037 invoked from network); 5 Nov 2002 09:38:45 -0000
Message-ID: <001501c284af$07928020$b2eae18f@luigi>
From: "Luigi Piegari" <gigi-x@piegari.net>
To: <cygwin-patches@cygwin.com>
Subject: Fw: ipv6 patch problem
Date: Tue, 05 Nov 2002 01:38:00 -0000
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0012_01C284B7.66471010"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
X-SW-Source: 2002-q4/txt/msg00067.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0012_01C284B7.66471010
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-length: 451

Hi,

I installed the ipv6 patch found on win6.jp/Cygwin but i got some problems =
that could depend on my little practice with cygwin (I'm a newbie).

During making operation I can compile programs, but at the linking procedur=
e i got errors like

 undefined reference to `gethostbyname2'

to all new functions of the patch. Have I to link some library at the start=
 of cygwin? Have I to set some shared libraries?

Thank you for your help.

gigi-x

------=_NextPart_000_0012_01C284B7.66471010
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-length: 951

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3504.2500" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>I installed the ipv6 patch found on win6.jp/Cygwin but i got some prob=
lems=20
that could depend on my little practice with cygwin (I'm a newbie).</DIV>
<DIV>&nbsp;</DIV>
<DIV>During making operation I can compile programs, but at the linking=20
procedure i got errors like</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;undefined reference to `gethostbyname2'</DIV>
<DIV>&nbsp;</DIV>
<DIV>to all new functions of the patch. Have I to link some library at the =
start=20
of cygwin? Have I to set some shared libraries?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you for your help.</DIV>
<DIV>&nbsp;</DIV>
<DIV>gigi-x</DIV></BODY></HTML>

------=_NextPart_000_0012_01C284B7.66471010--
