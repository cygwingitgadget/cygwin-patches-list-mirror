Return-Path: <cygwin-patches-return-1740-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21427 invoked by alias); 18 Jan 2002 13:21:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21403 invoked from network); 18 Jan 2002 13:21:05 -0000
Message-ID: <3C482122.C9361A2C@yahoo.com>
Date: Fri, 18 Jan 2002 05:21:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Bradshaw <bradshaw@staff.crosswalk.com>
CC: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: roken strptime addition to cygwin
References: <911C684A29ACD311921800508B7293BA037D2A6F@cnmail>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q1/txt/msg00097.txt.bz2

Uh, there isn't a newlib-patches.  Patches get sent to
newlib@sources.redhat.com.

Earnie.

Mark Bradshaw wrote:
> 
> BTW, the last was CC'd to the newlib-patches group without being subscribed,
> and I got a bounce.  I didn't see a signup for it on the newlib site, so I
> just hoped that it would allow emails in without a subscription.  Guess not.
> Could someone with appropriate uber powers please check that one in.
> 
> > -----Original Message-----
> > From: Mark Bradshaw
> > Sent: Friday, January 18, 2002 8:13 AM
> > To: 'cygwin-patches@cygwin.com'; newlib-patches@sources.redhat.com
> > Subject: roken strptime addition to cygwin
> >
> >
> > Thanks to Robert and Chuck for behind the scenes help.
> >
> > Here's the strptime addition to cygwin that's been discussed.
> >  The source
> > comes from:
> > http://ftp.uninett.no/pub/OpenBSD/src/kerberosIV/src/lib/roken
> /strptime.c
> 
> It's copyright isn't as restrictive as the BSD's, so it won't be a problem
> for inclusion.  This also includes a header change for newlib.
> 
> ====================================
> 
> Newlib:
> 2002-01-18  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
> 
>         * libc/include/time.h: Add prototype for strptime for Cygwin.
> 
> Cygwin:
> 2002-01-18  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
> 
>         * times.cc: Add strptime function, and supporting functions.
>           * cygwin.din: strptime

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

