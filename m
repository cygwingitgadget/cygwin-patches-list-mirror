Return-Path: <cygwin-patches-return-2010-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10773 invoked by alias); 27 Mar 2002 01:35:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10740 invoked from network); 27 Mar 2002 01:35:17 -0000
Date: Wed, 27 Mar 2002 06:03:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: Defining _POSIX_SEMAPHORES for cygwin
In-reply-to:
 <FC169E059D1A0442A04C40F86D9BA76008ABBD@itdomain003.itdomain.net.au>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Robert Collins <robert.collins@itdomain.com.au>,
 Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20020327014033.GA2088@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.24i
References: <FC169E059D1A0442A04C40F86D9BA76008ABBD@itdomain003.itdomain.net.au>
X-SW-Source: 2002-q1/txt/msg00367.txt.bz2

Rob,

On Wed, Mar 27, 2002 at 08:23:08AM +1100, Robert Collins wrote:
> > -----Original Message-----
> > From: Jason Tishler [mailto:jason@tishler.net] 
> > Sent: Wednesday, March 27, 2002 3:07 AM
> 
> > I have tried the attached patch and threaded Cygwin Python 
> > builds with semaphore support instead of conditional 
> > variables.  Is the consensus that this patch should be 
> > submitted to the newlib list?
> 
> Does it pass the test it kept crashing on?

Yes.  If it didn't, then I wouldn't be pursuing this tack.  BTW,
with Jerry's Python patch and this one, I have been able to run the
threaded regression tests for approximately 24 hours without hanging.
So, I think that this one is finally licked!

Jason
