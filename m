Return-Path: <cygwin-patches-return-4171-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21758 invoked by alias); 6 Sep 2003 02:18:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21746 invoked from network); 6 Sep 2003 02:18:36 -0000
Date: Sat, 06 Sep 2003 02:18:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: nanosleep patch 1
Message-ID: <20030906021835.GA5109@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030904214017.0081d6d0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030904214017.0081d6d0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00187.txt.bz2

On Thu, Sep 04, 2003 at 09:40:17PM -0400, Pierre A. Humblet wrote:
>This is part 1 of the patch I sent yesterday.
>See previous mails for background  info.
>Here are some more details:
>
>hires_ms::minperiod    Make NO_COPY for per process initialization.
>hires_ms::resolution   For use in sleep and alarm
>hires_ms::dmsecs       Ditto
>_DELAY_MAX             Ditto
>hires_ms::~hires_ms    Delete, rely on Windows end of process cleanup.
>                       Note that previous version could call timeEndPeriod
>                       even when timeBeginPeriod had not been called.

I guess I'm not making my point very clearly.  Here's an example of what
I'd like to see.

"I've deleted the destructor for hires_ms because all of the uses of it
are static so the appropriate cleanup will be handled automatically
anyway.  In fact, since the destructor is always invoked regardless of
whether the static variable has been used, it would end up uselessly
calling timeEndPeriod."

Descriptions like this make the reason for the change obvious.  Merely
stating that something is basically a challenge to go try to recreate
your thought process.  Scratching my head over "I wonder why he thinks
that" is what causes patch acceptance to be delayed.

Anyway, since I now understand the reason for the above mentioned
change, I've checked it in.  Now on to the rest of your patch...

cgf
