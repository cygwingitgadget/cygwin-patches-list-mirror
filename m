Return-Path: <cygwin-patches-return-2527-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18137 invoked by alias); 27 Jun 2002 15:21:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18122 invoked from network); 27 Jun 2002 15:21:27 -0000
Date: Thu, 27 Jun 2002 09:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: A minor patch to Makefile.in
Message-ID: <20020627152129.GA6961@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D19F55E.3070800@netscape.net> <3D19F812.70509@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D19F812.70509@netscape.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00510.txt.bz2

On Wed, Jun 26, 2002 at 01:21:22PM -0400, Nicholas Wourms wrote:
>Ok,
>
>A correction:
>"Due to the dependancy of gettext(libintl) and gettext, this pach..."
>
>This should read:
>"Due to the dependancy of gettext(libintl) on libiconv, this patch..."
>
>Also, Netscape is stripping tabs, so I have attached the Changelog this 
>time with the hope it won't be stripped.

Sorry, but this patch isn't acceptable.  If we are going to accommodate
libiconv then there needs to be a configure test for it.

cgf
