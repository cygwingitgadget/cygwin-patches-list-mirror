Return-Path: <cygwin-patches-return-4174-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23737 invoked by alias); 7 Sep 2003 05:18:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23727 invoked from network); 7 Sep 2003 05:18:32 -0000
Date: Sun, 07 Sep 2003 05:18:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: nanosleep patch 1
Message-ID: <20030907051832.GA23916@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030904214017.0081d6d0@incoming.verizon.net> <20030906021835.GA5109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030906021835.GA5109@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00190.txt.bz2

On Fri, Sep 05, 2003 at 10:18:35PM -0400, Christopher Faylor wrote:
>Anyway, since I now understand the reason for the above mentioned
>change, I've checked it in.  Now on to the rest of your patch...

I've checked this in with some minor modifications.  Namely, I changed
the name of _DELAY_MAX to HIRES_DELAY_MAX and had prime return minperiod
in the hires_ms class to simplify the code in resolution slightly.  I
also tweaked the ChangeLog.

Thanks.
cgf
