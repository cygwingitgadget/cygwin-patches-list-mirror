Return-Path: <cygwin-patches-return-1750-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18406 invoked by alias); 18 Jan 2002 23:46:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18380 invoked from network); 18 Jan 2002 23:46:57 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A82@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: roken strptime addition to cygwin
Date: Fri, 18 Jan 2002 15:46:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2002-q1/txt/msg00107.txt.bz2

Sure.  Next week...

> -----Original Message-----
> From: Corinna Vinschen [mailto:cygwin-patches@cygwin.com]
> Sent: Friday, January 18, 2002 6:43 PM
> To: 'cygwin-patches@cygwin.com'
> Subject: Re: roken strptime addition to cygwin
> 
> 
> On Fri, Jan 18, 2002 at 08:17:44AM -0500, Mark Bradshaw wrote:
> > BTW, the last was CC'd to the newlib-patches group without 
> being subscribed,
> > and I got a bounce.  I didn't see a signup for it on the 
> newlib site, so I
> > just hoped that it would allow emails in without a 
> subscription.  Guess not.
> > Could someone with appropriate uber powers please check that one in.
> 
> While the newlib change is alredy checked in I have a question
> to the function itself.
> 
> Wouldn't it make more sense to apply that function to newlib
> itself?
> 
> What bugs me is that the newlib/libc/time/strftime.c source
> already defines the needed static arrays with day names and
> month names.  It looks to me as if it would be useful to
> put strptime() into that strftime.c file since otherwise
> we're ending up with these arrays twice.  The next advantage
> would be that not only Cygwin has an advantage of that but
> all newlib targets.
> 
> So I would like to suggest that you move the function implementaton
> into newlib/libc/time/strftime.c, Mark.  The extern declaration in
> libc/include/time.h could be moved out of the `#ifdef __CYGWIN__'
> brackets and the cygwin.din patch would stay as it is.
> 
> Is that ok?
> 
> Corinna
> 
> -- 
> Corinna Vinschen                  Please, send mails 
> regarding Cygwin to
> Cygwin Developer                                
> mailto:cygwin@cygwin.com
> Red Hat, Inc.
> 
