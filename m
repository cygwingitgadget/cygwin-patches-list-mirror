Return-Path: <cygwin-patches-return-3539-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22421 invoked by alias); 7 Feb 2003 15:01:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22412 invoked from network); 7 Feb 2003 15:01:37 -0000
Date: Fri, 07 Feb 2003 15:01:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Make busy waiting loop in exceptions.cc (try_to_debug) less busy.
Message-ID: <20030207150230.GB5098@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030207152049.N27816-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030207152049.N27816-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00188.txt.bz2

On Fri, Feb 07, 2003 at 03:35:12PM +0100, Vaclav Haisman wrote:
>this patch makes busy waiting loop in try_to_debug less busy by lowering
>priority of current thread to idle and by giving up time slices with Sleep(0).

I'll apply something similar to this but the scenario of setting the
priority to idle and then doing a Sleep(0) doesn't do what I think you think
it does.  :-)

Unfortunately, Sleep (0) gives back time slices to any other thread running
at idle priority.  A Sleep(0) is better than nothing, though.

Thanks.
cgf

>2003-02-07  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>	* exceptions.cc (try_to_debug): Set priority of current thread to
>	idle. Make busy waiting loop less busy.
