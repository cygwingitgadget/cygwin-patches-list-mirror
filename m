Return-Path: <cygwin-patches-return-4066-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16840 invoked by alias); 10 Aug 2003 00:45:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16831 invoked from network); 10 Aug 2003 00:45:45 -0000
Date: Sun, 10 Aug 2003 00:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
Message-ID: <20030810004545.GA13746@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu> <20030809161211.GB9514@redhat.com> <1060465841.1475.34.camel@localhost> <20030810001228.GB13380@redhat.com> <1060475027.12270.49.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060475027.12270.49.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00082.txt.bz2

On Sun, Aug 10, 2003 at 10:23:47AM +1000, Robert Collins wrote:
>On Sun, 2003-08-10 at 10:12, Christopher Faylor wrote:
>>I don't see how that will ever be possible given the windows problems
>>with stdio and GUI apps.  I guess we could make setup a console utility
>>but that would result in the ugly black console box flashing up
>>whenever you start setup.exe.
>
>I was thinking of something like 'cygsetup' a console only version.
>cygcheck could then call that for the setup-related stuff it does now,
>and these extra features.

That would work.  I do have my recently renamed "cygupdate" package in
the cygwin-apps repository which uses the upset packages to read
setup.ini.  It is basically written in perl and does some command-line
installation things.

I've been tweaking this over time and it is starting to come together
fairly nicely.  The only problem is that, since it is written in perl,
it won't be able to easily use any setup C++ library stuff.  I've been
using it for quick testing of new packages and it is nice to have a
command line setup program where you can capture the output in a file.

cgf
