Return-Path: <cygwin-patches-return-4161-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32000 invoked by alias); 4 Sep 2003 01:05:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31991 invoked from network); 4 Sep 2003 01:05:54 -0000
Date: Thu, 04 Sep 2003 01:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch1: fix for mount -m command.
Message-ID: <20030904010554.GC28465@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030904003012.6705.qmail@web10009.mail.yahoo.com> <20030904010437.GA28465@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904010437.GA28465@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00177.txt.bz2

On Wed, Sep 03, 2003 at 09:04:37PM -0400, Christopher Faylor wrote:
>On Wed, Sep 03, 2003 at 05:30:12PM -0700, AJ Reins wrote:
>>2003-09-01  AJ Reins  <reinsaj@yahoo.com>
>>
>>	* mount.cc (mount_commands): Ensure user mode is actually
>>	user mode and not the default system mode.
>
>Applied but please, in the future, don't rename the files to something
>like mount1.cc and use the '-up' option.

Forgot to say: Thank you!

cgf
