Return-Path: <cygwin-patches-return-4775-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21372 invoked by alias); 19 May 2004 15:08:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21351 invoked from network); 19 May 2004 15:08:15 -0000
Date: Wed, 19 May 2004 15:08:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] To handle Win32 pipe names
In-Reply-To: <20040519085237.GA7011@cygbert.vinschen.de>
Message-ID: <Pine.CYG.4.58.0405190959550.2628@fordpc.vss.fsi.com>
References: <BAY9-F265VSSFcl3imp0000784b@hotmail.com>
 <20040519085237.GA7011@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q2/txt/msg00127.txt.bz2

On Wed, 19 May 2004, Corinna Vinschen wrote:

> So that explains your patch to symlink_info::check.  But it's not
> exactly right to circumvent this only for pipes.  Any \\.\foo path
> should get the same handling.  Wouldn't it be more straightforward to
> use is_unc_share or a slightly modified version of is_unc_share?

I'm confused here.  Are you suggesting that UNC paths can't contain
symlinks?  I use UNC paths to access Samba shares containing Cygwin
symlinks regularly.  I hope that won't become unsupported.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
