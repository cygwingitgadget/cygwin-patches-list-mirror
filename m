Return-Path: <cygwin-patches-return-3602-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8068 invoked by alias); 20 Feb 2003 10:16:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8047 invoked from network); 20 Feb 2003 10:16:08 -0000
Date: Thu, 20 Feb 2003 10:16:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030220101606.GA2467@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030218165804.GB7145@redhat.com> <20030218221239.U46120-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218221239.U46120-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00251.txt.bz2

On Tue, Feb 18, 2003 at 10:51:31PM +0100, Vaclav Haisman wrote:
> 2003-02-17 Vaclav Haisman <V.Haisman@sh.cvut.cz>
> 
> 	* include/winioctl.h (FSCTL_SET_SPARSE): Define.
> 
> 2003-02-18  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
> 
> 	* wincap.h (wincaps::supports_sparse_files): New flag.
> 	(wincapc::supports_sparse_files): New method.
> 	* wincap.cc (wincap_unknown): Define value for the new flag.
> 	(wincap_95): Ditto.
> 	(wincap_95osr2): Ditto.
> 	(wincap_98): Ditto.
> 	(wincap_98se): Ditto.
> 	(wincap_me): Ditto.
> 	(wincap_nt3): Ditto.
> 	(wincap_nt4): Ditto.
> 	(wincap_nt4sp4): Ditto.
> 	(wincap_2000): Ditto.
> 	(wincap_xp): Ditto.
> 	* path.h (path_conv::fs_flags): New method.
> 	* fhandler_disk_file.cc: Include winioctl.h for DeviceIoControl.
> 	(fhandler_disk_file::open): Set newly created and truncated files as
> 	sparse on platforms that support it.

I've applied that patch now.  If anybody still has problems with it,
please feel free to post a *testcase* which shows the problem.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
