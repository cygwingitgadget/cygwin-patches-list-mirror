Return-Path: <cygwin-patches-return-3598-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32376 invoked by alias); 19 Feb 2003 19:41:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32345 invoked from network); 19 Feb 2003 19:41:38 -0000
Date: Wed, 19 Feb 2003 19:41:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030219194135.GE29232@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000701c2d7b3$fbed0e90$78d96f83@pomello> <20030219021346.P54058-100000@logout.sh.cvut.cz> <20030219012118.GC5253@redhat.com> <3E53A525.9080405@hekimian.com> <20030219175738.GA3544@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219175738.GA3544@redhat.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00247.txt.bz2

On Wed, Feb 19, 2003 at 12:57:38PM -0500, Christopher Faylor wrote:
> On Wed, Feb 19, 2003 at 10:39:17AM -0500, Joe Buehler wrote:
> >One thing to investigate would be what happens when Windows trys to mmap()
> >a sparse file.  It doesn't bother a UNIX box, but Windows?  Perhaps that
> >is what BitTorrent is presently doing?
> 
> Hmm.  Good point.  Does some brave soul want to apply the patch and do some
> experimenting?

I'm going to test that *shiver*.

Just a hint:  Since we're calling GetVolumeInformation in path.cc
anyway, it could make sense to remember the sparseness of the FS
at that point.  So fhandler_disk_file::open() could use that result
when thinking about calling that new DeviceIoControl() call.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
