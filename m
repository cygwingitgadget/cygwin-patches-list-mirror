Return-Path: <cygwin-patches-return-1748-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17277 invoked by alias); 18 Jan 2002 23:43:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17262 invoked from network); 18 Jan 2002 23:43:14 -0000
Date: Fri, 18 Jan 2002 15:43:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: roken strptime addition to cygwin
Message-ID: <20020119004311.O11608@cygbert.vinschen.de>
Mail-Followup-To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
References: <911C684A29ACD311921800508B7293BA037D2A6F@cnmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911C684A29ACD311921800508B7293BA037D2A6F@cnmail>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00105.txt.bz2

On Fri, Jan 18, 2002 at 08:17:44AM -0500, Mark Bradshaw wrote:
> BTW, the last was CC'd to the newlib-patches group without being subscribed,
> and I got a bounce.  I didn't see a signup for it on the newlib site, so I
> just hoped that it would allow emails in without a subscription.  Guess not.
> Could someone with appropriate uber powers please check that one in.

While the newlib change is alredy checked in I have a question
to the function itself.

Wouldn't it make more sense to apply that function to newlib
itself?

What bugs me is that the newlib/libc/time/strftime.c source
already defines the needed static arrays with day names and
month names.  It looks to me as if it would be useful to
put strptime() into that strftime.c file since otherwise
we're ending up with these arrays twice.  The next advantage
would be that not only Cygwin has an advantage of that but
all newlib targets.

So I would like to suggest that you move the function implementaton
into newlib/libc/time/strftime.c, Mark.  The extern declaration in
libc/include/time.h could be moved out of the `#ifdef __CYGWIN__'
brackets and the cygwin.din patch would stay as it is.

Is that ok?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
