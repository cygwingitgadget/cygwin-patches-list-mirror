Return-Path: <cygwin-patches-return-2085-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19973 invoked by alias); 19 Apr 2002 11:42:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19954 invoked from network); 19 Apr 2002 11:42:32 -0000
Date: Fri, 19 Apr 2002 04:42:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: [PATCH] minor pthread fixes
In-reply-to:
 <FC169E059D1A0442A04C40F86D9BA7600C5E75@itdomain003.itdomain.net.au>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: cygwin-patches@cygwin.com
Mail-followup-to: Robert Collins <robert.collins@itdomain.com.au>,
 cygwin-patches@cygwin.com
Message-id: <20020419114850.GD1540@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.24i
References: <FC169E059D1A0442A04C40F86D9BA7600C5E75@itdomain003.itdomain.net.au>
X-SW-Source: 2002-q2/txt/msg00069.txt.bz2

Rob,

On Fri, Apr 19, 2002 at 09:37:04PM +1000, Robert Collins wrote:
> From memory - no. Alsothe symptoms are wrong - the test hangs, not
> prematurely exiting. Anyway, it shouldn't be too hard to build a test
> .dll and give it a try. If you want I can shoot such a  beast over to
> you.

No, that's OK.  Thanks to Gerald Williams' related Python patch this
issue has been obviated.  I was just trying to finally put this Cygwin
pthreads problem to bed...

Jason
