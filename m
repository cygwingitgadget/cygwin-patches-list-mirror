Return-Path: <cygwin-patches-return-1751-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27835 invoked by alias); 19 Jan 2002 03:31:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27821 invoked from network); 19 Jan 2002 03:31:56 -0000
Message-ID: <20020119033156.24856.qmail@web20003.mail.yahoo.com>
Date: Fri, 18 Jan 2002 19:31:00 -0000
From: Joshua Franklin <joshuadfranklin@yahoo.com>
Subject: Re: cygpath patch resend
To: cygwin-patches@cygwin.com
In-Reply-To: <1011320342.18424.ezmlm@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00108.txt.bz2

> > * cygpath.cc (main): Added options to show Desktop
> and Start Menu's Programs
> > directory for current user or all users
> > * cygpath.cc (main): moved bulk of DPWS options
> outside the getopt case
> > statement
> >  (since their output depends on uwA switches)
> > * utils.sgml: updated cygpath section for ADPWS
> options
> 
> The attachments look ok.  Your ChangeLog OTOH...  It
> should look like
> this:
> 
Sorry about that. I made the two changes separately
at separate times and never combined the changelog.


__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
