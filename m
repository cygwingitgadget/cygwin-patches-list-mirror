Return-Path: <cygwin-patches-return-3682-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20197 invoked by alias); 11 Mar 2003 09:43:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20077 invoked from network); 11 Mar 2003 09:42:31 -0000
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: A patch for the cygwin1.dll console handler
Date: Tue, 11 Mar 2003 09:43:00 -0000
Message-ID: <C691E039D3895C44AB8DFD006B950FB42AA93A@lanmhs50.rd.francetelecom.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "COTTO Daniel FTRD/DMI/CAE" <daniel.cotto@rd.francetelecom.com>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
X-OriginalArrivalTime: 11 Mar 2003 09:42:30.0534 (UTC) FILETIME=[88D04260:01C2E7B2]
X-SW-Source: 2003-q1/txt/msg00331.txt.bz2

Because I do the changes at home for my hobby , I will probably send
this patch to red-hat aproval system this week-end. So for your
question, Actually, the cygwin terminal have: esc  [ D for normal shift
et ctrl, esc esc  [ D for alt. I can change this to the xterm
conformences. If you have a spec for this no problems. If you think that
my patch has no interrest a priori let me know.=20

Thank you for your suggestions.


Daniel


-----Message d'origine-----
De : Corinna Vinschen [mailto:cygwin-patches@cygwin.com]
Envoye : mardi 11 mars 2003 09:57
A : COTTO Daniel FTRD/DMI/CAE
Cc : cygwin-patches@cygwin.com
Objet : Re: A patch for the cygwin1.dll console handler


On Tue, Mar 11, 2003 at 08:02:58AM +0100, COTTO Daniel FTRD/DMI/CAE
wrote:
> Hello,
>=20
> I have made a patch to the cygwin1.dll .
> Its main purpose is to allow a nul character to be input from a french
keyboard. Also this patch adds some othre functions keys. If you are
interrested you have the diff -up file from the last cvs 03/03/2003
05:00  fhandler_console.cc
>=20
> the binding added are:
> * ctrl-spc: nul character
> * ctrl-f1 through ctrl-f10: \e7~ through \e16~
> * alt-f1 through alt f10: \e[38~ through \e[47~
> * app key binded to: \e[50~
> * ctrl-tab and alt tab bind to esc tab.=20
> * and some other minor binding; (see the attachment).
>=20
> If you want, you can use this patch and you can add it to a next
version of cygwin1.dll.

That's not how it works unfortunately.  The size of the patch is too big
to go through as insignificant.=20

Have another look on http://cygwin.com/contrib.html, please.  You'll
have to sign an assignment form and send it to Red Hat.  As soon as
the assignment form arrived, we can review and eventually incorporate
your patch.  However, you should als add a ChangeLog entry as described
on that page.

A question:  How much sense does it make to change the key bindings
of the cursor block so that Normal/Shift and Ctrl/Alt return the same
code?  Looking into the keycodes returned by an xterm, it returns
for instance on VK_LEFT:

  Normal:  ESC [ D
  Shift:   ESC [ 2 D
  Ctrl:    ESC [ 5 D
  Alt:     ESC ESC [ D

4 different key codes.  Wouldn't it make sense to do the same here?

Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
