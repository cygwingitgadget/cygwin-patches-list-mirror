Return-Path: <cygwin-patches-return-4940-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20336 invoked by alias); 10 Sep 2004 09:40:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20326 invoked from network); 10 Sep 2004 09:40:27 -0000
Date: Fri, 10 Sep 2004 09:40:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-ID: <20040910094110.GW17670@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040910090123.GV17670@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910090123.GV17670@cygbert.vinschen.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00092.txt.bz2

On Sep 10 11:01, Corinna Vinschen wrote:
> Due to speed considerations, Cygwin's implementation of OpenSSH uses
> pipes for local IPC instead of socketpairs.

Hmm, I just found that this can't be quite valid anymore.  Using
socketpairs is way faster, even when using Cygwin 1.5.10.  I digged
in the openssh-unix-dev ML archives and the decision to switch to
USE_PIPES has been made 3 1/2 years ago.  I'm wondering if it's
time to switch back to socketpairs...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
