Return-Path: <cygwin-patches-return-3407-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32271 invoked by alias); 15 Jan 2003 20:28:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32210 invoked from network); 15 Jan 2003 20:28:15 -0000
Message-ID: <00fc01c2bcd4$bc52d930$305886d9@webdev>
From: "Elfyn McBratney" <elfyn-cygwin@exposure.org.uk>
To: <cygwin-patches@cygwin.com>
Subject: Re: Where to put my basename() and dirname() implementation...
Date: Wed, 15 Jan 2003 20:28:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00056.txt.bz2

Sorry I'm still at work and my source is at home so as soon as I get home I
will send off this magical patch.

While on the topic of copyright assignment would this be required? The patch
adds about 40-50 lines...

Elfyn
elfyn@exposure.org.uk

----- Original Message -----
From: "Charles Wilson" <cwilson@ece.gatech.edu>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, January 15, 2003 8:21 PM
Subject: Re: Where to put my basename() and dirname() implementation...


> Christopher Faylor wrote:
>
> >
> > I don't want to add any more libiberty routines to cygwin since the
> > licensing is suspect.  So, please follow the normal submission rules.
> > Probably miscfuncs.cc is the place to add this.
> >
>
> That make sense.  Unlike many of the other functions in libiberty, The
> basename() function itself in libiberty/basename.c is public domain --
> which may be good for our purposes, or it may be bad (I dunno, and cgf
> has already made the call: it's "suspect". Fair enough.)  In any case,
> it does no harm to have "our" own version that can be copyright-assigned
> to Red Hat and distributed under the Cygwin license.
>
> --Chuck
>
>
>


