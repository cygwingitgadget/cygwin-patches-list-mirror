Return-Path: <cygwin-patches-return-2083-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15937 invoked by alias); 19 Apr 2002 11:32:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15922 invoked from network); 19 Apr 2002 11:32:06 -0000
Date: Fri, 19 Apr 2002 04:32:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: [PATCH] minor pthread fixes
In-reply-to:
 <FC169E059D1A0442A04C40F86D9BA7600C5E6B@itdomain003.itdomain.net.au>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: Thomas Pfaff <tpfaff@gmx.net>, cygwin-patches@cygwin.com
Mail-followup-to: Robert Collins <robert.collins@itdomain.com.au>,
 Thomas Pfaff <tpfaff@gmx.net>, cygwin-patches@cygwin.com
Message-id: <20020419113823.GB1540@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.24i
References: <FC169E059D1A0442A04C40F86D9BA7600C5E6B@itdomain003.itdomain.net.au>
X-SW-Source: 2002-q2/txt/msg00067.txt.bz2

Rob,

On Fri, Apr 19, 2002 at 08:31:52AM +1000, Robert Collins wrote:
> > -----Original Message-----
> > From: Jason Tishler [mailto:jason@tishler.net] 
> > Sent: Thursday, April 18, 2002 9:58 PM
> > 
> > Could #2 have caused the problem that we saw with Python's 
> > test_threadedtempfile regression test?
> 
> I don't think so. python isn't creating and killing very short lived
> threads is it?

Recall that test_threadedtempfile spawns many threads (IIRC, at least
26) -- maybe they are short lived?  See the following to refresh your
memory:

    http://www.cygwin.com/ml/cygwin-developers/2001-10/msg00193.html

Do you think that Tom's patch would fix this problem?

Thanks,
Jason
