Return-Path: <cygwin-patches-return-4512-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13658 invoked by alias); 7 Jan 2004 21:06:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13645 invoked from network); 7 Jan 2004 21:06:14 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Wed, 07 Jan 2004 21:06:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: Re: lstat symbolic link size
In-Reply-To: <20040107181159.GC14105@redhat.com>
Message-ID: <Pine.GSO.4.58.0401071500390.23399@eos>
References: <20040106013026.21604.qmail@linuxmail.org> <20040106013824.GA6047@redhat.com>
 <20040106014410.GA6850@redhat.com> <Pine.GSO.4.58.0401071123210.23399@eos>
 <20040107181159.GC14105@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q1/txt/msg00002.txt.bz2

On Wed, 7 Jan 2004, Christopher Faylor wrote:

> On Wed, Jan 07, 2004 at 11:33:18AM -0600, Brian Ford wrote:
> >Ok, here it is.
> >
> >2004-01-07  Brian Ford  <ford@vss.fsi.com>
> >
> >	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Comply with
> >	SUSv3 for a symlink's st_size, ie. the length of the target
> >	pathname.
> >
> Thanks but that is not the correct fix.  The target pathname is not the
> windows path.
>
Ok, sorry for the noise.  I was trying to use readlink as my example and
that was what it appeared to do :).

I'll just wait until you have time to fix CVS HEAD so I can test and
debug.  Then, I'll try it again.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
