Return-Path: <cygwin-patches-return-4857-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13931 invoked by alias); 17 Jul 2004 22:51:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13921 invoked from network); 17 Jul 2004 22:51:43 -0000
Date: Sat, 17 Jul 2004 22:51:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC] Reference counting on Audio objects for /dev/dsp
Message-ID: <20040717225125.GB2450@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C46C45.1B9CA350.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C46C45.1B9CA350.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00009.txt.bz2

On Sat, Jul 17, 2004 at 09:29:13PM +0200, Gerd Spalink wrote:
>The current proposal will not work if someone first dups the device descriptor,
>and then changes the audio settings with ioctl calls using one of the two
>device descriptors. The other one will keep the old settings.
>
>The patch I am preparing will fix this. However, I also have problems to build
>the cygwin DLL. I'll try to do it tonight.

So, just to be a broken record, you could use archetypes.  That's what they were
designed for.

cgf
