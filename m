Return-Path: <cygwin-patches-return-4458-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16291 invoked by alias); 1 Dec 2003 10:28:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16282 invoked from network); 1 Dec 2003 10:28:08 -0000
Date: Mon, 01 Dec 2003 10:28:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] localtime.cc: Point TZDIR to the /usr/share/zoneinfo
Message-ID: <20031201102807.GB27760@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87ad6cgb3m.fsf@vzell-de.de.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ad6cgb3m.fsf@vzell-de.de.oracle.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00177.txt.bz2

On Mon, Dec 01, 2003 at 10:07:25AM +0100, Dr. Volker Zell wrote:
> Hi
> 
> As discussed in cygwin-apps here's a small patch to point cygwin to an existing
> time zone datasbase when the tzcode/data package is installed.

Should we do some extra stuff to maintain backward compatibility with
the old /usr/local/etc path?  I don't think so but...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
