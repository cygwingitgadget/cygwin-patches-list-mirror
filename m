Return-Path: <cygwin-patches-return-4833-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32453 invoked by alias); 8 Jun 2004 10:54:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32153 invoked from network); 8 Jun 2004 10:54:13 -0000
Date: Tue, 08 Jun 2004 10:54:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: make IPC_INFO visible to ipc system utilities only
Message-ID: <20040608105414.GB17957@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40C5871E.9010801@msgid.corpit.ru> <20040608100117.GA17957@cygbert.vinschen.de> <40C59105.1000202@msgid.corpit.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C59105.1000202@msgid.corpit.ru>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00185.txt.bz2

On Jun  8 14:12, Egor Duda wrote:
> Corinna Vinschen wrote:
> >  as long as we can't get semctl(IPC_INFO) results right anyway.
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  What is the author trying to tell me here?!?
> 
> I was unclear here, probably. I meant that "userspace application", i.e. 
> application which includes sys/sem.h but don't define _KERNEL, may call 
> semctl(IPC_INFO), but result of this call will have no meaning for 
> application since it can't interpret it.
> 
> So by "we" in underscored sentence i meant "userspace", non-system ipc 
> application.

Ok, applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
