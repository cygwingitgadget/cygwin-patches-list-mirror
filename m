Return-Path: <cygwin-patches-return-4888-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32186 invoked by alias); 4 Aug 2004 02:20:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32176 invoked from network); 4 Aug 2004 02:20:05 -0000
Date: Wed, 04 Aug 2004 02:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] mapping root directory to SystemDrive / CurrentDrive
Message-ID: <20040804022029.GA13189@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200408021452.34000.gernot.hillier@siemens.com> <3.0.5.32.20040803202352.0080e320@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040803202352.0080e320@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00040.txt.bz2

On Tue, Aug 03, 2004 at 08:23:52PM -0400, Pierre A. Humblet wrote:
>Here is a patch.

Thanks much but unless you are really really sure that this patch will
introduce no regressions, I'd like to hold off applying this patch until
after 1.5.11.

cgf

>2004-08-04  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* cygheap.h (cwdstuff::drive_length): New member.
>	(cwdstuff::get_drive): New method.
>	* path.cc (normalize_win32_path): Simplify by using cwdstuff::get_drive.
>	(mount_info::conv_to_win32_path): Use cwdstuff::get_drive as default for /.
>	(cwdstuff::set): Initialize drive_length.
