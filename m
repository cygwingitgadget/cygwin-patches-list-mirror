Return-Path: <cygwin-patches-return-5002-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16247 invoked by alias); 4 Oct 2004 09:43:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16232 invoked from network); 4 Oct 2004 09:43:00 -0000
Date: Mon, 04 Oct 2004 09:43:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: ``pclose'' what was ``popen''ed.
Message-ID: <20041004094404.GB21035@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjd7tg.3vvc92r.1@buzzy-box.bavag> <n2m-g.cjfeur.3vvfapn.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cjfeur.3vvfapn.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00003.txt.bz2

On Sep 29 23:06, Bas van Gompel wrote:
> 	* cygcheck.cc (pretty_id): Close pipe.

Applied with a formatting change:
 
> +  pclose(f);

     pclose (f);


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
