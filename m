Return-Path: <cygwin-patches-return-4240-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3086 invoked by alias); 26 Sep 2003 02:24:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2905 invoked from network); 26 Sep 2003 02:24:02 -0000
Date: Fri, 26 Sep 2003 02:24:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: {Patch]: Giving access to pinfo after seteuid and exec
Message-ID: <20030926022357.GA31116@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030925214748.0081f330@incoming.verizon.net> <20030926021722.GA30575@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030926021722.GA30575@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00256.txt.bz2

On Thu, Sep 25, 2003 at 10:17:22PM -0400, Christopher Faylor wrote:
>I'll check in the rest of the spawn.cc stuff with some modifications.  I see
>I missed some cases with the addition of _P_SYSTEM.

I'm sorry.  Long day.  I'm checking in the non-acl related stuff.  I'll leave
the rest for Corinna's review.

cgf
