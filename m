Return-Path: <cygwin-patches-return-4716-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1068 invoked by alias); 6 May 2004 14:06:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1041 invoked from network); 6 May 2004 14:06:55 -0000
Message-ID: <409A467B.6C65F2F5@phumblet.no-ip.org>
Date: Thu, 06 May 2004 14:06:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: chdir
References: <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net> <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040505004236.007ff280@incoming.verizon.net> <20040505095134.GA6206@cygbert.vinschen.de> <3.0.5.32.20040505235853.00806100@incoming.verizon.net> <20040506094334.GV2201@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00068.txt.bz2


Corinna Vinschen wrote:
> 
> Did you try find(1)?  Do you recall the problems we had with find years
> ago when crossing a mount point?  I tried to create a scenario but
> either it works fine or I failed to set that up correctly.  It would
> be nice if we could make sure that these cases work.  I tried some
> combinations with symlinks and they are working well, AFAICS.

Yes, I tried to set up such scenarios and didn't observe any trouble.
chdir works as it always did with check_case != relaxed or with paths starting
with a drive, so one might hope that any problem would have surfaced by now.

Pierre
