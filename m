Return-Path: <cygwin-patches-return-2925-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4196 invoked by alias); 3 Sep 2002 15:19:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4141 invoked from network); 3 Sep 2002 15:19:39 -0000
Date: Tue, 03 Sep 2002 08:19:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
Message-ID: <20020903171937.F12899@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020830142028.F5475@cygbert.vinschen.de> <97179922214.20020830163339@logos-m.ru> <20020830150147.G5475@cygbert.vinschen.de> <110182341242.20020830171358@logos-m.ru> <s1selceuumv.fsf@jaist.ac.jp> <3D720D1F.37080487@yahoo.com> <s1sbs7hvijp.fsf@jaist.ac.jp> <20020903142809.B12899@cygbert.vinschen.de> <3D74BD4A.80403@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D74BD4A.80403@netscape.net>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00373.txt.bz2

On Tue, Sep 03, 2002 at 09:46:50AM -0400, Nicholas Wourms wrote:
> I'd like to voice a small objection to this practice of adding and then 
> removing symbols, especially given the quantity in this case and the 
> period of time which lapsed inbetween.  I don't think this practice 
> should be encouraged at all because it can be quite a PITA if you have 
> apps which were compiled when the symbols were exported.  I think this 
> goes double for "cosmetic" issues which are going to be fixed anyhow in 
> the near future.  I'm trying to help Conrad test the cygserver, so I 
> have many apps I'm using for testing purposes.  I am now going to have 
> to recompile the ones I just compiled the other day due to this change. 

That's the reason I copy only the new built DLL to my "Cygwin test and
native build system", and *not* the libcygwin.a.  This way, I link always
against the symbols available in the latest stable release and not
against symbols only available in the developers snapshot (except I
really, really want it).

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
