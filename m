Return-Path: <cygwin-patches-return-4212-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8818 invoked by alias); 13 Sep 2003 17:17:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8808 invoked from network); 13 Sep 2003 17:17:48 -0000
Date: Sat, 13 Sep 2003 17:17:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fixing a security hole in pinfo.
Message-ID: <20030913171746.GA21878@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030911000542.00818340@incoming.verizon.net> <20030911041545.GA27495@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911041545.GA27495@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00228.txt.bz2

On Thu, Sep 11, 2003 at 12:15:45AM -0400, Christopher Faylor wrote:
>On Thu, Sep 11, 2003 at 12:05:42AM -0400, Pierre A. Humblet wrote:
>>2003-09-11  Pierre Humblet <pierre.humblet@ieee.org>
>>
>>        * include/sys/cygwin.h: Rename PID_UNUSED to PID_MAP_RW.
>>        * pinfo.cc (pinfo_init): Initialize myself->gid.
>>        (pinfo::init): Create the "access" variable, set it appropriately
>>        and use it to specify the requested access.
>>        * exceptions.cc (sig_handle_tty_stop): Add PID_MAP_RW in pinfo parent.
>>        * signal.cc (kill_worker): Ditto for pinfo dest.
>>        * syscalls.cc (setpgid): Ditto for pinfo p.
>
>I'm going to hold off on checking this in until 1.5.4 is released.
>Otherwise, it looks ok.

Checked in.

Thanks.

cgf
