Return-Path: <cygwin-patches-return-4714-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31016 invoked by alias); 6 May 2004 12:37:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30990 invoked from network); 6 May 2004 12:37:21 -0000
Date: Thu, 06 May 2004 12:37:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: chdir
Message-ID: <20040506123720.GB17511@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net> <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040505004236.007ff280@incoming.verizon.net> <20040505095134.GA6206@cygbert.vinschen.de> <3.0.5.32.20040505235853.00806100@incoming.verizon.net> <20040506094334.GV2201@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506094334.GV2201@cygbert.vinschen.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00066.txt.bz2

On May  6 11:43, Corinna Vinschen wrote:
> On May  5 23:58, Pierre A. Humblet wrote:
> > 2004-05-06  Pierre Humblet <pierre.humblet@ieee.org>
> > 
> > 	* path.cc (chdir): Do not check for trailing spaces.
> > 	Do not set native_dir to c:\ for virtual devices.
> > 	Pass only native_dir to cwd.set.
> > 	(cwdstuff::set): Assume posix_cwd is already normalized.
> 
> Looks pretty good to me.  I think calling cwd.set always with a
> NULL pointer is a good idea.  The resulting posix path is guaranteed
> to be right.

Ooops:

  $ cd /
  /: No such file or directory.
  $ pwd
  /home/corinna
  $ cd ..
  $ pwd
  /home
  $ cd ..
  ..: No such file or directory.
  $

Somehow after your patch, Cygwin doesn't like its own root dir anymore.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
