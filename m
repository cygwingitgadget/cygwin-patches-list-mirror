Return-Path: <cygwin-patches-return-3786-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21806 invoked by alias); 3 Apr 2003 08:19:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21719 invoked from network); 3 Apr 2003 08:19:17 -0000
Date: Thu, 03 Apr 2003 08:19:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin_internal(CW_CHECK_NTSEC, filename) patch
Message-ID: <20030403081916.GI18138@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030402183304.GD3147@redhat.com> <20030402131626.GA1888@tishler.net> <20030402154258.GA2614@redhat.com> <20030402182213.GA3064@tishler.net> <20030402183304.GD3147@redhat.com> <3.0.5.32.20030402232929.007fd540@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030402232929.007fd540@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00013.txt.bz2

On Wed, Apr 02, 2003 at 11:29:29PM -0500, Pierre A. Humblet wrote:
> this might return true on Win9X if a user has defined
> CYGWIN=ntsec and checks a file mounted on an NT class machine.
> You need to add && wincap.has_security().
> 
> Also, it's sometimes useful to know the value of allow_ntsec alone.
> Could you return that, e.g. if filename is NULL?

I've checked in a patch.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
