Return-Path: <cygwin-patches-return-3398-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1406 invoked by alias); 15 Jan 2003 18:03:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1224 invoked from network); 15 Jan 2003 18:03:32 -0000
Message-ID: <009201c2bcc0$82411040$305886d9@webdev>
From: "Elfyn McBratney" <elfyn-cygwin@exposure.org.uk>
To: <cygwin-patches@cygwin.com>
References: <59A835EDCDDBEB46BC75402F4604D5528F75D6@elmer>
Subject: Re: Where to put my basename() and dirname() implementation...
Date: Wed, 15 Jan 2003 18:03:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00047.txt.bz2

Doooh! Thanks for the heads up Sergey. It kinda seems pointless just adding
a dirname() function but what the hell... Any inkling where i should put
this lone sub?

Elfyn
elfyn@exposure.org.uk

----- Original Message -----
From: "Sergey Okhapkin" <sos@sokhapkin.dyndns.org>
To: "'Elfyn McBratney'" <elfyn-cygwin@exposure.org.uk>;
<cygwin-patches@cygwin.com>
Sent: Wednesday, January 15, 2003 5:56 PM
Subject: RE: Where to put my basename() and dirname() implementation...


> Basename() is implemented in libiberty already, just modify cygwin.din
> :-)
>
> > -----Original Message-----
> > From: cygwin-patches-owner@cygwin.com
> > [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Elfyn McBratney
> > Sent: Wednesday, January 15, 2003 12:37 PM
> > To: cygwin-patches@cygwin.com
> > Subject: Where to put my basename() and dirname() implementation...
> >
> >
> > I have finished my basename() and dirname() (so long for
> > something so simple
> > ;-) implementation and I have two questions:
> >
> > 1) Where would be the best place to put these functions? I
> > was thinking dir.cc or path.cc?
> > 2) What header file (winsup/cygwin/include) should I put the
> > prototypes into? On my sun and redhat box they're in libgen.h
> > so should I follow this convention?
> >
> > Once I have these answered I will submit the patch here.
> >
> > Elfyn
> > elfyn@exposure.org.uk
> >
> >
> >
> >
>
>


