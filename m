Return-Path: <cygwin-patches-return-4255-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4635 invoked by alias); 27 Sep 2003 02:21:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4626 invoked from network); 27 Sep 2003 02:21:35 -0000
Date: Sat, 27 Sep 2003 02:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Turning pinfo security on
Message-ID: <20030927022130.GA16851@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030926221700.008209b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030926221700.008209b0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00271.txt.bz2

On Fri, Sep 26, 2003 at 10:17:00PM -0400, Pierre A. Humblet wrote:
>Following Chris' new signal handling approach and the previous
>patch "Giving access to pinfo after seteuid and exec", we can
>now turn pinfo security on.
>
>It's just a matter of removing the FILE_MAP_WRITE permission for
>Everybody, and a couple of useless PID_MAP_WRITE in pinfo constructors.
>I have left the PID_MAP_WRITE in the winpids constructors for now,
>they will be removed later.

You can check this in and just check in the winpids stuff when you get
around to that step.

Thanks,
cgf
