Return-Path: <cygwin-patches-return-4275-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15409 invoked by alias); 30 Sep 2003 16:39:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15399 invoked from network); 30 Sep 2003 16:39:32 -0000
Date: Tue, 30 Sep 2003 16:39:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: setmetamode
Message-ID: <20030930163931.GA19277@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <s1sznjdk5sg.fsf@jaist.ac.jp> <20030718171054.GC1621@cygbert.vinschen.de> <s1sk7a3jxgm.fsf@jaist.ac.jp> <20030812144731.GB3101@cygbert.vinschen.de> <20030927030734.GA18280@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030927030734.GA18280@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00291.txt.bz2

On Fri, Sep 26, 2003 at 11:07:34PM -0400, Christopher Faylor wrote:
> On Tue, Aug 12, 2003 at 04:47:31PM +0200, Corinna Vinschen wrote:
> >On Mon, Jul 28, 2003 at 09:39:53AM +0900, Kazuhiro Fujieda wrote:
> >> >>> On Fri, 18 Jul 2003 19:10:54 +0200
> >> >>> Corinna Vinschen <cygwin-patches@cygwin.com> said:
> >> Umm. I can't find any reason why it doesn't work.
> >> I'd like to confirm whether setmetamode can show and change the
> >> meta mode in your environment.
> >> 
> >> Could you show me the output of the following instructions:
> >> $ setmetamode
> >> <output>
> >> $ setmetamode meta
> >> $ setmetamode
> >> <output>
> >
> >    $ setmetamode
> >    escprefix
> >    [~]$ cat | od -t x1
> >
> >    0000000 1b 78 1b 78 1b 78 0d 0a
> >    0000010
> >    $ setmetamode meta
> >    $ setmetamode
> >    metabit
> >    $ cat | od -t x1
> >
> >    0000000 1b 78 1b 78 1b 78 0d 0a
> >    0000010
> >
> >> > Another question: Shouldn't this also add a sys/kd.h file which just
> >> > includes <cygwin/kd.h>?
> >> 
> >> Probably yes. I'm not, however, sure why it is necessary.
> >> To stick to the way of Linux?
> >
> >Yes.
> 
> Whatever happened to this patch?  Did we figure out why it didn't work
> for Corinna?

I was waiting for Kazuhiro to either provide a new patch or to kick me
to debug something specifically.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
