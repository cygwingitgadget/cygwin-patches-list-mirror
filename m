Return-Path: <cygwin-patches-return-3234-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31899 invoked by alias); 25 Nov 2002 15:20:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31887 invoked from network); 25 Nov 2002 15:20:38 -0000
Date: Mon, 25 Nov 2002 07:20:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Win98/ME home directory
Message-ID: <20021125162036.M1398@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021124201818.0082b5e0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021124201818.0082b5e0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00185.txt.bz2

On Sun, Nov 24, 2002 at 08:18:18PM -0500, Pierre A. Humblet wrote:
> Also, looking at the output of mkpasswd on Win9X made me think
> it would be more secure to set the passwd field to *.

Yep, changed.

> 2002-11-24  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* passwd.cc (read_etc_passwd): Never add an entry when starting
> 	on Win95/98/ME if a default entry is present.
> 	* uinfo.cc (internal_getlogin): Look for the default uid if needed.
> 	Always call user.set_name ().

Applied. 

How I hate testing on 9x/Me.  It's pure luck when it doesn't crash on
startup.  And it's so dumb.  I've installed a german version of 98SE on
a box with US keyboard.  Changing from german to US keyboard layout
(which needs rebooting of course) worked fine but the @#^% console window
insists on still using the german layout.  Incredible!

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
