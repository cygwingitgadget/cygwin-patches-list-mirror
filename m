Return-Path: <cygwin-patches-return-4320-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 561 invoked by alias); 29 Oct 2003 01:15:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 545 invoked from network); 29 Oct 2003 01:15:10 -0000
Date: Wed, 29 Oct 2003 01:15:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow filenames ending with a "." in managed mode
Message-ID: <20031029011510.GA6702@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0310281935190.9558@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0310281935190.9558@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00039.txt.bz2

On Tue, Oct 28, 2003 at 07:44:18PM -0500, Igor Pechtchanski wrote:
>The attached patch allows creating and working with files ending in "."
>(or multiple "."s) in managed mode.
>ChangeLog:
>2003-10-28  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
>
>	* path.cc (dot_special_chars): New global variable.
>	(special_name): Make files ending in "." special.
>	(fnunmunge): Allow encoded ".".
>	(mount_item::fnmunge): Handle trailing ".".

Applied.

Thanks.
cgf
