Return-Path: <cygwin-patches-return-4071-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3637 invoked by alias); 12 Aug 2003 14:47:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3627 invoked from network); 12 Aug 2003 14:47:32 -0000
Date: Tue, 12 Aug 2003 14:47:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: setmetamode
Message-ID: <20030812144731.GB3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <s1sznjdk5sg.fsf@jaist.ac.jp> <20030718171054.GC1621@cygbert.vinschen.de> <s1sk7a3jxgm.fsf@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s1sk7a3jxgm.fsf@jaist.ac.jp>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00087.txt.bz2

On Mon, Jul 28, 2003 at 09:39:53AM +0900, Kazuhiro Fujieda wrote:
> >>> On Fri, 18 Jul 2003 19:10:54 +0200
> >>> Corinna Vinschen <cygwin-patches@cygwin.com> said:
> Umm. I can't find any reason why it doesn't work.
> I'd like to confirm whether setmetamode can show and change the
> meta mode in your environment.
> 
> Could you show me the output of the following instructions:
> $ setmetamode
> <output>
> $ setmetamode meta
> $ setmetamode
> <output>

    $ setmetamode
    escprefix
    [~]$ cat | od -t x1

    0000000 1b 78 1b 78 1b 78 0d 0a
    0000010
    $ setmetamode meta
    $ setmetamode
    metabit
    $ cat | od -t x1

    0000000 1b 78 1b 78 1b 78 0d 0a
    0000010

> > Another question: Shouldn't this also add a sys/kd.h file which just
> > includes <cygwin/kd.h>?
> 
> Probably yes. I'm not, however, sure why it is necessary.
> To stick to the way of Linux?

Yes.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
