Return-Path: <cygwin-patches-return-1656-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1077 invoked by alias); 7 Jan 2002 12:15:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1047 invoked from network); 7 Jan 2002 12:15:32 -0000
Message-ID: <C2D7D58DBFE9D111B0480060086E96350689B60B@mail_server.gft.com>
From: =?iso-8859-1?Q?=22Schaible=2C_J=F6rg=22?= <Joerg.Schaible@gft.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: RE: [PATCH] Update 2 - Setup.exe property sheet patch
Date: Mon, 07 Jan 2002 04:15:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2002-q1/txt/msg00013.txt.bz2

Hi Robert,

>> "Once virtual, always virtual", i.e., it isn't necessary to add
>"virtual" to
>> any overridden virtual functions, and in fact it's not possible to
>> "unvirtualize" once virtualized.  I do try to maintain them as a
>stylistic
>> convention, but even I fall short sometimes ;-).  Thanks for patching
>that.
>
>My understanding is that this is not 100% the case. Or more
>pedantically - in a class derived from a a class with virtual=20
>functions,
>those virtual functions wil get overriden, but if not declared virtual
>themselves, any further derivations will not. I believe that the
>technique of doing this to allow inlining of code calling references to
>an object is called 'final classes'.

Sorry, Gary is right. See 10.3.2 of the standard.

Regards,
J=F6rg
