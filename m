Return-Path: <cygwin-patches-return-1683-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31688 invoked by alias); 12 Jan 2002 19:58:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31674 invoked from network); 12 Jan 2002 19:58:51 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D29EC@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Earnie Boyd' <Cygwin-Patches@Cygwin.Com>
Subject: RE: [PATCH] mkpasswd.c - Central error reporting
Date: Sat, 12 Jan 2002 11:58:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2002-q1/txt/msg00040.txt.bz2

Thanks Earnie.  I'm still learning the Tao of Changelog.  Apparently thin is
in.

Mark

> -----Original Message-----
> From: Earnie Boyd [mailto:earnie_boyd@yahoo.com] 
> Sent: Saturday, January 12, 2002 2:09 PM
> To: Mark Bradshaw
> Cc: 'cygwin-patches@cygwin.com'
> Subject: Re: [PATCH] mkpasswd.c - Central error reporting
> 
> 
> Mark Bradshaw wrote:
> > 
> > My changelog is being evil.
> > 
> > 2002-01-12  Mark Bradshaw  <bradshaw@crosswalk.com>
> > 
> >         * mkpasswd.c (print_win_error): Add a new function, 
> print_win_error,
> >                 that will attempt to get a text message to 
> go along with any
> >                 error code that is passed to it.
> >         (enum_users): Replace any lines that did error 
> reporting with calls
> >                 to the new function, print_win_error.
> >         (enum_local_groups): Replace any lines that did 
> error reporting with
> >                 calls to the new function, print_win_error.
> >         (main): Replace SOME lines that did error reporting 
> with calls
> >                 to the new function, print_win_error.
> > 
> 
> That should read:
> 
> 2002-01-12  Mark Bradshaw  <bradshaw@crosswalk.com>
> 
>         * mkpasswd.c (print_win_error): Add a new function.
>         (enum_users): Use print_win_error.
>         (enum_local_groups): Ditto.
>         (main): Ditto.
> 
> 
> Earnie.
> 
> _________________________________________________________
> Do You Yahoo!?
> Get your free @yahoo.com address at http://mail.yahoo.com
> 
