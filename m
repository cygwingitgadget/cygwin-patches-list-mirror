Return-Path: <cygwin-patches-return-3623-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8029 invoked by alias); 25 Feb 2003 12:04:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8018 invoked from network); 25 Feb 2003 12:04:07 -0000
Date: Tue, 25 Feb 2003 12:04:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Silent some more warnings.
Message-ID: <20030225120405.GD8853@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030220230012.I26596-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220230012.I26596-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00272.txt.bz2

On Thu, Feb 20, 2003 at 11:29:32PM +0100, Vaclav Haisman wrote:
> -	ldptr = (struct ldieee *)&value;
> +	ldptr = (struct ldieee *)(void *)&value;

Actually, these look more like overreacting of the compiler.  I'm not
sure it's worth to concider to change all apps to this sort of wild
casting scheme.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
