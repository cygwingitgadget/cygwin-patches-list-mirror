Return-Path: <cygwin-patches-return-4691-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20934 invoked by alias); 20 Apr 2004 15:52:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20912 invoked from network); 20 Apr 2004 15:52:08 -0000
Date: Tue, 20 Apr 2004 15:52:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: chown etc
Message-ID: <20040420155207.GA30486@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040419082815.008a65a0@incoming.verizon.net> <40840802.E01356C0@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40840802.E01356C0@phumblet.no-ip.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00043.txt.bz2

On Apr 19 13:10, Pierre A. Humblet wrote:
> 2004-04-19  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* fhandler_disk_file.cc (fhandler_base::open_fs): Change set_file_attribute
> 	call to indicate that NT security isn't used.
> 	(fhandler_disk_file::fchmod): Rearrange to isolate 9x related statements.
> 	Do not set FILE_ATTRIBUTE_SYSTEM.
> 	(fhandler_disk_file::fchown): Check noop case first.
> 	* fhandler.cc (fhandler_base::open9x): Remove ntsec related statements.
> 	(fhandler_base::set_name): Do not set namehash.
> 	* fhandler.h (fhandler_base::get_namehash): Compute and set namehash if
> 	needed.
> 	* syscalls (access): Verify that fh is not NULL. Do not set PC_FULL.
> 	(chmod): Ditto.
> 	(chown_worker): Ditto.
> 	(stat_worker): Ditto. Verify if the path exists.

Applied with some formatting changes in fhandler.h and the ChangeLog.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
