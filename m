Return-Path: <cygwin-patches-return-3643-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1252 invoked by alias); 28 Feb 2003 04:36:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1243 invoked from network); 28 Feb 2003 04:36:23 -0000
Date: Fri, 28 Feb 2003 04:36:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: access () and path.cc
Message-ID: <20030228043623.GC23158@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030227230453.007d3a60@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030227230453.007d3a60@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00292.txt.bz2

Pierre,
You and Corinna are giving me a headache.  :-)

The code on my branch changes all of the device handling.  The stat
stuff is different, too.  The changes that Corinna just made were very
tough to integrate.  Your changes will be too.  In fact, I think everything
you did will probably not be applicable to my branch.  It doesn't seem
like it will be worth the effort given that I expect to merge my changes
into the trunk for 1.3.22.  If there is no other way to do this, then
I'll just hand tweak the stuff on my branch but if there is a stopgap
measure that could be used, I would appreciate it if we could explore
that.

For instance, wouldn't all this be alleviated just by using
cfg->get_name() rather than cfg->get_win32_name in the stat functions?

cgf

On Thu, Feb 27, 2003 at 11:04:53PM -0500, Pierre A. Humblet wrote:
>The patch below needs careful review & probably work as I
>don't know path.cc very well and you may have other ideas.
