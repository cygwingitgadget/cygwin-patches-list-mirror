Return-Path: <cygwin-patches-return-3563-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5288 invoked by alias); 13 Feb 2003 23:22:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5279 invoked from network); 13 Feb 2003 23:22:20 -0000
Date: Thu, 13 Feb 2003 23:22:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Produce beeps using soundcard
Message-ID: <20030213232335.GB31877@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030213012822.A20310-100000@logout.sh.cvut.cz> <20030213203228.GF32279@redhat.com> <021f01c2d39f$fcd78a00$78d96f83@pomello> <20030213204600.GH32279@redhat.com> <028d01c2d3af$d592f230$78d96f83@pomello>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028d01c2d3af$d592f230$78d96f83@pomello>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00212.txt.bz2

On Thu, Feb 13, 2003 at 10:32:47PM -0000, Max Bowsher wrote:
>> I don't like to introduce lots of unnecessary decision points into a
>> product.  It increases support and it increases code complexity.
>
>Complexity? Slightly, but only at CYGWIN-parsing time, and Beeping time.
>That's not that much, surely?

This is a cumulative thing.  Every "it's only a couple of lines" adds
up.  It's a couple lines of code, a couple of extra lines in
documentation, a couple of extra email messages with people struggling
to use it.

I don't mind adding the lines when we are moving closer to UNIX
compatibility but I will always push back on adding arbitrary options to
the CYGWIN environment variable.  I'm in good company.  My predecessor
did the same thing.

>>Once again, how does linux handle this scenario?  You don't do a
>>"export LINUX=linbeep" to get linux to use the soundcard.
>
>If Vaclav is correct - that it required a kernel module - I think this
>question is answered.

Ok.  How about if I say "I don't think it requires a kernel module".
Does that put things back on course?

cgf
