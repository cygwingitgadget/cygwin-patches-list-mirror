Return-Path: <cygwin-patches-return-3557-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10676 invoked by alias); 13 Feb 2003 20:35:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10659 invoked from network); 13 Feb 2003 20:35:27 -0000
Date: Thu, 13 Feb 2003 20:35:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030213203642.GG32279@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030203141333.Y68413-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203141333.Y68413-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00206.txt.bz2

On Mon, Feb 03, 2003 at 02:18:03PM +0100, Vaclav Haisman wrote:
>
>This is a little bit improved version of my previous post.
>By default creation of sparse files is disabled. It can be enabled by CYGWIN
>option sparse_files.
>
>Vaclav Haisman
>
>
>2003-02-03  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>	* fhandler.h (allow_sparse): Declare new extern variable.
>	* fhandler.cc (METHOD_BUFFERED): New macro.
>	(FSCTL_SET_SPARSE): Ditto.
>	(allow_sparse): Define the new variable.
>	(fhandler_base::open): Try to set newly created or trucated files
>	as sparse on NT systems.
>	* environ.cc (parse_thing): Add new CYGWIN option.

This is YA case where I don't think that a CYGWIN environment variable option is
justified.

UNIX has a method for producing sparse files.  If this is desired functionality,
Cygwin should mimic that not invent a new way of doing things.

cgf
